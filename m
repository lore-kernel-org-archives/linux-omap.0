From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/14] OMAPDSS: DSI remove unneeded clk source setup code
Date: Fri, 8 Mar 2013 13:52:41 +0200
Message-ID: <1362743569-10289-7-git-send-email-tomi.valkeinen@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44142 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933870Ab3CHLxV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 06:53:21 -0500
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We always use the same clock sources for DSI, so let's remove the
unnecessary clock source fields from dsi_data.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 7faad58..aabe472 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -269,10 +269,6 @@ struct dsi_data {
 	struct dispc_clock_info user_dispc_cinfo;
 	struct dsi_clock_info user_dsi_cinfo;
 
-	enum omap_dss_clk_source user_dispc_fclk_src;
-	enum omap_dss_clk_source user_lcd_clk_src;
-	enum omap_dss_clk_source user_dsi_fclk_src;
-
 	struct dsi_clock_info current_cinfo;
 
 	bool vdds_dsi_enabled;
@@ -4327,18 +4323,6 @@ static int dsi_set_clocks(struct omap_dss_device *dssdev,
 	dsi->user_dispc_cinfo.lck_div = dispc_cinfo.lck_div;
 	dsi->user_dispc_cinfo.pck_div = dispc_cinfo.pck_div;
 
-	dsi->user_dispc_fclk_src = OMAP_DSS_CLK_SRC_FCK;
-
-	dsi->user_lcd_clk_src =
-		dsi->module_id == 0 ?
-		OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC :
-		OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC;
-
-	dsi->user_dsi_fclk_src =
-		dsi->module_id == 0 ?
-		OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI :
-		OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI;
-
 	return 0;
 err:
 	return r;
@@ -4635,7 +4619,9 @@ static int dsi_display_init_dispc(struct platform_device *dsidev,
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r;
 
-	dss_select_lcd_clk_source(mgr->id, dsi->user_lcd_clk_src);
+	dss_select_lcd_clk_source(mgr->id, dsi->module_id == 0 ?
+			OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC :
+			OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC);
 
 	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE) {
 		dsi->timings.hsw = 1;
@@ -4741,7 +4727,9 @@ static int dsi_display_init_dsi(struct platform_device *dsidev)
 	if (r)
 		goto err1;
 
-	dss_select_dsi_clk_source(dsi->module_id, dsi->user_dsi_fclk_src);
+	dss_select_dsi_clk_source(dsi->module_id, dsi->module_id == 0 ?
+			OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI :
+			OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI);
 
 	DSSDBG("PLL OK\n");
 
-- 
1.7.10.4

