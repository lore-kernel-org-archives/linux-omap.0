From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] omapdss: Add support for the OrtusTech COM57H5M24KSC panel
Date: Mon, 23 Apr 2012 14:41:34 +0200
Message-ID: <1335184894-21733-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:34088 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab2DWMlT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 08:41:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   25 ++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 28b9a6d..9411ad7 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -363,6 +363,31 @@ static struct panel_config generic_dpi_panels[] = {
 
 		.name			= "ortustech_com43h4m10xtc",
 	},
+
+	/* OrtusTech COM57H5M24KSC */
+	{
+		{
+			.x_res		= 640,
+			.y_res		= 480,
+
+			.pixel_clock	= 25000,
+
+			.hsw		= 30,
+			.hfp		= 48,
+			.hbp		= 82,
+
+			.vsw		= 3,
+			.vfp		= 10,
+			.vbp		= 32,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC,
+		.power_on_delay		= 0,
+		.power_off_delay	= 0,
+		.name			= "ortustech_com57h5m24ksc",
+	},
 
 	/* Innolux AT080TN52 */
 	{
-- 
Regards,

Laurent Pinchart

