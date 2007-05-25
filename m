From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: [PATCH] OMAP: def_config sync up
Date: Fri, 25 May 2007 17:27:40 -0500
Message-ID: <782515bb0705251527h4e6624ach26cadb273901e6c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Sync up the def config to the changes in the kernel. Enable common features

Signed-off-by: Nishanth Menon <menon.nishanth@gmail.com>
---
 arch/arm/configs/omap_2430sdp_defconfig |  258 ++++++++++++++++---------------
 1 files changed, 134 insertions(+), 124 deletions(-)

diff --git a/arch/arm/configs/omap_2430sdp_defconfig
b/arch/arm/configs/omap_2430sdp_defconfig
index 9ea2dc4..b9dfb0e 100644
--- a/arch/arm/configs/omap_2430sdp_defconfig
+++ b/arch/arm/configs/omap_2430sdp_defconfig
@@ -1,15 +1,18 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.21-rc5-omap1
-# Tue Apr 10 15:23:50 2007
+# Linux kernel version: 2.6.22-rc2-omap1
+# Fri May 25 15:47:55 2007
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_GENERIC_GPIO=y
 CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_MMU=y
 # CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_HARDIRQS=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_HARDIRQS_SW_RESEND=y
 CONFIG_GENERIC_IRQ_PROBE=y
@@ -46,6 +49,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -64,14 +68,19 @@ CONFIG_BUG=y
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

 #
 # Loadable module support
@@ -121,13 +130,14 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
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
 # CONFIG_ARCH_NS9XXX is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
@@ -136,6 +146,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_ARCH_S3C2410 is not set
 # CONFIG_ARCH_SHARK is not set
 # CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_DAVINCI is not set
 CONFIG_ARCH_OMAP=y

 #
@@ -196,6 +207,7 @@ CONFIG_CPU_CACHE_V6=y
 CONFIG_CPU_CACHE_VIPT=y
 CONFIG_CPU_COPY_V6=y
 CONFIG_CPU_TLB_V6=y
+CONFIG_CPU_HAS_ASID=y
 CONFIG_CPU_CP15=y
 CONFIG_CPU_CP15_MMU=y

@@ -212,6 +224,7 @@ CONFIG_ARM_THUMB=y
 #
 # Bus support
 #
+# CONFIG_ARCH_SUPPORTS_MSI is not set

 #
 # PCCARD (PCMCIA/CardBus) support
@@ -221,8 +234,10 @@ CONFIG_ARM_THUMB=y
 #
 # Kernel Features
 #
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
 CONFIG_PREEMPT=y
-# CONFIG_NO_IDLE_HZ is not set
 CONFIG_HZ=100
 CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
@@ -290,7 +305,6 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -370,7 +384,16 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
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

 #
 # Device Drivers
@@ -390,10 +413,6 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # Connector - unified userspace <-> kernelspace linker
 #
 # CONFIG_CONNECTOR is not set
-
-#
-# Memory Technology Devices (MTD)
-#
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
 CONFIG_MTD_CONCAT=y
@@ -438,7 +457,6 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_OBSOLETE_CHIPS is not set

 #
 # Mapping drivers for chip access
@@ -452,6 +470,8 @@ CONFIG_MTD_OMAP_NOR=y
 #
 # Self-contained MTD device drivers
 #
+# CONFIG_MTD_DATAFLASH is not set
+# CONFIG_MTD_M25P80 is not set
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
@@ -463,15 +483,7 @@ CONFIG_MTD_OMAP_NOR=y
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
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
 # CONFIG_MTD_ONENAND_GENERIC is not set
@@ -479,6 +491,11 @@ CONFIG_MTD_ONENAND_OMAP2=y
 # CONFIG_MTD_ONENAND_OTP is not set

 #
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+
+#
 # Parallel port support
 #
 # CONFIG_PARPORT is not set
@@ -529,6 +546,7 @@ CONFIG_CHR_DEV_SG=m
 # CONFIG_SCSI_CONSTANTS is not set
 # CONFIG_SCSI_LOGGING is not set
 # CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m

 #
 # SCSI Transports
