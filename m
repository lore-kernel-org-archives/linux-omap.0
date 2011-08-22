From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/10] OMAP: DSS2: DISPC: rename manager related funcs
Date: Mon, 22 Aug 2011 11:27:50 +0300
Message-ID: <1314001671-18123-10-git-send-email-tomi.valkeinen@ti.com>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:36803 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754735Ab1HVI2Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:28:24 -0400
In-Reply-To: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Rename dispc's manager related functions as follows:

- Remove prepending underscores, which were originally used to inform
  that the clocks needs to be enabled. This meaning is no longer valid.
- Prepend the functions with dispc_mgr_*
- Remove "channel" from the name, e.g. dispc_enable_channel ->
  dispc_mgr_enable

The idea is to group manager related functions so that it can be deduced
from the function name that it writes to manager spesific registers.

All dispc_mgr_* functions have enum omap_channel as the first parameter.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |   99 +++++++++++++++++++------------------
 drivers/video/omap2/dss/dpi.c     |   16 +++---
 drivers/video/omap2/dss/dsi.c     |   17 +++---
 drivers/video/omap2/dss/dss.h     |   50 +++++++++---------
 drivers/video/omap2/dss/hdmi.c    |    6 +-
 drivers/video/omap2/dss/manager.c |   24 +++++-----
 drivers/video/omap2/dss/rfbi.c    |   12 ++--
 drivers/video/omap2/dss/sdi.c     |   12 ++--
 8 files changed, 119 insertions(+), 117 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 7ab3d58..73b1478 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -419,7 +419,7 @@ void dispc_runtime_put(void)
 }
 
 
-bool dispc_go_busy(enum omap_channel channel)
+bool dispc_mgr_go_busy(enum omap_channel channel)
 {
 	int bit;
 
@@ -435,7 +435,7 @@ bool dispc_go_busy(enum omap_channel channel)
 		return REG_GET(DISPC_CONTROL, bit, bit) == 1;
 }
 
-void dispc_go(enum omap_channel channel)
+void dispc_mgr_go(enum omap_channel channel)
 {
 	int bit;
 	bool enable_bit, go_bit;
@@ -926,7 +926,7 @@ void dispc_enable_gamma_table(bool enable)
 	REG_FLD_MOD(DISPC_CONFIG, enable, 9, 9);
 }
 
-void dispc_enable_cpr(enum omap_channel channel, bool enable)
+void dispc_mgr_enable_cpr(enum omap_channel channel, bool enable)
 {
 	u16 reg;
 
@@ -940,7 +940,7 @@ void dispc_enable_cpr(enum omap_channel channel, bool enable)
 	REG_FLD_MOD(reg, enable, 15, 15);
 }
 
-void dispc_set_cpr_coef(enum omap_channel channel,
+void dispc_mgr_set_cpr_coef(enum omap_channel channel,
 		struct omap_dss_cpr_coefs *coefs)
 {
 	u32 coef_r, coef_g, coef_b;
@@ -980,7 +980,7 @@ void dispc_ovl_enable_replication(enum omap_plane plane, bool enable)
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable, shift, shift);
 }
 
