From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V2 07/12] PM / OPP: Update OPP users to put reference
Date: Mon, 23 Jan 2017 10:11:47 +0530
Message-ID: <7fa4a831810fb7c6fdf7619686caed02765a34cc.1485146406.git.viresh.kumar@linaro.org>
References: <cover.1485146406.git.viresh.kumar@linaro.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1485146406.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1485146406.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1485146406.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Amit Daniel Kachhap <amit.kachhap-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Javi Merino <javi.merino-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <ru>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch updates dev_pm_opp_find_freq_*() routines to get a reference
to the OPPs returned by them.

Also updates the users of dev_pm_opp_find_freq_*() routines to call
dev_pm_opp_put() after they are done using the OPPs.

As it is guaranteed the that OPPs wouldn't get freed while being used,
the RCU read side locking present with the users isn't required anymore.
Drop it as well.

This patch also updates all users of devfreq_recommended_opp() which was
returning an OPP received from the OPP core.

Note that some of the OPP core routines have gained
rcu_read_{lock|unlock}() calls, as those still use RCU specific APIs
within them.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> [Devfreq]
---
 arch/arm/mach-omap2/pm.c             |   5 +-
 drivers/base/power/opp/core.c        | 114 +++++++++++++++++++----------------
 drivers/base/power/opp/cpu.c         |  22 ++-----
 drivers/clk/tegra/clk-dfll.c         |  17 ++----
 drivers/cpufreq/exynos5440-cpufreq.c |   5 +-
 drivers/cpufreq/imx6q-cpufreq.c      |  10 +--
 drivers/cpufreq/mt8173-cpufreq.c     |   8 +--
 drivers/cpufreq/omap-cpufreq.c       |   4 +-
 drivers/devfreq/devfreq.c            |  14 ++---
 drivers/devfreq/exynos-bus.c         |  14 ++---
 drivers/devfreq/governor_passive.c   |   4 +-
 drivers/devfreq/rk3399_dmc.c         |  16 ++---
 drivers/devfreq/tegra-devfreq.c      |   4 +-
 drivers/thermal/cpu_cooling.c        |  11 +---
 drivers/thermal/devfreq_cooling.c    |  15 ++---
 15 files changed, 110 insertions(+), 153 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 76b0454ddc49..0598630c1778 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -130,17 +130,16 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 	freq = clk_get_rate(clk);
 	clk_put(clk);
 
-	rcu_read_lock();
 	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
 	if (IS_ERR(opp)) {
-		rcu_read_unlock();
 		pr_err("%s: unable to find boot up OPP for vdd_%s\n",
 			__func__, vdd_name);
 		goto exit;
 	}
 
 	bootup_volt = dev_pm_opp_get_voltage(opp);
-	rcu_read_unlock();
+	dev_pm_opp_put(opp);
+
 	if (!bootup_volt) {
 		pr_err("%s: unable to find voltage corresponding to the bootup OPP for vdd_%s\n",
 		       __func__, vdd_name);
diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 9870ee54d708..a6efa818029a 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -40,6 +40,8 @@ do {									\
 			 "opp_table_lock protection");			\
 } while (0)
 
