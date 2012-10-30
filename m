From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Tue, 30 Oct 2012 18:10:09 +0200
Message-ID: <1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56517 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933955Ab2J3QKk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 12:10:40 -0400
In-Reply-To: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: rob@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

We currently get the decision whether to use PRCM or DSI PLL clock for
DPI from the board file. This is not a good way to handle it, and it
won't work with device tree.

This patch changes DPI to always use DSI PLL if it's available.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |   64 ++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 267caf0..32e7dd5 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -49,28 +49,30 @@ static struct {
 	struct omap_dss_output output;
 } dpi;
 
-static struct platform_device *dpi_get_dsidev(enum omap_dss_clk_source clk)
+static struct platform_device *dpi_get_dsidev(enum omap_channel channel)
 {
-	int dsi_module;
-
-	dsi_module = clk == OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC ? 0 : 1;
-
-	return dsi_get_dsidev_from_id(dsi_module);
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return dsi_get_dsidev_from_id(0);
+	case OMAP_DSS_CHANNEL_LCD2:
+		return dsi_get_dsidev_from_id(1);
+	default:
+		return NULL;
+	}
 }
 
-static bool dpi_use_dsi_pll(struct omap_dss_device *dssdev)
+static enum omap_dss_clk_source dpi_get_alt_clk_src(enum omap_channel channel)
 {
-	if (dssdev->clocks.dispc.dispc_fclk_src ==
-			OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC ||
-			dssdev->clocks.dispc.dispc_fclk_src ==
-			OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC ||
-			dssdev->clocks.dispc.channel.lcd_clk_src ==
-			OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC ||
-			dssdev->clocks.dispc.channel.lcd_clk_src ==
-			OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC)
-		return true;
-	else
-		return false;
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC;
+	case OMAP_DSS_CHANNEL_LCD2:
+		return OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC;
+	default:
+		/* this shouldn't happen */
+		WARN_ON(1);
+		return OMAP_DSS_CLK_SRC_FCK;
+	}
 }
 
 static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
@@ -92,7 +94,7 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
 		return r;
 
 	dss_select_lcd_clk_source(mgr->id,
-			dssdev->clocks.dispc.channel.lcd_clk_src);
+			dpi_get_alt_clk_src(mgr->id));
 
 	dpi.mgr_config.clock_info = dispc_cinfo;
 
@@ -385,6 +387,8 @@ static int __init dpi_verify_dsi_pll(struct platform_device *dsidev)
 
 static int __init dpi_init_display(struct omap_dss_device *dssdev)
 {
+	struct platform_device *dsidev;
+
 	DSSDBG("init_display\n");
 
 	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) &&
@@ -401,17 +405,23 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 		dpi.vdds_dsi_reg = vdds_dsi;
 	}
 
-	if (dpi_use_dsi_pll(dssdev)) {
-		enum omap_dss_clk_source dispc_fclk_src =
-			dssdev->clocks.dispc.dispc_fclk_src;
-		dpi.dsidev = dpi_get_dsidev(dispc_fclk_src);
+	/*
+	 * XXX We shouldn't need dssdev->channel for this. The dsi pll clock
+	 * source for DPI is SoC integration detail, not something that should
+	 * be configured in the dssdev
+	 */
+	dsidev = dpi_get_dsidev(dssdev->channel);
 
-		if (dpi_verify_dsi_pll(dpi.dsidev)) {
-			dpi.dsidev = NULL;
-			DSSWARN("DSI PLL not operational\n");
-		}
+	if (dpi_verify_dsi_pll(dsidev)) {
+		dsidev = NULL;
+		DSSWARN("DSI PLL not operational\n");
 	}
 
+	if (dsidev)
+		DSSDBG("using DSI PLL for DPI clock\n");
+
+	dpi.dsidev = dsidev;
+
 	return 0;
 }
 
-- 
1.7.10.4

