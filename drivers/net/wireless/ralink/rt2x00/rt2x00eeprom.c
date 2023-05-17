/*
	Copyright (C) 2004 - 2009 Ivo van Doorn <IvDoorn@gmail.com>
	Copyright (C) 2004 - 2009 Gertjan van Wingerde <gwingerde@gmail.com>
	<http://rt2x00.serialmonkey.com>

	This program is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the
	Free Software Foundation, Inc.,
	59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

/*
	Module: rt2x00lib
	Abstract: rt2x00 eeprom file loading routines.
 */

#include <linux/kernel.h>
#include <linux/module.h>

#include "rt2x00.h"
#include "rt2x00lib.h"

static const char *
rt2x00lib_get_eeprom_file_name(struct rt2x00_dev *rt2x00dev)
{
	struct rt2x00_platform_data *pdata = rt2x00dev->dev->platform_data;

	if (pdata && pdata->eeprom_file_name)
		return pdata->eeprom_file_name;

	return NULL;
}

static int rt2x00lib_request_eeprom_file(struct rt2x00_dev *rt2x00dev)
{
	const struct firmware *ee;
	const char *ee_name;
	int retval;

	ee_name = rt2x00lib_get_eeprom_file_name(rt2x00dev);
	if (!ee_name && test_bit(REQUIRE_EEPROM_FILE, &rt2x00dev->cap_flags)) {
		rt2x00_err(rt2x00dev, "Required EEPROM name is missing.");
		return -EINVAL;
	}

	if (!ee_name)
		return 0;

	rt2x00_info(rt2x00dev, "Loading EEPROM data from '%s'.\n", ee_name);

	retval = request_firmware(&ee, ee_name, rt2x00dev->dev);
	if (retval) {
		rt2x00_err(rt2x00dev, "Failed to request EEPROM.\n");
		return retval;
	}

	if (!ee || !ee->size || !ee->data) {
		rt2x00_err(rt2x00dev, "Failed to read EEPROM file.\n");
		retval = -ENOENT;
		goto err_exit;
	}

	if (ee->size != rt2x00dev->ops->eeprom_size) {
		rt2x00_err(rt2x00dev,
			   "EEPROM file size is invalid, it should be %d bytes\n",
			   rt2x00dev->ops->eeprom_size);
		retval = -EINVAL;
		goto err_release_ee;
	}

	rt2x00dev->eeprom_file = ee;
	return 0;

err_release_ee:
	release_firmware(ee);
err_exit:
	return retval;
}

int rt2x00lib_load_eeprom_file(struct rt2x00_dev *rt2x00dev)
{
	int retval;

	retval = rt2x00lib_request_eeprom_file(rt2x00dev);
	if (retval)
		return retval;

	return 0;
}

void rt2x00lib_free_eeprom_file(struct rt2x00_dev *rt2x00dev)
{
	if (rt2x00dev->eeprom_file && rt2x00dev->eeprom_file->size)
		release_firmware(rt2x00dev->eeprom_file);
	rt2x00dev->eeprom_file = NULL;
}