+static void dev_pm_opp_get(struct dev_pm_opp *opp);
+
 static struct opp_device *_find_opp_dev(const struct device *dev,
 					struct opp_table *opp_table)
 {
@@ -94,21 +96,13 @@ struct opp_table *_find_opp_table(struct device *dev)
  * return 0
  *
  * This is useful only for devices with single power supply.
- *
- * Locking: This function must be called under rcu_read_lock(). opp is a rcu
- * protected pointer. This means that opp which could have been fetched by
- * opp_find_freq_{exact,ceil,floor} functions is valid as long as we are
- * under RCU lock. The pointer returned by the opp_find_freq family must be
- * used in the same section as the usage of this function with the pointer
- * prior to unlocking with rcu_read_unlock() to maintain the integrity of the
- * pointer.
  */
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
 	struct dev_pm_opp *tmp_opp;
 	unsigned long v = 0;
 
-	opp_rcu_lockdep_assert();
+	rcu_read_lock();
 
 	tmp_opp = rcu_dereference(opp);
 	if (IS_ERR_OR_NULL(tmp_opp))
@@ -116,6 +110,7 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 	else
 		v = tmp_opp->supplies[0].u_volt;
 
+	rcu_read_unlock();
 	return v;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
@@ -126,21 +121,13 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
  *
  * Return: frequency in hertz corresponding to the opp, else
  * return 0
- *
- * Locking: This function must be called under rcu_read_lock(). opp is a rcu
- * protected pointer. This means that opp which could have been fetched by
- * opp_find_freq_{exact,ceil,floor} functions is valid as long as we are
- * under RCU lock. The pointer returned by the opp_find_freq family must be
- * used in the same section as the usage of this function with the pointer
- * prior to unlocking with rcu_read_unlock() to maintain the integrity of the
- * pointer.
  */
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 {
 	struct dev_pm_opp *tmp_opp;
 	unsigned long f = 0;
 
-	opp_rcu_lockdep_assert();
+	rcu_read_lock();
 
 	tmp_opp = rcu_dereference(opp);
 	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available)
@@ -148,6 +135,7 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 	else
 		f = tmp_opp->rate;
 
+	rcu_read_unlock();
 	return f;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
@@ -161,20 +149,13 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
  * quickly. Running on them for longer times may overheat the chip.
  *
  * Return: true if opp is turbo opp, else false.
- *
- * Locking: This function must be called under rcu_read_lock(). opp is a rcu
- * protected pointer. This means that opp which could have been fetched by
- * opp_find_freq_{exact,ceil,floor} functions is valid as long as we are
- * under RCU lock. The pointer returned by the opp_find_freq family must be
- * used in the same section as the usage of this function with the pointer
- * prior to unlocking with rcu_read_unlock() to maintain the integrity of the
- * pointer.
  */
 bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
 {
 	struct dev_pm_opp *tmp_opp;
+	bool turbo;
 
-	opp_rcu_lockdep_assert();
+	rcu_read_lock();
 
 	tmp_opp = rcu_dereference(opp);
 	if (IS_ERR_OR_NULL(tmp_opp) || !tmp_opp->available) {
@@ -182,7 +163,10 @@ bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
 		return false;
 	}
 
-	return tmp_opp->turbo;
+	turbo = tmp_opp->turbo;
+
+	rcu_read_unlock();
+	return turbo;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_is_turbo);
 
@@ -410,11 +394,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
  * This provides a mechanism to enable an opp which is not available currently
  * or the opposite as well.
  *
- * Locking: This function must be called under rcu_read_lock(). opp is a rcu
- * protected pointer. The reason for the same is that the opp pointer which is
- * returned will remain valid for use with opp_get_{voltage, freq} only while
- * under the locked area. The pointer returned must be used prior to unlocking
- * with rcu_read_unlock() to maintain the integrity of the pointer.
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
  */
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
@@ -423,13 +404,14 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 	struct opp_table *opp_table;
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
-	opp_rcu_lockdep_assert();
+	rcu_read_lock();
 
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		int r = PTR_ERR(opp_table);
 
 		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
+		rcu_read_unlock();
 		return ERR_PTR(r);
 	}
 
@@ -437,10 +419,15 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 		if (temp_opp->available == available &&
 				temp_opp->rate == freq) {
 			opp = temp_opp;
+
+			/* Increment the reference count of OPP */
+			dev_pm_opp_get(opp);
 			break;
 		}
 	}
 
+	rcu_read_unlock();
+
 	return opp;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
@@ -454,6 +441,9 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 		if (temp_opp->available && temp_opp->rate >= *freq) {
 			opp = temp_opp;
 			*freq = opp->rate;
+
+			/* Increment the reference count of OPP */
+			dev_pm_opp_get(opp);
 			break;
 		}
 	}
