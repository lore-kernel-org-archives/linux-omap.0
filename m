From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 3/5] regulator: tps65218: force set power-up/down strobe to 3 for dcdc3
Date: Fri, 24 Jun 2016 13:58:09 +0530
Message-ID: <1466756892-17015-3-git-send-email-j-keerthy@ti.com>
References: <1466756892-17015-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466756892-17015-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, tony@atomide.com, broonie@kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, j-keerthy@ti.com, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

The reset value for this register seems broken on certain versions of
tps65218 chip, so make sure the dcdc3 settings is proper. Needed for
proper functionality of rtc+ddr / rtc-only modes.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/regulator/tps65218-regulator.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 8eca1eb..d1e631d 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -180,8 +180,12 @@ static int tps65218_pmic_set_suspend_disable(struct regulator_dev *dev)
 	if (rid < TPS65218_DCDC_1 || rid > TPS65218_LDO_1)
 		return -EINVAL;
 
-	if (!tps->info[rid]->strobe)
-		return -EINVAL;
+	if (!tps->info[rid]->strobe) {
+		if (rid == TPS65218_DCDC_3)
+			tps->info[rid]->strobe = 3;
+		else
+			return -EINVAL;
+	}
 
 	return tps65218_set_bits(tps, dev->desc->bypass_reg,
 				 dev->desc->bypass_mask,
-- 
1.9.1
