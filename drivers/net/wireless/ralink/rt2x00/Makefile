# SPDX-License-Identifier: GPL-2.0
rt2x00lib-y				+= rt2x00dev.o
rt2x00lib-y				+= rt2x00mac.o
rt2x00lib-y				+= rt2x00config.o
rt2x00lib-y				+= rt2x00queue.o
rt2x00lib-y				+= rt2x00link.o
# TODO: use conditional compilation
rt2x00lib-y				+= rt2x00thermal.o
rt2x00lib-$(CPTCFG_RT2X00_LIB_DEBUGFS)	+= rt2x00debug.o
rt2x00lib-$(CPTCFG_RT2X00_LIB_CRYPTO)	+= rt2x00crypto.o
rt2x00lib-$(CPTCFG_RT2X00_LIB_FIRMWARE)	+= rt2x00firmware.o
rt2x00lib-$(CPTCFG_RT2X00_LIB_LEDS)	+= rt2x00leds.o
rt2x00lib-$(CPTCFG_RT2X00_LIB_EEPROM)	+= rt2x00eeprom.o
# TODO: conditional compilation doesn't work atm CPTCFG_RT2X00_THERMAL is
# emitted to backports .config from OpenWRT but stripped during the compilation
# step. Not sure why.
rt2x00lib-$(CPTCFG_RT2X00_THERMAL)	+= rt2x00thermal.o

obj-$(CPTCFG_RT2X00_LIB)		+= rt2x00lib.o
obj-$(CPTCFG_RT2X00_LIB_MMIO)		+= rt2x00mmio.o
obj-$(CPTCFG_RT2X00_LIB_PCI)		+= rt2x00pci.o
obj-$(CPTCFG_RT2X00_LIB_SOC)		+= rt2x00soc.o
obj-$(CPTCFG_RT2X00_LIB_USB)		+= rt2x00usb.o
obj-$(CPTCFG_RT2800_LIB)		+= rt2800lib.o
obj-$(CPTCFG_RT2800_LIB_MMIO)		+= rt2800mmio.o
obj-$(CPTCFG_RT2400PCI)			+= rt2400pci.o
obj-$(CPTCFG_RT2500PCI)			+= rt2500pci.o
obj-$(CPTCFG_RT61PCI)			+= rt61pci.o
obj-$(CPTCFG_RT2800PCI)			+= rt2800pci.o
obj-$(CPTCFG_RT2500USB)			+= rt2500usb.o
obj-$(CPTCFG_RT73USB)			+= rt73usb.o
obj-$(CPTCFG_RT2800USB)			+= rt2800usb.o
obj-$(CPTCFG_RT2800SOC)			+= rt2800soc.o
