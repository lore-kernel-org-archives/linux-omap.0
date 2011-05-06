From: Archit Taneja <archit@ti.com>
Subject: [PATCH 3/3] OMAP: DSS2: Remove usage of struct dispc_reg
Date: Fri,  6 May 2011 11:45:51 +0530
Message-ID: <1304662551-23832-4-git-send-email-archit@ti.com>
References: <1304662551-23832-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49339 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521Ab1EFGLP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 02:11:15 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p466BEDN002712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 6 May 2011 01:11:14 -0500
In-Reply-To: <1304662551-23832-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

struct dispc_reg was originally used while migrating from old omapfb to
catch cases where the arguments to dispc_read_reg/dispc_write_reg were in
wrong order, since old omapfb had the arguments in reverse order.

Remove this struct and use u16 instead

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   12 ++--
 drivers/video/omap2/dss/dispc.h |  156 +++++++++++++++++++--------------------
 2 files changed, 82 insertions(+), 86 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d00d2f1..5d58b5c 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -112,20 +112,20 @@ static struct {
 
 static void _omap_dispc_set_irqs(void);
 
-static inline void dispc_write_reg(const struct dispc_reg idx, u32 val)
+static inline void dispc_write_reg(const u16 idx, u32 val)
 {
-	__raw_writel(val, dispc.base + idx.idx);
+	__raw_writel(val, dispc.base + idx);
 }
 
-static inline u32 dispc_read_reg(const struct dispc_reg idx)
+static inline u32 dispc_read_reg(const u16 idx)
 {
-	return __raw_readl(dispc.base + idx.idx);
+	return __raw_readl(dispc.base + idx);
 }
 
 #define SR(reg) \
-	dispc.ctx[(DISPC_##reg).idx / sizeof(u32)] = dispc_read_reg(DISPC_##reg)
+	dispc.ctx[DISPC_##reg / sizeof(u32)] = dispc_read_reg(DISPC_##reg)
 #define RR(reg) \
-	dispc_write_reg(DISPC_##reg, dispc.ctx[(DISPC_##reg).idx / sizeof(u32)])
+	dispc_write_reg(DISPC_##reg, dispc.ctx[DISPC_##reg / sizeof(u32)])
 
 void dispc_save_context(void)
 {
diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
index 05e5662..d45f010 100644
--- a/drivers/video/omap2/dss/dispc.h
+++ b/drivers/video/omap2/dss/dispc.h
@@ -21,247 +21,243 @@
 #ifndef __OMAP2_DISPC_REG_H
 #define __OMAP2_DISPC_REG_H
 
-struct dispc_reg { u16 idx; };
-
-#define DISPC_REG(idx)			((const struct dispc_reg) { idx })
-
 /* DISPC common registers */
-#define DISPC_REVISION			DISPC_REG(0x0000)
-#define DISPC_SYSCONFIG			DISPC_REG(0x0010)
-#define DISPC_SYSSTATUS			DISPC_REG(0x0014)
-#define DISPC_IRQSTATUS			DISPC_REG(0x0018)
-#define DISPC_IRQENABLE			DISPC_REG(0x001C)
-#define DISPC_CONTROL			DISPC_REG(0x0040)
-#define DISPC_CONFIG			DISPC_REG(0x0044)
-#define DISPC_CAPABLE			DISPC_REG(0x0048)
-#define DISPC_LINE_STATUS		DISPC_REG(0x005C)
-#define DISPC_LINE_NUMBER		DISPC_REG(0x0060)
-#define DISPC_GLOBAL_ALPHA		DISPC_REG(0x0074)
-#define DISPC_CONTROL2			DISPC_REG(0x0238)
-#define DISPC_CONFIG2			DISPC_REG(0x0620)
-#define DISPC_DIVISOR			DISPC_REG(0x0804)
+#define DISPC_REVISION			0x0000
+#define DISPC_SYSCONFIG			0x0010
+#define DISPC_SYSSTATUS			0x0014
+#define DISPC_IRQSTATUS			0x0018
+#define DISPC_IRQENABLE			0x001C
+#define DISPC_CONTROL			0x0040
+#define DISPC_CONFIG			0x0044
+#define DISPC_CAPABLE			0x0048
+#define DISPC_LINE_STATUS		0x005C
+#define DISPC_LINE_NUMBER		0x0060
+#define DISPC_GLOBAL_ALPHA		0x0074
+#define DISPC_CONTROL2			0x0238
+#define DISPC_CONFIG2			0x0620
+#define DISPC_DIVISOR			0x0804
 
 /* DISPC overlay registers */
-#define DISPC_OVL_BA0(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_BA0(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_BA0_OFFSET(n))
-#define DISPC_OVL_BA1(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_BA1(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_BA1_OFFSET(n))
-#define DISPC_OVL_POSITION(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_POSITION(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_POS_OFFSET(n))
-#define DISPC_OVL_SIZE(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_SIZE(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_SIZE_OFFSET(n))
-#define DISPC_OVL_ATTRIBUTES(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_ATTRIBUTES(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_ATTR_OFFSET(n))
-#define DISPC_OVL_FIFO_THRESHOLD(n)	DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_FIFO_THRESHOLD(n)	(DISPC_OVL_BASE(n) + \
 					DISPC_FIFO_THRESH_OFFSET(n))
-#define DISPC_OVL_FIFO_SIZE_STATUS(n)	DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_FIFO_SIZE_STATUS(n)	(DISPC_OVL_BASE(n) + \
 					DISPC_FIFO_SIZE_STATUS_OFFSET(n))
-#define DISPC_OVL_ROW_INC(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_ROW_INC(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_ROW_INC_OFFSET(n))
-#define DISPC_OVL_PIXEL_INC(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_PIXEL_INC(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_PIX_INC_OFFSET(n))
-#define DISPC_OVL_WINDOW_SKIP(n)	DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_WINDOW_SKIP(n)	(DISPC_OVL_BASE(n) + \
 					DISPC_WINDOW_SKIP_OFFSET(n))
-#define DISPC_OVL_TABLE_BA(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_TABLE_BA(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_TABLE_BA_OFFSET(n))
-#define DISPC_OVL_FIR(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_FIR(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_FIR_OFFSET(n))
-#define DISPC_OVL_PICTURE_SIZE(n)	DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_PICTURE_SIZE(n)	(DISPC_OVL_BASE(n) + \
 					DISPC_PIC_SIZE_OFFSET(n))
-#define DISPC_OVL_ACCU0(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_ACCU0(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_ACCU0_OFFSET(n))
-#define DISPC_OVL_ACCU1(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_ACCU1(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_ACCU1_OFFSET(n))
-#define DISPC_OVL_FIR_COEF_H(n, i)	DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_FIR_COEF_H(n, i)	(DISPC_OVL_BASE(n) + \
 					DISPC_FIR_COEF_H_OFFSET(n, i))
-#define DISPC_OVL_FIR_COEF_HV(n, i)	DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_FIR_COEF_HV(n, i)	(DISPC_OVL_BASE(n) + \
 					DISPC_FIR_COEF_HV_OFFSET(n, i))
-#define DISPC_OVL_CONV_COEF(n, i)	DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_CONV_COEF(n, i)	(DISPC_OVL_BASE(n) + \
 					DISPC_CONV_COEF_OFFSET(n, i))
