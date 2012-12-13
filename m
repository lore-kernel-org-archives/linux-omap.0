From: Paolo Pisati <paolo.pisati@canonical.com>
Subject: [PATCH] regulator: core: if voltage scaling fails, restore original voltage values
Date: Thu, 13 Dec 2012 10:13:00 +0100
Message-ID: <1355389980-5532-2-git-send-email-paolo.pisati@canonical.com>
References: <1355389980-5532-1-git-send-email-paolo.pisati@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355389980-5532-1-git-send-email-paolo.pisati@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Felipe Balbi <balbi@ti.com>, stable@vger.kernel.org, Paolo Pisati <paolo.pisati@canonical.com>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>
Tested-by: Robert Nelson <robertcnelson@gmail.com>
---
 drivers/regulator/core.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e872c8b..c347fd0 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2250,6 +2250,7 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
+	int old_min_uV, old_max_uV;
 
 	mutex_lock(&rdev->mutex);
 
@@ -2271,18 +2272,29 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 	ret = regulator_check_voltage(rdev, &min_uV, &max_uV);
 	if (ret < 0)
 		goto out;
+	
+	/* restore original values in case of error */
+	old_min_uV = regulator->min_uV;
+	old_max_uV = regulator->max_uV;
 	regulator->min_uV = min_uV;
 	regulator->max_uV = max_uV;
 
 	ret = regulator_check_consumers(rdev, &min_uV, &max_uV);
 	if (ret < 0)
-		goto out;
+		goto out2;
 
 	ret = _regulator_do_set_voltage(rdev, min_uV, max_uV);
-
+	if (ret < 0)
+		goto out2;
+	
 out:
 	mutex_unlock(&rdev->mutex);
 	return ret;
+out2:
+	regulator->min_uV = old_min_uV;
+	regulator->max_uV = old_max_uV;
+	mutex_unlock(&rdev->mutex);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_set_voltage);
 
-- 
1.7.10.4
