From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/3] OMAP: DSS2: Clean up DISPC overlay manager register definitions
Date: Fri,  6 May 2011 11:45:50 +0530
Message-ID: <1304662551-23832-3-git-send-email-archit@ti.com>
References: <1304662551-23832-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36270 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521Ab1EFGLL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 May 2011 02:11:11 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p466BAAX026253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 6 May 2011 01:11:10 -0500
In-Reply-To: <1304662551-23832-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Represent manager/channel specific DISPC registers as inline functions returning
the required dispc_reg struct. This is done since the current method is not
scalable as the number of overlay managers increase in number.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  178 ++++++++++++++++----------------
 drivers/video/omap2/dss/dispc.h |  212 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 276 insertions(+), 114 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 127cc32..d00d2f1 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -136,27 +136,27 @@ void dispc_save_context(void)
 	SR(IRQENABLE);
 	SR(CONTROL);
 	SR(CONFIG);
-	SR(DEFAULT_COLOR(0));
-	SR(DEFAULT_COLOR(1));
-	SR(TRANS_COLOR(0));
-	SR(TRANS_COLOR(1));
+	SR(DEFAULT_COLOR(OMAP_DSS_CHANNEL_LCD));
+	SR(DEFAULT_COLOR(OMAP_DSS_CHANNEL_DIGIT));
+	SR(TRANS_COLOR(OMAP_DSS_CHANNEL_LCD));
+	SR(TRANS_COLOR(OMAP_DSS_CHANNEL_DIGIT));
 	SR(LINE_NUMBER);
-	SR(TIMING_H(0));
-	SR(TIMING_V(0));
-	SR(POL_FREQ(0));
-	SR(DIVISORo(0));
+	SR(TIMING_H(OMAP_DSS_CHANNEL_LCD));
+	SR(TIMING_V(OMAP_DSS_CHANNEL_LCD));
+	SR(POL_FREQ(OMAP_DSS_CHANNEL_LCD));
+	SR(DIVISORo(OMAP_DSS_CHANNEL_LCD));
 	SR(GLOBAL_ALPHA);
-	SR(SIZE_DIG);
-	SR(SIZE_LCD(0));
+	SR(SIZE_MGR(OMAP_DSS_CHANNEL_DIGIT));
+	SR(SIZE_MGR(OMAP_DSS_CHANNEL_LCD));
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
 		SR(CONTROL2);
-		SR(DEFAULT_COLOR(2));
-		SR(TRANS_COLOR(2));
-		SR(SIZE_LCD(2));
-		SR(TIMING_H(2));
-		SR(TIMING_V(2));
-		SR(POL_FREQ(2));
-		SR(DIVISORo(2));
+		SR(DEFAULT_COLOR(OMAP_DSS_CHANNEL_LCD2));
+		SR(TRANS_COLOR(OMAP_DSS_CHANNEL_LCD2));
+		SR(SIZE_MGR(OMAP_DSS_CHANNEL_LCD2));
+		SR(TIMING_H(OMAP_DSS_CHANNEL_LCD2));
+		SR(TIMING_V(OMAP_DSS_CHANNEL_LCD2));
+		SR(POL_FREQ(OMAP_DSS_CHANNEL_LCD2));
+		SR(DIVISORo(OMAP_DSS_CHANNEL_LCD2));
 		SR(CONFIG2);
 	}
 
@@ -171,21 +171,21 @@ void dispc_save_context(void)
 	SR(OVL_WINDOW_SKIP(OMAP_DSS_GFX));
 	SR(OVL_TABLE_BA(OMAP_DSS_GFX));
 
-	SR(DATA_CYCLE1(0));
-	SR(DATA_CYCLE2(0));
-	SR(DATA_CYCLE3(0));
+	SR(DATA_CYCLE1(OMAP_DSS_CHANNEL_LCD));
+	SR(DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD));
+	SR(DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD));
 
