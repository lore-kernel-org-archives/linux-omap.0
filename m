From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH 01/14] ARM: OMAP: Update
	arch/arm/configs/omap_2430sdp_defconfig
Date: Mon, 17 Sep 2007 16:23:08 -0400
Message-ID: <11900606021256-git-send-email-felipe.lima@indt.org.br>
References: <11900606011267-git-send-email-felipe.lima@indt.org.br>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11900606011267-git-send-email-felipe.lima@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Update  omap_2430sdp_defconfig

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 arch/arm/configs/omap_2430sdp_defconfig |  506 ++++++++-----------------------
 1 files changed, 133 insertions(+), 373 deletions(-)

diff --git a/arch/arm/configs/omap_2430sdp_defconfig b/arch/arm/configs/omap_2430sdp_defconfig
index b9dfb0e..ee33312 100644
--- a/arch/arm/configs/omap_2430sdp_defconfig
+++ b/arch/arm/configs/omap_2430sdp_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc2-omap1
-# Fri May 25 15:47:55 2007
+# Linux kernel version: 2.6.23-rc6-omap1
+# Mon Sep 17 15:41:30 2007
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -26,27 +26,21 @@ CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
-CONFIG_LOCK_KERNEL=y
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
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
@@ -58,7 +52,7 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_UID16=y
-# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 CONFIG_KALLSYMS_EXTRA_PASS=y
@@ -81,24 +75,17 @@ CONFIG_SLAB=y
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
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_KMOD=y
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
@@ -139,6 +126,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_ARCH_L7200 is not set
 # CONFIG_ARCH_KS8695 is not set
 # CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_MXC is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -152,20 +140,23 @@ CONFIG_ARCH_OMAP=y
 #
 # TI OMAP Implementations
 #
+CONFIG_ARCH_OMAP_OTG=y
 # CONFIG_ARCH_OMAP1 is not set
 CONFIG_ARCH_OMAP2=y
+# CONFIG_ARCH_OMAP3 is not set
 
 #
 # OMAP Feature Selections
 #
+CONFIG_OMAP_DEBUG_DEVICES=y
 # CONFIG_OMAP_RESET_CLOCKS is not set
 CONFIG_OMAP_BOOT_TAG=y
 # CONFIG_OMAP_BOOT_REASON is not set
 # CONFIG_OMAP_COMPONENT_VERSION is not set
 # CONFIG_OMAP_GPIO_SWITCH is not set
 CONFIG_OMAP_MUX=y
-# CONFIG_OMAP_MUX_DEBUG is not set
-# CONFIG_OMAP_MUX_WARNINGS is not set
+CONFIG_OMAP_MUX_DEBUG=y
+CONFIG_OMAP_MUX_WARNINGS=y
 # CONFIG_OMAP_STI is not set
 CONFIG_OMAP_MCBSP=y
 # CONFIG_OMAP_MMU_FWK is not set
@@ -184,16 +175,28 @@ CONFIG_OMAP_SERIAL_WAKE=y
 # OMAP Core Type
 #
 CONFIG_ARCH_OMAP24XX=y
-# CONFIG_ARCH_OMAP2420 is not set
-CONFIG_ARCH_OMAP2430=y
+CONFIG_ARCH_OMAP2420=y
+# CONFIG_ARCH_OMAP2430 is not set
 
 #
 # OMAP Board Type
 #
 # CONFIG_MACH_NOKIA_N800 is not set
-# CONFIG_MACH_OMAP_H4 is not set
+CONFIG_MACH_OMAP_H4=y
+# CONFIG_MACH_OMAP_H4_TUSB is not set
+# CONFIG_MACH_OMAP_H4_OTG is not set
+# CONFIG_MACH_OMAP2_H4_USB1 is not set
 # CONFIG_MACH_OMAP_APOLLON is not set
-CONFIG_MACH_OMAP_2430SDP=y
+# CONFIG_MACH_OMAP_APOLLON_PLUS is not set
+# CONFIG_MACH_OMAP_2430SDP is not set
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
@@ -203,6 +206,7 @@ CONFIG_CPU_V6=y
 # CONFIG_CPU_32v6K is not set
 CONFIG_CPU_32v6=y
 CONFIG_CPU_ABRT_EV6=y
