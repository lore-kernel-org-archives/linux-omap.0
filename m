From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/4] OMAP: DSS2: DSI: Get number of DSI data lanes using DSI_GNQ register
Date: Mon, 16 May 2011 15:17:08 +0530
Message-ID: <1305539229-28560-4-git-send-email-archit@ti.com>
References: <1305539229-28560-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43014 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171Ab1EPJm1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 05:42:27 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4G9gQJi018793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 04:42:26 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4G9gQMK010460
	for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 04:42:26 -0500 (CDT)
In-Reply-To: <1305539229-28560-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On OMAP3, the DSI module has 2 data lanes. On OMAP4, DSI1 has 4 data lanes
and DSI2 has 2 data lanes. Introduce function dsi_get_num_data_lanes() which
returns the number of data lanes on the dsi interface, introduce function
dsi_get_num_data_lanes_dssdev() which returns the number of data lanes used by
the omap_dss_device connected to the lanes.

Use the DSI_GNQ register on OMAP4 to get the number of data lanes, modify
dsi.c to use the number of lanes and the extra data lanes on DSI1.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c          |   97 +++++++++++++++++++++++++++++---
 drivers/video/omap2/dss/dss_features.c |    3 +-
 drivers/video/omap2/dss/dss_features.h |    1 +
 include/video/omapdss.h                |    4 +
 4 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index f04244b..784677d 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -59,6 +59,7 @@ struct dsi_reg { u16 idx; };
 #define DSI_IRQSTATUS			DSI_REG(0x0018)
 #define DSI_IRQENABLE			DSI_REG(0x001C)
 #define DSI_CTRL			DSI_REG(0x0040)
+#define DSI_GNQ				DSI_REG(0x0044)
 #define DSI_COMPLEXIO_CFG1		DSI_REG(0x0048)
 #define DSI_COMPLEXIO_IRQ_STATUS	DSI_REG(0x004C)
 #define DSI_COMPLEXIO_IRQ_ENABLE	DSI_REG(0x0050)
