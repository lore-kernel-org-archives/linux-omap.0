From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP2: Update N800 defconfig
Date: Sun, 04 Mar 2007 11:29:27 +0100
Message-ID: <45EA9F87.6090300@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020909040508020303040809"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------020909040508020303040809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Update N800 defconfig, mainly to disable netfilter which
doesn't compile:

    CC      net/ipv4/netfilter/ipt_IDLETIMER.o
net/ipv4/netfilter/ipt_IDLETIMER.c: In function 'utimer_work':
net/ipv4/netfilter/ipt_IDLETIMER.c:80: error: 'struct
net_device' has no member named 'class_dev'
net/ipv4/netfilter/ipt_IDLETIMER.c: In function
'utimer_notifier_call':
net/ipv4/netfilter/ipt_IDLETIMER.c:187: error: 'struct
net_device' has no member named 'class_dev'
net/ipv4/netfilter/ipt_IDLETIMER.c:192: error: 'struct
net_device' has no member named 'class_dev'
net/ipv4/netfilter/ipt_IDLETIMER.c: At top level:
net/ipv4/netfilter/ipt_IDLETIMER.c:276: warning:
initialization from incompatible pointer type
net/ipv4/netfilter/ipt_IDLETIMER.c:277: warning:
initialization from incompatible pointer type
net/ipv4/netfilter/ipt_IDLETIMER.c: In function 'init':
net/ipv4/netfilter/ipt_IDLETIMER.c:290: warning: implicit
declaration of function 'ipt_register_target'
net/ipv4/netfilter/ipt_IDLETIMER.c: In function 'fini':
net/ipv4/netfilter/ipt_IDLETIMER.c:300: warning: implicit
declaration of function 'ipt_unregister_target'

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>



--------------020909040508020303040809
Content-Type: text/x-patch;
 name="n800_defconfig_disable_netfilter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="n800_defconfig_disable_netfilter.patch"

Index: linux-osk/arch/arm/configs/n800_defconfig
===================================================================
--- linux-osk.orig/arch/arm/configs/n800_defconfig
+++ linux-osk/arch/arm/configs/n800_defconfig
@@ -1,11 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc5-omap1
-# Wed Jan 17 17:19:12 2007
+# Linux kernel version: 2.6.21-rc2-omap1
+# Sun Mar  4 11:17:38 2007
 #
 CONFIG_ARM=y
-CONFIG_GENERIC_TIME=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+# CONFIG_GENERIC_TIME is not set
 CONFIG_MMU=y
+# CONFIG_NO_IOPORT is not set
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 CONFIG_HARDIRQS_SW_RESEND=y
@@ -15,6 +17,7 @@ CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_ZONE_DMA=y
 CONFIG_VECTORS_BASE=0xffff0000
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
@@ -33,6 +36,7 @@ CONFIG_LOCALVERSION=""
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
@@ -120,6 +124,7 @@ CONFIG_DEFAULT_IOSCHED="noop"
 # CONFIG_ARCH_IXP2000 is not set
 # CONFIG_ARCH_IXP23XX is not set
 # CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_NS9XXX is not set
 # CONFIG_ARCH_PNX4008 is not set
 # CONFIG_ARCH_PXA is not set
 # CONFIG_ARCH_RPC is not set
@@ -200,6 +205,7 @@ CONFIG_ARM_THUMB=y
 # CONFIG_CPU_DCACHE_DISABLE is not set
 # CONFIG_CPU_DCACHE_WRITETHROUGH is not set
 # CONFIG_CPU_BPREDICT_DISABLE is not set
+# CONFIG_OUTER_CACHE is not set
 
 #
 # Bus support
@@ -228,9 +234,8 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
 CONFIG_LEDS=y
-# CONFIG_LEDS_TIMER is not set
-# CONFIG_LEDS_CPU is not set
 CONFIG_ALIGNMENT_TRAP=y
 
 #
@@ -241,6 +246,7 @@ CONFIG_ZBOOT_ROM_BSS=0x10200000
 # CONFIG_ZBOOT_ROM is not set
 CONFIG_CMDLINE="root=1f03 rootfstype=jffs2"
 # CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
 
 #
 # CPU Frequency scaling
@@ -273,7 +279,7 @@ CONFIG_PM=y
 # CONFIG_PM_LEGACY is not set
 # CONFIG_PM_DEBUG is not set
 # CONFIG_PM_SYSFS_DEPRECATED is not set
