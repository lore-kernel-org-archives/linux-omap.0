From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH/RFC] ARM: OMAP: implement CPUfreq frequency table based on
	PRCM table
Date: Fri, 19 Oct 2007 10:20:31 -0700
Message-ID: <20071019172031.226299706@mvista.com>
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

This patch adds a CPUfreq frequency-table implementation for OMAP2 by
walking the PRCM rate-table for available entries and adding them to a
CPUfreq table.

CPUfreq can then be used to manage switching between all the available
entries in the PRCM rate table.  Either use the CPUfreq sysfs
interface directly, (see Section 3 of Documentation/cpu-freq/user-guide.txt)
or use the cpufrequtils package:
http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils.html

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/mach-omap2/clock24xx.c |   39 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/cpu-omap.c   |   52 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 89 insertions(+), 2 deletions(-)

Index: dev/arch/arm/mach-omap2/clock24xx.c
===================================================================
--- dev.orig/arch/arm/mach-omap2/clock24xx.c
+++ dev/arch/arm/mach-omap2/clock24xx.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 
 #include <linux/io.h>
+#include <linux/cpufreq.h>
 
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
@@ -461,6 +462,42 @@ static int __init omap2_clk_arch_init(vo
 }
 arch_initcall(omap2_clk_arch_init);
 
+#ifdef CONFIG_CPU_FREQ
+/*
+ * Walk PRCM rate table and fillout cpufreq freq_table
+ */
+static struct cpufreq_frequency_table freq_table[16];
+struct cpufreq_frequency_table *omap2_cpufreq_table;
+
+static void omap2_cpufreq_init_table(void)
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
+	freq_table[i].index = i;
+	freq_table[i].frequency = CPUFREQ_TABLE_END;
+
+	omap2_cpufreq_table = &freq_table[0];
+}
+#else
+static void omap2_cpufreq_init_table(void) {}
+#endif
+
 int __init omap2_clk_init(void)
 {
 	struct prcm_config *prcm;
@@ -520,5 +557,7 @@ int __init omap2_clk_init(void)
 	vclk = clk_get(NULL, "virt_prcm_set");
 	sclk = clk_get(NULL, "sys_ck");
 
+	omap2_cpufreq_init_table();
+
 	return 0;
 }
Index: dev/arch/arm/plat-omap/cpu-omap.c
===================================================================
--- dev.orig/arch/arm/plat-omap/cpu-omap.c
+++ dev/arch/arm/plat-omap/cpu-omap.c
@@ -30,15 +30,25 @@
 #ifdef CONFIG_ARCH_OMAP1
 #define MPU_CLK		"mpu"
 #else
+
+#define USE_FREQ_TABLE
+extern struct cpufreq_frequency_table *omap2_cpufreq_table;
+static struct cpufreq_frequency_table *freq_table;
+
 #define MPU_CLK		"virt_prcm_set"
 #endif
 
 static struct clk *mpu_clk;
 
+static unsigned int omap_cur_speed;
+
 /* TODO: Add support for SDRAM timing changes */
 
 int omap_verify_speed(struct cpufreq_policy *policy)
 {
+#ifdef USE_FREQ_TABLE
+	return cpufreq_frequency_table_verify(policy, freq_table);
+#else
 	if (policy->cpu)
 		return -EINVAL;
 
@@ -50,6 +60,7 @@ int omap_verify_speed(struct cpufreq_pol
 	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
 				     policy->cpuinfo.max_freq);
 	return 0;
+#endif
 }
 
 unsigned int omap_getspeed(unsigned int cpu)
@@ -74,8 +85,16 @@ static int omap_target(struct cpufreq_po
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
+	omap_cur_speed = freqs.new * 1000;
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
 
 	return ret;
@@ -83,17 +102,32 @@ static int omap_target(struct cpufreq_po
 
 static int __init omap_cpu_init(struct cpufreq_policy *policy)
 {
+	int result = 0;
+
 	mpu_clk = clk_get(NULL, MPU_CLK);
 	if (IS_ERR(mpu_clk))
 		return PTR_ERR(mpu_clk);
 
 	if (policy->cpu != 0)
 		return -EINVAL;
-	policy->cur = policy->min = policy->max = omap_getspeed(0);
+
+	policy->cur = omap_getspeed(0);
 	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
+#ifdef USE_FREQ_TABLE
+	freq_table = omap2_cpufreq_table;
+	result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
+	if (!result)
+		cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
+#else
+	policy->min = omap_getspeed(0);
+	policy->max = omap_getspeed(0);
 	policy->cpuinfo.min_freq = clk_round_rate(mpu_clk, 0) / 1000;
 	policy->cpuinfo.max_freq = clk_round_rate(mpu_clk, VERY_HI_RATE) / 1000;
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+#endif
+	/* If CPUFREQ_ETERNAL is used, then governers cannot be changed */
+	policy->cpuinfo.transition_latency = 10 * 1000 * 1000; /* 10 msec */
+
 
 	return 0;
 }
@@ -104,6 +138,11 @@ static int omap_cpu_exit(struct cpufreq_
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
@@ -112,6 +151,7 @@ static struct cpufreq_driver omap_driver
 	.init		= omap_cpu_init,
 	.exit		= omap_cpu_exit,
 	.name		= "omap",
+	.attr		= omap_cpufreq_attr,
 };
 
 static int __init omap_cpufreq_init(void)
@@ -120,3 +160,11 @@ static int __init omap_cpufreq_init(void
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
--