-#define DISPC_OVL_FIR_COEF_V(n, i)	DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_FIR_COEF_V(n, i)	(DISPC_OVL_BASE(n) + \
 					DISPC_FIR_COEF_V_OFFSET(n, i))
-#define DISPC_OVL_PRELOAD(n)		DISPC_REG(DISPC_OVL_BASE(n) + \
+#define DISPC_OVL_PRELOAD(n)		(DISPC_OVL_BASE(n) + \
 					DISPC_PRELOAD_OFFSET(n))
 
 /* DISPC manager/channel specific registers */
-static inline struct dispc_reg DISPC_DEFAULT_COLOR(enum omap_channel channel)
+static inline u16 DISPC_DEFAULT_COLOR(enum omap_channel channel)
 {
 	switch (channel) {
 	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_REG(0x004C);
+		return 0x004C;
 	case OMAP_DSS_CHANNEL_DIGIT:
-		return DISPC_REG(0x0050);
+		return 0x0050;
 	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_REG(0x03AC);
+		return 0x03AC;
 	default:
 		BUG();
 	}
 }
 
-static inline struct dispc_reg DISPC_TRANS_COLOR(enum omap_channel channel)
+static inline u16 DISPC_TRANS_COLOR(enum omap_channel channel)
 {
 	switch (channel) {
 	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_REG(0x0054);
+		return 0x0054;
 	case OMAP_DSS_CHANNEL_DIGIT:
-		return DISPC_REG(0x0058);
+		return 0x0058;
 	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_REG(0x03B0);
+		return 0x03B0;
 	default:
 		BUG();
 	}
 }
 
