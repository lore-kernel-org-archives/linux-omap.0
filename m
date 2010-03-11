From: Pramod Gurav <pramod.gurav@ti.com>
Subject: [PATCH v3 1/2] OMAP3: SDRC: Dynamic Calculation of SDRC stall latency during DVFS
Date: Thu, 11 Mar 2010 17:04:56 +0530
Message-ID: <1268307297-23330-2-git-send-email-pramod.gurav@ti.com>
References: <1268307297-23330-1-git-send-email-pramod.gurav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33527 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624Ab0CKL2p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Mar 2010 06:28:45 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2BBSg5F005823
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 11 Mar 2010 05:28:44 -0600
In-Reply-To: <1268307297-23330-1-git-send-email-pramod.gurav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Teerth Reddy <teerth@ti.com>, Romit Dasgupta <romit@ti.com>, Pramod Gurav <pramod.gurav@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

From: Teerth Reddy <teerth@ti.com> 

The patch has the changes to calculate the dpll3 clock stabilization
delay dynamically. The SRAM delay is calibrated during bootup using the
gptimers and used while calculating the stabilization delay. By using
the dynamic method the dependency on the type of cache being used is
removed.

The wait time for L3 clock stabilization is calculated using the formula
        = 4*REFCLK + 8*CLKOUTX2,
which uses the M, N and M2 read from the registers.
Since this gives slightly less value, 2us is added as buffer for safety.
This works fine for omap3.

Signed-off-by: Teerth Reddy <teerth@ti.com>
Signed-off-by: Romit Dasgupta <romit@ti.com>
Signed-off-by: Pramod Gurav <pramod.gurav@ti.com>
Signed-off-by: Vishwanath Sripathy <vishwanath.bs@ti.com>

---
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |   52 +++++++++++++++++++++++++++----
 arch/arm/mach-omap2/clock34xx.h        |    2 +
 arch/arm/mach-omap2/clock3xxx_data.c   |   12 +++++++
 arch/arm/mach-omap2/sram34xx.S         |   11 +++++++
 arch/arm/plat-omap/include/plat/sram.h |    4 ++
 arch/arm/plat-omap/sram.c              |   49 ++++++++++++++++++++++++++++++
 6 files changed, 123 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index b2b1e37..3f61eb2 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -24,6 +24,7 @@
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
+#include <plat/prcm.h>
 
 #include "clock.h"
 #include "clock3xxx.h"
@@ -32,6 +33,13 @@
 
 #define CYCLES_PER_MHZ			1000000
 
+#define        DPLL_M_MASK     0x7ff
+#define        DPLL_N_MASK     0x7f
+#define        DPLL_M2_MASK    0x1f
+#define        SHIFT_DPLL_M    16
+#define        SHIFT_DPLL_N    8
+#define        SHIFT_DPLL_M2   27
+
 /*
  * CORE DPLL (DPLL3) M2 divider rate programming functions
  *
@@ -56,6 +64,11 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	struct omap_sdrc_params *sdrc_cs0;
 	struct omap_sdrc_params *sdrc_cs1;
 	int ret;
+	u32 clk_sel_regval;
+	u32 core_dpll_mul_m, core_dpll_div_n, core_dpll_clkoutdiv_m2;
+	u32 sys_clk_rate, sdrc_clk_stab;
+	u32 refclk, clkoutx2, switch_latency;
+	unsigned int delay_sram;
 
 	if (!clk || !rate)
 		return -EINVAL;
@@ -79,16 +92,41 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 		unlock_dll = 1;
 	}
 
+	clk_sel_regval = __raw_readl(clk->clksel_reg);
+
+	/* Get the M, N and M2 values required for getting sdrc clk stab */
+	core_dpll_mul_m = (clk_sel_regval >> SHIFT_DPLL_M) & DPLL_M_MASK;
+	core_dpll_div_n = (clk_sel_regval >> SHIFT_DPLL_N) & DPLL_N_MASK;
+	core_dpll_clkoutdiv_m2 = (clk_sel_regval >> SHIFT_DPLL_M2) &
+							DPLL_M2_MASK;
+	sys_clk_rate = clk_get_rate(clk_get(NULL, "sys_ck"));
+
+	sys_clk_rate = sys_clk_rate / CYCLES_PER_MHZ;
+
+	/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2 */
+	refclk = (4 * (core_dpll_div_n + 1)) / sys_clk_rate;
+	clkoutx2 = ((core_dpll_div_n + 1) * core_dpll_clkoutdiv_m2) /
+					(sys_clk_rate * core_dpll_mul_m * 2);
+	switch_latency =  refclk + 8 * clkoutx2;
+
+	/* Adding 2us to sdrc clk stab */
+	sdrc_clk_stab =  switch_latency + 2;
+
+	delay_sram = delay_sram_val();
+
 	/*
-	 * XXX This only needs to be done when the CPU frequency changes
+	 * Calculate the number of MPU cycles
+	 * to wait for SDRC to stabilize
 	 */
+
 	_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
-	c = (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
-	c += 1;  /* for safety */
-	c *= SDRC_MPURATE_LOOPS;
-	c >>= SDRC_MPURATE_SCALE;
-	if (c == 0)
-		c = 1;
+
+	c = ((sdrc_clk_stab * _mpurate) / (delay_sram * 2));
+
+	pr_debug("m = %d, n = %d, m2 =%d\n", core_dpll_mul_m, core_dpll_div_n,
+						core_dpll_clkoutdiv_m2);
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
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 57522de..9726f4b 100644
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
 
+unsigned int delay_sram;
+
 /* PRM CLOCKS */
 
 /* According to timer32k.c, this is a 32768Hz clock, not a 32000Hz clock. */
@@ -3599,5 +3602,14 @@ int __init omap3xxx_clk_init(void)
 	sdrc_ick_p = clk_get(NULL, "sdrc_ick");
 	arm_fck_p = clk_get(NULL, "arm_fck");
 
+	/* Measure sram delay */
+	delay_sram = measure_sram_delay(10000);
+	pr_debug("SRAM delay: %d\n", delay_sram);
+
 	return 0;
 }
+
+unsigned int delay_sram_val(void)
+{
+	return delay_sram;
+}
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index de99ba2..00da20a 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -313,3 +313,14 @@ core_m2_mask_val:
 ENTRY(omap3_sram_configure_core_dpll_sz)
 	.word	. - omap3_sram_configure_core_dpll
 
+ENTRY(__sram_wait_delay)
+	stmfd   sp!, {lr}       	@ store return addr to stack
+
+	loop1:
+	subs    r0, r0, #1		@ loop till counter = 0
+	bne     loop1
+
+	ldmfd   sp!, {pc}       	@ restore return address
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
index 51f4dfb..82d8df0 100644
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
@@ -437,11 +440,57 @@ static inline int omap34xx_sram_init(void)
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
+	delay_sram = (((mpurate / gt_rate) * diff) / (loop * 2));
+
+	error_gain = mpurate / gt_rate;
+	delay_sram = delay_sram + error_gain;
+
+	return delay_sram;
+}
+#endif
+
 int __init omap_sram_init(void)
 {
 	omap_detect_sram();
 	omap_map_sram();
 
+	_omap3_sram_delay = omap_sram_push(__sram_wait_delay,
+						__sram_wait_delay_sz);
+
 	if (!(cpu_class_is_omap2()))
 		omap1_sram_init();
 	else if (cpu_is_omap242x())
-- 
1.5.6.3

