From: Archit Taneja <archit@ti.com>
Subject: [RFC][PATCH 5/8] OMAP: DSS2: Secondary LCD Channel in DISPC functions
Date: Thu,  1 Jul 2010 16:01:22 +0530
Message-ID: <1277980285-20996-6-git-send-email-archit@ti.com>
References: <1277980285-20996-1-git-send-email-archit@ti.com>
 <1277980285-20996-2-git-send-email-archit@ti.com>
 <1277980285-20996-3-git-send-email-archit@ti.com>
 <1277980285-20996-4-git-send-email-archit@ti.com>
 <1277980285-20996-5-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34585 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755008Ab0GAKb4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Jul 2010 06:31:56 -0400
In-Reply-To: <1277980285-20996-5-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@nokia.com, Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Introduce the new enum channel as a parameter in all dispc functions
used by interface drivers(dsi, sdi etc) in order to differentiate
between the 2 channels

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  326 ++++++++++++++++++++++++++++-----------
 drivers/video/omap2/dss/dss.h   |   29 ++--
 2 files changed, 253 insertions(+), 102 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 08b36d6..22fd2c2
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -521,12 +521,17 @@ bool dispc_go_busy(enum omap_channel channel)
 {
 	int bit;
 
-	if (channel == OMAP_DSS_CHANNEL_LCD)
+	if ((!cpu_is_omap44xx()) && (channel == OMAP_DSS_CHANNEL_LCD))
+		bit = 5; /* GOLCD */
+	else if (cpu_is_omap44xx() && (channel != OMAP_DSS_CHANNEL_DIGIT))
 		bit = 5; /* GOLCD */
 	else
 		bit = 6; /* GODIGIT */
 
-	return REG_GET(DISPC_CONTROL, bit, bit) == 1;
+	if (cpu_is_omap44xx() && (channel == OMAP_DSS_CHANNEL_LCD2))
+		return REG_GET(DISPC_CONTROL2, bit, bit) == 1;
+	else
+		return REG_GET(DISPC_CONTROL, bit, bit) == 1;
 }
 
 void dispc_go(enum omap_channel channel)
@@ -535,28 +540,47 @@ void dispc_go(enum omap_channel channel)
 
 	enable_clocks(1);
 
-	if (channel == OMAP_DSS_CHANNEL_LCD)
+	if ((channel == OMAP_DSS_CHANNEL_LCD) ||
+			(channel == OMAP_DSS_CHANNEL_LCD2))
 		bit = 0; /* LCDENABLE */
 	else
 		bit = 1; /* DIGITALENABLE */
 
 	/* if the channel is not enabled, we don't need GO */
-	if (REG_GET(DISPC_CONTROL, bit, bit) == 0)
-		goto end;
+	if (cpu_is_omap44xx() && (channel == OMAP_DSS_CHANNEL_LCD2)) {
+		if (REG_GET(DISPC_CONTROL2, bit, bit) == 0)
+			goto end;
+	} else {
+		if (REG_GET(DISPC_CONTROL, bit, bit) == 0)
+			goto end;
+	}
 
-	if (channel == OMAP_DSS_CHANNEL_LCD)
+	if ((channel == OMAP_DSS_CHANNEL_LCD) ||
+			(channel == OMAP_DSS_CHANNEL_LCD2))
 		bit = 5; /* GOLCD */
 	else
 		bit = 6; /* GODIGIT */
 
-	if (REG_GET(DISPC_CONTROL, bit, bit) == 1) {
-		DSSERR("GO bit not down for channel %d\n", channel);
-		goto end;
+	if (cpu_is_omap44xx() && (channel == OMAP_DSS_CHANNEL_LCD2)) {
+		if (REG_GET(DISPC_CONTROL2, bit, bit) == 1) {
+			DSSERR("GO bit not down for channel %d\n", channel);
+			goto end;
+		}
+	} else {
+		if (REG_GET(DISPC_CONTROL, bit, bit) == 1) {
+			DSSERR("GO bit not down for channel %d\n", channel);
+			goto end;
+		}
 	}
 
-	DSSDBG("GO %s\n", channel == OMAP_DSS_CHANNEL_LCD ? "LCD" : "DIGIT");
+	DSSDBG("GO %s\n", channel == OMAP_DSS_CHANNEL_LCD ? "LCD" :
+		channel == OMAP_DSS_CHANNEL_LCD2 ? "LCD2" : "DIGIT");
+
+	if (cpu_is_omap44xx() && (channel == OMAP_DSS_CHANNEL_LCD2))
+		REG_FLD_MOD(DISPC_CONTROL2, 1, bit, bit);
+	else
+		REG_FLD_MOD(DISPC_CONTROL, 1, bit, bit);
 
-	REG_FLD_MOD(DISPC_CONTROL, 1, bit, bit);
 end:
 	enable_clocks(0);
 }
