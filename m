From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/13] OMAPDSS: DSI: use lane config in dsi_cio_enable_lane_override
Date: Thu, 24 Nov 2011 15:29:37 +0200
Message-ID: <1322141381-5395-10-git-send-email-tomi.valkeinen@ti.com>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:39392 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756059Ab1KXNaO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:30:14 -0500
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new lane config in dsi_cio_enable_lane_override(). The function
parameters are also slightly changed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   85 +++++++++++++----------------------------
 1 files changed, 27 insertions(+), 58 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 52cf97f..dee9525 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -238,19 +238,6 @@ enum dsi_vc_source {
 	DSI_VC_SOURCE_VP,
 };
 
-enum dsi_lane {
-	DSI_CLK_P	= 1 << 0,
-	DSI_CLK_N	= 1 << 1,
-	DSI_DATA1_P	= 1 << 2,
-	DSI_DATA1_N	= 1 << 3,
-	DSI_DATA2_P	= 1 << 4,
-	DSI_DATA2_N	= 1 << 5,
-	DSI_DATA3_P	= 1 << 6,
-	DSI_DATA3_N	= 1 << 7,
-	DSI_DATA4_P	= 1 << 8,
-	DSI_DATA4_N	= 1 << 9,
-};
-
 struct dsi_update_region {
 	u16 x, y, w, h;
 	struct omap_dss_device *device;
@@ -2290,49 +2277,28 @@ static void dsi_cio_timings(struct platform_device *dsidev)
 	dsi_write_reg(dsidev, DSI_DSIPHY_CFG2, r);
 }
 
+/* lane masks have lane 0 at lsb. mask_p for positive lines, n for negative */
 static void dsi_cio_enable_lane_override(struct omap_dss_device *dssdev,
-		enum dsi_lane lanes)
+		unsigned mask_p, unsigned mask_n)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	int clk_lane   = dssdev->phy.dsi.clk_lane;
-	int data1_lane = dssdev->phy.dsi.data1_lane;
-	int data2_lane = dssdev->phy.dsi.data2_lane;
-	int data3_lane = dssdev->phy.dsi.data3_lane;
-	int data4_lane = dssdev->phy.dsi.data4_lane;
-	int clk_pol    = dssdev->phy.dsi.clk_pol;
-	int data1_pol  = dssdev->phy.dsi.data1_pol;
-	int data2_pol  = dssdev->phy.dsi.data2_pol;
-	int data3_pol  = dssdev->phy.dsi.data3_pol;
-	int data4_pol  = dssdev->phy.dsi.data4_pol;
-
-	u32 l = 0;
+	int i;
+	u32 l;
 	u8 lptxscp_start = dsi->num_lanes_supported == 3 ? 22 : 26;
 
-	if (lanes & DSI_CLK_P)
-		l |= 1 << ((clk_lane - 1) * 2 + (clk_pol ? 0 : 1));
-	if (lanes & DSI_CLK_N)
-		l |= 1 << ((clk_lane - 1) * 2 + (clk_pol ? 1 : 0));
-
-	if (lanes & DSI_DATA1_P)
-		l |= 1 << ((data1_lane - 1) * 2 + (data1_pol ? 0 : 1));
-	if (lanes & DSI_DATA1_N)
-		l |= 1 << ((data1_lane - 1) * 2 + (data1_pol ? 1 : 0));
-
-	if (lanes & DSI_DATA2_P)
-		l |= 1 << ((data2_lane - 1) * 2 + (data2_pol ? 0 : 1));
-	if (lanes & DSI_DATA2_N)
-		l |= 1 << ((data2_lane - 1) * 2 + (data2_pol ? 1 : 0));
-
-	if (lanes & DSI_DATA3_P)
-		l |= 1 << ((data3_lane - 1) * 2 + (data3_pol ? 0 : 1));
-	if (lanes & DSI_DATA3_N)
-		l |= 1 << ((data3_lane - 1) * 2 + (data3_pol ? 1 : 0));
-
-	if (lanes & DSI_DATA4_P)
-		l |= 1 << ((data4_lane - 1) * 2 + (data4_pol ? 0 : 1));
-	if (lanes & DSI_DATA4_N)
-		l |= 1 << ((data4_lane - 1) * 2 + (data4_pol ? 1 : 0));
+	l = 0;
+
+	for (i = 0; i < dsi->num_lanes_supported; ++i) {
+		unsigned p = dsi->lanes[i].polarity;
+
+		if (mask_p & (1 << i))
+			l |= 1 << (i * 2 + (p ? 0 : 1));
+
+		if (mask_n & (1 << i))
+			l |= 1 << (i * 2 + (p ? 1 : 0));
+	}
+
 	/*
 	 * Bits in REGLPTXSCPDAT4TO0DXDY:
 	 * 17: DY0 18: DX0
@@ -2432,7 +2398,6 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r;
-	int num_lanes_used = dsi_get_num_lanes_used(dssdev);
 	u32 l;
 
 	DSSDBGF();
@@ -2467,7 +2432,8 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	dsi_write_reg(dsidev, DSI_TIMING1, l);
 
 	if (dsi->ulps_enabled) {
-		u32 lane_mask = DSI_CLK_P | DSI_DATA1_P | DSI_DATA2_P;
+		unsigned mask_p;
+		int i;
 
 		DSSDBG("manual ulps exit\n");
 
@@ -2476,16 +2442,19 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 		 * ULPS exit sequence, as after reset the DSS HW thinks
 		 * that we are not in ULPS mode, and refuses to send the
 		 * sequence. So we need to send the ULPS exit sequence
-		 * manually.
+		 * manually by setting positive lines high and negative lines
+		 * low for 1ms.
 		 */
 
-		if (num_lanes_used > 3)
-			lane_mask |= DSI_DATA3_P;
+		mask_p = 0;
 
-		if (num_lanes_used > 4)
-			lane_mask |= DSI_DATA4_P;
+		for (i = 0; i < dsi->num_lanes_supported; ++i) {
+			if (dsi->lanes[i].function == DSI_LANE_UNUSED)
+				continue;
+			mask_p |= 1 << i;
+		}
 
-		dsi_cio_enable_lane_override(dssdev, lane_mask);
+		dsi_cio_enable_lane_override(dssdev, mask_p, 0);
 	}
 
 	r = dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_ON);
-- 
1.7.4.1