-	SR(CPR_COEF_R(0));
-	SR(CPR_COEF_G(0));
-	SR(CPR_COEF_B(0));
+	SR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD));
+	SR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD));
+	SR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD));
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
-		SR(CPR_COEF_B(2));
-		SR(CPR_COEF_G(2));
-		SR(CPR_COEF_R(2));
+		SR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD2));
+		SR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD2));
+		SR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD2));
 
-		SR(DATA_CYCLE1(2));
-		SR(DATA_CYCLE2(2));
-		SR(DATA_CYCLE3(2));
+		SR(DATA_CYCLE1(OMAP_DSS_CHANNEL_LCD2));
+		SR(DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD2));
+		SR(DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD2));
 	}
 
 	SR(OVL_PRELOAD(OMAP_DSS_GFX));
@@ -298,26 +298,26 @@ void dispc_restore_context(void)
 	/*RR(IRQENABLE);*/
 	/*RR(CONTROL);*/
 	RR(CONFIG);
-	RR(DEFAULT_COLOR(0));
-	RR(DEFAULT_COLOR(1));
-	RR(TRANS_COLOR(0));
-	RR(TRANS_COLOR(1));
+	RR(DEFAULT_COLOR(OMAP_DSS_CHANNEL_LCD));
+	RR(DEFAULT_COLOR(OMAP_DSS_CHANNEL_DIGIT));
+	RR(TRANS_COLOR(OMAP_DSS_CHANNEL_LCD));
+	RR(TRANS_COLOR(OMAP_DSS_CHANNEL_DIGIT));
 	RR(LINE_NUMBER);
-	RR(TIMING_H(0));
-	RR(TIMING_V(0));
-	RR(POL_FREQ(0));
-	RR(DIVISORo(0));
+	RR(TIMING_H(OMAP_DSS_CHANNEL_LCD));
+	RR(TIMING_V(OMAP_DSS_CHANNEL_LCD));
+	RR(POL_FREQ(OMAP_DSS_CHANNEL_LCD));
+	RR(DIVISORo(OMAP_DSS_CHANNEL_LCD));
 	RR(GLOBAL_ALPHA);
-	RR(SIZE_DIG);
-	RR(SIZE_LCD(0));
+	RR(SIZE_MGR(OMAP_DSS_CHANNEL_DIGIT));
+	RR(SIZE_MGR(OMAP_DSS_CHANNEL_LCD));
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
-		RR(DEFAULT_COLOR(2));
-		RR(TRANS_COLOR(2));
-		RR(SIZE_LCD(2));
-		RR(TIMING_H(2));
-		RR(TIMING_V(2));
-		RR(POL_FREQ(2));
-		RR(DIVISORo(2));
+		RR(DEFAULT_COLOR(OMAP_DSS_CHANNEL_LCD2));
+		RR(TRANS_COLOR(OMAP_DSS_CHANNEL_LCD2));
+		RR(SIZE_MGR(OMAP_DSS_CHANNEL_LCD2));
+		RR(TIMING_H(OMAP_DSS_CHANNEL_LCD2));
+		RR(TIMING_V(OMAP_DSS_CHANNEL_LCD2));
+		RR(POL_FREQ(OMAP_DSS_CHANNEL_LCD2));
+		RR(DIVISORo(OMAP_DSS_CHANNEL_LCD2));
 		RR(CONFIG2);
 	}
 
@@ -333,21 +333,21 @@ void dispc_restore_context(void)
 	RR(OVL_TABLE_BA(OMAP_DSS_GFX));
 
 
-	RR(DATA_CYCLE1(0));
-	RR(DATA_CYCLE2(0));
-	RR(DATA_CYCLE3(0));
+	RR(DATA_CYCLE1(OMAP_DSS_CHANNEL_LCD));
+	RR(DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD));
+	RR(DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD));
 
