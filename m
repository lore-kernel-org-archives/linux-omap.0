From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 23/28] OMAP: DSS2: DISPC: remove finegrained clk enables/disables
Date: Thu,  9 Jun 2011 16:56:45 +0300
Message-ID: <1307627810-3768-24-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:41314 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758125Ab1FIN6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:58:00 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

dispc.c enables and disables clocks in almost every function to make
sure the clocks are enabled when the function is called. This is rather
unoptimal way to handle the problem.

With pm_runtime other components have to call dispc_runtime_get() to
enable dispc clocks before calling any other dispc functions. Thus the
finegrained clk enables/disables can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  165 +++++----------------------------------
 1 files changed, 19 insertions(+), 146 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 3f2265f..2de7e92 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -604,8 +604,6 @@ void dispc_go(enum omap_channel channel)
 	int bit;
 	bool enable_bit, go_bit;
 
-	dispc_runtime_get();
-
 	if (channel == OMAP_DSS_CHANNEL_LCD ||
 			channel == OMAP_DSS_CHANNEL_LCD2)
 		bit = 0; /* LCDENABLE */
@@ -619,7 +617,7 @@ void dispc_go(enum omap_channel channel)
 		enable_bit = REG_GET(DISPC_CONTROL, bit, bit) == 1;
 
 	if (!enable_bit)
-		goto end;
+		return;
 
 	if (channel == OMAP_DSS_CHANNEL_LCD ||
 			channel == OMAP_DSS_CHANNEL_LCD2)
@@ -634,7 +632,7 @@ void dispc_go(enum omap_channel channel)
 
 	if (go_bit) {
 		DSSERR("GO bit not down for channel %d\n", channel);
-		goto end;
+		return;
 	}
 
 	DSSDBG("GO %s\n", channel == OMAP_DSS_CHANNEL_LCD ? "LCD" :
@@ -644,8 +642,6 @@ void dispc_go(enum omap_channel channel)
 		REG_FLD_MOD(DISPC_CONTROL2, 1, bit, bit);
 	else
 		REG_FLD_MOD(DISPC_CONTROL, 1, bit, bit);
-end:
-	dispc_runtime_put();
 }
 
 static void _dispc_write_firh_reg(enum omap_plane plane, int reg, u32 value)
@@ -1019,7 +1015,7 @@ static void _dispc_set_color_mode(enum omap_plane plane,
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), m, 4, 1);
 }
 
-static void _dispc_set_channel_out(enum omap_plane plane,
+void dispc_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel)
 {
 	int shift;
@@ -1072,8 +1068,6 @@ void dispc_set_burst_size(enum omap_plane plane,
 	int shift;
 	u32 val;
 
-	dispc_runtime_get();
-
 	switch (plane) {
 	case OMAP_DSS_GFX:
 		shift = 6;
@@ -1090,8 +1084,6 @@ void dispc_set_burst_size(enum omap_plane plane,
 	val = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
 	val = FLD_MOD(val, burst_size, shift+1, shift);
 	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
-
-	dispc_runtime_put();
 }
 
 void dispc_enable_gamma_table(bool enable)
@@ -1128,9 +1120,7 @@ void dispc_enable_replication(enum omap_plane plane, bool enable)
 	else
 		bit = 10;
 
-	dispc_runtime_get();
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable, bit, bit);
-	dispc_runtime_put();
 }
 
 void dispc_set_lcd_size(enum omap_channel channel, u16 width, u16 height)
@@ -1138,9 +1128,7 @@ void dispc_set_lcd_size(enum omap_channel channel, u16 width, u16 height)
 	u32 val;
 	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
 	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
-	dispc_runtime_get();
 	dispc_write_reg(DISPC_SIZE_MGR(channel), val);
-	dispc_runtime_put();
 }
 
 void dispc_set_digit_size(u16 width, u16 height)
@@ -1148,9 +1136,7 @@ void dispc_set_digit_size(u16 width, u16 height)
 	u32 val;
 	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
 	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
-	dispc_runtime_get();
 	dispc_write_reg(DISPC_SIZE_MGR(OMAP_DSS_CHANNEL_DIGIT), val);