-static inline struct dispc_reg DISPC_TIMING_H(enum omap_channel channel)
+static inline u16 DISPC_TIMING_H(enum omap_channel channel)
 {
 	switch (channel) {
 	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_REG(0x0064);
+		return 0x0064;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
 	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_REG(0x0400);
+		return 0x0400;
 	default:
 		BUG();
 	}
 }
 
-static inline struct dispc_reg DISPC_TIMING_V(enum omap_channel channel)
+static inline u16 DISPC_TIMING_V(enum omap_channel channel)
 {
 	switch (channel) {
 	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_REG(0x0068);
+		return 0x0068;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
 	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_REG(0x0404);
+		return 0x0404;
 	default:
 		BUG();
 	}
 }
 
-static inline struct dispc_reg DISPC_POL_FREQ(enum omap_channel channel)
+static inline u16 DISPC_POL_FREQ(enum omap_channel channel)
 {
 	switch (channel) {
 	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_REG(0x006C);
+		return 0x006C;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
 	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_REG(0x0408);
+		return 0x0408;
 	default:
 		BUG();
 	}
 }
 
-static inline struct dispc_reg DISPC_DIVISORo(enum omap_channel channel)
+static inline u16 DISPC_DIVISORo(enum omap_channel channel)
 {
 	switch (channel) {
 	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_REG(0x0070);
+		return 0x0070;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
 	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_REG(0x040C);
+		return 0x040C;
 	default:
 		BUG();
 	}
 }
 
 /* Named as DISPC_SIZE_LCD, DISPC_SIZE_DIGIT and DISPC_SIZE_LCD2 in TRM */
-static inline struct dispc_reg DISPC_SIZE_MGR(enum omap_channel channel)
+static inline u16 DISPC_SIZE_MGR(enum omap_channel channel)
 {
 	switch (channel) {
 	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_REG(0x007C);
+		return 0x007C;
 	case OMAP_DSS_CHANNEL_DIGIT:
-		return DISPC_REG(0x0078);
+		return 0x0078;
 	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_REG(0x03CC);
+		return 0x03CC;
 	default:
 		BUG();
 	}
 }
 
-static inline struct dispc_reg DISPC_DATA_CYCLE1(enum omap_channel channel)
+static inline u16 DISPC_DATA_CYCLE1(enum omap_channel channel)
 {
 	switch (channel) {
 	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_REG(0x01D4);
+		return 0x01D4;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
 	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_REG(0x03C0);
+		return 0x03C0;
 	default:
 		BUG();
 	}
 }
 
-static inline struct dispc_reg DISPC_DATA_CYCLE2(enum omap_channel channel)
+static inline u16 DISPC_DATA_CYCLE2(enum omap_channel channel)
 {
 	switch (channel) {
 	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_REG(0x01D8);
+		return 0x01D8;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
 	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_REG(0x03C4);
+		return 0x03C4;
 	default:
 		BUG();
 	}
 }
 
-static inline struct dispc_reg DISPC_DATA_CYCLE3(enum omap_channel channel)
+static inline u16 DISPC_DATA_CYCLE3(enum omap_channel channel)
 {
 	switch (channel) {
 	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_REG(0x01DC);
+		return 0x01DC;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
 	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_REG(0x03C8);
+		return 0x03C8;
 	default:
 		BUG();
 	}
 }
 
-static inline struct dispc_reg DISPC_CPR_COEF_R(enum omap_channel channel)
+static inline u16 DISPC_CPR_COEF_R(enum omap_channel channel)
 {
 	switch (channel) {
 	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_REG(0x0220);
+		return 0x0220;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
 	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_REG(0x03BC);
+		return 0x03BC;
 	default:
 		BUG();
 	}
 }
 
-static inline struct dispc_reg DISPC_CPR_COEF_G(enum omap_channel channel)
+static inline u16 DISPC_CPR_COEF_G(enum omap_channel channel)
 {
 	switch (channel) {
 	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_REG(0x0224);
+		return 0x0224;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
 	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_REG(0x03B8);
+		return 0x03B8;
 	default:
 		BUG();
 	}
 }
 
-static inline struct dispc_reg DISPC_CPR_COEF_B(enum omap_channel channel)
+static inline u16 DISPC_CPR_COEF_B(enum omap_channel channel)
 {
 	switch (channel) {
 	case OMAP_DSS_CHANNEL_LCD:
-		return DISPC_REG(0x0228);
+		return 0x0228;
 	case OMAP_DSS_CHANNEL_DIGIT:
 		BUG();
 	case OMAP_DSS_CHANNEL_LCD2:
-		return DISPC_REG(0x03B4);
+		return 0x03B4;
 	default:
 		BUG();
 	}
-- 
1.7.1