-void dispc_set_lcd_size(enum omap_channel channel, u16 width, u16 height)
+void dispc_mgr_set_lcd_size(enum omap_channel channel, u16 width, u16 height)
 {
 	u32 val;
 	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
@@ -1614,7 +1614,7 @@ static unsigned long calc_fclk_five_taps(enum omap_channel channel, u16 width,
 {
 	u32 fclk = 0;
 	/* FIXME venc pclk? */
-	u64 tmp, pclk = dispc_pclk_rate(channel);
+	u64 tmp, pclk = dispc_mgr_pclk_rate(channel);
 
 	if (height > out_height) {
 		/* FIXME get real display PPL */
@@ -1671,7 +1671,7 @@ static unsigned long calc_fclk(enum omap_channel channel, u16 width,
 		vf = 1;
 
 	/* FIXME venc pclk? */
-	return dispc_pclk_rate(channel) * vf * hf;
+	return dispc_mgr_pclk_rate(channel) * vf * hf;
 }
 
 int dispc_ovl_setup(enum omap_plane plane,
@@ -1872,7 +1872,7 @@ static void _enable_lcd_out(enum omap_channel channel, bool enable)
 		REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 0, 0);
 }
 
-static void dispc_enable_lcd_out(enum omap_channel channel, bool enable)
+static void dispc_mgr_enable_lcd_out(enum omap_channel channel, bool enable)
 {
 	struct completion frame_done_completion;
 	bool is_on;
@@ -1919,7 +1919,7 @@ static void _enable_digit_out(bool enable)
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 1, 1);
 }
 
-static void dispc_enable_digit_out(bool enable)
+static void dispc_mgr_enable_digit_out(bool enable)
 {
 	struct completion frame_done_completion;
 	int r;
@@ -1979,7 +1979,7 @@ static void dispc_enable_digit_out(bool enable)
 	}
 }
 
-bool dispc_is_channel_enabled(enum omap_channel channel)
+bool dispc_mgr_is_enabled(enum omap_channel channel)
 {
 	if (channel == OMAP_DSS_CHANNEL_LCD)
 		return !!REG_GET(DISPC_CONTROL, 0, 0);
@@ -1991,13 +1991,13 @@ bool dispc_is_channel_enabled(enum omap_channel channel)
 		BUG();
 }
 
-void dispc_enable_channel(enum omap_channel channel, bool enable)
+void dispc_mgr_enable(enum omap_channel channel, bool enable)
 {
 	if (channel == OMAP_DSS_CHANNEL_LCD ||
 			channel == OMAP_DSS_CHANNEL_LCD2)
-		dispc_enable_lcd_out(channel, enable);
+		dispc_mgr_enable_lcd_out(channel, enable);
 	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
-		dispc_enable_digit_out(enable);
+		dispc_mgr_enable_digit_out(enable);
 	else
 		BUG();
 }
@@ -2026,7 +2026,7 @@ void dispc_pck_free_enable(bool enable)
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 27, 27);
 }
 
-void dispc_enable_fifohandcheck(enum omap_channel channel, bool enable)
+void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable)
 {
 	if (channel == OMAP_DSS_CHANNEL_LCD2)
 		REG_FLD_MOD(DISPC_CONFIG2, enable ? 1 : 0, 16, 16);
@@ -2035,7 +2035,7 @@ void dispc_enable_fifohandcheck(enum omap_channel channel, bool enable)
 }
 
 
