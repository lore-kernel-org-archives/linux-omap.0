From: Roger Quadros <roger.quadros@nokia.com>
Subject: [PATCH 5/5] OMAP: RX51: Add LCD Panel and framebuffer console to defconfig
Date: Tue, 23 Mar 2010 11:56:31 +0200
Message-ID: <1269338191-10734-6-git-send-email-roger.quadros@nokia.com>
References: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com>
 <1269338191-10734-2-git-send-email-roger.quadros@nokia.com>
 <1269338191-10734-3-git-send-email-roger.quadros@nokia.com>
 <1269338191-10734-4-git-send-email-roger.quadros@nokia.com>
 <1269338191-10734-5-git-send-email-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39860 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab0CWJ5H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 05:57:07 -0400
In-Reply-To: <1269338191-10734-5-git-send-email-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: Tomi.Valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

From: Roger Quadros <roger.quadros@nokia.com>

Let's see the flashy Tux and console on N900's LCD screen.

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
---
 arch/arm/configs/rx51_defconfig |   37 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index 45135ff..d3bac0e 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -1113,7 +1113,40 @@ CONFIG_RADIO_ADAPTERS=y
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
+CONFIG_OMAP2_VRAM_SIZE=2
+CONFIG_OMAP2_DSS_DEBUG_SUPPORT=y
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
@@ -1130,6 +1163,8 @@ CONFIG_DISPLAY_SUPPORT=y
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

