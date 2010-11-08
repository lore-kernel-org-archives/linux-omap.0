From: Archit Taneja <archit@ti.com>
Subject: [PATCH v4 2/7] OMAP: DSS2: Represent DISPC register defines with channel as parameter
Date: Mon,  8 Nov 2010 17:54:20 +0530
Message-ID: <1289219065-1362-3-git-send-email-archit@ti.com>
References: <1289219065-1362-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39848 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab0KHMXi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Nov 2010 07:23:38 -0500
In-Reply-To: <1289219065-1362-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Mukund Mittal <mmittal@ti.com>, Samreen <samreen@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Introduce new enum members for LCD2 Channel and corresponding Overlay Manager.

Represent some of the DISPC register defines with channel as a parameter
to differentiate between LCD, DIGIT and LCD2 channels. Replace the existing
reads/writes to these registers in this new way.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    2 +
 drivers/video/omap2/dss/dispc.c           |  255 ++++++++++++++---------------
 2 files changed, 128 insertions(+), 129 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index d433baf..586944d 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -64,6 +64,7 @@ enum omap_plane {
 enum omap_channel {
 	OMAP_DSS_CHANNEL_LCD	= 0,
 	OMAP_DSS_CHANNEL_DIGIT	= 1,
+	OMAP_DSS_CHANNEL_LCD2	= 2,
 };
 
 enum omap_color_mode {
@@ -142,6 +143,7 @@ enum omap_dss_display_state {
 enum omap_dss_overlay_managers {
 	OMAP_DSS_OVL_MGR_LCD,
 	OMAP_DSS_OVL_MGR_TV,
+	OMAP_DSS_OVL_MGR_LCD2,
 };
 
 enum omap_dss_rotation_type {
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 54ba8d3..493e0f9 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -44,34 +44,38 @@
 /* DISPC */
 #define DISPC_BASE			0x48050400
 
-#define DISPC_SZ_REGS			SZ_1K
+#define DISPC_SZ_REGS			SZ_4K
 
 struct dispc_reg { u16 idx; };
 
 #define DISPC_REG(idx)			((const struct dispc_reg) { idx })
 
-/* DISPC common */
+/*
+ * DISPC common registers and
+ * DISPC channel registers , ch = 0 for LCD, ch = 1 for
+ * DIGIT, and ch = 2 for LCD2
+ */
 #define DISPC_REVISION			DISPC_REG(0x0000)
 #define DISPC_SYSCONFIG			DISPC_REG(0x0010)
 #define DISPC_SYSSTATUS			DISPC_REG(0x0014)
 #define DISPC_IRQSTATUS			DISPC_REG(0x0018)
 #define DISPC_IRQENABLE			DISPC_REG(0x001C)
-#define DISPC_CONTROL			DISPC_REG(0x0040)
-#define DISPC_CONFIG			DISPC_REG(0x0044)
+#define DISPC_CONTROL(ch)		DISPC_REG(ch != 2 ? 0x0040 : 0x0238)
+#define DISPC_CONFIG(ch)		DISPC_REG(ch != 2 ? 0x0044 : 0x0620)
 #define DISPC_CAPABLE			DISPC_REG(0x0048)
-#define DISPC_DEFAULT_COLOR0		DISPC_REG(0x004C)
-#define DISPC_DEFAULT_COLOR1		DISPC_REG(0x0050)
-#define DISPC_TRANS_COLOR0		DISPC_REG(0x0054)
-#define DISPC_TRANS_COLOR1		DISPC_REG(0x0058)
+#define DISPC_DEFAULT_COLOR(ch)		DISPC_REG(ch == 0 ? 0x004C : \
+					(ch == 1 ? 0x0050 : 0x03AC))
+#define DISPC_TRANS_COLOR(ch)		DISPC_REG(ch == 0 ? 0x0054 : \
+					(ch == 1 ? 0x0058 : 0x03B0))
 #define DISPC_LINE_STATUS		DISPC_REG(0x005C)
 #define DISPC_LINE_NUMBER		DISPC_REG(0x0060)
-#define DISPC_TIMING_H			DISPC_REG(0x0064)
-#define DISPC_TIMING_V			DISPC_REG(0x0068)
-#define DISPC_POL_FREQ			DISPC_REG(0x006C)
-#define DISPC_DIVISOR			DISPC_REG(0x0070)
+#define DISPC_TIMING_H(ch)		DISPC_REG(ch != 2 ? 0x0064 : 0x0400)
+#define DISPC_TIMING_V(ch)		DISPC_REG(ch != 2 ? 0x0068 : 0x0404)
+#define DISPC_POL_FREQ(ch)		DISPC_REG(ch != 2 ? 0x006C : 0x0408)
+#define DISPC_DIVISOR(ch)		DISPC_REG(ch != 2 ? 0x0070 : 0x040C)
 #define DISPC_GLOBAL_ALPHA		DISPC_REG(0x0074)
 #define DISPC_SIZE_DIG			DISPC_REG(0x0078)
-#define DISPC_SIZE_LCD			DISPC_REG(0x007C)
+#define DISPC_SIZE_LCD(ch)		DISPC_REG(ch != 2 ? 0x007C : 0x03CC)
 
 /* DISPC GFX plane */
 #define DISPC_GFX_BA0			DISPC_REG(0x0080)
@@ -86,13 +90,12 @@ struct dispc_reg { u16 idx; };
 #define DISPC_GFX_WINDOW_SKIP		DISPC_REG(0x00B4)
 #define DISPC_GFX_TABLE_BA		DISPC_REG(0x00B8)
 
-#define DISPC_DATA_CYCLE1		DISPC_REG(0x01D4)
-#define DISPC_DATA_CYCLE2		DISPC_REG(0x01D8)
-#define DISPC_DATA_CYCLE3		DISPC_REG(0x01DC)
-
-#define DISPC_CPR_COEF_R		DISPC_REG(0x0220)
-#define DISPC_CPR_COEF_G		DISPC_REG(0x0224)
-#define DISPC_CPR_COEF_B		DISPC_REG(0x0228)
+#define DISPC_DATA_CYCLE1(ch)	DISPC_REG(ch != 2 ? 0x01D4 : 0x03C0)
+#define DISPC_DATA_CYCLE2(ch)	DISPC_REG(ch != 2 ? 0x01D8 : 0x03C4)
+#define DISPC_DATA_CYCLE3(ch)	DISPC_REG(ch != 2 ? 0x01DC : 0x03C8)
+#define DISPC_CPR_COEF_R(ch)	DISPC_REG(ch != 2 ? 0x0220 : 0x03BC)
+#define DISPC_CPR_COEF_G(ch)	DISPC_REG(ch != 2 ? 0x0224 : 0x03B8)
+#define DISPC_CPR_COEF_B(ch)	DISPC_REG(ch != 2 ? 0x0228 : 0x03B4)
 
 #define DISPC_GFX_PRELOAD		DISPC_REG(0x022C)
 
@@ -215,20 +218,20 @@ void dispc_save_context(void)
 
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
@@ -241,13 +244,13 @@ void dispc_save_context(void)
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
 
@@ -355,19 +358,19 @@ void dispc_restore_context(void)
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
@@ -380,13 +383,13 @@ void dispc_restore_context(void)
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
 
@@ -489,7 +492,7 @@ void dispc_restore_context(void)
 	RR(VID_PRELOAD(1));
 
 	/* enable last, because LCD & DIGIT enable are here */
-	RR(CONTROL);
+	RR(CONTROL(0));
 
 	/* clear spurious SYNC_LOST_DIGIT interrupts */
 	dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
@@ -521,7 +524,7 @@ bool dispc_go_busy(enum omap_channel channel)
 	else
 		bit = 6; /* GODIGIT */
 
-	return REG_GET(DISPC_CONTROL, bit, bit) == 1;
+	return REG_GET(DISPC_CONTROL(channel), bit, bit) == 1;
 }
 
 void dispc_go(enum omap_channel channel)
@@ -536,7 +539,7 @@ void dispc_go(enum omap_channel channel)
 		bit = 1; /* DIGITALENABLE */
 
 	/* if the channel is not enabled, we don't need GO */
-	if (REG_GET(DISPC_CONTROL, bit, bit) == 0)
+	if (REG_GET(DISPC_CONTROL(channel), bit, bit) == 0)
 		goto end;
 
 	if (channel == OMAP_DSS_CHANNEL_LCD)
@@ -544,14 +547,14 @@ void dispc_go(enum omap_channel channel)
 	else
 		bit = 6; /* GODIGIT */
 
-	if (REG_GET(DISPC_CONTROL, bit, bit) == 1) {
+	if (REG_GET(DISPC_CONTROL(channel), bit, bit) == 1) {
 		DSSERR("GO bit not down for channel %d\n", channel);
 		goto end;
 	}
 
 	DSSDBG("GO %s\n", channel == OMAP_DSS_CHANNEL_LCD ? "LCD" : "DIGIT");
 
-	REG_FLD_MOD(DISPC_CONTROL, 1, bit, bit);
+	REG_FLD_MOD(DISPC_CONTROL(channel), 1, bit, bit);
 end:
 	enable_clocks(0);
 }
@@ -942,7 +945,7 @@ void dispc_set_lcd_size(u16 width, u16 height)
 	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
 	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
 	enable_clocks(1);
-	dispc_write_reg(DISPC_SIZE_LCD, val);
+	dispc_write_reg(DISPC_SIZE_LCD(OMAP_DSS_CHANNEL_LCD), val);
 	enable_clocks(0);
 }
 
