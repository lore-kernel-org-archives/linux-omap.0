From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH RFC -next] omap: fix omap2plus_defconfig build
Date: Sat,  4 Dec 2010 00:01:34 +0530
Message-ID: <1291401094-31052-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33127 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab0LCSbp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 13:31:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-next@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

Having CONFIG_SWP_EMULATE causes the build of omap2plus_defconfig
to fail as below:

  CC      arch/arm/kernel/swp_emulate.o
/tmp/ccCx8SX8.s: Assembler messages:
/tmp/ccCx8SX8.s:339: Error: selected processor does not support ARM mode `ldrexb r7,[r6]'
/tmp/ccCx8SX8.s:340: Error: selected processor does not support ARM mode `strexb r3,r2,[r6]'
make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
make: *** [arch/arm/kernel] Error 2

While a proper fix is being found, work around it by turning off
the config option in the defconfig.

While at it, make savedefconfig trimmed a few lines.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
1. The issue has been discussed here:
http://marc.info/?t=128748412500003&r=1&w=2

It's been around for a couple of months now.
The last status was that maybe the toolchain should be fixed.

I'm afraid I don't know how to fix this properly, so I'm
hoping we can live with a workaround like this...

2. An alternative patch is this one:
http://marc.info/?l=linux-arm-kernel&m=128748874510144&w=2

3. Not sure if this should have been combined with the other noise
from make savedefconfig - maybe I should have hand-edited the
old defconfig to add one line.

 arch/arm/configs/omap2plus_defconfig |   68 ++++-------------------------------
 1 file changed, 8 insertions(+), 60 deletions(-)

Index: mainline/arch/arm/configs/omap2plus_defconfig
===================================================================
--- mainline.orig/arch/arm/configs/omap2plus_defconfig
+++ mainline/arch/arm/configs/omap2plus_defconfig
@@ -21,57 +21,23 @@ CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_OMAP=y
-CONFIG_ARCH_OMAP2=y
-CONFIG_ARCH_OMAP3=y
-CONFIG_ARCH_OMAP4=y
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_MUX_DEBUG=y
-CONFIG_OMAP_32K_TIMER=y
-CONFIG_MACH_OMAP_GENERIC=y
-CONFIG_ARCH_OMAP2420=y
-CONFIG_ARCH_OMAP2430=y
-CONFIG_ARCH_OMAP3430=y
-CONFIG_MACH_OMAP_H4=y
-CONFIG_MACH_OMAP_APOLLON=y
-CONFIG_MACH_OMAP_2430SDP=y
-CONFIG_MACH_OMAP3_BEAGLE=y
-CONFIG_MACH_DEVKIT8000=y
-CONFIG_MACH_OMAP_LDP=y
-CONFIG_MACH_OVERO=y
-CONFIG_MACH_OMAP3EVM=y
-CONFIG_MACH_OMAP3517EVM=y
-CONFIG_MACH_OMAP3_PANDORA=y
-CONFIG_MACH_OMAP3_TOUCHBOOK=y
-CONFIG_MACH_OMAP_3430SDP=y
-CONFIG_MACH_NOKIA_N8X0=y
-CONFIG_MACH_NOKIA_RX51=y
-CONFIG_MACH_OMAP_ZOOM2=y
-CONFIG_MACH_OMAP_ZOOM3=y
-CONFIG_MACH_CM_T35=y
-CONFIG_MACH_IGEP0020=y
-CONFIG_MACH_SBC3530=y
-CONFIG_MACH_OMAP_3630SDP=y
-CONFIG_MACH_OMAP_4430SDP=y
 CONFIG_ARM_THUMBEE=y
-CONFIG_ARM_L1_CACHE_SHIFT=5
+# CONFIG_SWP_EMULATE is not set
 CONFIG_ARM_ERRATA_411920=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_SMP=y
 # CONFIG_LOCAL_TIMERS is not set
-CONFIG_AEABI=y
 CONFIG_LEDS=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyO2,115200"
 CONFIG_KEXEC=y
 CONFIG_FPE_NWFPE=y
-CONFIG_VFP=y
-CONFIG_NEON=y
 CONFIG_BINFMT_MISC=y
-CONFIG_PM=y
 CONFIG_PM_DEBUG=y
-CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -90,7 +56,7 @@ CONFIG_NETFILTER=y
 CONFIG_BT=m
 CONFIG_BT_L2CAP=m
 CONFIG_BT_SCO=m
-CONFIG_BT_RFCOMM=y
+CONFIG_BT_RFCOMM=m
 CONFIG_BT_RFCOMM_TTY=y
 CONFIG_BT_BNEP=m
 CONFIG_BT_BNEP_MC_FILTER=y
@@ -126,7 +92,6 @@ CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
-CONFIG_EEPROM_LEGACY=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
@@ -157,8 +122,6 @@ CONFIG_TOUCHSCREEN_ADS7846=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_TWL4030_PWRBUTTON=y
 CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=32
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
@@ -167,9 +130,7 @@ CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_HW_RANDOM=y
-CONFIG_I2C=y
 CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_OMAP=y
 CONFIG_SPI=y
 CONFIG_SPI_OMAP24XX=y
 CONFIG_DEBUG_GPIO=y
@@ -180,10 +141,6 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_WATCHDOG=y
 CONFIG_OMAP_WATCHDOG=y
 CONFIG_TWL4030_WATCHDOG=y
-CONFIG_MENELAUS=y
-CONFIG_TWL4030_CORE=y
-CONFIG_TWL4030_POWER=y
-CONFIG_REGULATOR=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
@@ -196,7 +153,6 @@ CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=y
 CONFIG_DISPLAY_SUPPORT=y
-# CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_FONTS=y
@@ -205,25 +161,20 @@ CONFIG_FONT_8x16=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_SND=m
-CONFIG_SND_MIXER_OSS=y
-CONFIG_SND_PCM_OSS=y
+CONFIG_SND_MIXER_OSS=m
+CONFIG_SND_PCM_OSS=m
 CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
-CONFIG_SND_USB_AUDIO=y
-CONFIG_SND_SOC=y
-CONFIG_SND_OMAP_SOC=y
-CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=y
+CONFIG_SND_USB_AUDIO=m
+CONFIG_SND_SOC=m
+CONFIG_SND_OMAP_SOC=m
+CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
 CONFIG_USB=y
 CONFIG_USB_DEBUG=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_SUSPEND=y
-# CONFIG_USB_OTG_WHITELIST is not set
 CONFIG_USB_MON=y
-# CONFIG_USB_MUSB_HDRC is not set
-# CONFIG_USB_MUSB_OTG is not set
-# CONFIG_USB_GADGET_MUSB_HDRC is not set
-CONFIG_USB_MUSB_DEBUG=y
 CONFIG_USB_WDM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_LIBUSUAL=y
@@ -249,7 +200,6 @@ CONFIG_RTC_DRV_TWL4030=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-CONFIG_INOTIFY=y
 CONFIG_QUOTA=y
 CONFIG_QFMT_V2=y
 CONFIG_MSDOS_FS=y
@@ -273,12 +223,10 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_SCHEDSTATS=y
 CONFIG_TIMER_STATS=y
 CONFIG_PROVE_LOCKING=y
-# CONFIG_LOCK_STAT is not set
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