@@ -544,10 +562,7 @@ CONFIG_CHR_DEV_SG=m
 #
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_SCSI_DEBUG is not set
-
-#
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
+# CONFIG_SCSI_ESP_CORE is not set
 # CONFIG_ATA is not set

 #
@@ -556,19 +571,6 @@ CONFIG_CHR_DEV_SG=m
 # CONFIG_MD is not set

 #
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
 # Network device support
 #
 CONFIG_NETDEVICES=y
@@ -576,10 +578,6 @@ CONFIG_NETDEVICES=y
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-
-#
-# PHY device support
-#
 # CONFIG_PHYLIB is not set

 #
@@ -589,27 +587,28 @@ CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 CONFIG_SMC91X=y
 # CONFIG_DM9000 is not set
-
-#
-# Ethernet (1000 Mbit)
-#
-
-#
-# Ethernet (10000 Mbit)
-#
+CONFIG_NETDEV_1000=y
+CONFIG_NETDEV_10000=y

 #
 # Token Ring devices
 #

 #
-# Wireless LAN (non-hamradio)
+# Wireless LAN
 #
-# CONFIG_NET_RADIO is not set
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set

 #
-# Wan interfaces
+# USB Network Adapters
 #
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET_MII is not set
+# CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
@@ -653,7 +652,19 @@ CONFIG_KEYBOARD_TWL4030=y
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
-# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_TABLET is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ADS7846=y
+# CONFIG_TOUCHSCREEN_GUNZE is not set
+# CONFIG_TOUCHSCREEN_ELO is not set
+# CONFIG_TOUCHSCREEN_MTOUCH is not set
+# CONFIG_TOUCHSCREEN_MK712 is not set
+# CONFIG_TOUCHSCREEN_PENMOUNT is not set
+# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
+# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
+# CONFIG_TOUCHSCREEN_UCB1400 is not set
+# CONFIG_TOUCHSCREEN_TSC2102 is not set
+# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
 # CONFIG_INPUT_MISC is not set

 #
@@ -696,10 +707,6 @@ CONFIG_UNIX98_PTYS=y
 # IPMI
 #
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
 CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_NOWAYOUT=y

@@ -716,7 +723,6 @@ CONFIG_OMAP_WATCHDOG=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_OMAP=y
 # CONFIG_NVRAM is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set

@@ -724,12 +730,9 @@ CONFIG_HW_RANDOM_OMAP=y
 # TPM devices
 #
 # CONFIG_TCG_TPM is not set
-
-#
-# I2C support
-#
 CONFIG_I2C=y
-# CONFIG_I2C_CHARDEV is not set
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y

 #
 # I2C Algorithms
@@ -741,11 +744,13 @@ CONFIG_I2C=y
 #
 # I2C Hardware Bus support
 #
+# CONFIG_I2C_GPIO is not set
 # CONFIG_I2C_OCORES is not set
 CONFIG_I2C_OMAP=y
 # CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_SIMTEC is not set
 # CONFIG_I2C_STUB is not set
-# CONFIG_I2C_PCA_ISA is not set
+# CONFIG_I2C_TINY_USB is not set

 #
 # Miscellaneous I2C Chip support
@@ -771,23 +776,35 @@ CONFIG_TWL4030_GPIO=y
 #
 # SPI support
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y

 #
-# Dallas's 1-wire bus
+# SPI Master Controller Drivers
 #
-# CONFIG_W1 is not set
+# CONFIG_SPI_BITBANG is not set
+# CONFIG_SPI_OMAP24XX is not set
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_AT25 is not set
+# CONFIG_SPI_TSC2101 is not set
+# CONFIG_SPI_TSC2102 is not set
+# CONFIG_SPI_TSC2301 is not set
+# CONFIG_SPI_SPIDEV is not set

 #
-# Hardware Monitoring support
+# Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 # CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set

 #
 # Misc devices
 #
+# CONFIG_BLINK is not set

 #
 # Multifunction device drivers
@@ -811,23 +828,31 @@ CONFIG_TWL4030_GPIO=y
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-
-#
-# Digital Video Broadcasting Devices
-#
-# CONFIG_DVB is not set
+# CONFIG_DVB_CORE is not set
+CONFIG_DAB=y
 # CONFIG_USB_DABUSB is not set

 #
 # Graphics support
 #
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 # CONFIG_FB_DDC is not set
 # CONFIG_FB_CFB_FILLRECT is not set
 # CONFIG_FB_CFB_COPYAREA is not set
 # CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_SYS_FOPS is not set
