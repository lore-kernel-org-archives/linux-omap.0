From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [PATCH] ARM: OMAP2+ Add Primview dispalys to panel-generic
Date: Fri, 8 Jul 2011 12:47:14 +0200
Message-ID: <1310122034-6561-1-git-send-email-j.weitzel@phytec.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.phytec.de ([217.6.246.34]:56816 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604Ab1GHKrR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jul 2011 06:47:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, Jan Weitzel <j.weitzel@phytec.de>

Add displays to panel-generic-dpi.c
Prime View PD035VL1 (640 x 480)
Prime View PD050VL1 (640 x 480)
Prime View PD104SLF (800 x 600)
Prime View PM070WL4 (800 x 480)

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |  100 ++++++++++++++++++++++
 1 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 9c90f75..87d9ba1 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -232,6 +232,106 @@ static struct panel_config generic_dpi_panels[] = {
 		.power_off_delay	= 0,
 		.name			= "powertip_ph480272t",
 	},
+
+	/* Prime-View PD035VL1 */
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
+		.acbi			= 0x0,
+		.acb			= 0x28,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
+		.power_on_delay		= 50,
+		.power_off_delay	= 100,
+		.name			= "pd035vl1",
+	},
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
+		.acbi			= 0x0,
+		.acb			= 0x28,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
+		.power_on_delay		= 50,
+		.power_off_delay	= 100,
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
+		.acbi			= 0x0,
+		.acb			= 0x28,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
+		.power_on_delay		= 50,
+		.power_off_delay	= 100,
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
+		.acbi			= 0x0,
+		.acb			= 0x28,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
+		.power_on_delay		= 50,
+		.power_off_delay	= 100,
+		.name			= "pd104slf",
+	},
 };
 
 struct panel_drv_data {
-- 
1.7.0.4

