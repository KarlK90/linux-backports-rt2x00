#ifndef __BACKPORT_BCMA_DRIVER_CHIPCOMMON_H
#define __BACKPORT_BCMA_DRIVER_CHIPCOMMON_H

#include_next <linux/bcma/bcma_driver_chipcommon.h>

#ifndef BCMA_CC_SROM_CONTROL_OTP_PRESENT
#define BCMA_CC_SROM_CONTROL_OTP_PRESENT 0x00000020
#endif

#endif