+CONFIG_FB_DEFERRED_IO=y
 # CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
@@ -835,12 +860,11 @@ CONFIG_FIRMWARE_EDID=y
 # CONFIG_FB_TILEBLITTING is not set

 #
-# Frambuffer hardware drivers
+# Frame buffer hardware drivers
 #
 # CONFIG_FB_S1D13XXX is not set
 CONFIG_FB_OMAP=y
 # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
-# CONFIG_FB_OMAP_LCD_MIPID is not set
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_FB_VIRTUAL is not set
@@ -855,10 +879,6 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 # CONFIG_FONTS is not set
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
-
-#
-# Logo configuration
-#
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
@@ -876,6 +896,20 @@ CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set

 #
+# USB Input Devices
+#
+CONFIG_USB_HID=m
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
+
+#
+# USB HID Boot Protocol drivers
+#
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
+
+#
 # USB support
 #
 CONFIG_USB_ARCH_HAS_HCD=y
@@ -888,6 +922,7 @@ CONFIG_USB=m
 # Miscellaneous USB options
 #
 # CONFIG_USB_DEVICEFS is not set
+# CONFIG_USB_DEVICE_CLASS is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
 CONFIG_USB_SUSPEND=y
 CONFIG_USB_OTG=y
@@ -943,47 +978,10 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_LIBUSUAL is not set

 #
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
-# CONFIG_USB_AIPTEK is not set
-# CONFIG_USB_WACOM is not set
-# CONFIG_USB_ACECAD is not set
-# CONFIG_USB_KBTAB is not set
-# CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_TOUCHSCREEN is not set
-# CONFIG_USB_YEALINK is not set
-# CONFIG_USB_XPAD is not set
-# CONFIG_USB_ATI_REMOTE is not set
-# CONFIG_USB_ATI_REMOTE2 is not set
-# CONFIG_USB_KEYSPAN_REMOTE is not set
-# CONFIG_USB_APPLETOUCH is not set
-# CONFIG_USB_GTCO is not set
-
-#
 # USB Imaging devices
 #
 # CONFIG_USB_MDC800 is not set
 # CONFIG_USB_MICROTEK is not set
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
 CONFIG_USB_MON=y

 #
@@ -1027,6 +1025,7 @@ CONFIG_USB_MON=y
 CONFIG_USB_GADGET=m
 CONFIG_USB_GADGET_DEBUG_FILES=y
 CONFIG_USB_GADGET_SELECTED=y
+# CONFIG_USB_GADGET_FSL_USB2 is not set
 # CONFIG_USB_GADGET_NET2280 is not set
 # CONFIG_USB_GADGET_PXA2XX is not set
 # CONFIG_USB_GADGET_GOKU is not set
@@ -1044,13 +1043,18 @@ CONFIG_USB_FILE_STORAGE=m
 # CONFIG_USB_FILE_STORAGE_TEST is not set
 CONFIG_USB_G_SERIAL=m
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
+
+#
+# MMC/SD Host Controller Drivers
+#
 CONFIG_MMC_OMAP=y

 #
@@ -1165,6 +1169,7 @@ CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -1194,6 +1199,7 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_SUN_PARTITION is not set
 # CONFIG_KARMA_PARTITION is not set
 # CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set

 #
 # Native Language Support
@@ -1260,7 +1266,6 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
-CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 CONFIG_TIMER_STATS=y
@@ -1270,6 +1275,8 @@ CONFIG_DEBUG_PREEMPT=y
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1313,6 +1320,7 @@ CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_PCBC=m
 # CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_CRYPTD is not set
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
@@ -1341,6 +1349,7 @@ CONFIG_CRYPTO_DES=y
 CONFIG_BITREVERSE=y
 CONFIG_CRC_CCITT=y
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
 CONFIG_LIBCRC32C=y
 CONFIG_ZLIB_INFLATE=y
@@ -1348,3 +1357,4 @@ CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
-- 
1.5.0.6
