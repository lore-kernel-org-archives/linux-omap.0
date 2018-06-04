From: Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 2/7] regulator: core: Add regulator_set_voltage_rdev()
Date: Mon, 04 Jun 2018 15:59:19 +0200
Message-ID: <1528120764-14316-3-git-send-email-m.purski@samsung.com>
References: <20180530144505.GB5705@atomide.com>
        <1528120764-14316-1-git-send-email-m.purski@samsung.com>
        <CGME20180604135952eucas1p2e3fdb68bf31e32b7c9557051671885a9@eucas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Maciej Purski <m.purski@samsung.com>
List-Id: linux-omap@vger.kernel.org

Refactor regulator_set_voltage_unlocked() by taking code related to
regulator_dev and creating a new function regulator_set_voltage_rdev(),
which operates only on struct regulator_dev.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b740426..413a824 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -105,6 +105,9 @@ static int _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data);
 static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				     int min_uV, int max_uV);
+static int regulator_set_voltage_rdev(struct regulator_dev *rdev,
+				      int min_uV, int max_uV,
+				      suspend_state_t state);
 static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
 					  const char *supply_name);
@@ -2996,8 +2999,6 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	int ret = 0;
 	int old_min_uV, old_max_uV;
 	int current_uV;
-	int best_supply_uV = 0;
-	int supply_change_uV = 0;
 
 	pr_err("%s: %d\n", __func__, __LINE__);
 	/* If we're setting the same range as last time the change
@@ -3042,6 +3043,26 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	if (ret < 0)
 		goto out2;
 
+	ret = regulator_set_voltage_rdev(rdev, min_uV, max_uV, state);
+	if (ret < 0)
+		goto out2;
+
+out:
+	return 0;
+out2:
+	voltage->min_uV = old_min_uV;
+	voltage->max_uV = old_max_uV;
+
+	return ret;
+}
+
+static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
+				      int max_uV, suspend_state_t state)
+{
+	int best_supply_uV = 0;
+	int supply_change_uV = 0;
+	int ret;
+
 	if (rdev->supply &&
 	    regulator_ops_is_valid(rdev->supply->rdev,
 				   REGULATOR_CHANGE_VOLTAGE) &&
@@ -3053,13 +3074,13 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		selector = regulator_map_voltage(rdev, min_uV, max_uV);
 		if (selector < 0) {
 			ret = selector;
-			goto out2;
+			goto out;
 		}
 
 		best_supply_uV = _regulator_list_voltage(rdev, selector, 0);
 		if (best_supply_uV < 0) {
 			ret = best_supply_uV;
-			goto out2;
+			goto out;
 		}
 
 		best_supply_uV += rdev->desc->min_dropout_uV;
@@ -3067,7 +3088,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		current_supply_uV = _regulator_get_voltage(rdev->supply->rdev);
 		if (current_supply_uV < 0) {
 			ret = current_supply_uV;
-			goto out2;
+			goto out;
 		}
 
 		supply_change_uV = best_supply_uV - current_supply_uV;
@@ -3079,7 +3100,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		if (ret) {
 			dev_err(&rdev->dev, "Failed to increase supply voltage: %d\n",
 					ret);
-			goto out2;
+			goto out;
 		}
 	}
 
@@ -3089,7 +3110,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		ret = _regulator_do_set_suspend_voltage(rdev, min_uV,
 							max_uV, state);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	if (supply_change_uV < 0) {
 		ret = regulator_set_voltage_unlocked(rdev->supply,
@@ -3103,11 +3124,6 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 
 out:
 	return ret;
-out2:
-	voltage->min_uV = old_min_uV;
-	voltage->max_uV = old_max_uV;
-
-	return ret;
 }
 
 /**
-- 
2.7.4
