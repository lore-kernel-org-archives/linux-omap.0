From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 07/17] thermal: cpu_cooling: use cpufreq_policy to register cooling device
Date: Wed, 19 Apr 2017 10:59:02 +0530
Message-ID: <cfd2b62fffd70ca1af0138ea95d1f49a8ad60918.1492579345.git.viresh.kumar@linaro.org>
References: <cover.1492579345.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1492579345.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492579345.git.viresh.kumar@linaro.org>
References: <cover.1492579345.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The CPU cooling driver uses the cpufreq policy, to get clip_cpus, the
frequency table, etc. Most of the callers of CPU cooling driver's
registration routines have the cpufreq policy with them, but they only
pass the policy->related_cpus cpumask. The __cpufreq_cooling_register()
routine then gets the policy by itself and uses it.

It would be much better if the callers can pass the policy instead
directly. This also fixes a basic design flaw, where the policy can be
freed while the CPU cooling driver is still active.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c                   |  2 +-
 drivers/cpufreq/cpufreq-dt.c                       |  2 +-
 drivers/cpufreq/dbx500-cpufreq.c                   |  2 +-
 drivers/cpufreq/mt8173-cpufreq.c                   |  4 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |  3 +-
 drivers/thermal/cpu_cooling.c                      | 61 ++++++++--------------
 drivers/thermal/imx_thermal.c                      | 22 ++++++--
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 22 +++++---
 include/linux/cpu_cooling.h                        | 26 ++++-----
 9 files changed, 74 insertions(+), 70 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 418042201e6d..ea6d62547b10 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -540,7 +540,7 @@ static void bL_cpufreq_ready(struct cpufreq_policy *policy)
 				     &power_coefficient);
 
 		cdev[cur_cluster] = of_cpufreq_power_cooling_register(np,
-				policy->related_cpus, power_coefficient, NULL);
+				policy, power_coefficient, NULL);
 		if (IS_ERR(cdev[cur_cluster])) {
 			dev_err(cpu_dev,
 				"running cpufreq without cooling device: %ld\n",
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index c943787d761e..fef3c2160691 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -326,7 +326,7 @@ static void cpufreq_ready(struct cpufreq_policy *policy)
 				     &power_coefficient);
 
 		priv->cdev = of_cpufreq_power_cooling_register(np,
-				policy->related_cpus, power_coefficient, NULL);
+				policy, power_coefficient, NULL);
 		if (IS_ERR(priv->cdev)) {
 			dev_err(priv->cpu_dev,
 				"running cpufreq without cooling device: %ld\n",
diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 3575b82210ba..4ee0431579c1 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -43,7 +43,7 @@ static int dbx500_cpufreq_exit(struct cpufreq_policy *policy)
 
 static void dbx500_cpufreq_ready(struct cpufreq_policy *policy)
 {
-	cdev = cpufreq_cooling_register(policy->cpus);
+	cdev = cpufreq_cooling_register(policy);
 	if (IS_ERR(cdev))
 		pr_err("Failed to register cooling device %ld\n", PTR_ERR(cdev));
 	else
diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index fd1886faf33a..f9f00fb4bc3a 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -320,9 +320,7 @@ static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
 		of_property_read_u32(np, DYNAMIC_POWER, &capacitance);
 
 		info->cdev = of_cpufreq_power_cooling_register(np,
-						policy->related_cpus,
-						capacitance,
-						NULL);
+						policy, capacitance, NULL);
 
 		if (IS_ERR(info->cdev)) {
 			dev_err(info->cpu_dev,
diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index e2ea433a5f9c..4ada55b8856e 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -278,8 +278,7 @@ static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
 	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
 
 	if (of_find_property(np, "#cooling-cells", NULL)) {
-		cpud->cdev = of_cpufreq_cooling_register(np,
-							 policy->related_cpus);
+		cpud->cdev = of_cpufreq_cooling_register(np, policy);
 
 		if (IS_ERR(cpud->cdev) && PTR_ERR(cpud->cdev) != -ENOSYS) {
 			pr_err("cpu%d is not running as cooling device: %ld\n",
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 002b48dc6bea..58e58065b650 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -717,7 +717,7 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
 /**
  * __cpufreq_cooling_register - helper function to create cpufreq cooling device
  * @np: a valid struct device_node to the cooling device device tree node
- * @clip_cpus: cpumask of cpus where the frequency constraints will happen.
+ * @policy: cpufreq policy
  * Normally this should be same as cpufreq policy->related_cpus.
  * @capacitance: dynamic power coefficient for these cpus
  * @plat_static_func: function to calculate the static power consumed by these
@@ -733,45 +733,34 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
  */
 static struct thermal_cooling_device *
 __cpufreq_cooling_register(struct device_node *np,
-			const struct cpumask *clip_cpus, u32 capacitance,
+			struct cpufreq_policy *policy, u32 capacitance,
 			get_static_t plat_static_func)
 {
-	struct cpufreq_policy *policy;
 	struct thermal_cooling_device *cdev;
 	struct cpufreq_cooling_device *cpufreq_cdev;
 	char dev_name[THERMAL_NAME_LENGTH];
 	struct cpufreq_frequency_table *pos, *table;
-	cpumask_var_t temp_mask;
 	unsigned int freq, i, num_cpus;
 	int ret;
 	struct thermal_cooling_device_ops *cooling_ops;
 	bool first;
 
-	if (!alloc_cpumask_var(&temp_mask, GFP_KERNEL))
-		return ERR_PTR(-ENOMEM);
-
-	cpumask_and(temp_mask, clip_cpus, cpu_online_mask);
-	policy = cpufreq_cpu_get(cpumask_first(temp_mask));
-	if (!policy) {
-		pr_debug("%s: CPUFreq policy not found\n", __func__);
-		cdev = ERR_PTR(-EPROBE_DEFER);
-		goto free_cpumask;
+	if (IS_ERR_OR_NULL(policy)) {
+		pr_err("%s: cpufreq policy isn't valid: %p", __func__, policy);
+		return ERR_PTR(-EINVAL);
 	}
 
 	table = policy->freq_table;
 	if (!table) {
 		pr_debug("%s: CPUFreq table not found\n", __func__);
-		cdev = ERR_PTR(-ENODEV);
-		goto put_policy;
+		return ERR_PTR(-ENODEV);
 	}
 
 	cpufreq_cdev = kzalloc(sizeof(*cpufreq_cdev), GFP_KERNEL);
-	if (!cpufreq_cdev) {
-		cdev = ERR_PTR(-ENOMEM);
-		goto put_policy;
-	}
+	if (!cpufreq_cdev)
+		return ERR_PTR(-ENOMEM);
 
-	num_cpus = cpumask_weight(clip_cpus);
+	num_cpus = cpumask_weight(policy->related_cpus);
 	cpufreq_cdev->time_in_idle = kcalloc(num_cpus,
 					    sizeof(*cpufreq_cdev->time_in_idle),
 					    GFP_KERNEL);
@@ -802,7 +791,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	/* max_level is an index, not a counter */
 	cpufreq_cdev->max_level--;
 
-	cpumask_copy(&cpufreq_cdev->allowed_cpus, clip_cpus);
+	cpumask_copy(&cpufreq_cdev->allowed_cpus, policy->related_cpus);
 
 	if (capacitance) {
 		cpufreq_cdev->plat_get_static_power = plat_static_func;
@@ -858,7 +847,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
 					  CPUFREQ_POLICY_NOTIFIER);
 
-	goto put_policy;
+	return cdev;
 
 remove_ida:
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
@@ -872,16 +861,12 @@ __cpufreq_cooling_register(struct device_node *np,
 	kfree(cpufreq_cdev->time_in_idle);
 free_cdev:
 	kfree(cpufreq_cdev);
-put_policy:
-	cpufreq_cpu_put(policy);
-free_cpumask:
-	free_cpumask_var(temp_mask);
 	return cdev;
 }
 
 /**
  * cpufreq_cooling_register - function to create cpufreq cooling device.
- * @clip_cpus: cpumask of cpus where the frequency constraints will happen.
+ * @policy: cpufreq policy
  *
  * This interface function registers the cpufreq cooling device with the name
  * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
@@ -891,16 +876,16 @@ __cpufreq_cooling_register(struct device_node *np,
  * on failure, it returns a corresponding ERR_PTR().
  */
 struct thermal_cooling_device *
-cpufreq_cooling_register(const struct cpumask *clip_cpus)
+cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
-	return __cpufreq_cooling_register(NULL, clip_cpus, 0, NULL);
+	return __cpufreq_cooling_register(NULL, policy, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
 
 /**
  * of_cpufreq_cooling_register - function to create cpufreq cooling device.
  * @np: a valid struct device_node to the cooling device device tree node
- * @clip_cpus: cpumask of cpus where the frequency constraints will happen.
+ * @policy: cpufreq policy
  *
  * This interface function registers the cpufreq cooling device with the name
  * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
@@ -912,18 +897,18 @@ EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
  */
 struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
-			    const struct cpumask *clip_cpus)
+			    struct cpufreq_policy *policy)
 {
 	if (!np)
 		return ERR_PTR(-EINVAL);
 
-	return __cpufreq_cooling_register(np, clip_cpus, 0, NULL);
+	return __cpufreq_cooling_register(np, policy, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
 
 /**
  * cpufreq_power_cooling_register() - create cpufreq cooling device with power extensions
- * @clip_cpus:	cpumask of cpus where the frequency constraints will happen
+ * @policy:		cpufreq policy
  * @capacitance:	dynamic power coefficient for these cpus
  * @plat_static_func:	function to calculate the static power consumed by these
  *			cpus (optional)
@@ -943,10 +928,10 @@ EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
  * on failure, it returns a corresponding ERR_PTR().
  */
 struct thermal_cooling_device *
-cpufreq_power_cooling_register(const struct cpumask *clip_cpus, u32 capacitance,
+cpufreq_power_cooling_register(struct cpufreq_policy *policy, u32 capacitance,
 			       get_static_t plat_static_func)
 {
-	return __cpufreq_cooling_register(NULL, clip_cpus, capacitance,
+	return __cpufreq_cooling_register(NULL, policy, capacitance,
 				plat_static_func);
 }
 EXPORT_SYMBOL(cpufreq_power_cooling_register);
@@ -954,7 +939,7 @@ EXPORT_SYMBOL(cpufreq_power_cooling_register);
 /**
  * of_cpufreq_power_cooling_register() - create cpufreq cooling device with power extensions
  * @np:	a valid struct device_node to the cooling device device tree node
- * @clip_cpus:	cpumask of cpus where the frequency constraints will happen
+ * @policy: cpufreq policy
  * @capacitance:	dynamic power coefficient for these cpus
  * @plat_static_func:	function to calculate the static power consumed by these
  *			cpus (optional)
@@ -976,14 +961,14 @@ EXPORT_SYMBOL(cpufreq_power_cooling_register);
  */
 struct thermal_cooling_device *
 of_cpufreq_power_cooling_register(struct device_node *np,
-				  const struct cpumask *clip_cpus,
+				  struct cpufreq_policy *policy,
 				  u32 capacitance,
 				  get_static_t plat_static_func)
 {
 	if (!np)
 		return ERR_PTR(-EINVAL);
 
-	return __cpufreq_cooling_register(np, clip_cpus, capacitance,
+	return __cpufreq_cooling_register(np, policy, capacitance,
 				plat_static_func);
 }
 EXPORT_SYMBOL(of_cpufreq_power_cooling_register);
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index fb648a45754e..f7ec39f46ee4 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/cpufreq.h>
 #include <linux/cpu_cooling.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -88,6 +89,7 @@ static struct thermal_soc_data thermal_imx6sx_data = {
 };
 
 struct imx_thermal_data {
+	struct cpufreq_policy *policy;
 	struct thermal_zone_device *tz;
 	struct thermal_cooling_device *cdev;
 	enum thermal_device_mode mode;
@@ -525,13 +527,18 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	regmap_write(map, MISC0 + REG_SET, MISC0_REFTOP_SELBIASOFF);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
 
-	data->cdev = cpufreq_cooling_register(cpu_present_mask);
+	data->policy = cpufreq_cpu_get(0);
+	if (!data->policy) {
+		pr_debug("%s: CPUFreq policy not found\n", __func__);
+		return -EPROBE_DEFER;
+	}
+
+	data->cdev = cpufreq_cooling_register(data->policy);
 	if (IS_ERR(data->cdev)) {
 		ret = PTR_ERR(data->cdev);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to register cpufreq cooling device: %d\n",
-				ret);
+		dev_err(&pdev->dev,
+			"failed to register cpufreq cooling device: %d\n", ret);
+		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
 
@@ -542,6 +549,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to get thermal clk: %d\n", ret);
 		cpufreq_cooling_unregister(data->cdev);
+		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
 
@@ -556,6 +564,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
 		cpufreq_cooling_unregister(data->cdev);
+		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
 
@@ -571,6 +580,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 			"failed to register thermal zone device %d\n", ret);
 		clk_disable_unprepare(data->thermal_clk);
 		cpufreq_cooling_unregister(data->cdev);
+		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
 
@@ -599,6 +609,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		clk_disable_unprepare(data->thermal_clk);
 		thermal_zone_device_unregister(data->tz);
 		cpufreq_cooling_unregister(data->cdev);
+		cpufreq_cpu_put(data->policy);
 		return ret;
 	}
 
@@ -620,6 +631,7 @@ static int imx_thermal_remove(struct platform_device *pdev)
 
 	thermal_zone_device_unregister(data->tz);
 	cpufreq_cooling_unregister(data->cdev);
+	cpufreq_cpu_put(data->policy);
 
 	return 0;
 }
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 0586bd0f2bab..cfc851d76d4b 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -28,6 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
 #include <linux/thermal.h>
+#include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_cooling.h>
 #include <linux/of.h>
@@ -37,6 +38,7 @@
 
 /* common data structures */
 struct ti_thermal_data {
+	struct cpufreq_policy *policy;
 	struct thermal_zone_device *ti_thermal;
 	struct thermal_zone_device *pcb_tz;
 	struct thermal_cooling_device *cool_dev;
@@ -395,15 +397,19 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 	if (!data)
 		return -EINVAL;
 
+	data->policy = cpufreq_cpu_get(0);
+	if (!data->policy) {
+		pr_debug("%s: CPUFreq policy not found\n", __func__);
+		return -EPROBE_DEFER;
+	}
+
 	/* Register cooling device */
-	data->cool_dev = cpufreq_cooling_register(cpu_present_mask);
+	data->cool_dev = cpufreq_cooling_register(data->policy);
 	if (IS_ERR(data->cool_dev)) {
 		int ret = PTR_ERR(data->cool_dev);
-
-		if (ret != -EPROBE_DEFER)
-			dev_err(bgp->dev,
-				"Failed to register cpu cooling device %d\n",
-				ret);
+		dev_err(bgp->dev, "Failed to register cpu cooling device %d\n",
+			ret);
+		cpufreq_cpu_put(data->policy);
 
 		return ret;
 	}
@@ -418,8 +424,10 @@ int ti_thermal_unregister_cpu_cooling(struct ti_bandgap *bgp, int id)
 
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
-	if (data)
+	if (data) {
 		cpufreq_cooling_unregister(data->cool_dev);
+		cpufreq_cpu_put(data->policy);
+	}
 
 	return 0;
 }
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 96c5e4c2f9c8..d4292ebc5c8b 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -28,47 +28,49 @@
 #include <linux/thermal.h>
 #include <linux/cpumask.h>
 
+struct cpufreq_policy;
+
 typedef int (*get_static_t)(cpumask_t *cpumask, int interval,
 			    unsigned long voltage, u32 *power);
 
 #ifdef CONFIG_CPU_THERMAL
 /**
  * cpufreq_cooling_register - function to create cpufreq cooling device.
- * @clip_cpus: cpumask of cpus where the frequency constraints will happen
+ * @policy: cpufreq policy.
  */
 struct thermal_cooling_device *
-cpufreq_cooling_register(const struct cpumask *clip_cpus);
+cpufreq_cooling_register(struct cpufreq_policy *policy);
 
 struct thermal_cooling_device *
-cpufreq_power_cooling_register(const struct cpumask *clip_cpus,
+cpufreq_power_cooling_register(struct cpufreq_policy *policy,
 			       u32 capacitance, get_static_t plat_static_func);
 
 /**
  * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
  * @np: a valid struct device_node to the cooling device device tree node.
- * @clip_cpus: cpumask of cpus where the frequency constraints will happen
+ * @policy: cpufreq policy.
  */
 #ifdef CONFIG_THERMAL_OF
 struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
-			    const struct cpumask *clip_cpus);
+			    struct cpufreq_policy *policy);
 
 struct thermal_cooling_device *
 of_cpufreq_power_cooling_register(struct device_node *np,
-				  const struct cpumask *clip_cpus,
+				  struct cpufreq_policy *policy,
 				  u32 capacitance,
 				  get_static_t plat_static_func);
 #else
 static inline struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
-			    const struct cpumask *clip_cpus)
+			    struct cpufreq_policy *policy)
 {
 	return ERR_PTR(-ENOSYS);
 }
 
 static inline struct thermal_cooling_device *
 of_cpufreq_power_cooling_register(struct device_node *np,
-				  const struct cpumask *clip_cpus,
+				  struct cpufreq_policy *policy,
 				  u32 capacitance,
 				  get_static_t plat_static_func)
 {
@@ -84,12 +86,12 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
 
 #else /* !CONFIG_CPU_THERMAL */
 static inline struct thermal_cooling_device *
-cpufreq_cooling_register(const struct cpumask *clip_cpus)
+cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	return ERR_PTR(-ENOSYS);
 }
 static inline struct thermal_cooling_device *
-cpufreq_power_cooling_register(const struct cpumask *clip_cpus,
+cpufreq_power_cooling_register(struct cpufreq_policy *policy,
 			       u32 capacitance, get_static_t plat_static_func)
 {
 	return NULL;
@@ -97,14 +99,14 @@ cpufreq_power_cooling_register(const struct cpumask *clip_cpus,
 
 static inline struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct device_node *np,
-			    const struct cpumask *clip_cpus)
+			    struct cpufreq_policy *policy)
 {
 	return ERR_PTR(-ENOSYS);
 }
 
 static inline struct thermal_cooling_device *
 of_cpufreq_power_cooling_register(struct device_node *np,
-				  const struct cpumask *clip_cpus,
+				  struct cpufreq_policy *policy,
 				  u32 capacitance,
 				  get_static_t plat_static_func)
 {
-- 
2.12.0.432.g71c3a4f4ba37
