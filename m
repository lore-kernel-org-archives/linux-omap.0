From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 10/11] regulator: core: Use ww_mutex for regulators locking
Date: Fri,  5 Oct 2018 18:36:37 +0300
Message-ID: <20181005153638.1886-11-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Maciej Purski <m.purski@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Wait/wound mutex shall be used in order to avoid lockups on locking of
coupled regulators.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Suggested-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/regulator/core.c         | 401 +++++++++++++++++++++++--------
 include/linux/regulator/driver.h |   3 +-
 2 files changed, 307 insertions(+), 97 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 783ec9c74104..a3448636f334 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -50,6 +50,8 @@
 #define rdev_dbg(rdev, fmt, ...)					\
 	pr_debug("%s: " fmt, rdev_get_name(rdev), ##__VA_ARGS__)
 
+static DEFINE_WW_CLASS(regulator_ww_class);
+static DEFINE_MUTEX(regulator_nesting_mutex);
 static DEFINE_MUTEX(regulator_list_mutex);
 static LIST_HEAD(regulator_map_list);
 static LIST_HEAD(regulator_ena_gpio_list);
@@ -154,7 +156,7 @@ static inline struct regulator_dev *rdev_get_supply(struct regulator_dev *rdev)
 /**
  * regulator_lock_nested - lock a single regulator
  * @rdev:		regulator source
- * @subclass:		mutex subclass used for lockdep
+ * @ww_ctx:		w/w mutex acquire context
  *
  * This function can be called many times by one task on
  * a single regulator and its mutex will be locked only
@@ -162,24 +164,52 @@ static inline struct regulator_dev *rdev_get_supply(struct regulator_dev *rdev)
  * than the one, which initially locked the mutex, it will
  * wait on mutex.
  */
-static void regulator_lock_nested(struct regulator_dev *rdev,
-				  unsigned int subclass)
+static inline int regulator_lock_nested(struct regulator_dev *rdev,
+					struct ww_acquire_ctx *ww_ctx)
 {
-	if (!mutex_trylock(&rdev->mutex)) {
-		if (rdev->mutex_owner == current) {
+	bool lock = false;
+	int ret = 0;
+
+	mutex_lock(&regulator_nesting_mutex);
+
+	if (ww_ctx || !ww_mutex_trylock(&rdev->mutex)) {
+		if (rdev->mutex_owner == current)
 			rdev->ref_cnt++;
-			return;
+		else
+			lock = true;
+
+		if (lock) {
+			mutex_unlock(&regulator_nesting_mutex);
+			ret = ww_mutex_lock(&rdev->mutex, ww_ctx);
+			mutex_lock(&regulator_nesting_mutex);
 		}
-		mutex_lock_nested(&rdev->mutex, subclass);
+	} else {
+		lock = true;
 	}
 
-	rdev->ref_cnt = 1;
-	rdev->mutex_owner = current;
+	if (lock && ret != -EDEADLK) {
+		rdev->ref_cnt++;
+		rdev->mutex_owner = current;
+	}
+
+	mutex_unlock(&regulator_nesting_mutex);
+
+	return ret;
 }
 
-static inline void regulator_lock(struct regulator_dev *rdev)
+/**
+ * regulator_lock - lock a single regulator
+ * @rdev:		regulator source
+ *
+ * This function can be called many times by one task on
+ * a single regulator and its mutex will be locked only
+ * once. If a task, which is calling this function is other
+ * than the one, which initially locked the mutex, it will
+ * wait on mutex.
+ */
+static void regulator_lock(struct regulator_dev *rdev)
 {
-	regulator_lock_nested(rdev, 0);
+	regulator_lock_nested(rdev, NULL);
 }
 
 /**
@@ -191,50 +221,46 @@ static inline void regulator_lock(struct regulator_dev *rdev)
  */
 static void regulator_unlock(struct regulator_dev *rdev)
 {
-	if (rdev->ref_cnt != 0) {
-		rdev->ref_cnt--;
+	mutex_lock(&regulator_nesting_mutex);
 
-		if (!rdev->ref_cnt) {
-			rdev->mutex_owner = NULL;
-			mutex_unlock(&rdev->mutex);
-		}
+	if (--rdev->ref_cnt == 0) {
+		rdev->mutex_owner = NULL;
+		ww_mutex_unlock(&rdev->mutex);
 	}
+
+	WARN_ON_ONCE(rdev->ref_cnt < 0);
+
+	mutex_unlock(&regulator_nesting_mutex);
 }
 
-static int regulator_lock_recursive(struct regulator_dev *rdev,
-				    unsigned int subclass)
+static void regulator_unlock_recursive(struct regulator_dev *rdev,
+				       unsigned int n_coupled)
 {
 	struct regulator_dev *c_rdev;
 	int i;
 
-	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
-		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
+	for (i = n_coupled; i > 0; i--) {
+		c_rdev = rdev->coupling_desc.coupled_rdevs[i - 1];
 
 		if (!c_rdev)
 			continue;
 
-		regulator_lock_nested(c_rdev, subclass++);
-
 		if (c_rdev->supply)
-			subclass =
-				regulator_lock_recursive(c_rdev->supply->rdev,
-							 subclass);
-	}
+			regulator_unlock_recursive(
+					c_rdev->supply->rdev,
+					c_rdev->coupling_desc.n_coupled);
 
-	return subclass;
+		regulator_unlock(c_rdev);
+	}
 }
 
-/**
- * regulator_unlock_dependent - unlock regulator's suppliers and coupled
- *				regulators
- * @rdev:			regulator source
- *
- * Unlock all regulators related with rdev by coupling or suppling.
- */
-static void regulator_unlock_dependent(struct regulator_dev *rdev)
+static int regulator_lock_recursive(struct regulator_dev *rdev,
+				    struct regulator_dev **new_contended_rdev,
+				    struct regulator_dev **old_contended_rdev,
+				    struct ww_acquire_ctx *ww_ctx)
 {
 	struct regulator_dev *c_rdev;
-	int i;
+	int i, err;
 
 	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
 		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
@@ -242,23 +268,95 @@ static void regulator_unlock_dependent(struct regulator_dev *rdev)
 		if (!c_rdev)
 			continue;
 
-		regulator_unlock(c_rdev);
+		if (c_rdev != *old_contended_rdev) {
+			err = regulator_lock_nested(c_rdev, ww_ctx);
+			if (err) {
+				if (err == -EDEADLK) {
+					*new_contended_rdev = c_rdev;
+					goto err_unlock;
+				}
 
-		if (c_rdev->supply)
-			regulator_unlock_dependent(c_rdev->supply->rdev);
+				/* shouldn't happen */
+				WARN_ON_ONCE(err != -EALREADY);
+			}
+		} else {
+			*old_contended_rdev = NULL;
+		}
+
+		if (c_rdev->supply) {
+			err = regulator_lock_recursive(c_rdev->supply->rdev,
+						       new_contended_rdev,
+						       old_contended_rdev,
+						       ww_ctx);
+			if (err) {
+				regulator_unlock(c_rdev);
+				goto err_unlock;
+			}
+		}
 	}
+
+	return 0;
+
+err_unlock:
+	regulator_unlock_recursive(rdev, i);
+
+	return err;
+}
+
+/**
+ * regulator_unlock_dependent - unlock regulator's suppliers and coupled
+ *				regulators
+ * @rdev:			regulator source
+ * @ww_ctx:			w/w mutex acquire context
+ *
+ * Unlock all regulators related with rdev by coupling or suppling.
+ */
+static void regulator_unlock_dependent(struct regulator_dev *rdev,
+				       struct ww_acquire_ctx *ww_ctx)
+{
+	regulator_unlock_recursive(rdev, rdev->coupling_desc.n_coupled);
+	ww_acquire_fini(ww_ctx);
 }
 
 /**
  * regulator_lock_dependent - lock regulator's suppliers and coupled regulators
  * @rdev:			regulator source
+ * @ww_ctx:			w/w mutex acquire context
  *
  * This function as a wrapper on regulator_lock_recursive(), which locks
  * all regulators related with rdev by coupling or suppling.
  */
-static inline void regulator_lock_dependent(struct regulator_dev *rdev)
+static void regulator_lock_dependent(struct regulator_dev *rdev,
+				     struct ww_acquire_ctx *ww_ctx)
 {
-	regulator_lock_recursive(rdev, 0);
+	struct regulator_dev *new_contended_rdev = NULL;
+	struct regulator_dev *old_contended_rdev = NULL;
+	int err;
+
+	mutex_lock(&regulator_list_mutex);
+
+	ww_acquire_init(ww_ctx, &regulator_ww_class);
+
+	do {
+		if (new_contended_rdev) {
+			ww_mutex_lock_slow(&new_contended_rdev->mutex, ww_ctx);
+			old_contended_rdev = new_contended_rdev;
+			old_contended_rdev->ref_cnt++;
+		}
+
+		err = regulator_lock_recursive(rdev,
+					       &new_contended_rdev,
+					       &old_contended_rdev,
+					       ww_ctx);
+
+		if (old_contended_rdev)
+			regulator_unlock(old_contended_rdev);
+
+	} while (err == -EDEADLK);
+
+	ww_acquire_done(ww_ctx);
+
+	mutex_unlock(&regulator_list_mutex);
 }
 
 /**
@@ -772,7 +870,7 @@ static int drms_uA_update(struct regulator_dev *rdev)
 	int current_uA = 0, output_uV, input_uV, err;
 	unsigned int mode;
 
-	lockdep_assert_held_once(&rdev->mutex);
+	lockdep_assert_held_once(&rdev->mutex.base);
 
 	/*
 	 * first check to see if we can set modes at all, otherwise just
@@ -2274,7 +2372,20 @@ static int _regulator_enable(struct regulator_dev *rdev)
 {
 	int ret;
 
-	lockdep_assert_held_once(&rdev->mutex);
+	lockdep_assert_held_once(&rdev->mutex.base);
+
+	if (rdev->supply) {
+		ret = _regulator_enable(rdev->supply->rdev);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* balance only if there are regulators coupled */
+	if (rdev->coupling_desc.n_coupled > 1) {
+		ret = regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+		if (ret < 0)
+			goto err_disable_supply;
+	}
 
 	/* check voltage and requested load before enabling */
 	if (regulator_ops_is_valid(rdev, REGULATOR_CHANGE_DRMS))
@@ -2285,18 +2396,20 @@ static int _regulator_enable(struct regulator_dev *rdev)
 		ret = _regulator_is_enabled(rdev);
 		if (ret == -EINVAL || ret == 0) {
 			if (!regulator_ops_is_valid(rdev,
-					REGULATOR_CHANGE_STATUS))
-				return -EPERM;
+					REGULATOR_CHANGE_STATUS)) {
+				ret = -EPERM;
+				goto err_disable_supply;
+			}
 
 			ret = _regulator_do_enable(rdev);
 			if (ret < 0)
-				return ret;
+				goto err_disable_supply;
 
 			_notifier_call_chain(rdev, REGULATOR_EVENT_ENABLE,
 					     NULL);
 		} else if (ret < 0) {
 			rdev_err(rdev, "is_enabled() failed: %d\n", ret);
-			return ret;
+			goto err_disable_supply;
 		}
 		/* Fallthrough on positive return values - already enabled */
 	}
