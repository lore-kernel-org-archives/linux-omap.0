From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/22] OMAPDSS: DSI: remove unused hsdiv wait funcs
Date: Wed, 12 Nov 2014 13:52:04 +0200
Message-ID: <1415793144-11723-3-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38565 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014AbaKLLwr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:52:47 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

With the previous patch "OMAPDSS: DSI: wait for hsdiv clocks when
enabling PLL",  dsi_wait_pll_hsdiv_dispc_active and
dsi_wait_pll_hsdiv_dsi_active are no longer needed, so they and the
callers can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dsi.c | 15 ---------------
 drivers/video/fbdev/omap2/dss/dss.c | 15 ---------------
 drivers/video/fbdev/omap2/dss/dss.h |  8 --------
 3 files changed, 38 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index fe8196b17a5e..b7acdcd76f73 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -5255,21 +5255,6 @@ static void dsi_release_vc(struct omap_dss_device *dssdev, int channel)
 	}
 }
 
-void dsi_wait_pll_hsdiv_dispc_active(struct platform_device *dsidev)
-{
-	if (wait_for_bit_change(dsidev, DSI_PLL_STATUS, 7, 1) != 1)
-		DSSERR("%s (%s) not active\n",
-			dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
-			dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC));
-}
-
-void dsi_wait_pll_hsdiv_dsi_active(struct platform_device *dsidev)
-{
-	if (wait_for_bit_change(dsidev, DSI_PLL_STATUS, 8, 1) != 1)
-		DSSERR("%s (%s) not active\n",
-			dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
-			dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI));
-}
 
 static void dsi_calc_clock_param_ranges(struct platform_device *dsidev)
 {
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 5f6942c5df1c..702c495083ed 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -296,7 +296,6 @@ static void dss_dump_regs(struct seq_file *s)
 
 static void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 {
-	struct platform_device *dsidev;
 	int b;
 	u8 start, end;
 
@@ -306,13 +305,9 @@ static void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 		break;
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 		b = 1;
-		dsidev = dsi_get_dsidev_from_id(0);
-		dsi_wait_pll_hsdiv_dispc_active(dsidev);
 		break;
 	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
 		b = 2;
-		dsidev = dsi_get_dsidev_from_id(1);
-		dsi_wait_pll_hsdiv_dispc_active(dsidev);
 		break;
 	default:
 		BUG();
@@ -329,7 +324,6 @@ static void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 void dss_select_dsi_clk_source(int dsi_module,
 		enum omap_dss_clk_source clk_src)
 {
-	struct platform_device *dsidev;
 	int b, pos;
 
 	switch (clk_src) {
@@ -339,14 +333,10 @@ void dss_select_dsi_clk_source(int dsi_module,
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI:
 		BUG_ON(dsi_module != 0);
 		b = 1;
-		dsidev = dsi_get_dsidev_from_id(0);
-		dsi_wait_pll_hsdiv_dsi_active(dsidev);
 		break;
 	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI:
 		BUG_ON(dsi_module != 1);
 		b = 1;
-		dsidev = dsi_get_dsidev_from_id(1);
-		dsi_wait_pll_hsdiv_dsi_active(dsidev);
 		break;
 	default:
 		BUG();
@@ -362,7 +352,6 @@ void dss_select_dsi_clk_source(int dsi_module,
 void dss_select_lcd_clk_source(enum omap_channel channel,
 		enum omap_dss_clk_source clk_src)
 {
-	struct platform_device *dsidev;
 	int b, ix, pos;
 
 	if (!dss_has_feature(FEAT_LCD_CLK_SRC)) {
@@ -377,15 +366,11 @@ void dss_select_lcd_clk_source(enum omap_channel channel,
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 		BUG_ON(channel != OMAP_DSS_CHANNEL_LCD);
 		b = 1;
-		dsidev = dsi_get_dsidev_from_id(0);
-		dsi_wait_pll_hsdiv_dispc_active(dsidev);
 		break;
 	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
 		BUG_ON(channel != OMAP_DSS_CHANNEL_LCD2 &&
 		       channel != OMAP_DSS_CHANNEL_LCD3);
 		b = 1;
-		dsidev = dsi_get_dsidev_from_id(1);
-		dsi_wait_pll_hsdiv_dispc_active(dsidev);
 		break;
 	default:
 		BUG();
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index b70d7dfbfcfb..4617b4d9f78d 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -299,8 +299,6 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
 		bool enable_hsdiv);
 void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes);
-void dsi_wait_pll_hsdiv_dispc_active(struct platform_device *dsidev);
-void dsi_wait_pll_hsdiv_dsi_active(struct platform_device *dsidev);
 struct platform_device *dsi_get_dsidev_from_id(int module);
 #else
 static inline int dsi_runtime_get(struct platform_device *dsidev)
@@ -336,12 +334,6 @@ static inline void dsi_pll_uninit(struct platform_device *dsidev,
 		bool disconnect_lanes)
 {
 }
-static inline void dsi_wait_pll_hsdiv_dispc_active(struct platform_device *dsidev)
-{
-}
-static inline void dsi_wait_pll_hsdiv_dsi_active(struct platform_device *dsidev)
-{
-}
 static inline struct platform_device *dsi_get_dsidev_from_id(int module)
 {
 	return NULL;
-- 
2.1.3