@@ -898,6 +922,7 @@ static void _dispc_set_channel_out(enum omap_plane plane,
 {
 	int shift;
 	u32 val;
+	int chan = 0, chan2 = 0;
 
 	switch (plane) {
 	case OMAP_DSS_GFX:
@@ -913,7 +938,30 @@ static void _dispc_set_channel_out(enum omap_plane plane,
 	}
 
 	val = dispc_read_reg(dispc_reg_att[plane]);
-	val = FLD_MOD(val, channel, shift, shift);
+	if (cpu_is_omap44xx()) {
+		switch (channel) {
+
+		case OMAP_DSS_CHANNEL_LCD:
+			chan = 0;
+			chan2 = 0;
+			break;
+		case OMAP_DSS_CHANNEL_DIGIT:
+			chan = 1;
+			chan2 = 0;
+			break;
+		case OMAP_DSS_CHANNEL_LCD2:
+			chan = 0;
+			chan2 = 1;
+			break;
+		default:
+			BUG();
+		}
+
+		val = FLD_MOD(val, chan, shift, shift);
+		val = FLD_MOD(val, chan2, 31, 30);
+	} else {
+		val = FLD_MOD(val, channel, shift, shift);
+	}
 	dispc_write_reg(dispc_reg_att[plane], val);
 }
 
@@ -970,13 +1018,16 @@ void dispc_enable_replication(enum omap_plane plane, bool enable)
 	enable_clocks(0);
 }
 
-void dispc_set_lcd_size(u16 width, u16 height)
+void dispc_set_lcd_size(enum omap_channel channel, u16 width, u16 height)
 {
 	u32 val;
 	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
 	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
 	enable_clocks(1);
-	dispc_write_reg(DISPC_SIZE_LCD, val);
+	if (OMAP_DSS_CHANNEL_LCD2 == channel)
+		dispc_write_reg(DISPC_SIZE_LCD2, val);
+	else
+		dispc_write_reg(DISPC_SIZE_LCD, val);
 	enable_clocks(0);
 }
 
@@ -1471,12 +1522,13 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
 	}
 }
 
