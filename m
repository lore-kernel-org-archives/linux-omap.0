From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/4] regulator: fixed: Properly use input_supply parameter from device tree
Date: Thu, 15 Nov 2012 16:56:36 +0200
Message-ID: <1352991396-19589-5-git-send-email-rogerq@ti.com>
References: <1352991396-19589-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352991396-19589-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: b-cousson-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The device tree node will provide the input supply name as
a string. Use that to populate the supply_name parameter of
the regulator descriptor.

Also correct the documentation to reflect the same.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
CC: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
CC: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 .../bindings/regulator/fixed-regulator.txt         |    6 +++---
 drivers/regulator/fixed.c                          |    6 ++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
index 4fae41d..fe34114 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
@@ -7,10 +7,10 @@ Optional properties:
 - gpio: gpio to use for enable control
 - startup-delay-us: startup time in microseconds
 - enable-active-high: Polarity of GPIO is Active high
-If this property is missing, the default assumed is Active low.
+  If this property is missing, the default assumed is Active low.
 - gpio-open-drain: GPIO is open drain type.
   If this property is missing then default assumption is false.
--vin-supply: Input supply name.
+- vin-supply: Input supply name.
 
 Any property defined as part of the core regulator
 binding, defined in regulator.txt, can also be used.
@@ -30,5 +30,5 @@ Example:
 		enable-active-high;
 		regulator-boot-on;
 		gpio-open-drain;
-		vin-supply = <&parent_reg>;
+		vin-supply = "input-supply-name";
 	};
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 185468c..3a6f4ad 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -53,6 +53,7 @@ of_get_fixed_voltage_config(struct device *dev)
 	struct device_node *np = dev->of_node;
 	const __be32 *delay;
 	struct regulator_init_data *init_data;
+	const char *vin_name;
 
 	config = devm_kzalloc(dev, sizeof(struct fixed_voltage_config),
 								 GFP_KERNEL);
@@ -102,8 +103,9 @@ of_get_fixed_voltage_config(struct device *dev)
 	if (of_find_property(np, "gpio-open-drain", NULL))
 		config->gpio_is_open_drain = true;
 
-	if (of_find_property(np, "vin-supply", NULL))
-		config->input_supply = "vin";
+	vin_name = of_get_property(np, "vin-supply", NULL);
+	if (vin_name)
+		config->input_supply = vin_name;
 
 	return config;
 }
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