@@ -476,29 +466,33 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
  * ERANGE:	no match found for search
  * ENODEV:	if device not found in list of registered devices
  *
- * Locking: This function must be called under rcu_read_lock(). opp is a rcu
- * protected pointer. The reason for the same is that the opp pointer which is
- * returned will remain valid for use with opp_get_{voltage, freq} only while
- * under the locked area. The pointer returned must be used prior to unlocking
- * with rcu_read_unlock() to maintain the integrity of the pointer.
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
  */
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq)
 {
 	struct opp_table *opp_table;
-
-	opp_rcu_lockdep_assert();
+	struct dev_pm_opp *opp;
 
 	if (!dev || !freq) {
 		dev_err(dev, "%s: Invalid argument freq=%p\n", __func__, freq);
 		return ERR_PTR(-EINVAL);
 	}
 
+	rcu_read_lock();
+
 	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
+	if (IS_ERR(opp_table)) {
+		rcu_read_unlock();
 		return ERR_CAST(opp_table);
+	}
+
+	opp = _find_freq_ceil(opp_table, freq);
 
-	return _find_freq_ceil(opp_table, freq);
+	rcu_read_unlock();
+
+	return opp;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 
@@ -517,11 +511,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
  * ERANGE:	no match found for search
  * ENODEV:	if device not found in list of registered devices
  *
- * Locking: This function must be called under rcu_read_lock(). opp is a rcu
- * protected pointer. The reason for the same is that the opp pointer which is
- * returned will remain valid for use with opp_get_{voltage, freq} only while
- * under the locked area. The pointer returned must be used prior to unlocking
- * with rcu_read_unlock() to maintain the integrity of the pointer.
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
  */
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq)
@@ -529,16 +520,18 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 	struct opp_table *opp_table;
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
-	opp_rcu_lockdep_assert();
-
 	if (!dev || !freq) {
 		dev_err(dev, "%s: Invalid argument freq=%p\n", __func__, freq);
 		return ERR_PTR(-EINVAL);
 	}
 
+	rcu_read_lock();
+
 	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
+	if (IS_ERR(opp_table)) {
+		rcu_read_unlock();
 		return ERR_CAST(opp_table);
+	}
 
 	list_for_each_entry_rcu(temp_opp, &opp_table->opp_list, node) {
 		if (temp_opp->available) {
@@ -549,6 +542,12 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 				opp = temp_opp;
 		}
 	}
+
+	/* Increment the reference count of OPP */
+	if (!IS_ERR(opp))
+		dev_pm_opp_get(opp);
+	rcu_read_unlock();
+
 	if (!IS_ERR(opp))
 		*freq = opp->rate;
 
@@ -736,6 +735,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		ret = PTR_ERR(opp);
 		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
 			__func__, freq, ret);
+		if (!IS_ERR(old_opp))
+			dev_pm_opp_put(old_opp);
 		rcu_read_unlock();
 		return ret;
 	}
@@ -747,6 +748,9 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 
 	/* Only frequency scaling */
 	if (!regulators) {
+		dev_pm_opp_put(opp);
+		if (!IS_ERR(old_opp))
+			dev_pm_opp_put(old_opp);
 		rcu_read_unlock();
 		return _generic_set_opp_clk_only(dev, clk, old_freq, freq);
 	}
@@ -772,6 +776,9 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	data->new_opp.rate = freq;
 	memcpy(data->new_opp.supplies, opp->supplies, size);
 
+	dev_pm_opp_put(opp);
+	if (!IS_ERR(old_opp))
+		dev_pm_opp_put(old_opp);
 	rcu_read_unlock();
 
 	return set_opp(data);
@@ -967,6 +974,11 @@ static void _opp_kref_release(struct kref *kref)
 	dev_pm_opp_put_opp_table(opp_table);
 }
 