-static unsigned long calc_fclk_five_taps(u16 width, u16 height,
-		u16 out_width, u16 out_height, enum omap_color_mode color_mode)
+static unsigned long calc_fclk_five_taps(enum omap_channel channel,
+		u16 width, u16 height, u16 out_width, u16 out_height,
+		enum omap_color_mode color_mode)
 {
 	u32 fclk = 0;
 	/* FIXME venc pclk? */
-	u64 tmp, pclk = dispc_pclk_rate();
+	u64 tmp, pclk = dispc_pclk_rate(channel);
 
 	if (height > out_height) {
 		/* FIXME get real display PPL */
@@ -1508,8 +1560,8 @@ static unsigned long calc_fclk_five_taps(u16 width, u16 height,
 	return fclk;
 }
 
-static unsigned long calc_fclk(u16 width, u16 height,
-		u16 out_width, u16 out_height)
+static unsigned long calc_fclk(enum omap_channel channel, u16 width,
+			u16 height, u16 out_width, u16 out_height)
 {
 	unsigned int hf, vf;
 
@@ -1533,7 +1585,7 @@ static unsigned long calc_fclk(u16 width, u16 height,
 		vf = 1;
 
 	/* FIXME venc pclk? */
-	return dispc_pclk_rate() * vf * hf;
+	return dispc_pclk_rate(channel) * vf * hf;
 }
 
 void dispc_set_channel_out(enum omap_plane plane, enum omap_channel channel_out)
@@ -1552,7 +1604,8 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		bool ilace,
 		enum omap_dss_rotation_type rotation_type,
 		u8 rotation, int mirror,
-		u8 global_alpha)
+		u8 global_alpha,
+		enum omap_channel channel)
 {
 	const int maxdownscale = cpu_is_omap34xx() ? 4 : 2;
 	bool five_taps = 0;
@@ -1648,7 +1701,7 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		five_taps = height > out_height * 2;
 
 		if (!five_taps) {
-			fclk = calc_fclk(width, height,
+			fclk = calc_fclk(channel, width, height,
 					out_width, out_height);
 
 			/* Try 5-tap filter if 3-tap fclk is too high */
@@ -1663,7 +1716,7 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		}
 
 		if (five_taps)
-			fclk = calc_fclk_five_taps(width, height,
+			fclk = calc_fclk_five_taps(channel, width, height,
 					out_width, out_height, color_mode);
 
 		DSSDBG("required fclk rate = %lu Hz\n", fclk);
@@ -1752,12 +1805,16 @@ static void dispc_disable_isr(void *data, u32 mask)
 	complete(compl);
 }
 
-static void _enable_lcd_out(bool enable)
+static void _enable_lcd_out(enum omap_channel channel, bool enable)
 {
-	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 0, 0);
+	if (OMAP_DSS_CHANNEL_LCD2 == channel)
+		REG_FLD_MOD(DISPC_CONTROL2, enable ? 1 : 0, 0, 0);
+	else
+		REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 0, 0);
 }
 
-static void dispc_enable_lcd_out(bool enable)
+
+static void dispc_enable_lcd_out(enum omap_channel channel, bool enable)
 {
 	struct completion frame_done_completion;
 	bool is_on;
@@ -1781,7 +1838,7 @@ static void dispc_enable_lcd_out(bool enable)
 			DSSERR("failed to register FRAMEDONE isr\n");
 	}
 
-	_enable_lcd_out(enable);
+	_enable_lcd_out(channel, enable);
 
 	if (!enable && is_on) {
 		if (!wait_for_completion_timeout(&frame_done_completion,
@@ -1870,7 +1927,9 @@ static void dispc_enable_digit_out(bool enable)
 
 bool dispc_is_channel_enabled(enum omap_channel channel)
 {
-	if (channel == OMAP_DSS_CHANNEL_LCD)
+	if (channel == OMAP_DSS_CHANNEL_LCD2)
+		return !!REG_GET(DISPC_CONTROL2, 0, 0);
+	else if (channel == OMAP_DSS_CHANNEL_LCD)
 		return !!REG_GET(DISPC_CONTROL, 0, 0);
 	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
 		return !!REG_GET(DISPC_CONTROL, 1, 1);
@@ -1880,8 +1939,9 @@ bool dispc_is_channel_enabled(enum omap_channel channel)
 
 void dispc_enable_channel(enum omap_channel channel, bool enable)
 {
-	if (channel == OMAP_DSS_CHANNEL_LCD)
-		dispc_enable_lcd_out(enable);
+	if (channel == OMAP_DSS_CHANNEL_LCD ||
+		channel == OMAP_DSS_CHANNEL_LCD2)
+		dispc_enable_lcd_out(channel, enable);
 	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
 		dispc_enable_digit_out(enable);
 	else
@@ -1890,6 +1950,9 @@ void dispc_enable_channel(enum omap_channel channel, bool enable)
 
 void dispc_lcd_enable_signal_polarity(bool act_high)
 {
+	if (cpu_is_omap44xx())
+		return;
+
 	enable_clocks(1);
 	REG_FLD_MOD(DISPC_CONTROL, act_high ? 1 : 0, 29, 29);
 	enable_clocks(0);
@@ -1897,6 +1960,9 @@ void dispc_lcd_enable_signal_polarity(bool act_high)
 
 void dispc_lcd_enable_signal(bool enable)
 {
+	if (cpu_is_omap44xx())
+		return;
+
 	enable_clocks(1);
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 28, 28);
 	enable_clocks(0);
@@ -1904,6 +1970,9 @@ void dispc_lcd_enable_signal(bool enable)
 
 void dispc_pck_free_enable(bool enable)
 {
+	if (cpu_is_omap44xx())
+		return;
+
 	enable_clocks(1);
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 27, 27);
 	enable_clocks(0);
@@ -1917,7 +1986,8 @@ void dispc_enable_fifohandcheck(bool enable)
 }
 
 
-void dispc_set_lcd_display_type(enum omap_lcd_display_type type)
+void dispc_set_lcd_display_type(enum omap_channel channel,
+				enum omap_lcd_display_type type)
 {
 	int mode;
 
@@ -1936,7 +2006,11 @@ void dispc_set_lcd_display_type(enum omap_lcd_display_type type)
 	}
 
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONTROL, mode, 3, 3);
+	if (OMAP_DSS_CHANNEL_LCD2 == channel)
+		REG_FLD_MOD(DISPC_CONTROL2, mode, 3, 3);
+	else
+		REG_FLD_MOD(DISPC_CONTROL, mode, 3, 3);
+
 	enable_clocks(0);
 }
 
@@ -1947,12 +2021,10 @@ void dispc_set_loadmode(enum omap_dss_load_mode mode)
 	enable_clocks(0);
 }
 
-
 void dispc_set_default_color(enum omap_channel channel, u32 color)
 {
 	const struct dispc_reg def_reg[] = { DISPC_DEFAULT_COLOR0,
-				DISPC_DEFAULT_COLOR1 };
-
+				DISPC_DEFAULT_COLOR1, DISPC_DEFAULT_COLOR2 };
 	enable_clocks(1);
 	dispc_write_reg(def_reg[channel], color);
 	enable_clocks(0);
@@ -1961,11 +2033,12 @@ void dispc_set_default_color(enum omap_channel channel, u32 color)
 u32 dispc_get_default_color(enum omap_channel channel)
 {
 	const struct dispc_reg def_reg[] = { DISPC_DEFAULT_COLOR0,
-				DISPC_DEFAULT_COLOR1 };
+				DISPC_DEFAULT_COLOR1, DISPC_DEFAULT_COLOR2 };
 	u32 l;
 
-	BUG_ON(channel != OMAP_DSS_CHANNEL_DIGIT &&
-	       channel != OMAP_DSS_CHANNEL_LCD);
+	if (!cpu_is_omap44xx())
+		BUG_ON(channel != OMAP_DSS_CHANNEL_DIGIT &&
+			channel != OMAP_DSS_CHANNEL_LCD);
 
 	enable_clocks(1);
 	l = dispc_read_reg(def_reg[channel]);
@@ -1979,10 +2052,13 @@ void dispc_set_trans_key(enum omap_channel ch,
 		u32 trans_key)
 {
 	const struct dispc_reg tr_reg[] = {
-		DISPC_TRANS_COLOR0, DISPC_TRANS_COLOR1 };
+		DISPC_TRANS_COLOR0, DISPC_TRANS_COLOR1,
+		DISPC_TRANS_COLOR2};
 
 	enable_clocks(1);
-	if (ch == OMAP_DSS_CHANNEL_LCD)
+	if (ch == OMAP_DSS_CHANNEL_LCD2)
+		REG_FLD_MOD(DISPC_CONFIG2, type, 11, 11);
+	else if (ch == OMAP_DSS_CHANNEL_LCD)
 		REG_FLD_MOD(DISPC_CONFIG, type, 11, 11);
 	else /* OMAP_DSS_CHANNEL_DIGIT */
 		REG_FLD_MOD(DISPC_CONFIG, type, 13, 13);
@@ -1996,11 +2072,14 @@ void dispc_get_trans_key(enum omap_channel ch,
 		u32 *trans_key)
 {
 	const struct dispc_reg tr_reg[] = {
-		DISPC_TRANS_COLOR0, DISPC_TRANS_COLOR1 };
+		DISPC_TRANS_COLOR0, DISPC_TRANS_COLOR1,
+		DISPC_TRANS_COLOR2 };
 
 	enable_clocks(1);
 	if (type) {
-		if (ch == OMAP_DSS_CHANNEL_LCD)
+		if (ch == OMAP_DSS_CHANNEL_LCD2)
+			*type = REG_GET(DISPC_CONFIG2, 11, 11);
+		else if (ch == OMAP_DSS_CHANNEL_LCD)
 			*type = REG_GET(DISPC_CONFIG, 11, 11);
 		else if (ch == OMAP_DSS_CHANNEL_DIGIT)
 			*type = REG_GET(DISPC_CONFIG, 13, 13);
@@ -2016,12 +2095,15 @@ void dispc_get_trans_key(enum omap_channel ch,
 void dispc_enable_trans_key(enum omap_channel ch, bool enable)
 {
 	enable_clocks(1);
-	if (ch == OMAP_DSS_CHANNEL_LCD)
+	if (ch == OMAP_DSS_CHANNEL_LCD2)
+		REG_FLD_MOD(DISPC_CONFIG2, enable, 10, 10);
+	else if (ch == OMAP_DSS_CHANNEL_LCD)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 10, 10);
 	else /* OMAP_DSS_CHANNEL_DIGIT */
 		REG_FLD_MOD(DISPC_CONFIG, enable, 12, 12);
 	enable_clocks(0);
 }
+
 void dispc_enable_alpha_blending(enum omap_channel ch, bool enable)
 {
 	if (cpu_is_omap24xx())
@@ -2053,13 +2135,13 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
 	return enabled;
 
 }
-
-
 bool dispc_trans_key_enabled(enum omap_channel ch)
 {
 	bool enabled;
 
 	enable_clocks(1);
+	if (ch == OMAP_DSS_CHANNEL_LCD2)
+		enabled = REG_GET(DISPC_CONFIG2, 10, 10);
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		enabled = REG_GET(DISPC_CONFIG, 10, 10);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
@@ -2072,7 +2154,7 @@ bool dispc_trans_key_enabled(enum omap_channel ch)
 }
 
 
-void dispc_set_tft_data_lines(u8 data_lines)
+void dispc_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
 {
 	int code;
 
@@ -2095,11 +2177,15 @@ void dispc_set_tft_data_lines(u8 data_lines)
 	}
 
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONTROL, code, 9, 8);
+	if (channel == OMAP_DSS_CHANNEL_LCD2)
+		REG_FLD_MOD(DISPC_CONTROL2, code, 9, 8);
+	else
+		REG_FLD_MOD(DISPC_CONTROL, code, 9, 8);
 	enable_clocks(0);
 }
 
-void dispc_set_parallel_interface_mode(enum omap_parallel_interface_mode mode)
+void dispc_set_parallel_interface_mode(enum omap_channel channel,
+				enum omap_parallel_interface_mode mode)
 {
 	u32 l;
 	int stallmode;
@@ -2129,13 +2215,19 @@ void dispc_set_parallel_interface_mode(enum omap_parallel_interface_mode mode)
 
 	enable_clocks(1);
 
-	l = dispc_read_reg(DISPC_CONTROL);
+	if (OMAP_DSS_CHANNEL_LCD2 == channel) {
+		l = dispc_read_reg(DISPC_CONTROL2);
+		l = FLD_MOD(l, stallmode, 11, 11);
 
-	l = FLD_MOD(l, stallmode, 11, 11);
-	l = FLD_MOD(l, gpout0, 15, 15);
-	l = FLD_MOD(l, gpout1, 16, 16);
+		dispc_write_reg(DISPC_CONTROL2, l);
+	} else {
+		l = dispc_read_reg(DISPC_CONTROL);
+		l = FLD_MOD(l, stallmode, 11, 11);
+		l = FLD_MOD(l, gpout0, 15, 15);
+		l = FLD_MOD(l, gpout1, 16, 16);
 
-	dispc_write_reg(DISPC_CONTROL, l);
+		dispc_write_reg(DISPC_CONTROL, l);
+	}
 
 	enable_clocks(0);
 }
@@ -2171,8 +2263,8 @@ bool dispc_lcd_timings_ok(struct omap_video_timings *timings)
 			timings->vfp, timings->vbp);
 }
 
