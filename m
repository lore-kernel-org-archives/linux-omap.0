From: Archit Taneja <archit@ti.com>
Subject: [RFC v2][PATCH 4/7] OMAP: DSS2: Incorporate Secondary LCD Channel DISPC Registers
Date: Wed, 14 Jul 2010 12:02:44 +0530
Message-ID: <1279089167-14057-5-git-send-email-archit@ti.com>
References: <1279089167-14057-1-git-send-email-archit@ti.com>
 <1279089167-14057-2-git-send-email-archit@ti.com>
 <1279089167-14057-3-git-send-email-archit@ti.com>
 <1279089167-14057-4-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56876 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab0GNGdO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Jul 2010 02:33:14 -0400
In-Reply-To: <1279089167-14057-4-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Introduce OMAP4 DISPC Secondary LCD Channel registers and the new enum channel
as a parameter in all dispc functions used by interface drivers(dsi, sdi etc)
in order to differentiate between the 2 channels.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  524 +++++++++++++++++++++++----------------
 drivers/video/omap2/dss/dss.h   |   31 ++-
 2 files changed, 335 insertions(+), 220 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 5ecdc00..060768a
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -55,22 +55,31 @@ struct dispc_reg { u16 idx; };
 #define DISPC_SYSSTATUS			DISPC_REG(0x0014)
 #define DISPC_IRQSTATUS			DISPC_REG(0x0018)
 #define DISPC_IRQENABLE			DISPC_REG(0x001C)
-#define DISPC_CONTROL			DISPC_REG(0x0040)
-#define DISPC_CONFIG			DISPC_REG(0x0044)
+#define DISPC_CONTROL(ch)	DISPC_REG(ch != OMAP_DSS_CHANNEL_LCD2 ? \
+						(0x0040) : (0x0238))
+#define DISPC_CONFIG(ch)	DISPC_REG(ch != OMAP_DSS_CHANNEL_LCD2 ? \
+						(0x0044) : (0x0620))
 #define DISPC_CAPABLE			DISPC_REG(0x0048)
-#define DISPC_DEFAULT_COLOR0		DISPC_REG(0x004C)
-#define DISPC_DEFAULT_COLOR1		DISPC_REG(0x0050)
-#define DISPC_TRANS_COLOR0		DISPC_REG(0x0054)
-#define DISPC_TRANS_COLOR1		DISPC_REG(0x0058)
+#define DISPC_DEFAULT_COLOR(ch)	DISPC_REG(ch == OMAP_DSS_CHANNEL_LCD \
+				? (0x004C) : (ch == OMAP_DSS_CHANNEL_DIGIT ? \
+				(0x0050) : (0x03AC)))
+#define DISPC_TRANS_COLOR(ch)	DISPC_REG(ch == OMAP_DSS_CHANNEL_LCD \
+				? (0x0054) : (ch == OMAP_DSS_CHANNEL_DIGIT ? \
+				(0x0058) : (0x03B0)))
 #define DISPC_LINE_STATUS		DISPC_REG(0x005C)
 #define DISPC_LINE_NUMBER		DISPC_REG(0x0060)
-#define DISPC_TIMING_H			DISPC_REG(0x0064)
-#define DISPC_TIMING_V			DISPC_REG(0x0068)
-#define DISPC_POL_FREQ			DISPC_REG(0x006C)
-#define DISPC_DIVISOR			DISPC_REG(0x0070)
+#define DISPC_TIMING_H(ch)	DISPC_REG(ch != OMAP_DSS_CHANNEL_LCD2 ? \
+						(0x0064) : (0x0400))
+#define DISPC_TIMING_V(ch)	DISPC_REG(ch != OMAP_DSS_CHANNEL_LCD2 ? \
+						(0x0068) : (0x0404))
+#define DISPC_POL_FREQ(ch)	DISPC_REG(ch != OMAP_DSS_CHANNEL_LCD2 ? \
+						(0x006C) : (0x0408))
+#define DISPC_DIVISOR(ch)	DISPC_REG(ch != OMAP_DSS_CHANNEL_LCD2 ? \
+						(0x0070) : (0x040C))
 #define DISPC_GLOBAL_ALPHA		DISPC_REG(0x0074)
 #define DISPC_SIZE_DIG			DISPC_REG(0x0078)
-#define DISPC_SIZE_LCD			DISPC_REG(0x007C)
+#define DISPC_SIZE_LCD(ch)	DISPC_REG(ch != OMAP_DSS_CHANNEL_LCD2 ? \
+						(0x007C) : (0x03CC))
 
 /* DISPC GFX plane */
 #define DISPC_GFX_BA0			DISPC_REG(0x0080)
@@ -85,13 +94,19 @@ struct dispc_reg { u16 idx; };
 #define DISPC_GFX_WINDOW_SKIP		DISPC_REG(0x00B4)
 #define DISPC_GFX_TABLE_BA		DISPC_REG(0x00B8)
 
