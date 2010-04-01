From: Pramod Gurav <pramod.gurav@ti.com>
Subject: [PATCH v4 1/2] OMAP3: SDRC: Dynamic Calculation of SDRC stall latency during DVFS
Date: Fri,  2 Apr 2010 01:16:55 +0800
Message-ID: <1270142216-18118-2-git-send-email-pramod.gurav@ti.com>
References: <>
 <1270142216-18118-1-git-send-email-pramod.gurav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55330 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755424Ab0DALjg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Apr 2010 07:39:36 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o31BdXDx005373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 1 Apr 2010 06:39:35 -0500
In-Reply-To: <1270142216-18118-1-git-send-email-pramod.gurav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Teerth Reddy <teerth@ti.com>, Romit Dasgupta <romit@ti.com>, Pramod Gurav <pramod.gurav@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Ambresh K <ambresh@ti.com>

From: Teerth Reddy <teerth@ti.com> 

The patch has the changes to calculate the dpll3 clock stabilization
delay dynamically. The SRAM delay is calibrated during bootup using the
gptimers and used while calculating the stabilization delay. By using
the dynamic method the dependency on the type of cache being used is
removed. Hence there is no need of loop based calculation.

The wait time for L3 clock stabilization is calculated using the formula
	= 4*REFCLK + 8*CLKOUTX2,
which uses the M, N and M2 read from the registers.
Since this gives slightly less value, 2us is added as buffer for safety.
This works fine for omap3.

Signed-off-by: Teerth Reddy <teerth@ti.com>
Signed-off-by: Romit Dasgupta <romit@ti.com>
Signed-off-by: Pramod Gurav <pramod.gurav@ti.com>
Signed-off-by: Vishwanath Sripathy <vishwanath.bs@ti.com>
Signed-off-by: Ambresh K <ambresh@ti.com>

---
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |   56 +++++++++++++++++++++++++------
 arch/arm/mach-omap2/clock34xx.h        |    2 +
 arch/arm/mach-omap2/clock3xxx.c        |    2 +-
 arch/arm/mach-omap2/clock3xxx.h        |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c   |   13 +++++++
 arch/arm/mach-omap2/sram34xx.S         |    8 ++++
 arch/arm/plat-omap/include/plat/sram.h |    4 ++
 arch/arm/plat-omap/sram.c              |   51 +++++++++++++++++++++++++++++
 8 files changed, 125 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index b2b1e37..6ad18f2 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -24,13 +24,22 @@
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
+#include <plat/prcm.h>
 
 #include "clock.h"
 #include "clock3xxx.h"
 #include "clock34xx.h"
 #include "sdrc.h"
 
-#define CYCLES_PER_MHZ			1000000
+#define		CYCLES_PER_MHZ		1000000
+
+#define		DPLL_M_MASK		0x7ff
+#define		DPLL_N_MASK		0x7f
+#define		DPLL_M2_MASK		0x1f
+#define		SHIFT_DPLL_M		16
+#define		SHIFT_DPLL_N		8
+#define		SHIFT_DPLL_M2		27
+#define		SCALING_FACTOR		10
 
 /*
  * CORE DPLL (DPLL3) M2 divider rate programming functions
@@ -51,10 +60,14 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 {
 	u32 new_div = 0;
 	u32 unlock_dll = 0;
-	u32 c;
-	unsigned long validrate, sdrcrate, _mpurate;
+	u32 c, delay_sram;
+	u32 clk_sel_regval, sys_clk;
+	u32 m, n, m2;
+	u32 sys_clk_rate, sdrc_clk_stab;
+	u32 refclk, clkoutx2, switch_latency;
 	struct omap_sdrc_params *sdrc_cs0;
 	struct omap_sdrc_params *sdrc_cs1;
+	unsigned long validrate, sdrcrate, _mpurate;
 	int ret;
 
 	if (!clk || !rate)
@@ -79,16 +92,37 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 		unlock_dll = 1;
 	}
 
+	clk_sel_regval = __raw_readl(clk->clksel_reg);
+
+	/* Get the M, N and M2 values required for getting sdrc clk stab */
+	m = (clk_sel_regval >> SHIFT_DPLL_M) & DPLL_M_MASK;
+	n = (clk_sel_regval >> SHIFT_DPLL_N) & DPLL_N_MASK;
+	m2 = (clk_sel_regval >> SHIFT_DPLL_M2) & DPLL_M2_MASK;
+
+	sys_clk_rate = (sys_ck_p->rate) / CYCLES_PER_MHZ;
+
+	_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
+
+	delay_sram = delay_sram_val();
+	sys_clk = (1 << SCALING_FACTOR) / sys_clk_rate;
+	clkoutx2 = (sys_clk * (n + 1) * m2) / (2 * m);
+
+	/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2 */
+	refclk = (n + 1) * sys_clk;
+	switch_latency =  (4 * refclk) + (8 * clkoutx2);
+
+	/* Adding 2000 ns to sdrc clk stab */
+	sdrc_clk_stab =  switch_latency + 2000;
+
 	/*
-	 * XXX This only needs to be done when the CPU frequency changes
+	 * Calculate the number of MPU cycles
+	 * to wait for SDRC to stabilize
 	 */
