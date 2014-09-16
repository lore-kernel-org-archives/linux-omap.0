From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/12] ARM: omap2plus_defconfig: Enable some display features
Date: Mon, 15 Sep 2014 20:12:06 -0700
Message-ID: <1410837126-31553-12-git-send-email-tony@atomide.com>
References: <1410837126-31553-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20397 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754369AbaIPDN3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2014 23:13:29 -0400
In-Reply-To: <1410837126-31553-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Now that we have panel support for DT based booting,
let's make it usable and enable most things as modules.

Note that omap3 boards need also the ads7847 module for
the panel that we're now changing to a loadable module.
And n900 seems to require setting the brightness via
sysfs for acx565akm/brightness after modprobe of
panel_sony_acx565akm and omapfb.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 113f104..c029e5e 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -157,7 +157,9 @@ CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_MATRIX=m
 CONFIG_KEYBOARD_TWL4030=y
 CONFIG_INPUT_TOUCHSCREEN=y
-CONFIG_TOUCHSCREEN_ADS7846=y
+CONFIG_TOUCHSCREEN_ADS7846=m
+CONFIG_TOUCHSCREEN_TSC2005=m
+CONFIG_TOUCHSCREEN_TSC2007=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_TWL4030_PWRBUTTON=y
 # CONFIG_LEGACY_PTYS is not set
@@ -220,6 +222,7 @@ CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_TILEBLITTING=y
 CONFIG_OMAP2_DSS=m
+CONFIG_OMAP5_DSS_HDMI=y
 CONFIG_OMAP2_DSS_SDI=y
 CONFIG_OMAP2_DSS_DSI=y
 CONFIG_FB_OMAP2=m
@@ -227,11 +230,25 @@ CONFIG_DISPLAY_ENCODER_TFP410=m
 CONFIG_DISPLAY_ENCODER_TPD12S015=m
 CONFIG_DISPLAY_CONNECTOR_DVI=m
 CONFIG_DISPLAY_CONNECTOR_HDMI=m
+CONFIG_DISPLAY_CONNECTOR_ANALOG_TV=m
 CONFIG_DISPLAY_PANEL_DPI=m
+CONFIG_DISPLAY_PANEL_DSI_CM=m
+CONFIG_DISPLAY_PANEL_SONY_ACX565AKM=m
+CONFIG_DISPLAY_PANEL_LGPHILIPS_LB035Q02=m
+CONFIG_DISPLAY_PANEL_SHARP_LS037V7DW01=m
+CONFIG_DISPLAY_PANEL_TPO_TD028TTEC1=m
+CONFIG_DISPLAY_PANEL_TPO_TD043MTEA1=m
+CONFIG_DISPLAY_PANEL_NEC_NL8048HL11=m
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_GENERIC=m
+CONFIG_BACKLIGHT_PWM=m
+CONFIG_BACKLIGHT_PANDORA=m
+CONFIG_BACKLIGHT_GPIO=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
@@ -283,6 +300,9 @@ CONFIG_TI_EDMA=y
 CONFIG_DMA_OMAP=y
 CONFIG_EXTCON=y
 CONFIG_EXTCON_PALMAS=y
+CONFIG_PWM=y
+CONFIG_PWM_TWL=y
+CONFIG_PWM_TWL_LED=y
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
 CONFIG_EXT2_FS=y
-- 
2.1.0

