From: Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 1/7] regulator: core: Add debug messages
Date: Mon, 04 Jun 2018 15:59:18 +0200
Message-ID: <1528120764-14316-2-git-send-email-m.purski@samsung.com>
References: <20180530144505.GB5705@atomide.com>
        <1528120764-14316-1-git-send-email-m.purski@samsung.com>
        <CGME20180604135952eucas1p2d76b6aa5d8fc9912113d519b48f7e99a@eucas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Maciej Purski <m.purski@samsung.com>
List-Id: linux-omap@vger.kernel.org

Add debug messages on voltage setting and enabling path in order
to debug the coupled regulators problem.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6ed568b..b740426 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1571,6 +1571,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	struct device *dev = rdev->dev.parent;
 	int ret;
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	/* No supply to resovle? */
 	if (!rdev->supply_name)
 		return 0;
@@ -2211,6 +2212,7 @@ static int _regulator_enable(struct regulator_dev *rdev)
 {
 	int ret;
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	lockdep_assert_held_once(&rdev->mutex);
 
 	/* check voltage and requested load before enabling */
@@ -2259,6 +2261,7 @@ int regulator_enable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	if (regulator->always_on)
 		return 0;
 
@@ -2275,6 +2278,7 @@ int regulator_enable(struct regulator *regulator)
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_enable);
@@ -2373,6 +2377,7 @@ int regulator_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	if (regulator->always_on)
 		return 0;
 
@@ -2383,6 +2388,7 @@ int regulator_disable(struct regulator *regulator)
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_disable);
@@ -2858,6 +2864,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 	const struct regulator_ops *ops = rdev->desc->ops;
 	int old_uV = _regulator_get_voltage(rdev);
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	trace_regulator_set_voltage(rdev_get_name(rdev), min_uV, max_uV);
 
 	min_uV += rdev->constraints->uV_offset;
@@ -2992,6 +2999,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	int best_supply_uV = 0;
 	int supply_change_uV = 0;
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	/* If we're setting the same range as last time the change
 	 * should be a noop (some cpufreq implementations use the same
 	 * voltage for multiple frequencies, for example).
@@ -3124,6 +3132,7 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
 	int ret = 0;
 
+	pr_err("%s: %d\n", __func__, __LINE__);
 	regulator_lock_supply(regulator->rdev);
 
 	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
-- 
2.7.4