-	dispc_runtime_put();
 }
 
 static void dispc_read_plane_fifo_sizes(void)
@@ -1159,8 +1145,6 @@ static void dispc_read_plane_fifo_sizes(void)
 	int plane;
 	u8 start, end;
 
-	dispc_runtime_get();
-
 	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
 
 	for (plane = 0; plane < ARRAY_SIZE(dispc.fifo_size); ++plane) {
@@ -1168,8 +1152,6 @@ static void dispc_read_plane_fifo_sizes(void)
 			start, end);
 		dispc.fifo_size[plane] = size;
 	}
-
-	dispc_runtime_put();
 }
 
 u32 dispc_get_plane_fifo_size(enum omap_plane plane)
@@ -1184,8 +1166,6 @@ void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high)
 	dss_feat_get_reg_field(FEAT_REG_FIFOHIGHTHRESHOLD, &hi_start, &hi_end);
 	dss_feat_get_reg_field(FEAT_REG_FIFOLOWTHRESHOLD, &lo_start, &lo_end);
 
-	dispc_runtime_get();
-
 	DSSDBG("fifo(%d) low/high old %u/%u, new %u/%u\n",
 			plane,
 			REG_GET(DISPC_OVL_FIFO_THRESHOLD(plane),
@@ -1197,18 +1177,12 @@ void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high)
 	dispc_write_reg(DISPC_OVL_FIFO_THRESHOLD(plane),
 			FLD_VAL(high, hi_start, hi_end) |
 			FLD_VAL(low, lo_start, lo_end));
-
-	dispc_runtime_put();
 }
 
 void dispc_enable_fifomerge(bool enable)
 {
-	dispc_runtime_get();
-
 	DSSDBG("FIFO merge %s\n", enable ? "enabled" : "disabled");
 	REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 14, 14);
-
-	dispc_runtime_put();
 }
 
 static void _dispc_set_fir(enum omap_plane plane,
@@ -1828,14 +1802,7 @@ static unsigned long calc_fclk(enum omap_channel channel, u16 width,
 	return dispc_pclk_rate(channel) * vf * hf;
 }
 
-void dispc_set_channel_out(enum omap_plane plane, enum omap_channel channel_out)
-{
-	dispc_runtime_get();
-	_dispc_set_channel_out(plane, channel_out);
-	dispc_runtime_put();
-}
-
-static int _dispc_setup_plane(enum omap_plane plane,
+int dispc_setup_plane(enum omap_plane plane,
 		u32 paddr, u16 screen_width,
 		u16 pos_x, u16 pos_y,
 		u16 width, u16 height,
@@ -1843,7 +1810,7 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		enum omap_color_mode color_mode,
 		bool ilace,
 		enum omap_dss_rotation_type rotation_type,
-		u8 rotation, int mirror,
+		u8 rotation, bool mirror,
 		u8 global_alpha, u8 pre_mult_alpha,
 		enum omap_channel channel, u32 puv_addr)
 {
@@ -1857,6 +1824,14 @@ static int _dispc_setup_plane(enum omap_plane plane,
 	u16 frame_height = height;
 	unsigned int field_offset = 0;
 
+	DSSDBG("dispc_setup_plane %d, pa %x, sw %d, %d,%d, %dx%d -> "
+	       "%dx%d, ilace %d, cmode %x, rot %d, mir %d chan %d\n",
+	       plane, paddr, screen_width, pos_x, pos_y,
+	       width, height,
+	       out_width, out_height,
+	       ilace, color_mode,
+	       rotation, mirror, channel);
+
 	if (paddr == 0)
 		return -EINVAL;
 
@@ -2002,9 +1977,13 @@ static int _dispc_setup_plane(enum omap_plane plane,
 	return 0;
 }
 
-static void _dispc_enable_plane(enum omap_plane plane, bool enable)
+int dispc_enable_plane(enum omap_plane plane, bool enable)
 {
+	DSSDBG("dispc_enable_plane %d, %d\n", plane, enable);
+
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable ? 1 : 0, 0, 0);
+
+	return 0;
 }
 
 static void dispc_disable_isr(void *data, u32 mask)
@@ -2028,8 +2007,6 @@ static void dispc_enable_lcd_out(enum omap_channel channel, bool enable)
 	int r;
 	u32 irq;
 
-	dispc_runtime_get();
-
 	/* When we disable LCD output, we need to wait until frame is done.
 	 * Otherwise the DSS is still working, and turning off the clocks
 	 * prevents DSS from going to OFF mode */
@@ -2063,8 +2040,6 @@ static void dispc_enable_lcd_out(enum omap_channel channel, bool enable)
 		if (r)
 			DSSERR("failed to unregister FRAMEDONE isr\n");
 	}
-
-	dispc_runtime_put();
 }
 
 static void _enable_digit_out(bool enable)
@@ -2077,12 +2052,8 @@ static void dispc_enable_digit_out(bool enable)
 	struct completion frame_done_completion;
 	int r;
 
-	dispc_runtime_get();
-
-	if (REG_GET(DISPC_CONTROL, 1, 1) == enable) {
-		dispc_runtime_put();
+	if (REG_GET(DISPC_CONTROL, 1, 1) == enable)
 		return;
-	}
 
 	if (enable) {
 		unsigned long flags;
@@ -2134,8 +2105,6 @@ static void dispc_enable_digit_out(bool enable)
 		_omap_dispc_set_irqs();
 		spin_unlock_irqrestore(&dispc.irq_lock, flags);
 	}
-
-	dispc_runtime_put();
 }
 
 bool dispc_is_channel_enabled(enum omap_channel channel)
