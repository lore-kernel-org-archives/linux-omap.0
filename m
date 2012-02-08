From: yegorslists@googlemail.com
Subject: [PATCH] OMAPDSS: add Innolux AT080TN52 display support
Date: Wed,  8 Feb 2012 11:11:08 +0100
Message-ID: <1328695868-9977-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:36971 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365Ab2BHKL2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Feb 2012 05:11:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

This patch adds support for Innolux AT080TN52 800x600 panel.
Tested with AM3517 based board.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   23 ++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 28b9a6d..30fe4df 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -363,6 +363,29 @@ static struct panel_config generic_dpi_panels[] = {
 
 		.name			= "ortustech_com43h4m10xtc",
 	},
+
+	/* Innolux AT080TN52 */
+	{
+		{
+			.x_res = 800,
+			.y_res = 600,
+
+			.pixel_clock	= 41142,
+
+			.hsw		= 20,
+			.hfp		= 210,
+			.hbp		= 46,
+
+			.vsw		= 10,
+			.vfp		= 12,
+			.vbp		= 23,
+		},
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO,
+
+		.name			= "innolux_at080tn52",
+	},
 };
 
 struct panel_drv_data {
-- 
1.7.1.1