-	RR(CPR_COEF_R(0));
-	RR(CPR_COEF_G(0));
-	RR(CPR_COEF_B(0));
+	RR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD));
+	RR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD));
+	RR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD));
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
-		RR(DATA_CYCLE1(2));
-		RR(DATA_CYCLE2(2));
-		RR(DATA_CYCLE3(2));
+		RR(DATA_CYCLE1(OMAP_DSS_CHANNEL_LCD2));
+		RR(DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD2));
+		RR(DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD2));
 
-		RR(CPR_COEF_B(2));
-		RR(CPR_COEF_G(2));
-		RR(CPR_COEF_R(2));
+		RR(CPR_COEF_B(OMAP_DSS_CHANNEL_LCD2));
+		RR(CPR_COEF_G(OMAP_DSS_CHANNEL_LCD2));
+		RR(CPR_COEF_R(OMAP_DSS_CHANNEL_LCD2));
 	}
 
 	RR(OVL_PRELOAD(OMAP_DSS_GFX));
@@ -953,7 +953,7 @@ void dispc_set_lcd_size(enum omap_channel channel, u16 width, u16 height)
 	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
 	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
 	enable_clocks(1);
-	dispc_write_reg(DISPC_SIZE_LCD(channel), val);
+	dispc_write_reg(DISPC_SIZE_MGR(channel), val);
 	enable_clocks(0);
 }
 
@@ -963,7 +963,7 @@ void dispc_set_digit_size(u16 width, u16 height)
 	BUG_ON((width > (1 << 11)) || (height > (1 << 11)));
 	val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
 	enable_clocks(1);
-	dispc_write_reg(DISPC_SIZE_DIG, val);
+	dispc_write_reg(DISPC_SIZE_MGR(OMAP_DSS_CHANNEL_DIGIT), val);
 	enable_clocks(0);
 }
 
@@ -2426,29 +2426,29 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_CONTROL);
 	DUMPREG(DISPC_CONFIG);
 	DUMPREG(DISPC_CAPABLE);
-	DUMPREG(DISPC_DEFAULT_COLOR(0));
-	DUMPREG(DISPC_DEFAULT_COLOR(1));
-	DUMPREG(DISPC_TRANS_COLOR(0));
-	DUMPREG(DISPC_TRANS_COLOR(1));
+	DUMPREG(DISPC_DEFAULT_COLOR(OMAP_DSS_CHANNEL_LCD));
+	DUMPREG(DISPC_DEFAULT_COLOR(OMAP_DSS_CHANNEL_DIGIT));
+	DUMPREG(DISPC_TRANS_COLOR(OMAP_DSS_CHANNEL_LCD));
+	DUMPREG(DISPC_TRANS_COLOR(OMAP_DSS_CHANNEL_DIGIT));
 	DUMPREG(DISPC_LINE_STATUS);
 	DUMPREG(DISPC_LINE_NUMBER);
-	DUMPREG(DISPC_TIMING_H(0));
-	DUMPREG(DISPC_TIMING_V(0));
-	DUMPREG(DISPC_POL_FREQ(0));
-	DUMPREG(DISPC_DIVISORo(0));
+	DUMPREG(DISPC_TIMING_H(OMAP_DSS_CHANNEL_LCD));
+	DUMPREG(DISPC_TIMING_V(OMAP_DSS_CHANNEL_LCD));
+	DUMPREG(DISPC_POL_FREQ(OMAP_DSS_CHANNEL_LCD));
+	DUMPREG(DISPC_DIVISORo(OMAP_DSS_CHANNEL_LCD));
 	DUMPREG(DISPC_GLOBAL_ALPHA);
-	DUMPREG(DISPC_SIZE_DIG);
-	DUMPREG(DISPC_SIZE_LCD(0));
+	DUMPREG(DISPC_SIZE_MGR(OMAP_DSS_CHANNEL_DIGIT));
+	DUMPREG(DISPC_SIZE_MGR(OMAP_DSS_CHANNEL_LCD));
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
 		DUMPREG(DISPC_CONTROL2);
 		DUMPREG(DISPC_CONFIG2);