@@ -2166,9 +2135,7 @@ void dispc_lcd_enable_signal_polarity(bool act_high)
 	if (!dss_has_feature(FEAT_LCDENABLEPOL))
 		return;
 
-	dispc_runtime_get();
 	REG_FLD_MOD(DISPC_CONTROL, act_high ? 1 : 0, 29, 29);
-	dispc_runtime_put();
 }
 
 void dispc_lcd_enable_signal(bool enable)
@@ -2176,9 +2143,7 @@ void dispc_lcd_enable_signal(bool enable)
 	if (!dss_has_feature(FEAT_LCDENABLESIGNAL))
 		return;
 
-	dispc_runtime_get();
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 28, 28);
-	dispc_runtime_put();
 }
 
 void dispc_pck_free_enable(bool enable)
@@ -2186,19 +2151,15 @@ void dispc_pck_free_enable(bool enable)
 	if (!dss_has_feature(FEAT_PCKFREEENABLE))
 		return;
 
-	dispc_runtime_get();
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 27, 27);
-	dispc_runtime_put();
 }
 
 void dispc_enable_fifohandcheck(enum omap_channel channel, bool enable)
 {
-	dispc_runtime_get();
 	if (channel == OMAP_DSS_CHANNEL_LCD2)
 		REG_FLD_MOD(DISPC_CONFIG2, enable ? 1 : 0, 16, 16);
 	else
 		REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 16, 16);
-	dispc_runtime_put();
 }
 
 
@@ -2221,27 +2182,21 @@ void dispc_set_lcd_display_type(enum omap_channel channel,
 		return;
 	}
 
-	dispc_runtime_get();
 	if (channel == OMAP_DSS_CHANNEL_LCD2)
 		REG_FLD_MOD(DISPC_CONTROL2, mode, 3, 3);
 	else
 		REG_FLD_MOD(DISPC_CONTROL, mode, 3, 3);
-	dispc_runtime_put();
 }
 
 void dispc_set_loadmode(enum omap_dss_load_mode mode)
 {
-	dispc_runtime_get();
 	REG_FLD_MOD(DISPC_CONFIG, mode, 2, 1);
-	dispc_runtime_put();
 }
 
 
 void dispc_set_default_color(enum omap_channel channel, u32 color)
 {
-	dispc_runtime_get();
 	dispc_write_reg(DISPC_DEFAULT_COLOR(channel), color);
-	dispc_runtime_put();
 }
 
 u32 dispc_get_default_color(enum omap_channel channel)
@@ -2252,9 +2207,7 @@ u32 dispc_get_default_color(enum omap_channel channel)
 		channel != OMAP_DSS_CHANNEL_LCD &&
 		channel != OMAP_DSS_CHANNEL_LCD2);
 
