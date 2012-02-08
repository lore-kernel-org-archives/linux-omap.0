From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] ARM: OMAP: update omap1 and omap2plus defconfigs
Date: Wed,  8 Feb 2012 12:16:13 +0200
Message-ID: <1328696173-17226-1-git-send-email-grinberg@compulab.co.il>
References: <20120208053556.GB1426@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:35104
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753428Ab2BHKQe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 05:16:34 -0500
In-Reply-To: <20120208053556.GB1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

This patch updates omapX_defconfig to 3.3-rc1 and enables
the CONFIG_DEBUG_SECTION_MISMATCH.

The update is done by:
1) make mrproper && make omapX_defconfig
2) Enable the CONFIG_DEBUG_SECTION_MISMATCH
3) make savedefconfig
4) cp defconfig arch/arm/configs/omapX_defconfig

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
After updating omap1_defconfig,
there are several section mismatch warnings seen.
Hopefully, I will have time to fix those tomorrow
(unless someone will be kind enough to fix them before me).
The mismatches are:

WARNING: vmlinux.o(.data+0xb7e4): Section mismatch in reference from
the variable latch1_gpio_device to the (unknown reference) .init.rodata:(unknown)
The variable latch1_gpio_device references
the (unknown reference) __initconst (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: vmlinux.o(.data+0xb8f4): Section mismatch in reference from
the variable latch1_gpio_device to the (unknown reference) .init.rodata:(unknown)
The variable latch1_gpio_device references
the (unknown reference) __initconst (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: vmlinux.o(.data+0xb974): Section mismatch in reference from
the variable latch2_gpio_device to the (unknown reference) .init.rodata:(unknown)
The variable latch2_gpio_device references
the (unknown reference) __initconst (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: vmlinux.o(.data+0xba84): Section mismatch in reference from
the variable latch2_gpio_device to the (unknown reference) .init.rodata:(unknown)
The variable latch2_gpio_device references
the (unknown reference) __initconst (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

WARNING: vmlinux.o(.data+0xbb04): Section mismatch in reference from
the variable ams_delta_kp_device to the (unknown reference) .init.data:(unknown)
The variable ams_delta_kp_device references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console


 arch/arm/configs/omap1_defconfig     |   35 +++++++++++----------------------
 arch/arm/configs/omap2plus_defconfig |   25 ++++++++---------------
 2 files changed, 21 insertions(+), 39 deletions(-)

diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index dde2a1a..1122156 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -20,6 +20,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_OMAP=y
@@ -27,7 +28,6 @@ CONFIG_ARCH_OMAP1=y
 CONFIG_OMAP_RESET_CLOCKS=y
 # CONFIG_OMAP_MUX is not set
 CONFIG_OMAP_MBOX_FWK=y
-CONFIG_OMAP_32K_TIMER=y
 CONFIG_OMAP_DM_TIMER=y
 CONFIG_ARCH_OMAP730=y
 CONFIG_ARCH_OMAP850=y
@@ -62,7 +62,6 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=1f03 rootfstype=jffs2"
 CONFIG_FPE_NWFPE=y
 CONFIG_BINFMT_MISC=y
-CONFIG_PM=y
 # CONFIG_SUSPEND is not set
 CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
@@ -82,8 +81,6 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_IPV6=y
 CONFIG_NETFILTER=y
 CONFIG_BT=y
-CONFIG_BT_L2CAP=y
-CONFIG_BT_SCO=y
 CONFIG_BT_RFCOMM=y
 CONFIG_BT_RFCOMM_TTY=y
 CONFIG_BT_BNEP=y
@@ -94,9 +91,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=y
 # CONFIG_PROC_EVENTS is not set
 CONFIG_MTD=y
-CONFIG_MTD_DEBUG=y
-CONFIG_MTD_DEBUG_VERBOSE=3
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
@@ -118,9 +112,16 @@ CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_NETDEVICES=y
 CONFIG_TUN=y
-CONFIG_PHYLIB=y
-CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
+CONFIG_PHYLIB=y
+CONFIG_PPP=y
+CONFIG_PPP_BSDCOMP=y
+CONFIG_PPP_DEFLATE=y
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPP_ASYNC=y
+CONFIG_SLIP=y
+CONFIG_SLIP_COMPRESSED=y
 CONFIG_USB_CATC=y
 CONFIG_USB_KAWETH=y
 CONFIG_USB_PEGASUS=y
@@ -128,14 +129,6 @@ CONFIG_USB_RTL8150=y
 CONFIG_USB_USBNET=y
 # CONFIG_USB_NET_AX8817X is not set
 # CONFIG_USB_NET_CDC_SUBSET is not set
-CONFIG_PPP=y
-CONFIG_PPP_MULTILINK=y
-CONFIG_PPP_FILTER=y
-CONFIG_PPP_ASYNC=y
-CONFIG_PPP_DEFLATE=y
-CONFIG_PPP_BSDCOMP=y
-CONFIG_SLIP=y
-CONFIG_SLIP_COMPRESSED=y
 # CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_EVBUG=y
@@ -146,11 +139,11 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_UINPUT=y
 # CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=3
 CONFIG_SERIAL_8250_RUNTIME_UARTS=3
-# CONFIG_LEGACY_PTYS is not set
 CONFIG_HW_RANDOM=y
 CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
@@ -247,7 +240,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_CODEPAGE_852=y
@@ -261,16 +253,13 @@ CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_UTF8=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_ERRORS=y
 CONFIG_SECURITY=y
-CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_DEFLATE=y
 CONFIG_CRYPTO_ZLIB=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d5f00d7..e2e30ef 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -7,8 +7,6 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-# CONFIG_SYSCTL_SYSCALL is not set
-CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
@@ -20,6 +18,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_OMAP=y
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_MUX_DEBUG=y
@@ -87,21 +86,20 @@ CONFIG_SCSI_MULTI_LUN=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_MD=y
 CONFIG_NETDEVICES=y
-CONFIG_SMSC_PHY=y
-CONFIG_NET_ETHERNET=y
-CONFIG_SMC91X=y
-CONFIG_SMSC911X=y
 CONFIG_KS8851=y
 CONFIG_KS8851_MLL=y
-CONFIG_LIBERTAS=m
-CONFIG_LIBERTAS_USB=m
-CONFIG_LIBERTAS_SDIO=m
-CONFIG_LIBERTAS_DEBUG=y
+CONFIG_SMC91X=y
+CONFIG_SMSC911X=y
+CONFIG_SMSC_PHY=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_ALI_M5632=y
 CONFIG_USB_AN2720=y
 CONFIG_USB_EPSON2888=y
 CONFIG_USB_KC2190=y
+CONFIG_LIBERTAS=m
+CONFIG_LIBERTAS_USB=m
+CONFIG_LIBERTAS_SDIO=m
+CONFIG_LIBERTAS_DEBUG=y
 CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
@@ -137,7 +135,6 @@ CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
-CONFIG_FB_OMAP_LCD_VGA=y
 CONFIG_OMAP2_DSS=m
 CONFIG_OMAP2_DSS_RFBI=y
 CONFIG_OMAP2_DSS_SDI=y
@@ -152,7 +149,6 @@ CONFIG_PANEL_ACX565AKM=m
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=y
-CONFIG_DISPLAY_SUPPORT=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_FONTS=y
@@ -213,19 +209,16 @@ CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
-CONFIG_PARTITION_ADVANCED=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_SCHEDSTATS=y
 CONFIG_TIMER_STATS=y
 CONFIG_PROVE_LOCKING=y
-CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_MICHAEL_MIC=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-- 
1.7.3.4