-		DUMPREG(DISPC_DEFAULT_COLOR(2));
-		DUMPREG(DISPC_TRANS_COLOR(2));
-		DUMPREG(DISPC_TIMING_H(2));
-		DUMPREG(DISPC_TIMING_V(2));
-		DUMPREG(DISPC_POL_FREQ(2));
-		DUMPREG(DISPC_DIVISORo(2));
-		DUMPREG(DISPC_SIZE_LCD(2));
+		DUMPREG(DISPC_DEFAULT_COLOR(OMAP_DSS_CHANNEL_LCD2));
+		DUMPREG(DISPC_TRANS_COLOR(OMAP_DSS_CHANNEL_LCD2));
+		DUMPREG(DISPC_TIMING_H(OMAP_DSS_CHANNEL_LCD2));
+		DUMPREG(DISPC_TIMING_V(OMAP_DSS_CHANNEL_LCD2));
+		DUMPREG(DISPC_POL_FREQ(OMAP_DSS_CHANNEL_LCD2));
+		DUMPREG(DISPC_DIVISORo(OMAP_DSS_CHANNEL_LCD2));
+		DUMPREG(DISPC_SIZE_MGR(OMAP_DSS_CHANNEL_LCD2));
 	}
 
 	DUMPREG(DISPC_OVL_BA0(OMAP_DSS_GFX));
@@ -2463,21 +2463,21 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_OVL_WINDOW_SKIP(OMAP_DSS_GFX));
 	DUMPREG(DISPC_OVL_TABLE_BA(OMAP_DSS_GFX));
 
-	DUMPREG(DISPC_DATA_CYCLE1(0));
-	DUMPREG(DISPC_DATA_CYCLE2(0));
-	DUMPREG(DISPC_DATA_CYCLE3(0));
+	DUMPREG(DISPC_DATA_CYCLE1(OMAP_DSS_CHANNEL_LCD));
+	DUMPREG(DISPC_DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD));
+	DUMPREG(DISPC_DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD));
 
-	DUMPREG(DISPC_CPR_COEF_R(0));
-	DUMPREG(DISPC_CPR_COEF_G(0));
-	DUMPREG(DISPC_CPR_COEF_B(0));
+	DUMPREG(DISPC_CPR_COEF_R(OMAP_DSS_CHANNEL_LCD));
+	DUMPREG(DISPC_CPR_COEF_G(OMAP_DSS_CHANNEL_LCD));
+	DUMPREG(DISPC_CPR_COEF_B(OMAP_DSS_CHANNEL_LCD));
 	if (dss_has_feature(FEAT_MGR_LCD2)) {
-		DUMPREG(DISPC_DATA_CYCLE1(2));
-		DUMPREG(DISPC_DATA_CYCLE2(2));
-		DUMPREG(DISPC_DATA_CYCLE3(2));
+		DUMPREG(DISPC_DATA_CYCLE1(OMAP_DSS_CHANNEL_LCD2));
+		DUMPREG(DISPC_DATA_CYCLE2(OMAP_DSS_CHANNEL_LCD2));
+		DUMPREG(DISPC_DATA_CYCLE3(OMAP_DSS_CHANNEL_LCD2));
 
-		DUMPREG(DISPC_CPR_COEF_R(2));
-		DUMPREG(DISPC_CPR_COEF_G(2));
-		DUMPREG(DISPC_CPR_COEF_B(2));
+		DUMPREG(DISPC_CPR_COEF_R(OMAP_DSS_CHANNEL_LCD2));
+		DUMPREG(DISPC_CPR_COEF_G(OMAP_DSS_CHANNEL_LCD2));
+		DUMPREG(DISPC_CPR_COEF_B(OMAP_DSS_CHANNEL_LCD2));
 	}
 
 	DUMPREG(DISPC_OVL_PRELOAD(OMAP_DSS_GFX));
diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
index f22346b..05e5662 100644
--- a/drivers/video/omap2/dss/dispc.h
+++ b/drivers/video/omap2/dss/dispc.h
@@ -25,42 +25,20 @@ struct dispc_reg { u16 idx; };
 
 #define DISPC_REG(idx)			((const struct dispc_reg) { idx })
 
-/*
- * DISPC common registers and
- * DISPC channel registers , ch = 0 for LCD, ch = 1 for
- * DIGIT, and ch = 2 for LCD2
- */
+/* DISPC common registers */
 #define DISPC_REVISION			DISPC_REG(0x0000)
 #define DISPC_SYSCONFIG			DISPC_REG(0x0010)
 #define DISPC_SYSSTATUS			DISPC_REG(0x0014)
 #define DISPC_IRQSTATUS			DISPC_REG(0x0018)
 #define DISPC_IRQENABLE			DISPC_REG(0x001C)
 #define DISPC_CONTROL			DISPC_REG(0x0040)
-#define DISPC_CONTROL2			DISPC_REG(0x0238)
 #define DISPC_CONFIG			DISPC_REG(0x0044)
-#define DISPC_CONFIG2			DISPC_REG(0x0620)
 #define DISPC_CAPABLE			DISPC_REG(0x0048)
-#define DISPC_DEFAULT_COLOR(ch)		DISPC_REG(ch == 0 ? 0x004C : \
-					(ch == 1 ? 0x0050 : 0x03AC))
-#define DISPC_TRANS_COLOR(ch)		DISPC_REG(ch == 0 ? 0x0054 : \
-					(ch == 1 ? 0x0058 : 0x03B0))
 #define DISPC_LINE_STATUS		DISPC_REG(0x005C)
 #define DISPC_LINE_NUMBER		DISPC_REG(0x0060)
-#define DISPC_TIMING_H(ch)		DISPC_REG(ch != 2 ? 0x0064 : 0x0400)
-#define DISPC_TIMING_V(ch)		DISPC_REG(ch != 2 ? 0x0068 : 0x0404)
-#define DISPC_POL_FREQ(ch)		DISPC_REG(ch != 2 ? 0x006C : 0x0408)
-#define DISPC_DIVISORo(ch)		DISPC_REG(ch != 2 ? 0x0070 : 0x040C)
 #define DISPC_GLOBAL_ALPHA		DISPC_REG(0x0074)
-#define DISPC_SIZE_DIG			DISPC_REG(0x0078)
-#define DISPC_SIZE_LCD(ch)		DISPC_REG(ch != 2 ? 0x007C : 0x03CC)
-
-#define DISPC_DATA_CYCLE1(ch)		DISPC_REG(ch != 2 ? 0x01D4 : 0x03C0)
-#define DISPC_DATA_CYCLE2(ch)		DISPC_REG(ch != 2 ? 0x01D8 : 0x03C4)
-#define DISPC_DATA_CYCLE3(ch)		DISPC_REG(ch != 2 ? 0x01DC : 0x03C8)
-#define DISPC_CPR_COEF_R(ch)		DISPC_REG(ch != 2 ? 0x0220 : 0x03BC)
-#define DISPC_CPR_COEF_G(ch)		DISPC_REG(ch != 2 ? 0x0224 : 0x03B8)
-#define DISPC_CPR_COEF_B(ch)		DISPC_REG(ch != 2 ? 0x0228 : 0x03B4)
-
+#define DISPC_CONTROL2			DISPC_REG(0x0238)
+#define DISPC_CONFIG2			DISPC_REG(0x0620)
 #define DISPC_DIVISOR			DISPC_REG(0x0804)
 
 /* DISPC overlay registers */
@@ -105,6 +83,190 @@ struct dispc_reg { u16 idx; };
 #define DISPC_OVL_PRELOAD(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
 					DISPC_PRELOAD_OFFSET(n))
 