@@ -238,6 +239,10 @@ enum dsi_lane {
 	DSI_DATA1_N	= 1 << 3,
 	DSI_DATA2_P	= 1 << 4,
 	DSI_DATA2_N	= 1 << 5,
+	DSI_DATA3_P	= 1 << 6,
+	DSI_DATA3_N	= 1 << 7,
+	DSI_DATA4_P	= 1 << 8,
+	DSI_DATA4_N	= 1 << 9,
 };
 
 struct dsi_update_region {
@@ -326,6 +331,8 @@ struct dsi_data {
 	unsigned long  fint_min, fint_max;
 	unsigned long lpdiv_max;
 
+	int num_data_lanes;
+
 	unsigned scp_clk_refcount;
 };
 
@@ -2001,10 +2008,39 @@ static int dsi_cio_power(struct platform_device *dsidev,
 	return 0;
 }
 
+/* Number of data lanes present on DSI interface */
+static inline int dsi_get_num_data_lanes(struct platform_device *dsidev)
+{
+	/* DSI on OMAP3 doesn't have register DSI_GNQ, set number
+	 * of data lanes as 2 by default */
+	if (dss_has_feature(FEAT_DSI_GNQ))
+		return REG_GET(dsidev, DSI_GNQ, 11, 9);	/* NB_DATA_LANES */
+	else
+		return 2;
+}
+
+/* Number of data lanes used by the dss device */
+static inline int dsi_get_num_data_lanes_dssdev(struct omap_dss_device *dssdev)
+{
+	int num_data_lanes = 0;
+
+	if (dssdev->phy.dsi.data1_lane != 0)
+		num_data_lanes++;
+	if (dssdev->phy.dsi.data2_lane != 0)
+		num_data_lanes++;
+	if (dssdev->phy.dsi.data3_lane != 0)
+		num_data_lanes++;
+	if (dssdev->phy.dsi.data4_lane != 0)
+		num_data_lanes++;
+
+	return num_data_lanes;
+}
+
 static void dsi_set_lane_config(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	u32 r;
+	int num_data_lanes_dssdev = dsi_get_num_data_lanes_dssdev(dssdev);
 
 	int clk_lane   = dssdev->phy.dsi.clk_lane;
 	int data1_lane = dssdev->phy.dsi.data1_lane;
@@ -2020,6 +2056,20 @@ static void dsi_set_lane_config(struct omap_dss_device *dssdev)
 	r = FLD_MOD(r, data1_pol, 7, 7);
 	r = FLD_MOD(r, data2_lane, 10, 8);
 	r = FLD_MOD(r, data2_pol, 11, 11);
+	if (num_data_lanes_dssdev > 2) {
+		int data3_lane  = dssdev->phy.dsi.data3_lane;
+		int data3_pol  = dssdev->phy.dsi.data3_pol;
+
+		r = FLD_MOD(r, data3_lane, 14, 12);
+		r = FLD_MOD(r, data3_pol, 15, 15);
+	}
+	if (num_data_lanes_dssdev > 3) {
+		int data4_lane  = dssdev->phy.dsi.data4_lane;
+		int data4_pol  = dssdev->phy.dsi.data4_pol;
+
+		r = FLD_MOD(r, data4_lane, 18, 16);
+		r = FLD_MOD(r, data4_pol, 19, 19);
+	}
 	dsi_write_reg(dsidev, DSI_COMPLEXIO_CFG1, r);
 
 	/* The configuration of the DSI complex I/O (number of data lanes,
@@ -2132,14 +2182,20 @@ static void dsi_cio_enable_lane_override(struct omap_dss_device *dssdev,
 		enum dsi_lane lanes)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int clk_lane   = dssdev->phy.dsi.clk_lane;
 	int data1_lane = dssdev->phy.dsi.data1_lane;
 	int data2_lane = dssdev->phy.dsi.data2_lane;
+	int data3_lane = dssdev->phy.dsi.data3_lane;
+	int data4_lane = dssdev->phy.dsi.data4_lane;
 	int clk_pol    = dssdev->phy.dsi.clk_pol;
 	int data1_pol  = dssdev->phy.dsi.data1_pol;
 	int data2_pol  = dssdev->phy.dsi.data2_pol;
+	int data3_pol  = dssdev->phy.dsi.data3_pol;
+	int data4_pol  = dssdev->phy.dsi.data4_pol;
 
 	u32 l = 0;
+	u8 lptxscp_start = dsi->num_data_lanes == 2 ? 22 : 26;
 
 	if (lanes & DSI_CLK_P)
 		l |= 1 << ((clk_lane - 1) * 2 + (clk_pol ? 0 : 1));
@@ -2156,17 +2212,28 @@ static void dsi_cio_enable_lane_override(struct omap_dss_device *dssdev,
 	if (lanes & DSI_DATA2_N)
 		l |= 1 << ((data2_lane - 1) * 2 + (data2_pol ? 1 : 0));
 
+	if (lanes & DSI_DATA3_P)
+		l |= 1 << ((data3_lane - 1) * 2 + (data3_pol ? 0 : 1));
+	if (lanes & DSI_DATA3_N)
+		l |= 1 << ((data3_lane - 1) * 2 + (data3_pol ? 1 : 0));
+
+	if (lanes & DSI_DATA4_P)
+		l |= 1 << ((data4_lane - 1) * 2 + (data4_pol ? 0 : 1));
+	if (lanes & DSI_DATA4_N)
+		l |= 1 << ((data4_lane - 1) * 2 + (data4_pol ? 1 : 0));
 	/*
 	 * Bits in REGLPTXSCPDAT4TO0DXDY:
 	 * 17: DY0 18: DX0
 	 * 19: DY1 20: DX1
 	 * 21: DY2 22: DX2
+	 * 23: DY3 24: DX3
+	 * 25: DY4 26: DX4
 	 */
 
 	/* Set the lane override configuration */
 
 	/* REGLPTXSCPDAT4TO0DXDY */
-	REG_FLD_MOD(dsidev, DSI_DSIPHY_CFG10, l, 22, 17);
+	REG_FLD_MOD(dsidev, DSI_DSIPHY_CFG10, l, lptxscp_start, 17);
 
 	/* Enable lane override */
 
@@ -2248,6 +2315,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r;
+	int num_data_lanes_dssdev = dsi_get_num_data_lanes_dssdev(dssdev);
 	u32 l;
 
 	DSSDBGF();
@@ -2279,6 +2347,8 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	dsi_write_reg(dsidev, DSI_TIMING1, l);
 
 	if (dsi->ulps_enabled) {
+		u32 lane_mask = DSI_CLK_P | DSI_DATA1_P | DSI_DATA2_P;
+
 		DSSDBG("manual ulps exit\n");
 
 		/* ULPS is exited by Mark-1 state for 1ms, followed by
@@ -2289,8 +2359,13 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 		 * manually.
 		 */
 
-		dsi_cio_enable_lane_override(dssdev,
-				DSI_CLK_P | DSI_DATA1_P | DSI_DATA2_P);
+		if (num_data_lanes_dssdev > 2)
+			lane_mask |= DSI_DATA3_P;
+
+		if (num_data_lanes_dssdev > 3)
+			lane_mask |= DSI_DATA4_P;
+
+		dsi_cio_enable_lane_override(dssdev, lane_mask);
 	}
 
 	r = dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_ON);
@@ -3495,12 +3570,7 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 	/* min 60ns + 52*UI */
 	tclk_post = ns2ddr(dsidev, 60) + 26;
 
-	/* ths_eot is 2 for 2 datalanes and 4 for 1 datalane */
-	if (dssdev->phy.dsi.data1_lane != 0 &&
-			dssdev->phy.dsi.data2_lane != 0)
-		ths_eot = 2;
-	else
-		ths_eot = 4;
+	ths_eot = DIV_ROUND_UP(4, dsi_get_num_data_lanes_dssdev(dssdev));
 
 	ddr_clk_pre = DIV_ROUND_UP(tclk_pre + tlpx + tclk_zero + tclk_prepare,
 			4);
@@ -4220,6 +4290,7 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	int dsi_module = dsi_get_dsidev_id(dsidev);
 
 	DSSDBG("DSI init\n");
 
@@ -4240,6 +4311,12 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 		dsi->vdds_dsi_reg = vdds_dsi;
 	}
 
