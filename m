From: Archit Taneja <archit@ti.com>
Subject: [PATCH 4/4] OMAP2PLUS: DSS2: Remove hack config "CONFIG_OMAP2_DSS_USE_DSI_PLL"
Date: Tue, 12 Apr 2011 13:52:26 +0530
Message-ID: <1302596546-14888-5-git-send-email-archit@ti.com>
References: <1302596546-14888-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51533 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab1DLISC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Apr 2011 04:18:02 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3C8I2Ph003265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 12 Apr 2011 03:18:02 -0500
In-Reply-To: <1302596546-14888-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The clock sources for DISPC_FCLK and LCD1_CLK are now specified in the board file.
There is no need for the hack config "CONFIG_OMAP2_DSS_USE_DSI_PLL" anymore.
Introduce function dpi_use_dsi_pll() which checks for the clock sources to decide
whether DSI PLL is to be used or not.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/Kconfig |    8 ----
 drivers/video/omap2/dss/dpi.c   |   81 ++++++++++++++++++++-------------------
 drivers/video/omap2/dss/dsi.c   |    7 ---
 3 files changed, 42 insertions(+), 54 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 5b45c0c..7a49a75 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -90,14 +90,6 @@ config OMAP2_DSS_DSI
 
 	  See http://www.mipi.org/ for DSI spesifications.
 
-config OMAP2_DSS_USE_DSI_PLL
-	bool "Use DSI PLL for PCLK (EXPERIMENTAL)"
-	default n
-	depends on OMAP2_DSS_DSI
-	help
-	  Use DSI PLL to generate pixel clock.  Currently only for DPI output.
-	  DSI PLL can be used to generate higher and more precise pixel clocks.
-
 config OMAP2_DSS_FAKE_VSYNC
 	bool "Fake VSYNC irq from manual update displays"
 	default n
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 55d9157..737c738 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -39,7 +39,17 @@ static struct {
 	struct regulator *vdds_dsi_reg;
 } dpi;
 
-#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
+static bool dpi_use_dsi_pll(struct omap_dss_device *dssdev)
+{
+	if (dssdev->clocks.dispc.dispc_fclk_src ==
+			OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC ||
+			dssdev->clocks.dispc.channel.lcd_clk_src ==
+			OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC)
+		return true;
+	else
+		return false;
+}
+
 static int dpi_set_dsi_clk(struct omap_dss_device *dssdev, bool is_tft,
 		unsigned long pck_req, unsigned long *fck, int *lck_div,
 		int *pck_div)
@@ -69,7 +79,7 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev, bool is_tft,
 
 	return 0;
 }
-#else
+
 static int dpi_set_dispc_clk(struct omap_dss_device *dssdev, bool is_tft,
 		unsigned long pck_req, unsigned long *fck, int *lck_div,
 		int *pck_div)
@@ -96,13 +106,12 @@ static int dpi_set_dispc_clk(struct omap_dss_device *dssdev, bool is_tft,
 
 	return 0;
 }