+static void dev_pm_opp_get(struct dev_pm_opp *opp)
+{
+	kref_get(&opp->kref);
+}
+
 void dev_pm_opp_put(struct dev_pm_opp *opp)
 {
 	kref_put_mutex(&opp->kref, _opp_kref_release, &opp->opp_table->lock);
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 8c3434bdb26d..adef788862d5 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -42,11 +42,6 @@
  *
  * WARNING: It is  important for the callers to ensure refreshing their copy of
  * the table if any of the mentioned functions have been invoked in the interim.
- *
- * Locking: The internal opp_table and opp structures are RCU protected.
- * Since we just use the regular accessor functions to access the internal data
- * structures, we use RCU read lock inside this function. As a result, users of
- * this function DONOT need to use explicit locks for invoking.
  */
 int dev_pm_opp_init_cpufreq_table(struct device *dev,
 				  struct cpufreq_frequency_table **table)
@@ -56,19 +51,13 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 	int i, max_opps, ret = 0;
 	unsigned long rate;
 
-	rcu_read_lock();
-
 	max_opps = dev_pm_opp_get_opp_count(dev);
-	if (max_opps <= 0) {
-		ret = max_opps ? max_opps : -ENODATA;
-		goto out;
-	}
+	if (max_opps <= 0)
+		return max_opps ? max_opps : -ENODATA;
 
 	freq_table = kcalloc((max_opps + 1), sizeof(*freq_table), GFP_ATOMIC);
-	if (!freq_table) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!freq_table)
+		return -ENOMEM;
 
 	for (i = 0, rate = 0; i < max_opps; i++, rate++) {
 		/* find next rate */
@@ -83,6 +72,8 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 		/* Is Boost/turbo opp ? */
 		if (dev_pm_opp_is_turbo(opp))
 			freq_table[i].flags = CPUFREQ_BOOST_FREQ;
+
+		dev_pm_opp_put(opp);
 	}
 
 	freq_table[i].driver_data = i;
@@ -91,7 +82,6 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 	*table = &freq_table[0];
 
 out:
-	rcu_read_unlock();
 	if (ret)
 		kfree(freq_table);
 
diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index f010562534eb..2c44aeb0b97c 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -633,16 +633,12 @@ static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
 	struct dev_pm_opp *opp;
 	int i, uv;
 
-	rcu_read_lock();
-
 	opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
-	if (IS_ERR(opp)) {
-		rcu_read_unlock();
+	if (IS_ERR(opp))
 		return PTR_ERR(opp);
-	}
-	uv = dev_pm_opp_get_voltage(opp);
 
