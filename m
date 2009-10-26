From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 3/4] RX51: SDRC: change timing values to follow generic memory requirements
Date: Mon, 26 Oct 2009 18:15:25 +0200
Message-ID: <1256573726-29800-4-git-send-email-tero.kristo@nokia.com>
References: <>
 <1256573726-29800-1-git-send-email-tero.kristo@nokia.com>
 <1256573726-29800-2-git-send-email-tero.kristo@nokia.com>
 <1256573726-29800-3-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:59787 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbZJZQa5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 12:30:57 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9QGUan3030152
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 11:31:02 -0500
In-Reply-To: <1256573726-29800-3-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Onkalo Samu.P" <samu.p.onkalo@nokia.com>

From: Onkalo Samu.P <samu.p.onkalo@nokia.com>

Current memory parameters are slightly off-spec. Also, a couple of unused
functions removed from code.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-sdram.c |  130 ++++++++++++++++++++++----------
 1 files changed, 91 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-sdram.c b/arch/arm/mach-omap2/board-rx51-sdram.c
index b5d1c55..237b898 100644
--- a/arch/arm/mach-omap2/board-rx51-sdram.c
+++ b/arch/arm/mach-omap2/board-rx51-sdram.c
@@ -1,5 +1,5 @@
 /*
- * SDRC register values for the Samsung K4X1G323PC
+ * SDRC register values for RX51
  *
  * Copyright (C) 2008 Nokia Corporation
  *
@@ -23,7 +23,7 @@
 #include <mach/sdrc.h>
 
 
-/* In picoseconds, except for tREF */
+/* In picoseconds, except for tREF (ns), tXP, tCKE, tWTR (clks) */
 struct sdram_timings {
 	u32 casl;
 	u32 tDAL;
@@ -36,7 +36,11 @@ struct sdram_timings {
 	u32 tRFC;
 	u32 tXSR;
 
-	u32 tREF; /* in ms */
+	u32 tREF; /* in ns */
+
+	u32 tXP;
+	u32 tCKE;
+	u32 tWTR;
 };
 
 struct sdram_info {
@@ -49,22 +53,22 @@ struct omap_sdrc_params rx51_sdrc_params[4];
 static const struct sdram_timings rx51_timings[] = {
 	{
 		.casl = 3,
-		.tDAL = 15000 + 18000,
+		.tDAL = 33000,
 		.tDPL = 15000,
 		.tRRD = 12000,
-		.tRCD = 18000,
+		.tRCD = 22500,
 		.tRP = 18000,
 		.tRAS = 42000,
 		.tRC = 66000,
-		.tRFC = 97500,
-		.tXSR = 120000,
+		.tRFC = 138000,
+		.tXSR = 200000,
 
-		.tREF = 64,
-	},
-};
+		.tREF = 7800,
 
-static const struct sdram_info rx51_info = {
-	.row_lines = 13,
+		.tXP = 2,
+		.tCKE = 2,
+		.tWTR = 2
+	},
 };
 
 static unsigned long sdrc_get_fclk_period(long rate)
@@ -85,18 +89,14 @@ static unsigned int sdrc_ps_to_ticks(unsigned int time_ps, long rate)
 #undef DEBUG
 #ifdef DEBUG
 static int set_sdrc_timing_regval(u32 *regval, int st_bit, int end_bit,
-			       int time, long rate, const char *name)
+				int ticks, long rate, const char *name)
 #else
 static int set_sdrc_timing_regval(u32 *regval, int st_bit, int end_bit,
-			       int time, long rate)
+			       int ticks)
 #endif
 {
-	int ticks, mask, nr_bits;
+	int mask, nr_bits;
 
-	if (time == 0)
-		ticks = 0;
-	else
-		ticks = sdrc_ps_to_ticks(time, rate);
 	nr_bits = end_bit - st_bit + 1;
 	if (ticks >= 1 << nr_bits)
 		return -1;
@@ -104,7 +104,7 @@ static int set_sdrc_timing_regval(u32 *regval, int st_bit, int end_bit,
 	*regval &= ~(mask << st_bit);
 	*regval |= ticks << st_bit;
 #ifdef DEBUG
-	printk("SDRC %s: %i ticks %i ns\n", name, ticks,
+	printk(KERN_INFO "SDRC %s: %i ticks %i ns\n", name, ticks,
 			(unsigned int)sdrc_get_fclk_period(rate) * ticks /
 			1000);
 #endif
@@ -113,46 +113,98 @@ static int set_sdrc_timing_regval(u32 *regval, int st_bit, int end_bit,
 }
 
 #ifdef DEBUG
-#define SDRC_SET_ONE(reg, st, end, field, rate) \
-	if (set_sdrc_timing_regval((reg), (st), (end), \
+#define SDRC_SET_ONE(reg, st, end, field, rate)				  \
+	if (set_sdrc_timing_regval((reg), (st), (end),			  \
 				rx51_timings->field, (rate), #field) < 0) \
 		err = -1;
 #else
-#define SDRC_SET_ONE(reg, st, end, field, rate) \
-	if (set_sdrc_timing_regval((reg), (st), (end), \
-				rx51_timings->field, (rate)) < 0) \
+#define SDRC_SET_ONE(reg, st, end, field, rate)				\
+	if (set_sdrc_timing_regval((reg), (st), (end),			\
+				rx51_timings->field, (rate)) < 0)	\
+		err = -1;
+#endif
+
+#ifdef DEBUG
+static int set_sdrc_timing_regval_ps(u32 *regval, int st_bit, int end_bit,
+				int time, long rate, const char *name)
+#else
+static int set_sdrc_timing_regval_ps(u32 *regval, int st_bit, int end_bit,
+				int time, long rate)
+#endif
+{
+	int ticks, ret;
+	ret = 0;
+
+	if (time == 0)
+		ticks = 0;
+	else
+		ticks = sdrc_ps_to_ticks(time, rate);
+
+#ifdef DEBUG
+	ret = set_sdrc_timing_regval(regval, st_bit, end_bit, ticks,
+				     rate, name);
+#else
+	ret = set_sdrc_timing_regval(regval, st_bit, end_bit, ticks);
+#endif
+
+	return ret;
+}
+
+#ifdef DEBUG
+#define SDRC_SET_ONE_PS(reg, st, end, field, rate)			\
+	if (set_sdrc_timing_regval_ps((reg), (st), (end),		\
+					rx51_timings->field,		\
+					(rate), #field) < 0)		\
+		err = -1;
+
+#else
+#define SDRC_SET_ONE_PS(reg, st, end, field, rate)			  \
+	if (set_sdrc_timing_regval_ps((reg), (st), (end),		  \
+					rx51_timings->field, (rate)) < 0) \
 		err = -1;
 #endif
 
 static int sdrc_timings(int id, long rate)
 {
-	u32 ticks_per_ms;
+	u32 ticks_per_us;
 	u32 rfr, l;
 	u32 actim_ctrla = 0, actim_ctrlb = 0;
 	u32 rfr_ctrl;
 	int err = 0;
 	long l3_rate = rate / 1000;
 
-	SDRC_SET_ONE(&actim_ctrla,  0,  4, tDAL, l3_rate);
-	SDRC_SET_ONE(&actim_ctrla,  6,  8, tDPL, l3_rate);
-	SDRC_SET_ONE(&actim_ctrla,  9, 11, tRRD, l3_rate);
-	SDRC_SET_ONE(&actim_ctrla, 12, 14, tRCD, l3_rate);
-	SDRC_SET_ONE(&actim_ctrla, 15, 17, tRP, l3_rate);
-	SDRC_SET_ONE(&actim_ctrla, 18, 21, tRAS, l3_rate);
-	SDRC_SET_ONE(&actim_ctrla, 22, 26, tRC, l3_rate);
-	SDRC_SET_ONE(&actim_ctrla, 27, 31, tRFC, l3_rate);
+#ifdef DEBUG
+	printk(KERN_INFO "SDRC CLK rate: %i MHz\n", (int)l3_rate/1000);
+#endif
+
+	SDRC_SET_ONE_PS(&actim_ctrla,  0,  4, tDAL, l3_rate);
+	SDRC_SET_ONE_PS(&actim_ctrla,  6,  8, tDPL, l3_rate);
+	SDRC_SET_ONE_PS(&actim_ctrla,  9, 11, tRRD, l3_rate);
+	SDRC_SET_ONE_PS(&actim_ctrla, 12, 14, tRCD, l3_rate);
+	SDRC_SET_ONE_PS(&actim_ctrla, 15, 17, tRP, l3_rate);
+	SDRC_SET_ONE_PS(&actim_ctrla, 18, 21, tRAS, l3_rate);
+	SDRC_SET_ONE_PS(&actim_ctrla, 22, 26, tRC, l3_rate);
+	SDRC_SET_ONE_PS(&actim_ctrla, 27, 31, tRFC, l3_rate);
 
-	SDRC_SET_ONE(&actim_ctrlb,  0,  7, tXSR, l3_rate);
+	SDRC_SET_ONE_PS(&actim_ctrlb,  0,  7, tXSR, l3_rate);
 
-	ticks_per_ms = sdrc_ps_to_ticks(1000000000, l3_rate);
-	rfr = rx51_timings[0].tREF * ticks_per_ms / (1 << rx51_info.row_lines);
+	SDRC_SET_ONE(&actim_ctrlb,  8,  10, tXP, l3_rate);
+	SDRC_SET_ONE(&actim_ctrlb,  12,  14, tCKE, l3_rate);
+	SDRC_SET_ONE(&actim_ctrlb,  16,  17, tWTR, l3_rate);
+
+	ticks_per_us = sdrc_ps_to_ticks(1000000, l3_rate);
+	rfr = rx51_timings[0].tREF * ticks_per_us / 1000;
 	if (rfr > 65535 + 50)
 		rfr = 65535;
 	else
 		rfr -= 50;
 
+#ifdef DEBUG
+	printk(KERN_INFO "SDRC tREF: %i ticks\n", rfr);
+#endif
+
 	l = rfr << 8;
-	rfr_ctrl = l | 0x3; /* autorefresh, reload counter with 8xARCV */
+	rfr_ctrl = l | 0x1; /* autorefresh, reload counter with 1xARCV */
 
 	rx51_sdrc_params[id].rate = rate;
 	rx51_sdrc_params[id].actim_ctrla = actim_ctrla;
@@ -170,7 +222,7 @@ struct omap_sdrc_params *rx51_get_sdram_timings(void)
 	int err;
 
 	err = sdrc_timings(0, 41500000);
-	err = sdrc_timings(1, 83000000);
+	err |= sdrc_timings(1, 83000000);
 	err |= sdrc_timings(2, 166000000);
 
 	return &rx51_sdrc_params[0];
-- 
1.5.4.3

