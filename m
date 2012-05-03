From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/25] OMAPDSS: DSI: use dsi_get_dsidev_id(dsidev) instead of dsidev->id
Date: Thu,  3 May 2012 16:57:42 +0300
Message-ID: <1336053481-25433-7-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:52110 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756091Ab2ECN61 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:27 -0400
Received: by lbbgk8 with SMTP id gk8so1382609lbb.26
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:25 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The DSI driver uses dsi_get_dsidev_id() to get the ID number for the DSI
instance. However, there were a few places where dsidev->id was used
instead of the function. Fix those places to use the function.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index b6cf03c..f6ecc3a 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2365,7 +2365,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 
 	DSSDBGF();
 
-	r = dsi->enable_pads(dsidev->id, dsi_get_lane_mask(dssdev));
+	r = dsi->enable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
 	if (r)
 		return r;
 
@@ -2475,7 +2475,7 @@ err_cio_pwr:
 		dsi_cio_disable_lane_override(dsidev);
 err_scp_clk_dom:
 	dsi_disable_scp_clk(dsidev);
-	dsi->disable_pads(dsidev->id, dsi_get_lane_mask(dssdev));
+	dsi->disable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
 	return r;
 }
 
@@ -2489,7 +2489,7 @@ static void dsi_cio_uninit(struct omap_dss_device *dssdev)
 
 	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_OFF);
 	dsi_disable_scp_clk(dsidev);
-	dsi->disable_pads(dsidev->id, dsi_get_lane_mask(dssdev));
+	dsi->disable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
 }
 
 static void dsi_config_tx_fifo(struct platform_device *dsidev,
-- 
1.7.9.5