-	rcu_read_unlock();
+	uv = dev_pm_opp_get_voltage(opp);
+	dev_pm_opp_put(opp);
 
 	for (i = 0; i < td->i2c_lut_size; i++) {
 		if (regulator_list_voltage(td->vdd_reg, td->i2c_lut[i]) == uv)
@@ -1440,8 +1436,6 @@ static int dfll_build_i2c_lut(struct tegra_dfll *td)
 	struct dev_pm_opp *opp;
 	int lut;
 
-	rcu_read_lock();
-
 	rate = ULONG_MAX;
 	opp = dev_pm_opp_find_freq_floor(td->soc->dev, &rate);
 	if (IS_ERR(opp)) {
@@ -1449,6 +1443,7 @@ static int dfll_build_i2c_lut(struct tegra_dfll *td)
 		goto out;
 	}
 	v_max = dev_pm_opp_get_voltage(opp);
+	dev_pm_opp_put(opp);
 
 	v = td->soc->cvb->min_millivolts * 1000;
 	lut = find_vdd_map_entry_exact(td, v);
@@ -1465,6 +1460,8 @@ static int dfll_build_i2c_lut(struct tegra_dfll *td)
 		if (v_opp <= td->soc->cvb->min_millivolts * 1000)
 			td->dvco_rate_min = dev_pm_opp_get_freq(opp);
 
+		dev_pm_opp_put(opp);
+
 		for (;;) {
 			v += max(1, (v_max - v) / (MAX_DFLL_VOLTAGES - j));
 			if (v >= v_opp)
@@ -1496,8 +1493,6 @@ static int dfll_build_i2c_lut(struct tegra_dfll *td)
 		ret = 0;
 
 out:
-	rcu_read_unlock();
-
 	return ret;
 }
 
diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index c0f3373706f4..9180d34cc9fc 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -118,12 +118,10 @@ static int init_div_table(void)
 	unsigned int tmp, clk_div, ema_div, freq, volt_id;
 	struct dev_pm_opp *opp;
 
-	rcu_read_lock();
 	cpufreq_for_each_entry(pos, freq_tbl) {
 		opp = dev_pm_opp_find_freq_exact(dvfs_info->dev,
 					pos->frequency * 1000, true);
 		if (IS_ERR(opp)) {
-			rcu_read_unlock();
 			dev_err(dvfs_info->dev,
 				"failed to find valid OPP for %u KHZ\n",
 				pos->frequency);
@@ -140,6 +138,7 @@ static int init_div_table(void)
 
 		/* Calculate EMA */
 		volt_id = dev_pm_opp_get_voltage(opp);
+
 		volt_id = (MAX_VOLTAGE - volt_id) / VOLTAGE_STEP;
 		if (volt_id < PMIC_HIGH_VOLT) {
 			ema_div = (CPUEMA_HIGH << P0_7_CPUEMA_SHIFT) |
@@ -157,9 +156,9 @@ static int init_div_table(void)
 
 		__raw_writel(tmp, dvfs_info->base + XMU_PMU_P0_7 + 4 *
 						(pos - freq_tbl));
+		dev_pm_opp_put(opp);
 	}
 
-	rcu_read_unlock();
 	return 0;
 }
 
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index ef1fa8145419..7719b02e04f5 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -53,16 +53,15 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 	freq_hz = new_freq * 1000;
 	old_freq = clk_get_rate(arm_clk) / 1000;
 
-	rcu_read_lock();
 	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
 	if (IS_ERR(opp)) {
-		rcu_read_unlock();
 		dev_err(cpu_dev, "failed to find OPP for %ld\n", freq_hz);
 		return PTR_ERR(opp);
 	}
 
 	volt = dev_pm_opp_get_voltage(opp);
-	rcu_read_unlock();
+	dev_pm_opp_put(opp);
+
 	volt_old = regulator_get_voltage(arm_reg);
 
 	dev_dbg(cpu_dev, "%u MHz, %ld mV --> %u MHz, %ld mV\n",
@@ -321,14 +320,15 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	 * freq_table initialised from OPP is therefore sorted in the
 	 * same order.
 	 */
-	rcu_read_lock();
 	opp = dev_pm_opp_find_freq_exact(cpu_dev,
 				  freq_table[0].frequency * 1000, true);
 	min_volt = dev_pm_opp_get_voltage(opp);
+	dev_pm_opp_put(opp);
 	opp = dev_pm_opp_find_freq_exact(cpu_dev,
 				  freq_table[--num].frequency * 1000, true);
 	max_volt = dev_pm_opp_get_voltage(opp);
-	rcu_read_unlock();
+	dev_pm_opp_put(opp);
+
 	ret = regulator_set_voltage_time(arm_reg, min_volt, max_volt);
 	if (ret > 0)
 		transition_latency += ret * 1000;
diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 643f43179df1..ab25b1235a5e 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -232,16 +232,14 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 
 	freq_hz = freq_table[index].frequency * 1000;
 
-	rcu_read_lock();
 	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
 	if (IS_ERR(opp)) {
-		rcu_read_unlock();
 		pr_err("cpu%d: failed to find OPP for %ld\n",
 		       policy->cpu, freq_hz);
 		return PTR_ERR(opp);
 	}
 	vproc = dev_pm_opp_get_voltage(opp);
-	rcu_read_unlock();
+	dev_pm_opp_put(opp);
 
 	/*
 	 * If the new voltage or the intermediate voltage is higher than the
@@ -411,16 +409,14 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 
 	/* Search a safe voltage for intermediate frequency. */
 	rate = clk_get_rate(inter_clk);
-	rcu_read_lock();
 	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
 	if (IS_ERR(opp)) {
-		rcu_read_unlock();
 		pr_err("failed to get intermediate opp for cpu%d\n", cpu);
 		ret = PTR_ERR(opp);
 		goto out_free_opp_table;
 	}
 	info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
-	rcu_read_unlock();
+	dev_pm_opp_put(opp);
 
 	info->cpu_dev = cpu_dev;
 	info->proc_reg = proc_reg;
diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 376e63ca94e8..71e81bbf031b 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -63,16 +63,14 @@ static int omap_target(struct cpufreq_policy *policy, unsigned int index)
 	freq = ret;
 
 	if (mpu_reg) {
-		rcu_read_lock();
 		opp = dev_pm_opp_find_freq_ceil(mpu_dev, &freq);
 		if (IS_ERR(opp)) {
-			rcu_read_unlock();
 			dev_err(mpu_dev, "%s: unable to find MPU OPP for %d\n",
 				__func__, new_freq);
 			return -EINVAL;
 		}
 		volt = dev_pm_opp_get_voltage(opp);
-		rcu_read_unlock();
+		dev_pm_opp_put(opp);
 		tol = volt * OPP_TOLERANCE / 100;
 		volt_old = regulator_get_voltage(mpu_reg);
 	}
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a545c0fee6e1..253525ea17af 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -111,18 +111,16 @@ static void devfreq_set_freq_table(struct devfreq *devfreq)
 		return;
 	}
 
-	rcu_read_lock();
 	for (i = 0, freq = 0; i < profile->max_state; i++, freq++) {
 		opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &freq);
 		if (IS_ERR(opp)) {
 			devm_kfree(devfreq->dev.parent, profile->freq_table);
 			profile->max_state = 0;
-			rcu_read_unlock();
 			return;
 		}
+		dev_pm_opp_put(opp);
 		profile->freq_table[i] = freq;
 	}
-	rcu_read_unlock();
 }
 
 /**
@@ -1112,17 +1110,16 @@ static ssize_t available_frequencies_show(struct device *d,
 	ssize_t count = 0;
 	unsigned long freq = 0;
 
-	rcu_read_lock();
 	do {
 		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
 		if (IS_ERR(opp))
 			break;
 
+		dev_pm_opp_put(opp);
 		count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
 				   "%lu ", freq);
 		freq++;
 	} while (1);
-	rcu_read_unlock();
 
 	/* Truncate the trailing space */
 	if (count)
