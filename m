From: Archit Taneja <archit@ti.com>
Subject: [RFC v3][PATCH 2/4] OMAP: DSS2: Incorporate Secondary LCD Channel DISPC Registers
Date: Tue,  5 Oct 2010 17:25:22 +0530
Message-ID: <1286279724-11692-3-git-send-email-archit@ti.com>
References: <1286279724-11692-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38804 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960Ab0JELzE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 07:55:04 -0400
In-Reply-To: <1286279724-11692-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Mukund Mittal <mmittal@ti.com>, Archit Taneja <archit@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Introduce LCD2 manager and corresponding irq's in display.h. Introduce OMAP4
DISPC Secondary LCD Channel registers and the new enum channel as a parameter
in all dispc functions used by interface drivers(dsi, sdi etc) in order to
differentiate between the 2 channels.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    7 +
 drivers/video/omap2/dss/dispc.c           |  617 +++++++++++++++++++----------
 drivers/video/omap2/dss/dss.h             |   29 +-
 3 files changed, 433 insertions(+), 220 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index c915a66..0acc8c4 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -42,6 +42,10 @@
 #define DISPC_IRQ_SYNC_LOST		(1 << 14)
 #define DISPC_IRQ_SYNC_LOST_DIGIT	(1 << 15)
 #define DISPC_IRQ_WAKEUP		(1 << 16)
+#define DISPC_IRQ_SYNC_LOST_2		(1 << 17)
+#define DISPC_IRQ_VSYNC2		(1 << 18)
+#define DISPC_IRQ_ACBIAS_COUNT_STAT2	(1 << 21)
+#define DISPC_IRQ_FRAMEDONE2		(1 << 22)
 
 struct omap_dss_device;
 struct omap_overlay_manager;
