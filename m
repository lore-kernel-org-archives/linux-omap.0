From: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
Subject: [PATCH 8/8 v2] ARM OMAP2+ GPMC: fix WAITMONITORINGTIME divider bug
Date: Tue, 24 Feb 2015 21:05:30 +0100
Message-ID: <1424808331-17592-8-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1424808331-17592-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-2-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-4-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-5-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-6-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1424808331-17592-7-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424808331-17592-7-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
List-Id: linux-omap@vger.kernel.org

The WAITMONITORINGTIME is expressed as a number of GPMC_CLK clock cycles,
even though the access is defined as asynchronous, and no GPMC_CLK clock
is provided to the external device. Still, GPMCFCLKDIVIDER is used as a divider
for the GPMC clock, so it must be programmed to define the
correct WAITMONITORINGTIME delay.

This patch correctly computes WAITMONITORINGTIME in GPMC_CLK cycles instead of GPMC_FCLK cycles,
both during programming (gpmc_cs_set_timings) and during retrieval (gpmc_cs_show_timings).

Signed-off-by: Robert ABEL <rabel@cit-ec.uni-bielefeld.de>
---
 drivers/memory/omap-gpmc.c | 125 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 99 insertions(+), 26 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 9cf8d21..6591991 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -170,6 +170,11 @@
  */
 #define	GPMC_NR_IRQ		2
 
+enum gpmc_clk_domain {
+	GPMC_CD_FCLK,
+	GPMC_CD_CLK
+};
+
 struct gpmc_cs_data {
 	const char *name;
 
@@ -268,16 +273,55 @@ static unsigned long gpmc_get_fclk_period(void)
 	return rate;
 }
 
-static unsigned int gpmc_ns_to_ticks(unsigned int time_ns)
+/**
+ * gpmc_get_clk_period - get period of selected clock domain in ps
+ * @cs Chip Select Region.
+ * @cd Clock Domain.
+ *
+ * GPMC_CS_CONFIG1 GPMCFCLKDIVIDER for cs has to be setup
+ * prior to calling this function with GPMC_CD_CLK.
+ * 
+ */
+static unsigned long gpmc_get_clk_period(int cs, enum gpmc_clk_domain cd)
+{
+
+	unsigned long tick_ps = gpmc_get_fclk_period();
+	u32 l;
+	int div;
+
+	switch (cd) {
+	case GPMC_CD_CLK:
+		/* get current clk divider */
+		l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+		div = (l & 0x03) + 1;
+		/* get GPMC_CLK period */
+		tick_ps *= div;
+		break;
+	case GPMC_CD_FCLK:
+		/* FALL-THROUGH */
+	default:
+		break;
+	}
+
+	return tick_ps;
+
+}
+
+static unsigned int gpmc_ns_to_clk_ticks(unsigned int time_ns, int cs, enum gpmc_clk_domain cd)
 {
 	unsigned long tick_ps;
 
 	/* Calculate in picosecs to yield more exact results */
-	tick_ps = gpmc_get_fclk_period();
+	tick_ps = gpmc_get_clk_period(cs, cd);
 
 	return (time_ns * 1000 + tick_ps - 1) / tick_ps;
 }
 
+static unsigned int gpmc_ns_to_ticks(unsigned int time_ns)
+{
+	return gpmc_ns_to_clk_ticks(time_ns, /* any CS */ 0, GPMC_CD_FCLK);
+}
+
 static unsigned int gpmc_ps_to_ticks(unsigned int time_ps)
 {
 	unsigned long tick_ps;
@@ -288,9 +332,14 @@ static unsigned int gpmc_ps_to_ticks(unsigned int time_ps)
 	return (time_ps + tick_ps - 1) / tick_ps;
 }
 
+unsigned int gpmc_clk_ticks_to_ns(unsigned ticks, int cs, enum gpmc_clk_domain cd)
+{
+	return ticks * gpmc_get_clk_period(cs, cd) / 1000;
+}
+
 unsigned int gpmc_ticks_to_ns(unsigned int ticks)
 {
-	return ticks * gpmc_get_fclk_period() / 1000;
+	return gpmc_clk_ticks_to_ns(ticks, /* any CS */ 0, GPMC_CD_FCLK);
 }
 
 static unsigned int gpmc_ticks_to_ps(unsigned int ticks)