-#define DISPC_DATA_CYCLE1		DISPC_REG(0x01D4)
-#define DISPC_DATA_CYCLE2		DISPC_REG(0x01D8)
-#define DISPC_DATA_CYCLE3		DISPC_REG(0x01DC)
-
-#define DISPC_CPR_COEF_R		DISPC_REG(0x0220)
-#define DISPC_CPR_COEF_G		DISPC_REG(0x0224)
-#define DISPC_CPR_COEF_B		DISPC_REG(0x0228)
+/* LCD channels, channel= 0 for primary and n = 2 for secondary */
+#define DISPC_DATA_CYCLE1(ch)	DISPC_REG(ch != OMAP_DSS_CHANNEL_LCD2 ? \
+						(0x01D4) : (0x03C0))
+#define DISPC_DATA_CYCLE2(ch)	DISPC_REG(ch != OMAP_DSS_CHANNEL_LCD2 ? \
+						(0x01D8) : (0x03C4))
+#define DISPC_DATA_CYCLE3(ch)	DISPC_REG(ch != OMAP_DSS_CHANNEL_LCD2 ? \
+						(0x01DC) : (0x03C8))
+#define DISPC_CPR_COEF_R(ch)	DISPC_REG(ch != OMAP_DSS_CHANNEL_LCD2 ? \
+						(0x0220) : (0x03BC))
+#define DISPC_CPR_COEF_G(ch)	DISPC_REG(ch != OMAP_DSS_CHANNEL_LCD2 ? \
+						(0x0224) : (0x03B8))
+#define DISPC_CPR_COEF_B(ch)	DISPC_REG(ch != OMAP_DSS_CHANNEL_LCD2 ? \
+						(0x0228) : (0x03B4))
 
 #define DISPC_GFX_PRELOAD		DISPC_REG(0x022C)
 
@@ -198,20 +213,20 @@ void dispc_save_context(void)
 
 	SR(SYSCONFIG);
 	SR(IRQENABLE);
-	SR(CONTROL);
-	SR(CONFIG);
-	SR(DEFAULT_COLOR0);
-	SR(DEFAULT_COLOR1);
-	SR(TRANS_COLOR0);
-	SR(TRANS_COLOR1);
+	SR(CONTROL(0));
+	SR(CONFIG(0));
+	SR(DEFAULT_COLOR(0));
+	SR(DEFAULT_COLOR(1));
+	SR(TRANS_COLOR(0));
+	SR(TRANS_COLOR(1));
 	SR(LINE_NUMBER);
-	SR(TIMING_H);
-	SR(TIMING_V);
-	SR(POL_FREQ);
-	SR(DIVISOR);
+	SR(TIMING_H(0));
+	SR(TIMING_V(0));
+	SR(POL_FREQ(0));
+	SR(DIVISOR(0));
 	SR(GLOBAL_ALPHA);
 	SR(SIZE_DIG);
-	SR(SIZE_LCD);
+	SR(SIZE_LCD(0));
 
 	SR(GFX_BA0);
 	SR(GFX_BA1);
@@ -224,13 +239,13 @@ void dispc_save_context(void)
 	SR(GFX_WINDOW_SKIP);
 	SR(GFX_TABLE_BA);
 
-	SR(DATA_CYCLE1);
-	SR(DATA_CYCLE2);
-	SR(DATA_CYCLE3);
+	SR(DATA_CYCLE1(0));
+	SR(DATA_CYCLE2(0));
+	SR(DATA_CYCLE3(0));
 
-	SR(CPR_COEF_R);
-	SR(CPR_COEF_G);
-	SR(CPR_COEF_B);
+	SR(CPR_COEF_R(0));
+	SR(CPR_COEF_G(0));
+	SR(CPR_COEF_B(0));
 
 	SR(GFX_PRELOAD);
 
@@ -338,19 +353,19 @@ void dispc_restore_context(void)
 	RR(SYSCONFIG);
 	/*RR(IRQENABLE);*/
 	/*RR(CONTROL);*/
-	RR(CONFIG);
-	RR(DEFAULT_COLOR0);
-	RR(DEFAULT_COLOR1);
-	RR(TRANS_COLOR0);
-	RR(TRANS_COLOR1);
+	RR(CONFIG(0));
+	RR(DEFAULT_COLOR(0));
+	RR(DEFAULT_COLOR(1));
+	RR(TRANS_COLOR(0));
+	RR(TRANS_COLOR(1));
 	RR(LINE_NUMBER);
-	RR(TIMING_H);
-	RR(TIMING_V);
-	RR(POL_FREQ);
-	RR(DIVISOR);
+	RR(TIMING_H(0));
+	RR(TIMING_V(0));
+	RR(POL_FREQ(0));
+	RR(DIVISOR(0));
 	RR(GLOBAL_ALPHA);
 	RR(SIZE_DIG);
-	RR(SIZE_LCD);
+	RR(SIZE_LCD(0));
 
 	RR(GFX_BA0);
 	RR(GFX_BA1);
@@ -363,13 +378,13 @@ void dispc_restore_context(void)
 	RR(GFX_WINDOW_SKIP);
 	RR(GFX_TABLE_BA);
 
-	RR(DATA_CYCLE1);
-	RR(DATA_CYCLE2);
-	RR(DATA_CYCLE3);
+	RR(DATA_CYCLE1(0));
+	RR(DATA_CYCLE2(0));
+	RR(DATA_CYCLE3(0));
 
