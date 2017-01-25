From: Furquan Shaikh <furquan@chromium.org>
Subject: [PATCH 7/7] drivers/regulator: Initialize regulator init data for ACPI regulators
Date: Tue, 24 Jan 2017 16:06:41 -0800
Message-ID: <20170125000641.25520-8-furquan@chromium.org>
References: <20170125000641.25520-1-furquan@chromium.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170125000641.25520-1-furquan@chromium.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Furquan Shaikh <furquan@chromium.org>
List-Id: linux-omap@vger.kernel.org

Regulator init data and regulation constraints need to be setup by
ACPI regulators similar to OF regulators. This is required to ensure
that drivers can properly enable/disable the regulators.

Since, regulator properties remain the same across OF and ACPI
regulators, provide common routines for obtaining the regulation
constraints from device tree/ACPI node. Update fixed regulator driver
to use this newly added routine.

Signed-off-by: Furquan Shaikh <furquan@chromium.org>
---
 drivers/regulator/Makefile          |   2 +-
 drivers/regulator/fixed.c           | 100 +++++++------------
 drivers/regulator/internal.h        |   3 +
 drivers/regulator/of_regulator.c    | 156 +----------------------------
 drivers/regulator/regulator_props.c | 189 ++++++++++++++++++++++++++++++++++++
 5 files changed, 229 insertions(+), 221 deletions(-)
 create mode 100644 drivers/regulator/regulator_props.c

diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 14294692beb9..7701cb9e9bec 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -3,7 +3,7 @@
 #
 
 
-obj-$(CONFIG_REGULATOR) += core.o dummy.o fixed-helper.o helpers.o devres.o
+obj-$(CONFIG_REGULATOR) += core.o dummy.o fixed-helper.o helpers.o devres.o regulator_props.o
 obj-$(CONFIG_OF) += of_regulator.o
 obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) += fixed.o
 obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index a43b0e8a438d..572f352095c3 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -34,39 +34,40 @@
 #include <linux/property.h>
 #include <linux/gpio/consumer.h>
 
+#include "internal.h"
+
 struct fixed_voltage_data {
 	struct regulator_desc desc;
 	struct regulator_dev *dev;
 };
 
-
 /**
- * of_get_fixed_voltage_config - extract fixed_voltage_config structure info
+ * reg_get_fixed_voltage_config - extract fixed_voltage_config structure info
  * @dev: device requesting for fixed_voltage_config
  * @desc: regulator description
  *
  * Populates fixed_voltage_config structure by extracting data from device
- * tree node, returns a pointer to the populated structure of NULL if memory
- * alloc fails.
+ * tree or ACPI node, returns a pointer to the populated structure or NULL if
+ * memory alloc fails.
  */
 static struct fixed_voltage_config *