@@ -346,16 +395,22 @@ static void gpmc_cs_bool_timings(int cs, const struct gpmc_bool_timings *p)
  * @st_bit  Start Bit
  * @end_bit End Bit. Must be >= @st_bit.
  * @name    DTS node name, w/o "gpmc,"
+ * @cd      Clock Domain of timing parameter.
+ * @shift   Parameter value left shifts @shift, which is then printed instead of value.
  * @raw     Raw Format Option.
  *          raw format:  gpmc,name = <value>
  *          tick format: gpmc,name = <value> /&zwj;* x ticks *&zwj;/
  * @noval   Parameter values equal to 0 are not printed.
- * @shift   Parameter value left shifts @shift, which is then printed instead of value.
  *
  */
-static int get_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
-			       bool raw, bool noval, int shift,
-			       const char *name)
+static int get_gpmc_timing_reg(
+	/* timing specifiers */
+	int cs, int reg, int st_bit, int end_bit,
+	const char *name, const enum gpmc_clk_domain cd,
+	/* value transform */
+	int shift,
+	/* format specifiers */
+	bool raw, bool noval)
 {
 	u32 l;
 	int nr_bits;
@@ -373,7 +428,7 @@ static int get_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 		/* DTS tick format for timings in ns */
 		unsigned int time_ns;
 
-		time_ns = gpmc_ticks_to_ns(l);
+		time_ns = gpmc_clk_ticks_to_ns(l, cs, cd);
 		pr_info("gpmc,%s = <%u> /* %i ticks */\n",
 			name, time_ns, l);
 	} else {
@@ -388,13 +443,15 @@ static int get_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 	pr_info("cs%i %s: 0x%08x\n", cs, #config, \
 		gpmc_cs_read_reg(cs, config))
 #define GPMC_GET_RAW(reg, st, end, field) \
-	get_gpmc_timing_reg(cs, (reg), (st), (end), 1, 0, 0, field)
+	get_gpmc_timing_reg(cs, (reg), (st), (end), field, GPMC_CD_FCLK, 0, 1, 0)
 #define GPMC_GET_RAW_BOOL(reg, st, end, field) \
-	get_gpmc_timing_reg(cs, (reg), (st), (end), 1, 1, 0, field)
+	get_gpmc_timing_reg(cs, (reg), (st), (end), field, GPMC_CD_FCLK, 0, 1, 1)
 #define GPMC_GET_RAW_SHIFT(reg, st, end, shift, field) \
-	get_gpmc_timing_reg(cs, (reg), (st), (end), 1, 1, (shift), field)
+	get_gpmc_timing_reg(cs, (reg), (st), (end), field, GPMC_CD_FCLK, (shift), 1, 1)
 #define GPMC_GET_TICKS(reg, st, end, field) \
-	get_gpmc_timing_reg(cs, (reg), (st), (end), 0, 0, 0, field)
+	get_gpmc_timing_reg(cs, (reg), (st), (end), field, GPMC_CD_FCLK, 0, 0, 0)
+#define GPMC_GET_TICKS_CD(reg, st, end, field, cd) \
+	get_gpmc_timing_reg(cs, (reg), (st), (end), field, (cd), 0, 0, 0)
 
 static void gpmc_show_regs(int cs, const char *desc)
 {
@@ -462,7 +519,7 @@ static void gpmc_cs_show_timings(int cs, const char *desc)
 	GPMC_GET_TICKS(GPMC_CS_CONFIG6, 0, 3, "bus-turnaround-ns");
 	GPMC_GET_TICKS(GPMC_CS_CONFIG6, 8, 11, "cycle2cycle-delay-ns");
 
-	GPMC_GET_TICKS(GPMC_CS_CONFIG1, 18, 19, "wait-monitoring-ns");
+	GPMC_GET_TICKS_CD(GPMC_CS_CONFIG1, 18, 19, "wait-monitoring-ns", GPMC_CD_CLK);
 	GPMC_GET_TICKS(GPMC_CS_CONFIG1, 25, 26, "clk-activation-ns");
 
 	GPMC_GET_TICKS(GPMC_CS_CONFIG6, 16, 19, "wr-data-mux-bus-ns");
@@ -474,8 +531,20 @@ static inline void gpmc_cs_show_timings(int cs, const char *desc)
 }
 #endif
 
+/**
+ * set_gpmc_timing_reg - set a single timing parameter for Chip Select Region.
+ * @cs      Chip Select Region.
+ * @reg     GPMC_CS_CONFIGn register offset.
+ * @st_bit  Start Bit
+ * @end_bit End Bit. Must be >= @st_bit.
+ * @time    Timing parameter in ns.
+ * @cd      Timing parameter clock domain.
+ * @name    Timing parameter name.
+ * @note    Caller is expected to have initialized CONFIG1 GPMCFCLKDIVIDER
+ *          prior to calling this function with @cd equal to GPMC_CD_CLK.
+ */
 static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
-			       int time, const char *name)
+			       int time, enum gpmc_clk_domain cd, const char *name)
 {
 	u32 l;
 	int ticks, mask, nr_bits;
@@ -483,12 +552,12 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 	if (time == 0)
 		ticks = 0;
 	else
-		ticks = gpmc_ns_to_ticks(time);
+		ticks = gpmc_ns_to_clk_ticks(time, cs, cd);
 	nr_bits = end_bit - st_bit + 1;
 	mask = (1 << nr_bits) - 1;
 
 	if (ticks > mask) {
-		pr_err("%s: GPMC error! CS%d: %s: %d ns, %d ticks > %d\n",
+		pr_err("%s: GPMC CS%d: %s %d ns, %d ticks > %d ticks\n",
 		       __func__, cs, name, time, ticks, mask);
 
 		return -1;
@@ -498,7 +567,7 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 #ifdef DEBUG
 	printk(KERN_INFO
 		"GPMC CS%d: %-17s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
-	       cs, name, ticks, gpmc_get_fclk_period() * ticks / 1000,
+	       cs, name, ticks, gpmc_get_clk_period(cs, cd) * ticks / 1000,
 			(l >> st_bit) & mask, time);
 #endif
 	l &= ~(mask << st_bit);
@@ -508,11 +577,14 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 	return 0;
 }
 
-#define GPMC_SET_ONE(reg, st, end, field) \
-	if (set_gpmc_timing_reg(cs, (reg), (st), (end),		\
-			t->field, #field) < 0)			\
+#define GPMC_SET_ONE_CD(reg, st, end, field, cd) \
+	if (set_gpmc_timing_reg(cs, (reg), (st), (end), \
+	    t->field, (cd), #field) < 0)                \
 		return -1
 
+#define GPMC_SET_ONE(reg, st, end, field) \
+	GPMC_SET_ONE_CD(reg, st, end, field, GPMC_CD_FCLK)
+
 /**
  * gpmc_calc_waitmonitoring_divider - calculate proper GPMCFCLKDIVIDER based on WAITMONITORINGTIME
  * @wait_monitoring WAITMONITORINGTIME in ns.
@@ -620,22 +692,23 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t, const struct gpmc_
 	GPMC_SET_ONE(GPMC_CS_CONFIG6, 0, 3, bus_turnaround);
 	GPMC_SET_ONE(GPMC_CS_CONFIG6, 8, 11, cycle2cycle_delay);
 
-	GPMC_SET_ONE(GPMC_CS_CONFIG1, 18, 19, wait_monitoring);
-	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
-
 	if (gpmc_capability & GPMC_HAS_WR_DATA_MUX_BUS)
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
 	if (gpmc_capability & GPMC_HAS_WR_ACCESS)
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
 
 	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+	l &= ~0x03;
+	l |= (div - 1);
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
+
+	GPMC_SET_ONE_CD(GPMC_CS_CONFIG1, 18, 19, wait_monitoring, GPMC_CD_CLK);
+	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
+
 #ifdef DEBUG
 	printk(KERN_INFO "GPMC CS%d CLK period is %lu ns (div %d)\n",
 			cs, (div * gpmc_get_fclk_period()) / 1000, div);
 #endif
-	l &= ~0x03;
-	l |= (div - 1);
-	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
 
 	gpmc_cs_bool_timings(cs, &t->bool_timings);
 	gpmc_cs_show_timings(cs, "after gpmc_cs_set_timings");
-- 
2.3.0
