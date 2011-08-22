From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/10] OMAP: DSS2: reorganize functions in dss.h
Date: Mon, 22 Aug 2011 11:27:51 +0300
Message-ID: <1314001671-18123-11-git-send-email-tomi.valkeinen@ti.com>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:37531 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756719Ab1HVI2Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:28:25 -0400
In-Reply-To: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Group dispc's overlay and manager related functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |   47 +++++++++++++++++++---------------------
 1 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 0e95418..3de71c0 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -383,22 +383,24 @@ void dispc_disable_sidle(void);
 void dispc_lcd_enable_signal_polarity(bool act_high);
 void dispc_lcd_enable_signal(bool enable);
 void dispc_pck_free_enable(bool enable);
-void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable);
-
-void dispc_mgr_set_lcd_size(enum omap_channel channel, u16 width, u16 height);
 void dispc_set_digit_size(u16 width, u16 height);
+void dispc_enable_fifomerge(bool enable);
+void dispc_enable_gamma_table(bool enable);
+void dispc_set_loadmode(enum omap_dss_load_mode mode);
+
+bool dispc_lcd_timings_ok(struct omap_video_timings *timings);
+unsigned long dispc_fclk_rate(void);
+void dispc_find_clk_divs(bool is_tft, unsigned long req_pck, unsigned long fck,
+		struct dispc_clock_info *cinfo);
+int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
+		struct dispc_clock_info *cinfo);
+
+
 u32 dispc_ovl_get_fifo_size(enum omap_plane plane);
 void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
-void dispc_enable_fifomerge(bool enable);
 u32 dispc_ovl_get_burst_size(enum omap_plane plane);
-void dispc_mgr_enable_cpr(enum omap_channel channel, bool enable);
-void dispc_mgr_set_cpr_coef(enum omap_channel channel,
-		struct omap_dss_cpr_coefs *coefs);
-
 void dispc_ovl_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel_out);
-
-void dispc_enable_gamma_table(bool enable);
 int dispc_ovl_setup(enum omap_plane plane,
 		      u32 paddr, u16 screen_width,
 		      u16 pos_x, u16 pos_y,
@@ -411,21 +413,24 @@ int dispc_ovl_setup(enum omap_plane plane,
 		      u8 global_alpha, u8 pre_mult_alpha,
 		      enum omap_channel channel,
 		      u32 puv_addr);
+int dispc_ovl_enable(enum omap_plane plane, bool enable);
+void dispc_ovl_enable_replication(enum omap_plane plane, bool enable);
 
+
+void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable);
+void dispc_mgr_set_lcd_size(enum omap_channel channel, u16 width, u16 height);
+void dispc_mgr_enable_cpr(enum omap_channel channel, bool enable);
+void dispc_mgr_set_cpr_coef(enum omap_channel channel,
+		struct omap_dss_cpr_coefs *coefs);
 bool dispc_mgr_go_busy(enum omap_channel channel);
 void dispc_mgr_go(enum omap_channel channel);
 void dispc_mgr_enable(enum omap_channel channel, bool enable);
 bool dispc_mgr_is_channel_enabled(enum omap_channel channel);
-int dispc_ovl_enable(enum omap_plane plane, bool enable);
-void dispc_ovl_enable_replication(enum omap_plane plane, bool enable);
-
 void dispc_mgr_set_parallel_interface_mode(enum omap_channel channel,
 		enum omap_parallel_interface_mode mode);
 void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines);
 void dispc_mgr_set_lcd_display_type(enum omap_channel channel,
 		enum omap_lcd_display_type type);
-void dispc_set_loadmode(enum omap_dss_load_mode mode);
-
 void dispc_mgr_set_default_color(enum omap_channel channel, u32 color);
 u32 dispc_mgr_get_default_color(enum omap_channel channel);
 void dispc_mgr_set_trans_key(enum omap_channel ch,
@@ -438,25 +443,17 @@ void dispc_mgr_enable_trans_key(enum omap_channel ch, bool enable);
 void dispc_mgr_enable_alpha_blending(enum omap_channel ch, bool enable);
 bool dispc_mgr_trans_key_enabled(enum omap_channel ch);
 bool dispc_mgr_alpha_blending_enabled(enum omap_channel ch);
-
-bool dispc_lcd_timings_ok(struct omap_video_timings *timings);
 void dispc_mgr_set_lcd_timings(enum omap_channel channel,
 		struct omap_video_timings *timings);
-unsigned long dispc_fclk_rate(void);
-unsigned long dispc_mgr_lclk_rate(enum omap_channel channel);
-unsigned long dispc_mgr_pclk_rate(enum omap_channel channel);
 void dispc_mgr_set_pol_freq(enum omap_channel channel,
 		enum omap_panel_config config, u8 acbi, u8 acb);
-void dispc_find_clk_divs(bool is_tft, unsigned long req_pck, unsigned long fck,
-		struct dispc_clock_info *cinfo);
-int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
-		struct dispc_clock_info *cinfo);
+unsigned long dispc_mgr_lclk_rate(enum omap_channel channel);
+unsigned long dispc_mgr_pclk_rate(enum omap_channel channel);
 int dispc_mgr_set_clock_div(enum omap_channel channel,
 		struct dispc_clock_info *cinfo);
 int dispc_mgr_get_clock_div(enum omap_channel channel,
 		struct dispc_clock_info *cinfo);
 
-
 /* VENC */
 #ifdef CONFIG_OMAP2_DSS_VENC
 int venc_init_platform_driver(void);
-- 
1.7.4.1

