From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 1/2] OMAP: cpufreq: Split OMAP1 and OMAP2PLUS CPUfreq drivers.
Date: Mon, 14 Mar 2011 17:08:48 +0530
Message-ID: <1300102729-17276-2-git-send-email-santosh.shilimkar@ti.com>
References: <1300102729-17276-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46237 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677Ab1CNLiz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 07:38:55 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2EBcpFb018844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Mar 2011 06:38:54 -0500
In-Reply-To: <1300102729-17276-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

This patch is an attempt to cleanup the #ifdeferry in the
omap CPUfreq drivers.

The split betwenn OMAP1 and OMAP2PLUS is logical because
	- OMAP1 doesn't support opp layer.
	- OMAP1 build is seperate from omap2plus.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap1/Makefile                       |    3 +
 .../cpu-omap.c => mach-omap1/omap1-cpufreq.c}      |   68 +++++----------
 arch/arm/mach-omap2/Makefile                       |    3 +
 .../cpu-omap.c => mach-omap2/omap2plus-cpufreq.c}  |   91 ++++++++++----------
 arch/arm/plat-omap/Makefile                        |    1 -
 5 files changed, 70 insertions(+), 96 deletions(-)
 copy arch/arm/{plat-omap/cpu-omap.c => mach-omap1/omap1-cpufreq.c} (75%)
 rename arch/arm/{plat-omap/cpu-omap.c => mach-omap2/omap2plus-cpufreq.c} (76%)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index ba6009f..cb2d3a6 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -10,6 +10,9 @@ obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
 obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 
+# CPUFREQ driver
+obj-$(CONFIG_CPU_FREQ) += omap1-cpufreq.o
+
 # Power Management
 obj-$(CONFIG_PM) += pm.o sleep.o pm_bus.o
 
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/mach-omap1/omap1-cpufreq.c
similarity index 75%
copy from arch/arm/plat-omap/cpu-omap.c
copy to arch/arm/mach-omap1/omap1-cpufreq.c
index 1c1b80b..682cdc8 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/mach-omap1/omap1-cpufreq.c
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/plat-omap/cpu-omap.c
+ *  OMAP1 cpufreq driver
  *
  *  CPU frequency scaling for OMAP
  *
@@ -27,31 +27,18 @@
 #include <linux/io.h>
 #include <linux/opp.h>
 
-#include <mach/hardware.h>
-#include <plat/clock.h>
 #include <asm/system.h>
 
-#if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
+#include <plat/clock.h>
 #include <plat/omap-pm.h>
-#include <plat/common.h>
-#endif
+
+#include <mach/hardware.h>
 
 #define VERY_HI_RATE	900000000
 
 static struct cpufreq_frequency_table *freq_table;
-
-#ifdef CONFIG_ARCH_OMAP1
-#define MPU_CLK		"mpu"
-#elif defined(CONFIG_ARCH_OMAP3)
-#define MPU_CLK		"arm_fck"
-#else
-#define MPU_CLK		"virt_prcm_set"
-#endif
-
 static struct clk *mpu_clk;
 
