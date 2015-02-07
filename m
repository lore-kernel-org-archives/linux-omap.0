From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: omap1_defconfig: drop obsolete Kconfig symbols
Date: Sat, 7 Feb 2015 00:25:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1502070024030.3767@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, stefan.hengelein@fau.de, valentinrothberg@gmail.com, pebolle@tiscali.nl
List-Id: linux-omap@vger.kernel.org


scripts/checkkconfigsymbols.py indicates that omap1_defconfig
references the following obsolete Kconfig symbols:

CONFIG_BT_L2CAP
CONFIG_BT_SCO
CONFIG_DEBUG_ERRORS
CONFIG_EXPERIMENTAL
CONFIG_FB_OMAP_BOOTLOADER_INIT
CONFIG_LEDS_CPU
CONFIG_MACH_OMAP_HTCWIZARD
CONFIG_MTD_CHAR
CONFIG_MTD_DEBUG
CONFIG_MTD_DEBUG_VERBOSE
CONFIG_MTD_PARTITIONS
CONFIG_NET_ETHERNET
CONFIG_RCU_CPU_STALL_DETECTOR
CONFIG_SCSI_MULTI_LUN
CONFIG_USB_DEVICE_CLASS
CONFIG_VIDEO_OUTPUT_CONTROL

Drop them from omap1_defconfig.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Paul Bolle <pebolle@tiscali.nl>
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
Cc: Stefan Hengelein <stefan.hengelein@fau.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
---

Non-critical.  Targeted for v3.20-rc1 or v3.21-rc1.

I'm unable to boot test it since I don't have any OMAP1 devices currently 
active in the testbed, but it least compiles and deals with the Kconfig
checker warnings:

http://www.pwsan.com/omap/testlogs/fix-omap-warnings-v3.21/20150206154619/

 arch/arm/configs/omap1_defconfig | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index a7dce674f1be..0c8a78734536 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -1,4 +1,3 @@
-CONFIG_EXPERIMENTAL=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -34,7 +33,6 @@ CONFIG_ARCH_OMAP16XX=y
 CONFIG_MACH_OMAP_INNOVATOR=y
 CONFIG_MACH_OMAP_H2=y
 CONFIG_MACH_OMAP_H3=y
-CONFIG_MACH_OMAP_HTCWIZARD=y
 CONFIG_MACH_HERALD=y
 CONFIG_MACH_OMAP_OSK=y
 CONFIG_MACH_OMAP_PERSEUS2=y
@@ -55,7 +53,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_LEDS=y
-CONFIG_LEDS_CPU=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=1f03 rootfstype=jffs2"
@@ -80,8 +77,6 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_IPV6=y
 CONFIG_NETFILTER=y
 CONFIG_BT=y
-CONFIG_BT_L2CAP=y
-CONFIG_BT_SCO=y
 CONFIG_BT_RFCOMM=y
 CONFIG_BT_RFCOMM_TTY=y
 CONFIG_BT_BNEP=y
@@ -92,11 +87,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
 # CONFIG_PROC_EVENTS is not set
 CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
-CONFIG_MTD_DEBUG_VERBOSE=3
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
@@ -113,11 +104,9 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
-CONFIG_SCSI_MULTI_LUN=y
 CONFIG_NETDEVICES=y
 CONFIG_TUN=y
 CONFIG_PHYLIB=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
 CONFIG_USB_CATC=y
 CONFIG_USB_KAWETH=y
@@ -158,7 +147,6 @@ CONFIG_SPI_OMAP_UWIRE=y
 CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_NOWAYOUT=y
 CONFIG_OMAP_WATCHDOG=y
-CONFIG_VIDEO_OUTPUT_CONTROL=y
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
@@ -168,7 +156,6 @@ CONFIG_FB_OMAP_LCDC_EXTERNAL=y
 CONFIG_FB_OMAP_LCDC_HWA742=y
 CONFIG_FB_OMAP_MANUAL_UPDATE=y
 CONFIG_FB_OMAP_LCD_MIPID=y
-CONFIG_FB_OMAP_BOOTLOADER_INIT=y
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
@@ -194,7 +181,6 @@ CONFIG_SND_OMAP_SOC=y
 # CONFIG_USB_HID is not set
 CONFIG_USB=y
 CONFIG_USB_PHY=y
-# CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_MON=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_STORAGE=y
@@ -261,9 +247,7 @@ CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_ERRORS=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
-- 
2.1.4