@@ -1012,7 +1015,7 @@ void dispc_enable_fifomerge(bool enable)
 	enable_clocks(1);
 
 	DSSDBG("FIFO merge %s\n", enable ? "enabled" : "disabled");
-	REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 14, 14);
+	REG_FLD_MOD(DISPC_CONFIG(OMAP_DSS_CHANNEL_LCD), enable ? 1 : 0, 14, 14);
 
 	enable_clocks(0);
 }
@@ -1726,7 +1729,7 @@ static void dispc_disable_isr(void *data, u32 mask)
 
 static void _enable_lcd_out(bool enable)
 {
-	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 0, 0);
+	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD), enable ? 1 : 0, 0, 0);
 }
 
 static void dispc_enable_lcd_out(bool enable)
@@ -1740,7 +1743,7 @@ static void dispc_enable_lcd_out(bool enable)
 	/* When we disable LCD output, we need to wait until frame is done.
 	 * Otherwise the DSS is still working, and turning off the clocks
 	 * prevents DSS from going to OFF mode */
-	is_on = REG_GET(DISPC_CONTROL, 0, 0);
+	is_on = REG_GET(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD), 0, 0);
 
 	if (!enable && is_on) {
 		init_completion(&frame_done_completion);
@@ -1773,7 +1776,8 @@ static void dispc_enable_lcd_out(bool enable)
 
 static void _enable_digit_out(bool enable)
 {
-	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 1, 1);
+	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_DIGIT),
+		enable ? 1 : 0, 1, 1);
 }
 
 static void dispc_enable_digit_out(bool enable)
