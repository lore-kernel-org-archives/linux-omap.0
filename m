From: Samreen <samreen@ti.com>
Subject: [PATCH v3] OMAP3: DSS: Kconfig changes to enable display options on OMAP3
Date: Wed, 20 Oct 2010 17:34:20 +0530
Message-ID: <1287576260-14016-1-git-send-email-samreen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47116 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894Ab0JTMJZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Oct 2010 08:09:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Roger Quadros <roger.quadros@nokia.com>, Senthilvadivu
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Samreen <samreen@ti.com>

The defconfig options for display are taken in the respective Kconfig
to enable display by default on OMAP3 platforms

Signed-off-by: Samreen <samreen@ti.com>
---
 Version3:
       Eliminate the separate default number of FBs for
 different architecture. Keeping default FBs as 3 as before.

 Version2:
        Enables by default NEC panel used in zoom2/3/3630sdp, instead of 
 Sharp LQ043T1DG01 panel enabled in previous version of this patch

 drivers/video/omap2/displays/Kconfig |    3 +++
 drivers/video/omap2/dss/Kconfig      |    6 ++++--
 drivers/video/omap2/omapfb/Kconfig   |    1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index f8152cf..d818e44 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -3,6 +3,7 @@ menu "OMAP2/3 Display Device Drivers"
 
 config PANEL_GENERIC
         tristate "Generic Panel"
+	default y
         help
 	  Generic panel driver.
 	  Used for DVI output for Beagle and OMAP3 SDP.
@@ -10,6 +11,7 @@ config PANEL_GENERIC
 config PANEL_SHARP_LS037V7DW01
         tristate "Sharp LS037V7DW01 LCD Panel"
         depends on OMAP2_DSS
+	default y
         select BACKLIGHT_CLASS_DEVICE
         help
           LCD Panel used in TI's SDP3430 and EVM boards
@@ -23,6 +25,7 @@ config PANEL_SHARP_LQ043T1DG01
 config PANEL_NEC_NL8048HL11_01B
 	tristate "NEC NL8048HL11-01B Panel"
 	depends on OMAP2_DSS
+	default y
 	help
 		This NEC NL8048HL11-01B panel is TFT LCD
 		used in the Zoom2/3/3630 sdp boards.
diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 43b6440..f3244a2 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -1,6 +1,7 @@
 menuconfig OMAP2_DSS
         tristate "OMAP2/3 Display Subsystem support (EXPERIMENTAL)"
         depends on ARCH_OMAP2 || ARCH_OMAP3
+	default y
         help
           OMAP2/3 Display Subsystem support.
 
@@ -9,7 +10,7 @@ if OMAP2_DSS
 config OMAP2_VRAM_SIZE
 	int "VRAM size (MB)"
 	range 0 32
-	default 0
+	default 4
 	help
 	  The amount of SDRAM to reserve at boot time for video RAM use.
 	  This VRAM will be used by omapfb and other drivers that need
@@ -102,7 +103,8 @@ config OMAP2_DSS_FAKE_VSYNC
 config OMAP2_DSS_MIN_FCK_PER_PCK
 	int "Minimum FCK/PCK ratio (for scaling)"
 	range 0 32
-	default 0
+	default 4  if ARCH_OMAP2 || ARCH_OMAP3
+	default 0  if ARCH_OMAP4
 	help
 	  This can be used to adjust the minimum FCK/PCK ratio.
 
diff --git a/drivers/video/omap2/omapfb/Kconfig b/drivers/video/omap2/omapfb/Kconfig
index 65149b2..923bf48 100644
--- a/drivers/video/omap2/omapfb/Kconfig
+++ b/drivers/video/omap2/omapfb/Kconfig
@@ -1,6 +1,7 @@
 menuconfig FB_OMAP2
         tristate "OMAP2/3 frame buffer support (EXPERIMENTAL)"
         depends on FB && OMAP2_DSS
+	default y
 
 	select OMAP2_VRAM
 	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
-- 
1.5.6.3