@@ -1224,11 +1221,8 @@ subsys_initcall(devfreq_init);
  * @freq:	The frequency given to target function
  * @flags:	Flags handed from devfreq framework.
  *
- * Locking: This function must be called under rcu_read_lock(). opp is a rcu
- * protected pointer. The reason for the same is that the opp pointer which is
- * returned will remain valid for use with opp_get_{voltage, freq} only while
- * under the locked area. The pointer returned must be used prior to unlocking
- * with rcu_read_unlock() to maintain the integrity of the pointer.
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
  */
 struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 					   unsigned long *freq,
diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 9af86f46fbec..c6d850cddd98 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -103,18 +103,17 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
 	int ret = 0;
 
 	/* Get new opp-bus instance according to new bus clock */
-	rcu_read_lock();
 	new_opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(new_opp)) {
 		dev_err(dev, "failed to get recommended opp instance\n");
-		rcu_read_unlock();
 		return PTR_ERR(new_opp);
 	}
 
 	new_freq = dev_pm_opp_get_freq(new_opp);
 	new_volt = dev_pm_opp_get_voltage(new_opp);
+	dev_pm_opp_put(new_opp);
+
 	old_freq = bus->curr_freq;
-	rcu_read_unlock();
 
 	if (old_freq == new_freq)
 		return 0;
