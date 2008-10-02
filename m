From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 05/10] ARM: OMAP2: Implement CPUfreq frequency table based on
	PRCM table
Date: Thu, 02 Oct 2008 10:37:52 -0600
Message-ID: <20081002163752.15385.97004.stgit@localhost.localdomain>
References: <20081002163508.15385.43247.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51910 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbYJBQrH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Oct 2008 12:47:07 -0400
In-Reply-To: <20081002163508.15385.43247.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@mvista.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

From: Kevin Hilman <khilman@mvista.com>

This patch adds a CPUfreq frequency-table implementation for OMAP2 by
walking the PRCM rate-table for available entries and adding them to a
CPUfreq table.

CPUfreq can then be used to manage switching between all the available
entries in the PRCM rate table.  Either use the CPUfreq sysfs
interface directly, (see Section 3 of Documentation/cpu-freq/user-guide.txt)
or use the cpufrequtils package:
http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils.html

Signed-off-by: Kevin Hilman <khilman@mvista.com>

Updated to try to use cpufreq_table if it exists.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.c         |   42 ++++++++++++++++++++++
 arch/arm/plat-omap/cpu-omap.c           |   58 +++++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/mach/clock.h |    3 ++
 3 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 133c36f..9240e64 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -378,6 +378,45 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
+#ifdef CONFIG_CPU_FREQ
+/*
+ * Walk PRCM rate table and fillout cpufreq freq_table
+ */
+static struct cpufreq_frequency_table freq_table[ARRAY_SIZE(rate_table)];
+
+void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
+{
+	struct prcm_config *prcm;
+	int i = 0;
+
+	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
+		if (prcm->xtal_speed != sys_ck.rate)
+			continue;
+
+		/* don't put bypass rates in table */
+		if (prcm->dpll_speed == prcm->xtal_speed)
+			continue;
+
+		freq_table[i].index = i;
+		freq_table[i].frequency = prcm->mpu_speed / 1000;
+		i++;
+	}
+
+	if (i == 0) {
+		printk(KERN_WARNING "%s: failed to initialize frequency "
+		       "table\n", __func__);
+		return;
+	}
+
+	freq_table[i].index = i;
+	freq_table[i].frequency = CPUFREQ_TABLE_END;
+
+	*table = &freq_table[0];
+}
+#endif
+
 static struct clk_functions omap2_clk_functions = {
 	.clk_enable		= omap2_clk_enable,
 	.clk_disable		= omap2_clk_disable,
@@ -385,6 +424,9 @@ static struct clk_functions omap2_clk_functions = {
 	.clk_set_rate		= omap2_clk_set_rate,
 	.clk_set_parent		= omap2_clk_set_parent,
 	.clk_disable_unused	= omap2_clk_disable_unused,
+#ifdef	CONFIG_CPU_FREQ
+	.clk_init_cpufreq_table	= omap2_clk_init_cpufreq_table,
+#endif
 };
 
 static u32 omap2_get_apll_clkin(void)
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index b269024..e7d09c3 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -23,10 +23,14 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
+#include <mach/clock.h>
+#include <linux/io.h>
 #include <asm/system.h>
 
 #define VERY_HI_RATE	900000000
 
+static struct cpufreq_frequency_table *freq_table;
+
 #ifdef CONFIG_ARCH_OMAP1
 #define MPU_CLK		"mpu"
 #else
@@ -39,6 +43,9 @@ static struct clk *mpu_clk;
 
 int omap_verify_speed(struct cpufreq_policy *policy)
 {
+	if (freq_table)
+		return cpufreq_frequency_table_verify(policy, freq_table);
+
 	if (policy->cpu)
 		return -EINVAL;
 
@@ -70,12 +77,26 @@ static int omap_target(struct cpufreq_policy *policy,
 	struct cpufreq_freqs freqs;
 	int ret = 0;
 
+	/* Ensure desired rate is within allowed range.  Some govenors
+	 * (ondemand) will just pass target_freq=0 to get the minimum. */
+	if (target_freq < policy->cpuinfo.min_freq)
+		target_freq = policy->cpuinfo.min_freq;
+	if (target_freq > policy->cpuinfo.max_freq)
+		target_freq = policy->cpuinfo.max_freq;
+
 	freqs.old = omap_getspeed(0);
 	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
 	freqs.cpu = 0;
 
+	if (freqs.old == freqs.new)
+		return ret;
+
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
-	ret = clk_set_rate(mpu_clk, target_freq * 1000);
+#ifdef CONFIG_CPU_FREQ_DEBUG
+	printk(KERN_DEBUG "cpufreq-omap: transition: %u --> %u\n",
+	       freqs.old, freqs.new);
+#endif
+	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
 	return ret;
@@ -83,16 +104,31 @@ static int omap_target(struct cpufreq_policy *policy,
 
 static int __init omap_cpu_init(struct cpufreq_policy *policy)
 {
+	int result = 0;
+
 	mpu_clk = clk_get(NULL, MPU_CLK);
 	if (IS_ERR(mpu_clk))
 		return PTR_ERR(mpu_clk);
 
 	if (policy->cpu != 0)
 		return -EINVAL;
+
 	policy->cur = policy->min = policy->max = omap_getspeed(0);
-	policy->cpuinfo.min_freq = clk_round_rate(mpu_clk, 0) / 1000;
-	policy->cpuinfo.max_freq = clk_round_rate(mpu_clk, VERY_HI_RATE) / 1000;
-	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+
+	clk_init_cpufreq_table(&freq_table);
+	if (freq_table) {
+		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
+		if (!result)
+			cpufreq_frequency_table_get_attr(freq_table,
+							policy->cpu);
+	} else {
+		policy->cpuinfo.min_freq = clk_round_rate(mpu_clk, 0) / 1000;
+		policy->cpuinfo.max_freq = clk_round_rate(mpu_clk,
+							VERY_HI_RATE) / 1000;
+	}
+
+	/* FIXME: what's the actual transition time? */
+	policy->cpuinfo.transition_latency = 10 * 1000 * 1000;
 
 	return 0;
 }
@@ -103,6 +139,11 @@ static int omap_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static struct freq_attr *omap_cpufreq_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
 static struct cpufreq_driver omap_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= omap_verify_speed,
@@ -111,6 +152,7 @@ static struct cpufreq_driver omap_driver = {
 	.init		= omap_cpu_init,
 	.exit		= omap_cpu_exit,
 	.name		= "omap",
+	.attr		= omap_cpufreq_attr,
 };
 
 static int __init omap_cpufreq_init(void)
@@ -119,3 +161,11 @@ static int __init omap_cpufreq_init(void)
 }
 
 arch_initcall(omap_cpufreq_init);
+
+/*
+ * if ever we want to remove this, upon cleanup call:
+ *
+ * cpufreq_unregister_driver()
+ * cpufreq_frequency_table_put_attr()
+ */
+
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index e32937b..d78d3a7 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -121,6 +121,9 @@ extern void clk_allow_idle(struct clk *clk);
 extern void clk_deny_idle(struct clk *clk);
 extern int clk_get_usecount(struct clk *clk);
 extern void clk_enable_init_clocks(void);
+#ifdef CONFIG_CPU_FREQ
+extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
+#endif
 
 /* Clock flags */
 #define RATE_CKCTL		(1 << 0)	/* Main fixed ratio clocks */


