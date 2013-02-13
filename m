From: Archit Taneja <archit@ti.com>
Subject: [PATCH 28/33] OMAPDSS: n8x0 panel: remove platform_enable/disable callbacks
Date: Wed, 13 Feb 2013 19:52:20 +0530
Message-ID: <1360765345-19312-29-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40260 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934039Ab3BMOYj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:24:39 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The n8x0 panel driver now manages the gpios required to configure the panel.
This was previously done in panel_n8x0_data's platform_enable/disable callbacks
defined in board files using this panel.

All the board files using this panel now pass the gpio information as platform
data via the panel_n8x0_data struct, which is needed by the panel driver to
configure the gpios connected to the panel. Hence, the platform_enable/disable
ops can be safely removed now.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-n8x0.c |   12 ------------
 include/video/omap-panel-data.h           |    2 --
 2 files changed, 14 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index c146a3d..f94ead6 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -295,12 +295,6 @@ static int n8x0_panel_power_on(struct omap_dss_device *dssdev)
 
 	gpio_direction_output(bdata->ctrl_pwrdown, 1);
 
-	if (bdata->platform_enable) {
-		r = bdata->platform_enable(dssdev);
-		if (r)
-			goto err_plat_en;
-	}
-
 	omapdss_rfbi_set_size(dssdev, dssdev->panel.timings.x_res,
 		dssdev->panel.timings.y_res);
 	omapdss_rfbi_set_pixel_size(dssdev, dssdev->ctrl.pixel_size);
@@ -373,9 +367,6 @@ err_inv_panel:
 err_inv_chip:
 	omapdss_rfbi_display_disable(dssdev);
 err_rfbi_en:
-	if (bdata->platform_disable)
-		bdata->platform_disable(dssdev);
-err_plat_en:
 	gpio_direction_output(bdata->ctrl_pwrdown, 0);
 	return r;
 }
@@ -392,9 +383,6 @@ static void n8x0_panel_power_off(struct omap_dss_device *dssdev)
 	send_display_off(spi);
 	send_sleep_in(spi);
 
-	if (bdata->platform_disable)
-		bdata->platform_disable(dssdev);
-
 	/*
 	 * HACK: we should turn off the panel here, but there is some problem
 	 * with the initialization sequence, and we fail to init the panel if we
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index 7cac89e..84f332e 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -48,8 +48,6 @@ struct panel_generic_dpi_data {
  * struct panel_n8x0_data - N800 panel driver configuration data
  */
 struct panel_n8x0_data {
-	int (*platform_enable)(struct omap_dss_device *dssdev);
-	void (*platform_disable)(struct omap_dss_device *dssdev);
 	int panel_reset;
 	int ctrl_pwrdown;
 };
-- 
1.7.9.5

