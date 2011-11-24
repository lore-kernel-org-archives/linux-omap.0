From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/13] OMAPDSS: DSI: Use new lane config in dsi_set_lane_config
Date: Thu, 24 Nov 2011 15:29:34 +0200
Message-ID: <1322141381-5395-7-git-send-email-tomi.valkeinen@ti.com>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:41658 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756059Ab1KXNaI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:30:08 -0500
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new lane config in dsi_set_lane_config().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   84 +++++++++++++++++++---------------------
 1 files changed, 40 insertions(+), 44 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index aea110c..ba8d6b3 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2154,59 +2154,53 @@ static int dsi_parse_lane_config(struct omap_dss_device *dssdev)
 	return 0;
 }
 
-static void dsi_set_lane_config(struct omap_dss_device *dssdev)
+static int dsi_set_lane_config(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	static const u8 offsets[] = { 0, 4, 8, 12, 16 };
+	static const enum dsi_lane_function functions[] = {
+		DSI_LANE_CLK,
+		DSI_LANE_DATA1,
+		DSI_LANE_DATA2,
+		DSI_LANE_DATA3,
+		DSI_LANE_DATA4,
+	};
 	u32 r;
-	int num_lanes_used = dsi_get_num_lanes_used(dssdev);
-
-	int clk_lane   = dssdev->phy.dsi.clk_lane;
-	int data1_lane = dssdev->phy.dsi.data1_lane;
-	int data2_lane = dssdev->phy.dsi.data2_lane;
-	int clk_pol    = dssdev->phy.dsi.clk_pol;
-	int data1_pol  = dssdev->phy.dsi.data1_pol;
-	int data2_pol  = dssdev->phy.dsi.data2_pol;
+	int i;
 
 	r = dsi_read_reg(dsidev, DSI_COMPLEXIO_CFG1);
-	r = FLD_MOD(r, clk_lane, 2, 0);
-	r = FLD_MOD(r, clk_pol, 3, 3);
-	r = FLD_MOD(r, data1_lane, 6, 4);
-	r = FLD_MOD(r, data1_pol, 7, 7);
-	r = FLD_MOD(r, data2_lane, 10, 8);
-	r = FLD_MOD(r, data2_pol, 11, 11);
-	if (num_lanes_used > 3) {
-		int data3_lane  = dssdev->phy.dsi.data3_lane;
-		int data3_pol  = dssdev->phy.dsi.data3_pol;
-
-		r = FLD_MOD(r, data3_lane, 14, 12);
-		r = FLD_MOD(r, data3_pol, 15, 15);
+
+	for (i = 0; i < dsi->num_lanes_used; ++i) {
+		unsigned offset = offsets[i];
+		unsigned polarity, lane_number;
+		unsigned t;
+
+		for (t = 0; t < dsi->num_lanes_supported; ++t)
+			if (dsi->lanes[t].function == functions[i])
+				break;
+
+		if (t == dsi->num_lanes_supported)
+			return -EINVAL;
+
+		lane_number = t;
+		polarity = dsi->lanes[t].polarity;
+
+		r = FLD_MOD(r, lane_number + 1, offset + 2, offset);
+		r = FLD_MOD(r, polarity, offset + 3, offset + 3);
 	}
-	if (num_lanes_used > 4) {
-		int data4_lane  = dssdev->phy.dsi.data4_lane;
-		int data4_pol  = dssdev->phy.dsi.data4_pol;
 
-		r = FLD_MOD(r, data4_lane, 18, 16);
-		r = FLD_MOD(r, data4_pol, 19, 19);
+	/* clear the unused lanes */
+	for (; i < dsi->num_lanes_supported; ++i) {
+		unsigned offset = offsets[i];
+
+		r = FLD_MOD(r, 0, offset + 2, offset);
+		r = FLD_MOD(r, 0, offset + 3, offset + 3);
 	}
-	dsi_write_reg(dsidev, DSI_COMPLEXIO_CFG1, r);
 
-	/* The configuration of the DSI complex I/O (number of data lanes,
-	   position, differential order) should not be changed while
-	   DSS.DSI_CLK_CRTRL[20] LP_CLK_ENABLE bit is set to 1. In order for
-	   the hardware to take into account a new configuration of the complex
-	   I/O (done in DSS.DSI_COMPLEXIO_CFG1 register), it is recommended to
-	   follow this sequence: First set the DSS.DSI_CTRL[0] IF_EN bit to 1,
-	   then reset the DSS.DSI_CTRL[0] IF_EN to 0, then set
-	   DSS.DSI_CLK_CTRL[20] LP_CLK_ENABLE to 1 and finally set again the
-	   DSS.DSI_CTRL[0] IF_EN bit to 1. If the sequence is not followed, the
-	   DSI complex I/O configuration is unknown. */
+	dsi_write_reg(dsidev, DSI_COMPLEXIO_CFG1, r);
 
-	/*
-	REG_FLD_MOD(dsidev, DSI_CTRL, 1, 0, 0);
-	REG_FLD_MOD(dsidev, DSI_CTRL, 0, 0, 0);
-	REG_FLD_MOD(dsidev, DSI_CLK_CTRL, 1, 20, 20);
-	REG_FLD_MOD(dsidev, DSI_CTRL, 1, 0, 0);
-	*/
+	return 0;
 }
 
 static inline unsigned ns2ddr(struct platform_device *dsidev, unsigned ns)
@@ -2473,7 +2467,9 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 		goto err_scp_clk_dom;
 	}
 
-	dsi_set_lane_config(dssdev);
+	r = dsi_set_lane_config(dssdev);
+	if (r)
+		goto err_scp_clk_dom;
 
 	/* set TX STOP MODE timer to maximum for this operation */
 	l = dsi_read_reg(dsidev, DSI_TIMING1);
-- 
1.7.4.1

