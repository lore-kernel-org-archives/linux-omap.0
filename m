From: Samreen <samreen@ti.com>
Subject: [PATCH v4] OMAP3: DSS: Kconfig changes to enable display options on OMAP3
Date: Tue, 26 Oct 2010 08:47:54 +0530
Message-ID: <1288063074-8879-1-git-send-email-samreen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33536 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755944Ab0JZDXN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Oct 2010 23:23:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Roger Quadros <roger.quadros@nokia.com>, Senthilvadivu
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Samreen <samreen@ti.com>

The defconfig options for display are taken in the respective Kconfig
to enable display by default on OMAP3 platforms

Signed-off-by: Samreen <samreen@ti.com>
---
 Version4:
       Remove the enabling of the display panels by default.

 Version3:
       Eliminate the separate default number of FBs for
 different architecture. Keeping default FBs as 3 as before.

 Version2:
        Enables by default NEC panel used in zoom2/3/3630sdp, instead of 
 Sharp LQ043T1DG01 panel enabled in previous version of this patch.

 drivers/video/omap2/dss/Kconfig    |    6 ++++--
 drivers/video/omap2/omapfb/Kconfig |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

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

