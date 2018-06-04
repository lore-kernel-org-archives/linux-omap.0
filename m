From: Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 7/7] regulator: core: Enable voltage balancing
Date: Mon, 04 Jun 2018 15:59:24 +0200
Message-ID: <1528120764-14316-8-git-send-email-m.purski@samsung.com>
References: <20180530144505.GB5705@atomide.com>
        <1528120764-14316-1-git-send-email-m.purski@samsung.com>
        <CGME20180604135954eucas1p2bebd1c4970401bb957da228056f9a662@eucas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Maciej Purski <m.purski@samsung.com>
List-Id: linux-omap@vger.kernel.org

Call regulator_balance_voltage() instead of set_voltage_rdev()
in set_voltage_unlocked() and in enabling and disabling functions,
but only if the regulator is coupled.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2a7ffb7..2dd1f99 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2296,6 +2296,11 @@ int regulator_enable(struct regulator *regulator)
 	int ret = 0;
 
 	pr_err("%s: %d\n", __func__, __LINE__);
+	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
+		rdev_err(rdev, "not all coupled regulators registered\n");
+		return -EPERM;
+	}
+
 	if (regulator->always_on)
 		return 0;
 
@@ -2307,6 +2312,9 @@ int regulator_enable(struct regulator *regulator)
 
 	regulator_lock_dependent(rdev);
 	ret = _regulator_enable(rdev);
+	/* balance only if there are regulators coupled */
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (ret != 0 && rdev->supply)
@@ -2417,6 +2425,8 @@ int regulator_disable(struct regulator *regulator)
 
 	regulator_lock_dependent(rdev);
 	ret = _regulator_disable(rdev);
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (ret == 0 && rdev->supply)
@@ -2470,6 +2480,8 @@ int regulator_force_disable(struct regulator *regulator)
 	regulator_lock_dependent(rdev);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (rdev->supply)
@@ -3031,7 +3043,16 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	int old_min_uV, old_max_uV;
 	int current_uV;
 
+<<<<<<< HEAD
 	pr_err("%s: %d\n", __func__, __LINE__);
+=======
+	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
+		rdev_err(rdev, "not all coupled regulators registered\n");
+		ret = -EPERM;
+		goto out;
+	}
+
+>>>>>>> fcbf6fa... regulator: core: Enable voltage balancing
 	/* If we're setting the same range as last time the change
 	 * should be a noop (some cpufreq implementations use the same
 	 * voltage for multiple frequencies, for example).
@@ -3074,7 +3095,8 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	if (ret < 0)
 		goto out2;
 
-	ret = regulator_set_voltage_rdev(rdev, min_uV, max_uV, state);
+	/* for not coupled regulators this will just set the voltage */
+	ret = regulator_balance_voltage(rdev, state);
 	if (ret < 0)
 		goto out2;
 
-- 
2.7.4
