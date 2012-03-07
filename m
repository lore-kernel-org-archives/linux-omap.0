From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/21] OMAPDSS: DSI: use dsi_get_dsidev_id(dsidev) instead of dsidev->id
Date: Wed,  7 Mar 2012 14:44:35 +0200
Message-ID: <1331124290-6285-7-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:36755 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758440Ab2CGMpY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:45:24 -0500
Received: by mail-lpp01m010-f47.google.com with SMTP id w12so8121653lag.20
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:23 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
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
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 662d14f..3e656be 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2396,7 +2396,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 
 	DSSDBGF();
 
-	r = dsi->enable_pads(dsidev->id, dsi_get_lane_mask(dssdev));
+	r = dsi->enable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
 	if (r)
 		return r;
 
@@ -2506,7 +2506,7 @@ err_cio_pwr:
 		dsi_cio_disable_lane_override(dsidev);
 err_scp_clk_dom:
 	dsi_disable_scp_clk(dsidev);
-	dsi->disable_pads(dsidev->id, dsi_get_lane_mask(dssdev));
+	dsi->disable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
 	return r;
 }
 
@@ -2520,7 +2520,7 @@ static void dsi_cio_uninit(struct omap_dss_device *dssdev)
 
 	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_OFF);
 	dsi_disable_scp_clk(dsidev);
-	dsi->disable_pads(dsidev->id, dsi_get_lane_mask(dssdev));
+	dsi->disable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
 }
 
 static void dsi_config_tx_fifo(struct platform_device *dsidev,
-- 
1.7.4.1