@@ -2304,6 +2417,12 @@ static int _regulator_enable(struct regulator_dev *rdev)
 	rdev->use_count++;
 
 	return 0;
+
+err_disable_supply:
+	if (rdev->supply)
+		_regulator_disable(rdev->supply->rdev);
+
+	return ret;
 }
 
 /**
@@ -2320,30 +2439,15 @@ static int _regulator_enable(struct regulator_dev *rdev)
 int regulator_enable(struct regulator *regulator)
 {
 	struct regulator_dev *rdev = regulator->rdev;
+	struct ww_acquire_ctx ww_ctx;
 	int ret = 0;
 
 	if (regulator->always_on)
 		return 0;
 
-	if (rdev->supply) {
-		ret = regulator_enable(rdev->supply);
-		if (ret != 0)
-			return ret;
-	}
-
-	regulator_lock_dependent(rdev);
-	/* balance only if there are regulators coupled */
-	if (rdev->coupling_desc.n_coupled > 1) {
-		ret = regulator_balance_voltage(rdev, PM_SUSPEND_ON);
-		if (ret != 0)
-			goto unlock;
-	}
+	regulator_lock_dependent(rdev, &ww_ctx);
 	ret = _regulator_enable(rdev);
-unlock:
-	regulator_unlock_dependent(rdev);
-
-	if (ret != 0 && rdev->supply)
-		regulator_disable(rdev->supply);
+	regulator_unlock_dependent(rdev, &ww_ctx);
 
 	return ret;
 }