-static void _dispc_set_lcd_timings(int hsw, int hfp, int hbp,
-				   int vsw, int vfp, int vbp)
+static void _dispc_set_lcd_timings(enum omap_channel channel, int hsw,
+			int hfp, int hbp, int vsw, int vfp, int vbp)
 {
 	u32 timing_h, timing_v;
 
@@ -2191,13 +2283,19 @@ static void _dispc_set_lcd_timings(int hsw, int hfp, int hbp,
 	}
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_TIMING_H, timing_h);
-	dispc_write_reg(DISPC_TIMING_V, timing_v);
+	if (OMAP_DSS_CHANNEL_LCD2 == channel) {
+		dispc_write_reg(DISPC_TIMING_H2, timing_h);
+		dispc_write_reg(DISPC_TIMING_V2, timing_v);
+	} else {
+		dispc_write_reg(DISPC_TIMING_H, timing_h);
+		dispc_write_reg(DISPC_TIMING_V, timing_v);
+	}
 	enable_clocks(0);
 }
 
 /* change name to mode? */
-void dispc_set_lcd_timings(struct omap_video_timings *timings)
+void dispc_set_lcd_timings(enum omap_channel channel,
+				struct omap_video_timings *timings)
 {
 	unsigned xtot, ytot;
 	unsigned long ht, vt;
@@ -2207,10 +2305,11 @@ void dispc_set_lcd_timings(struct omap_video_timings *timings)
 				timings->vfp, timings->vbp))
 		BUG();
 
