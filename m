From: Archit Taneja <archit@ti.com>
Subject: [PATCH 23/33] OMAPDSS: tpo-td043: remove platform_enable/disable callbacks
Date: Wed, 13 Feb 2013 19:52:15 +0530
Message-ID: <1360765345-19312-24-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60122 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934079Ab3BMOYY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:24:24 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The tpo-td043 panel driver now manages the gpios required to configure the panel.
This was previously done in omap_dss_device's platform_enable/disable callbacks
defined in board files using this panel.

All the board files using this panel now pass the gpio information as platform
data via the panel_tpo_td043_data struct, which is needed by the panel driver to
configure the gpios connected to the panel. Hence, the platform_enable/disable
ops can be safely removed now.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index c8244bc..24bb0ff 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -348,12 +348,6 @@ static int tpo_td043_enable_dss(struct omap_dss_device *dssdev)
 	if (r)
 		goto err0;
 
-	if (dssdev->platform_enable) {
-		r = dssdev->platform_enable(dssdev);
-		if (r)
-			goto err1;
-	}
-
 	/*
 	 * If we are resuming from system suspend, SPI clocks might not be
 	 * enabled yet, so we'll program the LCD from SPI PM resume callback.
@@ -380,9 +374,6 @@ static void tpo_td043_disable_dss(struct omap_dss_device *dssdev)
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
 	omapdss_dpi_display_disable(dssdev);
 
 	if (!tpo_td043->spi_suspended)
-- 
1.7.9.5

