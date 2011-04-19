From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/19] OMAP: DSS2: DSI: fix CIO init and uninit
Date: Tue, 19 Apr 2011 12:22:12 +0300
Message-ID: <1303204942-25450-10-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:53928 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754317Ab1DSJWx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:22:53 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use dsi_enable_scp_clk and dsi_disable_scp_clk in CIO init and uninit,
and improve the CIO init by adding a few status checks and error
handling.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   54 ++++++++++++++++++++++-------------------
 1 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 9a0f9e4..9f450af 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1971,13 +1971,12 @@ static void dsi_cio_disable_lane_override(void)
 
 static int dsi_cio_init(struct omap_dss_device *dssdev)
 {
-	int r = 0;
+	int r;
 	u32 l;
 
 	DSSDBGF();
 
-	if (dsi.ulps_enabled)
-		DSSDBG("manual ulps exit\n");
+	dsi_enable_scp_clk();
 
 	/* A dummy read using the SCP interface to any DSIPHY register is
 	 * required after DSIPHY reset to complete the reset of the DSI complex
@@ -1985,17 +1984,13 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	dsi_read_reg(DSI_DSIPHY_CFG5);
 
 	if (wait_for_bit_change(DSI_DSIPHY_CFG5, 30, 1) != 1) {
-		DSSERR("ComplexIO PHY not coming out of reset.\n");
-		r = -ENODEV;
-		goto err;
+		DSSERR("CIO SCP Clock domain not coming out of reset.\n");
+		r = -EIO;
+		goto err_scp_clk_dom;
 	}
 
 	dsi_set_lane_config(dssdev);
 
-	dsi_if_enable(true);
-	dsi_if_enable(false);
-	REG_FLD_MOD(DSI_CLK_CTRL, 1, 20, 20); /* LP_CLK_ENABLE */
-
 	/* set TX STOP MODE timer to maximum for this operation */
 	l = dsi_read_reg(DSI_TIMING1);
 	l = FLD_MOD(l, 1, 15, 15);	/* FORCE_TX_STOP_MODE_IO */
@@ -2005,6 +2000,8 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	dsi_write_reg(DSI_TIMING1, l);
 
 	if (dsi.ulps_enabled) {
+		DSSDBG("manual ulps exit\n");
+
 		/* ULPS is exited by Mark-1 state for 1ms, followed by
 		 * stop state. DSS HW cannot do this via the normal
 		 * ULPS exit sequence, as after reset the DSS HW thinks
@@ -2019,7 +2016,17 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 
 	r = dsi_cio_power(DSI_COMPLEXIO_POWER_ON);
 	if (r)
-		goto err;
+		goto err_cio_pwr;
+
+	if (wait_for_bit_change(DSI_COMPLEXIO_CFG1, 29, 1) != 1) {
+		DSSERR("CIO PWR clock domain not coming out of reset.\n");
+		r = -ENODEV;
+		goto err_cio_pwr_dom;
+	}
+
+	dsi_if_enable(true);
+	dsi_if_enable(false);
+	REG_FLD_MOD(DSI_CLK_CTRL, 1, 20, 20); /* LP_CLK_ENABLE */
 
 	if (dsi.ulps_enabled) {
 		/* Keep Mark-1 state for 1ms (as per DSI spec) */
@@ -2035,24 +2042,28 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	/* FORCE_TX_STOP_MODE_IO */
 	REG_FLD_MOD(DSI_TIMING1, 0, 15, 15);
 
-	if (wait_for_bit_change(DSI_COMPLEXIO_CFG1, 29, 1) != 1) {
-		DSSERR("ComplexIO not coming out of reset.\n");
-		r = -ENODEV;
-		goto err;
-	}
-
 	dsi_cio_timings();
 
 	dsi.ulps_enabled = false;
 
 	DSSDBG("CIO init done\n");
-err:
+
+	return 0;
+
+err_cio_pwr_dom:
+	dsi_cio_power(DSI_COMPLEXIO_POWER_OFF);
+err_cio_pwr:
+	if (dsi.ulps_enabled)
+		dsi_cio_disable_lane_override();
+err_scp_clk_dom:
+	dsi_disable_scp_clk();
 	return r;
 }
 
 static void dsi_cio_uninit(void)
 {
 	dsi_cio_power(DSI_COMPLEXIO_POWER_OFF);
+	dsi_disable_scp_clk();
 }
 
 static int _dsi_wait_reset(void)
@@ -3631,11 +3642,6 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 {
 	int r;
 
-	/* The SCPClk is required for both PLL and CIO registers on OMAP4 */
-	dsi_enable_scp_clk();
-
-	_dsi_print_reset_status();
-
 	r = dsi_pll_init(dssdev, true, true);
 	if (r)
 		goto err0;
@@ -3688,7 +3694,6 @@ err2:
 err1:
 	dsi_pll_uninit(true);
 err0:
-	dsi_disable_scp_clk();
 	return r;
 }
 
@@ -3709,7 +3714,6 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dsi_cio_uninit();
 	dsi_pll_uninit(disconnect_lanes);
-	dsi_disable_scp_clk();
 }
 
 static int dsi_core_init(void)
-- 
1.7.1

