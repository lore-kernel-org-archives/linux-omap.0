From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [14/17 PATCH] MMC: OMAP: Enabling MMC/SD card support option on
 omap_h3_1710_defconfig to use MMC multislot support.
Date: Fri, 17 Aug 2007 15:02:26 -0400
Message-ID: <46C5F0C2.5040203@indt.org.br>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000104070101080701010000"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000104070101080701010000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

From: Felipe Balbi <felipe.lima@indt.org.br>

Enables MMC/SD card support option on omap_h3_1710_defconfig to use MMC
multislot support.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Cohen <david.cohen@indt.org.br>
Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

--------------000104070101080701010000
Content-Type: text/plain;
	name*0="0014-MMC-OMAP-Enabling-MMC-SD-card-support-on-omap_h3_1710_defco";
	name*1="nfig.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0014-MMC-OMAP-Enabling-MMC-SD-card-support-on-omap_h3_1710_d";
	filename*1="efconfig.diff"

Enables MMC/SD card support option on omap_h3_1710_defconfig to use MMC multislot support.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Anderson Briglia <anderson.briglia@indt.org.br>
Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Signed-off-by: David Cohen <david.cohen@indt.org.br>
Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

Index: linux-omap/arch/arm/configs/omap_h3_1710_defconfig
===================================================================
--- linux-omap.orig/arch/arm/configs/omap_h3_1710_defconfig	2007-08-17 09:40:46.000000000 -0400
+++ linux-omap/arch/arm/configs/omap_h3_1710_defconfig	2007-08-17 09:48:10.000000000 -0400
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc1-omap1
-# Thu Jun  7 04:41:04 2007
+# Linux kernel version: 2.6.23-rc2-omap1
+# Fri Aug 17 09:47:49 2007
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -26,25 +26,20 @@ CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
@@ -79,24 +74,17 @@ CONFIG_SLAB=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 # CONFIG_KMOD is not set
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
 
 #
 # IO Schedulers
@@ -137,6 +125,7 @@ CONFIG_DEFAULT_IOSCHED="cfq"
 # CONFIG_ARCH_L7200 is not set
 # CONFIG_ARCH_KS8695 is not set
 # CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_MXC is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -153,13 +142,14 @@ CONFIG_ARCH_OMAP=y
 CONFIG_ARCH_OMAP_OTG=y
 CONFIG_ARCH_OMAP1=y
 # CONFIG_ARCH_OMAP2 is not set
+# CONFIG_ARCH_OMAP3 is not set
 
 #
 # OMAP Feature Selections
 #
 # CONFIG_OMAP_RESET_CLOCKS is not set
 # CONFIG_OMAP_BOOT_TAG is not set
-# CONFIG_OMAP_GPIO_SWITCH is not set
+CONFIG_OMAP_GPIO_SWITCH=y
 CONFIG_OMAP_MUX=y
 # CONFIG_OMAP_MUX_DEBUG is not set
 CONFIG_OMAP_MUX_WARNINGS=y
@@ -173,7 +163,6 @@ CONFIG_OMAP_MPU_TIMER=y
 CONFIG_OMAP_LL_DEBUG_UART1=y
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
 # CONFIG_OMAP_LL_DEBUG_UART3 is not set
-# CONFIG_OMAP_LL_DEBUG_LCD is not set
 CONFIG_OMAP_SERIAL_WAKE=y
 # CONFIG_OMAP_DSP is not set
 
@@ -204,6 +193,15 @@ CONFIG_OMAP_ARM_168MHZ=y
 # CONFIG_OMAP_ARM_120MHZ is not set
 # CONFIG_OMAP_ARM_60MHZ is not set
 # CONFIG_OMAP_ARM_30MHZ is not set
+# CONFIG_MACH_OMAP_APOLLON_PLUS is not set
+
+#
+# Boot options
+#
+
+#
+# Power management
+#
 
 #
 # Processor Type
@@ -212,6 +210,7 @@ CONFIG_CPU_32=y
 CONFIG_CPU_ARM926T=y
 CONFIG_CPU_32v5=y
 CONFIG_CPU_ABRT_EV5TJ=y
+CONFIG_CPU_PABRT_NOIFAR=y
 CONFIG_CPU_CACHE_VIVT=y
 CONFIG_CPU_COPY_V4WB=y
 CONFIG_CPU_TLB_V4WBI=y
@@ -231,6 +230,7 @@ CONFIG_ARM_THUMB=y
 #
 # Bus support
 #
+# CONFIG_PCI_SYSCALL is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
@@ -258,6 +258,8 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_SPLIT_PTLOCK_CPUS=4096
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 CONFIG_LEDS=y
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -302,7 +304,8 @@ CONFIG_BINFMT_AOUT=y
 CONFIG_PM=y
 # CONFIG_PM_LEGACY is not set
 # CONFIG_PM_DEBUG is not set
