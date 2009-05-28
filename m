From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 01/06] OMAP3: PM: Update omap_3430sdp_pm_defconfig
Date: Thu, 28 May 2009 18:13:02 +0530
Message-ID: <1243514587-5323-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41544 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758300AbZE1MnO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 08:43:14 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4SCh9KG004743
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2009 07:43:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch disables OMAP FB driver from the pm defconfig
for SDP as it seems to gate sleep and throw some irq errors
omapfb omapfb: irq error status 0062
omapfb omapfb: irq error status 00c2
omapfb omapfb: irq error status 0060

Also ondemand CPUFreq governor support is enabled.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/configs/omap_3430sdp_pm_defconfig |   38 +--------------------------
 1 files changed, 2 insertions(+), 36 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_pm_defconfig b/arch/arm/configs/omap_3430sdp_pm_defconfig
index e06fea5..aefdb5b 100644
--- a/arch/arm/configs/omap_3430sdp_pm_defconfig
+++ b/arch/arm/configs/omap_3430sdp_pm_defconfig
@@ -315,7 +315,7 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 # CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
 # CONFIG_CPU_FREQ_GOV_USERSPACE is not set
-# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 # CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
 CONFIG_CPU_IDLE=y
 CONFIG_CPU_IDLE_GOV_LADDER=y
@@ -808,37 +808,8 @@ CONFIG_TWL4030_CORE=y
 #
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
-CONFIG_FB=y
-# CONFIG_FIRMWARE_EDID is not set
-# CONFIG_FB_DDC is not set
-# CONFIG_FB_BOOT_VESA_SUPPORT is not set
-CONFIG_FB_CFB_FILLRECT=y
-CONFIG_FB_CFB_COPYAREA=y
-CONFIG_FB_CFB_IMAGEBLIT=y
-# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
-# CONFIG_FB_SYS_FILLRECT is not set
-# CONFIG_FB_SYS_COPYAREA is not set
-# CONFIG_FB_SYS_IMAGEBLIT is not set
-# CONFIG_FB_FOREIGN_ENDIAN is not set
-# CONFIG_FB_SYS_FOPS is not set
-# CONFIG_FB_SVGALIB is not set
-# CONFIG_FB_MACMODES is not set
-# CONFIG_FB_BACKLIGHT is not set
-# CONFIG_FB_MODE_HELPERS is not set
-# CONFIG_FB_TILEBLITTING is not set
-
-#
-# Frame buffer hardware drivers
-#
-# CONFIG_FB_S1D13XXX is not set
-# CONFIG_FB_VIRTUAL is not set
-# CONFIG_FB_METRONOME is not set
-# CONFIG_FB_MB862XX is not set
-CONFIG_FB_OMAP=y
+# CONFIG_FB is not set
 # CONFIG_FB_OMAP_LCD_VGA is not set
-# CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
-# CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
-CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
@@ -851,11 +822,6 @@ CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
-# CONFIG_FRAMEBUFFER_CONSOLE is not set
-CONFIG_LOGO=y
-CONFIG_LOGO_LINUX_MONO=y
-CONFIG_LOGO_LINUX_VGA16=y
-CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_SOUND is not set
 # CONFIG_HID_SUPPORT is not set
 CONFIG_USB_SUPPORT=y
-- 
1.5.4.7