-	RR(CPR_COEF_R);
-	RR(CPR_COEF_G);
-	RR(CPR_COEF_B);
+	RR(CPR_COEF_R(0));
+	RR(CPR_COEF_G(0));
+	RR(CPR_COEF_B(0));
 
 	RR(GFX_PRELOAD);
 
@@ -472,7 +487,7 @@ void dispc_restore_context(void)
 	RR(VID_PRELOAD(1));
 
 	/* enable last, because LCD & DIGIT enable are here */
-	RR(CONTROL);
+	RR(CONTROL(0));
 
 	/* clear spurious SYNC_LOST_DIGIT interrupts */
 	dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
@@ -499,12 +514,14 @@ bool dispc_go_busy(enum omap_channel channel)
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
+	return REG_GET(DISPC_CONTROL(channel), bit, bit) == 1;
 }
 
 void dispc_go(enum omap_channel channel)
@@ -513,28 +530,32 @@ void dispc_go(enum omap_channel channel)
 
 	enable_clocks(1);
 
-	if (channel == OMAP_DSS_CHANNEL_LCD)
+	if ((channel == OMAP_DSS_CHANNEL_LCD) ||
+			(channel == OMAP_DSS_CHANNEL_LCD2))
 		bit = 0; /* LCDENABLE */
 	else
 		bit = 1; /* DIGITALENABLE */
 
 	/* if the channel is not enabled, we don't need GO */
-	if (REG_GET(DISPC_CONTROL, bit, bit) == 0)
+	if (REG_GET(DISPC_CONTROL(channel), bit, bit) == 0)
 		goto end;
 
-	if (channel == OMAP_DSS_CHANNEL_LCD)
+	if ((channel == OMAP_DSS_CHANNEL_LCD) ||
+			(channel == OMAP_DSS_CHANNEL_LCD2))
 		bit = 5; /* GOLCD */
 	else
 		bit = 6; /* GODIGIT */
 
-	if (REG_GET(DISPC_CONTROL, bit, bit) == 1) {
+	if (REG_GET(DISPC_CONTROL(channel), bit, bit) == 1) {
 		DSSERR("GO bit not down for channel %d\n", channel);
 		goto end;
 	}
 
-	DSSDBG("GO %s\n", channel == OMAP_DSS_CHANNEL_LCD ? "LCD" : "DIGIT");
+	DSSDBG("GO %s\n", channel == OMAP_DSS_CHANNEL_LCD ? "LCD" :
+		channel == OMAP_DSS_CHANNEL_LCD2 ? "LCD2" : "DIGIT");
+
+	REG_FLD_MOD(DISPC_CONTROL(channel), 1, bit, bit);
 
-	REG_FLD_MOD(DISPC_CONTROL, 1, bit, bit);
 end:
 	enable_clocks(0);
 }
