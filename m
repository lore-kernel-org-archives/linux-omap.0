From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [PATCH] ARM: OMAP2+ Add Primview displays to panel-generic
Date: Fri, 23 Mar 2012 13:48:32 +0100
Message-ID: <1332506912-10313-1-git-send-email-j.weitzel@phytec.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.phycard.de ([217.6.246.34]:38574 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246Ab2CWNPv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Mar 2012 09:15:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Jan Weitzel <j.weitzel@phytec.de>

Add displays to panel-generic-dpi.c
Prime View PD050VL1 (640 x 480)
Prime View PD104SLF (800 x 600)
Prime View PM070WL4 (800 x 480)

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   63 ++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 28b9a6d..85ee8d3 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -363,6 +363,69 @@ static struct panel_config generic_dpi_panels[] = {
 
 		.name			= "ortustech_com43h4m10xtc",
 	},
+
+	/* Prime-View PD050VL1 */
+	{
+		{
+			.x_res		= 640,
+			.y_res		= 480,
+
+			.pixel_clock	= 25000,
+
+			.hsw		= 96,
+			.hfp		= 18,
+			.hbp		= 46,
+
+			.vsw		= 2,
+			.vfp		= 10,
+			.vbp		= 33,
+		},
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
+		.name			= "pd050vl1",
+	},
+
+	/* Prime-View PM070WL4 */
+	{
+		{
+			.x_res		= 800,
+			.y_res		= 480,
+
+			.pixel_clock	= 32000,
+
+			.hsw		= 128,
+			.hfp		= 42,
+			.hbp		= 86,
+
+			.vsw		= 2,
+			.vfp		= 10,
+			.vbp		= 33,
+		},
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
+		.name			= "pm070wl4",
+	},
+
+	/* Prime-View PD104SLF */
+	{
+		{
+			.x_res		= 800,
+			.y_res		= 600,
+
+			.pixel_clock	= 40000,
+
+			.hsw		= 128,
+			.hfp		= 42,
+			.hbp		= 86,
+
+			.vsw		= 4,
+			.vfp		= 1,
+			.vbp		= 23,
+		},
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
+		.name			= "pd104slf",
+	},
 };
 
 struct panel_drv_data {
-- 
1.7.0.4