@@ -2385,7 +2489,7 @@ static int _regulator_disable(struct regulator_dev *rdev)
 {
 	int ret = 0;
 
-	lockdep_assert_held_once(&rdev->mutex);
+	lockdep_assert_held_once(&rdev->mutex.base);
 
 	if (WARN(rdev->use_count <= 0,
 		 "unbalanced disables for %s\n", rdev_get_name(rdev)))
@@ -2423,6 +2527,12 @@ static int _regulator_disable(struct regulator_dev *rdev)
 		rdev->use_count--;
 	}
 
+	if (ret == 0 && rdev->coupling_desc.n_coupled > 1)
+		ret = regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+
+	if (ret == 0 && rdev->supply)
+		ret = _regulator_disable(rdev->supply->rdev);
+
 	return ret;
 }
 
@@ -2441,19 +2551,15 @@ static int _regulator_disable(struct regulator_dev *rdev)
 int regulator_disable(struct regulator *regulator)
 {
 	struct regulator_dev *rdev = regulator->rdev;
+	struct ww_acquire_ctx ww_ctx;
 	int ret = 0;
 
 	if (regulator->always_on)
 		return 0;
 
-	regulator_lock_dependent(rdev);
+	regulator_lock_dependent(rdev, &ww_ctx);
 	ret = _regulator_disable(rdev);
-	if (rdev->coupling_desc.n_coupled > 1)
-		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
-	regulator_unlock_dependent(rdev);
-
-	if (ret == 0 && rdev->supply)
-		regulator_disable(rdev->supply);
+	regulator_unlock_dependent(rdev, &ww_ctx);
 
 	return ret;
 }