+	if (dsi_get_num_data_lanes_dssdev(dssdev) > dsi->num_data_lanes) {
+		DSSERR("DSI%d can't support more than %d data lanes\n",
+			dsi_module + 1, dsi->num_data_lanes);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -4416,6 +4493,8 @@ static int dsi_init(struct platform_device *dsidev)
 	dev_dbg(&dsidev->dev, "OMAP DSI rev %d.%d\n",
 	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
 
+	dsi->num_data_lanes = dsi_get_num_data_lanes(dsidev);
+
 	enable_clocks(0);
 
 	return 0;
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 5be5eb0..6460b0a 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -294,7 +294,8 @@ static const struct omap_dss_features omap4_dss_features = {
 		FEAT_GLOBAL_ALPHA | FEAT_PRE_MULT_ALPHA |
 		FEAT_MGR_LCD2 | FEAT_GLOBAL_ALPHA_VID1 |
 		FEAT_CORE_CLK_DIV | FEAT_LCD_CLK_SRC |
-		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH,
+		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH |
+		FEAT_DSI_GNQ,
 
 	.num_mgrs = 3,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 857162b..ff2cf33 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -47,6 +47,7 @@ enum dss_feat_id {
 	FEAT_DSI_DCS_CMD_CONFIG_VC	= 1 << 15,
 	FEAT_DSI_VC_OCP_WIDTH		= 1 << 16,
 	FEAT_DSI_REVERSE_TXCLKESC	= 1 << 17,
+	FEAT_DSI_GNQ			= 1 << 18,
 };
 
 /* DSS register field id */
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index b1b5ba5..e626745 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -420,6 +420,10 @@ struct omap_dss_device {
 			u8 data1_pol;
 			u8 data2_lane;
 			u8 data2_pol;
+			u8 data3_lane;
+			u8 data3_pol;
+			u8 data4_lane;
+			u8 data4_pol;
 
 			int module;
 
-- 
1.7.1