@@ -876,6 +897,7 @@ static void _dispc_set_channel_out(enum omap_plane plane,
 {
 	int shift;
 	u32 val;
+	int chan = 0, chan2 = 0;
 
 	switch (plane) {
 	case OMAP_DSS_GFX:
@@ -891,7 +913,30 @@ static void _dispc_set_channel_out(enum omap_plane plane,
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
 
@@ -948,13 +993,13 @@ void dispc_enable_replication(enum omap_plane plane, bool enable)
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
+	dispc_write_reg(DISPC_SIZE_LCD(channel), val);
 	enable_clocks(0);
 }
 
@@ -1025,7 +1070,7 @@ void dispc_enable_fifomerge(bool enable)
 	enable_clocks(1);
 
 	DSSDBG("FIFO merge %s\n", enable ? "enabled" : "disabled");
-	REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 14, 14);
+	REG_FLD_MOD(DISPC_CONFIG(OMAP_DSS_CHANNEL_LCD), enable ? 1 : 0, 14, 14);
 
 	enable_clocks(0);
 }
@@ -1449,12 +1494,13 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
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
@@ -1486,8 +1532,8 @@ static unsigned long calc_fclk_five_taps(u16 width, u16 height,
 	return fclk;
 }
 
-static unsigned long calc_fclk(u16 width, u16 height,
-		u16 out_width, u16 out_height)
+static unsigned long calc_fclk(enum omap_channel channel, u16 width,
+			u16 height, u16 out_width, u16 out_height)
 {
 	unsigned int hf, vf;
 
@@ -1511,7 +1557,7 @@ static unsigned long calc_fclk(u16 width, u16 height,
 		vf = 1;
 
 	/* FIXME venc pclk? */
-	return dispc_pclk_rate() * vf * hf;
+	return dispc_pclk_rate(channel) * vf * hf;
 }
 
 void dispc_set_channel_out(enum omap_plane plane, enum omap_channel channel_out)
@@ -1530,7 +1576,8 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		bool ilace,
 		enum omap_dss_rotation_type rotation_type,
 		u8 rotation, int mirror,
-		u8 global_alpha)
+		u8 global_alpha,
+		enum omap_channel channel)
 {
 	const int maxdownscale = cpu_is_omap34xx() ? 4 : 2;
 	bool five_taps = 0;
@@ -1626,7 +1673,7 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		five_taps = height > out_height * 2;
 
 		if (!five_taps) {
-			fclk = calc_fclk(width, height,
+			fclk = calc_fclk(channel, width, height,
 					out_width, out_height);
 
 			/* Try 5-tap filter if 3-tap fclk is too high */
@@ -1641,7 +1688,7 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		}
 
 		if (five_taps)
-			fclk = calc_fclk_five_taps(width, height,
+			fclk = calc_fclk_five_taps(channel, width, height,
 					out_width, out_height, color_mode);
 
 		DSSDBG("required fclk rate = %lu Hz\n", fclk);
@@ -1730,12 +1777,13 @@ static void dispc_disable_isr(void *data, u32 mask)
 	complete(compl);
 }
 
-static void _enable_lcd_out(bool enable)
+static void _enable_lcd_out(enum omap_channel channel, bool enable)
 {
-	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 0, 0);
+	REG_FLD_MOD(DISPC_CONTROL(channel), enable ? 1 : 0, 0, 0);
 }
 
-static void dispc_enable_lcd_out(bool enable)
+
+static void dispc_enable_lcd_out(enum omap_channel channel, bool enable)
 {
 	struct completion frame_done_completion;
 	bool is_on;
@@ -1746,7 +1794,7 @@ static void dispc_enable_lcd_out(bool enable)
 	/* When we disable LCD output, we need to wait until frame is done.
 	 * Otherwise the DSS is still working, and turning off the clocks
 	 * prevents DSS from going to OFF mode */
-	is_on = REG_GET(DISPC_CONTROL, 0, 0);
+	is_on = REG_GET(DISPC_CONTROL(channel), 0, 0);
 
 	if (!enable && is_on) {
 		init_completion(&frame_done_completion);
@@ -1759,7 +1807,7 @@ static void dispc_enable_lcd_out(bool enable)
 			DSSERR("failed to register FRAMEDONE isr\n");
 	}
 
-	_enable_lcd_out(enable);
+	_enable_lcd_out(channel, enable);
 
 	if (!enable && is_on) {
 		if (!wait_for_completion_timeout(&frame_done_completion,
@@ -1777,19 +1825,19 @@ static void dispc_enable_lcd_out(bool enable)
 	enable_clocks(0);
 }
 
-static void _enable_digit_out(bool enable)
+static void _enable_digit_out(enum omap_channel channel, bool enable)
 {
-	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 1, 1);
+	REG_FLD_MOD(DISPC_CONTROL(channel), enable ? 1 : 0, 1, 1);
 }
 
-static void dispc_enable_digit_out(bool enable)
+static void dispc_enable_digit_out(enum omap_channel channel, bool enable)
 {
 	struct completion frame_done_completion;
 	int r;
 
 	enable_clocks(1);
 
-	if (REG_GET(DISPC_CONTROL, 1, 1) == enable) {
+	if (REG_GET(DISPC_CONTROL(channel), 1, 1) == enable) {
 		enable_clocks(0);
 		return;
 	}
@@ -1815,7 +1863,7 @@ static void dispc_enable_digit_out(bool enable)
 	if (r)
 		DSSERR("failed to register EVSYNC isr\n");
 
-	_enable_digit_out(enable);
+	_enable_digit_out(channel, enable);
 
 	/* XXX I understand from TRM that we should only wait for the
 	 * current field to complete. But it seems we have to wait
@@ -1848,54 +1896,73 @@ static void dispc_enable_digit_out(bool enable)
 
 bool dispc_is_channel_enabled(enum omap_channel channel)
 {
-	if (channel == OMAP_DSS_CHANNEL_LCD)
-		return !!REG_GET(DISPC_CONTROL, 0, 0);
-	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
-		return !!REG_GET(DISPC_CONTROL, 1, 1);
+	int bit = 0;
+
+	if (channel == OMAP_DSS_CHANNEL_DIGIT)
+		bit = 1;
+
+	if (channel == OMAP_DSS_CHANNEL_LCD2 ||
+		channel == OMAP_DSS_CHANNEL_LCD ||
+		channel == OMAP_DSS_CHANNEL_DIGIT)
+		return !!REG_GET(DISPC_CONTROL(channel), bit, bit);
 	else
 		BUG();
 }
 
 void dispc_enable_channel(enum omap_channel channel, bool enable)
 {
-	if (channel == OMAP_DSS_CHANNEL_LCD)
-		dispc_enable_lcd_out(enable);
+	if (channel == OMAP_DSS_CHANNEL_LCD ||
+		channel == OMAP_DSS_CHANNEL_LCD2)
+		dispc_enable_lcd_out(channel, enable);
 	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
-		dispc_enable_digit_out(enable);
+		dispc_enable_digit_out(channel, enable);
 	else
 		BUG();
 }
 
 void dispc_lcd_enable_signal_polarity(bool act_high)
 {
+	if (cpu_is_omap44xx())
+		return;
+
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONTROL, act_high ? 1 : 0, 29, 29);
+	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD),
+		act_high ? 1 : 0, 29, 29);
 	enable_clocks(0);
 }
 
 void dispc_lcd_enable_signal(bool enable)
 {
+	if (cpu_is_omap44xx())
+		return;
+
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 28, 28);
+	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD),
+		enable ? 1 : 0, 28, 28);
 	enable_clocks(0);
 }
 
 void dispc_pck_free_enable(bool enable)
 {
+	if (cpu_is_omap44xx())
+		return;
+
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 27, 27);
+	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD),
+		enable ? 1 : 0, 27, 27);
 	enable_clocks(0);
 }
 
-void dispc_enable_fifohandcheck(bool enable)
+void dispc_enable_fifohandcheck(enum omap_channel channel, bool enable)
 {
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 16, 16);
+	REG_FLD_MOD(DISPC_CONFIG(channel), enable ? 1 : 0, 16, 16);
 	enable_clocks(0);
 }
 
 
-void dispc_set_lcd_display_type(enum omap_lcd_display_type type)
+void dispc_set_lcd_display_type(enum omap_channel channel,
+				enum omap_lcd_display_type type)
 {
 	int mode;
 
@@ -1914,39 +1981,34 @@ void dispc_set_lcd_display_type(enum omap_lcd_display_type type)
 	}
 
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONTROL, mode, 3, 3);
+	REG_FLD_MOD(DISPC_CONTROL(channel), mode, 3, 3);
 	enable_clocks(0);
 }
 
 void dispc_set_loadmode(enum omap_dss_load_mode mode)
 {
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONFIG, mode, 2, 1);
+	REG_FLD_MOD(DISPC_CONFIG(OMAP_DSS_CHANNEL_LCD), mode, 2, 1);
 	enable_clocks(0);
 }
 
-
 void dispc_set_default_color(enum omap_channel channel, u32 color)
 {
-	const struct dispc_reg def_reg[] = { DISPC_DEFAULT_COLOR0,
-				DISPC_DEFAULT_COLOR1 };
-
 	enable_clocks(1);
-	dispc_write_reg(def_reg[channel], color);
+	dispc_write_reg(DISPC_DEFAULT_COLOR(channel), color);
 	enable_clocks(0);
 }
 
 u32 dispc_get_default_color(enum omap_channel channel)
 {
-	const struct dispc_reg def_reg[] = { DISPC_DEFAULT_COLOR0,
-				DISPC_DEFAULT_COLOR1 };
 	u32 l;
 
-	BUG_ON(channel != OMAP_DSS_CHANNEL_DIGIT &&
-	       channel != OMAP_DSS_CHANNEL_LCD);
+	if (!cpu_is_omap44xx())
+		BUG_ON(channel != OMAP_DSS_CHANNEL_DIGIT &&
+			channel != OMAP_DSS_CHANNEL_LCD);
 
 	enable_clocks(1);
-	l = dispc_read_reg(def_reg[channel]);
+	l = dispc_read_reg(DISPC_DEFAULT_COLOR(channel));
 	enable_clocks(0);
 
 	return l;
@@ -1956,16 +2018,14 @@ void dispc_set_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type type,
 		u32 trans_key)
 {
-	const struct dispc_reg tr_reg[] = {
-		DISPC_TRANS_COLOR0, DISPC_TRANS_COLOR1 };
+	int bit = 11;
 
 	enable_clocks(1);
-	if (ch == OMAP_DSS_CHANNEL_LCD)
-		REG_FLD_MOD(DISPC_CONFIG, type, 11, 11);
-	else /* OMAP_DSS_CHANNEL_DIGIT */
-		REG_FLD_MOD(DISPC_CONFIG, type, 13, 13);
+	if (ch == OMAP_DSS_CHANNEL_DIGIT)
+		bit = 13;
 
-	dispc_write_reg(tr_reg[ch], trans_key);
+	REG_FLD_MOD(DISPC_CONFIG(ch), type, bit, bit);
+	dispc_write_reg(DISPC_DEFAULT_COLOR(ch), trans_key);
 	enable_clocks(0);
 }
 
@@ -1973,43 +2033,44 @@ void dispc_get_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type *type,
 		u32 *trans_key)
 {
-	const struct dispc_reg tr_reg[] = {
-		DISPC_TRANS_COLOR0, DISPC_TRANS_COLOR1 };
-
 	enable_clocks(1);
 	if (type) {
-		if (ch == OMAP_DSS_CHANNEL_LCD)
-			*type = REG_GET(DISPC_CONFIG, 11, 11);
-		else if (ch == OMAP_DSS_CHANNEL_DIGIT)
-			*type = REG_GET(DISPC_CONFIG, 13, 13);
-		else
-			BUG();
+		int bit = 11;
+
+		BUG_ON(ch != OMAP_DSS_CHANNEL_LCD &&
+			ch != OMAP_DSS_CHANNEL_LCD2 &&
+			ch != OMAP_DSS_CHANNEL_DIGIT);
+
+		if (ch == OMAP_DSS_CHANNEL_DIGIT)
+			bit = 13;
+		*type = REG_GET(DISPC_CONFIG(ch), bit, bit);
 	}
 
 	if (trans_key)
-		*trans_key = dispc_read_reg(tr_reg[ch]);
+		*trans_key = dispc_read_reg(DISPC_TRANS_COLOR(ch));
 	enable_clocks(0);
 }
 
 void dispc_enable_trans_key(enum omap_channel ch, bool enable)
 {
+	int bit = 10;
 	enable_clocks(1);
-	if (ch == OMAP_DSS_CHANNEL_LCD)
-		REG_FLD_MOD(DISPC_CONFIG, enable, 10, 10);
-	else /* OMAP_DSS_CHANNEL_DIGIT */
-		REG_FLD_MOD(DISPC_CONFIG, enable, 12, 12);
+	if (ch == OMAP_DSS_CHANNEL_DIGIT)
+		bit = 12;
+	REG_FLD_MOD(DISPC_CONFIG(ch), enable, bit, bit);
 	enable_clocks(0);
 }
+
 void dispc_enable_alpha_blending(enum omap_channel ch, bool enable)
 {
+	int bit = 18;
 	if (cpu_is_omap24xx())
 		return;
 
 	enable_clocks(1);
-	if (ch == OMAP_DSS_CHANNEL_LCD)
-		REG_FLD_MOD(DISPC_CONFIG, enable, 18, 18);
-	else /* OMAP_DSS_CHANNEL_DIGIT */
-		REG_FLD_MOD(DISPC_CONFIG, enable, 19, 19);
+	if (ch == OMAP_DSS_CHANNEL_DIGIT)
+		bit = 19;
+	REG_FLD_MOD(DISPC_CONFIG(ch), enable, bit, bit);
 	enable_clocks(0);
 }
 bool dispc_alpha_blending_enabled(enum omap_channel ch)
@@ -2020,10 +2081,8 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
 		return false;
 
 	enable_clocks(1);
-	if (ch == OMAP_DSS_CHANNEL_LCD)
-		enabled = REG_GET(DISPC_CONFIG, 18, 18);
-	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
-		enabled = REG_GET(DISPC_CONFIG, 18, 18);
+	if (ch == OMAP_DSS_CHANNEL_LCD || ch == OMAP_DSS_CHANNEL_DIGIT)
+		enabled = REG_GET(DISPC_CONFIG(ch), 18, 18);
 	else
 		BUG();
 	enable_clocks(0);
@@ -2031,26 +2090,26 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
 	return enabled;
 
 }
-
-
 bool dispc_trans_key_enabled(enum omap_channel ch)
 {
 	bool enabled;
+	int bit = 10;
 
 	enable_clocks(1);
-	if (ch == OMAP_DSS_CHANNEL_LCD)
-		enabled = REG_GET(DISPC_CONFIG, 10, 10);
-	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
-		enabled = REG_GET(DISPC_CONFIG, 12, 12);
-	else
-		BUG();
+	BUG_ON(ch != OMAP_DSS_CHANNEL_LCD &&
+		ch != OMAP_DSS_CHANNEL_LCD2 &&
+		ch != OMAP_DSS_CHANNEL_DIGIT);
+
+	if (ch == OMAP_DSS_CHANNEL_DIGIT)
+		bit = 12;
+	enabled = REG_GET(DISPC_CONFIG(ch), bit, bit);
 	enable_clocks(0);
 
 	return enabled;
 }
 
 
-void dispc_set_tft_data_lines(u8 data_lines)
+void dispc_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
 {
 	int code;
 
@@ -2073,11 +2132,12 @@ void dispc_set_tft_data_lines(u8 data_lines)
 	}
 
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONTROL, code, 9, 8);
+	REG_FLD_MOD(DISPC_CONTROL(channel), code, 9, 8);
 	enable_clocks(0);
 }
 