@@ -64,6 +68,7 @@ enum omap_plane {
 enum omap_channel {
 	OMAP_DSS_CHANNEL_LCD	= 0,
 	OMAP_DSS_CHANNEL_DIGIT	= 1,
+	OMAP_DSS_CHANNEL_LCD2   = 2,
 };
 
 enum omap_color_mode {
@@ -142,6 +147,7 @@ enum omap_dss_display_state {
 enum omap_dss_overlay_managers {
 	OMAP_DSS_OVL_MGR_LCD,
 	OMAP_DSS_OVL_MGR_TV,
+	OMAP_DSS_OVL_MGR_LCD2,
 };
 
 enum omap_dss_rotation_type {
@@ -431,6 +437,7 @@ struct omap_dss_device {
 	struct omap_overlay_manager *manager;
 
 	enum omap_dss_display_state state;
+	enum omap_channel channel;
 
 	/* platform specific  */
 	int (*platform_enable)(struct omap_dss_device *dssdev);
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index fa40fa5..149ea5f 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -44,7 +44,7 @@
 /* DISPC */
 #define DISPC_BASE			0x48050400
 
-#define DISPC_SZ_REGS			SZ_1K
+#define DISPC_SZ_REGS			SZ_4K
 
 struct dispc_reg { u16 idx; };
 
@@ -56,22 +56,31 @@ struct dispc_reg { u16 idx; };
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
@@ -86,13 +95,19 @@ struct dispc_reg { u16 idx; };
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
 
@@ -215,21 +230,32 @@ void dispc_save_context(void)
 
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
-
+	SR(SIZE_LCD(0));
+
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		SR(CONTROL(2));
+		SR(DEFAULT_COLOR(2));
+		SR(TRANS_COLOR(2));
+		SR(SIZE_LCD(2));
+		SR(TIMING_H(2));
+		SR(TIMING_V(2));
+		SR(POL_FREQ(2));
+		SR(DIVISOR(2));
+		SR(CONFIG(2));
+	}
 	SR(GFX_BA0);
 	SR(GFX_BA1);
 	SR(GFX_POSITION);
@@ -241,14 +267,23 @@ void dispc_save_context(void)
 	SR(GFX_WINDOW_SKIP);
 	SR(GFX_TABLE_BA);
 
-	SR(DATA_CYCLE1);
-	SR(DATA_CYCLE2);
-	SR(DATA_CYCLE3);
+	SR(DATA_CYCLE1(0));
+	SR(DATA_CYCLE2(0));
+	SR(DATA_CYCLE3(0));
+
+	SR(CPR_COEF_R(0));
+	SR(CPR_COEF_G(0));
+	SR(CPR_COEF_B(0));
 
-	SR(CPR_COEF_R);
-	SR(CPR_COEF_G);
-	SR(CPR_COEF_B);
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		SR(CPR_COEF_B(2));
+		SR(CPR_COEF_G(2));
+		SR(CPR_COEF_R(2));
 
+		SR(DATA_CYCLE1(2));
+		SR(DATA_CYCLE2(2));
+		SR(DATA_CYCLE3(2));
+	}
 	SR(GFX_PRELOAD);
 
 	/* VID1 */
@@ -355,20 +390,30 @@ void dispc_restore_context(void)
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
-
+	RR(SIZE_LCD(0));
+
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		RR(DEFAULT_COLOR(2));
+		RR(TRANS_COLOR(2));
+		RR(SIZE_LCD(2));
+		RR(TIMING_H(2));
+		RR(TIMING_V(2));
+		RR(POL_FREQ(2));
+		RR(DIVISOR(2));
+		RR(CONFIG(2));
+	}
 	RR(GFX_BA0);
 	RR(GFX_BA1);
 	RR(GFX_POSITION);
@@ -380,14 +425,23 @@ void dispc_restore_context(void)
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
 
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		RR(DATA_CYCLE1(2));
+		RR(DATA_CYCLE2(2));
+		RR(DATA_CYCLE3(2));
+
+		RR(CPR_COEF_B(2));
+		RR(CPR_COEF_G(2));
+		RR(CPR_COEF_R(2));
+	}
 	RR(GFX_PRELOAD);
 
 	/* VID1 */
@@ -489,7 +543,9 @@ void dispc_restore_context(void)
 	RR(VID_PRELOAD(1));
 
 	/* enable last, because LCD & DIGIT enable are here */
-	RR(CONTROL);
+	RR(CONTROL(0));
+	if (dss_has_feature(FEAT_MGR_LCD2))
+		RR(CONTROL(2));
 
 	/* clear spurious SYNC_LOST_DIGIT interrupts */
 	dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
@@ -516,12 +572,13 @@ bool dispc_go_busy(enum omap_channel channel)
 {
 	int bit;
 
-	if (channel == OMAP_DSS_CHANNEL_LCD)
+	if (channel == OMAP_DSS_CHANNEL_LCD ||
+			channel == OMAP_DSS_CHANNEL_LCD2)
 		bit = 5; /* GOLCD */
 	else
 		bit = 6; /* GODIGIT */
 
-	return REG_GET(DISPC_CONTROL, bit, bit) == 1;
+	return REG_GET(DISPC_CONTROL(channel), bit, bit) == 1;
 }
 
 void dispc_go(enum omap_channel channel)
@@ -530,28 +587,32 @@ void dispc_go(enum omap_channel channel)
 
 	enable_clocks(1);
 
-	if (channel == OMAP_DSS_CHANNEL_LCD)
+	if (channel == OMAP_DSS_CHANNEL_LCD ||
+			channel == OMAP_DSS_CHANNEL_LCD2)
 		bit = 0; /* LCDENABLE */
 	else
 		bit = 1; /* DIGITALENABLE */
 
 	/* if the channel is not enabled, we don't need GO */
-	if (REG_GET(DISPC_CONTROL, bit, bit) == 0)
+	if (REG_GET(DISPC_CONTROL(channel), bit, bit) == 0)
 		goto end;
 
-	if (channel == OMAP_DSS_CHANNEL_LCD)
+	if (channel == OMAP_DSS_CHANNEL_LCD ||
+			channel == OMAP_DSS_CHANNEL_LCD2)
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
@@ -851,6 +912,7 @@ static void _dispc_set_channel_out(enum omap_plane plane,
 {
 	int shift;
 	u32 val;
+	int chan = 0, chan2 = 0;
 
 	switch (plane) {
 	case OMAP_DSS_GFX:
@@ -866,7 +928,30 @@ static void _dispc_set_channel_out(enum omap_plane plane,
 	}
 
 	val = dispc_read_reg(dispc_reg_att[plane]);
-	val = FLD_MOD(val, channel, shift, shift);
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
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
 
@@ -923,13 +1008,13 @@ void dispc_enable_replication(enum omap_plane plane, bool enable)
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
 
@@ -999,7 +1084,7 @@ void dispc_enable_fifomerge(bool enable)
 	enable_clocks(1);
 
 	DSSDBG("FIFO merge %s\n", enable ? "enabled" : "disabled");
-	REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 14, 14);
+	REG_FLD_MOD(DISPC_CONFIG(OMAP_DSS_CHANNEL_LCD), enable ? 1 : 0, 14, 14);
 
 	enable_clocks(0);
 }
@@ -1426,12 +1511,13 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
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
@@ -1463,8 +1549,8 @@ static unsigned long calc_fclk_five_taps(u16 width, u16 height,
 	return fclk;
 }
 
-static unsigned long calc_fclk(u16 width, u16 height,
-		u16 out_width, u16 out_height)
+static unsigned long calc_fclk(enum omap_channel channel, u16 width,
+			u16 height, u16 out_width, u16 out_height)
 {
 	unsigned int hf, vf;
 
@@ -1488,7 +1574,7 @@ static unsigned long calc_fclk(u16 width, u16 height,
 		vf = 1;
 
 	/* FIXME venc pclk? */
-	return dispc_pclk_rate() * vf * hf;
+	return dispc_pclk_rate(channel) * vf * hf;
 }
 
 void dispc_set_channel_out(enum omap_plane plane, enum omap_channel channel_out)
@@ -1606,7 +1692,7 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		five_taps = height > out_height * 2;
 
 		if (!five_taps) {
-			fclk = calc_fclk(width, height,
+			fclk = calc_fclk(OMAP_DSS_CHANNEL_LCD, width, height,
 					out_width, out_height);
 
 			/* Try 5-tap filter if 3-tap fclk is too high */
@@ -1621,8 +1707,9 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		}
 
 		if (five_taps)
-			fclk = calc_fclk_five_taps(width, height,
-					out_width, out_height, color_mode);
+			fclk = calc_fclk_five_taps(OMAP_DSS_CHANNEL_LCD,
+					width, height, out_width, out_height,
+					color_mode);
 
 		DSSDBG("required fclk rate = %lu Hz\n", fclk);
 		DSSDBG("current fclk rate = %lu Hz\n", dispc_fclk_rate());
@@ -1710,36 +1797,43 @@ static void dispc_disable_isr(void *data, u32 mask)
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
 	int r;
+	u32 irq;
 
 	enable_clocks(1);
 
 	/* When we disable LCD output, we need to wait until frame is done.
 	 * Otherwise the DSS is still working, and turning off the clocks
 	 * prevents DSS from going to OFF mode */
-	is_on = REG_GET(DISPC_CONTROL, 0, 0);
+	is_on = REG_GET(DISPC_CONTROL(channel), 0, 0);
+
+	if (OMAP_DSS_CHANNEL_LCD2 == channel)
+		irq = DISPC_IRQ_FRAMEDONE2;
+	else
+		irq = DISPC_IRQ_FRAMEDONE;
 
 	if (!enable && is_on) {
 		init_completion(&frame_done_completion);
 
 		r = omap_dispc_register_isr(dispc_disable_isr,
 				&frame_done_completion,
-				DISPC_IRQ_FRAMEDONE);
+				irq);
 
 		if (r)
 			DSSERR("failed to register FRAMEDONE isr\n");
 	}
 
-	_enable_lcd_out(enable);
+	_enable_lcd_out(channel, enable);
 
 	if (!enable && is_on) {
 		if (!wait_for_completion_timeout(&frame_done_completion,
@@ -1748,7 +1842,7 @@ static void dispc_enable_lcd_out(bool enable)
 
 		r = omap_dispc_unregister_isr(dispc_disable_isr,
 				&frame_done_completion,
-				DISPC_IRQ_FRAMEDONE);
+				irq);
 
 		if (r)
 			DSSERR("failed to unregister FRAMEDONE isr\n");
@@ -1757,19 +1851,19 @@ static void dispc_enable_lcd_out(bool enable)
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
@@ -1795,7 +1889,7 @@ static void dispc_enable_digit_out(bool enable)
 	if (r)
 		DSSERR("failed to register EVSYNC isr\n");
 
-	_enable_digit_out(enable);
+	_enable_digit_out(channel, enable);
 
 	/* XXX I understand from TRM that we should only wait for the
 	 * current field to complete. But it seems we have to wait
@@ -1818,6 +1912,8 @@ static void dispc_enable_digit_out(bool enable)
 		unsigned long flags;
 		spin_lock_irqsave(&dispc.irq_lock, flags);
 		dispc.irq_error_mask = DISPC_IRQ_MASK_ERROR;
+		if (dss_has_feature(FEAT_MGR_LCD2))
+			dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST_2;
 		dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
 		_omap_dispc_set_irqs();
 		spin_unlock_irqrestore(&dispc.irq_lock, flags);
@@ -1828,54 +1924,73 @@ static void dispc_enable_digit_out(bool enable)
 
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
+	if (!dss_has_feature(FEAT_LCDENABLEPOL))
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
+	if (!dss_has_feature(FEAT_LCDENABLESIGNAL))
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
+	if (!dss_has_feature(FEAT_PCKFREEENABLE))
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
 
@@ -1894,39 +2009,34 @@ void dispc_set_lcd_display_type(enum omap_lcd_display_type type)
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
 
 	BUG_ON(channel != OMAP_DSS_CHANNEL_DIGIT &&
-	       channel != OMAP_DSS_CHANNEL_LCD);
+		channel != OMAP_DSS_CHANNEL_LCD &&
+		channel != OMAP_DSS_CHANNEL_LCD2);
 
 	enable_clocks(1);
-	l = dispc_read_reg(def_reg[channel]);
+	l = dispc_read_reg(DISPC_DEFAULT_COLOR(channel));
 	enable_clocks(0);
 
 	return l;
@@ -1936,16 +2046,14 @@ void dispc_set_trans_key(enum omap_channel ch,
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
 
@@ -1953,43 +2061,42 @@ void dispc_get_trans_key(enum omap_channel ch,
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
-	}
+		int bit = 11;
+
+		BUG_ON(ch != OMAP_DSS_CHANNEL_LCD &&
+			ch != OMAP_DSS_CHANNEL_LCD2 &&
+			ch != OMAP_DSS_CHANNEL_DIGIT);
 
+		if (ch == OMAP_DSS_CHANNEL_DIGIT)
+			bit = 13;
+	}
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
 void dispc_enable_alpha_blending(enum omap_channel ch, bool enable)
 {
+	int bit = 18;
+
 	if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
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
@@ -2000,10 +2107,8 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
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
@@ -2011,26 +2116,26 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
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
 
@@ -2053,11 +2158,12 @@ void dispc_set_tft_data_lines(u8 data_lines)
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
@@ -2087,13 +2193,15 @@ void dispc_set_parallel_interface_mode(enum omap_parallel_interface_mode mode)
 
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
@@ -2129,8 +2237,8 @@ bool dispc_lcd_timings_ok(struct omap_video_timings *timings)
 			timings->vfp, timings->vbp);
 }
 
-static void _dispc_set_lcd_timings(int hsw, int hfp, int hbp,
-				   int vsw, int vfp, int vbp)
+static void _dispc_set_lcd_timings(enum omap_channel channel, int hsw,
+			int hfp, int hbp, int vsw, int vfp, int vbp)
 {
 	u32 timing_h, timing_v;
 
@@ -2149,13 +2257,14 @@ static void _dispc_set_lcd_timings(int hsw, int hfp, int hbp,
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
@@ -2165,10 +2274,11 @@ void dispc_set_lcd_timings(struct omap_video_timings *timings)
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
@@ -2176,7 +2286,8 @@ void dispc_set_lcd_timings(struct omap_video_timings *timings)
 	ht = (timings->pixel_clock * 1000) / xtot;
 	vt = (timings->pixel_clock * 1000) / xtot / ytot;
 
-	DSSDBG("xres %u yres %u\n", timings->x_res, timings->y_res);
+	DSSDBG("channel %u xres %u yres %u\n", channel, timings->x_res,
+						timings->y_res);
 	DSSDBG("pck %u\n", timings->pixel_clock);
 	DSSDBG("hsw %d hfp %d hbp %d vsw %d vfp %d vbp %d\n",
 			timings->hsw, timings->hfp, timings->hbp,
@@ -2185,21 +2296,23 @@ void dispc_set_lcd_timings(struct omap_video_timings *timings)
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
@@ -2219,13 +2332,12 @@ unsigned long dispc_fclk_rate(void)
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
 
@@ -2234,13 +2346,12 @@ unsigned long dispc_lclk_rate(void)
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
@@ -2256,7 +2367,7 @@ void dispc_dump_clocks(struct seq_file *s)
 
 	enable_clocks(1);
 
-	dispc_get_lcd_divisor(&lcd, &pcd);
+	dispc_get_lcd_divisor(OMAP_DSS_CHANNEL_LCD, &lcd, &pcd);
 
 	seq_printf(s, "- DISPC -\n");
 
@@ -2265,8 +2376,26 @@ void dispc_dump_clocks(struct seq_file *s)
 			"dss1_alwon_fclk" : "dsi1_pll_fclk");
 
 	seq_printf(s, "fck\t\t%-16lu\n", dispc_fclk_rate());
-	seq_printf(s, "lck\t\t%-16lulck div\t%u\n", dispc_lclk_rate(), lcd);
-	seq_printf(s, "pck\t\t%-16lupck div\t%u\n", dispc_pclk_rate(), pcd);
+	seq_printf(s, "lck\t\t%-16lulck div\t%u\n",
+			dispc_lclk_rate(OMAP_DSS_CHANNEL_LCD), lcd);
+	seq_printf(s, "pck\t\t%-16lupck div\t%u\n",
+			dispc_pclk_rate(OMAP_DSS_CHANNEL_LCD), pcd);
+
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
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
@@ -2309,6 +2438,12 @@ void dispc_dump_irqs(struct seq_file *s)
 	PIS(SYNC_LOST);
 	PIS(SYNC_LOST_DIGIT);
 	PIS(WAKEUP);
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		PIS(FRAMEDONE2);
+		PIS(VSYNC2);
+		PIS(ACBIAS_COUNT_STAT2);
+		PIS(SYNC_LOST_2);
+	}
 #undef PIS
 }
 #endif
@@ -2324,23 +2459,41 @@ void dispc_dump_regs(struct seq_file *s)
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
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
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
@@ -2353,13 +2506,13 @@ void dispc_dump_regs(struct seq_file *s)
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
 
@@ -2458,8 +2611,9 @@ void dispc_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-static void _dispc_set_pol_freq(bool onoff, bool rf, bool ieo, bool ipc,
-				bool ihs, bool ivs, u8 acbi, u8 acb)
+static void _dispc_set_pol_freq(enum omap_channel channel, bool onoff, bool rf,
+				bool ieo, bool ipc, bool ihs, bool ivs,
+				u8 acbi, u8 acb)
 {
 	u32 l = 0;
 
@@ -2476,13 +2630,14 @@ static void _dispc_set_pol_freq(bool onoff, bool rf, bool ieo, bool ipc,
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
@@ -2551,24 +2706,27 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
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
@@ -2926,6 +3084,45 @@ static void dispc_error_worker(struct work_struct *work)
 		}
 	}
 
+	if (errors & DISPC_IRQ_SYNC_LOST_2) {
+		struct omap_overlay_manager *manager = NULL;
+		bool enable = false;
+
+		DSSERR("SYNC_LOST for LCD2, disabling LCD2\n");
+
+		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
+			struct omap_overlay_manager *mgr;
+			mgr = omap_dss_get_overlay_manager(i);
+
+			if (mgr->id == OMAP_DSS_CHANNEL_LCD2) {
+				manager = mgr;
+				enable = mgr->device->state ==
+						OMAP_DSS_DISPLAY_ACTIVE;
+				mgr->device->driver->disable(mgr->device);
+				break;
+			}
+		}
+
+		if (manager) {
+			struct omap_dss_device *dssdev = manager->device;
+			for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+				struct omap_overlay *ovl;
+				ovl = omap_dss_get_overlay(i);
+
+				if (!(ovl->caps & OMAP_DSS_OVL_CAP_DISPC))
+					continue;
+
+				if (ovl->id != 0 && ovl->manager == manager)
+					dispc_enable_plane(ovl->id, 0);
+			}
+
+			dispc_go(manager->id);
+			mdelay(50);
+			if (enable)
+				dssdev->driver->enable(dssdev);
+		}
+	}
+
 	if (errors & DISPC_IRQ_OCP_ERR) {
 		DSSERR("OCP_ERR\n");
 		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
@@ -3033,6 +3230,8 @@ static void _omap_dispc_initialize_irq(void)
 	memset(dispc.registered_isr, 0, sizeof(dispc.registered_isr));
 
 	dispc.irq_error_mask = DISPC_IRQ_MASK_ERROR;
+	if (dss_has_feature(FEAT_MGR_LCD2))
+		dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST_2;
 
 	/* there's SYNC_LOST_DIGIT waiting after enabling the DSS,
 	 * so clear it */
@@ -3065,7 +3264,7 @@ static void _omap_dispc_initial_config(void)
 	dispc_write_reg(DISPC_SYSCONFIG, l);
 
 	/* FUNCGATED */
-	REG_FLD_MOD(DISPC_CONFIG, 1, 9, 9);
+	REG_FLD_MOD(DISPC_CONFIG(OMAP_DSS_CHANNEL_LCD), 1, 9, 9);
 
 	/* L3 firewall setting: enable access to OCM RAM */
 	/* XXX this should be somewhere in plat-omap */
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 5c7940d..62b3ead 100644
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
1.7.0.4

