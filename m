From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: OMAP2+: clock: cleanup CPUfreq leftovers
Date: Mon, 30 Jan 2012 13:59:48 -0800
Message-ID: <1327960788-28905-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:51551 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753854Ab2A3V7j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 16:59:39 -0500
Received: by ghbg20 with SMTP id g20so989930ghb.22
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 13:59:35 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Now that we have OPP layer, and OMAP CPUfreq driver is using it, we no
longer need/use the clock framework code for filling up CPUfreq
tables.  Remove it.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Paul, now that the CPUfreq driver is in mainline (v3.3), this can be safely
removed.

 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   80 --------------------------
 arch/arm/mach-omap2/clock.c                  |    5 --
 arch/arm/mach-omap2/clock.h                  |    8 ---
 3 files changed, 0 insertions(+), 93 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 39f9d5a..9a13e07 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -164,83 +164,3 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 
 	return 0;
 }
-
-#ifdef CONFIG_CPU_FREQ
-/*
- * Walk PRCM rate table and fillout cpufreq freq_table
- * XXX This should be replaced by an OPP layer in the near future
- */
-static struct cpufreq_frequency_table *freq_table;
-
-void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
-{
-	const struct prcm_config *prcm;
-	int i = 0;
-	int tbl_sz = 0;
-
-	if (!cpu_is_omap24xx())
-		return;
-
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (!(prcm->flags & cpu_mask))
-			continue;
-		if (prcm->xtal_speed != sclk->rate)
-			continue;
-
-		/* don't put bypass rates in table */
-		if (prcm->dpll_speed == prcm->xtal_speed)
-			continue;
-
-		tbl_sz++;
-	}
-
-	/*
-	 * XXX Ensure that we're doing what CPUFreq expects for this error
-	 * case and the following one
-	 */
-	if (tbl_sz == 0) {
-		pr_warning("%s: no matching entries in rate_table\n",
-			   __func__);
-		return;
-	}
-
-	/* Include the CPUFREQ_TABLE_END terminator entry */
-	tbl_sz++;
-
-	freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) * tbl_sz,
-			     GFP_ATOMIC);
-	if (!freq_table) {
-		pr_err("%s: could not kzalloc frequency table\n", __func__);
-		return;
-	}
-
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (!(prcm->flags & cpu_mask))
-			continue;
-		if (prcm->xtal_speed != sclk->rate)
-			continue;
-
-		/* don't put bypass rates in table */
-		if (prcm->dpll_speed == prcm->xtal_speed)
-			continue;
-
-		freq_table[i].index = i;
-		freq_table[i].frequency = prcm->mpu_speed / 1000;
-		i++;
-	}
-
-	freq_table[i].index = i;
-	freq_table[i].frequency = CPUFREQ_TABLE_END;
-
-	*table = &freq_table[0];
-}
-
-void omap2_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
-{
-	if (!cpu_is_omap24xx())
-		return;
-
-	kfree(freq_table);
-}
-
-#endif
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index f57ed5b..d9f4931 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -536,10 +536,5 @@ struct clk_functions omap2_clk_functions = {
 	.clk_set_rate		= omap2_clk_set_rate,
 	.clk_set_parent		= omap2_clk_set_parent,
 	.clk_disable_unused	= omap2_clk_disable_unused,
-#ifdef CONFIG_CPU_FREQ
-	/* These will be removed when the OPP code is integrated */
-	.clk_init_cpufreq_table	= omap2_clk_init_cpufreq_table,
-	.clk_exit_cpufreq_table	= omap2_clk_exit_cpufreq_table,
-#endif
 };
 
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index b8c2a68..a1bb23a 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -146,14 +146,6 @@ extern const struct clksel_rate gpt_sys_rates[];
 extern const struct clksel_rate gfx_l3_rates[];
 extern const struct clksel_rate dsp_ick_rates[];
 
-#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_CPU_FREQ)
-extern void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
-extern void omap2_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table);
-#else
-#define omap2_clk_init_cpufreq_table	0
-#define omap2_clk_exit_cpufreq_table	0
-#endif
-
 extern const struct clkops clkops_omap2_iclk_dflt_wait;
 extern const struct clkops clkops_omap2_iclk_dflt;
 extern const struct clkops clkops_omap2_iclk_idle_only;
-- 
1.7.8.2