-# CONFIG_APM is not set
+# CONFIG_APM_EMULATION is not set
 
 #
 # Networking
@@ -290,6 +296,7 @@ CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -315,72 +322,12 @@ CONFIG_INET_TCP_DIAG=y
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
-
-#
-# IP: Virtual Server Configuration
-#
-# CONFIG_IP_VS is not set
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETLABEL is not set
 # CONFIG_NETWORK_SECMARK is not set
-CONFIG_NETFILTER=y
-# CONFIG_NETFILTER_DEBUG is not set
-
-#
-# Core Netfilter Configuration
-#
-CONFIG_NETFILTER_NETLINK=y
-# CONFIG_NETFILTER_NETLINK_QUEUE is not set
-# CONFIG_NETFILTER_NETLINK_LOG is not set
-# CONFIG_NF_CONNTRACK_ENABLED is not set
-CONFIG_NETFILTER_XTABLES=y
-# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
-# CONFIG_NETFILTER_XT_TARGET_MARK is not set
-# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
-# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
-# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
-# CONFIG_NETFILTER_XT_MATCH_DCCP is not set
-# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
-# CONFIG_NETFILTER_XT_MATCH_ESP is not set
-# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
-# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
-# CONFIG_NETFILTER_XT_MATCH_MAC is not set
-# CONFIG_NETFILTER_XT_MATCH_MARK is not set
-# CONFIG_NETFILTER_XT_MATCH_POLICY is not set
-# CONFIG_NETFILTER_XT_MATCH_MULTIPORT is not set
-# CONFIG_NETFILTER_XT_MATCH_PKTTYPE is not set
-# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
-# CONFIG_NETFILTER_XT_MATCH_REALM is not set
-# CONFIG_NETFILTER_XT_MATCH_SCTP is not set
-# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
-# CONFIG_NETFILTER_XT_MATCH_STRING is not set
-# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
-# CONFIG_NETFILTER_XT_MATCH_HASHLIMIT is not set
-
-#
-# IP: Netfilter Configuration
-#
-# CONFIG_IP_NF_QUEUE is not set
-CONFIG_IP_NF_IPTABLES=y
-# CONFIG_IP_NF_MATCH_IPRANGE is not set
-# CONFIG_IP_NF_MATCH_TOS is not set
-# CONFIG_IP_NF_MATCH_RECENT is not set
-# CONFIG_IP_NF_MATCH_ECN is not set
-# CONFIG_IP_NF_MATCH_AH is not set
-# CONFIG_IP_NF_MATCH_TTL is not set
-# CONFIG_IP_NF_MATCH_OWNER is not set
-# CONFIG_IP_NF_MATCH_ADDRTYPE is not set
-CONFIG_IP_NF_FILTER=y
-# CONFIG_IP_NF_TARGET_REJECT is not set
-# CONFIG_IP_NF_TARGET_LOG is not set
-# CONFIG_IP_NF_TARGET_ULOG is not set
-# CONFIG_IP_NF_TARGET_TCPMSS is not set
-CONFIG_IP_NF_TARGET_IDLETIMER=y
-# CONFIG_IP_NF_MANGLE is not set
-# CONFIG_IP_NF_RAW is not set
-# CONFIG_IP_NF_ARPTABLES is not set
+# CONFIG_NETFILTER is not set
 
 #
 # DCCP Configuration (EXPERIMENTAL)
@@ -453,6 +400,7 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
@@ -475,6 +423,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
 # User Modules And Translation Layers
 #
 CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
@@ -547,6 +496,7 @@ CONFIG_MTD_ONENAND_OTP=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
@@ -739,7 +689,6 @@ CONFIG_INPUT_TOUCHSCREEN=y
 # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
 # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
 # CONFIG_TOUCHSCREEN_UCB1400 is not set
-# CONFIG_TOUCHSCREEN_TSC2102 is not set
 # CONFIG_INPUT_MISC is not set
 
 #
@@ -870,6 +819,7 @@ CONFIG_SPI_OMAP24XX=y
 # SPI Protocol Masters
 #
 # CONFIG_TSC2102 is not set
+# CONFIG_SPI_AT25 is not set
 
 #
 # Dallas's 1-wire bus
@@ -885,6 +835,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
 # CONFIG_SENSORS_ADM1031 is not set
 # CONFIG_SENSORS_ADM9240 is not set
 # CONFIG_SENSORS_ASB100 is not set
@@ -926,7 +877,11 @@ CONFIG_HWMON=y
 #
 # Misc devices
 #
