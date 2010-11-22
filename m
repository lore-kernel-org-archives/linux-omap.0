From: Archit Taneja <archit@ti.com>
Subject: [PATCH v5 2/7] OMAP: DSS2: Represent DISPC register defines with channel as parameter
Date: Mon, 22 Nov 2010 12:53:00 +0530
Message-ID: <1290410585-29418-3-git-send-email-archit@ti.com>
References: <1290410585-29418-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36299 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179Ab0KVHXX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 02:23:23 -0500
In-Reply-To: <1290410585-29418-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Sumit Semwal <sumit.semwal@ti.com>, Mukund Mittal <mmittal@ti.com>, Samreen <samreen@ti.com>, Archit Taneja <archit@ti.com>

From: Sumit Semwal <sumit.semwal@ti.com>

Introduce new enum members for LCD2 Channel and corresponding Overlay Manager.

Represent some of the DISPC register defines with channel as a parameter
to differentiate between LCD, DIGIT and LCD2 channels. Replace the existing
reads/writes to these registers in this new way.

Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    2 +
 drivers/video/omap2/dss/dispc.c           |  170 ++++++++++++++---------------
 2 files changed, 84 insertions(+), 88 deletions(-)

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
index 54ba8d3..ca072fe 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -44,34 +44,40 @@
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
 #define DISPC_CONTROL			DISPC_REG(0x0040)
+#define DISPC_CONTROL2			DISPC_REG(0x0238)
 #define DISPC_CONFIG			DISPC_REG(0x0044)
+#define DISPC_CONFIG2			DISPC_REG(0x0620)
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
@@ -86,13 +92,12 @@ struct dispc_reg { u16 idx; };
 #define DISPC_GFX_WINDOW_SKIP		DISPC_REG(0x00B4)
 #define DISPC_GFX_TABLE_BA		DISPC_REG(0x00B8)
 
-#define DISPC_DATA_CYCLE1		DISPC_REG(0x01D4)
-#define DISPC_DATA_CYCLE2		DISPC_REG(0x01D8)
-#define DISPC_DATA_CYCLE3		DISPC_REG(0x01DC)
-
-#define DISPC_CPR_COEF_R		DISPC_REG(0x0220)
-#define DISPC_CPR_COEF_G		DISPC_REG(0x0224)
-#define DISPC_CPR_COEF_B		DISPC_REG(0x0228)
+#define DISPC_DATA_CYCLE1(ch)		DISPC_REG(ch != 2 ? 0x01D4 : 0x03C0)
+#define DISPC_DATA_CYCLE2(ch)		DISPC_REG(ch != 2 ? 0x01D8 : 0x03C4)
+#define DISPC_DATA_CYCLE3(ch)		DISPC_REG(ch != 2 ? 0x01DC : 0x03C8)
+#define DISPC_CPR_COEF_R(ch)		DISPC_REG(ch != 2 ? 0x0220 : 0x03BC)
+#define DISPC_CPR_COEF_G(ch)		DISPC_REG(ch != 2 ? 0x0224 : 0x03B8)
+#define DISPC_CPR_COEF_B(ch)		DISPC_REG(ch != 2 ? 0x0228 : 0x03B4)
 
 #define DISPC_GFX_PRELOAD		DISPC_REG(0x022C)
 
@@ -217,18 +222,18 @@ void dispc_save_context(void)
 	SR(IRQENABLE);
 	SR(CONTROL);
 	SR(CONFIG);
-	SR(DEFAULT_COLOR0);
-	SR(DEFAULT_COLOR1);
-	SR(TRANS_COLOR0);
-	SR(TRANS_COLOR1);
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
@@ -241,13 +246,13 @@ void dispc_save_context(void)
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
 
@@ -356,18 +361,18 @@ void dispc_restore_context(void)
 	/*RR(IRQENABLE);*/
 	/*RR(CONTROL);*/
 	RR(CONFIG);
-	RR(DEFAULT_COLOR0);
-	RR(DEFAULT_COLOR1);
-	RR(TRANS_COLOR0);
-	RR(TRANS_COLOR1);
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
@@ -380,13 +385,13 @@ void dispc_restore_context(void)
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
 
@@ -942,7 +947,7 @@ void dispc_set_lcd_size(u16 width, u16 height)
 	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
 	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
 	enable_clocks(1);
-	dispc_write_reg(DISPC_SIZE_LCD, val);
+	dispc_write_reg(DISPC_SIZE_LCD(OMAP_DSS_CHANNEL_LCD), val);
 	enable_clocks(0);
 }
 
