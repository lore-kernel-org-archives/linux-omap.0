From: Archit Taneja <archit@ti.com>
Subject: [RFC v3][PATCH 3/4] OMAP: DSS2: Interface driver changes for Secondary LCD Channel
Date: Tue,  5 Oct 2010 17:25:23 +0530
Message-ID: <1286279724-11692-4-git-send-email-archit@ti.com>
References: <1286279724-11692-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56021 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960Ab0JELzG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 07:55:06 -0400
In-Reply-To: <1286279724-11692-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Make necessary changes in the interface drivers for the dispc
functions which have the new enum channel added to them

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 drivers/video/omap2/dss/core.c |    2 +-
 drivers/video/omap2/dss/dpi.c  |   38 +++++++++++++++++++++-----------------
 drivers/video/omap2/dss/dsi.c  |   24 +++++++++++++-----------
 drivers/video/omap2/dss/dss.h  |    8 +++++---
 drivers/video/omap2/dss/rfbi.c |   21 ++++++++++++---------
 drivers/video/omap2/dss/sdi.c  |   22 ++++++++++++----------
 6 files changed, 64 insertions(+), 51 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 8e89f60..8755cd6 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -412,7 +412,7 @@ static void dss_debug_dump_clocks(struct seq_file *s)
 	dss_dump_clocks(s);
 	dispc_dump_clocks(s);
 #ifdef CONFIG_OMAP2_DSS_DSI
-	dsi_dump_clocks(s);
+	dsi_dump_clocks(OMAP_DSS_CHANNEL_LCD, s);
 #endif
 }
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 960e977..592c0c0 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -40,8 +40,9 @@ static struct {
 } dpi;
 
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
-static int dpi_set_dsi_clk(bool is_tft, unsigned long pck_req,
-		unsigned long *fck, int *lck_div, int *pck_div)
+static int dpi_set_dsi_clk(enum omap_channel channel, bool is_tft,
+		unsigned long pck_req, unsigned long *fck, int *lck_div,
+		int *pck_div)
 {
 	struct dsi_clock_info dsi_cinfo;
 	struct dispc_clock_info dispc_cinfo;
@@ -58,7 +59,7 @@ static int dpi_set_dsi_clk(bool is_tft, unsigned long pck_req,
 
 	dss_select_dispc_clk_source(DSS_SRC_DSI1_PLL_FCLK);
 
-	r = dispc_set_clock_div(&dispc_cinfo);
+	r = dispc_set_clock_div(channel, &dispc_cinfo);
 	if (r)
 		return r;
 
@@ -69,8 +70,9 @@ static int dpi_set_dsi_clk(bool is_tft, unsigned long pck_req,
 	return 0;
 }
 #else
-static int dpi_set_dispc_clk(bool is_tft, unsigned long pck_req,
-		unsigned long *fck, int *lck_div, int *pck_div)
+static int dpi_set_dispc_clk(enum omap_channel channel, bool is_tft,
+		unsigned long pck_req, unsigned long *fck, int *lck_div,
+		int *pck_div)
 {
 	struct dss_clock_info dss_cinfo;
 	struct dispc_clock_info dispc_cinfo;
@@ -84,7 +86,7 @@ static int dpi_set_dispc_clk(bool is_tft, unsigned long pck_req,
 	if (r)
 		return r;
 
-	r = dispc_set_clock_div(&dispc_cinfo);
+	r = dispc_set_clock_div(channel, &dispc_cinfo);
 	if (r)
 		return r;
 
@@ -107,17 +109,17 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
-	dispc_set_pol_freq(dssdev->panel.config, dssdev->panel.acbi,
-			dssdev->panel.acb);
+	dispc_set_pol_freq(dssdev->channel, dssdev->panel.config,
+		dssdev->panel.acbi, dssdev->panel.acb);
 
 	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
 
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
-	r = dpi_set_dsi_clk(is_tft, t->pixel_clock * 1000,
-			&fck, &lck_div, &pck_div);
+	r = dpi_set_dsi_clk(dssdev->channel, is_tft,
+			t->pixel_clock * 1000, &fck, &lck_div, &pck_div);
 #else
-	r = dpi_set_dispc_clk(is_tft, t->pixel_clock * 1000,
-			&fck, &lck_div, &pck_div);
+	r = dpi_set_dispc_clk(dssdev->channel, is_tft,
+			t->pixel_clock * 1000, &fck, &lck_div, &pck_div);
 #endif
 	if (r)
 		goto err0;
@@ -132,7 +134,7 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 		t->pixel_clock = pck;
 	}
 
-	dispc_set_lcd_timings(t);
+	dispc_set_lcd_timings(dssdev->channel, t);
 
 err0:
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
@@ -145,10 +147,12 @@ static int dpi_basic_init(struct omap_dss_device *dssdev)
 
 	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
 
-	dispc_set_parallel_interface_mode(OMAP_DSS_PARALLELMODE_BYPASS);
-	dispc_set_lcd_display_type(is_tft ? OMAP_DSS_LCD_DISPLAY_TFT :
-			OMAP_DSS_LCD_DISPLAY_STN);
-	dispc_set_tft_data_lines(dssdev->phy.dpi.data_lines);
+	dispc_set_parallel_interface_mode(dssdev->channel,
+						OMAP_DSS_PARALLELMODE_BYPASS);
+	dispc_set_lcd_display_type(dssdev->channel,
+		is_tft ? OMAP_DSS_LCD_DISPLAY_TFT : OMAP_DSS_LCD_DISPLAY_STN);
+	dispc_set_tft_data_lines(dssdev->channel,
+				dssdev->phy.dpi.data_lines);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index b3fa3a7..87b7f90 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -812,7 +812,7 @@ static int dsi_calc_clock_rates(struct dsi_clock_info *cinfo)
 		 * with DSS2_FCK source also */
 		cinfo->highfreq = 0;
 	} else {
-		cinfo->clkin = dispc_pclk_rate();
+		cinfo->clkin = dispc_pclk_rate(OMAP_DSS_CHANNEL_LCD);
 
 		if (cinfo->clkin < 32000000)
 			cinfo->highfreq = 0;
@@ -1157,7 +1157,7 @@ void dsi_pll_uninit(void)
 	DSSDBG("PLL uninit done\n");
 }
 
-void dsi_dump_clocks(struct seq_file *s)
+void dsi_dump_clocks(enum omap_channel channel, struct seq_file *s)
 {
 	int clksel;
 	struct dsi_clock_info *cinfo = &dsi.current_cinfo;
@@ -1206,8 +1206,8 @@ void dsi_dump_clocks(struct seq_file *s)
 
 	seq_printf(s,	"VP_CLK\t\t%lu\n"
 			"VP_PCLK\t\t%lu\n",
-			dispc_lclk_rate(),
-			dispc_pclk_rate());
+			dispc_lclk_rate(channel),
+			dispc_pclk_rate(channel));
 
 	enable_clocks(0);
 }
@@ -2888,7 +2888,7 @@ int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
 	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
 		dss_setup_partial_planes(dssdev, x, y, w, h,
 				enlarge_update_area);
-		dispc_set_lcd_size(*w, *h);
+		dispc_set_lcd_size(dssdev->channel, *w, *h);
 	}
 
 	return 0;