@@ -2464,7 +2570,7 @@ static int _regulator_force_disable(struct regulator_dev *rdev)
 {
 	int ret = 0;
 
-	lockdep_assert_held_once(&rdev->mutex);
+	lockdep_assert_held_once(&rdev->mutex.base);
 
 	ret = _notifier_call_chain(rdev, REGULATOR_EVENT_FORCE_DISABLE |
 			REGULATOR_EVENT_PRE_DISABLE, NULL);
@@ -2497,14 +2603,15 @@ static int _regulator_force_disable(struct regulator_dev *rdev)
 int regulator_force_disable(struct regulator *regulator)
 {
 	struct regulator_dev *rdev = regulator->rdev;
+	struct ww_acquire_ctx ww_ctx;
 	int ret;
 
-	regulator_lock_dependent(rdev);
+	regulator_lock_dependent(rdev, &ww_ctx);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
 	if (rdev->coupling_desc.n_coupled > 1)
 		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
-	regulator_unlock_dependent(rdev);
+	regulator_unlock_dependent(rdev, &ww_ctx);
 
 	if (rdev->supply)
 		while (rdev->open_count--)
@@ -2518,9 +2625,10 @@ static void regulator_disable_work(struct work_struct *work)
 {
 	struct regulator_dev *rdev = container_of(work, struct regulator_dev,
 						  disable_work.work);
+	struct ww_acquire_ctx ww_ctx;
 	int count, i, ret;
 
-	regulator_lock(rdev);
+	regulator_lock_dependent(rdev, &ww_ctx);
 
 	BUG_ON(!rdev->deferred_disables);
 
@@ -2541,7 +2649,10 @@ static void regulator_disable_work(struct work_struct *work)
 			rdev_err(rdev, "Deferred disable failed: %d\n", ret);
 	}
 
-	regulator_unlock(rdev);
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+
+	regulator_unlock_dependent(rdev, &ww_ctx);
 
 	if (rdev->supply) {
 		for (i = 0; i < count; i++) {
@@ -2652,9 +2763,9 @@ int regulator_is_enabled(struct regulator *regulator)
 	if (regulator->always_on)
 		return 1;
 
-	regulator_lock_dependent(regulator->rdev);
+	regulator_lock(regulator->rdev);
 	ret = _regulator_is_enabled(regulator->rdev);
-	regulator_unlock_dependent(regulator->rdev);
+	regulator_unlock(regulator->rdev);
 
 	return ret;
 }
@@ -3268,7 +3379,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
 		int tmp_min = 0;
 		int tmp_max = INT_MAX;
 
-		lockdep_assert_held_once(&c_rdevs[i]->mutex);
+		lockdep_assert_held_once(&c_rdevs[i]->mutex.base);
 
 		ret = regulator_check_consumers(c_rdevs[i],
 						&tmp_min,
@@ -3479,14 +3590,15 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
  */
 int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
-	int ret = 0;
+	struct ww_acquire_ctx ww_ctx;
+	int ret;
 
-	regulator_lock_dependent(regulator->rdev);
+	regulator_lock_dependent(regulator->rdev, &ww_ctx);
 
 	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
 					     PM_SUSPEND_ON);
 
-	regulator_unlock_dependent(regulator->rdev);
+	regulator_unlock_dependent(regulator->rdev, &ww_ctx);
 
 	return ret;
 }
@@ -3558,18 +3670,19 @@ static int _regulator_set_suspend_voltage(struct regulator *regulator,
 int regulator_set_suspend_voltage(struct regulator *regulator, int min_uV,
 				  int max_uV, suspend_state_t state)
 {
-	int ret = 0;
+	struct ww_acquire_ctx ww_ctx;
+	int ret;
 
 	/* PM_SUSPEND_ON is handled by regulator_set_voltage() */
 	if (regulator_check_states(state) || state == PM_SUSPEND_ON)
 		return -EINVAL;
 
-	regulator_lock_dependent(regulator->rdev);
+	regulator_lock_dependent(regulator->rdev, &ww_ctx);
 
 	ret = _regulator_set_suspend_voltage(regulator, min_uV,
 					     max_uV, state);
 
-	regulator_unlock_dependent(regulator->rdev);
+	regulator_unlock_dependent(regulator->rdev, &ww_ctx);
 
 	return ret;
 }
@@ -3759,13 +3872,12 @@ static int _regulator_get_voltage(struct regulator_dev *rdev)
  */
 int regulator_get_voltage(struct regulator *regulator)
 {
+	struct ww_acquire_ctx ww_ctx;
 	int ret;
 
-	regulator_lock_dependent(regulator->rdev);
-
+	regulator_lock_dependent(regulator->rdev, &ww_ctx);
 	ret = _regulator_get_voltage(regulator->rdev);
-
-	regulator_unlock_dependent(regulator->rdev);
+	regulator_unlock_dependent(regulator->rdev, &ww_ctx);
 
 	return ret;
 }
@@ -4301,7 +4413,7 @@ EXPORT_SYMBOL_GPL(regulator_bulk_free);
 int regulator_notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data)
 {
-	lockdep_assert_held_once(&rdev->mutex);
+	lockdep_assert_held_once(&rdev->mutex.base);
 
 	_notifier_call_chain(rdev, event, data);
 	return NOTIFY_DONE;
@@ -4669,7 +4781,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		rdev->dev.of_node = of_node_get(config->of_node);
 	}
 
-	mutex_init(&rdev->mutex);
+	ww_mutex_init(&rdev->mutex, &regulator_ww_class);
 	rdev->reg_data = config->driver_data;
 	rdev->owner = regulator_desc->owner;
 	rdev->desc = regulator_desc;
@@ -5026,8 +5138,6 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 	if (!rdev)
 		return;
 
-	regulator_lock_nested(rdev, level);
-
 	opmode = _regulator_get_mode_unlocked(rdev);
 	seq_printf(s, "%*s%-*s %3d %4d %6d %7s ",
 		   level * 3 + 1, "",
@@ -5084,8 +5194,101 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 
 	class_for_each_device(&regulator_class, NULL, &summary_data,
 			      regulator_summary_show_children);
+}
+
+struct summary_lock_data {
+	struct ww_acquire_ctx *ww_ctx;
+	struct regulator_dev **new_contended_rdev;
+	struct regulator_dev **old_contended_rdev;
+};
+
+static int regulator_summary_lock_one(struct device *dev, void *data)
+{
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+	struct summary_lock_data *lock_data = data;
+	int ret = 0;
+
+	if (rdev != *lock_data->old_contended_rdev) {
+		ret = regulator_lock_nested(rdev, lock_data->ww_ctx);
+
+		if (ret == -EDEADLK)
+			*lock_data->new_contended_rdev = rdev;
+		else
+			WARN_ON_ONCE(ret);
+	} else {
+		*lock_data->old_contended_rdev = NULL;
+	}
+
+	return ret;
+}
+
+static int regulator_summary_unlock_one(struct device *dev, void *data)
+{
+	struct regulator_dev *rdev = dev_to_rdev(dev);
+	struct summary_lock_data *lock_data = data;
+
+	if (lock_data) {
+		if (rdev == *lock_data->new_contended_rdev)
+			return -EDEADLK;
+	}
 
 	regulator_unlock(rdev);
+
+	return 0;
+}
+
+static int regulator_summary_lock_all(struct ww_acquire_ctx *ww_ctx,
+				      struct regulator_dev **new_contended_rdev,
+				      struct regulator_dev **old_contended_rdev)
+{
+	struct summary_lock_data lock_data;
+	int ret;
+
+	lock_data.ww_ctx = ww_ctx;
+	lock_data.new_contended_rdev = new_contended_rdev;
+	lock_data.old_contended_rdev = old_contended_rdev;
+
+	ret = class_for_each_device(&regulator_class, NULL, &lock_data,
+				    regulator_summary_lock_one);
+	if (ret)
+		class_for_each_device(&regulator_class, NULL, &lock_data,
+				      regulator_summary_unlock_one);
+
+	return ret;
+}
+
+static void regulator_summary_lock(struct ww_acquire_ctx *ww_ctx)
+{
+	struct regulator_dev *new_contended_rdev = NULL;
+	struct regulator_dev *old_contended_rdev = NULL;
+	int err;
+
+	ww_acquire_init(ww_ctx, &regulator_ww_class);
+
+	do {
+		if (new_contended_rdev) {
+			ww_mutex_lock_slow(&new_contended_rdev->mutex, ww_ctx);
+			old_contended_rdev = new_contended_rdev;
+			old_contended_rdev->ref_cnt++;
+		}
+
+		err = regulator_summary_lock_all(ww_ctx,
+						 &new_contended_rdev,
+						 &old_contended_rdev);
+
+		if (old_contended_rdev)
+			regulator_unlock(old_contended_rdev);
+
+	} while (err == -EDEADLK);
+
+	ww_acquire_done(ww_ctx);
+}
+
+static void regulator_summary_unlock(struct ww_acquire_ctx *ww_ctx)
+{
+	class_for_each_device(&regulator_class, NULL, NULL,
+			      regulator_summary_unlock_one);
+	ww_acquire_fini(ww_ctx);
 }
 
 static int regulator_summary_show_roots(struct device *dev, void *data)
@@ -5101,12 +5304,18 @@ static int regulator_summary_show_roots(struct device *dev, void *data)
 
 static int regulator_summary_show(struct seq_file *s, void *data)
 {
+	struct ww_acquire_ctx ww_ctx;
+
 	seq_puts(s, " regulator                      use open bypass  opmode voltage current     min     max\n");
 	seq_puts(s, "---------------------------------------------------------------------------------------\n");
 
+	regulator_summary_lock(&ww_ctx);
+
 	class_for_each_device(&regulator_class, NULL, s,
 			      regulator_summary_show_roots);
 
+	regulator_summary_unlock(&ww_ctx);
+
 	return 0;
 }
 
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index a05d37d0efa1..e71f9c314426 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/regulator/consumer.h>
+#include <linux/ww_mutex.h>
 
 struct gpio_desc;
 struct regmap;
@@ -462,7 +463,7 @@ struct regulator_dev {
 	struct coupling_desc coupling_desc;
 
 	struct blocking_notifier_head notifier;
-	struct mutex mutex; /* consumer lock */
+	struct ww_mutex mutex; /* consumer lock */
 	struct task_struct *mutex_owner;
 	int ref_cnt;
 	struct module *owner;
-- 
2.19.0
