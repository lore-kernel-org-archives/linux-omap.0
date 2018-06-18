From: Maciej Purski <m.purski@samsung.com>
Subject: [PATCH] regulator: core: Pass max_uV value to
 regulator_set_voltage_rdev
Date: Mon, 18 Jun 2018 16:08:33 +0200
Message-ID: <1529330913-11152-1-git-send-email-m.purski@samsung.com>
References: <20180615112916.GK112168@atomide.com>
        <CGME20180618140856eucas1p281619f9bf003655a3c2eac356216ab25@eucas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180615112916.GK112168@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Maciej Purski <m.purski@samsung.com>
List-Id: linux-omap@vger.kernel.org

If the regulator is not coupled, balance_voltage() should preserve
its desired max uV, instead of setting the exact value like in
coupled regulators case.

Remove debugs, which are not necessary for now.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 266f4eb..9894f4e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2245,7 +2245,6 @@ static int _regulator_enable(struct regulator_dev *rdev)
 {
 	int ret;
 
-	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	lockdep_assert_held_once(&rdev->mutex);
 
 	/* check voltage and requested load before enabling */
@@ -2294,7 +2293,6 @@ int regulator_enable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
-	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
 		rdev_err(rdev, "not all coupled regulators registered\n");
 		return -EPERM;
@@ -2319,7 +2317,6 @@ int regulator_enable(struct regulator *regulator)
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
 
-	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_enable);
@@ -2418,7 +2415,6 @@ int regulator_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
-	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	if (regulator->always_on)
 		return 0;
 
@@ -2431,7 +2427,6 @@ int regulator_disable(struct regulator *regulator)
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
 
-	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_disable);
@@ -3112,6 +3107,8 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 	int supply_change_uV = 0;
 	int ret;
 
+	rdev_err(rdev, "%s: %d\n", __func__, __LINE__);
+
 	if (rdev->supply &&
 	    regulator_ops_is_valid(rdev->supply->rdev,
 				   REGULATOR_CHANGE_VOLTAGE) &&
@@ -3175,7 +3172,8 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 	return ret;
 }
 
-static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
+static int
+regulator_get_optimal_voltage(struct regulator_dev *rdev, int *max_uV)
 {
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
@@ -3200,6 +3198,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
 	 */
 	if (n_coupled == 1) {
 		ret = desired_min_uV;
+		*max_uV = desired_max_uV;
 		goto out;
 	}
 
@@ -3274,6 +3273,7 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
 		goto out;
 	}
 	ret = possible_uV;
+	*max_uV = ret;
 
 out:
 	return ret;
@@ -3303,6 +3303,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 	 * if there isn't any possible change.
 	 */
 	while (1) {
+		int max_uV;
+
 		best_delta = 0;
 		best_uV = 0;
 		best_rdev = NULL;
@@ -3318,9 +3320,9 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 			 * max_spread constraint in order to balance
 			 * the coupled voltages.
 			 */
-			int optimal_uV, current_uV;
+			int optimal_uV, current_uV;;
 
-			optimal_uV = regulator_get_optimal_voltage(c_rdevs[i]);
+			optimal_uV = regulator_get_optimal_voltage(c_rdevs[i], &max_uV);
 			if (optimal_uV < 0) {
 				ret = optimal_uV;
 				goto out;
@@ -3337,6 +3339,10 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 				best_rdev = c_rdevs[i];
 				best_uV = optimal_uV;
 			}
+
+			rdev_err(rdev,
+				"optimal uV: %d current uV: %d, max uV: %d\n",
+				 optimal_uV, current_uV, max_uV);
 		}
 
 		/* Nothing to change, return successfully */
@@ -3346,7 +3352,7 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 		}
 
 		ret = regulator_set_voltage_rdev(best_rdev, best_uV,
-						 best_uV, state);
+						 max_uV, state);
 
 		if (ret < 0)
 			goto out;
@@ -3378,7 +3384,7 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
 	int ret = 0;
 
-	rdev_err(regulator->rdev, "%s: %d\n", __func__, __LINE__);
+	dev_err(regulator->dev, "%s: %d\n", __func__, __LINE__);
 	regulator_lock_dependent(regulator->rdev);
 
 	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
-- 
2.7.4
