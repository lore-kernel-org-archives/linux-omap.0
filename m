From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: palmas: Remove *rdev[PALMAS_NUM_REGS] from struct palmas_pmic
Date: Sun, 10 Mar 2019 23:06:09 +0800
Message-ID: <20190310150609.5178-1-axel.lin@ingics.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, J Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
List-Id: linux-omap@vger.kernel.org

This driver is using devm_regulator_register() so it is not necessary
to save *rdev for clean up. Actually the pmic->rdev[id] is not used now.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/palmas-regulator.c | 12 ------------
 include/linux/mfd/palmas.h           |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 7fb9e8dd834e..f13c7c8b1061 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -991,9 +991,6 @@ static int palmas_ldo_registration(struct palmas_pmic *pmic,
 			return PTR_ERR(rdev);
 		}
 
-		/* Save regulator for cleanup */
-		pmic->rdev[id] = rdev;
-
 		/* Initialise sleep/init values from platform data */
 		if (pdata) {
 			reg_init = pdata->reg_init[id];
@@ -1101,9 +1098,6 @@ static int tps65917_ldo_registration(struct palmas_pmic *pmic,
 			return PTR_ERR(rdev);
 		}
 
-		/* Save regulator for cleanup */
-		pmic->rdev[id] = rdev;
-
 		/* Initialise sleep/init values from platform data */
 		if (pdata) {
 			reg_init = pdata->reg_init[id];
@@ -1288,9 +1282,6 @@ static int palmas_smps_registration(struct palmas_pmic *pmic,
 				pdev_name);
 			return PTR_ERR(rdev);
 		}
-
-		/* Save regulator for cleanup */
-		pmic->rdev[id] = rdev;
 	}
 
 	return 0;
@@ -1395,9 +1386,6 @@ static int tps65917_smps_registration(struct palmas_pmic *pmic,
 				pdev_name);
 			return PTR_ERR(rdev);
 		}
-
-		/* Save regulator for cleanup */
-		pmic->rdev[id] = rdev;
 	}
 
 	return 0;
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index 75e5c8ff85fc..c34d5f0d34d7 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -553,7 +553,6 @@ struct palmas_pmic {
 	struct palmas *palmas;
 	struct device *dev;
 	struct regulator_desc desc[PALMAS_NUM_REGS];
-	struct regulator_dev *rdev[PALMAS_NUM_REGS];
 	struct mutex mutex;
 
 	int smps123;
-- 
2.17.1
