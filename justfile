default: build-fast deploy reload

remote := "root@192.168.0.44"
export STAGING_DIR := "/home/karlk/Development/openwrt/staging_dir/target-mipsel_24kc_musl"

openwrt_dir := "~/Development/openwrt"
build_dir := "{{openwrt_dir}}/build_dir"
staging_dir := "{{openwrt_dir}}/staging_dir"

ssh_run := "ssh " + remote
copy := "rsync --compress --checksum --update --progress"
copy_scp := "scp -O"

prepare:
  # download and install rsync if it doesnt exist
  {{ssh_run}} 'wget https://downloads.openwrt.org/releases/22.03.3/packages/mipsel_24kc/packages/rsync_3.2.7-1_mipsel_24kc.ipk'
  {{ssh_run}} 'opkg update; opkg install rsync_3.2.7-1_mipsel_24kc.ipk'

build:
  # build mac80211 and rt2x00 driver
  make -C {{openwrt_dir}} package/kernel/mac80211/compile -j `nproc`

build-fast:
  make -j `nproc` -C "/home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/backports-6.1.24" KCFLAGS="-ffile-prefix-map=/home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl=target-mipsel_24kc_musl -fno-caller-saves " HOSTCFLAGS="-O2 -I/home/karlk/Development/openwrt/staging_dir/host/include -I/home/karlk/Development/openwrt/staging_dir/hostpkg/include -I/home/karlk/Development/openwrt/staging_dir/target-mipsel_24kc_musl/host/include -Wall -Wmissing-prototypes -Wstrict-prototypes" CROSS_COMPILE="mipsel-openwrt-linux-musl-" ARCH="mips" KBUILD_HAVE_NLS=no KBUILD_BUILD_USER="builder" KBUILD_BUILD_HOST="buildhost" KBUILD_BUILD_TIMESTAMP="Mon Mar 27 12:16:10 2023" KBUILD_BUILD_VERSION="0" KBUILD_HOSTLDFLAGS="-L/home/karlk/Development/openwrt/staging_dir/host/lib" CONFIG_SHELL="bash" V=''  cmd_syscalls= KBUILD_EXTRA_SYMBOLS="/home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/batman-adv.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/button-hotplug.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/cryptodev-linux.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/dahdi-linux.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/dmx_usb_module.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/gl-mifi-mcu.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/gpio-button-hotplug.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/jool.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/ksmbd.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/mac80211.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/macremapper.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/mdio-netlink.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/mtd-rw.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/nat46.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/netatop.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/openvswitch.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/ovpn-dco.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/rtpengine.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/siit.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/trelay.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/ubnt-ledbar.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/usb-serial-xr_usb_serial_common.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/v4l2loopback.symvers /home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/symvers/xtables-addons.symvers" KERNELRELEASE=5.15.111 EXTRA_CFLAGS="-I/home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/backports-6.1.24/include -ffile-prefix-map=/home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/backports-6.1.24=backports-6.1.24 " KLIB_BUILD="/home/karlk/Development/openwrt/build_dir/target-mipsel_24kc_musl/linux-ramips_mt7620/linux-5.15.111" MODPROBE=true KLIB=/lib/modules/5.15.111 KERNEL_SUBLEVEL=15 KBUILD_LDFLAGS_MODULE_PREREQ=

build-verbose:
  # build mac80211 and rt2x00 driver
  make -C {{openwrt_dir}} package/kernel/mac80211/compile -j1 V=s

deploy:
  # deploy changed rt2x00 kernel modules
  {{copy}} drivers/net/wireless/ralink/rt2x00/*.ko {{remote}}:/lib/modules/5.15.111/

reload:
  # reload rt2x00 driver
  {{ssh_run}} 'rmmod rt2800soc; rmmod rt2800pci; rmmod rt2800mmio; rmmod rt2800lib; rmmod rt2x00soc; rmmod rt2x00pci; rmmod rt2x00mmio; rmmod rt2x00lib'
  {{ssh_run}} 'modprobe rt2800pci; modprobe rt2800soc'

sysupgrade:
  # make -C {{openwrt_dir}}  -j `nproc`
  {{copy_scp}} {{openwrt_dir}}/bin/targets/ramips/mt7620/openwrt-ramips-mt7620-buffalo_whr-600d-squashfs-sysupgrade.bin {{remote}}:/tmp
  {{ssh_run}} 'sysupgrade -v /tmp/openwrt-ramips-mt7620-buffalo_whr-600d-squashfs-sysupgrade.bin'
