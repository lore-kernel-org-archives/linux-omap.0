From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 05/18] OMAP2/3/4 clock: combine all omap2_clk_functions
Date: Tue, 19 Jan 2010 16:36:03 -0700
Message-ID: <20100119233559.26047.48967.stgit@localhost.localdomain>
References: <20100119232900.26047.98263.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58604 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab0ASXid (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 18:38:33 -0500
In-Reply-To: <20100119232900.26047.98263.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

The struct clk_functions for OMAP2, 3, and 4 are all essentially the
same, so combine them.  This removes one multi-OMAP kernel impediment
and saves memory on multi-OMAP builds.

The stubs for omap2_clk_{init,exit}_cpufreq() code will removed once
the OPP layer code that's currently in Kevin's PM branch is merged.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clock.c     |   17 +++++++++++++++++
 arch/arm/mach-omap2/clock.h     |    7 +++++++
 arch/arm/mach-omap2/clock2xxx.c |   23 ++++++++---------------
 arch/arm/mach-omap2/clock34xx.c |    9 ---------
 arch/arm/mach-omap2/clock44xx.c |    9 ---------
 5 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 0d54fde..999b91e 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -351,3 +351,20 @@ void omap2_clk_disable_unused(struct clk *clk)
 		pwrdm_clkdm_state_switch(clk->clkdm);
 }
 #endif
+
+/* Common data */
+
+struct clk_functions omap2_clk_functions = {
+	.clk_enable		= omap2_clk_enable,
+	.clk_disable		= omap2_clk_disable,
+	.clk_round_rate		= omap2_clk_round_rate,
+	.clk_set_rate		= omap2_clk_set_rate,
+	.clk_set_parent		= omap2_clk_set_parent,
+	.clk_disable_unused	= omap2_clk_disable_unused,
+#ifdef CONFIG_CPU_FREQ
+	/* These will be removed when the OPP code is integrated */
+	.clk_init_cpufreq_table	= omap2_clk_init_cpufreq_table,
+	.clk_exit_cpufreq_table	= omap2_clk_exit_cpufreq_table,
+#endif
+};
+
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 0d21702..dcd58cd 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -105,5 +105,12 @@ extern const struct clksel_rate gpt_32k_rates[];
 extern const struct clksel_rate gpt_sys_rates[];
 extern const struct clksel_rate gfx_l3_rates[];
 
+#if defined(CONFIG_ARCH_OMAP24XX) && defined(CONFIG_CPU_FREQ)
+extern void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
+extern void omap2_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table);
+#else
+#define omap2_clk_init_cpufreq_table	0
+#define omap2_clk_exit_cpufreq_table	0
+#endif
 
 #endif
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 5420356..bef5574 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -453,13 +453,16 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
  */
 static struct cpufreq_frequency_table *freq_table;
 
-void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
+void omap2xxx_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
 	const struct prcm_config *prcm;
 	long sys_ck_rate;
 	int i = 0;
 	int tbl_sz = 0;
 
+	if (!cpu_is_omap2xxx())
+		return;
+
 	sys_ck_rate = clk_get_rate(sclk);
 
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
@@ -516,26 +519,16 @@ void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 	*table = &freq_table[0];
 }
 
-void omap2_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
+void omap2xxx_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
 {
+	if (!cpu_is_omap2xxx())
+		return;
+
 	kfree(freq_table);
 }
 
 #endif
 
-struct clk_functions omap2_clk_functions = {
-	.clk_enable		= omap2_clk_enable,
-	.clk_disable		= omap2_clk_disable,
-	.clk_round_rate		= omap2_clk_round_rate,
-	.clk_set_rate		= omap2_clk_set_rate,
-	.clk_set_parent		= omap2_clk_set_parent,
-	.clk_disable_unused	= omap2_clk_disable_unused,
-#ifdef	CONFIG_CPU_FREQ
-	.clk_init_cpufreq_table	= omap2_clk_init_cpufreq_table,
-	.clk_exit_cpufreq_table	= omap2_clk_exit_cpufreq_table,
-#endif
-};
-
 static u32 omap2_get_apll_clkin(void)
 {
 	u32 aplls, srate = 0;
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index d4217b9..4c4bb3c 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -258,15 +258,6 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
  */
 #if defined(CONFIG_ARCH_OMAP3)
 
-struct clk_functions omap2_clk_functions = {
-	.clk_enable		= omap2_clk_enable,
-	.clk_disable		= omap2_clk_disable,
-	.clk_round_rate		= omap2_clk_round_rate,
-	.clk_set_rate		= omap2_clk_set_rate,
-	.clk_set_parent		= omap2_clk_set_parent,
-	.clk_disable_unused	= omap2_clk_disable_unused,
-};
-
 /*
  * Set clocks for bypass mode for reboot to work.
  */
diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
index e370868..08dd642 100644
--- a/arch/arm/mach-omap2/clock44xx.c
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -13,15 +13,6 @@
 #include <linux/errno.h>
 #include "clock.h"
 
-struct clk_functions omap2_clk_functions = {
-	.clk_enable		= omap2_clk_enable,
-	.clk_disable		= omap2_clk_disable,
-	.clk_round_rate		= omap2_clk_round_rate,
-	.clk_set_rate		= omap2_clk_set_rate,
-	.clk_set_parent		= omap2_clk_set_parent,
-	.clk_disable_unused	= omap2_clk_disable_unused,
-};
-
 const struct clkops clkops_noncore_dpll_ops = {
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,


