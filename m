From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/13] OMAPDSS: DSI: use lane config in dsi_get_lane_mask
Date: Thu, 24 Nov 2011 15:29:35 +0200
Message-ID: <1322141381-5395-8-git-send-email-tomi.valkeinen@ti.com>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:42480 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756059Ab1KXNaL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:30:11 -0500
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new lane config in dsi_get_lane_mask().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ba8d6b3..1a209a2 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2422,22 +2422,20 @@ static int dsi_cio_wait_tx_clk_esc_reset(struct omap_dss_device *dssdev)
 	return 0;
 }
 
+/* return bitmask of enabled lanes, lane0 being the lsb */
 static unsigned dsi_get_lane_mask(struct omap_dss_device *dssdev)
 {
-	unsigned lanes = 0;
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	unsigned mask = 0;
+	int i;
 
-	if (dssdev->phy.dsi.clk_lane != 0)
-		lanes |= 1 << (dssdev->phy.dsi.clk_lane - 1);
-	if (dssdev->phy.dsi.data1_lane != 0)
-		lanes |= 1 << (dssdev->phy.dsi.data1_lane - 1);
-	if (dssdev->phy.dsi.data2_lane != 0)
-		lanes |= 1 << (dssdev->phy.dsi.data2_lane - 1);
-	if (dssdev->phy.dsi.data3_lane != 0)
-		lanes |= 1 << (dssdev->phy.dsi.data3_lane - 1);
-	if (dssdev->phy.dsi.data4_lane != 0)
-		lanes |= 1 << (dssdev->phy.dsi.data4_lane - 1);
+	for (i = 0; i < dsi->num_lanes_supported; ++i) {
+		if (dsi->lanes[i].function != DSI_LANE_UNUSED)
+			mask |= 1 << i;
+	}
 
-	return lanes;
+	return mask;
 }
 
 static int dsi_cio_init(struct omap_dss_device *dssdev)
-- 
1.7.4.1

