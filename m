From: Antonio Barbalace <antoniob@vt.edu>
Subject: support cpufreq on 3.0.10-rt27
Date: Fri, 13 Jan 2012 10:29:21 -0500
Message-ID: <20120113102921.69979y5qipcdv2z5@webmail.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lennier.cc.vt.edu ([198.82.162.213]:49555 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164Ab2AMP3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 10:29:22 -0500
Received: from zidane.cc.vt.edu (zidane.cc.vt.edu [198.82.163.227])
	by lennier.cc.vt.edu (8.13.8/8.13.8) with ESMTP id q0DFTL5l004434
	for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 10:29:21 -0500
Received: from imp-b08.cc.vt.edu (imp-b08.cc.vt.edu [127.0.0.1])
	by imp-b08.cc.vt.edu (8.13.8/8.13.8) with ESMTP id q0DFTLnZ013532
	for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 10:29:21 -0500
Received: (from apache@localhost)
	by imp-b08.cc.vt.edu (8.13.8/8.13.8/Submit) id q0DFTLxk013531
	for linux-omap@vger.kernel.org; Fri, 13 Jan 2012 10:29:21 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

With the help of Mike Turquette I have integrated Kevin's PM work on
3.0.10-rt27. cpufreq-omap work independently of rt patches.

Antonio

---

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index e10ff2b..8e6c8bc 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -141,13 +141,13 @@ extern const struct clksel_rate gpt_sys_rates[];
  extern const struct clksel_rate gfx_l3_rates[];
  extern const struct clksel_rate dsp_ick_rates[];

-#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_CPU_FREQ)
+//#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_CPU_FREQ)
  extern void omap2_clk_init_cpufreq_table(struct  
cpufreq_frequency_table **table);
  extern void omap2_clk_exit_cpufreq_table(struct  
cpufreq_frequency_table **table);
-#else
-#define omap2_clk_init_cpufreq_table	0
-#define omap2_clk_exit_cpufreq_table	0
-#endif
+//#else
+//#define omap2_clk_init_cpufreq_table	0
+//#define omap2_clk_exit_cpufreq_table	0
+//#endif

  extern const struct clkops clkops_omap2_iclk_dflt_wait;
  extern const struct clkops clkops_omap2_iclk_dflt;
diff --git a/arch/arm/mach-omap2/clock44xx_data.c
b/arch/arm/mach-omap2/clock44xx_data.c
index 8c96567..c714963 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -740,8 +740,8 @@ static struct dpll_data dpll_mpu_dd = {
  	.enable_mask	= OMAP4430_DPLL_EN_MASK,
  	.autoidle_mask	= OMAP4430_AUTO_DPLL_MODE_MASK,
  	.idlest_mask	= OMAP4430_ST_DPLL_CLK_MASK,
-	.max_multiplier	= OMAP4430_MAX_DPLL_MULT,
-	.max_divider	= OMAP4430_MAX_DPLL_DIV,
+	.max_multiplier	= 2047,
+	.max_divider	= 128,
  	.min_divider	= 1,
  };

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 49486f5..22af291 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -63,9 +63,12 @@ static int _init_omap_device(char *name, struct  
device **new_dev)
  	struct omap_device *od;

  	oh = omap_hwmod_lookup(name);
-	if (WARN(!oh, "%s: could not find omap_hwmod for %s\n",
-		 __func__, name))
+	//if (WARN(!oh, "%s: could not find omap_hwmod for %s\n",
+		// __func__, name))
+	if (!oh) {
+		printk( "%s: could not find omap_hwmod for %s\n", __func__, name);
  		return -ENODEV;
+	}

  	od = omap_device_build(oh->name, 0, oh, NULL, 0, pm_lats, 0, false);
  	if (WARN(IS_ERR(od), "%s: could not build omap_device for %s\n",

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index c9122dd..71ff153 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -20,6 +20,7 @@
  #include <linux/mutex.h>
  #include <linux/cpufreq.h>
  #include <linux/debugfs.h>
+#include <linux/seq_file.h>
  #include <linux/io.h>

  #include <plat/clock.h>
@@ -475,8 +476,38 @@ int __init clk_init(struct clk_functions * custom_clocks)
  /*
   *	debugfs support to trace clock tree hierarchy and attributes
   */
+
  static struct dentry *clk_debugfs_root;

+static int clk_dbg_show_summary(struct seq_file *s, void *unused)
+{
+    struct clk *c;
+    struct clk *pa;
+
+    seq_printf(s, "%-30s %-30s %-10s %s\n",
+	"clock-name", "parent-name", "rate", "use-count");
+
+    list_for_each_entry(c, &clocks, node) {
+	pa = c->parent;
+	seq_printf(s, "%-30s %-30s %-10lu %d\n",
+	c->name, pa ? pa->name : "none", c->rate, c->usecount);
+    }
+
+    return 0;
+}
+
+static int clk_dbg_open(struct inode *inode, struct file *file)
+{
+    return single_open(file, clk_dbg_show_summary, inode->i_private);
+}
+
+static const struct file_operations debug_clock_fops = {
+    .open = clk_dbg_open,
+    .read = seq_read,
+    .llseek = seq_lseek,
+    .release = single_release,
+};
+
  static int clk_debugfs_register_one(struct clk *c)
  {
  	int err;
@@ -551,6 +582,12 @@ static int __init clk_debugfs_init(void)
  		if (err)
  			goto err_out;
  	}
+
+	d = debugfs_create_file("summary", S_IRUGO,
+			d, NULL, &debug_clock_fops);
+	if (!d)
+	      return -ENOMEM;
+
  	return 0;
  err_out:
  	debugfs_remove_recursive(clk_debugfs_root);
diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index cc4c9e1..d087882 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -21,37 +21,54 @@
  #include <linux/err.h>
  #include <linux/clk.h>
  #include <linux/io.h>
+#include <linux/cpu.h>

-#include <mach/hardware.h>
-#include <plat/clock.h>
  #include <asm/system.h>
+#include <asm/smp_plat.h>
+#include <asm/cpu.h>
+
+#include <plat/clock.h>
+#include <plat/omap-pm.h>
+#include <plat/common.h>
+#include <plat/omap_device.h>
+
+#include <mach/hardware.h>
+
+
+// NOTA this code take kHz
+

  //#define VERY_HI_RATE	900000000
-#define VERY_HI_RATE	1500000000
+#define VERY_LO_RATE	38400000
+#define VERY_HI_RATE	1200000000

-static struct cpufreq_frequency_table *freq_table;
+#ifdef CONFIG_SMP
+struct lpj_info {
+unsigned long ref;
+unsigned int freq;
+};

-#ifdef CONFIG_ARCH_OMAP1
-#define MPU_CLK		"mpu"
-#else
-#define MPU_CLK		"virt_prcm_set"
-#endif
+static DEFINE_PER_CPU(struct lpj_info, lpj_ref);
+static struct lpj_info global_lpj_ref;
+#endif /* CONFIG_SMP */
+
+static struct cpufreq_frequency_table *freq_table;
+static atomic_t freq_table_users = ATOMIC_INIT(0);

  #define CONFIG_CPU_FREQ_DEBUG

  static struct clk *mpu_clk;
+static char *mpu_clk_name = 0;
+static struct device *mpu_dev;

  /* TODO: Add support for SDRAM timing changes */

-// TODO multiprocessor aware
-// TODO transition_latency
-
  static int omap_verify_speed(struct cpufreq_policy *policy)
  {
  	if (freq_table)
  		return cpufreq_frequency_table_verify(policy, freq_table);

-	if (policy->cpu)
+	if (policy->cpu >= NR_CPUS)
  		return -EINVAL;

  	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
@@ -68,7 +85,7 @@ static unsigned int omap_getspeed(unsigned int cpu)
  {
  	unsigned long rate;

-	if (cpu)
+	if (cpu >= NR_CPUS)
  		return 0;

  	rate = clk_get_rate(mpu_clk) / 1000;
@@ -79,31 +96,71 @@ static int omap_target(struct cpufreq_policy *policy,
  		       unsigned int target_freq,
  		       unsigned int relation)
  {
+	unsigned int i;
+	int ret = 0;
  	struct cpufreq_freqs freqs;
-	int ret = 0;
-
+
  	/* Ensure desired rate is within allowed range.  Some govenors
  	 * (ondemand) will just pass target_freq=0 to get the minimum. */
+//TODO to comply with the freqtable START replace code here
  	if (target_freq < policy->min)
  		target_freq = policy->min;
  	if (target_freq > policy->max)
  		target_freq = policy->max;

-	freqs.old = omap_getspeed(0);
+	freqs.old = omap_getspeed(policy->cpu);
  	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
-	freqs.cpu = 0;
+	freqs.cpu = policy->cpu;
+//TODO to comply with the freqtable END replace code here

  	if (freqs.old == freqs.new)
  		return ret;

-	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	/* notifiers */
+	for_each_cpu(i, policy->cpus) {
+	      freqs.cpu = i;
+	      cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	}
  #ifdef CONFIG_CPU_FREQ_DEBUG
-	printk(KERN_DEBUG "cpufreq-omap: transition: %u --> %u\n",
+	pr_info(KERN_DEBUG "cpufreq-omap: transition: %u --> %u\n",
  	       freqs.old, freqs.new);
  #endif
  	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
-	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	freqs.new = omap_getspeed(policy->cpu);
+
+	//adjust jiffies here
+#ifdef CONFIG_SMP
+	/*
+	 * Note that loops_per_jiffy is not updated on SMP systems in
+	 * cpufreq driver. So, update the per-CPU loops_per_jiffy value
+	 * on frequency transition. We need to update all dependent CPUs.
+	 */
+	for_each_cpu(i, policy->cpus) {
+		struct lpj_info *lpj = &per_cpu(lpj_ref, i);
+		if (!lpj->freq) {
+		    lpj->ref = per_cpu(cpu_data, i).loops_per_jiffy;
+		    lpj->freq = freqs.old;
+		}
+
+		per_cpu(cpu_data, i).loops_per_jiffy =
+			cpufreq_scale(lpj->ref, lpj->freq, freqs.new);
+	}

+	/* And don't forget to adjust the global one */
+	if (!global_lpj_ref.freq) {
+		global_lpj_ref.ref = loops_per_jiffy;
+		global_lpj_ref.freq = freqs.old;
+	}
+	loops_per_jiffy = cpufreq_scale(global_lpj_ref.ref, global_lpj_ref.freq,
+					freqs.new);
+#endif
+
+	 /* notifiers */
+	for_each_cpu(i, policy->cpus) {
+	      freqs.cpu = i;
+	      cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+	}
+
  	return ret;
  }

@@ -111,33 +168,63 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy
*policy)
  {
  	int result = 0;

-	// TODO how many MPU_CLK there are in a dual core ARM ?!
-	mpu_clk = clk_get(NULL, MPU_CLK);
-	if (IS_ERR(mpu_clk))
+	// how many MPU_CLK there are in a dual core ARM ?!
+	mpu_clk = clk_get(NULL, mpu_clk_name);
+	if (IS_ERR(mpu_clk)) {
+		printk("cpufreq-omap: mpu_clk err\n");
  		return PTR_ERR(mpu_clk);
+	}

-	if (policy->cpu != 0)
+	if (policy->cpu >= NR_CPUS) {
+	  	printk("cpufreq-omap: policy->cpu >= NR_CPUS\n");
  		return -EINVAL;
+	}

-	policy->cur = policy->min = policy->max = omap_getspeed(0);
-
-	clk_init_cpufreq_table(&freq_table);
+	policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
+
+	if (atomic_inc_return(&freq_table_users) == 1)
+		result = opp_init_cpufreq_table(mpu_dev,  &freq_table);
+		//clk_init_cpufreq_table(&freq_table);
+
+//	if (!freq_table) {
+	if (result) {
+//		 dev_err(mpu_dev, "%s: cpu:%d: failed creating freq table[%d]\n",
+//			 __func__, policy->cpu, result);
+//		 goto fail_ck;
+		 printk("%s: cpu:%d: failed creating freq table[%d] 0x%p\n",
+			 __func__, policy->cpu, result, freq_table);
+	}
+
+//	clk_init_cpufreq_table(&freq_table);
  	if (freq_table) {
  		result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
  		if (!result)
  			cpufreq_frequency_table_get_attr(freq_table,
  							policy->cpu);
  	} else {
-		policy->cpuinfo.min_freq = clk_round_rate(mpu_clk, 0) / 1000;
+		policy->cpuinfo.min_freq = clk_round_rate(mpu_clk,
+							VERY_LO_RATE) / 1000;
  		policy->cpuinfo.max_freq = clk_round_rate(mpu_clk,
  							VERY_HI_RATE) / 1000;
  	}

-	/* FIXME: what's the actual transition time? */
+	policy->min = policy->cpuinfo.min_freq;
+	policy->max = policy->cpuinfo.max_freq;
+
+	if (is_smp()) {
+	  //policy->shared_type = CPUFREQ_TYPE_ANY;
+	  cpumask_setall(policy->cpus);
+	}
+	/* on OMAP smp configuration both processors share the voltage and clock.
+	 * Is this really true?!?!
+	 */
+
+	/* FIXME: what's the actual transition time? */ //still to be fixed  
in latest
patches
  	policy->cpuinfo.transition_latency = 300 * 1000;
  #ifdef CONFIG_CPU_FREQ_DEBUG
-	printk(KERN_DEBUG "cpufreq-omap: getspeed: %u min %u max %u\n",
-	       policy->cur, policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
+	printk("%s: cpu:%d: getspeed: %u min %u max %u\n",
+		__func__, policy->cpu,
+		policy->cur, policy->min, policy->max);
  #endif

  	return 0;
@@ -145,7 +232,9 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy
*policy)

  static int omap_cpu_exit(struct cpufreq_policy *policy)
  {
-	clk_exit_cpufreq_table(&freq_table);
+	if (atomic_dec_and_test(&freq_table_users))
+	    clk_exit_cpufreq_table(&freq_table);
+
  	clk_put(mpu_clk);
  	return 0;
  }
@@ -168,11 +257,32 @@ static struct cpufreq_driver omap_driver = {

  static int __init omap_cpufreq_init(void)
  {
-  	printk(KERN_INFO "cpufreq-omap: cpufreq_register_driver\n");
+	if (cpu_is_omap24xx())
+		mpu_clk_name = "virt_prcm_set";
+	else if (cpu_is_omap34xx())
+		mpu_clk_name = "dpll1_ck";
+	else if (cpu_is_omap44xx())
+		mpu_clk_name = "dpll_mpu_ck";
+
+	if (!mpu_clk_name) {
+		pr_err("%s: unsupported Silicon?\n", __func__);
+		return -EINVAL;
+	}
+
+	mpu_dev = omap_device_get_by_hwmod_name("mpu");
+	if (!mpu_dev) {
+		pr_err("%s: unable to get the mpu device\n", __func__);
+		return -EINVAL;
+	}
+	//antonio
+	//printk("%s: cpufreq mpu dev %p\n", __func__, mpu_dev);
+
  	return cpufreq_register_driver(&omap_driver);
  }

-arch_initcall(omap_cpufreq_init);
+//arch_initcall(omap_cpufreq_init);
+//the following solve all the problems (run with it to do not have  
freq limits)
+device_initcall(omap_cpufreq_init);

  /*
   * if ever we want to remove this, upon cleanup call:
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h
b/arch/arm/plat-omap/include/plat/omap_device.h
index e4c349f..40e8718 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -111,6 +111,8 @@ u32 omap_device_get_context_loss_count(struct
platform_device *pdev);

  /* Other */

+struct device *omap_device_get_by_hwmod_name(const char *oh_name);
+
  int omap_device_idle_hwmods(struct omap_device *od);
  int omap_device_enable_hwmods(struct omap_device *od);

diff --git a/arch/arm/plat-omap/omap_device.c  
b/arch/arm/plat-omap/omap_device.c
index 49fc0df..65ab8b0 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -436,6 +436,7 @@ struct omap_device *omap_device_build_ss(const char
*pdev_name, int pdev_id,
  {
  	int ret = -ENOMEM;
  	struct omap_device *od;
+
  	char *pdev_name2;
  	struct resource *res = NULL;
  	int i, res_count;
@@ -612,6 +613,7 @@ int omap_device_enable(struct platform_device *pdev)
  	struct omap_device *od;

  	od = _find_by_pdev(pdev);
+	 //od = to_omap_device(pdev);

  	if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
  		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
@@ -786,6 +788,50 @@ void __iomem *omap_device_get_rt_va(struct  
omap_device *od)
   */

  /**
+ * omap_device_get_by_hwmod_name() - convert a hwmod name to
+ * device pointer.
+ * @oh_name: name of the hwmod device
+ *
+ * Returns back a struct device * pointer associated with a hwmod
+ * device represented by a hwmod_name
+ */
+struct device *omap_device_get_by_hwmod_name(const char *oh_name)
+{
+         struct omap_hwmod *oh;
+
+         if (!oh_name) {
+                 WARN(1, "%s: no hwmod name!\n", __func__);
+                 return ERR_PTR(-EINVAL);
+         }
+
+         oh = omap_hwmod_lookup(oh_name);
+ /*        if (IS_ERR_OR_NULL(oh)) {
+                 WARN(1, "%s: no hwmod for %s\n", __func__,
+                         oh_name);
+                 return ERR_PTR(oh ? PTR_ERR(oh) : -ENODEV);
+         }
+         if (IS_ERR_OR_NULL(oh->od)) {
+                 WARN(1, "%s: no omap_device for %s\n", __func__,
+                         oh_name);
+                 return ERR_PTR(oh->od ? PTR_ERR(oh->od) : -ENODEV);
+         }
+
+         if (IS_ERR_OR_NULL(oh->od->pdev))
+	    return ERR_PTR(oh->od->pdev ? PTR_ERR(oh->od->pdev) : -ENODEV);
+*/
+	// modified from arch/arm/mach-omap2/opp.c
+	if (!oh || !oh->od) {
+		WARN(1, "%s: no hwmod or odev for %s\n",
+		//printk("%s: no hwmod or odev for %s\n",
+			__func__, oh_name);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return 	&oh->od->pdev.dev;
+}
+EXPORT_SYMBOL(omap_device_get_by_hwmod_name);
+
+/**
   * omap_device_enable_hwmods - call omap_hwmod_enable() on all hwmods
   * @od: struct omap_device *od
   *
@@ -860,8 +906,13 @@ struct device omap_device_parent = {
  	.parent         = &platform_bus,
  };

+//static struct notifier_block platform_nb = {
+//   .notifier_call = _omap_device_notifier_call,
+//};
+
  static int __init omap_device_init(void)
  {
+   //bus_register_notifier(&platform_bus_type, &platform_nb);
  	return device_register(&omap_device_parent);
  }
  core_initcall(omap_device_init);
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ef063b6..4ae1b78 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -535,11 +535,12 @@ static ssize_t store_scaling_setspeed(struct
cpufreq_policy *policy,
  	unsigned int freq = 0;
  	unsigned int ret;

+	// performance governor does not allow us to change speed using the  
/sys interface
  	if (!policy->governor || !policy->governor->store_setspeed)
  		return -EINVAL;

  	ret = sscanf(buf, "%u", &freq);
-	if (ret != 1)
+	if (ret != 1)
  		return -EINVAL;

  	policy->governor->store_setspeed(policy, freq);