@@ -2947,12 +2947,14 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 		return r;
 	}
 
-	dispc_set_lcd_display_type(OMAP_DSS_LCD_DISPLAY_TFT);
+	dispc_set_lcd_display_type(dssdev->channel,
+					OMAP_DSS_LCD_DISPLAY_TFT);
 
-	dispc_set_parallel_interface_mode(OMAP_DSS_PARALLELMODE_DSI);
-	dispc_enable_fifohandcheck(1);
+	dispc_set_parallel_interface_mode(dssdev->channel,
+					OMAP_DSS_PARALLELMODE_DSI);
+	dispc_enable_fifohandcheck(dssdev->channel, 1);
 
-	dispc_set_tft_data_lines(dssdev->ctrl.pixel_size);
+	dispc_set_tft_data_lines(dssdev->channel, dssdev->ctrl.pixel_size);
 
 	{
 		struct omap_video_timings timings = {
@@ -2964,7 +2966,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 			.vbp		= 0,
 		};
 
-		dispc_set_lcd_timings(&timings);
+		dispc_set_lcd_timings(dssdev->channel, &timings);
 	}
 
 	return 0;
@@ -3019,7 +3021,7 @@ static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
 		return r;
 	}
 
-	r = dispc_set_clock_div(&dispc_cinfo);
+	r = dispc_set_clock_div(dssdev->channel, &dispc_cinfo);
 	if (r) {
 		DSSERR("Failed to set dispc clocks\n");
 		return r;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 62b3ead..2efbb4f 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -262,7 +262,8 @@ static inline void sdi_exit(void)
 int dsi_init(struct platform_device *pdev);
 void dsi_exit(void);
 
-void dsi_dump_clocks(struct seq_file *s);
+void dsi_dump_clocks(enum omap_channel channel,
+		struct seq_file *s);
 void dsi_dump_irqs(struct seq_file *s);
 void dsi_dump_regs(struct seq_file *s);
 
@@ -431,8 +432,9 @@ void rfbi_dump_regs(struct seq_file *s);
 
 int rfbi_configure(int rfbi_module, int bpp, int lines);
 void rfbi_enable_rfbi(bool enable);
-void rfbi_transfer_area(u16 width, u16 height,
-			     void (callback)(void *data), void *data);
+void rfbi_transfer_area(struct omap_dss_device *dssdev,
+		u16 width, u16 height,
+		void (callback)(void *data), void *data);
 void rfbi_set_timings(int rfbi_module, struct rfbi_timings *t);
 unsigned long rfbi_get_max_tx_rate(void);
 int rfbi_init_display(struct omap_dss_device *display);
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index bbe6246..f7e9b95 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -301,8 +301,8 @@ void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
 }
 EXPORT_SYMBOL(omap_rfbi_write_pixels);
 
