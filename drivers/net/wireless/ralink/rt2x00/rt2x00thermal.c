#include <linux/thermal.h>

#include "rt2x00thermal.h"

static int rt2x00_tzone_get_temp(struct thermal_zone_device *device,
				 int *temperature)
{
	int temp;
	struct rt2x00_dev *rt2x00dev = (struct rt2x00_dev *)device->devdata;

	// TODO: interacting with BBP before initializing the device hangs the chip
	if (!test_bit(DEVICE_STATE_ENABLED_RADIO, &rt2x00dev->flags)) {
		rt2x00_err(rt2x00dev, "device not started yet");
		return -ENODEV;
		// TODO: remove this check once all ops structures have a
		// read_temperature function
	} else if (rt2x00dev->ops->lib->read_temperature == NULL) {
		rt2x00_err(rt2x00dev, "no thermal state read function");
		return -ENODEV;
	}

	temp = rt2x00dev->ops->lib->read_temperature(rt2x00dev);
	if (temp < 0) {
		rt2x00_err(rt2x00dev, "failed to read current temperature");
		return -EIO;
	}

	rt2x00_info(rt2x00dev, "current temperature: %i", temp);
	*temperature = temp;

	return 0;
}

static struct thermal_zone_device_ops tzone_ops = {
	.get_temp = rt2x00_tzone_get_temp
};

int rt2x00_thermal_register(struct rt2x00_dev *dev)
{
	int i, ret;
	char name[16];
	static atomic_t counter = ATOMIC_INIT(0);
	(void)i;

	// TODO: only register for RT6352/MT7620 for now
	if (!rt2x00_rt(dev, RT6352)) {
		return 0;
	}

	BUILD_BUG_ON(ARRAY_SIZE(name) >= THERMAL_NAME_LENGTH);

	sprintf(name, "rt2x00_%u", atomic_inc_return(&counter) & 0xFF);
	dev->thermal.tzone = thermal_zone_device_register(
		name, 0, 0, dev, &tzone_ops, NULL, 0, 0);
	if (IS_ERR(dev->thermal.tzone)) {
		rt2x00_info(dev,
			    "Failed to register thermal zone (err = %ld)\n",
			    PTR_ERR(dev->thermal.tzone));
		dev->thermal.tzone = NULL;
		return -EINVAL;
	}

	ret = thermal_zone_device_enable(dev->thermal.tzone);
	if (ret) {
		rt2x00_info(dev, "Failed to enable thermal zone\n");
		thermal_zone_device_unregister(dev->thermal.tzone);
		return -EINVAL;
	}

	return ret;
}

void rt2x00_thermal_unregister(struct rt2x00_dev *dev)
{
	if (dev->thermal.tzone) {
		thermal_zone_device_unregister(dev->thermal.tzone);
	}
}