-	dispc_runtime_get();
 	l = dispc_read_reg(DISPC_DEFAULT_COLOR(channel));
-	dispc_runtime_put();
 
 	return l;
 }
@@ -2263,7 +2216,6 @@ void dispc_set_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type type,
 		u32 trans_key)
 {
-	dispc_runtime_get();
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		REG_FLD_MOD(DISPC_CONFIG, type, 11, 11);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
@@ -2272,14 +2224,12 @@ void dispc_set_trans_key(enum omap_channel ch,
 		REG_FLD_MOD(DISPC_CONFIG2, type, 11, 11);
 
 	dispc_write_reg(DISPC_TRANS_COLOR(ch), trans_key);
-	dispc_runtime_put();
 }
 
 void dispc_get_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type *type,
 		u32 *trans_key)
 {
-	dispc_runtime_get();
 	if (type) {
 		if (ch == OMAP_DSS_CHANNEL_LCD)
 			*type = REG_GET(DISPC_CONFIG, 11, 11);
@@ -2293,33 +2243,28 @@ void dispc_get_trans_key(enum omap_channel ch,
 
 	if (trans_key)
 		*trans_key = dispc_read_reg(DISPC_TRANS_COLOR(ch));
-	dispc_runtime_put();
 }
 
 void dispc_enable_trans_key(enum omap_channel ch, bool enable)
 {
-	dispc_runtime_get();
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 10, 10);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 12, 12);
 	else /* OMAP_DSS_CHANNEL_LCD2 */
 		REG_FLD_MOD(DISPC_CONFIG2, enable, 10, 10);
-	dispc_runtime_put();
 }
 void dispc_enable_alpha_blending(enum omap_channel ch, bool enable)
 {
 	if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
 		return;
 
-	dispc_runtime_get();
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 18, 18);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 19, 19);
 	else /* OMAP_DSS_CHANNEL_LCD2 */
 		REG_FLD_MOD(DISPC_CONFIG2, enable, 18, 18);
-	dispc_runtime_put();
 }
 bool dispc_alpha_blending_enabled(enum omap_channel ch)
 {
@@ -2328,7 +2273,6 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
 	if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
 		return false;
 
-	dispc_runtime_get();
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		enabled = REG_GET(DISPC_CONFIG, 18, 18);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
@@ -2337,7 +2281,6 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
 		enabled = REG_GET(DISPC_CONFIG2, 18, 18);
 	else
 		BUG();
-	dispc_runtime_put();
 
 	return enabled;
 }
@@ -2347,7 +2290,6 @@ bool dispc_trans_key_enabled(enum omap_channel ch)
 {
 	bool enabled;
 
-	dispc_runtime_get();
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		enabled = REG_GET(DISPC_CONFIG, 10, 10);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
@@ -2356,7 +2298,6 @@ bool dispc_trans_key_enabled(enum omap_channel ch)
 		enabled = REG_GET(DISPC_CONFIG2, 10, 10);
 	else
 		BUG();
-	dispc_runtime_put();
 
 	return enabled;
 }
@@ -2384,12 +2325,10 @@ void dispc_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
 		return;
 	}
 
-	dispc_runtime_get();
 	if (channel == OMAP_DSS_CHANNEL_LCD2)
 		REG_FLD_MOD(DISPC_CONTROL2, code, 9, 8);
 	else
 		REG_FLD_MOD(DISPC_CONTROL, code, 9, 8);