-of_get_fixed_voltage_config(struct device *dev,
-			    const struct regulator_desc *desc)
+reg_fixed_voltage_get_config(struct device *dev,
+			const struct regulator_desc *desc)
 {
 	struct fixed_voltage_config *config;
-	struct device_node *np = dev->of_node;
 	struct regulator_init_data *init_data;
+	struct gpio_desc *gpiod;
 
-	config = devm_kzalloc(dev, sizeof(struct fixed_voltage_config),
-								 GFP_KERNEL);
+	config = devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
 	if (!config)
 		return ERR_PTR(-ENOMEM);
 
-	config->init_data = of_get_regulator_init_data(dev, dev->of_node, desc);
-	if (!config->init_data)
+	init_data = devm_kzalloc(dev, sizeof(*init_data), GFP_KERNEL);
+	if (!init_data)
 		return ERR_PTR(-EINVAL);
 
-	init_data = config->init_data;
+	device_get_regulation_constraints(dev_fwnode(dev), init_data, desc);
+
 	init_data->constraints.apply_uV = 0;
 
 	config->supply_name = init_data->constraints.name;
@@ -74,63 +75,35 @@ of_get_fixed_voltage_config(struct device *dev,
 		config->microvolts = init_data->constraints.min_uV;
 	} else {
 		dev_err(dev,
-			 "Fixed regulator specified with variable voltages\n");
+			"Fixed regulator specified with variable voltages\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	if (init_data->constraints.boot_on)
 		config->enabled_at_boot = true;
 
-	config->gpio = of_get_named_gpio(np, "gpio", 0);
-	if ((config->gpio < 0) && (config->gpio != -ENOENT))
-		return ERR_PTR(config->gpio);
-
-	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
+	gpiod = gpiod_lookup(dev, NULL);
 
-	config->enable_high = of_property_read_bool(np, "enable-active-high");
-	config->gpio_is_open_drain = of_property_read_bool(np,
-							   "gpio-open-drain");
+	if (gpiod == ERR_PTR(-EPROBE_DEFER))
+		return ERR_PTR(-EPROBE_DEFER);
 
-	if (of_find_property(np, "vin-supply", NULL))
-		config->input_supply = "vin";
+	if (!IS_ERR(gpiod))
+		config->gpio = desc_to_gpio(gpiod);
+	else
+		config->gpio = -1;
 
-	return config;
-}
+	device_property_read_u32(dev, "startup-delay-us",
+				&config->startup_delay);
 
-/**
- * acpi_get_fixed_voltage_config - extract fixed_voltage_config structure info
- * @dev: device requesting for fixed_voltage_config
- * @desc: regulator description
- *
- * Populates fixed_voltage_config structure by extracting data through ACPI
- * interface, returns a pointer to the populated structure of NULL if memory
- * alloc fails.
- */
-static struct fixed_voltage_config *
-acpi_get_fixed_voltage_config(struct device *dev,
-			      const struct regulator_desc *desc)
-{
-	struct fixed_voltage_config *config;
-	const char *supply_name;
-	struct gpio_desc *gpiod;
-	int ret;
-
-	config = devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
-	if (!config)
-		return ERR_PTR(-ENOMEM);
-
-	ret = device_property_read_string(dev, "supply-name", &supply_name);
-	if (!ret)
-		config->supply_name = supply_name;
-
-	gpiod = gpiod_get(dev, "gpio", GPIOD_ASIS);
-	if (IS_ERR(gpiod))
-		return ERR_PTR(-ENODEV);
-
-	config->gpio = desc_to_gpio(gpiod);
 	config->enable_high = device_property_read_bool(dev,
 							"enable-active-high");
-	gpiod_put(gpiod);
+	config->gpio_is_open_drain = device_property_read_bool(dev,
+							"gpio-open-drain");
+
+	if (device_property_present(dev, "vin-supply"))
+		config->input_supply = "vin";
+
+	config->init_data = init_data;
 
 	return config;
 }
@@ -150,14 +123,9 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
-	if (pdev->dev.of_node) {
-		config = of_get_fixed_voltage_config(&pdev->dev,
-						     &drvdata->desc);
-		if (IS_ERR(config))
-			return PTR_ERR(config);
-	} else if (ACPI_HANDLE(&pdev->dev)) {
-		config = acpi_get_fixed_voltage_config(&pdev->dev,
-						       &drvdata->desc);
+	if (pdev->dev.of_node || ACPI_HANDLE(&pdev->dev)) {
+		config = reg_fixed_voltage_get_config(&pdev->dev,
+						      &drvdata->desc);
 		if (IS_ERR(config))
 			return PTR_ERR(config);
 	} else {
@@ -198,7 +166,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 
 	if (gpio_is_valid(config->gpio)) {
 		cfg.ena_gpio = config->gpio;
-		if (pdev->dev.of_node)
+		if (pdev->dev.of_node || ACPI_HANDLE(&pdev->dev))
 			cfg.ena_gpio_initialized = true;
 	}
 	cfg.ena_gpio_invert = !config->enable_high;
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index c74ac8734023..3a699b2cbea9 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -51,4 +51,7 @@ regulator_of_get_init_data(struct device *dev,
 }
 #endif
 
+void device_get_regulation_constraints(struct fwnode_handle *fwnode,
+					struct regulator_init_data *init_data,
+					const struct regulator_desc *desc);
 #endif
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 13d4dc2c287e..0ff5259c34f0 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -19,159 +19,6 @@
 
 #include "internal.h"
 
-static const char *const regulator_states[PM_SUSPEND_MAX + 1] = {
-	[PM_SUSPEND_MEM]	= "regulator-state-mem",
-	[PM_SUSPEND_MAX]	= "regulator-state-disk",
-};
-
-static void of_get_regulation_constraints(struct device_node *np,
-					struct regulator_init_data **init_data,
-					const struct regulator_desc *desc)
-{
-	struct regulation_constraints *constraints = &(*init_data)->constraints;
-	struct regulator_state *suspend_state;
-	struct device_node *suspend_np;
-	int ret, i;
-	u32 pval;
-
-	constraints->name = of_get_property(np, "regulator-name", NULL);
-
-	if (!of_property_read_u32(np, "regulator-min-microvolt", &pval))
-		constraints->min_uV = pval;
-
-	if (!of_property_read_u32(np, "regulator-max-microvolt", &pval))
-		constraints->max_uV = pval;
-
-	/* Voltage change possible? */
-	if (constraints->min_uV != constraints->max_uV)
-		constraints->valid_ops_mask |= REGULATOR_CHANGE_VOLTAGE;
-
-	/* Do we have a voltage range, if so try to apply it? */
-	if (constraints->min_uV && constraints->max_uV)
-		constraints->apply_uV = true;
-
-	if (!of_property_read_u32(np, "regulator-microvolt-offset", &pval))
-		constraints->uV_offset = pval;
-	if (!of_property_read_u32(np, "regulator-min-microamp", &pval))
-		constraints->min_uA = pval;
-	if (!of_property_read_u32(np, "regulator-max-microamp", &pval))
-		constraints->max_uA = pval;
-
-	if (!of_property_read_u32(np, "regulator-input-current-limit-microamp",
-				  &pval))
-		constraints->ilim_uA = pval;
-
-	/* Current change possible? */
-	if (constraints->min_uA != constraints->max_uA)
-		constraints->valid_ops_mask |= REGULATOR_CHANGE_CURRENT;
-
-	constraints->boot_on = of_property_read_bool(np, "regulator-boot-on");
-	constraints->always_on = of_property_read_bool(np, "regulator-always-on");
-	if (!constraints->always_on) /* status change should be possible. */
-		constraints->valid_ops_mask |= REGULATOR_CHANGE_STATUS;
-
-	constraints->pull_down = of_property_read_bool(np, "regulator-pull-down");
-
-	if (of_property_read_bool(np, "regulator-allow-bypass"))
-		constraints->valid_ops_mask |= REGULATOR_CHANGE_BYPASS;
-
-	if (of_property_read_bool(np, "regulator-allow-set-load"))
-		constraints->valid_ops_mask |= REGULATOR_CHANGE_DRMS;
-
-	ret = of_property_read_u32(np, "regulator-ramp-delay", &pval);
-	if (!ret) {
-		if (pval)
-			constraints->ramp_delay = pval;
-		else
-			constraints->ramp_disable = true;
-	}
-
-	ret = of_property_read_u32(np, "regulator-enable-ramp-delay", &pval);
-	if (!ret)
-		constraints->enable_time = pval;
-
-	constraints->soft_start = of_property_read_bool(np,
-					"regulator-soft-start");
-	ret = of_property_read_u32(np, "regulator-active-discharge", &pval);
-	if (!ret) {
-		constraints->active_discharge =
-				(pval) ? REGULATOR_ACTIVE_DISCHARGE_ENABLE :
-					REGULATOR_ACTIVE_DISCHARGE_DISABLE;
-	}
-
-	if (!of_property_read_u32(np, "regulator-initial-mode", &pval)) {
-		if (desc && desc->map_mode) {
-			ret = desc->map_mode(pval);
-			if (ret == -EINVAL)
-				pr_err("%s: invalid mode %u\n", np->name, pval);
-			else
-				constraints->initial_mode = ret;
-		} else {
-			pr_warn("%s: mapping for mode %d not defined\n",
-				np->name, pval);
-		}
-	}
-
-	if (!of_property_read_u32(np, "regulator-system-load", &pval))
-		constraints->system_load = pval;
-
-	constraints->over_current_protection = of_property_read_bool(np,
-					"regulator-over-current-protection");
-
-	for (i = 0; i < ARRAY_SIZE(regulator_states); i++) {
-		switch (i) {
-		case PM_SUSPEND_MEM:
-			suspend_state = &constraints->state_mem;
-			break;
-		case PM_SUSPEND_MAX:
-			suspend_state = &constraints->state_disk;
-			break;
-		case PM_SUSPEND_ON:
-		case PM_SUSPEND_FREEZE:
-		case PM_SUSPEND_STANDBY:
-		default:
-			continue;
-		}
-
-		suspend_np = of_get_child_by_name(np, regulator_states[i]);
-		if (!suspend_np || !suspend_state)
-			continue;
-
-		if (!of_property_read_u32(suspend_np, "regulator-mode",
-					  &pval)) {
-			if (desc && desc->map_mode) {
-				ret = desc->map_mode(pval);
-				if (ret == -EINVAL)
-					pr_err("%s: invalid mode %u\n",
-					       np->name, pval);
-				else
-					suspend_state->mode = ret;
-			} else {
-				pr_warn("%s: mapping for mode %d not defined\n",
-					np->name, pval);
-			}
-		}
-
-		if (of_property_read_bool(suspend_np,
-					"regulator-on-in-suspend"))
-			suspend_state->enabled = true;
-		else if (of_property_read_bool(suspend_np,
-					"regulator-off-in-suspend"))
-			suspend_state->disabled = true;
-
-		if (!of_property_read_u32(suspend_np,
-					"regulator-suspend-microvolt", &pval))
-			suspend_state->uV = pval;
-
-		if (i == PM_SUSPEND_MEM)
-			constraints->initial_state = PM_SUSPEND_MEM;
-
-		of_node_put(suspend_np);
-		suspend_state = NULL;
-		suspend_np = NULL;
-	}
-}
-
 /**
  * of_get_regulator_init_data - extract regulator_init_data structure info
  * @dev: device requesting for regulator_init_data
@@ -195,7 +42,8 @@ struct regulator_init_data *of_get_regulator_init_data(struct device *dev,
 	if (!init_data)
 		return NULL; /* Out of memory? */
 
-	of_get_regulation_constraints(node, &init_data, desc);
+	device_get_regulation_constraints(&node->fwnode, init_data, desc);
+
 	return init_data;
 }
 EXPORT_SYMBOL_GPL(of_get_regulator_init_data);
diff --git a/drivers/regulator/regulator_props.c b/drivers/regulator/regulator_props.c
new file mode 100644
index 000000000000..65e78ad1f494
--- /dev/null
+++ b/drivers/regulator/regulator_props.c
@@ -0,0 +1,189 @@
+/*
+ * ACPI helpers for regulator framework
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc
+ * Copyright (C) 2016 Google Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/of.h>
+#include <linux/property.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+static const char *const regulator_states[PM_SUSPEND_MAX + 1] = {
+	[PM_SUSPEND_MEM]	= "regulator-state-mem",
+	[PM_SUSPEND_MAX]	= "regulator-state-disk",
+};
+
+/**
+ * device_get_regulation_constraints - extract regulation_constraints info
+ * @fwnode: fwnode of device requesting for regulation_constraints
+ * @init_data: regulator_init_data structure containing regulation_constraints
+ * @desc: regulator description
+ *
+ * Populates regulation_constraints structure by extracting data from device
+ * tree or ACPI node.
+ */
+void device_get_regulation_constraints(struct fwnode_handle *fwnode,
+					struct regulator_init_data *init_data,
+					const struct regulator_desc *desc)
+{
+	struct regulation_constraints *constraints = &init_data->constraints;
+	int ret, i;
+	u32 pval;
+	struct regulator_state *suspend_state = NULL;
+	struct fwnode_handle *suspend_fwnode;
+
+	fwnode_property_read_string(fwnode, "regulator-name",
+					&constraints->name);
+
+	if (!fwnode_property_read_u32(fwnode, "regulator-min-microvolt", &pval))
+		constraints->min_uV = pval;
+
+	if (!fwnode_property_read_u32(fwnode, "regulator-max-microvolt", &pval))
+		constraints->max_uV = pval;
+
+	/* Voltage change possible? */
+	if (constraints->min_uV != constraints->max_uV)
+		constraints->valid_ops_mask |= REGULATOR_CHANGE_VOLTAGE;
+
+	/* Do we have a voltage range, if so try to apply it? */
+	if (constraints->min_uV && constraints->max_uV)
+		constraints->apply_uV = true;
+
+	if (!fwnode_property_read_u32(fwnode, "regulator-microvolt-offset",
+					&pval))
+		constraints->uV_offset = pval;
+	if (!fwnode_property_read_u32(fwnode, "regulator-min-microamp", &pval))
+		constraints->min_uA = pval;
+	if (!fwnode_property_read_u32(fwnode, "regulator-max-microamp", &pval))
+		constraints->max_uA = pval;
+
+	if (!fwnode_property_read_u32(fwnode,
+				"regulator-input-current-limit-microamp",
+				&pval))
+		constraints->ilim_uA = pval;
+
+	/* Current change possible? */
+	if (constraints->min_uA != constraints->max_uA)
+		constraints->valid_ops_mask |= REGULATOR_CHANGE_CURRENT;
+
+	constraints->boot_on = fwnode_property_read_bool(fwnode,
+							"regulator-boot-on");
+	constraints->always_on = fwnode_property_read_bool(fwnode,
+							"regulator-always-on");
+	if (!constraints->always_on) /* status change should be possible. */
+		constraints->valid_ops_mask |= REGULATOR_CHANGE_STATUS;
+
+	constraints->pull_down = fwnode_property_read_bool(fwnode,
+							"regulator-pull-down");
+
+	if (fwnode_property_read_bool(fwnode, "regulator-allow-bypass"))
+		constraints->valid_ops_mask |= REGULATOR_CHANGE_BYPASS;
+
+	if (fwnode_property_read_bool(fwnode, "regulator-allow-set-load"))
+		constraints->valid_ops_mask |= REGULATOR_CHANGE_DRMS;
+
+	ret = fwnode_property_read_u32(fwnode, "regulator-ramp-delay", &pval);
+	if (!ret) {
+		if (pval)
+			constraints->ramp_delay = pval;
+		else
+			constraints->ramp_disable = true;
+	}
+
+	ret = fwnode_property_read_u32(fwnode, "regulator-enable-ramp-delay",
+					&pval);
+	if (!ret)
+		constraints->enable_time = pval;
+
+	constraints->soft_start = fwnode_property_read_bool(fwnode,
+							"regulator-soft-start");
+	ret = fwnode_property_read_u32(fwnode, "regulator-active-discharge",
+					&pval);
+	if (!ret) {
+		constraints->active_discharge =
+				(pval) ? REGULATOR_ACTIVE_DISCHARGE_ENABLE :
+					REGULATOR_ACTIVE_DISCHARGE_DISABLE;
+	}
+
+	if (!fwnode_property_read_u32(fwnode, "regulator-initial-mode",
+					&pval)) {
+		if (desc && desc->map_mode) {
+			ret = desc->map_mode(pval);
+			if (ret == -EINVAL)
+				pr_err("invalid mode %u\n", pval);
+			else
+				constraints->initial_mode = ret;
+		} else {
+			pr_warn("mapping for mode %d not defined\n", pval);
+		}
+	}
+
+	if (!fwnode_property_read_u32(fwnode, "regulator-system-load", &pval))
+		constraints->system_load = pval;
+
+	constraints->over_current_protection = fwnode_property_read_bool(fwnode,
+					"regulator-over-current-protection");
+
+	for (i = 0; i < ARRAY_SIZE(regulator_states); i++) {
+		switch (i) {
+		case PM_SUSPEND_MEM:
+			suspend_state = &constraints->state_mem;
+			break;
+		case PM_SUSPEND_MAX:
+			suspend_state = &constraints->state_disk;
+			break;
+		case PM_SUSPEND_ON:
+		case PM_SUSPEND_FREEZE:
+		case PM_SUSPEND_STANDBY:
+		default:
+			continue;
+		}
+
+		suspend_fwnode = fwnode_get_named_child_node(fwnode,
+							regulator_states[i]);
+		if (!suspend_fwnode || !suspend_state)
+			continue;
+
+		if (!fwnode_property_read_u32(suspend_fwnode, "regulator-mode",
+						&pval)) {
+			if (desc && desc->map_mode) {
+				ret = desc->map_mode(pval);
+				if (ret == -EINVAL)
+					pr_err("invalid mode %u\n", pval);
+				else
+					suspend_state->mode = ret;
+			} else {
+				pr_warn("mapping for mode %d not defined\n",
+					pval);
+			}
+		}
+
+		if (fwnode_property_read_bool(suspend_fwnode,
+					"regulator-on-in-suspend"))
+			suspend_state->enabled = true;
+		else if (fwnode_property_read_bool(suspend_fwnode,
+						"regulator-off-in-suspend"))
+			suspend_state->disabled = true;
+
+		if (!fwnode_property_read_u32(suspend_fwnode,
+					"regulator-suspend-microvolt", &pval))
+			suspend_state->uV = pval;
+
+		if (i == PM_SUSPEND_MEM)
+			constraints->initial_state = PM_SUSPEND_MEM;
+
+		fwnode_handle_put(suspend_fwnode);
+		suspend_state = NULL;
+		suspend_fwnode = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(device_get_regulation_constraints);
-- 
2.11.0.483.g087da7b7c-goog