-void dispc_set_parallel_interface_mode(enum omap_parallel_interface_mode mode)
+void dispc_set_parallel_interface_mode(enum omap_channel channel,
+				enum omap_parallel_interface_mode mode)
 {
 	u32 l;
 	int stallmode;
@@ -2107,13 +2167,15 @@ void dispc_set_parallel_interface_mode(enum omap_parallel_interface_mode mode)
 
 	enable_clocks(1);
 
-	l = dispc_read_reg(DISPC_CONTROL);
-
+	l = dispc_read_reg(DISPC_CONTROL(channel));
 	l = FLD_MOD(l, stallmode, 11, 11);
-	l = FLD_MOD(l, gpout0, 15, 15);
-	l = FLD_MOD(l, gpout1, 16, 16);
 
-	dispc_write_reg(DISPC_CONTROL, l);
+	if (OMAP_DSS_CHANNEL_LCD2 != channel) {
+		l = FLD_MOD(l, gpout0, 15, 15);
+		l = FLD_MOD(l, gpout1, 16, 16);
+	}
+
+	dispc_write_reg(DISPC_CONTROL(channel), l);
 
 	enable_clocks(0);
 }
@@ -2149,8 +2211,8 @@ bool dispc_lcd_timings_ok(struct omap_video_timings *timings)
 			timings->vfp, timings->vbp);
 }
 