-#endif
 
 static int dpi_set_mode(struct omap_dss_device *dssdev)
 {
 	struct omap_video_timings *t = &dssdev->panel.timings;
-	int lck_div, pck_div;
-	unsigned long fck;
+	int lck_div = 0, pck_div = 0;
+	unsigned long fck = 0;
 	unsigned long pck;
 	bool is_tft;
 	int r = 0;
@@ -114,13 +123,12 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 
 	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
 
-#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
-	r = dpi_set_dsi_clk(dssdev, is_tft, t->pixel_clock * 1000, &fck,
-			&lck_div, &pck_div);
-#else
-	r = dpi_set_dispc_clk(dssdev, is_tft, t->pixel_clock * 1000, &fck,
-			&lck_div, &pck_div);
-#endif
+	if (dpi_use_dsi_pll(dssdev))
+		r = dpi_set_dsi_clk(dssdev, is_tft, t->pixel_clock * 1000,
+				&fck, &lck_div, &pck_div);
+	else
+		r = dpi_set_dispc_clk(dssdev, is_tft, t->pixel_clock * 1000,
+				&fck, &lck_div, &pck_div);
 	if (r)
 		goto err0;
 
@@ -179,12 +187,13 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err2;
 
-#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
-	dss_clk_enable(DSS_CLK_SYSCK);
-	r = dsi_pll_init(dssdev, 0, 1);
-	if (r)
-		goto err3;
-#endif
+	if (dpi_use_dsi_pll(dssdev)) {
+		dss_clk_enable(DSS_CLK_SYSCK);
+		r = dsi_pll_init(dssdev, 0, 1);
+		if (r)
+			goto err3;
+	}
+
 	r = dpi_set_mode(dssdev);
 	if (r)
 		goto err4;
@@ -196,11 +205,11 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 	return 0;
 
 err4:
-#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
-	dsi_pll_uninit();
+	if (dpi_use_dsi_pll(dssdev))
+		dsi_pll_uninit();
 err3:
-	dss_clk_disable(DSS_CLK_SYSCK);
-#endif
+	if (dpi_use_dsi_pll(dssdev))
+		dss_clk_disable(DSS_CLK_SYSCK);
 err2:
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 	if (cpu_is_omap34xx())
@@ -216,11 +225,11 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 {
 	dssdev->manager->disable(dssdev->manager);
 
-#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
-	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
-	dsi_pll_uninit();
-	dss_clk_disable(DSS_CLK_SYSCK);
-#endif
+	if (dpi_use_dsi_pll(dssdev)) {
+		dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
+		dsi_pll_uninit();
+		dss_clk_disable(DSS_CLK_SYSCK);
+	}
 
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 
@@ -251,6 +260,7 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 	int lck_div, pck_div;
 	unsigned long fck;
 	unsigned long pck;
+	struct dispc_clock_info dispc_cinfo;
 
 	if (!dispc_lcd_timings_ok(timings))
 		return -EINVAL;
@@ -260,10 +270,8 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 
 	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
 
-#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
-	{
+	if (dpi_use_dsi_pll(dssdev)) {
 		struct dsi_clock_info dsi_cinfo;
-		struct dispc_clock_info dispc_cinfo;
 		r = dsi_pll_calc_clock_div_pck(is_tft,
 				timings->pixel_clock * 1000,
 				&dsi_cinfo, &dispc_cinfo);
@@ -272,13 +280,8 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 			return r;
 
 		fck = dsi_cinfo.dsi_pll_hsdiv_dispc_clk;
-		lck_div = dispc_cinfo.lck_div;
-		pck_div = dispc_cinfo.pck_div;
-	}
-#else
-	{
+	} else {
 		struct dss_clock_info dss_cinfo;
-		struct dispc_clock_info dispc_cinfo;
 		r = dss_calc_clock_div(is_tft, timings->pixel_clock * 1000,
 				&dss_cinfo, &dispc_cinfo);
 
@@ -286,10 +289,10 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 			return r;
 
 		fck = dss_cinfo.fck;
-		lck_div = dispc_cinfo.lck_div;
-		pck_div = dispc_cinfo.pck_div;
 	}
-#endif
+
+	lck_div = dispc_cinfo.lck_div;
+	pck_div = dispc_cinfo.pck_div;
 
 	pck = fck / lck_div / pck_div / 1000;
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 6a51c07..7f8a788 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1409,12 +1409,6 @@ int dsi_pll_init(struct omap_dss_device *dssdev, bool enable_hsclk,
 
 	DSSDBG("PLL init\n");
 
-#ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
-	/*
-	 * HACK: this is just a quick hack to get the USE_DSI_PLL
-	 * option working. USE_DSI_PLL is itself a big hack, and
-	 * should be removed.
-	 */
 	if (dsi.vdds_dsi_reg == NULL) {
 		struct regulator *vdds_dsi;
 
@@ -1427,7 +1421,6 @@ int dsi_pll_init(struct omap_dss_device *dssdev, bool enable_hsclk,
 
 		dsi.vdds_dsi_reg = vdds_dsi;
 	}
-#endif
 
 	enable_clocks(1);
 	dsi_enable_pll_clock(1);
-- 
1.7.1