-	_dispc_set_lcd_timings(timings->hsw, timings->hfp, timings->hbp,
-			timings->vsw, timings->vfp, timings->vbp);
+	_dispc_set_lcd_timings(channel, timings->hsw, timings->hfp,
+				timings->hbp, timings->vsw, timings->vfp,
+				timings->vbp);
 
-	dispc_set_lcd_size(timings->x_res, timings->y_res);
+	dispc_set_lcd_size(channel, timings->x_res, timings->y_res);
 
 	xtot = timings->x_res + timings->hfp + timings->hsw + timings->hbp;
 	ytot = timings->y_res + timings->vfp + timings->vsw + timings->vbp;
@@ -2218,7 +2317,8 @@ void dispc_set_lcd_timings(struct omap_video_timings *timings)
 	ht = (timings->pixel_clock * 1000) / xtot;
 	vt = (timings->pixel_clock * 1000) / xtot / ytot;
 
-	DSSDBG("xres %u yres %u\n", timings->x_res, timings->y_res);
+	DSSDBG("channel %u xres %u yres %u\n", channel, timings->x_res,
+						timings->y_res);
 	DSSDBG("pck %u\n", timings->pixel_clock);
 	DSSDBG("hsw %d hfp %d hbp %d vsw %d vfp %d vbp %d\n",
 			timings->hsw, timings->hfp, timings->hbp,
@@ -2227,21 +2327,30 @@ void dispc_set_lcd_timings(struct omap_video_timings *timings)
 	DSSDBG("hsync %luHz, vsync %luHz\n", ht, vt);
 }
 
