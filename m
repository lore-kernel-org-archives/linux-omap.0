From: Roger Quadros <roger.quadros@nokia.com>
Subject: [PATCHv3 5/5] OMAP: RX51: Update board defconfig
Date: Thu, 15 Apr 2010 15:06:21 +0300
Message-ID: <1271333181-23609-6-git-send-email-roger.quadros@nokia.com>
References: <1271333181-23609-1-git-send-email-roger.quadros@nokia.com>
 <1271333181-23609-2-git-send-email-roger.quadros@nokia.com>
 <1271333181-23609-3-git-send-email-roger.quadros@nokia.com>
 <1271333181-23609-4-git-send-email-roger.quadros@nokia.com>
 <1271333181-23609-5-git-send-email-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44547 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab0DOMGt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 08:06:49 -0400
In-Reply-To: <1271333181-23609-5-git-send-email-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

From: Roger Quadros <roger.quadros@nokia.com>

Add LCD, Boot-up logo, framebuffer console, Keypad
and Power button support

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
---
 arch/arm/configs/rx51_defconfig |   39 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index 45135ff..e891af8 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -787,6 +787,7 @@ CONFIG_INPUT_KEYBOARD=y
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
 CONFIG_KEYBOARD_GPIO=m
+CONFIG_KEYBOARD_TWL4030=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
 # CONFIG_INPUT_TABLET is not set
@@ -812,6 +813,7 @@ CONFIG_INPUT_MISC=y
 # CONFIG_INPUT_POWERMATE is not set
 # CONFIG_INPUT_YEALINK is not set
 # CONFIG_INPUT_CM109 is not set
+CONFIG_INPUT_TWL4030_PWRBUTTON=y
 CONFIG_INPUT_UINPUT=m
 
 #
@@ -1113,7 +1115,40 @@ CONFIG_RADIO_ADAPTERS=y
 #
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
+CONFIG_FB=y
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+
+# Frame buffer hardware drivers
+#
+CONFIG_OMAP2_VRAM=y
+CONFIG_OMAP2_VRFB=y
+CONFIG_OMAP2_DSS=y
+CONFIG_OMAP2_VRAM_SIZE=0
+# CONFIG_OMAP2_DSS_DEBUG_SUPPORT is not set
+# CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS is not set
+# CONFIG_OMAP2_DSS_DPI is not set
+# CONFIG_OMAP2_DSS_RFBI is not set
+# CONFIG_OMAP2_DSS_VENC is not set
+CONFIG_OMAP2_DSS_SDI=y
+# CONFIG_OMAP2_DSS_DSI is not set
+# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
+CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=0
+CONFIG_FB_OMAP2=y
+CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
+CONFIG_FB_OMAP2_NUM_FBS=3
+
+#
+# OMAP2/3 Display Device Drivers
+#
+# CONFIG_PANEL_GENERIC is not set
+# CONFIG_PANEL_SHARP_LS037V7DW01 is not set
+# CONFIG_PANEL_SHARP_LQ043T1DG01 is not set
+# CONFIG_PANEL_TOPPOLY_TDO35S is not set
+# CONFIG_PANEL_TPO_TD043MTEA1 is not set
+CONFIG_PANEL_ACX565AKM=y
+
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
@@ -1130,6 +1165,8 @@ CONFIG_DISPLAY_SUPPORT=y
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_LOGO=y
 CONFIG_SOUND=y
 # CONFIG_SOUND_OSS_CORE is not set
 CONFIG_SND=y
-- 
1.6.0.4

