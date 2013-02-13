From: Archit Taneja <archit@ti.com>
Subject: [PATCH 11/33] OMAPDSS: lb035q02 panel: remove platform_enable/disable callbacks
Date: Wed, 13 Feb 2013 19:52:03 +0530
Message-ID: <1360765345-19312-12-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40211 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756877Ab3BMOXr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:23:47 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The lgphilips panel driver now manages the gpios required to configure the
panel. This was previously done in omap_dss_device's platform_enable/disable
callbacks defined in board files using this panel.

All the board files using this panel now pass the gpio information as platform
data via the panel_generic_dpi_data struct, which is needed by the panel driver
to configure the gpios connected to the panel. Hence, the
platform_enable/disable ops can be safely removed now.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 .../omap2/displays/panel-lgphilips-lb035q02.c      |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
index 63cd8857..4ea6548 100644
--- a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
@@ -71,20 +71,13 @@ static int lb035q02_panel_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		goto err0;
 
-	if (dssdev->platform_enable) {
-		r = dssdev->platform_enable(dssdev);
-		if (r)
-			goto err1;
-	}
-
 	for (i = 0; i < panel_data->num_gpios; ++i) {
 		gpio_set_value_cansleep(panel_data->gpios[i],
 				panel_data->gpio_invert[i] ? 0 : 1);
 	}
 
 	return 0;
-err1:
-	omapdss_dpi_display_disable(dssdev);
+
 err0:
 	return r;
 }
@@ -102,9 +95,6 @@ static void lb035q02_panel_power_off(struct omap_dss_device *dssdev)
 				panel_data->gpio_invert[i] ? 1 : 0);
 	}
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
 	omapdss_dpi_display_disable(dssdev);
 }
 
-- 
1.7.9.5

