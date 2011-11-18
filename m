From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 1/4] regulator: helper routine to extract
	regulator_init_data
Date: Fri, 18 Nov 2011 16:47:17 +0530
Message-ID: <1321615040-13257-2-git-send-email-rnayak@ti.com>
References: <1321615040-13257-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1321615040-13257-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The helper routine is meant to be used by the regulator drivers
to extract the regulator_init_data structure from the data
that is passed from device tree.
'consumer_supplies' which is part of regulator_init_data is not extracted
as the regulator consumer mappings are passed through DT differently,
implemented in subsequent patches.
Similarly the regulator<-->parent/supply mapping is handled in
subsequent patches.

Also add documentation for regulator bindings to be used to pass
regulator_init_data struct information from device tree.

Some of the regulator properties which are linux and board specific,
are left out since its not clear if they can
be in someway embedded into the kernel or passed in from DT.
They will be revisited later.

Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/regulator/regulator.txt    |   54 +++++++++++++
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/of_regulator.c                   |   81 ++++++++++++++++++++
 include/linux/regulator/of_regulator.h             |   20 +++++
 4 files changed, 156 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator.txt
 create mode 100644 drivers/regulator/of_regulator.c
 create mode 100644 include/linux/regulator/of_regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
new file mode 100644
index 0000000..82bef20
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -0,0 +1,54 @@
+Voltage/Current Regulators
+
+Optional properties:
+- regulator-name: A string used as a descriptive name for regulator outputs
+- regulator-min-microvolt: smallest voltage consumers may set
+- regulator-max-microvolt: largest voltage consumers may set
+- regulator-microvolt-offset: Offset applied to voltages to compensate for voltage drops
+- regulator-min-microamp: smallest current consumers may set
+- regulator-max-microamp: largest current consumers may set
+- regulator-always-on: boolean, regulator should never be disabled
+- regulator-boot-on: bootloader/firmware enabled regulator
+- <name>-supply: phandle to the parent supply/regulator node
+
+Example:
+
+	xyzreg: regulator@0 {
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+		vin-supply = <&vin>;
+	};
+
+Regulator Consumers:
+Consumer nodes can reference one or more of its supplies/
+regulators using the below bindings.
+
+- <name>-supply: phandle to the regulator node
+
+These are the same bindings that a regulator in the above
+example used to reference its own supply, in which case
+its just seen as a special case of a regulator being a
+consumer itself.
+
+Example of a consumer device node (mmc) referencing two
+regulators (twl-reg1 and twl-reg2),
+
+	twl-reg1: regulator@0 {
+		...
+		...
+		...
+	};
+
+	twl-reg2: regulator@1 {
+		...
+		...
+		...
+	};
+
+	mmc: mmc@0x0 {
+		...
+		...
+		vmmc-supply = <&twl-reg1>;
+		vmmcaux-supply = <&twl-reg2>;
+	};
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 93a6318..c75a522 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -4,6 +4,7 @@
 
 
 obj-$(CONFIG_REGULATOR) += core.o dummy.o
+obj-$(CONFIG_OF) += of_regulator.o
 obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) += fixed.o
 obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o
 obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
new file mode 100644
index 0000000..76673c7
--- /dev/null
+++ b/drivers/regulator/of_regulator.c
@@ -0,0 +1,81 @@
+/*
+ * OF helpers for regulator framework
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
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
+	const __be32 *min_uV, *max_uV, *uV_offset;
+	const __be32 *min_uA, *max_uA;
+	struct regulation_constraints *constraints = &(*init_data)->constraints;
+
+	constraints->name = of_get_property(np, "regulator-name", NULL);
+
+	min_uV = of_get_property(np, "regulator-min-microvolt", NULL);
+	if (min_uV)
+		constraints->min_uV = be32_to_cpu(*min_uV);
+	max_uV = of_get_property(np, "regulator-max-microvolt", NULL);
+	if (max_uV)
+		constraints->max_uV = be32_to_cpu(*max_uV);
+
+	/* Voltage change possible? */
+	if (constraints->min_uV != constraints->max_uV)
+		constraints->valid_ops_mask |= REGULATOR_CHANGE_VOLTAGE;
+
+	uV_offset = of_get_property(np, "regulator-microvolt-offset", NULL);
+	if (uV_offset)
+		constraints->uV_offset = be32_to_cpu(*uV_offset);
+	min_uA = of_get_property(np, "regulator-min-microamp", NULL);
+	if (min_uA)
+		constraints->min_uA = be32_to_cpu(*min_uA);
+	max_uA = of_get_property(np, "regulator-max-microamp", NULL);
+	if (max_uA)
+		constraints->max_uA = be32_to_cpu(*max_uA);
+
+	/* Current change possible? */
+	if (constraints->min_uA != constraints->max_uA)
+		constraints->valid_ops_mask |= REGULATOR_CHANGE_CURRENT;
+
+	if (of_find_property(np, "regulator-boot-on", NULL))
+		constraints->boot_on = true;
+
+	if (of_find_property(np, "regulator-always-on", NULL))
+		constraints->always_on = true;
+	else /* status change should be possible if not always on. */
+		constraints->valid_ops_mask |= REGULATOR_CHANGE_STATUS;
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
+	init_data = devm_kzalloc(dev, sizeof(*init_data), GFP_KERNEL);
+	if (!init_data)
+		return NULL; /* Out of memory? */
+
+	of_get_regulation_constraints(dev->of_node, &init_data);
+	return init_data;
+}
diff --git a/include/linux/regulator/of_regulator.h b/include/linux/regulator/of_regulator.h
new file mode 100644
index 0000000..d83a98d
--- /dev/null
+++ b/include/linux/regulator/of_regulator.h
@@ -0,0 +1,20 @@
+/*
+ * OpenFirmware regulator support routines
+ *
+ */
+
+#ifndef __LINUX_OF_REG_H
+#define __LINUX_OF_REG_H
+
+#if defined(CONFIG_OF)
+extern struct regulator_init_data
+	*of_get_regulator_init_data(struct device *dev);
+#else
+static inline struct regulator_init_data
+	*of_get_regulator_init_data(struct device *dev)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
+#endif /* __LINUX_OF_REG_H */
-- 
1.7.1