@@ -1783,7 +1787,7 @@ static void dispc_enable_digit_out(bool enable)
 
 	enable_clocks(1);
 
-	if (REG_GET(DISPC_CONTROL, 1, 1) == enable) {
+	if (REG_GET(DISPC_CONTROL(OMAP_DSS_CHANNEL_DIGIT), 1, 1) == enable) {
 		enable_clocks(0);
 		return;
 	}
@@ -1843,9 +1847,9 @@ static void dispc_enable_digit_out(bool enable)
 bool dispc_is_channel_enabled(enum omap_channel channel)
 {
 	if (channel == OMAP_DSS_CHANNEL_LCD)
-		return !!REG_GET(DISPC_CONTROL, 0, 0);
+		return !!REG_GET(DISPC_CONTROL(channel), 0, 0);
 	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
-		return !!REG_GET(DISPC_CONTROL, 1, 1);
+		return !!REG_GET(DISPC_CONTROL(channel), 1, 1);
 	else
 		BUG();
 }
@@ -1863,28 +1867,32 @@ void dispc_enable_channel(enum omap_channel channel, bool enable)
 void dispc_lcd_enable_signal_polarity(bool act_high)
 {
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONTROL, act_high ? 1 : 0, 29, 29);
+	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD),
+		act_high ? 1 : 0, 29, 29);
 	enable_clocks(0);
 }
 
 void dispc_lcd_enable_signal(bool enable)
 {
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 28, 28);
+	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD),
+		enable ? 1 : 0, 28, 28);
 	enable_clocks(0);
 }
 
 void dispc_pck_free_enable(bool enable)
 {
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 27, 27);
+	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD),
+		enable ? 1 : 0, 27, 27);
 	enable_clocks(0);
 }
 
 void dispc_enable_fifohandcheck(bool enable)
 {
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 16, 16);
+	REG_FLD_MOD(DISPC_CONFIG(OMAP_DSS_CHANNEL_LCD),
+		enable ? 1 : 0, 16, 16);
 	enable_clocks(0);
 }
 
