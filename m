From: Archit Taneja <archit@ti.com>
Subject: [PATCH 20/33] OMAPDSS: nec-nl8048 panel: remove platform_enable/disable callbacks
Date: Wed, 13 Feb 2013 19:52:12 +0530
Message-ID: <1360765345-19312-21-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60116 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934073Ab3BMOYP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:24:15 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The nec-nl8048 panel driver now manages the gpios required to configure the
panel. This was previously done in omap_dss_device's platform_enable/disable
callbacks defined in board files using this panel.

All the board files using this panel now pass the gpio information as platform
data via the panel_nec_nl8048_data struct, which is needed by the panel driver
to configure the gpios connected to the panel. Hence, the
platform_enable/disable ops can be safely removed now.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index 3b85e2a..1e0097d 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -133,18 +133,11 @@ static int nec_8048_panel_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		goto err0;
 
-	if (dssdev->platform_enable) {
-		r = dssdev->platform_enable(dssdev);
-		if (r)
-			goto err1;
-	}
-
 	if (gpio_is_valid(pd->res_gpio))
 		gpio_set_value_cansleep(pd->res_gpio, 1);
 
 	return 0;
-err1:
-	omapdss_dpi_display_disable(dssdev);
+
 err0:
 	return r;
 }
@@ -159,9 +152,6 @@ static void nec_8048_panel_power_off(struct omap_dss_device *dssdev)
 	if (gpio_is_valid(pd->res_gpio))
 		gpio_set_value_cansleep(pd->res_gpio, 0);
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
 	omapdss_dpi_display_disable(dssdev);
 }
 
-- 
1.7.9.5