-void dispc_set_lcd_display_type(enum omap_channel channel,
+void dispc_mgr_set_lcd_display_type(enum omap_channel channel,
 		enum omap_lcd_display_type type)
 {
 	int mode;
@@ -2066,12 +2066,12 @@ void dispc_set_loadmode(enum omap_dss_load_mode mode)
 }
 
 
-void dispc_set_default_color(enum omap_channel channel, u32 color)
+void dispc_mgr_set_default_color(enum omap_channel channel, u32 color)
 {
 	dispc_write_reg(DISPC_DEFAULT_COLOR(channel), color);
 }
 
-u32 dispc_get_default_color(enum omap_channel channel)
+u32 dispc_mgr_get_default_color(enum omap_channel channel)
 {
 	u32 l;
 
@@ -2084,7 +2084,7 @@ u32 dispc_get_default_color(enum omap_channel channel)
 	return l;
 }
 
-void dispc_set_trans_key(enum omap_channel ch,
+void dispc_mgr_set_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type type,
 		u32 trans_key)
 {
@@ -2098,7 +2098,7 @@ void dispc_set_trans_key(enum omap_channel ch,
 	dispc_write_reg(DISPC_TRANS_COLOR(ch), trans_key);
 }
 
-void dispc_get_trans_key(enum omap_channel ch,
+void dispc_mgr_get_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type *type,
 		u32 *trans_key)
 {
@@ -2117,7 +2117,7 @@ void dispc_get_trans_key(enum omap_channel ch,
 		*trans_key = dispc_read_reg(DISPC_TRANS_COLOR(ch));
 }
 
-void dispc_enable_trans_key(enum omap_channel ch, bool enable)
+void dispc_mgr_enable_trans_key(enum omap_channel ch, bool enable)
 {
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 10, 10);
@@ -2126,7 +2126,7 @@ void dispc_enable_trans_key(enum omap_channel ch, bool enable)
 	else /* OMAP_DSS_CHANNEL_LCD2 */
 		REG_FLD_MOD(DISPC_CONFIG2, enable, 10, 10);
 }
-void dispc_enable_alpha_blending(enum omap_channel ch, bool enable)
+void dispc_mgr_enable_alpha_blending(enum omap_channel ch, bool enable)
 {
 	if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
 		return;
@@ -2138,7 +2138,7 @@ void dispc_enable_alpha_blending(enum omap_channel ch, bool enable)
 	else /* OMAP_DSS_CHANNEL_LCD2 */
 		REG_FLD_MOD(DISPC_CONFIG2, enable, 18, 18);
 }
-bool dispc_alpha_blending_enabled(enum omap_channel ch)
+bool dispc_mgr_alpha_blending_enabled(enum omap_channel ch)
 {
 	bool enabled;
 
@@ -2158,7 +2158,7 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
 }
 
 
-bool dispc_trans_key_enabled(enum omap_channel ch)
+bool dispc_mgr_trans_key_enabled(enum omap_channel ch)
 {
 	bool enabled;
 
@@ -2175,7 +2175,7 @@ bool dispc_trans_key_enabled(enum omap_channel ch)
 }
 
 
-void dispc_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
+void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
 {
 	int code;
 
@@ -2203,7 +2203,7 @@ void dispc_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
 		REG_FLD_MOD(DISPC_CONTROL, code, 9, 8);
 }
 
-void dispc_set_parallel_interface_mode(enum omap_channel channel,
+void dispc_mgr_set_parallel_interface_mode(enum omap_channel channel,
 		enum omap_parallel_interface_mode mode)
 {
 	u32 l;
@@ -2276,7 +2276,7 @@ bool dispc_lcd_timings_ok(struct omap_video_timings *timings)
 			timings->vfp, timings->vbp);
 }
 
-static void _dispc_set_lcd_timings(enum omap_channel channel, int hsw,
+static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 		int hfp, int hbp, int vsw, int vfp, int vbp)
 {
 	u32 timing_h, timing_v;
@@ -2300,7 +2300,7 @@ static void _dispc_set_lcd_timings(enum omap_channel channel, int hsw,
 }
 
 /* change name to mode? */
-void dispc_set_lcd_timings(enum omap_channel channel,
+void dispc_mgr_set_lcd_timings(enum omap_channel channel,
 		struct omap_video_timings *timings)
 {
 	unsigned xtot, ytot;
@@ -2311,11 +2311,11 @@ void dispc_set_lcd_timings(enum omap_channel channel,
 				timings->vfp, timings->vbp))
 		BUG();
 
-	_dispc_set_lcd_timings(channel, timings->hsw, timings->hfp,
+	_dispc_mgr_set_lcd_timings(channel, timings->hsw, timings->hfp,
 			timings->hbp, timings->vsw, timings->vfp,
 			timings->vbp);
 
-	dispc_set_lcd_size(channel, timings->x_res, timings->y_res);
+	dispc_mgr_set_lcd_size(channel, timings->x_res, timings->y_res);
 
 	xtot = timings->x_res + timings->hfp + timings->hsw + timings->hbp;
 	ytot = timings->y_res + timings->vfp + timings->vsw + timings->vbp;
@@ -2333,7 +2333,7 @@ void dispc_set_lcd_timings(enum omap_channel channel,
 	DSSDBG("hsync %luHz, vsync %luHz\n", ht, vt);
 }
 
-static void dispc_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
+static void dispc_mgr_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
 		u16 pck_div)
 {
 	BUG_ON(lck_div < 1);
@@ -2343,7 +2343,7 @@ static void dispc_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
 			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
 }
 
-static void dispc_get_lcd_divisor(enum omap_channel channel, int *lck_div,
+static void dispc_mgr_get_lcd_divisor(enum omap_channel channel, int *lck_div,
 		int *pck_div)
 {
 	u32 l;
@@ -2376,7 +2376,7 @@ unsigned long dispc_fclk_rate(void)
 	return r;
 }
 
-unsigned long dispc_lclk_rate(enum omap_channel channel)
+unsigned long dispc_mgr_lclk_rate(enum omap_channel channel)
 {
 	struct platform_device *dsidev;
 	int lcd;
@@ -2406,7 +2406,7 @@ unsigned long dispc_lclk_rate(enum omap_channel channel)
 	return r / lcd;
 }
 
-unsigned long dispc_pclk_rate(enum omap_channel channel)
+unsigned long dispc_mgr_pclk_rate(enum omap_channel channel)
 {
 	int pcd;
 	unsigned long r;
@@ -2416,7 +2416,7 @@ unsigned long dispc_pclk_rate(enum omap_channel channel)
 
 	pcd = FLD_GET(l, 7, 0);
 
-	r = dispc_lclk_rate(channel);
+	r = dispc_mgr_lclk_rate(channel);
 
 	return r / pcd;
 }
@@ -2455,12 +2455,12 @@ void dispc_dump_clocks(struct seq_file *s)
 		dss_get_generic_clk_source_name(lcd_clk_src),
 		dss_feat_get_clk_source_name(lcd_clk_src));
 
-	dispc_get_lcd_divisor(OMAP_DSS_CHANNEL_LCD, &lcd, &pcd);
+	dispc_mgr_get_lcd_divisor(OMAP_DSS_CHANNEL_LCD, &lcd, &pcd);
 
 	seq_printf(s, "lck\t\t%-16lulck div\t%u\n",
-			dispc_lclk_rate(OMAP_DSS_CHANNEL_LCD), lcd);
+			dispc_mgr_lclk_rate(OMAP_DSS_CHANNEL_LCD), lcd);
 	seq_printf(s, "pck\t\t%-16lupck div\t%u\n",
-			dispc_pclk_rate(OMAP_DSS_CHANNEL_LCD), pcd);
+			dispc_mgr_pclk_rate(OMAP_DSS_CHANNEL_LCD), pcd);
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
 		seq_printf(s, "- LCD2 -\n");
 
@@ -2470,12 +2470,12 @@ void dispc_dump_clocks(struct seq_file *s)
 			dss_get_generic_clk_source_name(lcd_clk_src),
 			dss_feat_get_clk_source_name(lcd_clk_src));
 
-		dispc_get_lcd_divisor(OMAP_DSS_CHANNEL_LCD2, &lcd, &pcd);
+		dispc_mgr_get_lcd_divisor(OMAP_DSS_CHANNEL_LCD2, &lcd, &pcd);
 
 		seq_printf(s, "lck\t\t%-16lulck div\t%u\n",
-				dispc_lclk_rate(OMAP_DSS_CHANNEL_LCD2), lcd);
+				dispc_mgr_lclk_rate(OMAP_DSS_CHANNEL_LCD2), lcd);
 		seq_printf(s, "pck\t\t%-16lupck div\t%u\n",
-				dispc_pclk_rate(OMAP_DSS_CHANNEL_LCD2), pcd);
+				dispc_mgr_pclk_rate(OMAP_DSS_CHANNEL_LCD2), pcd);
 	}
 
 	dispc_runtime_put();
