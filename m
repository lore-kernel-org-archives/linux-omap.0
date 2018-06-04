From: Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 6/7] regulator: core: Lock dependent regulators on
 regulator_enable()
Date: Mon, 04 Jun 2018 15:59:23 +0200
Message-ID: <1528120764-14316-7-git-send-email-m.purski@samsung.com>
References: <20180530144505.GB5705@atomide.com>
        <1528120764-14316-1-git-send-email-m.purski@samsung.com>
        <CGME20180604135954eucas1p2eeb77ada3ca97fecc6caec20d7e8397a@eucas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1528120764-14316-1-git-send-email-m.purski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Maciej Purski <m.purski@samsung.com>
List-Id: linux-omap@vger.kernel.org

Since regulator_enable() might now call regulator_balance_voltage(),
it should also lock its coupled regulators and suppliers.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 7c57268..2a7ffb7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2305,9 +2305,9 @@ int regulator_enable(struct regulator *regulator)
 			return ret;
 	}
 
-	regulator_lock(rdev);
+	regulator_lock_dependent(rdev);
 	ret = _regulator_enable(rdev);
-	regulator_unlock(rdev);
+	regulator_unlock_dependent(rdev);
 
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2415,9 +2415,9 @@ int regulator_disable(struct regulator *regulator)
 	if (regulator->always_on)
 		return 0;
 
-	regulator_lock(rdev);
+	regulator_lock_dependent(rdev);
 	ret = _regulator_disable(rdev);
-	regulator_unlock(rdev);
+	regulator_unlock_dependent(rdev);
 
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2467,10 +2467,10 @@ int regulator_force_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
 
-	regulator_lock(rdev);
+	regulator_lock_dependent(rdev);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
-	regulator_unlock(rdev);
+	regulator_unlock_dependent(rdev);
 
 	if (rdev->supply)
 		while (rdev->open_count--)
-- 
2.7.4