@@ -1908,39 +1916,34 @@ void dispc_set_lcd_display_type(enum omap_lcd_display_type type)
 	}
 
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONTROL, mode, 3, 3);
+	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD), mode, 3, 3);
 	enable_clocks(0);
 }
 
 void dispc_set_loadmode(enum omap_dss_load_mode mode)
 {
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONFIG, mode, 2, 1);
+	REG_FLD_MOD(DISPC_CONFIG(OMAP_DSS_CHANNEL_LCD), mode, 2, 1);
 	enable_clocks(0);
 }
 
 
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
 	       channel != OMAP_DSS_CHANNEL_LCD);
 
 	enable_clocks(1);
-	l = dispc_read_reg(def_reg[channel]);
+	l = dispc_read_reg(DISPC_DEFAULT_COLOR(channel));
 	enable_clocks(0);
 
 	return l;
@@ -1950,16 +1953,13 @@ void dispc_set_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type type,
 		u32 trans_key)
 {
-	const struct dispc_reg tr_reg[] = {
-		DISPC_TRANS_COLOR0, DISPC_TRANS_COLOR1 };
-
 	enable_clocks(1);
 	if (ch == OMAP_DSS_CHANNEL_LCD)
-		REG_FLD_MOD(DISPC_CONFIG, type, 11, 11);
+		REG_FLD_MOD(DISPC_CONFIG(ch), type, 11, 11);
 	else /* OMAP_DSS_CHANNEL_DIGIT */
-		REG_FLD_MOD(DISPC_CONFIG, type, 13, 13);
+		REG_FLD_MOD(DISPC_CONFIG(ch), type, 13, 13);
 
-	dispc_write_reg(tr_reg[ch], trans_key);
+	dispc_write_reg(DISPC_TRANS_COLOR(ch), trans_key);
 	enable_clocks(0);
 }
 
@@ -1967,21 +1967,18 @@ void dispc_get_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type *type,
 		u32 *trans_key)
 {
-	const struct dispc_reg tr_reg[] = {
-		DISPC_TRANS_COLOR0, DISPC_TRANS_COLOR1 };
-
 	enable_clocks(1);
 	if (type) {
 		if (ch == OMAP_DSS_CHANNEL_LCD)
-			*type = REG_GET(DISPC_CONFIG, 11, 11);
+			*type = REG_GET(DISPC_CONFIG(ch), 11, 11);
 		else if (ch == OMAP_DSS_CHANNEL_DIGIT)
-			*type = REG_GET(DISPC_CONFIG, 13, 13);
+			*type = REG_GET(DISPC_CONFIG(ch), 13, 13);
 		else
 			BUG();
 	}
 
 	if (trans_key)
-		*trans_key = dispc_read_reg(tr_reg[ch]);
+		*trans_key = dispc_read_reg(DISPC_TRANS_COLOR(ch));
 	enable_clocks(0);
 }
 