-	_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
-	c = (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
-	c += 1;  /* for safety */
-	c *= SDRC_MPURATE_LOOPS;
-	c >>= SDRC_MPURATE_SCALE;
-	if (c == 0)
-		c = 1;
+	c = ((sdrc_clk_stab * _mpurate) / (delay_sram * 2)) >> SCALING_FACTOR;
+
+	pr_debug("m = %d, n = %d, m2 =%d\n", m, n, m2);
+	pr_debug("switch_latency = %d, sys_clk_rate = %d, cycles = %d\n",
+					switch_latency, sys_clk_rate, c);
 
 	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
 		 validrate);
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 628e8de..a9f2204 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -12,4 +12,6 @@ extern const struct clkops clkops_omap3430es2_ssi_wait;
 extern const struct clkops clkops_omap3430es2_hsotgusb_wait;
 extern const struct clkops clkops_omap3430es2_dss_usbhost_wait;
 
+unsigned int delay_sram_val(void);
+
 #endif
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index a447c4d..ce84a98 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -38,7 +38,7 @@
 #define DPLL5_FREQ_FOR_USBHOST		120000000
 
 /* needed by omap3_core_dpll_m2_set_rate() */
-struct clk *sdrc_ick_p, *arm_fck_p;
+struct clk *sdrc_ick_p, *arm_fck_p, *sys_ck_p;
 
 int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
 {
diff --git a/arch/arm/mach-omap2/clock3xxx.h b/arch/arm/mach-omap2/clock3xxx.h
index 8bbeeaf..475d0c7 100644
--- a/arch/arm/mach-omap2/clock3xxx.h
+++ b/arch/arm/mach-omap2/clock3xxx.h
@@ -15,6 +15,7 @@ void omap3_clk_lock_dpll5(void);
 
 extern struct clk *sdrc_ick_p;
 extern struct clk *arm_fck_p;
+extern struct clk *sys_ck_p;
 
 extern const struct clkops clkops_noncore_dpll_ops;
 
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 57522de..280adff 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -22,6 +22,7 @@
 
 #include <plat/control.h>
 #include <plat/clkdev_omap.h>
+#include <plat/sram.h>
 
 #include "clock.h"
 #include "clock3xxx.h"
@@ -57,6 +58,8 @@
 static struct clk dpll1_fck;
 static struct clk dpll2_fck;
 
+static unsigned int delay_sram;
+
 /* PRM CLOCKS */
 
 /* According to timer32k.c, this is a 32768Hz clock, not a 32000Hz clock. */
@@ -3598,6 +3601,16 @@ int __init omap3xxx_clk_init(void)
 	/* Avoid sleeping during omap3_core_dpll_m2_set_rate() */
 	sdrc_ick_p = clk_get(NULL, "sdrc_ick");
 	arm_fck_p = clk_get(NULL, "arm_fck");
+	sys_ck_p = clk_get(NULL, "sys_ck");
+
+	/* Measure sram delay */
+	delay_sram = measure_sram_delay(10000);
+	pr_debug("SRAM delay: %d\n", delay_sram);
 
 	return 0;
 }
