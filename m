From: Archit Taneja <archit@ti.com>
Subject: [PATCH v4 4/7] OMAP: DSS2: Change remaining Dispc functions for new 'channel' argument
Date: Mon,  8 Nov 2010 17:54:22 +0530
Message-ID: <1289219065-1362-5-git-send-email-archit@ti.com>
References: <1289219065-1362-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50640 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892Ab0KHMX4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 07:23:56 -0500
In-Reply-To: <1289219065-1362-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Mukund Mittal <mmittal@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

The following dispc functions are changed to incorporate channel as an argument:
	-dispc_lclk_rate()
	-dispc_pclk_rate()
	-dispc_set_pol_freq()
	-dispc_set_clock_div()
	-dispc_get_clock_div()

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   62 ++++++++++++++++++++++-----------------
 drivers/video/omap2/dss/dpi.c   |   22 +++++++------
 drivers/video/omap2/dss/dsi.c   |    8 ++--
 drivers/video/omap2/dss/dss.h   |   13 +++++---
 drivers/video/omap2/dss/sdi.c   |    8 ++--
 5 files changed, 63 insertions(+), 50 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 2ea1a7a..b9be4fd 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1442,12 +1442,13 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
 	}
 }
 
-static unsigned long calc_fclk_five_taps(u16 width, u16 height,
-		u16 out_width, u16 out_height, enum omap_color_mode color_mode)
+static unsigned long calc_fclk_five_taps(enum omap_channel channel, u16 width,
+		u16 height, u16 out_width, u16 out_height,
+		enum omap_color_mode color_mode)
 {
 	u32 fclk = 0;
 	/* FIXME venc pclk? */
-	u64 tmp, pclk = dispc_pclk_rate();
+	u64 tmp, pclk = dispc_pclk_rate(channel);
 
 	if (height > out_height) {
 		/* FIXME get real display PPL */
@@ -1479,8 +1480,8 @@ static unsigned long calc_fclk_five_taps(u16 width, u16 height,
 	return fclk;
 }
 
-static unsigned long calc_fclk(u16 width, u16 height,
-		u16 out_width, u16 out_height)
+static unsigned long calc_fclk(enum omap_channel channel, u16 width,
+		u16 height, u16 out_width, u16 out_height)
 {
 	unsigned int hf, vf;
 
@@ -1504,7 +1505,7 @@ static unsigned long calc_fclk(u16 width, u16 height,
 		vf = 1;
 
 	/* FIXME venc pclk? */
-	return dispc_pclk_rate() * vf * hf;
+	return dispc_pclk_rate(channel) * vf * hf;
 }
 
 void dispc_set_channel_out(enum omap_plane plane, enum omap_channel channel_out)
@@ -1623,7 +1624,7 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		five_taps = height > out_height * 2;
 
 		if (!five_taps) {
-			fclk = calc_fclk(width, height,
+			fclk = calc_fclk(OMAP_DSS_CHANNEL_LCD, width, height,
 					out_width, out_height);
 
 			/* Try 5-tap filter if 3-tap fclk is too high */
@@ -1638,8 +1639,9 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		}
 
 		if (five_taps)
-			fclk = calc_fclk_five_taps(width, height,
-					out_width, out_height, color_mode);
+			fclk = calc_fclk_five_taps(OMAP_DSS_CHANNEL_LCD, width,
+					height, out_width, out_height,
+					color_mode);
 
 		DSSDBG("required fclk rate = %lu Hz\n", fclk);
 		DSSDBG("current fclk rate = %lu Hz\n", dispc_fclk_rate());
@@ -2200,13 +2202,14 @@ void dispc_set_lcd_timings(enum omap_channel channel,
 	DSSDBG("hsync %luHz, vsync %luHz\n", ht, vt);
 }
 
-static void dispc_set_lcd_divisor(u16 lck_div, u16 pck_div)
+static void dispc_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
+		u16 pck_div)
 {
 	BUG_ON(lck_div < 1);
 	BUG_ON(pck_div < 2);
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD),
+	dispc_write_reg(DISPC_DIVISOR(channel),
 			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
 	enable_clocks(0);
 }
@@ -2234,13 +2237,13 @@ unsigned long dispc_fclk_rate(void)
 	return r;
 }
 
-unsigned long dispc_lclk_rate(void)
+unsigned long dispc_lclk_rate(enum omap_channel channel)
 {
 	int lcd;
 	unsigned long r;
 	u32 l;
 
-	l = dispc_read_reg(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD));
+	l = dispc_read_reg(DISPC_DIVISOR(channel));
 
 	lcd = FLD_GET(l, 23, 16);
 
@@ -2249,13 +2252,13 @@ unsigned long dispc_lclk_rate(void)
 	return r / lcd;
 }
 
-unsigned long dispc_pclk_rate(void)
+unsigned long dispc_pclk_rate(enum omap_channel channel)
 {
 	int lcd, pcd;
 	unsigned long r;
 	u32 l;
 
-	l = dispc_read_reg(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD));
+	l = dispc_read_reg(DISPC_DIVISOR(channel));
 
 	lcd = FLD_GET(l, 23, 16);
 	pcd = FLD_GET(l, 7, 0);
@@ -2280,8 +2283,10 @@ void dispc_dump_clocks(struct seq_file *s)
 			"dss1_alwon_fclk" : "dsi1_pll_fclk");
 
 	seq_printf(s, "fck\t\t%-16lu\n", dispc_fclk_rate());