-void rfbi_transfer_area(u16 width, u16 height,
-			     void (callback)(void *data), void *data)
+void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
+			u16 height, void (*callback)(void *data), void *data)
 {
 	u32 l;
 
@@ -311,9 +311,9 @@ void rfbi_transfer_area(u16 width, u16 height,
 
 	DSSDBG("rfbi_transfer_area %dx%d\n", width, height);
 
-	dispc_set_lcd_size(width, height);
+	dispc_set_lcd_size(dssdev->channel, width, height);
 
-	dispc_enable_channel(OMAP_DSS_CHANNEL_LCD, true);
+	dispc_enable_channel(dssdev->channel, true);
 
 	rfbi.framedone_callback = callback;
 	rfbi.framedone_callback_data = data;
@@ -887,7 +887,7 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 
 	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
 		dss_setup_partial_planes(dssdev, x, y, w, h, true);
-		dispc_set_lcd_size(*w, *h);
+		dispc_set_lcd_size(dssdev->channel, *w, *h);
 	}
 
 	return 0;
@@ -899,7 +899,7 @@ int omap_rfbi_update(struct omap_dss_device *dssdev,
 		void (*callback)(void *), void *data)
 {
 	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
-		rfbi_transfer_area(w, h, callback, data);
+		rfbi_transfer_area(dssdev, w, h, callback, data);
 	} else {
 		struct omap_overlay *ovl;
 		void __iomem *addr;
@@ -1018,11 +1018,14 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 		goto err1;
 	}
 
-	dispc_set_lcd_display_type(OMAP_DSS_LCD_DISPLAY_TFT);
+	dispc_set_lcd_display_type(dssdev->channel,
+					OMAP_DSS_LCD_DISPLAY_TFT);
 
-	dispc_set_parallel_interface_mode(OMAP_DSS_PARALLELMODE_RFBI);
+	dispc_set_parallel_interface_mode(dssdev->channel,
+					OMAP_DSS_PARALLELMODE_RFBI);
 
-	dispc_set_tft_data_lines(dssdev->ctrl.pixel_size);
+	dispc_set_tft_data_lines(dssdev->channel,
+					dssdev->ctrl.pixel_size);
 
 	rfbi_configure(dssdev->phy.rfbi.channel,
 			       dssdev->ctrl.pixel_size,
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index ee07a3c..2f8924b 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -35,12 +35,14 @@ static struct {
 	struct regulator *vdds_sdi_reg;
 } sdi;
 
-static void sdi_basic_init(void)
+static void sdi_basic_init(struct omap_dss_device *dssdev)
 {
-	dispc_set_parallel_interface_mode(OMAP_DSS_PARALLELMODE_BYPASS);
+	dispc_set_parallel_interface_mode(dssdev->channel,
+					OMAP_DSS_PARALLELMODE_BYPASS);
 
-	dispc_set_lcd_display_type(OMAP_DSS_LCD_DISPLAY_TFT);
-	dispc_set_tft_data_lines(24);
+	dispc_set_lcd_display_type(dssdev->channel,
+					OMAP_DSS_LCD_DISPLAY_TFT);
+	dispc_set_tft_data_lines(dssdev->channel, 24);
 	dispc_lcd_enable_signal_polarity(1);
 }
 
@@ -68,20 +70,20 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	if (!sdi.skip_init)
 		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
-	sdi_basic_init();
+	sdi_basic_init(dssdev);
 
 	/* 15.5.9.1.2 */
 	dssdev->panel.config |= OMAP_DSS_LCD_RF | OMAP_DSS_LCD_ONOFF;
 
-	dispc_set_pol_freq(dssdev->panel.config, dssdev->panel.acbi,
-			dssdev->panel.acb);
+	dispc_set_pol_freq(dssdev->channel, dssdev->panel.config,
+				dssdev->panel.acbi, dssdev->panel.acb);
 
 	if (!sdi.skip_init) {
 		r = dss_calc_clock_div(1, t->pixel_clock * 1000,
 				&dss_cinfo, &dispc_cinfo);
 	} else {
 		r = dss_get_clock_div(&dss_cinfo);
-		r = dispc_get_clock_div(&dispc_cinfo);
+		r = dispc_get_clock_div(dssdev->channel, &dispc_cinfo);
 	}
 
 	if (r)
@@ -102,13 +104,13 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	}
 
 
-	dispc_set_lcd_timings(t);
+	dispc_set_lcd_timings(dssdev->channel, t);
 
 	r = dss_set_clock_div(&dss_cinfo);
 	if (r)
 		goto err2;
 
-	r = dispc_set_clock_div(&dispc_cinfo);
+	r = dispc_set_clock_div(dssdev->channel, &dispc_cinfo);
 	if (r)
 		goto err2;
 
-- 
1.7.0.4

