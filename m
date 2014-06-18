From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/2] regulators: TPS65218: Correct the the config register for LDO1
Date: Wed, 18 Jun 2014 10:17:48 -0500
Message-ID: <1403104668-32316-2-git-send-email-balbi@ti.com>
References: <1403104668-32316-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403104668-32316-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Keerthy <j-keerthy@ti.com>, stable@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

Correct the the config register for LDO1.

Cc: <stable@vger.kernel.org> # v3.15
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/regulator/tps65218-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index edbc46e..9effe48 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -209,7 +209,7 @@ static const struct regulator_desc regulators[] = {
 			   1, -1, -1, TPS65218_REG_ENABLE1,
 			   TPS65218_ENABLE1_DC6_EN, NULL, NULL, 0, 0),
 	TPS65218_REGULATOR("LDO1", TPS65218_LDO_1, tps65218_ldo1_dcdc34_ops, 64,
-			   TPS65218_REG_CONTROL_DCDC4,
+			   TPS65218_REG_CONTROL_LDO1,
 			   TPS65218_CONTROL_LDO1_MASK, TPS65218_REG_ENABLE2,
 			   TPS65218_ENABLE2_LDO1_EN, NULL, ldo1_dcdc3_ranges,
 			   2, 0),
-- 
2.0.0.rc1