-/* TODO: Add support for SDRAM timing changes */
-
 static int omap_verify_speed(struct cpufreq_policy *policy)
 {
 	if (freq_table)
@@ -85,13 +72,7 @@ static int omap_target(struct cpufreq_policy *policy,
 		       unsigned int target_freq,
 		       unsigned int relation)
 {
-#ifdef CONFIG_ARCH_OMAP1
 	struct cpufreq_freqs freqs;
-#endif
-#if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
-	unsigned long freq;
-	struct device *mpu_dev = omap2_get_mpuss_device();
-#endif
 	int ret = 0;
 
 	/* Ensure desired rate is within allowed range.  Some govenors
@@ -101,25 +82,22 @@ static int omap_target(struct cpufreq_policy *policy,
 	if (target_freq > policy->max)
 		target_freq = policy->max;
 
-#ifdef CONFIG_ARCH_OMAP1
 	freqs.old = omap_getspeed(0);
 	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
 	freqs.cpu = 0;
 
 	if (freqs.old == freqs.new)
 		return ret;
+
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
 #ifdef CONFIG_CPU_FREQ_DEBUG
-	printk(KERN_DEBUG "cpufreq-omap: transition: %u --> %u\n",
-	       freqs.old, freqs.new);
+	pr_info("cpufreq-omap: transition: %u --> %u\n", freqs.old, freqs.new);
 #endif
 	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
+
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-#elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
-	freq = target_freq * 1000;
-	if (opp_find_freq_ceil(mpu_dev, &freq))
-		omap_pm_cpu_set_freq(freq);
-#endif
+
 	return ret;
 }
 
@@ -127,7 +105,7 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
 
-	mpu_clk = clk_get(NULL, MPU_CLK);
+	mpu_clk = clk_get(NULL, "mpu");
 	if (IS_ERR(mpu_clk))
 		return PTR_ERR(mpu_clk);
 
@@ -136,13 +114,7 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cur = policy->min = policy->max = omap_getspeed(0);
 
-	if (!cpu_is_omap34xx()) {
-		clk_init_cpufreq_table(&freq_table);
-	} else {
-		struct device *mpu_dev = omap2_get_mpuss_device();
-
-		opp_init_cpufreq_table(mpu_dev, &freq_table);
-	}
+	clk_init_cpufreq_table(&freq_table);
 
 	if (freq_table) {
 		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
@@ -184,7 +156,7 @@ static struct cpufreq_driver omap_driver = {
 	.get		= omap_getspeed,
 	.init		= omap_cpu_init,
 	.exit		= omap_cpu_exit,
-	.name		= "omap",
+	.name		= "omap1",
 	.attr		= omap_cpufreq_attr,
 };
 
@@ -193,12 +165,12 @@ static int __init omap_cpufreq_init(void)
 	return cpufreq_register_driver(&omap_driver);
 }
 
-late_initcall(omap_cpufreq_init);
-
-/*
- * if ever we want to remove this, upon cleanup call:
- *
- * cpufreq_unregister_driver()
- * cpufreq_frequency_table_put_attr()
- */
+static void __exit omap_cpufreq_exit(void)
+{
+	cpufreq_unregister_driver(&omap_driver);
+}
 
+MODULE_DESCRIPTION("cpufreq driver for OMAP1 SOCs");
+MODULE_LICENSE("GPL");
+module_init(omap_cpufreq_init);
+module_exit(omap_cpufreq_exit);
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 1c0c2b0..b1187f9 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -56,6 +56,9 @@ obj-$(CONFIG_ARCH_OMAP3)		+= opp3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= opp4xxx_data.o
 endif
 
+# CPUFREQ driver
+obj-$(CONFIG_CPU_FREQ)			+= omap2plus-cpufreq.o
+
 # Power Management
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
similarity index 76%
rename from arch/arm/plat-omap/cpu-omap.c
rename to arch/arm/mach-omap2/omap2plus-cpufreq.c
index 1c1b80b..216704e 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/plat-omap/cpu-omap.c
+ *  OMAP2PLUS cpufreq driver
  *
  *  CPU frequency scaling for OMAP
  *
@@ -27,31 +27,20 @@
 #include <linux/io.h>
 #include <linux/opp.h>
 
-#include <mach/hardware.h>
-#include <plat/clock.h>
 #include <asm/system.h>
+#include <asm/smp_plat.h>
 
-#if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
+#include <plat/clock.h>
 #include <plat/omap-pm.h>
 #include <plat/common.h>
-#endif
+
+#include <mach/hardware.h>
 
 #define VERY_HI_RATE	900000000
 
 static struct cpufreq_frequency_table *freq_table;
-
-#ifdef CONFIG_ARCH_OMAP1
-#define MPU_CLK		"mpu"
-#elif defined(CONFIG_ARCH_OMAP3)
-#define MPU_CLK		"arm_fck"
-#else
-#define MPU_CLK		"virt_prcm_set"
-#endif
-
 static struct clk *mpu_clk;
 
-/* TODO: Add support for SDRAM timing changes */
-
 static int omap_verify_speed(struct cpufreq_policy *policy)
 {
 	if (freq_table)
@@ -85,14 +74,8 @@ static int omap_target(struct cpufreq_policy *policy,
 		       unsigned int target_freq,
 		       unsigned int relation)
 {
-#ifdef CONFIG_ARCH_OMAP1
-	struct cpufreq_freqs freqs;
-#endif
-#if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
-	unsigned long freq;
-	struct device *mpu_dev = omap2_get_mpuss_device();
-#endif
 	int ret = 0;
+	struct cpufreq_freqs freqs;
 
 	/* Ensure desired rate is within allowed range.  Some govenors
 	 * (ondemand) will just pass target_freq=0 to get the minimum. */
@@ -101,33 +84,48 @@ static int omap_target(struct cpufreq_policy *policy,
 	if (target_freq > policy->max)
 		target_freq = policy->max;
 
-#ifdef CONFIG_ARCH_OMAP1
 	freqs.old = omap_getspeed(0);
 	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
 	freqs.cpu = 0;
 
 	if (freqs.old == freqs.new)
 		return ret;
+
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
 #ifdef CONFIG_CPU_FREQ_DEBUG
-	printk(KERN_DEBUG "cpufreq-omap: transition: %u --> %u\n",
-	       freqs.old, freqs.new);
+	pr_info("cpufreq-omap: transition: %u --> %u\n", freqs.old, freqs.new);
 #endif
+
 	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
+
+	/*
+	 * Generic CPUFREQ driver jiffy update is under !SMP. So jiffies
+	 * won't get updated when UP machine cpufreq build with
+	 * CONFIG_SMP enabled. Below code is added only to manage that
+	 * scenario
+	 */
+	if (!is_smp())
+		loops_per_jiffy =
+			 cpufreq_scale(loops_per_jiffy, freqs.old, freqs.new);
+
 	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
-#elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
-	freq = target_freq * 1000;
-	if (opp_find_freq_ceil(mpu_dev, &freq))
-		omap_pm_cpu_set_freq(freq);
-#endif
+
 	return ret;
 }
 
 static int __init omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
+	struct device *mpu_dev;
+
+	if (cpu_is_omap24xx())
+		mpu_clk = clk_get(NULL, "virt_prcm_set");
+	else if (cpu_is_omap34xx())
+		mpu_clk = clk_get(NULL, "dpll1_ck");
+	else if (cpu_is_omap34xx())
+		mpu_clk = clk_get(NULL, "dpll_mpu_ck");
 
-	mpu_clk = clk_get(NULL, MPU_CLK);
 	if (IS_ERR(mpu_clk))
 		return PTR_ERR(mpu_clk);
 
@@ -136,13 +134,12 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cur = policy->min = policy->max = omap_getspeed(0);
 
-	if (!cpu_is_omap34xx()) {
-		clk_init_cpufreq_table(&freq_table);
-	} else {
-		struct device *mpu_dev = omap2_get_mpuss_device();
-
-		opp_init_cpufreq_table(mpu_dev, &freq_table);
+	mpu_dev = omap2_get_mpuss_device();
+	if (!mpu_dev) {
+		pr_warning("%s: unable to get the mpu device\n", __func__);
+		return -EINVAL;
 	}
+	opp_init_cpufreq_table(mpu_dev, &freq_table);
 
 	if (freq_table) {
 		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
@@ -184,7 +181,7 @@ static struct cpufreq_driver omap_driver = {
 	.get		= omap_getspeed,
 	.init		= omap_cpu_init,
 	.exit		= omap_cpu_exit,
-	.name		= "omap",
+	.name		= "omap2plus",
 	.attr		= omap_cpufreq_attr,
 };
 
@@ -193,12 +190,12 @@ static int __init omap_cpufreq_init(void)
 	return cpufreq_register_driver(&omap_driver);
 }
 
-late_initcall(omap_cpufreq_init);
-
-/*
- * if ever we want to remove this, upon cleanup call:
- *
- * cpufreq_unregister_driver()
- * cpufreq_frequency_table_put_attr()
- */
+static void __exit omap_cpufreq_exit(void)
+{
+	cpufreq_unregister_driver(&omap_driver);
+}
 
+MODULE_DESCRIPTION("cpufreq driver for OMAP2PLUS SOCs");
+MODULE_LICENSE("GPL");
+module_init(omap_cpufreq_init);
+module_exit(omap_cpufreq_exit);
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index a4a1285..ec7862e 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o
 obj-$(CONFIG_OMAP_IOMMU_DEBUG) += iommu-debug.o
 
-obj-$(CONFIG_CPU_FREQ) += cpu-omap.o
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
-- 
1.6.0.4

