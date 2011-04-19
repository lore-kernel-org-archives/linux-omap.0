From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/19] OMAP: DSS2: DSI: implement enable/disable SCP clk
Date: Tue, 19 Apr 2011 12:22:11 +0300
Message-ID: <1303204942-25450-9-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:56264 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754209Ab1DSJWt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:22:49 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

SCP clock is needed for CIO on OMAP3, and for CIO and PLL on OMAP4.
Current driver enables the CIO clock always when DSI display is
initialized. However, if a DPI display tries to use DSI PLL, the SCP
clock is never enabled.

This patch implements simple ref counting enable/disable functions for
SCP clock.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   33 ++++++++++++++++++++++++++++-----
 1 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a6b6ca6..9a0f9e4 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -305,6 +305,8 @@ static struct
 	unsigned long  regm_dispc_max, regm_dsi_max;
 	unsigned long  fint_min, fint_max;
 	unsigned long lpdiv_max;
+
+	unsigned scp_clk_refcount;
 } dsi;
 
 #ifdef DEBUG
@@ -1073,6 +1075,18 @@ static int dsi_set_lp_clk_divisor(struct omap_dss_device *dssdev)
 	return 0;
 }
 
+static void dsi_enable_scp_clk(void)
+{
+	if (dsi.scp_clk_refcount++ == 0)
+		REG_FLD_MOD(DSI_CLK_CTRL, 1, 14, 14); /* CIO_CLK_ICG */
+}
+
+static void dsi_disable_scp_clk(void)
+{
+	WARN_ON(dsi.scp_clk_refcount == 0);
+	if (--dsi.scp_clk_refcount == 0)
+		REG_FLD_MOD(DSI_CLK_CTRL, 0, 14, 14); /* CIO_CLK_ICG */
+}
 
 enum dsi_pll_power_state {
 	DSI_PLL_POWER_OFF	= 0x0,
@@ -1458,6 +1472,10 @@ int dsi_pll_init(struct omap_dss_device *dssdev, bool enable_hsclk,
 
 	enable_clocks(1);
 	dsi_enable_pll_clock(1);
+	/*
+	 * Note: SCP CLK is not required on OMAP3, but it is required on OMAP4.
+	 */
+	dsi_enable_scp_clk();
 
 	if (!dsi.vdds_dsi_enabled) {
 		r = regulator_enable(dsi.vdds_dsi_reg);
@@ -1503,6 +1521,7 @@ err1:
 		dsi.vdds_dsi_enabled = false;
 	}
 err0:
+	dsi_disable_scp_clk();
 	enable_clocks(0);
 	dsi_enable_pll_clock(0);
 	return r;
@@ -1510,9 +1529,6 @@ err0:
 
 void dsi_pll_uninit(bool disconnect_lanes)
 {
-	enable_clocks(0);
-	dsi_enable_pll_clock(0);
-
 	dsi.pll_locked = 0;
 	dsi_pll_power(DSI_PLL_POWER_OFF);
 	if (disconnect_lanes) {
@@ -1520,6 +1536,11 @@ void dsi_pll_uninit(bool disconnect_lanes)
 		regulator_disable(dsi.vdds_dsi_reg);
 		dsi.vdds_dsi_enabled = false;
 	}
+
+	dsi_disable_scp_clk();
+	enable_clocks(0);
+	dsi_enable_pll_clock(0);
+
 	DSSDBG("PLL uninit done\n");
 }
 
@@ -3611,8 +3632,7 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	int r;
 
 	/* The SCPClk is required for both PLL and CIO registers on OMAP4 */
-	/* CIO_CLK_ICG, enable L3 clk to CIO */
-	REG_FLD_MOD(DSI_CLK_CTRL, 1, 14, 14);
+	dsi_enable_scp_clk();
 
 	_dsi_print_reset_status();
 
@@ -3668,6 +3688,7 @@ err2:
 err1:
 	dsi_pll_uninit(true);
 err0:
+	dsi_disable_scp_clk();
 	return r;
 }
 
@@ -3688,6 +3709,7 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dsi_cio_uninit();
 	dsi_pll_uninit(disconnect_lanes);
+	dsi_disable_scp_clk();
 }
 
 static int dsi_core_init(void)
@@ -4013,6 +4035,7 @@ err_dsi:
 static int omap_dsi1hw_remove(struct platform_device *pdev)
 {
 	dsi_exit();
+	WARN_ON(dsi.scp_clk_refcount > 0);
 	return 0;
 }
 
-- 
1.7.1

