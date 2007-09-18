From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [PATCH 03/14] Update arch/arm/configs/omap_apollon_2420_defconfig
Date: Tue, 18 Sep 2007 13:56:39 -0400
Message-ID: <11901382112392-git-send-email-felipe.lima@indt.org.br>
References: <1190138210438-git-send-email-felipe.lima@indt.org.br>
	<11901382113889-git-send-email-felipe.lima@indt.org.br>
	<11901382111511-git-send-email-felipe.lima@indt.org.br>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11901382111511-git-send-email-felipe.lima@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Update arch/arm/configs/omap_apollon_2420_defconfig

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---
 arch/arm/configs/omap_apollon_2420_defconfig |  357 +++++++++++---------------
 1 files changed, 155 insertions(+), 202 deletions(-)

diff --git a/arch/arm/configs/omap_apollon_2420_defconfig b/arch/arm/configs/omap_apollon_2420_defconfig
index 2cef064..bb39dfc 100644
--- a/arch/arm/configs/omap_apollon_2420_defconfig
+++ b/arch/arm/configs/omap_apollon_2420_defconfig
@@ -1,12 +1,18 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc1-omap1
-# Fri Dec 22 14:31:47 2006
+# Linux kernel version: 2.6.23-rc6-omap1
+# Tue Sep 18 12:07:29 2007
 #
 CONFIG_ARM=y
-# CONFIG_GENERIC_TIME is not set
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+CONFIG_GENERIC_GPIO=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_MMU=y
+# CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_HARDIRQS=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_HARDIRQS_SW_RESEND=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -15,35 +21,33 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_ZONE_DMA=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
-CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_BLK_DEV_INITRD is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
@@ -58,32 +62,30 @@ CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
-CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
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
@@ -115,13 +117,16 @@ CONFIG_DEFAULT_IOSCHED="cfq"
 # CONFIG_ARCH_NETX is not set
 # CONFIG_ARCH_H720X is not set
 # CONFIG_ARCH_IMX is not set
+# CONFIG_ARCH_IOP13XX is not set
 # CONFIG_ARCH_IOP32X is not set
 # CONFIG_ARCH_IOP33X is not set
-# CONFIG_ARCH_IOP13XX is not set
-# CONFIG_ARCH_IXP4XX is not set
-# CONFIG_ARCH_IXP2000 is not set
 # CONFIG_ARCH_IXP23XX is not set
+# CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP4XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_KS8695 is not set
+# CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_MXC is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -129,6 +134,7 @@ CONFIG_DEFAULT_IOSCHED="cfq"
 # CONFIG_ARCH_S3C2410 is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_DAVINCI is not set
 CONFIG_ARCH_OMAP=y
 
 #
@@ -137,6 +143,7 @@ CONFIG_ARCH_OMAP=y
 CONFIG_ARCH_OMAP_OTG=y
 # CONFIG_ARCH_OMAP1 is not set
 CONFIG_ARCH_OMAP2=y
+# CONFIG_ARCH_OMAP3 is not set
 
 #
 # OMAP Feature Selections
@@ -149,6 +156,8 @@ CONFIG_OMAP_MUX=y
 CONFIG_OMAP_MUX_WARNINGS=y
 # CONFIG_OMAP_STI is not set
 # CONFIG_OMAP_MCBSP is not set
+# CONFIG_OMAP_MMU_FWK is not set
+# CONFIG_OMAP_MBOX_FWK is not set
 # CONFIG_OMAP_MPU_TIMER is not set
 CONFIG_OMAP_32K_TIMER=y
 CONFIG_OMAP_32K_TIMER_HZ=128
@@ -170,9 +179,19 @@ CONFIG_ARCH_OMAP2420=y
 #
 # OMAP Board Type
 #
+# CONFIG_MACH_NOKIA_N800 is not set
 # CONFIG_MACH_OMAP_H4 is not set
-# CONFIG_MACH_OMAP_2430SDP is not set
 CONFIG_MACH_OMAP_APOLLON=y
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
@@ -182,10 +201,12 @@ CONFIG_CPU_V6=y
 # CONFIG_CPU_32v6K is not set
 CONFIG_CPU_32v6=y
 CONFIG_CPU_ABRT_EV6=y
+CONFIG_CPU_PABRT_NOIFAR=y
 CONFIG_CPU_CACHE_V6=y
 CONFIG_CPU_CACHE_VIPT=y
 CONFIG_CPU_COPY_V6=y
 CONFIG_CPU_TLB_V6=y
+CONFIG_CPU_HAS_ASID=y
 CONFIG_CPU_CP15=y
 CONFIG_CPU_CP15_MMU=y
 
