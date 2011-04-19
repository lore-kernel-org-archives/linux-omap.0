From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/19] OMAP: DSS2: DSI: Add lane override functions
Date: Tue, 19 Apr 2011 12:22:04 +0300
Message-ID: <1303204942-25450-2-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:46194 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753051Ab1DSJWg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:22:36 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

DSI_DSIPHY_CFG10 register can be used to override DSI lane state. Add
functions to configure and enable the override, and to disable the
override.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   58 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 2666b6b..d245c5c 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -90,6 +90,7 @@ struct dsi_reg { u16 idx; };
 #define DSI_DSIPHY_CFG1			DSI_REG(0x200 + 0x0004)
 #define DSI_DSIPHY_CFG2			DSI_REG(0x200 + 0x0008)
 #define DSI_DSIPHY_CFG5			DSI_REG(0x200 + 0x0014)
+#define DSI_DSIPHY_CFG10		DSI_REG(0x200 + 0x0028)
 
 /* DSI_PLL_CTRL_SCP */
 
@@ -208,6 +209,15 @@ enum dsi_vc_mode {
 	DSI_VC_MODE_VP,
 };
 
+enum dsi_lane {
+	DSI_CLK_P	= 1 << 0,
+	DSI_CLK_N	= 1 << 1,
+	DSI_DATA1_P	= 1 << 2,
+	DSI_DATA1_N	= 1 << 3,
+	DSI_DATA2_P	= 1 << 4,
+	DSI_DATA2_N	= 1 << 5,
+};
+
 struct dsi_update_region {
 	u16 x, y, w, h;
 	struct omap_dss_device *device;
@@ -1863,6 +1873,54 @@ static void dsi_complexio_timings(void)
 	dsi_write_reg(DSI_DSIPHY_CFG2, r);
 }
 
+static void dsi_enable_lane_override(struct omap_dss_device *dssdev,
+		enum dsi_lane lanes)
+{
+	int clk_lane   = dssdev->phy.dsi.clk_lane;
+	int data1_lane = dssdev->phy.dsi.data1_lane;
+	int data2_lane = dssdev->phy.dsi.data2_lane;
+	int clk_pol    = dssdev->phy.dsi.clk_pol;
+	int data1_pol  = dssdev->phy.dsi.data1_pol;
+	int data2_pol  = dssdev->phy.dsi.data2_pol;
+
+	u32 l = 0;
+
+	if (lanes & DSI_CLK_P)
+		l |= 1 << ((clk_lane - 1) * 2 + (clk_pol ? 0 : 1));
+	if (lanes & DSI_CLK_N)
+		l |= 1 << ((clk_lane - 1) * 2 + (clk_pol ? 1 : 0));
+
+	if (lanes & DSI_DATA1_P)
+		l |= 1 << ((data1_lane - 1) * 2 + (data1_pol ? 0 : 1));
+	if (lanes & DSI_DATA1_N)
+		l |= 1 << ((data1_lane - 1) * 2 + (data1_pol ? 1 : 0));
+
+	if (lanes & DSI_DATA2_P)
+		l |= 1 << ((data2_lane - 1) * 2 + (data2_pol ? 0 : 1));
+	if (lanes & DSI_DATA2_N)
+		l |= 1 << ((data2_lane - 1) * 2 + (data2_pol ? 1 : 0));
+
+	/*
+	 * Bits in REGLPTXSCPDAT4TO0DXDY:
+	 * 17: DY0 18: DX0
+	 * 19: DY1 20: DX1
+	 * 21: DY2 22: DX2
+	 */
+
+	/* Set the lane override configuration */
+	REG_FLD_MOD(DSI_DSIPHY_CFG10, l, 22, 17); /* REGLPTXSCPDAT4TO0DXDY */
+
+	/* Enable lane override */
+	REG_FLD_MOD(DSI_DSIPHY_CFG10, 1, 27, 27); /* ENLPTXSCPDAT */
+}
+
+static void dsi_disable_lane_override(void)
+{
+	/* Disable lane override */
+	REG_FLD_MOD(DSI_DSIPHY_CFG10, 0, 27, 27); /* ENLPTXSCPDAT */
+	/* Reset the lane override configuration */
+	REG_FLD_MOD(DSI_DSIPHY_CFG10, 0, 22, 17); /* REGLPTXSCPDAT4TO0DXDY */
+}
 
 static int dsi_complexio_init(struct omap_dss_device *dssdev)
 {
-- 
1.7.1

