From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: OMAP: clock: cleanup CPUfreq leftovers, fix build errors
Date: Fri, 13 Apr 2012 13:52:15 -0700
Message-ID: <1334350335-1250-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:58479 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755981Ab2DMUvm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 16:51:42 -0400
Received: by dadp12 with SMTP id p12so4272583dad.21
        for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 13:51:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Now that we have OPP layer, and OMAP CPUfreq driver is using it, we no
longer need/use the clock framework code for filling up CPUfreq
tables.  Remove it.

Removing this code also eliminates build errors when CPU_FREQ_TABLE
support is not enabled.

Thanks to Russell King for pointing out the parts I missed under
plat-omap in the original version and also pointing out the build
errors when CPUFREQ_TABLE support was not enabled.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Tony/Paul, can you queue this up ASAP for v3.4-rc?  This was a cleanup
that was targetted to go in to v3.4, but missed the merge window.  The
cleanup is still needed, but now it's also a fix since this dead code
also causes build errors when CPU_FREQ_TABLE support is not enabled.

Also, if we don't merge this patch, we'll have to rework it because
Russell has queued an alternate fix to this which changes some of this
code that should be removed instead:
http://marc.info/?l=linux-arm-kernel&m=133434335009356&w=2
However, if we get this fix in soon, Russell is willing to drop his 
version.   

 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   80 --------------------------
 arch/arm/mach-omap2/clock.c                  |    5 --
 arch/arm/mach-omap2/clock.h                  |    8 ---
 arch/arm/plat-omap/clock.c                   |   26 ---------
 arch/arm/plat-omap/include/plat/clock.h      |   10 ----
 5 files changed, 129 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 7072e0d..3d9d746 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -165,83 +165,3 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 
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
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 8506cbb..62ec5c4 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -398,32 +398,6 @@ struct clk dummy_ck = {
 	.ops	= &clkops_null,
 };
 
-#ifdef CONFIG_CPU_FREQ
-void clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
-{
-	unsigned long flags;
-
-	if (!arch_clock || !arch_clock->clk_init_cpufreq_table)
-		return;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	arch_clock->clk_init_cpufreq_table(table);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-}
-
-void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
-{
-	unsigned long flags;
-
-	if (!arch_clock || !arch_clock->clk_exit_cpufreq_table)
-		return;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	arch_clock->clk_exit_cpufreq_table(table);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-}
-#endif
-
 /*
  *
  */
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 240a7b9..d0ef57c 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -272,8 +272,6 @@ struct clk {
 #endif
 };
 
-struct cpufreq_frequency_table;
-
 struct clk_functions {
 	int		(*clk_enable)(struct clk *clk);
 	void		(*clk_disable)(struct clk *clk);
@@ -283,10 +281,6 @@ struct clk_functions {
 	void		(*clk_allow_idle)(struct clk *clk);
 	void		(*clk_deny_idle)(struct clk *clk);
 	void		(*clk_disable_unused)(struct clk *clk);
-#ifdef CONFIG_CPU_FREQ
-	void		(*clk_init_cpufreq_table)(struct cpufreq_frequency_table **);
-	void		(*clk_exit_cpufreq_table)(struct cpufreq_frequency_table **);
-#endif
 };
 
 extern int mpurate;
@@ -301,10 +295,6 @@ extern void recalculate_root_clocks(void);
 extern unsigned long followparent_recalc(struct clk *clk);
 extern void clk_enable_init_clocks(void);
 unsigned long omap_fixed_divisor_recalc(struct clk *clk);
-#ifdef CONFIG_CPU_FREQ
-extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
-extern void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table);
-#endif
 extern struct clk *omap_clk_get_by_name(const char *name);
 extern int omap_clk_enable_autoidle_all(void);
 extern int omap_clk_disable_autoidle_all(void);
-- 
1.7.9.2

