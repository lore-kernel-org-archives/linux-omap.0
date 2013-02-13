From: Archit Taneja <archit@ti.com>
Subject: [PATCH 26/33] OMAPDSS: picodlp panel: remove platform_enable/disable callbacks
Date: Wed, 13 Feb 2013 19:52:18 +0530
Message-ID: <1360765345-19312-27-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56558 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934079Ab3BMOYd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 09:24:33 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The picodlp panel driver now manages the gpios required to configure the
panel. This was previously done in omap_dss_device's platform_enable/disable
callbacks defined in board files using this panel.

All the board files using this panel now pass the gpio information as platform
data via the panel_generic_dpi_data struct, which is needed by the panel driver
to configure the gpios connected to the panel. Hence, the
platform_enable/disable ops can be safely removed now.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-picodlp.c |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index bc8ac77..62f2db0 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -354,12 +354,6 @@ static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
 	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
 	struct picodlp_panel_data *picodlp_pdata = get_panel_data(dssdev);
 
-	if (dssdev->platform_enable) {
-		r = dssdev->platform_enable(dssdev);
-		if (r)
-			return r;
-	}
-
 	gpio_set_value(picodlp_pdata->pwrgood_gpio, 0);
 	msleep(1);
 	gpio_set_value(picodlp_pdata->pwrgood_gpio, 1);
@@ -398,9 +392,6 @@ static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
 err:
 	omapdss_dpi_display_disable(dssdev);
 err1:
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
 	return r;
 }
 
@@ -412,9 +403,6 @@ static void picodlp_panel_power_off(struct omap_dss_device *dssdev)
 
 	gpio_set_value(picodlp_pdata->emu_done_gpio, 0);
 	gpio_set_value(picodlp_pdata->pwrgood_gpio, 0);
-
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
 }
 
 static int picodlp_panel_probe(struct omap_dss_device *dssdev)
-- 
1.7.9.5