@@ -2687,8 +2687,9 @@ void dispc_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-static void _dispc_set_pol_freq(enum omap_channel channel, bool onoff, bool rf,
-		bool ieo, bool ipc, bool ihs, bool ivs, u8 acbi, u8 acb)
+static void _dispc_mgr_set_pol_freq(enum omap_channel channel, bool onoff,
+		bool rf, bool ieo, bool ipc, bool ihs, bool ivs, u8 acbi,
+		u8 acb)
 {
 	u32 l = 0;
 
@@ -2707,10 +2708,10 @@ static void _dispc_set_pol_freq(enum omap_channel channel, bool onoff, bool rf,
 	dispc_write_reg(DISPC_POL_FREQ(channel), l);
 }
 
-void dispc_set_pol_freq(enum omap_channel channel,
+void dispc_mgr_set_pol_freq(enum omap_channel channel,
 		enum omap_panel_config config, u8 acbi, u8 acb)
 {
-	_dispc_set_pol_freq(channel, (config & OMAP_DSS_LCD_ONOFF) != 0,
+	_dispc_mgr_set_pol_freq(channel, (config & OMAP_DSS_LCD_ONOFF) != 0,
 			(config & OMAP_DSS_LCD_RF) != 0,
 			(config & OMAP_DSS_LCD_IEO) != 0,
 			(config & OMAP_DSS_LCD_IPC) != 0,
@@ -2779,18 +2780,18 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 	return 0;
 }
 
-int dispc_set_clock_div(enum omap_channel channel,
+int dispc_mgr_set_clock_div(enum omap_channel channel,
 		struct dispc_clock_info *cinfo)
 {
 	DSSDBG("lck = %lu (%u)\n", cinfo->lck, cinfo->lck_div);
 	DSSDBG("pck = %lu (%u)\n", cinfo->pck, cinfo->pck_div);
 
-	dispc_set_lcd_divisor(channel, cinfo->lck_div, cinfo->pck_div);
+	dispc_mgr_set_lcd_divisor(channel, cinfo->lck_div, cinfo->pck_div);
 
 	return 0;
 }
 
-int dispc_get_clock_div(enum omap_channel channel,
+int dispc_mgr_get_clock_div(enum omap_channel channel,
 		struct dispc_clock_info *cinfo)
 {
 	unsigned long fck;
@@ -3058,7 +3059,7 @@ static void dispc_error_worker(struct work_struct *work)
 			DSSERR("FIFO UNDERFLOW on %s, disabling the overlay\n",
 					ovl->name);
 			dispc_ovl_enable(ovl->id, false);
-			dispc_go(ovl->manager->id);
+			dispc_mgr_go(ovl->manager->id);
 			mdelay(50);
 		}
 	}
@@ -3090,7 +3091,7 @@ static void dispc_error_worker(struct work_struct *work)
 					dispc_ovl_enable(ovl->id, false);
 			}
 
-			dispc_go(mgr->id);
+			dispc_mgr_go(mgr->id);
 			mdelay(50);
 
 			if (enable)
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index dc698bd..1edc832 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -82,7 +82,7 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev, bool is_tft,
 
 	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
 
-	r = dispc_set_clock_div(dssdev->manager->id, &dispc_cinfo);
+	r = dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
 	if (r) {
 		dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 		return r;
@@ -111,7 +111,7 @@ static int dpi_set_dispc_clk(struct omap_dss_device *dssdev, bool is_tft,
 	if (r)
 		return r;
 
-	r = dispc_set_clock_div(dssdev->manager->id, &dispc_cinfo);
+	r = dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
 	if (r)
 		return r;
 
@@ -131,7 +131,7 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 	bool is_tft;
 	int r = 0;
 
-	dispc_set_pol_freq(dssdev->manager->id, dssdev->panel.config,
+	dispc_mgr_set_pol_freq(dssdev->manager->id, dssdev->panel.config,
 			dssdev->panel.acbi, dssdev->panel.acb);
 
 	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
@@ -155,7 +155,7 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 		t->pixel_clock = pck;
 	}
 
-	dispc_set_lcd_timings(dssdev->manager->id, t);
+	dispc_mgr_set_lcd_timings(dssdev->manager->id, t);
 
 	return 0;
 }
@@ -166,11 +166,11 @@ static void dpi_basic_init(struct omap_dss_device *dssdev)
 
 	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
 
-	dispc_set_parallel_interface_mode(dssdev->manager->id,
+	dispc_mgr_set_parallel_interface_mode(dssdev->manager->id,
 			OMAP_DSS_PARALLELMODE_BYPASS);
-	dispc_set_lcd_display_type(dssdev->manager->id, is_tft ?
+	dispc_mgr_set_lcd_display_type(dssdev->manager->id, is_tft ?
 			OMAP_DSS_LCD_DISPLAY_TFT : OMAP_DSS_LCD_DISPLAY_STN);
-	dispc_set_tft_data_lines(dssdev->manager->id,
+	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
 			dssdev->phy.dpi.data_lines);
 }
 
@@ -284,7 +284,7 @@ void dpi_set_timings(struct omap_dss_device *dssdev,
 		}
 
 		dpi_set_mode(dssdev);
-		dispc_go(dssdev->manager->id);
+		dispc_mgr_go(dssdev->manager->id);
 
 		dispc_runtime_put();
 		dss_runtime_put();
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index bd0ff1d..52a4a02 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1283,7 +1283,7 @@ static int dsi_calc_clock_rates(struct omap_dss_device *dssdev,
 		 * with DSS_SYS_CLK source also */
 		cinfo->highfreq = 0;
 	} else {
-		cinfo->clkin = dispc_pclk_rate(dssdev->manager->id);
+		cinfo->clkin = dispc_mgr_pclk_rate(dssdev->manager->id);
 
 		if (cinfo->clkin < 32000000)
 			cinfo->highfreq = 0;
@@ -3817,7 +3817,7 @@ int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
 
 	dss_setup_partial_planes(dssdev, x, y, w, h,
 			enlarge_update_area);
-	dispc_set_lcd_size(dssdev->manager->id, *w, *h);
+	dispc_mgr_set_lcd_size(dssdev->manager->id, *w, *h);
 
 	return 0;
 }
@@ -3871,14 +3871,15 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 		return r;
 	}
 
-	dispc_set_lcd_display_type(dssdev->manager->id,
+	dispc_mgr_set_lcd_display_type(dssdev->manager->id,
 			OMAP_DSS_LCD_DISPLAY_TFT);
 
-	dispc_set_parallel_interface_mode(dssdev->manager->id,
+	dispc_mgr_set_parallel_interface_mode(dssdev->manager->id,
 			OMAP_DSS_PARALLELMODE_DSI);
-	dispc_enable_fifohandcheck(dssdev->manager->id, 1);
+	dispc_mgr_enable_fifohandcheck(dssdev->manager->id, 1);
 
-	dispc_set_tft_data_lines(dssdev->manager->id, dssdev->ctrl.pixel_size);
+	dispc_mgr_set_tft_data_lines(dssdev->manager->id,
+			dssdev->ctrl.pixel_size);
 
 	{
 		struct omap_video_timings timings = {
@@ -3890,7 +3891,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 			.vbp		= 0,
 		};
 
-		dispc_set_lcd_timings(dssdev->manager->id, &timings);
+		dispc_mgr_set_lcd_timings(dssdev->manager->id, &timings);
 	}
 
 	return 0;
@@ -3952,7 +3953,7 @@ static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
 		return r;
 	}
 
-	r = dispc_set_clock_div(dssdev->manager->id, &dispc_cinfo);
+	r = dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
 	if (r) {
 		DSSERR("Failed to set dispc clocks\n");
 		return r;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f2e9eed..0e95418 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -383,16 +383,16 @@ void dispc_disable_sidle(void);
 void dispc_lcd_enable_signal_polarity(bool act_high);
 void dispc_lcd_enable_signal(bool enable);
 void dispc_pck_free_enable(bool enable);
-void dispc_enable_fifohandcheck(enum omap_channel channel, bool enable);
+void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable);
 
-void dispc_set_lcd_size(enum omap_channel channel, u16 width, u16 height);
+void dispc_mgr_set_lcd_size(enum omap_channel channel, u16 width, u16 height);
 void dispc_set_digit_size(u16 width, u16 height);
 u32 dispc_ovl_get_fifo_size(enum omap_plane plane);
 void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
 void dispc_enable_fifomerge(bool enable);
 u32 dispc_ovl_get_burst_size(enum omap_plane plane);
-void dispc_enable_cpr(enum omap_channel channel, bool enable);
-void dispc_set_cpr_coef(enum omap_channel channel,
+void dispc_mgr_enable_cpr(enum omap_channel channel, bool enable);
+void dispc_mgr_set_cpr_coef(enum omap_channel channel,
 		struct omap_dss_cpr_coefs *coefs);
 
 void dispc_ovl_set_channel_out(enum omap_plane plane,
@@ -412,48 +412,48 @@ int dispc_ovl_setup(enum omap_plane plane,
 		      enum omap_channel channel,
 		      u32 puv_addr);
 
-bool dispc_go_busy(enum omap_channel channel);
-void dispc_go(enum omap_channel channel);
-void dispc_enable_channel(enum omap_channel channel, bool enable);
-bool dispc_is_channel_enabled(enum omap_channel channel);
+bool dispc_mgr_go_busy(enum omap_channel channel);
+void dispc_mgr_go(enum omap_channel channel);
+void dispc_mgr_enable(enum omap_channel channel, bool enable);
+bool dispc_mgr_is_channel_enabled(enum omap_channel channel);
 int dispc_ovl_enable(enum omap_plane plane, bool enable);
 void dispc_ovl_enable_replication(enum omap_plane plane, bool enable);
 
-void dispc_set_parallel_interface_mode(enum omap_channel channel,
+void dispc_mgr_set_parallel_interface_mode(enum omap_channel channel,
 		enum omap_parallel_interface_mode mode);
-void dispc_set_tft_data_lines(enum omap_channel channel, u8 data_lines);
-void dispc_set_lcd_display_type(enum omap_channel channel,
+void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines);
+void dispc_mgr_set_lcd_display_type(enum omap_channel channel,
 		enum omap_lcd_display_type type);
 void dispc_set_loadmode(enum omap_dss_load_mode mode);
 
-void dispc_set_default_color(enum omap_channel channel, u32 color);
-u32 dispc_get_default_color(enum omap_channel channel);
-void dispc_set_trans_key(enum omap_channel ch,
+void dispc_mgr_set_default_color(enum omap_channel channel, u32 color);
+u32 dispc_mgr_get_default_color(enum omap_channel channel);
+void dispc_mgr_set_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type type,
 		u32 trans_key);
-void dispc_get_trans_key(enum omap_channel ch,
+void dispc_mgr_get_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type *type,
 		u32 *trans_key);
-void dispc_enable_trans_key(enum omap_channel ch, bool enable);
-void dispc_enable_alpha_blending(enum omap_channel ch, bool enable);
-bool dispc_trans_key_enabled(enum omap_channel ch);
-bool dispc_alpha_blending_enabled(enum omap_channel ch);
+void dispc_mgr_enable_trans_key(enum omap_channel ch, bool enable);
+void dispc_mgr_enable_alpha_blending(enum omap_channel ch, bool enable);
+bool dispc_mgr_trans_key_enabled(enum omap_channel ch);
+bool dispc_mgr_alpha_blending_enabled(enum omap_channel ch);
 
 bool dispc_lcd_timings_ok(struct omap_video_timings *timings);
-void dispc_set_lcd_timings(enum omap_channel channel,
+void dispc_mgr_set_lcd_timings(enum omap_channel channel,
 		struct omap_video_timings *timings);
 unsigned long dispc_fclk_rate(void);
-unsigned long dispc_lclk_rate(enum omap_channel channel);
-unsigned long dispc_pclk_rate(enum omap_channel channel);
-void dispc_set_pol_freq(enum omap_channel channel,
+unsigned long dispc_mgr_lclk_rate(enum omap_channel channel);
+unsigned long dispc_mgr_pclk_rate(enum omap_channel channel);
+void dispc_mgr_set_pol_freq(enum omap_channel channel,
 		enum omap_panel_config config, u8 acbi, u8 acb);
 void dispc_find_clk_divs(bool is_tft, unsigned long req_pck, unsigned long fck,
 		struct dispc_clock_info *cinfo);
 int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 		struct dispc_clock_info *cinfo);
-int dispc_set_clock_div(enum omap_channel channel,
+int dispc_mgr_set_clock_div(enum omap_channel channel,
 		struct dispc_clock_info *cinfo);
-int dispc_get_clock_div(enum omap_channel channel,
+int dispc_mgr_get_clock_div(enum omap_channel channel,
 		struct dispc_clock_info *cinfo);
 
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 876274b..b8e02e4 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1116,7 +1116,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		return r;
 
-	dispc_enable_channel(OMAP_DSS_CHANNEL_DIGIT, 0);
+	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 0);
 
 	p = &dssdev->panel.timings;
 
@@ -1173,7 +1173,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	dispc_set_digit_size(dssdev->panel.timings.x_res,
 			dssdev->panel.timings.y_res);
 
-	dispc_enable_channel(OMAP_DSS_CHANNEL_DIGIT, 1);
+	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
 
 	hdmi_wp_video_start(1);
 
@@ -1185,7 +1185,7 @@ err:
 
 static void hdmi_power_off(struct omap_dss_device *dssdev)
 {
-	dispc_enable_channel(OMAP_DSS_CHANNEL_DIGIT, 0);
+	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 0);
 
 	hdmi_wp_video_start(0);
 	hdmi_phy_off();
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index b9bdf22..a5f107f 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -970,13 +970,13 @@ static void configure_manager(enum omap_channel channel)
 	/* picking info from the cache */
 	mi = &dss_cache.manager_cache[channel].info;
 
-	dispc_set_default_color(channel, mi->default_color);
-	dispc_set_trans_key(channel, mi->trans_key_type, mi->trans_key);
-	dispc_enable_trans_key(channel, mi->trans_enabled);
-	dispc_enable_alpha_blending(channel, mi->alpha_enabled);
+	dispc_mgr_set_default_color(channel, mi->default_color);
+	dispc_mgr_set_trans_key(channel, mi->trans_key_type, mi->trans_key);
+	dispc_mgr_enable_trans_key(channel, mi->trans_enabled);
+	dispc_mgr_enable_alpha_blending(channel, mi->alpha_enabled);
 	if (dss_has_feature(FEAT_CPR)) {
-		dispc_enable_cpr(channel, mi->cpr_enable);
-		dispc_set_cpr_coef(channel, &mi->cpr_coefs);
+		dispc_mgr_enable_cpr(channel, mi->cpr_enable);
+		dispc_mgr_set_cpr_coef(channel, &mi->cpr_coefs);
 	}
 }
 
@@ -1000,7 +1000,7 @@ static int configure_dispc(void)
 	busy = false;
 
 	for (i = 0; i < num_mgrs; i++) {
-		mgr_busy[i] = dispc_go_busy(i);
+		mgr_busy[i] = dispc_mgr_go_busy(i);
 		mgr_go[i] = false;
 	}
 
@@ -1061,7 +1061,7 @@ static int configure_dispc(void)
 		 * always be turned off after frame, and new settings will be
 		 * taken in to use at next update */
 		if (!mc->manual_update)
-			dispc_go(i);
+			dispc_mgr_go(i);
 	}
 
 	if (busy)
@@ -1266,7 +1266,7 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 	u32 irq_mask;
 
 	for (i = 0; i < num_mgrs; i++)
-		mgr_busy[i] = dispc_go_busy(i);
+		mgr_busy[i] = dispc_mgr_go_busy(i);
 
 	spin_lock(&dss_cache.lock);
 
@@ -1288,7 +1288,7 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 
 	/* re-read busy flags */
 	for (i = 0; i < num_mgrs; i++)
-		mgr_busy[i] = dispc_go_busy(i);
+		mgr_busy[i] = dispc_mgr_go_busy(i);
 
 	/* keep running as long as there are busy managers, so that
 	 * we can collect overlay-applied information */
@@ -1521,13 +1521,13 @@ static void omap_dss_mgr_get_info(struct omap_overlay_manager *mgr,
 
 static int dss_mgr_enable(struct omap_overlay_manager *mgr)
 {
-	dispc_enable_channel(mgr->id, 1);
+	dispc_mgr_enable(mgr->id, 1);
 	return 0;
 }
 
 static int dss_mgr_disable(struct omap_overlay_manager *mgr)
 {
-	dispc_enable_channel(mgr->id, 0);
+	dispc_mgr_enable(mgr->id, 0);
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index b605066..b4a131a 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -309,9 +309,9 @@ static void rfbi_transfer_area(struct omap_dss_device *dssdev, u16 width,
 
 	DSSDBG("rfbi_transfer_area %dx%d\n", width, height);
 
-	dispc_set_lcd_size(dssdev->manager->id, width, height);
+	dispc_mgr_set_lcd_size(dssdev->manager->id, width, height);
 
-	dispc_enable_channel(dssdev->manager->id, true);
+	dispc_mgr_enable(dssdev->manager->id, true);
 
 	rfbi.framedone_callback = callback;
 	rfbi.framedone_callback_data = data;
@@ -784,7 +784,7 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 		return -EINVAL;
 
 	dss_setup_partial_planes(dssdev, x, y, w, h, true);
-	dispc_set_lcd_size(dssdev->manager->id, *w, *h);
+	dispc_mgr_set_lcd_size(dssdev->manager->id, *w, *h);
 
 	return 0;
 }
@@ -865,13 +865,13 @@ int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev)
 		goto err1;
 	}
 
-	dispc_set_lcd_display_type(dssdev->manager->id,
+	dispc_mgr_set_lcd_display_type(dssdev->manager->id,
 			OMAP_DSS_LCD_DISPLAY_TFT);
 
-	dispc_set_parallel_interface_mode(dssdev->manager->id,
+	dispc_mgr_set_parallel_interface_mode(dssdev->manager->id,
 			OMAP_DSS_PARALLELMODE_RFBI);
 
-	dispc_set_tft_data_lines(dssdev->manager->id, dssdev->ctrl.pixel_size);
+	dispc_mgr_set_tft_data_lines(dssdev->manager->id, dssdev->ctrl.pixel_size);
 
 	rfbi_configure(dssdev->phy.rfbi.channel,
 			       dssdev->ctrl.pixel_size,
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index df2b3c3..e2f35c0 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -35,13 +35,13 @@ static struct {
 static void sdi_basic_init(struct omap_dss_device *dssdev)
 
 {
-	dispc_set_parallel_interface_mode(dssdev->manager->id,
+	dispc_mgr_set_parallel_interface_mode(dssdev->manager->id,
 			OMAP_DSS_PARALLELMODE_BYPASS);
 
-	dispc_set_lcd_display_type(dssdev->manager->id,
+	dispc_mgr_set_lcd_display_type(dssdev->manager->id,
 			OMAP_DSS_LCD_DISPLAY_TFT);
 
-	dispc_set_tft_data_lines(dssdev->manager->id, 24);
+	dispc_mgr_set_tft_data_lines(dssdev->manager->id, 24);
 	dispc_lcd_enable_signal_polarity(1);
 }
 
@@ -83,7 +83,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	/* 15.5.9.1.2 */
 	dssdev->panel.config |= OMAP_DSS_LCD_RF | OMAP_DSS_LCD_ONOFF;
 
-	dispc_set_pol_freq(dssdev->manager->id, dssdev->panel.config,
+	dispc_mgr_set_pol_freq(dssdev->manager->id, dssdev->panel.config,
 			dssdev->panel.acbi, dssdev->panel.acb);
 
 	r = dss_calc_clock_div(1, t->pixel_clock * 1000,
@@ -106,13 +106,13 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	}
 
 
-	dispc_set_lcd_timings(dssdev->manager->id, t);
+	dispc_mgr_set_lcd_timings(dssdev->manager->id, t);
 
 	r = dss_set_clock_div(&dss_cinfo);
 	if (r)
 		goto err_set_dss_clock_div;
 
-	r = dispc_set_clock_div(dssdev->manager->id, &dispc_cinfo);
+	r = dispc_mgr_set_clock_div(dssdev->manager->id, &dispc_cinfo);
 	if (r)
 		goto err_set_dispc_clock_div;
 
-- 
1.7.4.1

