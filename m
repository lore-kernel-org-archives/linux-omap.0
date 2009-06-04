From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 19/20] omapfb: Add FB manual update option to Kconfig
Date: Thu,  4 Jun 2009 20:52:44 +0300
Message-ID: <06b710348c4bdd4929e4d270ef29155214ca2a4a.1244131952.git.imre.deak@nokia.com>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
 <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
 <e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
 <e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com>
 <833ed44e61e3d4093eb27b55b97252967e042d41.1244131952.git.imre.deak@nokia.com>
 <5ba715a9dbc88b8c3a8225bc1cfdabd3faffe00f.1244131952.git.imre.deak@nokia.com>
 <646692ce09a12e1a8a2d4072097b4d440b7de5d5.1244131952.git.imre.deak@nokia.com>
 <b0e578438bb53d9fbf333e5bd10d4d33f869b373.1244131952.git.imre.deak@nokia.com>
 <9139035cc12b22600135677cd5d3096c1dcd286d.1244131952.git.imre.deak@nokia.com>
 <08ba068bda363adf4cb8a1f5afe11245c828d017.1244131952.git.imre.deak@nokia.com>
 <057471246e776de4c452b4ba2ebf2a4579f3171c.1244131952.git.imre.deak@nokia.com>
 <310d4aa52bfd6dd15664286643ca8a9703787dce.1244131952.git.imre.deak@nokia.com>
 <5dfa68a13340c793f25f12815e5055f9c2eda1a5.1244131952.git.imre.deak@nokia.com>
 <d5cd6aebac66e8e03a244a63bf60e21237ff32a0.1244131952.git.imre.deak@nokia.com>
 <d83034cc97924164ca9949fee84bfb480ad5c806.1244131952.git.imre.deak@nokia.com>
 <36ddd74a50b8c225b2c571035c67dbff4686b881.1244131952.git.imre.deak@nokia.com>
 <024fee28b6c89decf0d50747127db8fc61ac789e.1244131952.git.imre.deak@nokia.com>
 <20541a2436ab1399a93c28197244bb05e8657859.1244131952.git.imre.deak@nokia.com>
 <63e0213f6444a9d3c99c659dbef14207e8756b37.1244131952.git.imre.deak@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38817 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbZFDR5N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 13:57:13 -0400
In-Reply-To: <63e0213f6444a9d3c99c659dbef14207e8756b37.1244131952.git.imre.deak@nokia.com>
In-Reply-To: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
References: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, Imre Deak <imre.deak@nokia.com>

Also move the controller specific options up in the menu, to a more
logical spot.

Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 drivers/video/omap/Kconfig |   49 ++++++++++++++++++++++++++-----------------
 1 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index 2bffc07..551e3e9 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -32,6 +32,36 @@ config FB_OMAP_092M9R
 
 endchoice
 
+config FB_OMAP_LCDC_EXTERNAL
+	bool "External LCD controller support"
+	depends on FB_OMAP
+	help
+	  Say Y here, if you want to have support for boards with an
+	  external LCD controller connected to the SoSSI/RFBI interface.
+
+config FB_OMAP_LCDC_HWA742
+	bool "Epson HWA742 LCD controller support"
+	depends on FB_OMAP && FB_OMAP_LCDC_EXTERNAL
+	help
+	  Say Y here if you want to have support for the external
+	  Epson HWA742 LCD controller.
+
+config FB_OMAP_LCDC_BLIZZARD
+	bool "Epson Blizzard LCD controller support"
+	depends on FB_OMAP && FB_OMAP_LCDC_EXTERNAL
+	help
+	  Say Y here if you want to have support for the external
+	  Epson Blizzard LCD controller.
+
+config FB_OMAP_MANUAL_UPDATE
+	bool "Default to manual update mode"
+	depends on FB_OMAP && FB_OMAP_LCDC_EXTERNAL
+	help
+	  Say Y here, if your user-space applications are capable of
+	  notifying the frame buffer driver when a change has occured in
+	  the frame buffer content and thus a reload of the image data to
+	  the external frame buffer is required. If unsure, say N.
+
 config FB_OMAP_LCD_MIPID
 	bool "MIPI DBI-C/DCS compatible LCD support"
 	depends on FB_OMAP && SPI_MASTER
@@ -69,23 +99,4 @@ config FB_OMAP_DMA_TUNE
           answer yes. Answer no if you have a dedicated video
           memory, or don't use any of the accelerated features.
 
-config FB_OMAP_LCDC_EXTERNAL
-	bool "External LCD controller support"
-	depends on FB_OMAP
-	help
-	  Say Y here, if you want to have support for boards with an
-	  external LCD controller connected to the SoSSI/RFBI interface.
 
-config FB_OMAP_LCDC_HWA742
-	bool "Epson HWA742 LCD controller support"
-	depends on FB_OMAP && FB_OMAP_LCDC_EXTERNAL
-	help
-	  Say Y here if you want to have support for the external
-	  Epson HWA742 LCD controller.
-
-config FB_OMAP_LCDC_BLIZZARD
-	bool "Epson Blizzard LCD controller support"
-	depends on FB_OMAP && FB_OMAP_LCDC_EXTERNAL
-	help
-	  Say Y here if you want to have support for the external
-	  Epson Blizzard LCD controller.
-- 
1.6.3.1

