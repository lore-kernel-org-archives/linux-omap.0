From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 5/9] regulator: helper routine to extract fixed_voltage_config
Date: Tue, 27 Sep 2011 15:42:48 +0530
Message-ID: <1317118372-17052-6-git-send-email-rnayak@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42637 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab1I0KNh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Sep 2011 06:13:37 -0400
In-Reply-To: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, Rajendra Nayak <rnayak@ti.com>

The helper routine of_get_fixed_voltage_config() extracts
fixed_voltage_config structure contents from device tree.

Also add documenation for additional bindings for fixed
regulators that can be passed through dt.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../bindings/regulator/fixed-regulator.txt         |   24 +++++++++++++
 drivers/regulator/fixed.c                          |   36 ++++++++++++++++++++
 include/linux/regulator/fixed.h                    |    6 ++--
 3 files changed, 63 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/fixed-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
new file mode 100644
index 0000000..a204cbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
@@ -0,0 +1,24 @@
+Fixed Voltage regulators
+
+Required properties:
+- compatible: Must be "regulator-fixed";
+
+Optional properties:
+- regulator-fixed-supply: Name of the regulator supply
+- regulator-fixed-microvolts: Output voltage of regulator
+- regulator-fixed-gpio: gpio to use for enable control
+- regulator-fixed-startup-delay: startup time in microseconds
+- regulator-fixed-enable-high: Polarity of enable GPIO, 1 = Active High, 0 = Active low
+- regulator-fixed-enabled-at-boot: 1 = yes, 0 = no
+
+Example:
+
+	abc: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-fixed-supply = "fixed-supply";
+		regulator-fixed-microvolts = <1800000>;
+		regulator-fixed-gpio = <43>;
+		regulator-fixed-startup-delay = <70000>;
+		regulator-fixed-enable-high;
+		regulator-fixed-enabled-at-boot;
+	};
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 2fe9d99..c09f791 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -26,6 +26,8 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/regulator/of_regulator.h>
 
 struct fixed_voltage_data {
 	struct regulator_desc desc;
@@ -37,6 +39,40 @@ struct fixed_voltage_data {
 	bool is_enabled;
 };
 
+
+/**
+ * of_get_fixed_voltage_config - extract fixed_voltage_config structure info
+ * @dev: device requesting for fixed_voltage_config
+ *
+ * Populates fixed_voltage_config structure by extracting data from device
+ * tree node, returns a pointer to the populated structure of NULL if memory
+ * alloc fails.
+ */
+struct fixed_voltage_config *of_get_fixed_voltage_config(struct device *dev)
+{
+	struct fixed_voltage_config *config;
+	struct device_node *np = dev->of_node;
+
+	config = devm_kzalloc(dev, sizeof(struct fixed_voltage_config), GFP_KERNEL);
+	if (!config)
+		return NULL;
+
+	config->supply_name = (char *)of_get_property(np,
+					"regulator-fixed-supply", NULL);
+	of_property_read_u32(np, "regulator-fixed-microvolts",
+					&config->microvolts);
+	of_property_read_u32(np, "regulator-fixed-gpio", &config->gpio);
+	of_property_read_u32(np, "regulator-fixed-startup-delay",
+					&config->startup_delay);
+	if (of_find_property(np, "regulator-fixed-enable-high", NULL))
+		config->enable_high = true;
+	if (of_find_property(np, "regulator-fixed-enabled-at-boot", NULL))
+		config->enabled_at_boot = true;
+	config->init_data = of_get_regulator_init_data(dev);
+
+	return config;
+}
+
 static int fixed_voltage_is_enabled(struct regulator_dev *dev)
 {
 	struct fixed_voltage_data *data = rdev_get_drvdata(dev);
diff --git a/include/linux/regulator/fixed.h b/include/linux/regulator/fixed.h
index ffd7d50..bb762cf 100644
--- a/include/linux/regulator/fixed.h
+++ b/include/linux/regulator/fixed.h
@@ -40,9 +40,9 @@ struct regulator_init_data;
  */
 struct fixed_voltage_config {
 	const char *supply_name;
-	int microvolts;
-	int gpio;
-	unsigned startup_delay;
+	u32 microvolts;
+	u32 gpio;
+	u32 startup_delay;
 	unsigned enable_high:1;
 	unsigned enabled_at_boot:1;
 	struct regulator_init_data *init_data;
-- 
1.7.1

