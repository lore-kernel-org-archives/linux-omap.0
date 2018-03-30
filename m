From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 05/10] mfd: ti-lmu: use of_device_get_match_data() helper
Date: Fri, 30 Mar 2018 19:24:09 +0200
Message-ID: <20180330172414.26575-6-sebastian.reichel@collabora.co.uk>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Milo Kim <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Replace of_match_device() with of_device_get_match_data(), which
slightly decreases lines of code and allows to move the DT table
next to the I2C table.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/mfd/ti-lmu.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index de76298cf3a8..ce16c896879b 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -142,34 +142,21 @@ TI_LMU_DATA(lm3633, LM3633_MAX_REG);
 TI_LMU_DATA(lm3695, LM3695_MAX_REG);
 TI_LMU_DATA(lm3697, LM3697_MAX_REG);
 
-static const struct of_device_id ti_lmu_of_match[] = {
-	{ .compatible = "ti,lm3532", .data = &lm3532_data },
-	{ .compatible = "ti,lm3631", .data = &lm3631_data },
-	{ .compatible = "ti,lm3632", .data = &lm3632_data },
-	{ .compatible = "ti,lm3633", .data = &lm3633_data },
-	{ .compatible = "ti,lm3695", .data = &lm3695_data },
-	{ .compatible = "ti,lm3697", .data = &lm3697_data },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, ti_lmu_of_match);
-
 static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 {
 	struct device *dev = &cl->dev;
-	const struct of_device_id *match;
 	const struct ti_lmu_data *data;
 	struct regmap_config regmap_cfg;
 	struct ti_lmu *lmu;
 	int ret;
 
-	match = of_match_device(ti_lmu_of_match, dev);
-	if (!match)
-		return -ENODEV;
 	/*
 	 * Get device specific data from of_match table.
 	 * This data is defined by using TI_LMU_DATA() macro.
 	 */
-	data = (struct ti_lmu_data *)match->data;
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
 
 	lmu = devm_kzalloc(dev, sizeof(*lmu), GFP_KERNEL);
 	if (!lmu)
@@ -217,6 +204,17 @@ static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 				    data->num_cells, NULL, 0, NULL);
 }
 
+static const struct of_device_id ti_lmu_of_match[] = {
+	{ .compatible = "ti,lm3532", .data = &lm3532_data },
+	{ .compatible = "ti,lm3631", .data = &lm3631_data },
+	{ .compatible = "ti,lm3632", .data = &lm3632_data },
+	{ .compatible = "ti,lm3633", .data = &lm3633_data },
+	{ .compatible = "ti,lm3695", .data = &lm3695_data },
+	{ .compatible = "ti,lm3697", .data = &lm3697_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ti_lmu_of_match);
+
 static const struct i2c_device_id ti_lmu_ids[] = {
 	{ "lm3532", LM3532 },
 	{ "lm3631", LM3631 },
-- 
2.16.2