@@ -1989,9 +1986,9 @@ void dispc_enable_trans_key(enum omap_channel ch, bool enable)
 {
 	enable_clocks(1);
 	if (ch == OMAP_DSS_CHANNEL_LCD)
-		REG_FLD_MOD(DISPC_CONFIG, enable, 10, 10);
+		REG_FLD_MOD(DISPC_CONFIG(ch), enable, 10, 10);
 	else /* OMAP_DSS_CHANNEL_DIGIT */
-		REG_FLD_MOD(DISPC_CONFIG, enable, 12, 12);
+		REG_FLD_MOD(DISPC_CONFIG(ch), enable, 12, 12);
 	enable_clocks(0);
 }
 void dispc_enable_alpha_blending(enum omap_channel ch, bool enable)
@@ -2001,9 +1998,9 @@ void dispc_enable_alpha_blending(enum omap_channel ch, bool enable)
 
 	enable_clocks(1);
 	if (ch == OMAP_DSS_CHANNEL_LCD)
-		REG_FLD_MOD(DISPC_CONFIG, enable, 18, 18);
+		REG_FLD_MOD(DISPC_CONFIG(ch), enable, 18, 18);
 	else /* OMAP_DSS_CHANNEL_DIGIT */
-		REG_FLD_MOD(DISPC_CONFIG, enable, 19, 19);
+		REG_FLD_MOD(DISPC_CONFIG(ch), enable, 19, 19);
 	enable_clocks(0);
 }
 bool dispc_alpha_blending_enabled(enum omap_channel ch)
@@ -2015,9 +2012,9 @@ bool dispc_alpha_blending_enabled(enum omap_channel ch)
 
 	enable_clocks(1);
 	if (ch == OMAP_DSS_CHANNEL_LCD)
-		enabled = REG_GET(DISPC_CONFIG, 18, 18);
+		enabled = REG_GET(DISPC_CONFIG(ch), 18, 18);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
-		enabled = REG_GET(DISPC_CONFIG, 19, 19);
+		enabled = REG_GET(DISPC_CONFIG(ch), 19, 19);
 	else
 		BUG();
 	enable_clocks(0);
@@ -2032,9 +2029,9 @@ bool dispc_trans_key_enabled(enum omap_channel ch)
 
 	enable_clocks(1);
 	if (ch == OMAP_DSS_CHANNEL_LCD)
-		enabled = REG_GET(DISPC_CONFIG, 10, 10);
+		enabled = REG_GET(DISPC_CONFIG(ch), 10, 10);
 	else if (ch == OMAP_DSS_CHANNEL_DIGIT)
-		enabled = REG_GET(DISPC_CONFIG, 12, 12);
+		enabled = REG_GET(DISPC_CONFIG(ch), 12, 12);
 	else
 		BUG();
 	enable_clocks(0);
@@ -2066,7 +2063,7 @@ void dispc_set_tft_data_lines(u8 data_lines)
 	}
 
 	enable_clocks(1);
-	REG_FLD_MOD(DISPC_CONTROL, code, 9, 8);
+	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD), code, 9, 8);
 	enable_clocks(0);
 }
 
@@ -2100,13 +2097,13 @@ void dispc_set_parallel_interface_mode(enum omap_parallel_interface_mode mode)
 
 	enable_clocks(1);
 
-	l = dispc_read_reg(DISPC_CONTROL);
+	l = dispc_read_reg(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD));
 
 	l = FLD_MOD(l, stallmode, 11, 11);
 	l = FLD_MOD(l, gpout0, 15, 15);
 	l = FLD_MOD(l, gpout1, 16, 16);
 
-	dispc_write_reg(DISPC_CONTROL, l);
+	dispc_write_reg(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD), l);
 
 	enable_clocks(0);
 }
