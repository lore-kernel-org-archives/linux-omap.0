From: Archit Taneja <archit@ti.com>
Subject: [PATCH 06/11] OMAPDSS: Generic DPI Panel: use devm_kzalloc for allocating driver data
Date: Wed, 13 Feb 2013 19:37:09 +0530
Message-ID: <1360764434-18788-7-git-send-email-archit@ti.com>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39230 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933917Ab3BMOIM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:08:12 -0500
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Use devm_kzalloc instead of kzalloc to allocate driver data for the generic dpi
panel driver. This simplifies the driver's probe and remove functions.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 54ca8ae..6cb2fe0 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -632,7 +632,7 @@ static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
 
 	dssdev->panel.timings = panel_config->timings;
 
-	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
+	drv_data = devm_kzalloc(&dssdev->dev, sizeof(*drv_data), GFP_KERNEL);
 	if (!drv_data)
 		return -ENOMEM;
 
@@ -648,12 +648,8 @@ static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
 
 static void __exit generic_dpi_panel_remove(struct omap_dss_device *dssdev)
 {
-	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
-
 	dev_dbg(&dssdev->dev, "remove\n");
 
-	kfree(drv_data);
-
 	dev_set_drvdata(&dssdev->dev, NULL);
 }
 
-- 
1.7.9.5

