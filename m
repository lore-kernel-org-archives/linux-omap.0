From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/2] regulator: tps65218: Fix strobe assignment
Date: Fri, 10 Nov 2017 17:22:43 +0530
Message-ID: <1510314764-1940-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lee.jones@linaro.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

Currentlly tps_info structure is no longer used. So use the
strobes parameter in tps65218 structure to capture the info.

Fixes: 2dc4940360d4c0c (regulator: tps65218: Remove all the compatibles)
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/regulator/tps65218-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 9aafbb0..bc48995 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -154,7 +154,7 @@ static int tps65218_pmic_set_suspend_disable(struct regulator_dev *dev)
 
 	if (!tps->strobes[rid]) {
 		if (rid == TPS65218_DCDC_3)
-			tps->info[rid]->strobe = 3;
+			tps->strobes[rid] = 3;
 		else
 			return -EINVAL;
 	}
-- 
1.9.1