-	dispc_runtime_put();
 }
 
 void dispc_set_parallel_interface_mode(enum omap_channel channel,
@@ -2421,8 +2360,6 @@ void dispc_set_parallel_interface_mode(enum omap_channel channel,
 		return;
 	}
 
-	dispc_runtime_get();
-
 	if (channel == OMAP_DSS_CHANNEL_LCD2) {
 		l = dispc_read_reg(DISPC_CONTROL2);
 		l = FLD_MOD(l, stallmode, 11, 11);
@@ -2434,8 +2371,6 @@ void dispc_set_parallel_interface_mode(enum omap_channel channel,
 		l = FLD_MOD(l, gpout1, 16, 16);
 		dispc_write_reg(DISPC_CONTROL, l);
 	}
-
-	dispc_runtime_put();
 }
 
 static bool _dispc_lcd_timings_ok(int hsw, int hfp, int hbp,
@@ -2488,10 +2423,8 @@ static void _dispc_set_lcd_timings(enum omap_channel channel, int hsw,
 			FLD_VAL(vbp, 31, 20);
 	}
 
-	dispc_runtime_get();
 	dispc_write_reg(DISPC_TIMING_H(channel), timing_h);
 	dispc_write_reg(DISPC_TIMING_V(channel), timing_v);
-	dispc_runtime_put();
 }
 
 /* change name to mode? */
@@ -2534,10 +2467,8 @@ static void dispc_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
 	BUG_ON(lck_div < 1);
 	BUG_ON(pck_div < 2);
 
-	dispc_runtime_get();
 	dispc_write_reg(DISPC_DIVISORo(channel),
 			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
-	dispc_runtime_put();
 }
 
 static void dispc_get_lcd_divisor(enum omap_channel channel, int *lck_div,
@@ -2997,9 +2928,7 @@ static void _dispc_set_pol_freq(enum omap_channel channel, bool onoff, bool rf,
 	l |= FLD_VAL(acbi, 11, 8);
 	l |= FLD_VAL(acb, 7, 0);
 
-	dispc_runtime_get();
 	dispc_write_reg(DISPC_POL_FREQ(channel), l);
-	dispc_runtime_put();
 }
 
 void dispc_set_pol_freq(enum omap_channel channel,
@@ -3120,15 +3049,11 @@ static void _omap_dispc_set_irqs(void)
 		mask |= isr_data->mask;
 	}
 
-	dispc_runtime_get();
-
 	old_mask = dispc_read_reg(DISPC_IRQENABLE);
 	/* clear the irqstatus for newly enabled irqs */
 	dispc_write_reg(DISPC_IRQSTATUS, (mask ^ old_mask) & mask);
 
 	dispc_write_reg(DISPC_IRQENABLE, mask);
-
-	dispc_runtime_put();
 }
 
 int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
@@ -3662,58 +3587,6 @@ static void _omap_dispc_initial_config(void)
 	dispc_read_plane_fifo_sizes();
 }
 
-int dispc_enable_plane(enum omap_plane plane, bool enable)
-{
-	DSSDBG("dispc_enable_plane %d, %d\n", plane, enable);
-
-	dispc_runtime_get();
-	_dispc_enable_plane(plane, enable);
-	dispc_runtime_put();
-
-	return 0;
-}
-
-int dispc_setup_plane(enum omap_plane plane,
-		       u32 paddr, u16 screen_width,
-		       u16 pos_x, u16 pos_y,
-		       u16 width, u16 height,
-		       u16 out_width, u16 out_height,
-		       enum omap_color_mode color_mode,
-		       bool ilace,
-		       enum omap_dss_rotation_type rotation_type,
-		       u8 rotation, bool mirror, u8 global_alpha,
-		       u8 pre_mult_alpha, enum omap_channel channel,
-		       u32 puv_addr)
-{
-	int r = 0;
-
-	DSSDBG("dispc_setup_plane %d, pa %x, sw %d, %d, %d, %dx%d -> "
-	       "%dx%d, ilace %d, cmode %x, rot %d, mir %d chan %d\n",
-	       plane, paddr, screen_width, pos_x, pos_y,
-	       width, height,
-	       out_width, out_height,
-	       ilace, color_mode,
-	       rotation, mirror, channel);
-
-	dispc_runtime_get();
-
-	r = _dispc_setup_plane(plane,
-			   paddr, screen_width,
-			   pos_x, pos_y,
-			   width, height,
-			   out_width, out_height,
-			   color_mode, ilace,
-			   rotation_type,
-			   rotation, mirror,
-			   global_alpha,
-			   pre_mult_alpha,
-			   channel, puv_addr);
-
-	dispc_runtime_put();
-
-	return r;
-}
-
 /* DISPC HW IP initialisation */
 static int omap_dispchw_probe(struct platform_device *pdev)
 {
-- 
1.7.4.1

