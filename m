From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC PATCH 03/11] DT: regulator: Helper routine to extract regulator_init_data
Date: Thu, 15 Sep 2011 16:51:59 +0530
Message-ID: <1316085727-15023-4-git-send-email-rnayak@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
 <1316085727-15023-2-git-send-email-rnayak@ti.com>
 <1316085727-15023-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59770 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933359Ab1IOLWm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 07:22:42 -0400
In-Reply-To: <1316085727-15023-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

The helper routine is meant to be used by regulator drivers
to extract the regulator_init_data structure passed from device tree.
'consumer_supplies' which is part of regulator_init_data is not extracted
as the regulator consumer mappings are passed through DT differently,
implemented in subsequent patches.

Also add documentation for regulator bindings to be used to pass
regulator_init_data struct information from device tree.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../devicetree/bindings/regulator/regulator.txt    |   37 +++++++++
 drivers/of/Kconfig                                 |    6 ++
 drivers/of/Makefile                                |    1 +
 drivers/of/of_regulator.c                          |   85 ++++++++++++++++++++
 include/linux/of_regulator.h                       |   23 +++++
 5 files changed, 152 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator.txt
 create mode 100644 drivers/of/of_regulator.c
 create mode 100644 include/linux/of_regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
new file mode 100644
index 0000000..001e5ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -0,0 +1,37 @@
+Voltage/Current Regulators
+
+Required properties:
+- compatible: Must be "regulator";
+
+Optional properties:
+- supply-regulator: Name of the parent regulator
+- min-uV: smallest voltage consumers may set
+- max-uV: largest voltage consumers may set
+- uV-offset: Offset applied to voltages from consumer to compensate for voltage drops
+- min-uA: smallest current consumers may set
+- max-uA: largest current consumers may set
+- mode-fast: boolean, Can handle fast changes in its load
+- mode-normal: boolean, Normal regulator power supply mode
+- mode-idle: boolean, Can be more efficient during light loads
+- mode-standby: boolean, Can be most efficient during light loads
+- change-voltage: boolean, Output voltage can be changed by software
+- change-current: boolean, Output current can be chnaged by software
+- change-mode: boolean, Operating mode can be changed by software
+- change-status: boolean, Enable/Disable control for regulator exists
+- change-drms: boolean, Dynamic regulator mode switching is enabled
+- input-uV: Input voltage for regulator when supplied by another regulator
+- initial-mode: Mode to set at startup
+- always-on: boolean, regulator should never be disabled
+- boot-on: bootloader/firmware enabled regulator
+- apply-uV: apply uV constraint if min == max
+
+Example:
+
+	xyz-regulator: regulator@0 {
+		compatible = "regulator";
+		min-uV = <1000000>;
+		max-uV = <2500000>;
+		mode-fast;
+		change-voltage;
+		always-on;
+	};
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index b3bfea5..296b96d 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -87,4 +87,10 @@ config OF_PCI_IRQ
 	help
 	  OpenFirmware PCI IRQ routing helpers
 
+config OF_REGULATOR
+	def_bool y
+	depends on REGULATOR
+	help
+	  OpenFirmware regulator framework helpers
+
 endmenu # OF
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 74b959c..bea2852 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_OF_SPI)	+= of_spi.o
 obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
 obj-$(CONFIG_OF_PCI)	+= of_pci.o
 obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
+obj-$(CONFIG_OF_REGULATOR) += of_regulator.o
diff --git a/drivers/of/of_regulator.c b/drivers/of/of_regulator.c
new file mode 100644
index 0000000..f01d275
--- /dev/null
+++ b/drivers/of/of_regulator.c
@@ -0,0 +1,85 @@
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
+	of_property_read_u32(np, "min-uV", &(*init_data)->constraints.min_uV);
+	of_property_read_u32(np, "max-uV", &(*init_data)->constraints.max_uV);
+	of_property_read_u32(np, "uV-offset", &(*init_data)->constraints.uV_offset);
+	of_property_read_u32(np, "min-uA", &(*init_data)->constraints.min_uA);
+	of_property_read_u32(np, "max-uA", &(*init_data)->constraints.max_uA);
+
+	/* valid modes mask */
+	if (of_find_property(np, "mode-fast", NULL))
+		valid_modes_mask |= REGULATOR_MODE_FAST;
+	if (of_find_property(np, "mode-normal", NULL))
+		valid_modes_mask |= REGULATOR_MODE_NORMAL;
+	if (of_find_property(np, "mode-idle", NULL))
+		valid_modes_mask |= REGULATOR_MODE_IDLE;
+	if (of_find_property(np, "mode-standby", NULL))
+		valid_modes_mask |= REGULATOR_MODE_STANDBY;
+
+	/* valid ops mask */
+	if (of_find_property(np, "change-voltage", NULL))
+		valid_ops_mask |= REGULATOR_CHANGE_VOLTAGE;
+	if (of_find_property(np, "change-current", NULL))
+		valid_ops_mask |= REGULATOR_CHANGE_CURRENT;
+	if (of_find_property(np, "change-mode", NULL))
+		valid_ops_mask |= REGULATOR_CHANGE_MODE;
+	if (of_find_property(np, "change-status", NULL))
+		valid_ops_mask |= REGULATOR_CHANGE_STATUS;
+
+	(*init_data)->constraints.valid_modes_mask = valid_modes_mask;
+	(*init_data)->constraints.valid_ops_mask = valid_ops_mask;
+
+	of_property_read_u32(np, "input-uV",
+			&(*init_data)->constraints.input_uV);
+	of_property_read_u32(np, "initial-mode",
+			&(*init_data)->constraints.initial_mode);
+
+	if (of_find_property(np, "always-on", NULL))
+			(*init_data)->constraints.always_on = true;
+	if (of_find_property(np, "boot-on", NULL))
+			(*init_data)->constraints.boot_on = true;
+	if (of_find_property(np, "apply-uV", NULL))
+			(*init_data)->constraints.apply_uV = true;
+}
+
+/**
+ * of_get_regulator_init_data - extarct regulator_init_data structure info
+ * @np: Pointer to regulator device tree node
+ *
+ * Populates regulator_init_data structure by extracting data from device
+ * tree node, returns a pointer to the populated struture or NULL if memory
+ * alloc fails.
+ */
+struct regulator_init_data *of_get_regulator_init_data(struct device_node *np)
+{
+	struct regulator_init_data *init_data;
+
+	init_data = kzalloc(sizeof(struct regulator_init_data), GFP_KERNEL);
+	if (!init_data)
+		return NULL; /* Out of memory? */
+
+	init_data->supply_regulator = (char *)of_get_property(np,
+						"supply-regulator", NULL);
+	of_get_regulation_constraints(np, &init_data);
+	return init_data;
+}
+EXPORT_SYMBOL(of_get_regulator_init_data);
diff --git a/include/linux/of_regulator.h b/include/linux/of_regulator.h
new file mode 100644
index 0000000..5eb048c
--- /dev/null
+++ b/include/linux/of_regulator.h
@@ -0,0 +1,23 @@
+/*
+ * OpenFirmware regulator support routines
+ *
+ */
+
+#ifndef __LINUX_OF_REG_H
+#define __LINUX_OF_REG_H
+
+#include <linux/regulator/machine.h>
+
+#if defined(CONFIG_OF_REGULATOR)
+extern struct regulator_init_data
+	*of_get_regulator_init_data(struct device_node *np);
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

