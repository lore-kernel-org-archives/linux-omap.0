From: Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v2] regulator: core: Enable voltage balancing
Date: Wed, 13 Jun 2018 12:33:46 +0200
Message-ID: <1528886026-9457-1-git-send-email-m.purski@samsung.com>
References: <20180605044554.GC5738@atomide.com>
        <CGME20180613103622eucas1p1778ba2c2e5dd85ccb4c488bd0a38386d@eucas1p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180605044554.GC5738@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Maciej Purski <m.purski@samsung.com>
List-Id: linux-omap@vger.kernel.org

Call regulator_balance_voltage() instead of set_voltage_rdev()
in set_voltage_unlocked() and in enabling and disabling functions,
but only if the regulator is coupled.

Signed-off-by: Maciej Purski <m.purski@samsung.com>

---
Changes in v2:
- fix compile errors
- make debug messages more informative
---
 drivers/regulator/core.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2a7ffb7..266f4eb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1605,7 +1605,6 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	struct device *dev = rdev->dev.parent;
 	int ret;
 
-	pr_err("%s: %d\n", __func__, __LINE__);
 	/* No supply to resovle? */
 	if (!rdev->supply_name)
 		return 0;
@@ -2246,7 +2245,7 @@ static int _regulator_enable(struct regulator_dev *rdev)
 {
 	int ret;
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	lockdep_assert_held_once(&rdev->mutex);
 
 	/* check voltage and requested load before enabling */
@@ -2295,7 +2294,12 @@ int regulator_enable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
+	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
+		rdev_err(rdev, "not all coupled regulators registered\n");
+		return -EPERM;
+	}
+
 	if (regulator->always_on)
 		return 0;
 
@@ -2307,12 +2311,15 @@ int regulator_enable(struct regulator *regulator)
 
 	regulator_lock_dependent(rdev);
 	ret = _regulator_enable(rdev);
+	/* balance only if there are regulators coupled */
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_enable);
@@ -2411,18 +2418,20 @@ int regulator_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	if (regulator->always_on)
 		return 0;
 
 	regulator_lock_dependent(rdev);
 	ret = _regulator_disable(rdev);
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_disable);
@@ -2470,6 +2479,8 @@ int regulator_force_disable(struct regulator *regulator)
 	regulator_lock_dependent(rdev);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (rdev->supply)
@@ -2898,7 +2909,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	const struct regulator_ops *ops = rdev->desc->ops;
 	int old_uV = _regulator_get_voltage(rdev);
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	trace_regulator_set_voltage(rdev_get_name(rdev), min_uV, max_uV);
 
 	min_uV += rdev->constraints->uV_offset;
@@ -3031,7 +3042,13 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	int old_min_uV, old_max_uV;
 	int current_uV;
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(rdev, "%s:  %d\n", __func__, __LINE__);
+	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
+		rdev_err(rdev, "not all coupled regulators registered\n");
+		ret = -EPERM;
+		goto out;
+	}
+
 	/* If we're setting the same range as last time the change
 	 * should be a noop (some cpufreq implementations use the same
 	 * voltage for multiple frequencies, for example).
@@ -3074,7 +3091,8 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	if (ret < 0)
 		goto out2;
 
-	ret = regulator_set_voltage_rdev(rdev, min_uV, max_uV, state);
+	/* for not coupled regulators this will just set the voltage */
+	ret = regulator_balance_voltage(rdev, state);
 	if (ret < 0)
 		goto out2;
 
@@ -3360,7 +3378,7 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
 	int ret = 0;
 
-	pr_err("%s: %d\n", __func__, __LINE__);
+	rdev_err(regulator->rdev, "%s: %d\n", __func__, __LINE__);
 	regulator_lock_dependent(regulator->rdev);
 
 	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
-- 
2.7.4