-static void dispc_set_lcd_divisor(u16 lck_div, u16 pck_div)
+static void dispc_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
+								u16 pck_div)
 {
 	BUG_ON(lck_div < 1);
 	BUG_ON(pck_div < 2);
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_DIVISOR,
+	if (OMAP_DSS_CHANNEL_LCD2 == channel)
+		dispc_write_reg(DISPC_DIVISOR2,
+			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
+	else
+		dispc_write_reg(DISPC_DIVISOR,
 			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
 	enable_clocks(0);
 }
 
-static void dispc_get_lcd_divisor(int *lck_div, int *pck_div)
+static void dispc_get_lcd_divisor(enum omap_channel channel,
+						int *lck_div, int *pck_div)
 {
 	u32 l;
-	l = dispc_read_reg(DISPC_DIVISOR);
+	if (OMAP_DSS_CHANNEL_LCD2 == channel)
+		l = dispc_read_reg(DISPC_DIVISOR2);
+	else
+		l = dispc_read_reg(DISPC_DIVISOR);
 	*lck_div = FLD_GET(l, 23, 16);
 	*pck_div = FLD_GET(l, 7, 0);
 }
@@ -2261,13 +2370,15 @@ unsigned long dispc_fclk_rate(void)
 	return r;
 }
 
-unsigned long dispc_lclk_rate(void)
+unsigned long dispc_lclk_rate(enum omap_channel channel)
 {
 	int lcd;
 	unsigned long r;
 	u32 l;
-
-	l = dispc_read_reg(DISPC_DIVISOR);
+	if (OMAP_DSS_CHANNEL_LCD2 == channel)
+		l = dispc_read_reg(DISPC_DIVISOR2);
+	else
+		l = dispc_read_reg(DISPC_DIVISOR);
 
 	lcd = FLD_GET(l, 23, 16);
 
@@ -2276,13 +2387,15 @@ unsigned long dispc_lclk_rate(void)
 	return r / lcd;
 }
 
-unsigned long dispc_pclk_rate(void)
+unsigned long dispc_pclk_rate(enum omap_channel channel)
 {
 	int lcd, pcd;
 	unsigned long r;
 	u32 l;
-
-	l = dispc_read_reg(DISPC_DIVISOR);
+	if (OMAP_DSS_CHANNEL_LCD2 == channel)
+		l = dispc_read_reg(DISPC_DIVISOR2);
+	else
+		l = dispc_read_reg(DISPC_DIVISOR);
 
 	lcd = FLD_GET(l, 23, 16);
 	pcd = FLD_GET(l, 7, 0);
@@ -2298,7 +2411,7 @@ void dispc_dump_clocks(struct seq_file *s)
 
 	enable_clocks(1);
 
-	dispc_get_lcd_divisor(&lcd, &pcd);
+	dispc_get_lcd_divisor(OMAP_DSS_CHANNEL_LCD, &lcd, &pcd);
 
 	seq_printf(s, "- DISPC -\n");
 
@@ -2307,8 +2420,26 @@ void dispc_dump_clocks(struct seq_file *s)
 			"dss1_alwon_fclk" : "dsi1_pll_fclk");
 
 	seq_printf(s, "fck\t\t%-16lu\n", dispc_fclk_rate());
-	seq_printf(s, "lck\t\t%-16lulck div\t%u\n", dispc_lclk_rate(), lcd);
-	seq_printf(s, "pck\t\t%-16lupck div\t%u\n", dispc_pclk_rate(), pcd);
+	seq_printf(s, "lck\t\t%-16lulck div\t%u\n",
+			dispc_lclk_rate(OMAP_DSS_CHANNEL_LCD), lcd);
+	seq_printf(s, "pck\t\t%-16lupck div\t%u\n",
+			dispc_pclk_rate(OMAP_DSS_CHANNEL_LCD), pcd);
+
+	if (cpu_is_omap44xx()) {
+		dispc_get_lcd_divisor(OMAP_DSS_CHANNEL_LCD2, &lcd, &pcd);
+
+		seq_printf(s, "- DISPC - LCD 2\n");
+
+		seq_printf(s, "dispc fclk source = %s\n",
+			 dss_get_dispc_clk_source() == 0 ?
+			 "dss1_alwon_fclk" : "dsi1_pll_fclk");
+
+		seq_printf(s, "fck\t\t%-16lu\n", dispc_fclk_rate());
+		seq_printf(s, "lck\t\t%-16lulck div\t%u\n",
+				dispc_lclk_rate(OMAP_DSS_CHANNEL_LCD2), lcd);
+		seq_printf(s, "pck\t\t%-16lupck div\t%u\n",
+				dispc_pclk_rate(OMAP_DSS_CHANNEL_LCD2), pcd);
+	}
 
 	enable_clocks(0);
 }