-# CONFIG_PM_SYSFS_DEPRECATED is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
 # CONFIG_APM_EMULATION is not set
 
 #
@@ -353,20 +356,8 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
-
-#
-# DCCP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_DCCP is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_SCTP is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -448,6 +439,7 @@ CONFIG_IRDA=y
 # CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -462,26 +454,10 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
 # CONFIG_MTD is not set
-
-#
-# Parallel port support
-#
 # CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
-# CONFIG_PNPACPI is not set
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
@@ -498,39 +474,27 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
 # CONFIG_MD is not set
-
-#
-# Network device support
-#
 CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
 # CONFIG_PHYLIB is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_AX88796 is not set
 CONFIG_SMC91X=y
 # CONFIG_DM9000 is not set
 CONFIG_NETDEV_1000=y
 CONFIG_NETDEV_10000=y
 
 #
-# Token Ring devices
-#
-
-#
 # Wireless LAN
 #
 # CONFIG_WLAN_PRE80211 is not set
@@ -555,6 +519,7 @@ CONFIG_PPP=y
 # CONFIG_PPP_BSDCOMP is not set
 # CONFIG_PPP_MPPE is not set
 # CONFIG_PPPOE is not set
+# CONFIG_PPPOL2TP is not set
 CONFIG_SLIP=y
 CONFIG_SLIP_COMPRESSED=y
 CONFIG_SLHC=y
@@ -564,10 +529,6 @@ CONFIG_SLHC=y
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
 
 #
@@ -575,6 +536,7 @@ CONFIG_SLHC=y
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -639,10 +601,6 @@ CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
 CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_NOWAYOUT=y
@@ -662,10 +620,6 @@ CONFIG_HW_RANDOM_OMAP=m
 # CONFIG_NVRAM is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
@@ -686,6 +640,7 @@ CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_OMAP=y
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_TAOS_EVM is not set
 # CONFIG_I2C_STUB is not set
 # CONFIG_I2C_TINY_USB is not set
 
@@ -694,6 +649,7 @@ CONFIG_I2C_OMAP=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
+# CONFIG_DS1682 is not set
 # CONFIG_SENSORS_EEPROM is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -703,6 +659,7 @@ CONFIG_TPS65010=y
 # CONFIG_SENSORS_TLV320AIC23 is not set
 CONFIG_GPIOEXPANDER_OMAP=y
 # CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
@@ -730,14 +687,12 @@ CONFIG_SPI_OMAP_UWIRE=y
 # CONFIG_SPI_TSC210X is not set
 # CONFIG_SPI_TSC2301 is not set
 # CONFIG_SPI_SPIDEV is not set
-
-#
-# Dallas's 1-wire bus
-#
+# CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
 CONFIG_HWMON=y
 # CONFIG_HWMON_VID is not set
 # CONFIG_SENSORS_ABITUGURU is not set
+# CONFIG_SENSORS_ABITUGURU3 is not set
 # CONFIG_SENSORS_AD7418 is not set
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
@@ -765,13 +720,16 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_LM87 is not set
 # CONFIG_SENSORS_LM90 is not set
 # CONFIG_SENSORS_LM92 is not set
+# CONFIG_SENSORS_LM93 is not set
 # CONFIG_SENSORS_MAX1619 is not set
 # CONFIG_SENSORS_MAX6650 is not set
 # CONFIG_SENSORS_PC87360 is not set
 # CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_DME1737 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
 # CONFIG_SENSORS_SMSC47M192 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_THMC50 is not set
 # CONFIG_SENSORS_VT1211 is not set
 # CONFIG_SENSORS_W83781D is not set
 # CONFIG_SENSORS_W83791D is not set
@@ -782,31 +740,16 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_W83627EHF is not set
 # CONFIG_SENSORS_TSC210X is not set
 # CONFIG_HWMON_DEBUG_CHIP is not set
-
-#
-# Misc devices
-#
-# CONFIG_BLINK is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
 
 #
 # Multifunction device drivers
 #
 # CONFIG_MFD_SM501 is not set
-
-#
-# LED devices
-#
 # CONFIG_NEW_LEDS is not set
 
 #
-# LED drivers
-#
-
-#
-# LED Triggers
-#
-
-#
 # Multimedia devices
 #
 CONFIG_VIDEO_DEV=y
@@ -821,9 +764,11 @@ CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
 # CONFIG_VIDEO_SAA5246A is not set
 # CONFIG_VIDEO_SAA5249 is not set
 # CONFIG_TUNER_3036 is not set
