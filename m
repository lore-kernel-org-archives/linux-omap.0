From: Samreen <samreen@ti.com>
Subject: [PATCH 1/1] OMAP3: DSS: Kconfig changes to enable display options on OMAP3
Date: Thu, 14 Oct 2010 17:05:03 +0530
Message-ID: <1287056103-25191-1-git-send-email-samreen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42879 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123Ab0JNLjp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Oct 2010 07:39:45 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9EBdjD6002295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 14 Oct 2010 06:39:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Samreen <samreen@ti.com>

The defconfig options for display are taken in the respective Kconfig
to enable display by default on OMAP3 platforms

Signed-off-by: Samreen <samreen@ti.com>
---
 drivers/video/omap2/displays/Kconfig |    3 +++
 drivers/video/omap2/dss/Kconfig      |    6 ++++--
 drivers/video/omap2/omapfb/Kconfig   |    4 +++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index f8152cf..d7d3edb 100644
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
@@ -17,6 +19,7 @@ config PANEL_SHARP_LS037V7DW01
 config PANEL_SHARP_LQ043T1DG01
         tristate "Sharp LQ043T1DG01 LCD Panel"
         depends on OMAP2_DSS
+	default y
         help
           LCD Panel used in TI's OMAP3517 EVM boards
 
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
index 65149b2..41aec6f 100644
--- a/drivers/video/omap2/omapfb/Kconfig
+++ b/drivers/video/omap2/omapfb/Kconfig
@@ -1,6 +1,7 @@
 menuconfig FB_OMAP2
         tristate "OMAP2/3 frame buffer support (EXPERIMENTAL)"
         depends on FB && OMAP2_DSS
+	default y
 
 	select OMAP2_VRAM
 	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
@@ -21,7 +22,8 @@ config FB_OMAP2_DEBUG_SUPPORT
 config FB_OMAP2_NUM_FBS
 	int "Number of framebuffers"
 	range 1 10
-	default 3
+	default 1  if ARCH_OMAP2 || ARCH_OMAP3
+	default 3  if ARCH_OMAP4
 	depends on FB_OMAP2
 	help
 	  Select the number of framebuffers created. OMAP2/3 has 3 overlays
-- 
1.5.6.3

