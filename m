From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/13] OMAPDSS: DSI: count with number of lanes
Date: Thu, 24 Nov 2011 15:29:32 +0200
Message-ID: <1322141381-5395-5-git-send-email-tomi.valkeinen@ti.com>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:38962 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755542Ab1KXNaE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:30:04 -0500
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

DSI driver currently counts used lanes and number of supported lanes by
using the number of data lanes (i.e. excluding clock lane). This patch
changes this to use the number of all lanes so that the following lane
config patches are cleaner.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   49 ++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 4b1c074..6a110b2 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -327,7 +327,7 @@ struct dsi_data {
 	unsigned long  fint_min, fint_max;
 	unsigned long lpdiv_max;
 
-	int num_data_lanes;
+	unsigned num_lanes_supported;
 
 	unsigned scp_clk_refcount;
 };
@@ -2029,19 +2029,8 @@ static int dsi_cio_power(struct platform_device *dsidev,
 	return 0;
 }
 
-/* Number of data lanes present on DSI interface */
-static inline int dsi_get_num_data_lanes(struct platform_device *dsidev)
-{
-	/* DSI on OMAP3 doesn't have register DSI_GNQ, set number
-	 * of data lanes as 2 by default */
-	if (dss_has_feature(FEAT_DSI_GNQ))
-		return REG_GET(dsidev, DSI_GNQ, 11, 9);	/* NB_DATA_LANES */
-	else
-		return 2;
-}
-
-/* Number of data lanes used by the dss device */
-static inline int dsi_get_num_data_lanes_dssdev(struct omap_dss_device *dssdev)
+/* Number of lanes used by the dss device */
+static inline int dsi_get_num_lanes_used(struct omap_dss_device *dssdev)
 {
 	int num_data_lanes = 0;
 
@@ -2054,7 +2043,7 @@ static inline int dsi_get_num_data_lanes_dssdev(struct omap_dss_device *dssdev)
 	if (dssdev->phy.dsi.data4_lane != 0)
 		num_data_lanes++;
 
-	return num_data_lanes;
+	return num_data_lanes + 1;
 }
 
 static unsigned dsi_get_line_buf_size(struct platform_device *dsidev)
@@ -2092,7 +2081,7 @@ static void dsi_set_lane_config(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	u32 r;
-	int num_data_lanes_dssdev = dsi_get_num_data_lanes_dssdev(dssdev);
+	int num_lanes_used = dsi_get_num_lanes_used(dssdev);
 
 	int clk_lane   = dssdev->phy.dsi.clk_lane;
 	int data1_lane = dssdev->phy.dsi.data1_lane;
@@ -2108,14 +2097,14 @@ static void dsi_set_lane_config(struct omap_dss_device *dssdev)
 	r = FLD_MOD(r, data1_pol, 7, 7);
 	r = FLD_MOD(r, data2_lane, 10, 8);
 	r = FLD_MOD(r, data2_pol, 11, 11);
-	if (num_data_lanes_dssdev > 2) {
+	if (num_lanes_used > 3) {
 		int data3_lane  = dssdev->phy.dsi.data3_lane;
 		int data3_pol  = dssdev->phy.dsi.data3_pol;
 
 		r = FLD_MOD(r, data3_lane, 14, 12);
 		r = FLD_MOD(r, data3_pol, 15, 15);
 	}
-	if (num_data_lanes_dssdev > 3) {
+	if (num_lanes_used > 4) {
 		int data4_lane  = dssdev->phy.dsi.data4_lane;
 		int data4_pol  = dssdev->phy.dsi.data4_pol;
 
@@ -2247,7 +2236,7 @@ static void dsi_cio_enable_lane_override(struct omap_dss_device *dssdev,
 	int data4_pol  = dssdev->phy.dsi.data4_pol;
 
 	u32 l = 0;
-	u8 lptxscp_start = dsi->num_data_lanes == 2 ? 22 : 26;
+	u8 lptxscp_start = dsi->num_lanes_supported == 3 ? 22 : 26;
 
 	if (lanes & DSI_CLK_P)
 		l |= 1 << ((clk_lane - 1) * 2 + (clk_pol ? 0 : 1));
@@ -2385,7 +2374,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r;
-	int num_data_lanes_dssdev = dsi_get_num_data_lanes_dssdev(dssdev);
+	int num_lanes_used = dsi_get_num_lanes_used(dssdev);
 	u32 l;
 
 	DSSDBGF();
@@ -2430,10 +2419,10 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 		 * manually.
 		 */
 
-		if (num_data_lanes_dssdev > 2)
+		if (num_lanes_used > 3)
 			lane_mask |= DSI_DATA3_P;
 
-		if (num_data_lanes_dssdev > 3)
+		if (num_lanes_used > 4)
 			lane_mask |= DSI_DATA4_P;
 
 		dsi_cio_enable_lane_override(dssdev, lane_mask);
@@ -3852,7 +3841,7 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 	unsigned ddr_clk_pre, ddr_clk_post;
 	unsigned enter_hs_mode_lat, exit_hs_mode_lat;
 	unsigned ths_eot;
-	int ndl = dsi_get_num_data_lanes_dssdev(dssdev);
+	int ndl = dsi_get_num_lanes_used(dssdev) - 1;
 	u32 r;
 
 	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG0);
@@ -4552,9 +4541,9 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 		dsi->vdds_dsi_reg = vdds_dsi;
 	}
 
-	if (dsi_get_num_data_lanes_dssdev(dssdev) > dsi->num_data_lanes) {
-		DSSERR("DSI%d can't support more than %d data lanes\n",
-			dsi_module + 1, dsi->num_data_lanes);
+	if (dsi_get_num_lanes_used(dssdev) > dsi->num_lanes_supported) {
+		DSSERR("DSI%d can't support more than %d lanes\n",
+			dsi_module + 1, dsi->num_lanes_supported);
 		return -EINVAL;
 	}
 
@@ -4780,7 +4769,13 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 	dev_dbg(&dsidev->dev, "OMAP DSI rev %d.%d\n",
 	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
 
-	dsi->num_data_lanes = dsi_get_num_data_lanes(dsidev);
+	/* DSI on OMAP3 doesn't have register DSI_GNQ, set number
+	 * of data to 3 by default */
+	if (dss_has_feature(FEAT_DSI_GNQ))
+		/* NB_DATA_LANES */
+		dsi->num_lanes_supported = 1 + REG_GET(dsidev, DSI_GNQ, 11, 9);
+	else
+		dsi->num_lanes_supported = 3;
 
 	dsi_runtime_put(dsidev);
 
-- 
1.7.4.1