+
+unsigned int delay_sram_val(void)
+{
+	return delay_sram;
+}
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index de99ba2..5a1631f 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -313,3 +313,11 @@ core_m2_mask_val:
 ENTRY(omap3_sram_configure_core_dpll_sz)
 	.word	. - omap3_sram_configure_core_dpll
 
+ENTRY(__sram_wait_delay)
+	subs    r0, r0, #1		@ loop till counter = 0
+	bne     __sram_wait_delay
+
+	mov     pc, lr
+
+ENTRY(__sram_wait_delay_sz)
+	.word   . - __sram_wait_delay
diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
index 16a1b45..dd294a8 100644
--- a/arch/arm/plat-omap/include/plat/sram.h
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -69,6 +69,10 @@ extern u32 omap3_sram_configure_core_dpll(
 			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
 extern unsigned long omap3_sram_configure_core_dpll_sz;
 
+extern unsigned int measure_sram_delay(unsigned int);
+extern void __sram_wait_delay(unsigned int);
+extern unsigned long __sram_wait_delay_sz;
+
 #ifdef CONFIG_PM
 extern void omap_push_sram_idle(void);
 #else
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 51f4dfb..a890e5a 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -30,6 +30,9 @@
 #include <plat/cpu.h>
 #include <plat/vram.h>
 
+#include <linux/clk.h>
+#include <plat/dmtimer.h>
+#include <plat/io.h>
 #include <plat/control.h>
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
@@ -437,11 +440,59 @@ static inline int omap34xx_sram_init(void)
 }
 #endif
 
+#ifdef CONFIG_ARCH_OMAP3
+void (*_omap3_sram_delay)(unsigned int);
+unsigned int  measure_sram_delay(unsigned int loop)
+{
+	static struct omap_dm_timer *gpt;
+	unsigned long flags, diff = 0, gt_rate, mpurate;
+	unsigned int delay_sram, error_gain;
+	unsigned int start = 0, end = 0;
+
+	omap_dm_timer_init();
+	gpt = omap_dm_timer_request();
+	if (!gpt) {
+		pr_err("Could not get the gptimer\n");
+		return -1;
+	}
+
+	omap_dm_timer_set_source(gpt, OMAP_TIMER_SRC_SYS_CLK);
+
+	gt_rate = clk_get_rate(omap_dm_timer_get_fclk(gpt));
+	omap_dm_timer_set_load_start(gpt, 0, 0);
+
+	local_irq_save(flags);
+	start = omap_dm_timer_read_counter(gpt);
+	_omap3_sram_delay(loop);
+	end = omap_dm_timer_read_counter(gpt);
+	diff = end - start;
+	local_irq_restore(flags);
+
+	omap_dm_timer_stop(gpt);
+	omap_dm_timer_free(gpt);
+
+	mpurate = clk_get_rate(clk_get(NULL, "arm_fck"));
+
+	/* calculate the sram delay */
+	error_gain = mpurate / gt_rate;
+	delay_sram = ((error_gain * diff) / (loop * 2));
+
+	delay_sram += error_gain;
+
+	return delay_sram;
+}
+#endif
+
 int __init omap_sram_init(void)
 {
 	omap_detect_sram();
 	omap_map_sram();
 
+#ifdef CONFIG_ARCH_OMAP3
+	_omap3_sram_delay = omap_sram_push(__sram_wait_delay,
+						__sram_wait_delay_sz);
+#endif
+
 	if (!(cpu_class_is_omap2()))
 		omap1_sram_init();
 	else if (cpu_is_omap242x())
-- 
1.6.0.4