@@ -2162,8 +2159,8 @@ static void _dispc_set_lcd_timings(int hsw, int hfp, int hbp,
 	}
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_TIMING_H, timing_h);
-	dispc_write_reg(DISPC_TIMING_V, timing_v);
+	dispc_write_reg(DISPC_TIMING_H(OMAP_DSS_CHANNEL_LCD), timing_h);
+	dispc_write_reg(DISPC_TIMING_V(OMAP_DSS_CHANNEL_LCD), timing_v);
 	enable_clocks(0);
 }
 
@@ -2204,7 +2201,7 @@ static void dispc_set_lcd_divisor(u16 lck_div, u16 pck_div)
 	BUG_ON(pck_div < 2);
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_DIVISOR,
+	dispc_write_reg(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD),
 			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
 	enable_clocks(0);
 }
@@ -2212,7 +2209,7 @@ static void dispc_set_lcd_divisor(u16 lck_div, u16 pck_div)
 static void dispc_get_lcd_divisor(int *lck_div, int *pck_div)
 {
 	u32 l;
-	l = dispc_read_reg(DISPC_DIVISOR);
+	l = dispc_read_reg(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD));
 	*lck_div = FLD_GET(l, 23, 16);
 	*pck_div = FLD_GET(l, 7, 0);
 }
@@ -2238,7 +2235,7 @@ unsigned long dispc_lclk_rate(void)
 	unsigned long r;
 	u32 l;
 
-	l = dispc_read_reg(DISPC_DIVISOR);
+	l = dispc_read_reg(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD));
 
 	lcd = FLD_GET(l, 23, 16);
 
@@ -2253,7 +2250,7 @@ unsigned long dispc_pclk_rate(void)
 	unsigned long r;
 	u32 l;
 
-	l = dispc_read_reg(DISPC_DIVISOR);
+	l = dispc_read_reg(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD));
 
 	lcd = FLD_GET(l, 23, 16);
 	pcd = FLD_GET(l, 7, 0);
@@ -2337,22 +2334,22 @@ void dispc_dump_regs(struct seq_file *s)
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
+	DUMPREG(DISPC_SIZE_LCD(0));
 
 	DUMPREG(DISPC_GFX_BA0);
 	DUMPREG(DISPC_GFX_BA1);
@@ -2366,13 +2363,13 @@ void dispc_dump_regs(struct seq_file *s)
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
 
@@ -2489,7 +2486,7 @@ static void _dispc_set_pol_freq(bool onoff, bool rf, bool ieo, bool ipc,
 	l |= FLD_VAL(acb, 7, 0);
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_POL_FREQ, l);
+	dispc_write_reg(DISPC_POL_FREQ(OMAP_DSS_CHANNEL_LCD), l);
 	enable_clocks(0);
 }
 
@@ -2580,8 +2577,8 @@ int dispc_get_clock_div(struct dispc_clock_info *cinfo)
 
 	fck = dispc_fclk_rate();
 
-	cinfo->lck_div = REG_GET(DISPC_DIVISOR, 23, 16);
-	cinfo->pck_div = REG_GET(DISPC_DIVISOR, 7, 0);
+	cinfo->lck_div = REG_GET(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD), 23, 16);
+	cinfo->pck_div = REG_GET(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD), 7, 0);
 
 	cinfo->lck = fck / cinfo->lck_div;
 	cinfo->pck = cinfo->lck / cinfo->pck_div;
@@ -3078,7 +3075,7 @@ static void _omap_dispc_initial_config(void)
 	dispc_write_reg(DISPC_SYSCONFIG, l);
 
 	/* FUNCGATED */
-	REG_FLD_MOD(DISPC_CONFIG, 1, 9, 9);
+	REG_FLD_MOD(DISPC_CONFIG(OMAP_DSS_CHANNEL_LCD), 1, 9, 9);
 
 	/* L3 firewall setting: enable access to OCM RAM */
 	/* XXX this should be somewhere in plat-omap */
-- 
1.7.0.4

