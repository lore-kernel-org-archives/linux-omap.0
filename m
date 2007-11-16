From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: implement CPUfreq frequency table based on
	PRCM table
Date: Fri, 16 Nov 2007 11:54:03 -0800
Message-ID: <20071116195402.GD32675@atomide.com>
References: <20071115233817.668467680@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071115233817.668467680@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Kevin Hilman <khilman@mvista.com> [071115 15:43]:
> This patch adds a CPUfreq frequency-table implementation for OMAP2 by
> walking the PRCM rate-table for available entries and adding them to a
> CPUfreq table.

I updated the patch a bit to use the cpufreq table if initialized, and
to allow omap1 and omap3 to implement it later on easily. Can you please
check? I've only compile tested on osk, and on n800 noticed there are
currently no frequencies for 19.2 source clock.

Regards,

Tony

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=apply

From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: implement CPUfreq frequency table based on PRCM table

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

--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 
 #include <linux/io.h>
+#include <linux/cpufreq.h>
 
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
@@ -374,6 +375,45 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
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
+		printk(KERN_WARNING "%s: failed to initialize frequency table\n",
+		       __FUNCTION__);
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
@@ -381,6 +421,9 @@ static struct clk_functions omap2_clk_functions = {
 	.clk_set_rate		= omap2_clk_set_rate,
 	.clk_set_parent		= omap2_clk_set_parent,
 	.clk_disable_unused	= omap2_clk_disable_unused,
+#ifdef	CONFIG_CPU_FREQ
+	.clk_init_cpufreq_table	= omap2_clk_init_cpufreq_table,
+#endif
 };
 
 static u32 omap2_get_apll_clkin(void)
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -394,6 +394,19 @@ void clk_enable_init_clocks(void)
 }
 EXPORT_SYMBOL(clk_enable_init_clocks);
 
+#ifdef CONFIG_CPU_FREQ
+void clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clockfw_lock, flags);
+	if (arch_clock->clk_init_cpufreq_table)
+		arch_clock->clk_init_cpufreq_table(table);
+	spin_unlock_irqrestore(&clockfw_lock, flags);
+}
+EXPORT_SYMBOL(clk_init_cpufreq_table);
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -24,9 +24,12 @@
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/system.h>
+#include <asm/arch/clock.h>
 
 #define VERY_HI_RATE	900000000
 
+static struct cpufreq_frequency_table *freq_table;
+
 #ifdef CONFIG_ARCH_OMAP1
 #define MPU_CLK		"mpu"
 #else
@@ -39,6 +42,9 @@ static struct clk *mpu_clk;
 
 int omap_verify_speed(struct cpufreq_policy *policy)
 {
+	if (freq_table)
+		return cpufreq_frequency_table_verify(policy, freq_table);
+
 	if (policy->cpu)
 		return -EINVAL;
 
@@ -70,12 +76,26 @@ static int omap_target(struct cpufreq_policy *policy,
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
@@ -83,16 +103,31 @@ static int omap_target(struct cpufreq_policy *policy,
 
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
@@ -103,6 +138,11 @@ static int omap_cpu_exit(struct cpufreq_policy *policy)
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
@@ -111,6 +151,7 @@ static struct cpufreq_driver omap_driver = {
 	.init		= omap_cpu_init,
 	.exit		= omap_cpu_exit,
 	.name		= "omap",
+	.attr		= omap_cpufreq_attr,
 };
 
 static int __init omap_cpufreq_init(void)
@@ -119,3 +160,11 @@ static int __init omap_cpufreq_init(void)
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
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -10,6 +10,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/cpufreq.h>
+
 #ifndef __ARCH_ARM_OMAP_CLOCK_H
 #define __ARCH_ARM_OMAP_CLOCK_H
 
@@ -85,6 +87,9 @@ struct clk_functions {
 	void		(*clk_allow_idle)(struct clk *clk);
 	void		(*clk_deny_idle)(struct clk *clk);
 	void		(*clk_disable_unused)(struct clk *clk);
+#ifdef	CONFIG_CPU_FREQ
+	void		(*clk_init_cpufreq_table)(struct cpufreq_frequency_table **table);
+#endif
 };
 
 extern unsigned int mpurate;
@@ -99,6 +104,9 @@ extern void clk_allow_idle(struct clk *clk);
 extern void clk_deny_idle(struct clk *clk);
 extern int clk_get_usecount(struct clk *clk);
 extern void clk_enable_init_clocks(void);
+#ifdef CONFIG_CPU_FREQ
+extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
+#endif
 
 /* Clock flags */
 #define RATE_CKCTL		(1 << 0)	/* Main fixed ratio clocks */


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0OAP2g/MAC+5xKAE--
