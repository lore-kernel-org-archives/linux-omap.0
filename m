From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/6] thermal/drivers/cpu_cooling: Unregister with the policy
Date: Fri, 21 Jun 2019 15:22:58 +0200
Message-ID: <20190621132302.30414-2-daniel.lezcano@linaro.org>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190621132302.30414-1-daniel.lezcano@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: viresh.kumar@linaro.org
Cc: Keerthy <j-keerthy@ti.com>, "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" <linux-pm@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, edubezval@gmail.com, "open list:TI BANDGAP AND THERMAL DRIVER" <linux-omap@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Currently the function cpufreq_cooling_register() returns a cooling
device pointer which is used back as a pointer to call the function
cpufreq_cooling_unregister(). Even if it is correct, it would make
sense to not leak the structure inside a cpufreq driver and keep the
code thermal code self-encapsulate. Moreover, that forces to add an
extra variable in each driver using this function.

Instead of passing the cooling device to unregister, pass the policy.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/arm_big_little.c               |  2 +-
 drivers/cpufreq/cpufreq.c                      |  2 +-
 drivers/thermal/cpu_cooling.c                  | 18 ++++++++++--------
 drivers/thermal/imx_thermal.c                  |  4 ++--
 .../thermal/ti-soc-thermal/ti-thermal-common.c |  2 +-
 include/linux/cpu_cooling.h                    |  6 +++---
 6 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 7fe52fcddcf1..6b243202caa9 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -502,7 +502,7 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 	int cur_cluster = cpu_to_cluster(policy->cpu);
 
 	if (cur_cluster < MAX_CLUSTERS) {
-		cpufreq_cooling_unregister(cdev[cur_cluster]);
+		cpufreq_cooling_unregister(policy);
 		cdev[cur_cluster] = NULL;
 	}
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7c72f7d3509c..dfbc9bea606c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1469,7 +1469,7 @@ static int cpufreq_offline(unsigned int cpu)
 	}
 
 	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
-		cpufreq_cooling_unregister(policy->cdev);
+		cpufreq_cooling_unregister(policy);
 		policy->cdev = NULL;
 	}
 
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 83486775e593..007c7c6bf845 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -78,6 +78,7 @@ struct cpufreq_cooling_device {
 	struct cpufreq_policy *policy;
 	struct list_head node;
 	struct time_in_idle *idle_time;
+	struct thermal_cooling_device *cdev;
 };
 
 static DEFINE_IDA(cpufreq_ida);
@@ -606,6 +607,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		goto remove_ida;
 
 	cpufreq_cdev->clipped_freq = get_state_freq(cpufreq_cdev, 0);
+	cpufreq_cdev->cdev = cdev;
 
 	mutex_lock(&cooling_list_lock);
 	/* Register the notifier for first cpufreq cooling device */
@@ -699,18 +701,18 @@ EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
  *
  * This interface function unregisters the "thermal-cpufreq-%x" cooling device.
  */
-void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
+void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev;
 	bool last;
 
-	if (!cdev)
-		return;
-
-	cpufreq_cdev = cdev->devdata;
-
 	mutex_lock(&cooling_list_lock);
-	list_del(&cpufreq_cdev->node);
+	list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
+		if (cpufreq_cdev->policy == policy) {
+			list_del(&cpufreq_cdev->node);
+			break;
+		}
+	}
 	/* Unregister the notifier for the last cpufreq cooling device */
 	last = list_empty(&cpufreq_cdev_list);
 	mutex_unlock(&cooling_list_lock);
@@ -719,7 +721,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
 					    CPUFREQ_POLICY_NOTIFIER);
 
-	thermal_cooling_device_unregister(cdev);
+	thermal_cooling_device_unregister(cpufreq_cdev->cdev);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 	kfree(cpufreq_cdev->idle_time);
 	kfree(cpufreq_cdev);
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index bb6754a5342c..6746f1b73eb7 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -680,7 +680,7 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
 
 static void imx_thermal_unregister_legacy_cooling(struct imx_thermal_data *data)
 {
-	cpufreq_cooling_unregister(data->cdev);
+	cpufreq_cooling_unregister(data->policy);
 	cpufreq_cpu_put(data->policy);
 }
 
@@ -872,7 +872,7 @@ static int imx_thermal_remove(struct platform_device *pdev)
 		clk_disable_unprepare(data->thermal_clk);
 
 	thermal_zone_device_unregister(data->tz);
-	cpufreq_cooling_unregister(data->cdev);
+	cpufreq_cooling_unregister(data->policy);
 	cpufreq_cpu_put(data->policy);
 
 	return 0;
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index b4f981daeaf2..217b1aae8b4f 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -277,7 +277,7 @@ int ti_thermal_unregister_cpu_cooling(struct ti_bandgap *bgp, int id)
 	data = ti_bandgap_get_sensor_data(bgp, id);
 
 	if (data) {
-		cpufreq_cooling_unregister(data->cool_dev);
+		cpufreq_cooling_unregister(data->policy);
 		if (data->policy)
 			cpufreq_cpu_put(data->policy);
 	}
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index bae54bb7c048..89f469ee4be4 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -29,9 +29,9 @@ cpufreq_cooling_register(struct cpufreq_policy *policy);
 
 /**
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
- * @cdev: thermal cooling device pointer.
+ * @policy: cpufreq policy
  */
-void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
+void cpufreq_cooling_unregister(struct cpufreq_policy *policy);
 
 #else /* !CONFIG_CPU_THERMAL */
 static inline struct thermal_cooling_device *
@@ -41,7 +41,7 @@ cpufreq_cooling_register(struct cpufreq_policy *policy)
 }
 
 static inline
-void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
+void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
 {
 	return;
 }
-- 
2.17.1
