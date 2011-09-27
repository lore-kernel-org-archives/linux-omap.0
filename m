From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/9] regulator: helper routine to extract regulator_init_data
Date: Tue, 27 Sep 2011 15:42:45 +0530
Message-ID: <1317118372-17052-3-git-send-email-rnayak@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34764 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348Ab1I0KNp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 06:13:45 -0400
In-Reply-To: <1317118372-17052-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, Rajendra Nayak <rnayak@ti.com>

The helper routine is meant to be used by regulator drivers
to extract the regulator_init_data structure from the data
that is passed from device tree.
'consumer_supplies' which is part of regulator_init_data is not extracted
as the regulator consumer mappings are passed through DT differently,
implemented in subsequent patches.

Also add documentation for regulator bindings to be used to pass
regulator_init_data struct information from device tree.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../devicetree/bindings/regulator/regulator.txt    |   42 +++++++++
 drivers/regulator/Kconfig                          |    7 ++
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/of_regulator.c                   |   88 ++++++++++++++++++++
 include/linux/regulator/machine.h                  |   12 ++--
 include/linux/regulator/of_regulator.h             |   21 +++++
 6 files changed, 165 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator.txt
 create mode 100644 drivers/regulator/of_regulator.c
 create mode 100644 include/linux/regulator/of_regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
new file mode 100644
index 0000000..91b8d8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -0,0 +1,42 @@
+Voltage/Current Regulators
+
+Optional properties:
+- regulator-supplies: Names of the regulator supplies
+- regulator-min-uV: smallest voltage consumers may set
+- regulator-max-uV: largest voltage consumers may set
+- regulator-uV-offset: Offset applied to voltages to compensate for voltage drops
+- regulator-min-uA: smallest current consumers may set
+- regulator-max-uA: largest current consumers may set
+- regulator-change-voltage: boolean, Output voltage can be changed by software
+- regulator-change-current: boolean, Output current can be chnaged by software
+- regulator-change-mode: boolean, Operating mode can be changed by software
+- regulator-change-status: boolean, Enable/Disable control for regulator exists
+- regulator-change-drms: boolean, Dynamic regulator mode switching is enabled
+- regulator-mode-fast: boolean, allow/set fast mode for the regulator
+- regulator-mode-normal: boolean, allow/set normal mode for the regulator
+- regulator-mode-idle: boolean, allow/set idle mode for the regulator
+- regulator-mode-standby: boolean, allow/set standby mode for the regulator
+- regulator-input-uV: Input voltage for regulator when supplied by another regulator
+- regulator-always-on: boolean, regulator should never be disabled
+- regulator-boot-on: bootloader/firmware enabled regulator
+
+Example:
+
+	xyzreg: regulator@0 {
+		regulator-min-uV = <1000000>;
+		regulator-max-uV = <2500000>;
+		regulator-mode-fast;
+		regulator-change-voltage;
+		regulator-always-on;
+	};
+
+Example of a device node referencing a regulator node:
+
+	devicenode: node@0x0 {
+		...
+		...
+		<name>-supply = <&xyzreg>;
+	};
+
+	where <name> is the supply name or regulator id passed
+	as part of regulator_get(dev, <name>);
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index c7fd2c0..2b684aa 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -64,6 +64,13 @@ config REGULATOR_USERSPACE_CONSUMER
 
           If unsure, say no.
 
+config OF_REGULATOR
+	tristate "OF regulator helpers"
+	depends on OF
+	help
+	  OpenFirmware regulator framework helper routines that can
+	  used by regulator drivers to extract data from device tree.
+
 config REGULATOR_BQ24022
 	tristate "TI bq24022 Dual Input 1-Cell Li-Ion Charger IC"
 	help
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 040d5aa..e6bc009 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_REGULATOR) += core.o dummy.o
 obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) += fixed.o
 obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o
 obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
