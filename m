From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: fix clock table walking for OMAP2 variants
Date: Wed, 13 Jun 2007 17:55:58 -0700
Message-ID: <20070614005558.976939568@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The various places where the clock rate_table is walked are not all
checking whether the clock actually exists on the OMAP2 variant.

Among other things, this results in broken rounding for the OMAP2430
since the rounding code can potentially find matching speeds that are
marked as RATE_IN_242X.

It also results in confusing CPUfreq about what the current speed is.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

Index: linux-2.6.21/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-2.6.21.orig/arch/arm/mach-omap2/clock.c
+++ linux-2.6.21/arch/arm/mach-omap2/clock.c
@@ -49,6 +49,7 @@ static struct prcm_config *curr_prcm_set
 static u32 curr_perf_level = PRCM_FULL_SPEED;
 static struct clk *vclk;
 static struct clk *sclk;
+static u8 cpu_mask;
 
 /*-------------------------------------------------------------------------
  * Omap2 specific clock functions
@@ -609,6 +610,8 @@ static long omap2_round_to_table_rate(st
 	highest_rate = -EINVAL;
 
 	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
+		if (!(ptr->flags & cpu_mask))
+			continue;
 		if (ptr->xtal_speed != sys_ck.rate)
 			continue;
 
@@ -996,19 +999,12 @@ static int omap2_clk_set_parent(struct c
 static int omap2_select_table_rate(struct clk * clk, unsigned long rate)
 {
 	u32 flags, cur_rate, done_rate, bypass = 0;
-	u8 cpu_mask = 0;
 	struct prcm_config *prcm;
 	unsigned long found_speed = 0;
 
 	if (clk != &virt_prcm_set)
 		return -EINVAL;
 
-	/* FIXME: Change cpu_is_omap2420() to cpu_is_omap242x() */
-	if (cpu_is_omap2420())
-		cpu_mask = RATE_IN_242X;
-	else if (cpu_is_omap2430())
-		cpu_mask = RATE_IN_243X;
-
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
@@ -1190,9 +1186,16 @@ int __init omap2_clk_init(void)
 		}
 	}
 
+	if (cpu_is_omap242x())
+		cpu_mask = RATE_IN_242X;
+	else if (cpu_is_omap2430())
+		cpu_mask = RATE_IN_243X;
+
 	/* Check the MPU rate set by bootloader */
 	clkrate = omap2_get_dpll_rate(&dpll_ck);
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
 		if (prcm->xtal_speed != sys_ck.rate)
 			continue;
 		if (prcm->dpll_speed <= clkrate)
--
