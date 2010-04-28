From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 1/2] omap: gpmc: add gpmc_cs_get_timings
Date: Wed, 28 Apr 2010 19:06:04 +0300
Message-ID: <3c93c09ed4d293ff959b7bef1911ee73b4d0ec12.1272470212.git.mike@compulab.co.il>
References: <cover.1272470212.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:48293 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878Ab0D1QHi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Apr 2010 12:07:38 -0400
In-Reply-To: <cover.1272470212.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: s-ghorai@ti.com, linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

Add gpmc_cs_get_timings counterpart of gpmc_cs_set_timings and
convinience macros to read particular timing configuration fields

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/gpmc.c             |   79 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc.h |    1 +
 2 files changed, 80 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 5bc3ca0..416336f 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -163,6 +163,36 @@ unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns)
 }
 
 #ifdef DEBUG
+static int get_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
+			       const char *name)
+#else
+static int get_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit)
+#endif
+{
+	u32 l;
+	int ticks, mask, nr_bits, time;
+
+	nr_bits = end_bit - st_bit + 1;
+	mask = ((1 << nr_bits) - 1);
+
+	l = gpmc_cs_read_reg(cs, reg);
+	ticks = (l >> st_bit) & mask;
+
+	if (ticks == 0)
+		time = 0;
+	else
+		time = gpmc_ticks_to_ns(ticks);
+
+#ifdef DEBUG
+	printk(KERN_INFO
+		"GPMC CS%d: %-10s: %3d ticks, %3d ns\n",
+	       cs, name, ticks, time);
+#endif
+
+	return time;
+}
+
+#ifdef DEBUG
 static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 			       int time, const char *name)
 #else
@@ -206,10 +236,14 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 	if (set_gpmc_timing_reg(cs, (reg), (st), (end),		\
 			t->field, #field) < 0)			\
 		return -1
+#define GPMC_GET_ONE(reg, st, end, field) \
+	t->field = get_gpmc_timing_reg(cs, (reg), (st), (end), #field)
 #else
 #define GPMC_SET_ONE(reg, st, end, field) \
 	if (set_gpmc_timing_reg(cs, (reg), (st), (end), t->field) < 0) \
 		return -1
+#define GPMC_GET_ONE(reg, st, end, field) \
+	t->field = get_gpmc_timing_reg(cs, (reg), (st), (end))
 #endif
 
 int gpmc_cs_calc_divider(int cs, unsigned int sync_clk)
@@ -227,6 +261,51 @@ int gpmc_cs_calc_divider(int cs, unsigned int sync_clk)
 	return div;
 }
 
+void gpmc_cs_get_timings(int cs, struct gpmc_timings *t)
+{
+	int div;
+	u32 l;
+
+	GPMC_GET_ONE(GPMC_CS_CONFIG2,  0,  3, cs_on);
+	GPMC_GET_ONE(GPMC_CS_CONFIG2,  8, 12, cs_rd_off);
+	GPMC_GET_ONE(GPMC_CS_CONFIG2, 16, 20, cs_wr_off);
+
+	GPMC_GET_ONE(GPMC_CS_CONFIG3,  0,  3, adv_on);
+	GPMC_GET_ONE(GPMC_CS_CONFIG3,  8, 12, adv_rd_off);
+	GPMC_GET_ONE(GPMC_CS_CONFIG3, 16, 20, adv_wr_off);
+
+	GPMC_GET_ONE(GPMC_CS_CONFIG4,  0,  3, oe_on);
+	GPMC_GET_ONE(GPMC_CS_CONFIG4,  8, 12, oe_off);
+	GPMC_GET_ONE(GPMC_CS_CONFIG4, 16, 19, we_on);
+	GPMC_GET_ONE(GPMC_CS_CONFIG4, 24, 28, we_off);
+
+	GPMC_GET_ONE(GPMC_CS_CONFIG5,  0,  4, rd_cycle);
+	GPMC_GET_ONE(GPMC_CS_CONFIG5,  8, 12, wr_cycle);
+	GPMC_GET_ONE(GPMC_CS_CONFIG5, 16, 20, access);
+
+	GPMC_GET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
+
+	if (cpu_is_omap34xx()) {
+		GPMC_GET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
+		GPMC_GET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
+	}
+
+	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+	if (l & (GPMC_CONFIG1_READTYPE_SYNC | GPMC_CONFIG1_WRITETYPE_SYNC)) {
+		div = (l & 0x03) + 1;
+#ifdef DEBUG
+		printk(KERN_INFO "GPMC CS%d CLK period is %lu ns (div %d)\n",
+				cs, (div * gpmc_get_fclk_period()) / 1000, div);
+#endif
+		t->sync_clk = (div * gpmc_get_fclk_period()) / 1000;
+	} else {
+		t->sync_clk = 0;
+	}
+
+	gpmc_dump_regs(cs);
+	gpmc_dump_timings(t);
+}
+
 int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 {
 	int div;
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 145838a..5c345f1 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -102,6 +102,7 @@ extern void gpmc_cs_write_reg(int cs, int idx, u32 val);
 extern u32 gpmc_cs_read_reg(int cs, int idx);
 extern int gpmc_cs_calc_divider(int cs, unsigned int sync_clk);
 extern int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t);
+extern void gpmc_cs_get_timings(int cs, struct gpmc_timings *t);
 extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
 extern void gpmc_cs_free(int cs);
 extern int gpmc_cs_set_reserved(int cs, int reserved);
-- 
1.6.6.2

