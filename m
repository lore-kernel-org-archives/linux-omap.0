From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/19] OMAP: DSS2: DSI: rename complexio related functions
Date: Tue, 19 Apr 2011 12:22:08 +0300
Message-ID: <1303204942-25450-6-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:56222 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751422Ab1DSJWp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:22:45 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Rename ComplexIO from dsi_complexio_xxx to dsi_cio_xxx for brevity.
Also, add cio prefix for couple of functions that didn't have it, but
are cio related.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 54fc0f6..61d9f3c 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1738,13 +1738,13 @@ void dsi_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-enum dsi_complexio_power_state {
+enum dsi_cio_power_state {
 	DSI_COMPLEXIO_POWER_OFF		= 0x0,
 	DSI_COMPLEXIO_POWER_ON		= 0x1,
 	DSI_COMPLEXIO_POWER_ULPS	= 0x2,
 };
 
-static int dsi_complexio_power(enum dsi_complexio_power_state state)
+static int dsi_cio_power(enum dsi_cio_power_state state)
 {
 	int t = 0;
 
@@ -1764,7 +1764,7 @@ static int dsi_complexio_power(enum dsi_complexio_power_state state)
 	return 0;
 }
 
-static void dsi_complexio_config(struct omap_dss_device *dssdev)
+static void dsi_set_lane_config(struct omap_dss_device *dssdev)
 {
 	u32 r;
 
@@ -1816,7 +1816,7 @@ static inline unsigned ddr2ns(unsigned ddr)
 	return ddr * 1000 * 1000 / (ddr_clk / 1000);
 }
 
-static void dsi_complexio_timings(void)
+static void dsi_cio_timings(void)
 {
 	u32 r;
 	u32 ths_prepare, ths_prepare_ths_zero, ths_trail, ths_exit;
@@ -1886,7 +1886,7 @@ static void dsi_complexio_timings(void)
 	dsi_write_reg(DSI_DSIPHY_CFG2, r);
 }
 
-static void dsi_enable_lane_override(struct omap_dss_device *dssdev,
+static void dsi_cio_enable_lane_override(struct omap_dss_device *dssdev,
 		enum dsi_lane lanes)
 {
 	int clk_lane   = dssdev->phy.dsi.clk_lane;
@@ -1927,7 +1927,7 @@ static void dsi_enable_lane_override(struct omap_dss_device *dssdev,
 	REG_FLD_MOD(DSI_DSIPHY_CFG10, 1, 27, 27); /* ENLPTXSCPDAT */
 }
 
-static void dsi_disable_lane_override(void)
+static void dsi_cio_disable_lane_override(void)
 {
 	/* Disable lane override */
 	REG_FLD_MOD(DSI_DSIPHY_CFG10, 0, 27, 27); /* ENLPTXSCPDAT */
@@ -1935,12 +1935,12 @@ static void dsi_disable_lane_override(void)
 	REG_FLD_MOD(DSI_DSIPHY_CFG10, 0, 22, 17); /* REGLPTXSCPDAT4TO0DXDY */
 }
 
-static int dsi_complexio_init(struct omap_dss_device *dssdev)
+static int dsi_cio_init(struct omap_dss_device *dssdev)
 {
 	int r = 0;
 	u32 l;
 
-	DSSDBG("dsi_complexio_init\n");
+	DSSDBGF();
 
 	if (dsi.ulps_enabled)
 		DSSDBG("manual ulps exit\n");
@@ -1956,7 +1956,7 @@ static int dsi_complexio_init(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	dsi_complexio_config(dssdev);
+	dsi_set_lane_config(dssdev);
 
 	dsi_if_enable(true);
 	dsi_if_enable(false);
@@ -1979,11 +1979,11 @@ static int dsi_complexio_init(struct omap_dss_device *dssdev)
 		 * manually.
 		 */
 
-		dsi_enable_lane_override(dssdev,
+		dsi_cio_enable_lane_override(dssdev,
 				DSI_CLK_P | DSI_DATA1_P | DSI_DATA2_P);
 	}
 
-	r = dsi_complexio_power(DSI_COMPLEXIO_POWER_ON);
+	r = dsi_cio_power(DSI_COMPLEXIO_POWER_ON);
 	if (r)
 		goto err;
 
@@ -1995,7 +1995,7 @@ static int dsi_complexio_init(struct omap_dss_device *dssdev)
 
 		/* Disable the override. The lanes should be set to Mark-11
 		 * state by the HW */
-		dsi_disable_lane_override();
+		dsi_cio_disable_lane_override();
 	}
 
 	/* FORCE_TX_STOP_MODE_IO */
@@ -2007,7 +2007,7 @@ static int dsi_complexio_init(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	dsi_complexio_timings();
+	dsi_cio_timings();
 
 	dsi.ulps_enabled = false;
 
@@ -2016,9 +2016,9 @@ err:
 	return r;
 }
 
-static void dsi_complexio_uninit(void)
+static void dsi_cio_uninit(void)
 {
-	dsi_complexio_power(DSI_COMPLEXIO_POWER_OFF);
+	dsi_cio_power(DSI_COMPLEXIO_POWER_OFF);
 }
 
 static int _dsi_wait_reset(void)
@@ -2892,7 +2892,7 @@ static int dsi_enter_ulps(void)
 	dsi_unregister_isr_cio(dsi_completion_handler, &completion,
 			DSI_CIO_IRQ_ULPSACTIVENOT_ALL0);
 
-	dsi_complexio_power(DSI_COMPLEXIO_POWER_ULPS);
+	dsi_cio_power(DSI_COMPLEXIO_POWER_ULPS);
 
 	dsi_if_enable(false);
 
@@ -3622,7 +3622,7 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	if (r)
 		goto err2;
 
-	r = dsi_complexio_init(dssdev);
+	r = dsi_cio_init(dssdev);
 	if (r)
 		goto err2;
 
@@ -3648,7 +3648,7 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 
 	return 0;
 err3:
-	dsi_complexio_uninit();
+	dsi_cio_uninit();
 err2:
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_FCK);
@@ -3673,7 +3673,7 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 
 	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_FCK);
-	dsi_complexio_uninit();
+	dsi_cio_uninit();
 	dsi_pll_uninit(disconnect_lanes);
 }
 
-- 
1.7.1