@@ -2518,8 +2649,9 @@ void dispc_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-static void _dispc_set_pol_freq(bool onoff, bool rf, bool ieo, bool ipc,
-				bool ihs, bool ivs, u8 acbi, u8 acb)
+static void _dispc_set_pol_freq(enum omap_channel channel, bool onoff, bool rf,
+				bool ieo, bool ipc, bool ihs, bool ivs,
+				u8 acbi, u8 acb)
 {
 	u32 l = 0;
 
@@ -2536,13 +2668,17 @@ static void _dispc_set_pol_freq(bool onoff, bool rf, bool ieo, bool ipc,
 	l |= FLD_VAL(acb, 7, 0);
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_POL_FREQ, l);
+	if (OMAP_DSS_CHANNEL_LCD2 == channel)
+		dispc_write_reg(DISPC_POL_FREQ2, l);
+	else
+		dispc_write_reg(DISPC_POL_FREQ, l);
 	enable_clocks(0);
 }
 
-void dispc_set_pol_freq(enum omap_panel_config config, u8 acbi, u8 acb)
+void dispc_set_pol_freq(enum omap_channel channel,
+			enum omap_panel_config config, u8 acbi, u8 acb)
 {
-	_dispc_set_pol_freq((config & OMAP_DSS_LCD_ONOFF) != 0,
+	_dispc_set_pol_freq(channel, (config & OMAP_DSS_LCD_ONOFF) != 0,
 			(config & OMAP_DSS_LCD_RF) != 0,
 			(config & OMAP_DSS_LCD_IEO) != 0,
 			(config & OMAP_DSS_LCD_IPC) != 0,
@@ -2611,25 +2747,31 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 	return 0;
 }
 
-int dispc_set_clock_div(struct dispc_clock_info *cinfo)
+int dispc_set_clock_div(enum omap_channel channel,
+	struct dispc_clock_info *cinfo)
 {
 	DSSDBG("lck = %lu (%u)\n", cinfo->lck, cinfo->lck_div);
 	DSSDBG("pck = %lu (%u)\n", cinfo->pck, cinfo->pck_div);
 
-	dispc_set_lcd_divisor(cinfo->lck_div, cinfo->pck_div);
+	dispc_set_lcd_divisor(channel, cinfo->lck_div,
+		cinfo->pck_div);
 
 	return 0;
 }
 
-int dispc_get_clock_div(struct dispc_clock_info *cinfo)
+int dispc_get_clock_div(enum omap_channel channel,
+	struct dispc_clock_info *cinfo)
 {
 	unsigned long fck;
 
 	fck = dispc_fclk_rate();
-
-	cinfo->lck_div = REG_GET(DISPC_DIVISOR, 23, 16);
-	cinfo->pck_div = REG_GET(DISPC_DIVISOR, 7, 0);
-
+	if (OMAP_DSS_CHANNEL_LCD2 == channel) {
+		cinfo->lck_div = REG_GET(DISPC_DIVISOR2, 23, 16);
+		cinfo->pck_div = REG_GET(DISPC_DIVISOR2, 7, 0);
+	} else {
+		cinfo->lck_div = REG_GET(DISPC_DIVISOR, 23, 16);
+		cinfo->pck_div = REG_GET(DISPC_DIVISOR, 7, 0);
+	}
 	cinfo->lck = fck / cinfo->lck_div;
 	cinfo->pck = cinfo->lck / cinfo->pck_div;
 
@@ -3199,17 +3341,18 @@ int dispc_setup_plane(enum omap_plane plane,
 		       enum omap_color_mode color_mode,
 		       bool ilace,
 		       enum omap_dss_rotation_type rotation_type,
-		       u8 rotation, bool mirror, u8 global_alpha)
+		       u8 rotation, bool mirror, u8 global_alpha,
+		       enum omap_channel channel)
 {
 	int r = 0;
 
 	DSSDBG("dispc_setup_plane %d, pa %x, sw %d, %d,%d, %dx%d -> "
-	       "%dx%d, ilace %d, cmode %x, rot %d, mir %d\n",
+	       "%dx%d, ilace %d, cmode %x, rot %d, mir %d chan %d\n",
 	       plane, paddr, screen_width, pos_x, pos_y,
 	       width, height,
 	       out_width, out_height,
 	       ilace, color_mode,
-	       rotation, mirror);
+	       rotation, mirror, channel);
 
 	enable_clocks(1);
 
@@ -3221,7 +3364,8 @@ int dispc_setup_plane(enum omap_plane plane,
 			   color_mode, ilace,
 			   rotation_type,
 			   rotation, mirror,
-			   global_alpha);
+			   global_alpha,
+			   channel);
 
 	enable_clocks(0);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 5c7940d..456c702
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -335,7 +335,7 @@ void dispc_lcd_enable_signal(bool enable);
 void dispc_pck_free_enable(bool enable);
 void dispc_enable_fifohandcheck(bool enable);
 
-void dispc_set_lcd_size(u16 width, u16 height);
+void dispc_set_lcd_size(enum omap_channel channel, u16 width, u16 height);
 void dispc_set_digit_size(u16 width, u16 height);
 u32 dispc_get_plane_fifo_size(enum omap_plane plane);
 void dispc_setup_plane_fifo(enum omap_plane plane, u32 low, u32 high);
@@ -359,7 +359,7 @@ int dispc_setup_plane(enum omap_plane plane,
 		      bool ilace,
 		      enum omap_dss_rotation_type rotation_type,
 		      u8 rotation, bool mirror,
-		      u8 global_alpha);
+		      u8 global_alpha, enum omap_channel channel);
 
 bool dispc_go_busy(enum omap_channel channel);
 void dispc_go(enum omap_channel channel);
