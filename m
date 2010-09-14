From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Update omap3_defconfig for omap2
Date: Tue, 14 Sep 2010 12:05:08 -0700
Message-ID: <20100914190508.GI8647@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100906104413.GD20903@n2100.arm.linux.org.uk>
 <20100914185907.GG8647@atomide.com>
 <20100914190314.GH8647@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61924 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab0INTFT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 15:05:19 -0400
Content-Disposition: inline
In-Reply-To: <20100914190314.GH8647@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

We need to enable ARM_ERRATA_411920 for omap2 and
remove the omap2 specific defconfigs.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/configs/n8x0_defconfig b/arch/arm/configs/n8x0_defconfig
deleted file mode 100644
index 56aebb6..0000000
--- a/arch/arm/configs/n8x0_defconfig
+++ /dev/null
@@ -1,94 +0,0 @@
-CONFIG_EXPERIMENTAL=y
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_LBDAF is not set
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-CONFIG_ARCH_OMAP=y
-CONFIG_ARCH_OMAP2=y
-CONFIG_OMAP_RESET_CLOCKS=y
-# CONFIG_OMAP_MUX is not set
-# CONFIG_OMAP_MCBSP is not set
-CONFIG_OMAP_MBOX_FWK=y
-CONFIG_OMAP_32K_TIMER=y
-CONFIG_ARCH_OMAP2420=y
-CONFIG_MACH_NOKIA_N8X0=y
-CONFIG_AEABI=y
-CONFIG_LEDS=y
-CONFIG_ZBOOT_ROM_TEXT=0x10C08000
-CONFIG_ZBOOT_ROM_BSS=0x10200000
-CONFIG_CMDLINE="root=/dev/mmcblk0p2 console=ttyS2,115200n8 debug earlyprintk rootwait"
-CONFIG_FPE_NWFPE=y
-CONFIG_VFP=y
-CONFIG_PM=y
-CONFIG_PM_RUNTIME=y
-CONFIG_NET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-# CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_ONENAND=y
-CONFIG_MTD_ONENAND_OMAP2=y
-CONFIG_MTD_ONENAND_OTP=y
-CONFIG_BLK_DEV_RAM=y
-# CONFIG_MISC_DEVICES is not set
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
-# CONFIG_I2C_COMPAT is not set
-# CONFIG_I2C_HELPER_AUTO is not set
-CONFIG_I2C_OMAP=y
-CONFIG_SPI=y
-CONFIG_SPI_OMAP24XX=y
-# CONFIG_HWMON is not set
-CONFIG_MENELAUS=y
-CONFIG_REGULATOR=y
-# CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
-CONFIG_USB=y
-CONFIG_USB_DEBUG=y
-CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-CONFIG_USB_DEVICEFS=y
-CONFIG_USB_SUSPEND=y
-# CONFIG_USB_OTG_WHITELIST is not set
-CONFIG_USB_MUSB_HDRC=y
-CONFIG_USB_MUSB_OTG=y
-CONFIG_USB_GADGET_MUSB_HDRC=y
-# CONFIG_MUSB_PIO_ONLY is not set
-CONFIG_USB_MUSB_DEBUG=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_DEBUG=y
-CONFIG_USB_GADGET_DEBUG_FILES=y
-CONFIG_USB_ETH=m
-CONFIG_USB_ETH_EEM=y
-CONFIG_MMC=y
-CONFIG_MMC_OMAP=y
-CONFIG_EXT3_FS=y
-CONFIG_INOTIFY=y
-CONFIG_VFAT_FS=y
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_SUMMARY=y
-CONFIG_JFFS2_COMPRESSION_OPTIONS=y
-CONFIG_JFFS2_LZO=y
-CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO=y
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_ERRORS=y
-CONFIG_CRC_CCITT=y
diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap3_defconfig
index 833a9bc..d090503 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -53,6 +53,7 @@ CONFIG_MACH_SBC3530=y
 CONFIG_MACH_OMAP_3630SDP=y
 CONFIG_MACH_OMAP_4430SDP=y
 CONFIG_ARM_THUMBEE=y
+CONFIG_ARM_ERRATA_411920=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_SMP=y
diff --git a/arch/arm/configs/omap_generic_2420_defconfig b/arch/arm/configs/omap_generic_2420_defconfig
deleted file mode 100644
index ac08e51..0000000
--- a/arch/arm/configs/omap_generic_2420_defconfig
+++ /dev/null
@@ -1,37 +0,0 @@
-CONFIG_EXPERIMENTAL=y
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_OMAP=y
-CONFIG_ARCH_OMAP2=y
-# CONFIG_OMAP_MUX is not set
-CONFIG_MACH_OMAP_GENERIC=y
-CONFIG_ARCH_OMAP2420=y
-CONFIG_LEDS=y
-CONFIG_ZBOOT_ROM_TEXT=0x10C08000
-CONFIG_ZBOOT_ROM_BSS=0x10200000
-CONFIG_FPE_NWFPE=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_WATCHDOG=y
-CONFIG_WATCHDOG_NOWAYOUT=y
-CONFIG_VIDEO_OUTPUT_CONTROL=m
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_INOTIFY=y
-CONFIG_ROMFS_FS=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_ERRORS=y
-CONFIG_DEBUG_LL=y
-CONFIG_CRC_CCITT=y