-	seq_printf(s, "lck\t\t%-16lulck div\t%u\n", dispc_lclk_rate(), lcd);
-	seq_printf(s, "pck\t\t%-16lupck div\t%u\n", dispc_pclk_rate(), pcd);
+	seq_printf(s, "lck\t\t%-16lulck div\t%u\n",
+			dispc_lclk_rate(OMAP_DSS_CHANNEL_LCD), lcd);
+	seq_printf(s, "pck\t\t%-16lupck div\t%u\n",
+			dispc_pclk_rate(OMAP_DSS_CHANNEL_LCD), pcd);
 
 	enable_clocks(0);
 }
@@ -2473,8 +2478,8 @@ void dispc_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-static void _dispc_set_pol_freq(bool onoff, bool rf, bool ieo, bool ipc,
-				bool ihs, bool ivs, u8 acbi, u8 acb)
+static void _dispc_set_pol_freq(enum omap_channel channel, bool onoff, bool rf,
+		bool ieo, bool ipc, bool ihs, bool ivs, u8 acbi, u8 acb)
 {
 	u32 l = 0;
 
@@ -2491,13 +2496,14 @@ static void _dispc_set_pol_freq(bool onoff, bool rf, bool ieo, bool ipc,
 	l |= FLD_VAL(acb, 7, 0);
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_POL_FREQ(OMAP_DSS_CHANNEL_LCD), l);
+	dispc_write_reg(DISPC_POL_FREQ(channel), l);
 	enable_clocks(0);
 }
 
-void dispc_set_pol_freq(enum omap_panel_config config, u8 acbi, u8 acb)
+void dispc_set_pol_freq(enum omap_channel channel,
+		enum omap_panel_config config, u8 acbi, u8 acb)
 {
-	_dispc_set_pol_freq((config & OMAP_DSS_LCD_ONOFF) != 0,
+	_dispc_set_pol_freq(channel, (config & OMAP_DSS_LCD_ONOFF) != 0,
 			(config & OMAP_DSS_LCD_RF) != 0,
 			(config & OMAP_DSS_LCD_IEO) != 0,
 			(config & OMAP_DSS_LCD_IPC) != 0,
@@ -2566,24 +2572,26 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 	return 0;
 }
 
-int dispc_set_clock_div(struct dispc_clock_info *cinfo)
+int dispc_set_clock_div(enum omap_channel channel,
+		struct dispc_clock_info *cinfo)
 {
 	DSSDBG("lck = %lu (%u)\n", cinfo->lck, cinfo->lck_div);
 	DSSDBG("pck = %lu (%u)\n", cinfo->pck, cinfo->pck_div);
 
-	dispc_set_lcd_divisor(cinfo->lck_div, cinfo->pck_div);
+	dispc_set_lcd_divisor(channel, cinfo->lck_div, cinfo->pck_div);
 
 	return 0;
 }
 
-int dispc_get_clock_div(struct dispc_clock_info *cinfo)
+int dispc_get_clock_div(enum omap_channel channel,
+		struct dispc_clock_info *cinfo)
 {
 	unsigned long fck;
 
 	fck = dispc_fclk_rate();
 
-	cinfo->lck_div = REG_GET(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD), 23, 16);
-	cinfo->pck_div = REG_GET(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD), 7, 0);
+	cinfo->lck_div = REG_GET(DISPC_DIVISOR(channel), 23, 16);
+	cinfo->pck_div = REG_GET(DISPC_DIVISOR(channel), 7, 0);
 
 	cinfo->lck = fck / cinfo->lck_div;
 	cinfo->pck = cinfo->lck / cinfo->pck_div;
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 51040dc..8f4f500 100644
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
 
@@ -107,16 +109,16 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
-	dispc_set_pol_freq(dssdev->panel.config, dssdev->panel.acbi,
-			dssdev->panel.acb);
+	dispc_set_pol_freq(dssdev->channel, dssdev->panel.config,
+			dssdev->panel.acbi, dssdev->panel.acb);
 
 	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
 
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
-	r = dpi_set_dsi_clk(is_tft, t->pixel_clock * 1000,
+	r = dpi_set_dsi_clk(dssdev->channel, is_tft, t->pixel_clock * 1000,
 			&fck, &lck_div, &pck_div);
 #else
-	r = dpi_set_dispc_clk(is_tft, t->pixel_clock * 1000,
+	r = dpi_set_dispc_clk(dssdev->channel, is_tft, t->pixel_clock * 1000,
 			&fck, &lck_div, &pck_div);
 #endif
 	if (r)
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a4c031e..932321d 100644
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
@@ -1206,8 +1206,8 @@ void dsi_dump_clocks(struct seq_file *s)
 
 	seq_printf(s,	"VP_CLK\t\t%lu\n"
 			"VP_PCLK\t\t%lu\n",
-			dispc_lclk_rate(),
-			dispc_pclk_rate());
+			dispc_lclk_rate(OMAP_DSS_CHANNEL_LCD),
+			dispc_pclk_rate(OMAP_DSS_CHANNEL_LCD));
 
 	enable_clocks(0);
 }
@@ -3020,7 +3020,7 @@ static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
 		return r;
 	}
 