+obj-$(CONFIG_OF_REGULATOR) += of_regulator.o
 
 obj-$(CONFIG_REGULATOR_AD5398) += ad5398.o
 obj-$(CONFIG_REGULATOR_BQ24022) += bq24022.o
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
new file mode 100644
index 0000000..7fa63ff
--- /dev/null
+++ b/drivers/regulator/of_regulator.c
@@ -0,0 +1,88 @@
+/*
+ * OF helpers for regulator framework
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Rajendra Nayak <rnayak@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/regulator/machine.h>
+
+static void of_get_regulation_constraints(struct device_node *np,
+					struct regulator_init_data **init_data)
+{
+	unsigned int valid_modes_mask = 0, valid_ops_mask = 0;
+
+	of_property_read_u32(np, "regulator-min-uV",
+				&(*init_data)->constraints.min_uV);
+	of_property_read_u32(np, "regulator-max-uV",
+				&(*init_data)->constraints.max_uV);
+	of_property_read_u32(np, "regulator-uV-offset",
+				&(*init_data)->constraints.uV_offset);
+	of_property_read_u32(np, "regulator-min-uA",
+				&(*init_data)->constraints.min_uA);
+	of_property_read_u32(np, "regulator-max-uA",
+				&(*init_data)->constraints.max_uA);
+	of_property_read_u32(np, "regulator-input-uV",
+				&(*init_data)->constraints.input_uV);
+
+	/* valid modes mask */
+	if (of_find_property(np, "regulator-mode-fast", NULL))
+				valid_modes_mask |= REGULATOR_MODE_FAST;
+	if (of_find_property(np, "regulator-mode-normal", NULL))
+				valid_modes_mask |= REGULATOR_MODE_NORMAL;
+	if (of_find_property(np, "regulator-mode-idle", NULL))
+				valid_modes_mask |= REGULATOR_MODE_IDLE;
+	if (of_find_property(np, "regulator-mode-standby", NULL))
+				valid_modes_mask |= REGULATOR_MODE_STANDBY;
+
+	/* valid ops mask */
+	if (of_find_property(np, "regulator-change-voltage", NULL))
+				valid_ops_mask |= REGULATOR_CHANGE_VOLTAGE;
+	if (of_find_property(np, "regulator-change-current", NULL))
+				valid_ops_mask |= REGULATOR_CHANGE_CURRENT;
+	if (of_find_property(np, "regulator-change-mode", NULL))
+				valid_ops_mask |= REGULATOR_CHANGE_MODE;
+	if (of_find_property(np, "regulator-change-status", NULL))
+				valid_ops_mask |= REGULATOR_CHANGE_STATUS;
+
+	(*init_data)->constraints.valid_modes_mask = valid_modes_mask;
+	(*init_data)->constraints.valid_ops_mask = valid_ops_mask;
+
+	if (of_find_property(np, "regulator-always-on", NULL))
+				(*init_data)->constraints.always_on = true;
+	if (of_find_property(np, "regulator-boot-on", NULL))
+				(*init_data)->constraints.boot_on = true;
+}
+
+/**
+ * of_get_regulator_init_data - extract regulator_init_data structure info
+ * @dev: device requesting for regulator_init_data
+ *
+ * Populates regulator_init_data structure by extracting data from device
+ * tree node, returns a pointer to the populated struture or NULL if memory
+ * alloc fails.
+ */
+struct regulator_init_data *of_get_regulator_init_data(struct device *dev)
+{
+	struct regulator_init_data *init_data;
+
+	if (!dev->of_node)
+		return NULL;
+
+	init_data = devm_kzalloc(dev, sizeof(struct regulator_init_data),
+						 GFP_KERNEL);
+	if (!init_data)
+		return NULL; /* Out of memory? */
+
+	init_data->supply_regulator = (char *)of_get_property(dev->of_node,
+						"regulator-supplies", NULL);
+	of_get_regulation_constraints(dev->of_node, &init_data);
+	return init_data;
+}
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index ce3127a..d2d921b 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -98,14 +98,14 @@ struct regulation_constraints {
 	char *name;
 
 	/* voltage output range (inclusive) - for voltage control */
-	int min_uV;
-	int max_uV;
+	u32 min_uV;
+	u32 max_uV;
 
-	int uV_offset;
+	u32 uV_offset;
 
 	/* current output range (inclusive) - for current control */
-	int min_uA;
-	int max_uA;
+	u32 min_uA;
+	u32 max_uA;
 
 	/* valid regulator operating modes for this machine */
 	unsigned int valid_modes_mask;
@@ -114,7 +114,7 @@ struct regulation_constraints {
 	unsigned int valid_ops_mask;
 
 	/* regulator input voltage - only if supply is another regulator */
-	int input_uV;
+	u32 input_uV;
 
 	/* regulator suspend states for global PMIC STANDBY/HIBERNATE */
 	struct regulator_state state_disk;
diff --git a/include/linux/regulator/of_regulator.h b/include/linux/regulator/of_regulator.h
new file mode 100644
index 0000000..3f63be9
--- /dev/null
+++ b/include/linux/regulator/of_regulator.h
@@ -0,0 +1,21 @@
+/*
+ * OpenFirmware regulator support routines
+ *
+ */
+
+#ifndef __LINUX_OF_REG_H
+#define __LINUX_OF_REG_H
+
+#if defined(CONFIG_OF_REGULATOR)
+extern struct regulator_init_data
+	*of_get_regulator_init_data(struct device *dev);
+#else
+static inline struct regulator_init_data
+	*of_get_regulator_init_data(struct device_node *np)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF_REGULATOR */
+
+#endif /* __LINUX_OF_REG_H */
+
-- 
1.7.1