-# CONFIG_TIFM_CORE is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
 
 #
 # LED devices
@@ -965,7 +920,6 @@ CONFIG_VIDEO_V4L2=y
 #
 # CONFIG_VIDEO_ADV_DEBUG is not set
 CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
-# CONFIG_VIDEO_VIVI is not set
 # CONFIG_VIDEO_SAA5246A is not set
 # CONFIG_VIDEO_SAA5249 is not set
 
@@ -990,20 +944,28 @@ CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
 # CONFIG_FB_CFB_FILLRECT is not set
 # CONFIG_FB_CFB_COPYAREA is not set
 # CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frambuffer hardware drivers
+#
 # CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_VIRTUAL is not set
 CONFIG_FB_OMAP=y
 CONFIG_FB_OMAP_LCDC_EXTERNAL=y
 # CONFIG_FB_OMAP_LCDC_HWA742 is not set
+# CONFIG_FB_OMAP_LCDC_BLIZZARD is not set
 CONFIG_FB_OMAP_MANUAL_UPDATE=y
 CONFIG_FB_OMAP_LCD_MIPID=y
 CONFIG_FB_OMAP_BOOTLOADER_INIT=y
@@ -1020,7 +982,6 @@ CONFIG_DUMMY_CONSOLE=y
 # Logo configuration
 #
 # CONFIG_LOGO is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -1063,6 +1024,11 @@ CONFIG_SND_SUPPORT_OLD_API=y
 # CONFIG_SND_USB_AUDIO is not set
 
 #
+# SoC audio support
+#
+# CONFIG_SND_SOC is not set
+
+#
 # Open Sound System
 #
 # CONFIG_SOUND_PRIME is not set
@@ -1071,6 +1037,7 @@ CONFIG_SND_SUPPORT_OLD_API=y
 # HID Devices
 #
 CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
 
 #
 # USB support
@@ -1085,10 +1052,8 @@ CONFIG_USB_DEBUG=y
 # Miscellaneous USB options
 #
 CONFIG_USB_DEVICEFS=y
-# CONFIG_USB_BANDWIDTH is not set
 CONFIG_USB_DYNAMIC_MINORS=y
 CONFIG_USB_SUSPEND=y
-# CONFIG_USB_MULTITHREAD_PROBE is not set
 CONFIG_USB_OTG=y
 CONFIG_USB_OTG_WHITELIST=y
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
@@ -1157,6 +1122,7 @@ CONFIG_USB_HID=y
 # CONFIG_USB_ATI_REMOTE2 is not set
 # CONFIG_USB_KEYSPAN_REMOTE is not set
 # CONFIG_USB_APPLETOUCH is not set
+# CONFIG_USB_GTCO is not set
 
 #
 # USB Imaging devices
@@ -1174,6 +1140,7 @@ CONFIG_USB_RTL8150=y
 # CONFIG_USB_USBNET_MII is not set
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_CDCETHER=y
+# CONFIG_USB_NET_DM9601 is not set
 # CONFIG_USB_NET_GL620A is not set
 CONFIG_USB_NET_NET1080=y
 CONFIG_USB_NET_PLUSB=y
@@ -1185,6 +1152,7 @@ CONFIG_USB_NET_CDC_SUBSET=y
 CONFIG_USB_BELKIN=y
 CONFIG_USB_ARMLINUX=y
 # CONFIG_USB_EPSON2888 is not set
+# CONFIG_USB_KC2190 is not set
 CONFIG_USB_NET_ZAURUS=y
 CONFIG_USB_MON=y
 
@@ -1207,6 +1175,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
@@ -1216,6 +1185,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_APPLEDISPLAY is not set
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1256,11 +1226,6 @@ CONFIG_RTC_LIB=y
 # CONFIG_RTC_CLASS is not set
 
 #
-# Synchronous Serial Interfaces (SSI)
-#
-# CONFIG_OMAP_TSC2101 is not set
-
-#
 # CBUS support
 #
 CONFIG_CBUS=y
@@ -1444,15 +1409,16 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_MUTEXES is not set
-# CONFIG_DEBUG_RWSEMS is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1463,6 +1429,7 @@ CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_FRAME_POINTER=y
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_ERRORS=y
 # CONFIG_DEBUG_LL is not set
@@ -1492,4 +1459,5 @@ CONFIG_CRC32=y
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y


--------------020909040508020303040809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020909040508020303040809--