-static void _dispc_set_lcd_timings(int hsw, int hfp, int hbp,
-				   int vsw, int vfp, int vbp)
+static void _dispc_set_lcd_timings(enum omap_channel channel, int hsw,
+			int hfp, int hbp, int vsw, int vfp, int vbp)
 {
 	u32 timing_h, timing_v;
 
@@ -2169,13 +2231,14 @@ static void _dispc_set_lcd_timings(int hsw, int hfp, int hbp,
 	}
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_TIMING_H, timing_h);
-	dispc_write_reg(DISPC_TIMING_V, timing_v);
+	dispc_write_reg(DISPC_TIMING_H(channel), timing_h);
+	dispc_write_reg(DISPC_TIMING_V(channel), timing_v);
 	enable_clocks(0);
 }
 
 /* change name to mode? */
-void dispc_set_lcd_timings(struct omap_video_timings *timings)
+void dispc_set_lcd_timings(enum omap_channel channel,
+				struct omap_video_timings *timings)
 {
 	unsigned xtot, ytot;
 	unsigned long ht, vt;
@@ -2185,10 +2248,11 @@ void dispc_set_lcd_timings(struct omap_video_timings *timings)
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
@@ -2196,7 +2260,8 @@ void dispc_set_lcd_timings(struct omap_video_timings *timings)
 	ht = (timings->pixel_clock * 1000) / xtot;
 	vt = (timings->pixel_clock * 1000) / xtot / ytot;
 
-	DSSDBG("xres %u yres %u\n", timings->x_res, timings->y_res);
+	DSSDBG("channel %u xres %u yres %u\n", channel, timings->x_res,
+						timings->y_res);
 	DSSDBG("pck %u\n", timings->pixel_clock);
 	DSSDBG("hsw %d hfp %d hbp %d vsw %d vfp %d vbp %d\n",
 			timings->hsw, timings->hfp, timings->hbp,
@@ -2205,21 +2270,23 @@ void dispc_set_lcd_timings(struct omap_video_timings *timings)
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
+	dispc_write_reg(DISPC_DIVISOR(channel),
 			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
 	enable_clocks(0);
 }
 
-static void dispc_get_lcd_divisor(int *lck_div, int *pck_div)
+static void dispc_get_lcd_divisor(enum omap_channel channel,
+						int *lck_div, int *pck_div)
 {
 	u32 l;
-	l = dispc_read_reg(DISPC_DIVISOR);
+	l = dispc_read_reg(DISPC_DIVISOR(channel));
 	*lck_div = FLD_GET(l, 23, 16);
 	*pck_div = FLD_GET(l, 7, 0);
 }
@@ -2239,13 +2306,12 @@ unsigned long dispc_fclk_rate(void)
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
+	l = dispc_read_reg(DISPC_DIVISOR(channel));
 
 	lcd = FLD_GET(l, 23, 16);
 
@@ -2254,13 +2320,12 @@ unsigned long dispc_lclk_rate(void)
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
+	l = dispc_read_reg(DISPC_DIVISOR(channel));
 
 	lcd = FLD_GET(l, 23, 16);
 	pcd = FLD_GET(l, 7, 0);
@@ -2276,7 +2341,7 @@ void dispc_dump_clocks(struct seq_file *s)
 
 	enable_clocks(1);
 
-	dispc_get_lcd_divisor(&lcd, &pcd);
+	dispc_get_lcd_divisor(OMAP_DSS_CHANNEL_LCD, &lcd, &pcd);
 
 	seq_printf(s, "- DISPC -\n");
 
@@ -2285,8 +2350,26 @@ void dispc_dump_clocks(struct seq_file *s)
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
@@ -2344,23 +2427,41 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_SYSSTATUS);
 	DUMPREG(DISPC_IRQSTATUS);
 	DUMPREG(DISPC_IRQENABLE);
-	DUMPREG(DISPC_CONTROL);
-	DUMPREG(DISPC_CONFIG);
+	DUMPREG(DISPC_CONTROL(0));
+	DUMPREG(DISPC_CONFIG(0));
 	DUMPREG(DISPC_CAPABLE);
-	DUMPREG(DISPC_DEFAULT_COLOR0);
-	DUMPREG(DISPC_DEFAULT_COLOR1);
-	DUMPREG(DISPC_TRANS_COLOR0);
-	DUMPREG(DISPC_TRANS_COLOR1);
+	DUMPREG(DISPC_DEFAULT_COLOR(0));
+	DUMPREG(DISPC_DEFAULT_COLOR(1));
+	DUMPREG(DISPC_TRANS_COLOR(0));
+	DUMPREG(DISPC_TRANS_COLOR(1));
 	DUMPREG(DISPC_LINE_STATUS);
 	DUMPREG(DISPC_LINE_NUMBER);
-	DUMPREG(DISPC_TIMING_H);
-	DUMPREG(DISPC_TIMING_V);
-	DUMPREG(DISPC_POL_FREQ);
-	DUMPREG(DISPC_DIVISOR);
+	DUMPREG(DISPC_TIMING_H(0));
+	DUMPREG(DISPC_TIMING_V(0));
+	DUMPREG(DISPC_POL_FREQ(0));
+	DUMPREG(DISPC_DIVISOR(0));
 	DUMPREG(DISPC_GLOBAL_ALPHA);
 	DUMPREG(DISPC_SIZE_DIG);
-	DUMPREG(DISPC_SIZE_LCD);
-
+	DUMPREG(DISPC_SIZE_LCD(0));
+
+	/* OMAP4 LCD2 channel registers*/
+	if (cpu_is_omap44xx()) {
+		DUMPREG(DISPC_CONTROL(2));
+		DUMPREG(DISPC_DEFAULT_COLOR(2));
+		DUMPREG(DISPC_TRANS_COLOR(2));
+		DUMPREG(DISPC_CPR_COEF_B(2));
+		DUMPREG(DISPC_CPR_COEF_G(2));
+		DUMPREG(DISPC_CPR_COEF_R(2));
+		DUMPREG(DISPC_DATA_CYCLE1(2));
+		DUMPREG(DISPC_DATA_CYCLE2(2));
+		DUMPREG(DISPC_DATA_CYCLE3(2));
+		DUMPREG(DISPC_SIZE_LCD(2));
+		DUMPREG(DISPC_TIMING_H(2));
+		DUMPREG(DISPC_TIMING_V(2));
+		DUMPREG(DISPC_POL_FREQ(2));
+		DUMPREG(DISPC_DIVISOR(2));
+		DUMPREG(DISPC_CONFIG(2));
+	}
 	DUMPREG(DISPC_GFX_BA0);
 	DUMPREG(DISPC_GFX_BA1);
 	DUMPREG(DISPC_GFX_POSITION);
@@ -2373,13 +2474,13 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_GFX_WINDOW_SKIP);
 	DUMPREG(DISPC_GFX_TABLE_BA);
 