@@ -195,12 +216,14 @@ CONFIG_CPU_CP15_MMU=y
 # CONFIG_ARM_THUMB is not set
 # CONFIG_CPU_ICACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_DISABLE is not set
-# CONFIG_CPU_DCACHE_WRITETHROUGH is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
+# CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
 #
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -210,8 +233,10 @@ CONFIG_CPU_CP15_MMU=y
 #
 # Kernel Features
 #
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
 CONFIG_PREEMPT=y
-CONFIG_NO_IDLE_HZ=y
 CONFIG_HZ=128
 # CONFIG_AEABI is not set
 # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
@@ -224,6 +249,9 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 # CONFIG_LEDS is not set
 CONFIG_ALIGNMENT_TRAP=y
 
@@ -234,6 +262,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/ram0 rw mem=128M console=ttyS0,115200n8 initrd=0x80600000,8M ramdisk_size=8192"
 # CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
 
 #
 # CPU Frequency scaling
@@ -263,7 +292,7 @@ CONFIG_BINFMT_ELF=y
 # Power management options
 #
 # CONFIG_PM is not set
-# CONFIG_APM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
 
 #
 # Networking
@@ -273,13 +302,13 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
@@ -312,20 +341,8 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
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
@@ -351,7 +368,17 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -364,16 +391,9 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
-
-#
-# Memory Technology Devices (MTD)
-#
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
 CONFIG_MTD_CONCAT=y
@@ -386,6 +406,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
 # User Modules And Translation Layers
 #
 CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
@@ -411,7 +432,6 @@ CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_OBSOLETE_CHIPS is not set
 
 #
 # Mapping drivers for chip access
@@ -435,38 +455,24 @@ CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
 # CONFIG_MTD_NAND is not set
-
-#
-# OneNAND Flash Device Drivers
-#
 CONFIG_MTD_ONENAND=y
 # CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
 CONFIG_MTD_ONENAND_GENERIC=y
+# CONFIG_MTD_ONENAND_OMAP2 is not set
 # CONFIG_MTD_ONENAND_OTP is not set
 
 #
-# Parallel port support
+# UBI - Unsorted block images
 #
+# CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
@@ -475,73 +481,31 @@ CONFIG_BLK_DEV_LOOP=y
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
 # CONFIG_SCSI_NETLINK is not set
-
-#
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
 # CONFIG_ATA is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
-#
-
-#
-# I2O device support
-#
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
-
-#
-# PHY device support
-#
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
+CONFIG_NETDEV_1000=y
+CONFIG_NETDEV_10000=y
 
 #
-# Ethernet (1000 Mbit)
-#
-
-#
-# Ethernet (10000 Mbit)
-#
-
-#
-# Token Ring devices
-#
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# Wan interfaces
+# Wireless LAN
 #
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
@@ -549,10 +513,6 @@ CONFIG_SMC91X=y
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
 
 #
@@ -560,6 +520,7 @@ CONFIG_SMC91X=y
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -579,6 +540,7 @@ CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set
 
@@ -617,15 +579,7 @@ CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
 CONFIG_WATCHDOG=y
 # CONFIG_WATCHDOG_NOWAYOUT is not set
 
@@ -636,20 +590,10 @@ CONFIG_WATCHDOG=y
 CONFIG_OMAP_WATCHDOG=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_OMAP=y
-# CONFIG_OMAP_RNG is not set
 # CONFIG_NVRAM is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
 # CONFIG_I2C is not set
 
 #
@@ -663,72 +607,73 @@ CONFIG_SPI_MASTER=y
 # SPI Master Controller Drivers
 #
 # CONFIG_SPI_BITBANG is not set
-# CONFIG_SPI_OMAP_UWIRE is not set
 CONFIG_SPI_OMAP24XX=y
 
 #
 # SPI Protocol Masters
 #
-# CONFIG_TSC2102 is not set
-
-#
-# Dallas's 1-wire bus
-#
+# CONFIG_SPI_AT25 is not set
+# CONFIG_SPI_TSC2101 is not set
+# CONFIG_SPI_TSC2102 is not set
+# CONFIG_SPI_TSC210X is not set
+# CONFIG_SPI_TSC2301 is not set
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
-
-#
-# Hardware Monitoring support
-#
 # CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
 
 #
-# Misc devices
-#
-# CONFIG_TIFM_CORE is not set
-
-#
-# LED devices
+# Multifunction device drivers
 #
+# CONFIG_MFD_SM501 is not set
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
+# CONFIG_DVB_CORE is not set
+CONFIG_DAB=y
 
 #
