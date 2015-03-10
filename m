From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v4 2/6] power: twl4030_madc_battery: Add device tree support
Date: Tue, 10 Mar 2015 22:27:23 +0100
Message-ID: <1426022847-30912-3-git-send-email-marek@goldelico.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1426022847-30912-1-git-send-email-marek@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bcousson@baylibre.com, tony@atomide.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, hns@goldelico.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, Marek Belisko <marek@goldelico.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 drivers/power/twl4030_madc_battery.c | 81 ++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/power/twl4030_madc_battery.c b/drivers/power/twl4030_madc_battery.c
index 6af28b5..4bcb4a9 100644
--- a/drivers/power/twl4030_madc_battery.c
+++ b/drivers/power/twl4030_madc_battery.c
@@ -20,6 +20,7 @@
 #include <linux/i2c/twl4030-madc.h>
 #include <linux/power/twl4030_madc_battery.h>
 #include <linux/iio/consumer.h>
+#include <linux/of.h>
 
 struct twl4030_madc_battery {
 	struct power_supply psy;
@@ -183,6 +184,82 @@ static int twl4030_cmp(const void *a, const void *b)
 		((struct twl4030_madc_bat_calibration *)a)->voltage;
 }
 
+#ifdef CONFIG_OF
+static struct twl4030_madc_bat_platform_data *
+	twl4030_madc_dt_probe(struct platform_device *pdev)
+{
+	struct twl4030_madc_bat_platform_data *pdata;
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+	int i, proplen;
+
+	pdata = devm_kzalloc(&pdev->dev,
+			sizeof(struct twl4030_madc_bat_platform_data),
+			GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	ret = of_property_read_u32(np, "capacity-uah", &pdata->capacity);
+	if (ret != 0)
+		return ERR_PTR(-EINVAL);
+
+	/* parse and prepare charging data */
+	proplen = of_property_count_u32_elems(np, "ti,volt-to-capacity-charging-map");
+	if (proplen < 0) {
+		dev_warn(&pdev->dev, "No 'ti,volt-to-capacity-charging-map' property found\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdata->charging = devm_kzalloc(&pdev->dev,
+		sizeof(struct twl4030_madc_bat_calibration) * (proplen / 2),
+		GFP_KERNEL);
+
+	for (i = 0; i < proplen / 2; i++) {
+		of_property_read_u32_index(np, "ti,volt-to-capacity-charging-map",
+					   i * 2,
+					   (u32 *)&pdata->charging[i].voltage);
+		of_property_read_u32_index(np, "ti,volt-to-capacity-charging-map",
+					  i * 2 + 1,
+					  (u32 *)&pdata->charging[i].level);
+	}
+
+	/* parse and prepare discharging data */
+	proplen = of_property_count_u32_elems(np,
+			"ti,volt-to-capacity-discharging-map");
+	if (proplen < 0) {
+		dev_warn(&pdev->dev, "No 'ti,volt-to-capacity-discharging-map' property found\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdata->discharging = devm_kzalloc(&pdev->dev,
+		sizeof(struct twl4030_madc_bat_calibration) * (proplen / 2),
+		GFP_KERNEL);
+
+	for (i = 0; i < proplen / 2; i++) {
+		of_property_read_u32_index(np, "ti,volt-to-capacity-discharging-map",
+					   i * 2,
+					   (u32 *)&pdata->discharging[i].voltage);
+		of_property_read_u32_index(np, "ti,volt-to-capacity-discharging-map",
+					   i * 2 + 1,
+					   (u32 *)&pdata->discharging[i].level);
+	}
+
+	return pdata;
+}
+
+static const struct of_device_id of_twl4030_madc_match[] = {
+	{ .compatible = "ti,twl4030-madc-battery", },
+	{},
+};
+
+#else
+static struct twl4030_madc_bat_platform_data *
+	twl4030_madc_dt_probe(struct platform_device *pdev)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+
 static int twl4030_madc_battery_probe(struct platform_device *pdev)
 {
 	struct twl4030_madc_battery *twl4030_madc_bat;
@@ -194,6 +271,9 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
 	if (!twl4030_madc_bat)
 		return -ENOMEM;
 
+	if (!pdata)
+		pdata = twl4030_madc_dt_probe(pdev);
+
 	twl4030_madc_bat->psy.name = "twl4030_battery";
 	twl4030_madc_bat->psy.type = POWER_SUPPLY_TYPE_BATTERY;
 	twl4030_madc_bat->psy.properties = twl4030_madc_bat_props;
@@ -263,6 +343,7 @@ static int twl4030_madc_battery_remove(struct platform_device *pdev)
 static struct platform_driver twl4030_madc_battery_driver = {
 	.driver = {
 		.name = "twl4030_madc_battery",
+		.of_match_table = of_match_ptr(of_twl4030_madc_match),
 	},
 	.probe  = twl4030_madc_battery_probe,
 	.remove = twl4030_madc_battery_remove,
-- 
1.9.1