-	r = dispc_set_clock_div(&dispc_cinfo);
+	r = dispc_set_clock_div(dssdev->channel, &dispc_cinfo);
 	if (r) {
 		DSSERR("Failed to set dispc clocks\n");
 		return r;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 68f7c42..599df58 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -393,15 +393,18 @@ bool dispc_lcd_timings_ok(struct omap_video_timings *timings);
 void dispc_set_lcd_timings(enum omap_channel channel,
 		struct omap_video_timings *timings);
 unsigned long dispc_fclk_rate(void);
-unsigned long dispc_lclk_rate(void);
-unsigned long dispc_pclk_rate(void);
-void dispc_set_pol_freq(enum omap_panel_config config, u8 acbi, u8 acb);
+unsigned long dispc_lclk_rate(enum omap_channel channel);
+unsigned long dispc_pclk_rate(enum omap_channel channel);
+void dispc_set_pol_freq(enum omap_channel channel,
+		enum omap_panel_config config, u8 acbi, u8 acb);
 void dispc_find_clk_divs(bool is_tft, unsigned long req_pck, unsigned long fck,
 		struct dispc_clock_info *cinfo);
 int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 		struct dispc_clock_info *cinfo);
-int dispc_set_clock_div(struct dispc_clock_info *cinfo);
-int dispc_get_clock_div(struct dispc_clock_info *cinfo);
+int dispc_set_clock_div(enum omap_channel channel,
+		struct dispc_clock_info *cinfo);
+int dispc_get_clock_div(enum omap_channel channel,
+		struct dispc_clock_info *cinfo);
 
 
 /* VENC */
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index a011be6..82d763a 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -75,15 +75,15 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	/* 15.5.9.1.2 */
 	dssdev->panel.config |= OMAP_DSS_LCD_RF | OMAP_DSS_LCD_ONOFF;
 
-	dispc_set_pol_freq(dssdev->panel.config, dssdev->panel.acbi,
-			dssdev->panel.acb);
+	dispc_set_pol_freq(dssdev->channel, dssdev->panel.config,
+			dssdev->panel.acbi, dssdev->panel.acb);
 
 	if (!sdi.skip_init) {
 		r = dss_calc_clock_div(1, t->pixel_clock * 1000,
 				&dss_cinfo, &dispc_cinfo);
 	} else {
 		r = dss_get_clock_div(&dss_cinfo);
-		r = dispc_get_clock_div(&dispc_cinfo);
+		r = dispc_get_clock_div(dssdev->channel, &dispc_cinfo);
 	}
 
 	if (r)
@@ -110,7 +110,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err2;
 
-	r = dispc_set_clock_div(&dispc_cinfo);
+	r = dispc_set_clock_div(dssdev->channel, &dispc_cinfo);
 	if (r)
 		goto err2;
 
-- 
1.7.0.4