@@ -214,17 +213,16 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
 	int ret = 0;
 
 	/* Get new opp-bus instance according to new bus clock */
-	rcu_read_lock();
 	new_opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(new_opp)) {
 		dev_err(dev, "failed to get recommended opp instance\n");
-		rcu_read_unlock();
 		return PTR_ERR(new_opp);
 	}
 
 	new_freq = dev_pm_opp_get_freq(new_opp);
+	dev_pm_opp_put(new_opp);
+
 	old_freq = bus->curr_freq;
-	rcu_read_unlock();
 
 	if (old_freq == new_freq)
 		return 0;
@@ -358,16 +356,14 @@ static int exynos_bus_parse_of(struct device_node *np,
 
 	rate = clk_get_rate(bus->clk);
 
-	rcu_read_lock();
 	opp = devfreq_recommended_opp(dev, &rate, 0);
 	if (IS_ERR(opp)) {
 		dev_err(dev, "failed to find dev_pm_opp\n");
-		rcu_read_unlock();
 		ret = PTR_ERR(opp);
 		goto err_opp;
 	}
 	bus->curr_freq = dev_pm_opp_get_freq(opp);
-	rcu_read_unlock();
+	dev_pm_opp_put(opp);
 
 	return 0;
 
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 9ef46e2592c4..bd452236dba4 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -59,14 +59,14 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	 * list of parent device. Because in this case, *freq is temporary
 	 * value which is decided by ondemand governor.
 	 */
-	rcu_read_lock();
 	opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
-	rcu_read_unlock();
 	if (IS_ERR(opp)) {
 		ret = PTR_ERR(opp);
 		goto out;
 	}
 
+	dev_pm_opp_put(opp);
+
 	/*
 	 * Get the OPP table's index of decided freqeuncy by governor
 	 * of parent device.
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 27d2f349b53c..40a2499730fc 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -91,17 +91,13 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 	unsigned long target_volt, target_rate;
 	int err;
 
-	rcu_read_lock();
 	opp = devfreq_recommended_opp(dev, freq, flags);
-	if (IS_ERR(opp)) {
-		rcu_read_unlock();
+	if (IS_ERR(opp))
 		return PTR_ERR(opp);
-	}
 
 	target_rate = dev_pm_opp_get_freq(opp);
 	target_volt = dev_pm_opp_get_voltage(opp);
-
-	rcu_read_unlock();
+	dev_pm_opp_put(opp);
 
 	if (dmcfreq->rate == target_rate)
 		return 0;
@@ -422,15 +418,13 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 	data->rate = clk_get_rate(data->dmc_clk);
 
-	rcu_read_lock();
 	opp = devfreq_recommended_opp(dev, &data->rate, 0);
-	if (IS_ERR(opp)) {
-		rcu_read_unlock();
+	if (IS_ERR(opp))
 		return PTR_ERR(opp);
-	}
+
 	data->rate = dev_pm_opp_get_freq(opp);
 	data->volt = dev_pm_opp_get_voltage(opp);
-	rcu_read_unlock();
+	dev_pm_opp_put(opp);
 
 	rk3399_devfreq_dmc_profile.initial_freq = data->rate;
 
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index fe9dce0245bf..214fff96fa4a 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -487,15 +487,13 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	struct dev_pm_opp *opp;
 	unsigned long rate = *freq * KHZ;
 
-	rcu_read_lock();
 	opp = devfreq_recommended_opp(dev, &rate, flags);
 	if (IS_ERR(opp)) {
-		rcu_read_unlock();
 		dev_err(dev, "Failed to find opp for %lu KHz\n", *freq);
 		return PTR_ERR(opp);
 	}
 	rate = dev_pm_opp_get_freq(opp);
-	rcu_read_unlock();
+	dev_pm_opp_put(opp);
 
 	clk_set_min_rate(tegra->emc_clock, rate);
 	clk_set_rate(tegra->emc_clock, 0);
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 9ce0e9eef923..85fdbf762fa0 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -297,8 +297,6 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 	if (!power_table)
 		return -ENOMEM;
 
-	rcu_read_lock();
-
 	for (freq = 0, i = 0;
 	     opp = dev_pm_opp_find_freq_ceil(dev, &freq), !IS_ERR(opp);
 	     freq++, i++) {
@@ -306,13 +304,13 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 		u64 power;
 
 		if (i >= num_opps) {
-			rcu_read_unlock();
 			ret = -EAGAIN;
 			goto free_power_table;
 		}
 
 		freq_mhz = freq / 1000000;
 		voltage_mv = dev_pm_opp_get_voltage(opp) / 1000;
+		dev_pm_opp_put(opp);
 
 		/*
 		 * Do the multiplication with MHz and millivolt so as
@@ -328,8 +326,6 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 		power_table[i].power = power;
 	}
 
-	rcu_read_unlock();
-
 	if (i != num_opps) {
 		ret = PTR_ERR(opp);
 		goto free_power_table;
@@ -433,13 +429,10 @@ static int get_static_power(struct cpufreq_cooling_device *cpufreq_device,
 		return 0;
 	}
 
-	rcu_read_lock();
-
 	opp = dev_pm_opp_find_freq_exact(cpufreq_device->cpu_dev, freq_hz,
 					 true);
 	voltage = dev_pm_opp_get_voltage(opp);
-
-	rcu_read_unlock();
+	dev_pm_opp_put(opp);
 
 	if (voltage == 0) {
 		dev_warn_ratelimited(cpufreq_device->cpu_dev,
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 5a737fd5f1aa..ba7a5cd994dc 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -113,15 +113,15 @@ static int partition_enable_opps(struct devfreq_cooling_device *dfc,
 		unsigned int freq = dfc->freq_table[i];
 		bool want_enable = i >= cdev_state ? true : false;
 
-		rcu_read_lock();
 		opp = dev_pm_opp_find_freq_exact(dev, freq, !want_enable);
-		rcu_read_unlock();
 
 		if (PTR_ERR(opp) == -ERANGE)
 			continue;
 		else if (IS_ERR(opp))
 			return PTR_ERR(opp);
 
+		dev_pm_opp_put(opp);
+
 		if (want_enable)
 			ret = dev_pm_opp_enable(dev, freq);
 		else
@@ -221,15 +221,12 @@ get_static_power(struct devfreq_cooling_device *dfc, unsigned long freq)
 	if (!dfc->power_ops->get_static_power)
 		return 0;
 
-	rcu_read_lock();
-
 	opp = dev_pm_opp_find_freq_exact(dev, freq, true);
 	if (IS_ERR(opp) && (PTR_ERR(opp) == -ERANGE))
 		opp = dev_pm_opp_find_freq_exact(dev, freq, false);
 
 	voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
-
-	rcu_read_unlock();
+	dev_pm_opp_put(opp);
 
 	if (voltage == 0) {
 		dev_warn_ratelimited(dev,
@@ -412,18 +409,14 @@ static int devfreq_cooling_gen_tables(struct devfreq_cooling_device *dfc)
 		unsigned long power_dyn, voltage;
 		struct dev_pm_opp *opp;
 
-		rcu_read_lock();
-
 		opp = dev_pm_opp_find_freq_floor(dev, &freq);
 		if (IS_ERR(opp)) {
-			rcu_read_unlock();
 			ret = PTR_ERR(opp);
 			goto free_tables;
 		}
 
 		voltage = dev_pm_opp_get_voltage(opp) / 1000; /* mV */
-
-		rcu_read_unlock();
+		dev_pm_opp_put(opp);
 
 		if (dfc->power_ops) {
 			power_dyn = get_dynamic_power(dfc, freq, voltage);
-- 
2.7.1.410.g6faf27b