@@ -1922,25 +1927,20 @@ void dispc_set_loadmode(enum omap_dss_load_mode mode)
 
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
@@ -1950,16 +1950,13 @@ void dispc_set_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type type,
 		u32 trans_key)
 {
-	const struct dispc_reg tr_reg[] = {
-		DISPC_TRANS_COLOR0, DISPC_TRANS_COLOR1 };
-
 	enable_clocks(1);
 	if (ch == OMAP_DSS_CHANNEL_LCD)
 		REG_FLD_MOD(DISPC_CONFIG, type, 11, 11);
 	else /* OMAP_DSS_CHANNEL_DIGIT */
 		REG_FLD_MOD(DISPC_CONFIG, type, 13, 13);
 
-	dispc_write_reg(tr_reg[ch], trans_key);
+	dispc_write_reg(DISPC_TRANS_COLOR(ch), trans_key);
 	enable_clocks(0);
 }
 
@@ -1967,9 +1964,6 @@ void dispc_get_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type *type,
 		u32 *trans_key)
 {
-	const struct dispc_reg tr_reg[] = {
-		DISPC_TRANS_COLOR0, DISPC_TRANS_COLOR1 };
-
 	enable_clocks(1);
 	if (type) {
 		if (ch == OMAP_DSS_CHANNEL_LCD)
@@ -1981,7 +1975,7 @@ void dispc_get_trans_key(enum omap_channel ch,
 	}
 
 	if (trans_key)
-		*trans_key = dispc_read_reg(tr_reg[ch]);
+		*trans_key = dispc_read_reg(DISPC_TRANS_COLOR(ch));
 	enable_clocks(0);
 }
 
@@ -2162,8 +2156,8 @@ static void _dispc_set_lcd_timings(int hsw, int hfp, int hbp,
 	}
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_TIMING_H, timing_h);
-	dispc_write_reg(DISPC_TIMING_V, timing_v);
+	dispc_write_reg(DISPC_TIMING_H(OMAP_DSS_CHANNEL_LCD), timing_h);
+	dispc_write_reg(DISPC_TIMING_V(OMAP_DSS_CHANNEL_LCD), timing_v);
 	enable_clocks(0);
 }
 
@@ -2204,7 +2198,7 @@ static void dispc_set_lcd_divisor(u16 lck_div, u16 pck_div)
 	BUG_ON(pck_div < 2);
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_DIVISOR,
+	dispc_write_reg(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD),
 			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
 	enable_clocks(0);
 }
@@ -2212,7 +2206,7 @@ static void dispc_set_lcd_divisor(u16 lck_div, u16 pck_div)
 static void dispc_get_lcd_divisor(int *lck_div, int *pck_div)
 {
 	u32 l;
-	l = dispc_read_reg(DISPC_DIVISOR);
+	l = dispc_read_reg(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD));
 	*lck_div = FLD_GET(l, 23, 16);
 	*pck_div = FLD_GET(l, 7, 0);
 }
@@ -2238,7 +2232,7 @@ unsigned long dispc_lclk_rate(void)
 	unsigned long r;
 	u32 l;
 
-	l = dispc_read_reg(DISPC_DIVISOR);
+	l = dispc_read_reg(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD));
 
 	lcd = FLD_GET(l, 23, 16);
 
@@ -2253,7 +2247,7 @@ unsigned long dispc_pclk_rate(void)
 	unsigned long r;
 	u32 l;
 
-	l = dispc_read_reg(DISPC_DIVISOR);
+	l = dispc_read_reg(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD));
 
 	lcd = FLD_GET(l, 23, 16);
 	pcd = FLD_GET(l, 7, 0);
@@ -2340,19 +2334,19 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_CONTROL);
 	DUMPREG(DISPC_CONFIG);
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
@@ -2366,13 +2360,13 @@ void dispc_dump_regs(struct seq_file *s)
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
 
@@ -2489,7 +2483,7 @@ static void _dispc_set_pol_freq(bool onoff, bool rf, bool ieo, bool ipc,
 	l |= FLD_VAL(acb, 7, 0);
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_POL_FREQ, l);
+	dispc_write_reg(DISPC_POL_FREQ(OMAP_DSS_CHANNEL_LCD), l);
 	enable_clocks(0);
 }
 
@@ -2580,8 +2574,8 @@ int dispc_get_clock_div(struct dispc_clock_info *cinfo)
 
 	fck = dispc_fclk_rate();
 
-	cinfo->lck_div = REG_GET(DISPC_DIVISOR, 23, 16);
-	cinfo->pck_div = REG_GET(DISPC_DIVISOR, 7, 0);
+	cinfo->lck_div = REG_GET(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD), 23, 16);
+	cinfo->pck_div = REG_GET(DISPC_DIVISOR(OMAP_DSS_CHANNEL_LCD), 7, 0);
 
 	cinfo->lck = fck / cinfo->lck_div;
 	cinfo->pck = cinfo->lck / cinfo->pck_div;
-- 
1.7.0.4