-	DUMPREG(DISPC_DATA_CYCLE1);
-	DUMPREG(DISPC_DATA_CYCLE2);
-	DUMPREG(DISPC_DATA_CYCLE3);
+	DUMPREG(DISPC_DATA_CYCLE1(0));
+	DUMPREG(DISPC_DATA_CYCLE2(0));
+	DUMPREG(DISPC_DATA_CYCLE3(0));
 
-	DUMPREG(DISPC_CPR_COEF_R);
-	DUMPREG(DISPC_CPR_COEF_G);
-	DUMPREG(DISPC_CPR_COEF_B);
+	DUMPREG(DISPC_CPR_COEF_R(0));
+	DUMPREG(DISPC_CPR_COEF_G(0));
+	DUMPREG(DISPC_CPR_COEF_B(0));
 
 	DUMPREG(DISPC_GFX_PRELOAD);
 
@@ -2478,8 +2579,9 @@ void dispc_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-static void _dispc_set_pol_freq(bool onoff, bool rf, bool ieo, bool ipc,
-				bool ihs, bool ivs, u8 acbi, u8 acb)
+static void _dispc_set_pol_freq(enum omap_channel channel, bool onoff, bool rf,
+				bool ieo, bool ipc, bool ihs, bool ivs,
+				u8 acbi, u8 acb)
 {
 	u32 l = 0;
 
@@ -2496,13 +2598,14 @@ static void _dispc_set_pol_freq(bool onoff, bool rf, bool ieo, bool ipc,
 	l |= FLD_VAL(acb, 7, 0);
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_POL_FREQ, l);
+	dispc_write_reg(DISPC_POL_FREQ(channel), l);
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
@@ -2571,24 +2674,27 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
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
 
-	cinfo->lck_div = REG_GET(DISPC_DIVISOR, 23, 16);
-	cinfo->pck_div = REG_GET(DISPC_DIVISOR, 7, 0);
+	cinfo->lck_div = REG_GET(DISPC_DIVISOR(channel), 23, 16);
+	cinfo->pck_div = REG_GET(DISPC_DIVISOR(channel), 7, 0);
 
 	cinfo->lck = fck / cinfo->lck_div;
 	cinfo->pck = cinfo->lck / cinfo->pck_div;
@@ -3085,7 +3191,7 @@ static void _omap_dispc_initial_config(void)
 	dispc_write_reg(DISPC_SYSCONFIG, l);
 
 	/* FUNCGATED */
-	REG_FLD_MOD(DISPC_CONFIG, 1, 9, 9);
+		REG_FLD_MOD(DISPC_CONFIG(OMAP_DSS_CHANNEL_LCD), 1, 9, 9);
 
 	/* L3 firewall setting: enable access to OCM RAM */
 	/* XXX this should be somewhere in plat-omap */
@@ -3159,17 +3265,18 @@ int dispc_setup_plane(enum omap_plane plane,
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
 
@@ -3181,7 +3288,8 @@ int dispc_setup_plane(enum omap_plane plane,
 			   color_mode, ilace,
 			   rotation_type,
 			   rotation, mirror,
-			   global_alpha);
+			   global_alpha,
+			   channel);
 
 	enable_clocks(0);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 5c7940d..f7449d0
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -333,9 +333,9 @@ void dispc_disable_sidle(void);
 void dispc_lcd_enable_signal_polarity(bool act_high);
 void dispc_lcd_enable_signal(bool enable);
 void dispc_pck_free_enable(bool enable);
-void dispc_enable_fifohandcheck(bool enable);
+void dispc_enable_fifohandcheck(enum omap_channel channel, bool enable);
 
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

