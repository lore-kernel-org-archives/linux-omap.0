From: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Subject: [PATCH 2/2] mfd: tps65218.c: Add input voltage options
Date: Tue, 18 Dec 2018 09:05:56 +0100
Message-ID: <1545120356-7749-3-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

These options apply to all regulators in this chip.

strict-supply-voltage:
  Set STRICT flag in CONFIG1
under-voltage-limit:
  Select 2.75, 2.95, 3.25 or 3.35 V UVLO in CONFIG1
under-voltage-hysteresis:
  Select 200mV or 400mV UVLOHYS in CONFIG2

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 drivers/mfd/tps65218.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 8bcdecf..f5e559b 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -211,6 +211,50 @@ static const struct of_device_id of_tps65218_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, of_tps65218_match_table);
 
+static void tps65218_options(struct tps65218 *tps)
+{
+	struct device *dev = tps->dev;
+	struct device_node *np = dev->of_node;
+	u32 pval;
+
+	if (!of_property_read_u32(np, "strict-supply-voltage", &pval)) {
+		tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
+			TPS65218_CONFIG1_STRICT,
+			pval ? TPS65218_CONFIG1_STRICT : 0,
+			TPS65218_PROTECT_L1);
+		dev_dbg(dev, "tps65218 strict-supply-voltage: %d\n", pval);
+	}
+	if (!of_property_read_u32(np, "under-voltage-hysteresis", &pval)) {
+		if (pval != 400000 && pval != 200000) {
+			dev_err(dev,
+				 "under-voltage-hysteresis must be %d or %d\n",
+				 200000, 400000);
+		} else {
+			tps65218_update_bits(tps, TPS65218_REG_CONFIG2,
+				TPS65218_CONFIG2_UVLOHYS,
+				pval == 400000 ? TPS65218_CONFIG2_UVLOHYS : 0,
+				TPS65218_PROTECT_L1);
+		}
+		dev_dbg(dev, "tps65218 under-voltage-hysteresis: %d\n", pval);
+	}
+	if (!of_property_read_u32(np, "under-voltage-limit", &pval)) {
+		int i, vals[] = { 275, 295, 325, 335 };
+
+		for (i = 0; i < ARRAY_SIZE(vals); i++) {
+			if (pval == vals[i] * 10000)
+				break;
+		}
+		if (i < ARRAY_SIZE(vals)) {
+			tps65218_update_bits(tps, TPS65218_REG_CONFIG1,
+				TPS65218_CONFIG1_UVLO_MASK, i,
+				TPS65218_PROTECT_L1);
+		} else {
+			dev_err(dev, "Invalid under-voltage-limit: %d\n", pval);
+		}
+		dev_dbg(dev, "tps65218 under-voltage-limit: %d=%d\n", pval, i);
+	}
+}
+
 static int tps65218_probe(struct i2c_client *client,
 				const struct i2c_device_id *ids)
 {
@@ -249,6 +293,8 @@ static int tps65218_probe(struct i2c_client *client,
 
 	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;
 
+	tps65218_options(tps);
+
 	ret = mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65218_cells,
 			      ARRAY_SIZE(tps65218_cells), NULL, 0,
 			      regmap_irq_get_domain(tps->irq_data));
-- 
2.7.4