+CONFIG_CPU_PABRT_NOIFAR=y
 CONFIG_CPU_CACHE_V6=y
 CONFIG_CPU_CACHE_VIPT=y
 CONFIG_CPU_COPY_V6=y
@@ -217,13 +221,13 @@ CONFIG_CPU_CP15_MMU=y
 CONFIG_ARM_THUMB=y
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
-# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 # CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
 #
+# CONFIG_PCI_SYSCALL is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
@@ -237,7 +241,7 @@ CONFIG_ARM_THUMB=y
 # CONFIG_TICK_ONESHOT is not set
 # CONFIG_NO_HZ is not set
 # CONFIG_HIGH_RES_TIMERS is not set
-CONFIG_PREEMPT=y
+# CONFIG_PREEMPT is not set
 CONFIG_HZ=100
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
@@ -252,6 +256,8 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -291,11 +297,8 @@ CONFIG_BINFMT_MISC=y
 #
 # Power management options
 #
-CONFIG_PM=y
-# CONFIG_PM_LEGACY is not set
-# CONFIG_PM_DEBUG is not set
-# CONFIG_PM_SYSFS_DEPRECATED is not set
-# CONFIG_APM_EMULATION is not set
+# CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
 
 #
 # Networking
@@ -345,20 +348,8 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
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
@@ -382,7 +373,48 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
-# CONFIG_IRDA is not set
+CONFIG_IRDA=y
+
+#
+# IrDA protocols
+#
+CONFIG_IRLAN=y
+CONFIG_IRCOMM=y
+# CONFIG_IRDA_ULTRA is not set
+
+#
+# IrDA options
+#
+# CONFIG_IRDA_CACHE_LAST_LSAP is not set
+# CONFIG_IRDA_FAST_RR is not set
+# CONFIG_IRDA_DEBUG is not set
+
+#
+# Infrared-port device drivers
+#
+
+#
+# SIR device drivers
+#
+# CONFIG_IRTTY_SIR is not set
+
+#
+# Dongle support
+#
+
+#
+# Old SIR device drivers
+#
+# CONFIG_IRPORT_SIR is not set
+
+#
+# Old Serial dongle support
+#
+
+#
+# FIR device drivers
+#
+CONFIG_OMAP_IR=y
 # CONFIG_BT is not set
 # CONFIG_AF_RXRPC is not set
 
@@ -394,6 +426,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -408,10 +441,6 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
@@ -470,8 +499,6 @@ CONFIG_MTD_OMAP_NOR=y
 #
 # Self-contained MTD device drivers
 #
-# CONFIG_MTD_DATAFLASH is not set
-# CONFIG_MTD_M25P80 is not set
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
@@ -484,35 +511,18 @@ CONFIG_MTD_OMAP_NOR=y
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
 # CONFIG_MTD_NAND is not set
-CONFIG_MTD_ONENAND=y
-CONFIG_MTD_ONENAND_VERIFY_WRITE=y
-# CONFIG_MTD_ONENAND_GENERIC is not set
-CONFIG_MTD_ONENAND_OMAP2=y
-# CONFIG_MTD_ONENAND_OTP is not set
+# CONFIG_MTD_ONENAND is not set
 
 #
 # UBI - Unsorted block images
 #
 # CONFIG_MTD_UBI is not set
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
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=16384
@@ -524,91 +534,32 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
-CONFIG_SCSI=m
-# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
 # CONFIG_SCSI_NETLINK is not set
-CONFIG_SCSI_PROC_FS=y
-
-#
-# SCSI support type (disk, tape, CD-ROM)
-#
-CONFIG_BLK_DEV_SD=m
-# CONFIG_CHR_DEV_ST is not set
-# CONFIG_CHR_DEV_OSST is not set
-# CONFIG_BLK_DEV_SR is not set
-CONFIG_CHR_DEV_SG=m
-# CONFIG_CHR_DEV_SCH is not set
-
-#
-# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
-#
-# CONFIG_SCSI_MULTI_LUN is not set
-# CONFIG_SCSI_CONSTANTS is not set
-# CONFIG_SCSI_LOGGING is not set
-# CONFIG_SCSI_SCAN_ASYNC is not set
-CONFIG_SCSI_WAIT_SCAN=m
-
-#
-# SCSI Transports
-#
-# CONFIG_SCSI_SPI_ATTRS is not set
-# CONFIG_SCSI_FC_ATTRS is not set
-# CONFIG_SCSI_ISCSI_ATTRS is not set
-# CONFIG_SCSI_SAS_ATTRS is not set
-# CONFIG_SCSI_SAS_LIBSAS is not set
-
-#
-# SCSI low-level drivers
-#
-# CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_DEBUG is not set
-# CONFIG_SCSI_ESP_CORE is not set
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
 # CONFIG_WLAN_80211 is not set
