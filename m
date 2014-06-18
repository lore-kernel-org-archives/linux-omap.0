From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/2] regulators: TPS65218: Add the missing of_node assignment in probe
Date: Wed, 18 Jun 2014 10:17:47 -0500
Message-ID: <1403104668-32316-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Keerthy <j-keerthy@ti.com>, stable@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

Add the missing of_node assignment in probe.

Cc: <stable@vger.kernel.org> # v3.15
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/regulator/tps65218-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 69b4b77..edbc46e 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -240,6 +240,7 @@ static int tps65218_regulator_probe(struct platform_device *pdev)
 	config.init_data = init_data;
 	config.driver_data = tps;
 	config.regmap = tps->regmap;
+	config.of_node = pdev->dev.of_node;
 
 	rdev = devm_regulator_register(&pdev->dev, &regulators[id], &config);
 	if (IS_ERR(rdev)) {
-- 
2.0.0.rc1
