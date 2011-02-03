From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH 2/4] OMAP: DSS2: Renaming register macro DISPC_DIVISOR(ch)
Date: Thu,  3 Feb 2011 19:39:19 +0530
Message-ID: <1296742161-9395-3-git-send-email-raghuveer.murthy@ti.com>
References: <1296742161-9395-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34561 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932186Ab1BCOOr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 09:14:47 -0500
In-Reply-To: <1296742161-9395-1-git-send-email-raghuveer.murthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomba@iki.fi
Cc: linux-omap@vger.kernel.org

Renamed DISPC_DIVISOR(ch) to DISPC_DIVISORo(ch), to facilitate introduction
of DISPC_DIVISOR register, which is specific for OMAP4. OMAP4 has 3 registers
DISPC_DIVISOR, DISPC_DIVISOR1 and DISPC_DIVISOR2.

Also updated, all the usages of DISPC_DIVISOR(ch) to DISPC_DIVISORo(ch).

OMAP4 TRM uses DISPC_DIVISORo generically to refer to DISPC_DIVISOR1 and
DISPC_DIVISOR2

Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index cc58208..e52a413 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -72,7 +72,12 @@ struct dispc_reg { u16 idx; };
 #define DISPC_TIMING_H(ch)		DISPC_REG(ch != 2 ? 0x0064 : 0x0400)
 #define DISPC_TIMING_V(ch)		DISPC_REG(ch != 2 ? 0x0068 : 0x0404)
 #define DISPC_POL_FREQ(ch)		DISPC_REG(ch != 2 ? 0x006C : 0x0408)
-#define DISPC_DIVISOR(ch)		DISPC_REG(ch != 2 ? 0x0070 : 0x040C)
+/*
+ * Use DISPC_DIVISORo(ch) when DISPC_DIVISOR1 or DISPC_DIVISOR2 has to be
+ * configured. OMAP4 TRM uses DISPC_DIVISORo generically to refer DISPC_DIVISOR1
+ * and DISPC_DIVISOR2
+ */
+#define DISPC_DIVISORo(ch)		DISPC_REG(ch != 2 ? 0x0070 : 0x040C)
 #define DISPC_GLOBAL_ALPHA		DISPC_REG(0x0074)
 #define DISPC_SIZE_DIG			DISPC_REG(0x0078)
 #define DISPC_SIZE_LCD(ch)		DISPC_REG(ch != 2 ? 0x007C : 0x03CC)
@@ -229,7 +234,7 @@ void dispc_save_context(void)
 	SR(TIMING_H(0));
 	SR(TIMING_V(0));
 	SR(POL_FREQ(0));
-	SR(DIVISOR(0));
+	SR(DIVISORo(0));
 	SR(GLOBAL_ALPHA);
 	SR(SIZE_DIG);
 	SR(SIZE_LCD(0));
@@ -241,7 +246,7 @@ void dispc_save_context(void)
 		SR(TIMING_H(2));
 		SR(TIMING_V(2));
 		SR(POL_FREQ(2));
-		SR(DIVISOR(2));
+		SR(DIVISORo(2));
 		SR(CONFIG2);
 	}
 
@@ -388,7 +393,7 @@ void dispc_restore_context(void)
 	RR(TIMING_H(0));
 	RR(TIMING_V(0));
 	RR(POL_FREQ(0));
-	RR(DIVISOR(0));
+	RR(DIVISORo(0));
 	RR(GLOBAL_ALPHA);
 	RR(SIZE_DIG);
 	RR(SIZE_LCD(0));
@@ -399,7 +404,7 @@ void dispc_restore_context(void)
 		RR(TIMING_H(2));
 		RR(TIMING_V(2));
 		RR(POL_FREQ(2));
-		RR(DIVISOR(2));
+		RR(DIVISORo(2));
 		RR(CONFIG2);
 	}
 
@@ -2292,7 +2297,7 @@ static void dispc_set_lcd_divisor(enum omap_channel channel, u16 lck_div,
 	BUG_ON(pck_div < 2);
 
 	enable_clocks(1);
-	dispc_write_reg(DISPC_DIVISOR(channel),
+	dispc_write_reg(DISPC_DIVISORo(channel),
 			FLD_VAL(lck_div, 23, 16) | FLD_VAL(pck_div, 7, 0));
 	enable_clocks(0);
 }
@@ -2301,7 +2306,7 @@ static void dispc_get_lcd_divisor(enum omap_channel channel, int *lck_div,
 		int *pck_div)
 {
 	u32 l;
-	l = dispc_read_reg(DISPC_DIVISOR(channel));
+	l = dispc_read_reg(DISPC_DIVISORo(channel));
 	*lck_div = FLD_GET(l, 23, 16);
 	*pck_div = FLD_GET(l, 7, 0);
 }
@@ -2327,7 +2332,7 @@ unsigned long dispc_lclk_rate(enum omap_channel channel)
 	unsigned long r;
 	u32 l;
 
-	l = dispc_read_reg(DISPC_DIVISOR(channel));
+	l = dispc_read_reg(DISPC_DIVISORo(channel));
 
 	lcd = FLD_GET(l, 23, 16);
 
@@ -2342,7 +2347,7 @@ unsigned long dispc_pclk_rate(enum omap_channel channel)
 	unsigned long r;
 	u32 l;
 
-	l = dispc_read_reg(DISPC_DIVISOR(channel));
+	l = dispc_read_reg(DISPC_DIVISORo(channel));
 
 	lcd = FLD_GET(l, 23, 16);
 	pcd = FLD_GET(l, 7, 0);
@@ -2458,7 +2463,7 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_TIMING_H(0));
 	DUMPREG(DISPC_TIMING_V(0));
 	DUMPREG(DISPC_POL_FREQ(0));
-	DUMPREG(DISPC_DIVISOR(0));
+	DUMPREG(DISPC_DIVISORo(0));
 	DUMPREG(DISPC_GLOBAL_ALPHA);
 	DUMPREG(DISPC_SIZE_DIG);
 	DUMPREG(DISPC_SIZE_LCD(0));
@@ -2470,7 +2475,7 @@ void dispc_dump_regs(struct seq_file *s)
 		DUMPREG(DISPC_TIMING_H(2));
 		DUMPREG(DISPC_TIMING_V(2));
 		DUMPREG(DISPC_POL_FREQ(2));
-		DUMPREG(DISPC_DIVISOR(2));
+		DUMPREG(DISPC_DIVISORo(2));
 		DUMPREG(DISPC_SIZE_LCD(2));
 	}
 
@@ -2712,8 +2717,8 @@ int dispc_get_clock_div(enum omap_channel channel,
 
 	fck = dispc_fclk_rate();
 
-	cinfo->lck_div = REG_GET(DISPC_DIVISOR(channel), 23, 16);
-	cinfo->pck_div = REG_GET(DISPC_DIVISOR(channel), 7, 0);
+	cinfo->lck_div = REG_GET(DISPC_DIVISORo(channel), 23, 16);
+	cinfo->pck_div = REG_GET(DISPC_DIVISORo(channel), 7, 0);
 
 	cinfo->lck = fck / cinfo->lck_div;
 	cinfo->pck = cinfo->lck / cinfo->pck_div;
-- 
1.7.0.4