@@ -368,9 +368,12 @@ bool dispc_is_channel_enabled(enum omap_channel channel);
 int dispc_enable_plane(enum omap_plane plane, bool enable);
 void dispc_enable_replication(enum omap_plane plane, bool enable);
 
-void dispc_set_parallel_interface_mode(enum omap_parallel_interface_mode mode);
-void dispc_set_tft_data_lines(u8 data_lines);
-void dispc_set_lcd_display_type(enum omap_lcd_display_type type);
+void dispc_set_parallel_interface_mode(enum omap_channel channel,
+				enum omap_parallel_interface_mode mode);
+void dispc_set_tft_data_lines(enum omap_channel channel,
+						u8 data_lines);
+void dispc_set_lcd_display_type(enum omap_channel channel,
+				enum omap_lcd_display_type type);
 void dispc_set_loadmode(enum omap_dss_load_mode mode);
 
 void dispc_set_default_color(enum omap_channel channel, u32 color);
@@ -387,17 +390,21 @@ bool dispc_trans_key_enabled(enum omap_channel ch);
 bool dispc_alpha_blending_enabled(enum omap_channel ch);
 
 bool dispc_lcd_timings_ok(struct omap_video_timings *timings);
-void dispc_set_lcd_timings(struct omap_video_timings *timings);
+void dispc_set_lcd_timings(enum omap_channel channel,
+				struct omap_video_timings *timings);
 unsigned long dispc_fclk_rate(void);
-unsigned long dispc_lclk_rate(void);
-unsigned long dispc_pclk_rate(void);
-void dispc_set_pol_freq(enum omap_panel_config config, u8 acbi, u8 acb);
+unsigned long dispc_lclk_rate(enum omap_channel channel);
+unsigned long dispc_pclk_rate(enum omap_channel channel);
+void dispc_set_pol_freq(enum omap_channel channel,
+			enum omap_panel_config config, u8 acbi, u8 acb);
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
-- 
1.6.3.3

