From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 1/4] RX51: Add SDRAM configs for different OPPs
Date: Mon, 26 Oct 2009 18:15:23 +0200
Message-ID: <1256573726-29800-2-git-send-email-tero.kristo@nokia.com>
References: <>
 <1256573726-29800-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32962 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbZJZQak (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 12:30:40 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9QGUPRl018879
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 18:30:43 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9QGUKla018261
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 18:30:21 +0200
In-Reply-To: <1256573726-29800-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

This modification is needed by DVFS.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-sdram.c |   84 ++++++++++++++++++--------------
 1 files changed, 47 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-sdram.c b/arch/arm/mach-omap2/board-rx51-sdram.c
index 6f1f33c..78cd5ed 100644
--- a/arch/arm/mach-omap2/board-rx51-sdram.c
+++ b/arch/arm/mach-omap2/board-rx51-sdram.c
@@ -44,7 +44,7 @@ struct sdram_info {
 };
 
 
-struct omap_sdrc_params rx51_sdrc_params[2];
+struct omap_sdrc_params rx51_sdrc_params[4];
 
 static const struct sdram_timings rx51_timings[] = {
 	{
@@ -118,30 +118,28 @@ static unsigned long get_l3_rate(void)
 	return get_core_rate() / (l & 0x03);
 }
 
-
-
-static unsigned long sdrc_get_fclk_period(void)
+static unsigned long sdrc_get_fclk_period(long rate)
 {
 	/* In picoseconds */
-	return 1000000000 / get_l3_rate();
+	return 1000000000 / rate;
 }
 
-static unsigned int sdrc_ps_to_ticks(unsigned int time_ps)
+static unsigned int sdrc_ps_to_ticks(unsigned int time_ps, long rate)
 {
 	unsigned long tick_ps;
 
 	/* Calculate in picosecs to yield more exact results */
-	tick_ps = sdrc_get_fclk_period();
+	tick_ps = sdrc_get_fclk_period(rate);
 
 	return (time_ps + tick_ps - 1) / tick_ps;
 }
 #undef DEBUG
 #ifdef DEBUG
 static int set_sdrc_timing_regval(u32 *regval, int st_bit, int end_bit,
-			       int time, const char *name)
+			       int time, long rate, const char *name)
 #else
 static int set_sdrc_timing_regval(u32 *regval, int st_bit, int end_bit,
-			       int time)
+			       int time, long rate)
 #endif
 {
 	int ticks, mask, nr_bits;
@@ -149,7 +147,7 @@ static int set_sdrc_timing_regval(u32 *regval, int st_bit, int end_bit,
 	if (time == 0)
 		ticks = 0;
 	else
-		ticks = sdrc_ps_to_ticks(time);
+		ticks = sdrc_ps_to_ticks(time, rate);
 	nr_bits = end_bit - st_bit + 1;
 	if (ticks >= 1 << nr_bits)
 		return -1;
@@ -158,42 +156,46 @@ static int set_sdrc_timing_regval(u32 *regval, int st_bit, int end_bit,
 	*regval |= ticks << st_bit;
 #ifdef DEBUG
 	printk("SDRC %s: %i ticks %i ns\n", name, ticks,
-			(unsigned int)sdrc_get_fclk_period() * ticks / 1000);
+			(unsigned int)sdrc_get_fclk_period(rate) * ticks /
+			1000);
 #endif
 
 	return 0;
 }
 
 #ifdef DEBUG
-#define SDRC_SET_ONE(reg, st, end, field) \
-	if (set_sdrc_timing_regval((reg), (st), (end), rx51_timings->field, #field) < 0) \
-		err = -1
+#define SDRC_SET_ONE(reg, st, end, field, rate) \
+	if (set_sdrc_timing_regval((reg), (st), (end), \
+				rx51_timings->field, (rate), #field) < 0) \
+		err = -1;
 #else
-#define SDRC_SET_ONE(reg, st, end, field) \
-	if (set_sdrc_timing_regval((reg), (st), (end), rx51_timings->field) < 0) \
-		err = -1
+#define SDRC_SET_ONE(reg, st, end, field, rate) \
+	if (set_sdrc_timing_regval((reg), (st), (end), \
+				rx51_timings->field, (rate)) < 0) \
+		err = -1;
 #endif
 
-struct omap_sdrc_params *rx51_get_sdram_timings(void)
+static int sdrc_timings(int id, long rate)
 {
 	u32 ticks_per_ms;
 	u32 rfr, l;
-	u32 actim_ctrla, actim_ctrlb;
+	u32 actim_ctrla = 0, actim_ctrlb = 0;
 	u32 rfr_ctrl;
 	int err = 0;
+	long l3_rate = rate / 1000;
 
-	SDRC_SET_ONE(&actim_ctrla,  0,  4, tDAL);
-	SDRC_SET_ONE(&actim_ctrla,  6,  8, tDPL);
-	SDRC_SET_ONE(&actim_ctrla,  9, 11, tRRD);
-	SDRC_SET_ONE(&actim_ctrla, 12, 14, tRCD);
-	SDRC_SET_ONE(&actim_ctrla, 15, 17, tRP);
-	SDRC_SET_ONE(&actim_ctrla, 18, 21, tRAS);
-	SDRC_SET_ONE(&actim_ctrla, 22, 26, tRC);
-	SDRC_SET_ONE(&actim_ctrla, 27, 31, tRFC);
+	SDRC_SET_ONE(&actim_ctrla,  0,  4, tDAL, l3_rate);
+	SDRC_SET_ONE(&actim_ctrla,  6,  8, tDPL, l3_rate);
+	SDRC_SET_ONE(&actim_ctrla,  9, 11, tRRD, l3_rate);
+	SDRC_SET_ONE(&actim_ctrla, 12, 14, tRCD, l3_rate);
+	SDRC_SET_ONE(&actim_ctrla, 15, 17, tRP, l3_rate);
+	SDRC_SET_ONE(&actim_ctrla, 18, 21, tRAS, l3_rate);
+	SDRC_SET_ONE(&actim_ctrla, 22, 26, tRC, l3_rate);
+	SDRC_SET_ONE(&actim_ctrla, 27, 31, tRFC, l3_rate);
 
-	SDRC_SET_ONE(&actim_ctrlb,  0,  7, tXSR);
+	SDRC_SET_ONE(&actim_ctrlb,  0,  7, tXSR, l3_rate);
 
-	ticks_per_ms = sdrc_ps_to_ticks(1000000000);
+	ticks_per_ms = sdrc_ps_to_ticks(1000000000, l3_rate);
 	rfr = rx51_timings[0].tREF * ticks_per_ms / (1 << rx51_info.row_lines);
 	if (rfr > 65535 + 50)
 		rfr = 65535;
@@ -203,16 +205,24 @@ struct omap_sdrc_params *rx51_get_sdram_timings(void)
 	l = rfr << 8;
 	rfr_ctrl = l | 0x3; /* autorefresh, reload counter with 8xARCV */
 
-	rx51_sdrc_params[0].rate = 133333333;
-	rx51_sdrc_params[0].actim_ctrla = actim_ctrla;
-	rx51_sdrc_params[0].actim_ctrlb = actim_ctrlb;
-	rx51_sdrc_params[0].rfr_ctrl = rfr_ctrl;
-	rx51_sdrc_params[0].mr = 0x32;
+	rx51_sdrc_params[id].rate = rate;
+	rx51_sdrc_params[id].actim_ctrla = actim_ctrla;
+	rx51_sdrc_params[id].actim_ctrlb = actim_ctrlb;
+	rx51_sdrc_params[id].rfr_ctrl = rfr_ctrl;
+	rx51_sdrc_params[id].mr = 0x32;
+
+	rx51_sdrc_params[id + 1].rate = 0;
 
-	rx51_sdrc_params[1].rate = 0;
+	return err;
+}
+
+struct omap_sdrc_params *rx51_get_sdram_timings(void)
+{
+	int err;
 
-	if (err < 0)
-		return NULL;
+	err = sdrc_timings(0, 41500000);
+	err = sdrc_timings(1, 83000000);
+	err |= sdrc_timings(2, 166000000);
 
 	return &rx51_sdrc_params[0];
 }
-- 
1.5.4.3