+/* DISPC manager/channel specific registers */
+static inline struct dispc_reg DISPC_DEFAULT_COLOR(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_REG(0x004C);
+	case OMAP_DSS_CHANNEL_DIGIT:
+		return DISPC_REG(0x0050);
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_REG(0x03AC);
+	default:
+		BUG();
+	}
+}
+
+static inline struct dispc_reg DISPC_TRANS_COLOR(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_REG(0x0054);
+	case OMAP_DSS_CHANNEL_DIGIT:
+		return DISPC_REG(0x0058);
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_REG(0x03B0);
+	default:
+		BUG();
+	}
+}
+
+static inline struct dispc_reg DISPC_TIMING_H(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_REG(0x0064);
+	case OMAP_DSS_CHANNEL_DIGIT:
+		BUG();
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_REG(0x0400);
+	default:
+		BUG();
+	}
+}
+
+static inline struct dispc_reg DISPC_TIMING_V(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_REG(0x0068);
+	case OMAP_DSS_CHANNEL_DIGIT:
+		BUG();
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_REG(0x0404);
+	default:
+		BUG();
+	}
+}
+
+static inline struct dispc_reg DISPC_POL_FREQ(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_REG(0x006C);
+	case OMAP_DSS_CHANNEL_DIGIT:
+		BUG();
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_REG(0x0408);
+	default:
+		BUG();
+	}
+}
+
+static inline struct dispc_reg DISPC_DIVISORo(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_REG(0x0070);
+	case OMAP_DSS_CHANNEL_DIGIT:
+		BUG();
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_REG(0x040C);
+	default:
+		BUG();
+	}
+}
+
+/* Named as DISPC_SIZE_LCD, DISPC_SIZE_DIGIT and DISPC_SIZE_LCD2 in TRM */
+static inline struct dispc_reg DISPC_SIZE_MGR(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_REG(0x007C);
+	case OMAP_DSS_CHANNEL_DIGIT:
+		return DISPC_REG(0x0078);
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_REG(0x03CC);
+	default:
+		BUG();
+	}
+}
+
+static inline struct dispc_reg DISPC_DATA_CYCLE1(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_REG(0x01D4);
+	case OMAP_DSS_CHANNEL_DIGIT:
+		BUG();
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_REG(0x03C0);
+	default:
+		BUG();
+	}
+}
+
+static inline struct dispc_reg DISPC_DATA_CYCLE2(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_REG(0x01D8);
+	case OMAP_DSS_CHANNEL_DIGIT:
+		BUG();
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_REG(0x03C4);
+	default:
+		BUG();
+	}
+}
+
+static inline struct dispc_reg DISPC_DATA_CYCLE3(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_REG(0x01DC);
+	case OMAP_DSS_CHANNEL_DIGIT:
+		BUG();
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_REG(0x03C8);
+	default:
+		BUG();
+	}
+}
+
+static inline struct dispc_reg DISPC_CPR_COEF_R(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_REG(0x0220);
+	case OMAP_DSS_CHANNEL_DIGIT:
+		BUG();
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_REG(0x03BC);
+	default:
+		BUG();
+	}
+}
+
+static inline struct dispc_reg DISPC_CPR_COEF_G(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_REG(0x0224);
+	case OMAP_DSS_CHANNEL_DIGIT:
+		BUG();
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_REG(0x03B8);
+	default:
+		BUG();
+	}
+}
+
+static inline struct dispc_reg DISPC_CPR_COEF_B(enum omap_channel channel)
+{
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		return DISPC_REG(0x0228);
+	case OMAP_DSS_CHANNEL_DIGIT:
+		BUG();
+	case OMAP_DSS_CHANNEL_LCD2:
+		return DISPC_REG(0x03B4);
+	default:
+		BUG();
+	}
+}
+
 /* DISPC overlay register base addresses */
 static inline u16 DISPC_OVL_BASE(enum omap_plane plane)
 {
-- 
1.7.1