+# CONFIG_TUNER_TEA5761 is not set
 # CONFIG_VIDEO_OMAP_CAMERA is not set
 CONFIG_V4L_USB_DRIVERS=y
 # CONFIG_VIDEO_PVRUSB2 is not set
+# CONFIG_VIDEO_EM28XX is not set
 # CONFIG_VIDEO_USBVISION is not set
 # CONFIG_USB_VICAM is not set
 # CONFIG_USB_IBMCAM is not set
@@ -856,6 +801,7 @@ CONFIG_DAB=y
 #
 # CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
 # CONFIG_FIRMWARE_EDID is not set
 # CONFIG_FB_DDC is not set
@@ -879,7 +825,6 @@ CONFIG_FB_MODE_HELPERS=y
 # CONFIG_FB_S1D13XXX is not set
 CONFIG_FB_OMAP=y
 # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
-# CONFIG_FB_OMAP_LCD_MIPID is not set
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_FB_OMAP_DMA_TUNE is not set
@@ -891,6 +836,7 @@ CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
 # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
 # CONFIG_FONTS is not set
 CONFIG_FONT_8x8=y
@@ -914,13 +860,9 @@ CONFIG_SOUND=y
 # Open Sound System
 #
 CONFIG_SOUND_PRIME=y
-# CONFIG_OSS_OBSOLETE is not set
 # CONFIG_SOUND_MSNDCLAS is not set
 # CONFIG_SOUND_MSNDPIN is not set
-
-#
-# HID Devices
-#
+CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
 
@@ -934,10 +876,7 @@ CONFIG_HID=y
 #
 # CONFIG_USB_KBD is not set
 # CONFIG_USB_MOUSE is not set
-
-#
-# USB support
-#
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_USB_ARCH_HAS_EHCI is not set
@@ -951,6 +890,7 @@ CONFIG_USB=m
 # CONFIG_USB_DEVICE_CLASS is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
 # CONFIG_USB_SUSPEND is not set
+# CONFIG_USB_PERSIST is not set
 # CONFIG_USB_OTG is not set
 
 #
@@ -962,6 +902,7 @@ CONFIG_USB_OHCI_HCD=m
 # CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
 
 #
 # Enable Host or Gadget support to see Inventra options
@@ -1036,15 +977,12 @@ CONFIG_MMC=y
 # MMC/SD Card Drivers
 #
 CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
 
 #
 # MMC/SD Host Controller Drivers
 #
 CONFIG_MMC_OMAP=y
-
-#
-# Real Time Clock
-#
 CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_HCTOSYS=y
@@ -1071,6 +1009,7 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_X1205 is not set
 # CONFIG_RTC_DRV_PCF8563 is not set
 # CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
 
 #
 # SPI RTC drivers
@@ -1083,8 +1022,10 @@ CONFIG_RTC_INTF_DEV=y
 #
 # CONFIG_RTC_DRV_CMOS is not set
 # CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
 # CONFIG_RTC_DRV_V3020 is not set
 
 #
@@ -1093,6 +1034,19 @@ CONFIG_RTC_INTF_DEV=y
 CONFIG_RTC_DRV_OMAP=y
 
 #
+# DMA Engine support
+#
+# CONFIG_DMA_ENGINE is not set
+
+#
+# DMA Clients
+#
+
+#
+# DMA Devices
+#
+
+#
 # CBUS support
 #
 # CONFIG_CBUS is not set
@@ -1110,7 +1064,7 @@ CONFIG_EXT2_FS_XATTR=y
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-# CONFIG_FS_POSIX_ACL is not set
+CONFIG_FS_POSIX_ACL=y
 # CONFIG_XFS_FS is not set
 # CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
@@ -1123,6 +1077,7 @@ CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
+CONFIG_GENERIC_ACL=y
 
 #
 # CD-ROM/DVD Filesystems
@@ -1133,8 +1088,11 @@ CONFIG_DNOTIFY=y
 #
 # DOS/FAT/NT Filesystems
 #
-# CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
 
 #
@@ -1143,7 +1101,8 @@ CONFIG_DNOTIFY=y
 CONFIG_PROC_FS=y
 CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
-# CONFIG_TMPFS is not set
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
@@ -1187,7 +1146,6 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -1198,7 +1156,46 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Native Language Support
 #
-# CONFIG_NLS is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
 
 #
 # Distributed Lock Manager
@@ -1222,6 +1219,7 @@ CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
 CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
@@ -1231,6 +1229,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_DEBUG_MUTEXES is not set
 # CONFIG_DEBUG_LOCK_ALLOC is not set
 # CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1251,10 +1250,6 @@ CONFIG_DEBUG_ERRORS=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
 # CONFIG_CRYPTO is not set
 
 #
@@ -1265,6 +1260,7 @@ CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y

--------------000104070101080701010000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000104070101080701010000--