-
-#
-# USB Network Adapters
-#
-# CONFIG_USB_CATC is not set
-# CONFIG_USB_KAWETH is not set
-# CONFIG_USB_PEGASUS is not set
-# CONFIG_USB_RTL8150 is not set
-# CONFIG_USB_USBNET_MII is not set
-# CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
@@ -616,10 +567,6 @@ CONFIG_NETDEV_10000=y
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
 
 #
@@ -627,6 +574,7 @@ CONFIG_NETDEV_10000=y
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -647,24 +595,12 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
-# CONFIG_KEYBOARD_OMAP is not set
-CONFIG_KEYBOARD_TWL4030=y
+CONFIG_KEYBOARD_OMAP=y
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
-CONFIG_INPUT_TOUCHSCREEN=y
-CONFIG_TOUCHSCREEN_ADS7846=y
-# CONFIG_TOUCHSCREEN_GUNZE is not set
-# CONFIG_TOUCHSCREEN_ELO is not set
-# CONFIG_TOUCHSCREEN_MTOUCH is not set
-# CONFIG_TOUCHSCREEN_MK712 is not set
-# CONFIG_TOUCHSCREEN_PENMOUNT is not set
-# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
-# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
-# CONFIG_TOUCHSCREEN_UCB1400 is not set
-# CONFIG_TOUCHSCREEN_TSC2102 is not set
-# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
 #
@@ -702,10 +638,6 @@ CONFIG_SERIAL_CORE=y
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
@@ -715,24 +647,15 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 #
 # CONFIG_SOFT_WATCHDOG is not set
 CONFIG_OMAP_WATCHDOG=y
-
-#
-# USB-based Watchdog Cards
-#
-# CONFIG_USBPCWATCHDOG is not set
-CONFIG_HW_RANDOM=y
-CONFIG_HW_RANDOM_OMAP=y
+CONFIG_HW_RANDOM=m
+CONFIG_HW_RANDOM_OMAP=m
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
-CONFIG_I2C_CHARDEV=y
+# CONFIG_I2C_CHARDEV is not set
 
 #
 # I2C Algorithms
@@ -749,25 +672,27 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_OMAP=y
 # CONFIG_I2C_PARPORT_LIGHT is not set
 # CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_TAOS_EVM is not set
 # CONFIG_I2C_STUB is not set
-# CONFIG_I2C_TINY_USB is not set
 
 #
 # Miscellaneous I2C Chip support
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
+# CONFIG_DS1682 is not set
 # CONFIG_SENSORS_EEPROM is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_ISP1301_OMAP is not set
 # CONFIG_TPS65010 is not set
 # CONFIG_SENSORS_TLV320AIC23 is not set
-# CONFIG_GPIOEXPANDER_OMAP is not set
-# CONFIG_MENELAUS is not set
-CONFIG_TWL4030_CORE=y
-CONFIG_TWL4030_GPIO=y
+CONFIG_GPIOEXPANDER_OMAP=y
+# CONFIG_TWL4030_CORE is not set
 # CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+CONFIG_MENELAUS=y
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
@@ -776,61 +701,25 @@ CONFIG_TWL4030_GPIO=y
 #
 # SPI support
 #
-CONFIG_SPI=y
-# CONFIG_SPI_DEBUG is not set
-CONFIG_SPI_MASTER=y
-
-#
-# SPI Master Controller Drivers
-#
-# CONFIG_SPI_BITBANG is not set
-# CONFIG_SPI_OMAP24XX is not set
-
-#
-# SPI Protocol Masters
-#
-# CONFIG_SPI_AT25 is not set
-# CONFIG_SPI_TSC2101 is not set
-# CONFIG_SPI_TSC2102 is not set
-# CONFIG_SPI_TSC2301 is not set
-# CONFIG_SPI_SPIDEV is not set
-
-#
-# Dallas's 1-wire bus
-#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
 # CONFIG_W1 is not set
 # CONFIG_HWMON is not set
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
 # CONFIG_VIDEO_DEV is not set
 # CONFIG_DVB_CORE is not set
 CONFIG_DAB=y
-# CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
@@ -842,6 +731,7 @@ CONFIG_DAB=y
 #
 # CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 # CONFIG_FB_DDC is not set
@@ -875,6 +765,7 @@ CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
 # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
 # CONFIG_FONTS is not set
 CONFIG_FONT_8x8=y
@@ -888,161 +779,27 @@ CONFIG_LOGO_LINUX_CLUT224=y
 # Sound
 #
 # CONFIG_SOUND is not set
-
-#
-# HID Devices
-#
+CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
-
-#
-# USB Input Devices
-#
-CONFIG_USB_HID=m
-# CONFIG_USB_HIDINPUT_POWERBOOK is not set
-# CONFIG_HID_FF is not set
-# CONFIG_USB_HIDDEV is not set
-
-#
-# USB HID Boot Protocol drivers
-#
-# CONFIG_USB_KBD is not set
-# CONFIG_USB_MOUSE is not set
-
-#
-# USB support
-#
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_USB_ARCH_HAS_EHCI is not set
-CONFIG_USB=m
-# CONFIG_USB_DEBUG is not set
-
-#
-# Miscellaneous USB options
-#
-# CONFIG_USB_DEVICEFS is not set
-# CONFIG_USB_DEVICE_CLASS is not set
-# CONFIG_USB_DYNAMIC_MINORS is not set
-CONFIG_USB_SUSPEND=y
-CONFIG_USB_OTG=y
-CONFIG_USB_OTG_WHITELIST=y
-# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB is not set
 
 #
-# USB Host Controller Drivers
+# Enable Host or Gadget support to see Inventra options
 #
-# CONFIG_USB_ISP116X_HCD is not set
-# CONFIG_USB_OHCI_HCD is not set
-# CONFIG_USB_SL811_HCD is not set
-CONFIG_USB_MUSB_HDRC=m
-CONFIG_USB_MUSB_SOC=y
-
-#
-# OMAP 243x high speed USB support
-#
-# CONFIG_USB_MUSB_HOST is not set
-# CONFIG_USB_MUSB_PERIPHERAL is not set
-CONFIG_USB_MUSB_OTG=y
-CONFIG_USB_GADGET_MUSB_HDRC=y
-CONFIG_USB_MUSB_HDRC_HCD=y
-# CONFIG_USB_INVENTRA_FIFO is not set
-CONFIG_USB_INVENTRA_DMA=y
-# CONFIG_USB_TI_CPPI_DMA is not set
-CONFIG_USB_INVENTRA_HCD_LOGGING=1
-
-#
-# USB Device Class drivers
-#
-# CONFIG_USB_ACM is not set
-# CONFIG_USB_PRINTER is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
-# may also be needed; see USB_STORAGE Help for more information
-#
-CONFIG_USB_STORAGE=m
-# CONFIG_USB_STORAGE_DEBUG is not set
-# CONFIG_USB_STORAGE_DATAFAB is not set
-# CONFIG_USB_STORAGE_FREECOM is not set
-# CONFIG_USB_STORAGE_DPCM is not set
-# CONFIG_USB_STORAGE_USBAT is not set
-# CONFIG_USB_STORAGE_SDDR09 is not set
-# CONFIG_USB_STORAGE_SDDR55 is not set
-# CONFIG_USB_STORAGE_JUMPSHOT is not set
-# CONFIG_USB_STORAGE_ALAUDA is not set
-# CONFIG_USB_STORAGE_KARMA is not set
-# CONFIG_USB_LIBUSUAL is not set
-
-#
-# USB Imaging devices
-#
-# CONFIG_USB_MDC800 is not set
-# CONFIG_USB_MICROTEK is not set
-CONFIG_USB_MON=y
-
-#
-# USB port drivers
-#
-
-#
-# USB Serial Converter support
-#
-# CONFIG_USB_SERIAL is not set
-
-#
-# USB Miscellaneous drivers
-#
-# CONFIG_USB_EMI62 is not set
-# CONFIG_USB_EMI26 is not set
-# CONFIG_USB_ADUTUX is not set
-# CONFIG_USB_AUERSWALD is not set
-# CONFIG_USB_RIO500 is not set
-# CONFIG_USB_LEGOTOWER is not set
-# CONFIG_USB_LCD is not set
-# CONFIG_USB_BERRY_CHARGE is not set
-# CONFIG_USB_LED is not set
-# CONFIG_USB_CYPRESS_CY7C63 is not set
-# CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGET is not set
-# CONFIG_USB_IDMOUSE is not set
-# CONFIG_USB_FTDI_ELAN is not set
-# CONFIG_USB_APPLEDISPLAY is not set
-# CONFIG_USB_LD is not set
-# CONFIG_USB_TRANCEVIBRATOR is not set
-# CONFIG_USB_IOWARRIOR is not set
-
-#
-# USB DSL modem support
-#
-
-#
 # USB Gadget Support
 #
