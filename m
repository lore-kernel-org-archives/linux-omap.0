From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/12] OMAP3 OPP: move CPUFreq table init code to OPP layer
Date: Thu, 17 Dec 2009 17:47:42 -0700
Message-ID: <20091218004741.7694.33747.stgit@localhost.localdomain>
References: <20091218004617.7694.84525.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46479 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589AbZLRAsc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 19:48:32 -0500
In-Reply-To: <20091218004617.7694.84525.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: linux-omap@vger.kernel.org

Move omap2_clk_init_cpufreq_table() to opp_init_cpufreq_table() in opp.c
where it now belongs.  OMAP2 still needs to be converted to use the OPP layer,
so it is using the old code.
---
 arch/arm/mach-omap2/clock34xx.c       |   55 +--------------------------------
 arch/arm/plat-omap/cpu-omap.c         |    6 +++-
 arch/arm/plat-omap/include/plat/opp.h |    4 ++
 arch/arm/plat-omap/opp.c              |   46 ++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index ba3dd70..6a40fb1 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -27,7 +27,6 @@
 #include <linux/limits.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
-#include <linux/cpufreq.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
@@ -257,56 +256,7 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 
 /* Common clock code */
 
-/*
- * As it is structured now, this will prevent an OMAP2/3 multiboot
- * kernel from compiling.  This will need further attention.
- */
-#if defined(CONFIG_ARCH_OMAP3)
-
-#ifdef CONFIG_CPU_FREQ
-
-static struct cpufreq_frequency_table *freq_table;
-
-void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
-{
-	int i = 0;
-	int opp_num;
-	struct omap_opp *opp = mpu_opps;
-	unsigned long freq = ULONG_MAX;
-
-	if (!mpu_opps) {
-		pr_warning("%s: failed to initialize frequency"
-				"table\n", __func__);
-		return;
-	}
-	opp_num = opp_get_opp_count(mpu_opps);
-	if (opp_num < 0) {
-		pr_err("%s: no opp table?\n", __func__);
-		return;
-	}
-
-	freq_table = kmalloc(sizeof(struct cpufreq_frequency_table) *
-			(opp_num + 1), GFP_ATOMIC);
-	if (!freq_table) {
-		pr_warning("%s: failed to allocate frequency"
-				"table\n", __func__);
-		return;
-	}
-
-	while (!IS_ERR(opp = opp_find_freq_floor(opp, &freq))) {
-		freq_table[i].index = i;
-		freq_table[i].frequency = freq / 1000;
-		i++;
-		/* set the next benchmark to search */
-		freq--;
-	}
-
-	freq_table[i].index = i;
-	freq_table[i].frequency = CPUFREQ_TABLE_END;
-
-	*table = &freq_table[0];
-}
-#endif
+#ifdef CONFIG_ARCH_OMAP3
 
 struct clk_functions omap2_clk_functions = {
 	.clk_enable		= omap2_clk_enable,
@@ -315,9 +265,6 @@ struct clk_functions omap2_clk_functions = {
 	.clk_set_rate		= omap2_clk_set_rate,
 	.clk_set_parent		= omap2_clk_set_parent,
 	.clk_disable_unused	= omap2_clk_disable_unused,
-#ifdef CONFIG_CPU_FREQ
-	.clk_init_cpufreq_table = omap2_clk_init_cpufreq_table,
-#endif
 };
 
 /*
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index a2b5ee4..723834e 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -132,7 +132,11 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cur = policy->min = policy->max = omap_getspeed(0);
 
-	clk_init_cpufreq_table(&freq_table);
+	if (!cpu_is_omap34xx())
+		clk_init_cpufreq_table(&freq_table);
+	else
+		opp_init_cpufreq_table(mpu_opps, &freq_table);
+
 	if (freq_table) {
 		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
 		if (!result)
diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index b00f7f9..91b0aa6 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -240,4 +240,8 @@ int opp_disable(struct omap_opp *opp);
 struct omap_opp * __deprecated opp_find_by_opp_id(struct omap_opp *opps,
 						  u8 opp_id);
 
+void opp_init_cpufreq_table(struct omap_opp *opps,
+			    struct cpufreq_frequency_table **table);
+
+
 #endif		/* __ASM_ARM_OMAP_OPP_H */
diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
index 8bdad43..aaafc10 100644
--- a/arch/arm/plat-omap/opp.c
+++ b/arch/arm/plat-omap/opp.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/cpufreq.h>
 
 #include <plat/opp_twl_tps.h>
 #include <plat/opp.h>
@@ -281,3 +282,48 @@ int opp_disable(struct omap_opp *opp)
 	opp->enabled = false;
 	return 0;
 }
+
+/* XXX document */
+void opp_init_cpufreq_table(struct omap_opp *opps,
+			    struct cpufreq_frequency_table **table)
+{
+	int i = 0;
+	int opp_num;
+	unsigned long freq = ULONG_MAX;
+	struct cpufreq_frequency_table *freq_table;
+
+	if (!opps) {
+		pr_warning("%s: failed to initialize frequency"
+				"table\n", __func__);
+		return;
+	}
+
+	opp_num = opp_get_opp_count(opps);
+	if (opp_num < 0) {
+		pr_err("%s: no opp table?\n", __func__);
+		return;
+	}
+
+	freq_table = kmalloc(sizeof(struct cpufreq_frequency_table) *
+			     (opp_num + 1), GFP_ATOMIC);
+	if (!freq_table) {
+		pr_warning("%s: failed to allocate frequency"
+				"table\n", __func__);
+		return;
+	}
+
+	while (!OPP_TERM(opps)) {
+		if (opps->enabled) {
+			freq_table[i].index = i;
+			freq_table[i].frequency = freq / 1000;
+			i++;
+		}
+
+		opps++;
+	}
+
+	freq_table[i].index = i;
+	freq_table[i].frequency = CPUFREQ_TABLE_END;
+
+	*table = &freq_table[0];
+}