-# Digital Video Broadcasting Devices
+# Graphics support
 #
-# CONFIG_DVB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-# Graphics support
+# Display device support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
+CONFIG_FIRMWARE_EDID=y
+# CONFIG_FB_DDC is not set
 # CONFIG_FB_CFB_FILLRECT is not set
 # CONFIG_FB_CFB_COPYAREA is not set
 # CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
+# CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
 # CONFIG_FB_S1D13XXX is not set
-# CONFIG_FB_VIRTUAL is not set
 CONFIG_FB_OMAP=y
 # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
-# CONFIG_FB_OMAP_LCD_MIPID is not set
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
+# CONFIG_FB_VIRTUAL is not set
 
 #
 # Console display driver support
@@ -736,6 +681,7 @@ CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
 # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
@@ -748,29 +694,18 @@ CONFIG_FONT_8x16=y
 # CONFIG_FONT_SUN8x16 is not set
 # CONFIG_FONT_SUN12x22 is not set
 # CONFIG_FONT_10x18 is not set
-
-#
-# Logo configuration
-#
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_LOGO_LINUX_CLUT224=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
 #
 # CONFIG_SOUND is not set
-
-#
-# HID Devices
-#
+CONFIG_HID_SUPPORT=y
 # CONFIG_HID is not set
-
-#
-# USB support
-#
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 # CONFIG_USB_ARCH_HAS_EHCI is not set
@@ -786,14 +721,19 @@ CONFIG_USB_ARCH_HAS_OHCI=y
 # USB Gadget Support
 #
 CONFIG_USB_GADGET=y
+# CONFIG_USB_GADGET_DEBUG is not set
 # CONFIG_USB_GADGET_DEBUG_FILES is not set
 CONFIG_USB_GADGET_SELECTED=y
+# CONFIG_USB_GADGET_AMD5536UDC is not set
+# CONFIG_USB_GADGET_FSL_USB2 is not set
 # CONFIG_USB_GADGET_NET2280 is not set
 # CONFIG_USB_GADGET_PXA2XX is not set
+# CONFIG_USB_GADGET_M66592 is not set
 # CONFIG_USB_GADGET_GOKU is not set
 # CONFIG_USB_GADGET_LH7A40X is not set
 CONFIG_USB_GADGET_OMAP=y
 CONFIG_USB_OMAP=y
+# CONFIG_USB_GADGET_S3C2410 is not set
 # CONFIG_USB_GADGET_AT91 is not set
 # CONFIG_USB_GADGET_DUMMY_HCD is not set
 # CONFIG_USB_GADGET_DUALSPEED is not set
@@ -805,26 +745,35 @@ CONFIG_USB_FILE_STORAGE=m
 # CONFIG_USB_FILE_STORAGE_TEST is not set
 # CONFIG_USB_G_SERIAL is not set
 # CONFIG_USB_MIDI_GADGET is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
 
 #
-# MMC/SD Card support
+# MMC/SD Card Drivers
 #
-CONFIG_MMC=y
-# CONFIG_MMC_DEBUG is not set
 CONFIG_MMC_BLOCK=y
-CONFIG_MMC_OMAP=y
-# CONFIG_MMC_TIFM_SD is not set
+CONFIG_MMC_BLOCK_BOUNCE=y
 
 #
-# Real Time Clock
+# MMC/SD Host Controller Drivers
 #
+CONFIG_MMC_OMAP=y
 CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 
 #
-# Synchronous Serial Interfaces (SSI)
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
-# CONFIG_OMAP_TSC2101 is not set
 
 #
 # CBUS support
@@ -889,7 +838,6 @@ CONFIG_RAMFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS_FS is not set
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 CONFIG_JFFS2_FS_WRITEBUFFER=y
@@ -920,6 +868,7 @@ CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -927,7 +876,6 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -960,16 +908,20 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
-CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_DEBUG_SHIRQ is not set
 CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_DEBUG_PREEMPT=y
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
-# CONFIG_DEBUG_RWSEMS is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -980,6 +932,7 @@ CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_FRAME_POINTER=y
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
 # CONFIG_DEBUG_USER is not set
 # CONFIG_DEBUG_ERRORS is not set
 # CONFIG_DEBUG_LL is not set
@@ -989,10 +942,6 @@ CONFIG_FORCED_INLINING=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
 # CONFIG_CRYPTO is not set
 
 #
@@ -1001,9 +950,13 @@ CONFIG_FORCED_INLINING=y
 CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=y
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
-- 
1.5.3.1.91.gd3392