-CONFIG_USB_GADGET=m
-CONFIG_USB_GADGET_DEBUG_FILES=y
-CONFIG_USB_GADGET_SELECTED=y
-# CONFIG_USB_GADGET_FSL_USB2 is not set
-# CONFIG_USB_GADGET_NET2280 is not set
-# CONFIG_USB_GADGET_PXA2XX is not set
-# CONFIG_USB_GADGET_GOKU is not set
-# CONFIG_USB_GADGET_LH7A40X is not set
-# CONFIG_USB_GADGET_OMAP is not set
-# CONFIG_USB_GADGET_AT91 is not set
-# CONFIG_USB_GADGET_DUMMY_HCD is not set
-CONFIG_USB_GADGET_DUALSPEED=y
-CONFIG_USB_ZERO=m
-# CONFIG_USB_ZERO_HNPTEST is not set
-CONFIG_USB_ETH=m
-CONFIG_USB_ETH_RNDIS=y
-CONFIG_USB_GADGETFS=m
-CONFIG_USB_FILE_STORAGE=m
-# CONFIG_USB_FILE_STORAGE_TEST is not set
-CONFIG_USB_G_SERIAL=m
-# CONFIG_USB_MIDI_GADGET is not set
+# CONFIG_USB_GADGET is not set
 CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
 # CONFIG_MMC_UNSAFE_RESUME is not set
@@ -1051,17 +808,27 @@ CONFIG_MMC=y
 # MMC/SD Card Drivers
 #
 CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
 
 #
 # MMC/SD Host Controller Drivers
 #
 CONFIG_MMC_OMAP=y
+CONFIG_RTC_LIB=y
+# CONFIG_RTC_CLASS is not set
 
 #
-# Real Time Clock
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
 #
-CONFIG_RTC_LIB=y
-# CONFIG_RTC_CLASS is not set
 
 #
 # CBUS support
@@ -1141,13 +908,10 @@ CONFIG_JFFS2_FS_DEBUG=0
 CONFIG_JFFS2_FS_WRITEBUFFER=y
 # CONFIG_JFFS2_SUMMARY is not set
 # CONFIG_JFFS2_FS_XATTR is not set
-CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
 CONFIG_JFFS2_ZLIB=y
 CONFIG_JFFS2_RTIME=y
 # CONFIG_JFFS2_RUBIN is not set
-# CONFIG_JFFS2_CMODE_NONE is not set
-CONFIG_JFFS2_CMODE_PRIORITY=y
-# CONFIG_JFFS2_CMODE_SIZE is not set
 # CONFIG_CRAMFS is not set
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -1161,7 +925,7 @@ CONFIG_JFFS2_CMODE_PRIORITY=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
-# CONFIG_NFS_V4 is not set
+CONFIG_NFS_V4=y
 # CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
@@ -1169,15 +933,15 @@ CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
 # CONFIG_SUNRPC_BIND34 is not set
-# CONFIG_RPCSEC_GSS_KRB5 is not set
+CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -1267,16 +1031,17 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
 CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
-CONFIG_TIMER_STATS=y
+# CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
-CONFIG_DEBUG_PREEMPT=y
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_LOCK_ALLOC is not set
 # CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1290,17 +1055,14 @@ CONFIG_FORCED_INLINING=y
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_ERRORS is not set
-# CONFIG_DEBUG_LL is not set
+CONFIG_DEBUG_LL=y
+# CONFIG_DEBUG_ICEDCC is not set
 
 #
 # Security options
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
@@ -1338,10 +1100,7 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_CRYPTO_HW=y
 
 #
 # Library routines
@@ -1351,6 +1110,7 @@ CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=y
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
-- 
1.5.3.1.91.gd3392
