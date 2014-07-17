From: Dan Murphy <dmurphy@ti.com>
Subject: [v3 PATCH 1/6] drivers: reset: TI: SoC reset controller support.
Date: Thu, 17 Jul 2014 11:45:26 -0500
Message-ID: <1405615531-15649-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34622 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757463AbaGQQqA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2014 12:46:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, Dan Murphy <dmurphy@ti.com>

The TI SoC reset controller support utilizes the
reset controller framework to give device drivers or
function drivers a common set of APIs to call to reset
a module.

The reset-ti is a common interface to the reset framework.
 The register data is retrieved during initialization
 of the reset driver through the reset-ti-data
file.  The array of data is associated with the compatible from the
respective DT entry.

Once the data is available then this is derefenced within the common
interface.

The device driver has the ability to assert, deassert or perform a
complete reset.

This code was derived from previous work by Rajendra Nayak and Afzal Mohammed.
The code was changed to adopt to the reset core and abstract away the SoC information.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v3 - Resolved comments from v2.  To many to call out here - https://patchwork.kernel.org/patch/4116941/

 drivers/reset/Kconfig    |    9 ++
 drivers/reset/Makefile   |    1 +
 drivers/reset/reset-ti.c |  373 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 383 insertions(+)
 create mode 100644 drivers/reset/reset-ti.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 0615f50..31a5a79 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -12,4 +12,13 @@ menuconfig RESET_CONTROLLER
 
 	  If unsure, say no.
 
+config RESET_TI
+	depends on RESET_CONTROLLER && ARCH_OMAP || COMPILE_TEST
+	bool "TI reset controller"
+	help
+	  Reset controller support for TI SoC's
+
+	  Reset controller found in TI's AM series of SoC's like
+	  AM335x and AM43x and OMAP SoC's like OMAP5 and DRA7
+
 source "drivers/reset/sti/Kconfig"
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 60fed3d..a5986b9 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_RESET_CONTROLLER) += core.o
 obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
+obj-$(CONFIG_RESET_TI) += reset-ti.o
 obj-$(CONFIG_ARCH_STI) += sti/
diff --git a/drivers/reset/reset-ti.c b/drivers/reset/reset-ti.c
new file mode 100644
index 0000000..e9d4039
--- /dev/null
+++ b/drivers/reset/reset-ti.c
@@ -0,0 +1,373 @@
+/*
+ * reset-ti.c - PRCM reset driver for TI SoC's
+ *
+ * Copyright (C) 2014 Texas Instruments Incorporated -  http://www.ti.com
+ *
+ * Author: Dan Murphy <dmurphy@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define DRIVER_NAME "prcm_reset_ti"
+#define MAX_RESET_SIGNALS 255
+
+/**
+ * struct ti_reset_reg_data - Structure of the reset register information
+ *		for a particular SoC.
+ * @rstctrl_offs: This is the reset control offset value from
+ *		from the parent reset node.
+ * @rstst_offs: This is the reset status offset value from
+ *		from the parent reset node.
+ * @rstctrl_bit: This is the reset control bit for the module.
+ * @rstst_bit: This is the reset status bit for the module.
+ *
+ * Longer description of this structure.
+ */
+struct ti_reset_reg_data {
+	phandle handle;
+	u32	rstctrl_offs;
+	u32	rstst_offs;
+	u32	rstctrl_bit;
+	u32	rstst_bit;
+};
+
+/**
+ * struct ti_reset_data - Structure that contains the reset register data
+ *	as well as the total number of resets for a particular SoC.
+ * @ti_data:	Pointer to this structure to be dereferenced
+ * @reg_data:	Pointer to the register data structure.
+ * @rcdev:		Reset controller device instance
+ * @dev:		Pointer to the devive structure
+ * @ti_reg_data: Array of register data.  Only reset signal with valid
+ *				phandles will be stored in this array.
+ * @reg_base:	Parent register base address
+ * @lock:		Spinlock for accessing the registers
+ * @nr_resets:	Total number of resets for the SoC in the reset array.
+ *
+ * This structure contains a pointer to the register data and the modules
+ * register base.  The number of resets and reset controller device data is
+ * stored within this structure.
+ *
+ */
+struct ti_reset_data {
+	struct ti_reset_data *ti_data;
+	struct ti_reset_reg_data *reg_data;
+	struct reset_controller_dev rcdev;
+	struct device *dev;
+	struct ti_reset_reg_data ti_reg_data[MAX_RESET_SIGNALS];
+	void __iomem *reg_base;
+	spinlock_t lock;
+	int nr_resets;
+};
+
+static int ti_reset_wait_on_reset(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct ti_reset_data *reset_data = container_of(rcdev,
+						     struct ti_reset_data,
+						     rcdev);
+	void __iomem *status_reg = reset_data->reg_base;
+	u32 bit_mask = 0;
+	u32 val = 0;
+	unsigned long flags;
+	int i = 1000;
+	int ret = 0;
+
+	spin_lock_irqsave(&reset_data->lock, flags);
+	/* Clear the reset status bit to reflect the current status */
+	status_reg = reset_data->reg_base + reset_data->ti_reg_data[id].rstst_offs;
+	bit_mask = reset_data->ti_reg_data[id].rstst_bit;
+
+	do {
+		val = readl(status_reg);
+	} while (--i && (val & (1 << bit_mask)));
+
+	if (i == 0 && val & (1 << bit_mask)) {
+		dev_err(reset_data->dev, "%s: Reset failed\n", __func__);
+		ret = -EIO;
+	}
+
+	spin_unlock_irqrestore(&reset_data->lock, flags);
+	return ret;
+}
+
+static int ti_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct ti_reset_data *reset_data = container_of(rcdev,
+						     struct ti_reset_data,
+						     rcdev);
+	void __iomem *reg;
+	void __iomem *status_reg;
+	u32 status_bit = 0;
+	u32 bit_mask = 0;
+	u32 val = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&reset_data->lock, flags);
+
+	/* Clear the reset status bit to reflect the current status */
+	status_reg = reset_data->reg_base + reset_data->ti_reg_data[id].rstst_offs;
+	status_bit = reset_data->ti_reg_data[id].rstst_bit;
+	writel(1 << status_bit, status_reg);
+
+	reg = reset_data->reg_base + reset_data->ti_reg_data[id].rstctrl_offs;
+	bit_mask = reset_data->ti_reg_data[id].rstctrl_bit;
+	val = readl(reg);
+	if (!(val & bit_mask)) {
+		val |= bit_mask;
+		writel(val, reg);
+	}
+
+	spin_unlock_irqrestore(&reset_data->lock, flags);
+	return 0;
+}
+
+static int ti_reset_deassert(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+
+	struct ti_reset_data *reset_data = container_of(rcdev,
+						     struct ti_reset_data,
+						     rcdev);
+	void __iomem *reg;
+	void __iomem *status_reg;
+	u32 status_bit = 0;
+	u32 bit_mask = 0;
+	u32 val = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&reset_data->lock, flags);
+
+	/* Clear the reset status bit to reflect the current status */
+	status_reg = reset_data->reg_base + reset_data->ti_reg_data[id].rstst_offs;
+	status_bit = reset_data->ti_reg_data[id].rstst_bit;
+	writel(1 << status_bit, status_reg);
+
+	reg = reset_data->reg_base + reset_data->ti_reg_data[id].rstctrl_offs;
+	bit_mask = reset_data->ti_reg_data[id].rstctrl_bit;
+	val = readl(reg);
+	if (val & bit_mask) {
+		val &= ~bit_mask;
+		writel(val, reg);
+	}
+
+	spin_unlock_irqrestore(&reset_data->lock, flags);
+
+	return 0;
+}
+
+static int ti_reset_reset(struct reset_controller_dev *rcdev,
+			  unsigned long id)
+{
+	ti_reset_assert(rcdev, id);
+	ti_reset_deassert(rcdev, id);
+
+	return ti_reset_wait_on_reset(rcdev, id);
+}
+
+static int ti_reset_xlate(struct reset_controller_dev *rcdev,
+			const struct of_phandle_args *reset_spec)
+{
+
+	struct ti_reset_data *reset_data = container_of(rcdev,
+						     struct ti_reset_data,
+						     rcdev);
+	struct device_node *dev_node;
+	int i;
+
+	if (WARN_ON(reset_spec->args_count != rcdev->of_reset_n_cells))
+		return -EINVAL;
+
+	/* Verify that the phandle exists */
+	dev_node = of_find_node_by_phandle((phandle) reset_spec->args[0]);
+	if (!dev_node) {
+		dev_err(reset_data->dev,
+				"%s: Cannot find phandle node\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	for (i = 0; i <= reset_data->nr_resets; i++) {
+		if (reset_data->ti_reg_data[i].handle == dev_node->phandle)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static struct reset_control_ops ti_reset_ops = {
+	.reset = ti_reset_reset,
+	.assert = ti_reset_assert,
+	.deassert = ti_reset_deassert,
+};
+
+static int ti_reset_populate_child(struct ti_reset_data *reset_data,
+					struct device_node *reset_child,
+					u32 ctrl_offs, u32 status_offs)
+{
+	struct device_node *next_reset_child = NULL;
+	int i = reset_data->nr_resets;
+	int ret;
+	u32 ctrl_bit;
+
+	while ((next_reset_child = of_get_next_child(reset_child, next_reset_child))) {
+		if (next_reset_child->phandle) {
+			/* Get the bits of each sub-reset */
+			ret = of_property_read_u32(next_reset_child, "control-bit",
+						&ctrl_bit);
+				if (ret < 0) {
+					dev_err(reset_data->dev,
+						"%s: No entry in %s for rstctrl_offs\n",
+						__func__, next_reset_child->name);
+
+				return -ENODEV;
+			}
+
+			ret = of_property_read_u32(next_reset_child, "status-bit",
+						&reset_data->ti_reg_data[i].rstst_bit);
+				if (ret < 0) {
+					dev_err(reset_data->dev,
+							"%s: No entry in %s for rstst_offs\n",
+							__func__, next_reset_child->name);
+
+				return -ENODEV;
+			}
+
+			reset_data->ti_reg_data[i].rstctrl_offs = ctrl_offs;
+			reset_data->ti_reg_data[i].rstst_offs = status_offs;
+			reset_data->ti_reg_data[i].handle = next_reset_child->phandle;
+			i++;
+		}
+	};
+
+	reset_data->nr_resets = i;
+
+	return 0;
+}
+
+static int ti_reset_get_of_data(struct ti_reset_data *reset_data,
+				struct device_node *dev_node)
+{
+	struct device_node *reset_child = NULL;
+	int ret = -EINVAL;
+	u32 ctrl_offs, status_offs;
+
+	/* Loop through all the children and populate a lookup array */
+	while ((reset_child = of_get_next_child(dev_node, reset_child))) {
+		ret = of_property_read_u32_index(reset_child, "reg", 0,
+						 &ctrl_offs);
+		if (ret)
+			return ret;
+
+		ret = of_property_read_u32_index(reset_child, "reg", 1,
+						 &status_offs);
+		if (ret)
+			return ret;
+
+		ret = ti_reset_populate_child(reset_data, reset_child,
+							ctrl_offs, status_offs);
+		if (ret)
+			return ret;
+	};
+
+	return 0;
+}
+
+static int ti_reset_probe(struct platform_device *pdev)
+{
+	struct device_node *resets;
+	struct ti_reset_data *reset_data;
+	struct resource *res;
+	int ret;
+
+	reset_data = devm_kzalloc(&pdev->dev, sizeof(*reset_data), GFP_KERNEL);
+	if (!reset_data)
+		return -ENOMEM;
+
+	resets = of_find_node_by_name(NULL, "resets");
+	if (!resets) {
+		dev_err(&pdev->dev, "%s: missing 'resets' child node.\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reset_data->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(reset_data->reg_base)) {
+		dev_err(&pdev->dev, "%s: Cannot map reset parent.\n", __func__);
+		return -ENODEV;
+	}
+
+	spin_lock_init(&reset_data->lock);
+	reset_data->dev = &pdev->dev;
+	ret = ti_reset_get_of_data(reset_data, resets);
+	if (ret)
+		return -EINVAL;
+
+	reset_data->rcdev.owner = THIS_MODULE;
+	reset_data->rcdev.of_node = resets;
+	reset_data->rcdev.ops = &ti_reset_ops;
+
+	reset_data->rcdev.of_reset_n_cells = 1;
+	reset_data->rcdev.of_xlate = &ti_reset_xlate;
+
+	reset_data->ti_data = reset_data;
+
+	platform_set_drvdata(pdev, reset_data);
+
+	reset_controller_register(&reset_data->rcdev);
+
+	return 0;
+}
+
+static int ti_reset_remove(struct platform_device *pdev)
+{
+	struct ti_reset_data *reset_data;
+
+	reset_data = platform_get_drvdata(pdev);
+	reset_controller_unregister(&reset_data->rcdev);
+
+	return 0;
+}
+
+static const struct of_device_id ti_reset_of_match[] = {
+	{ .compatible = "ti,omap5-prm" },
+	{ .compatible =	"ti,omap4-prm" },
+	{ .compatible =	"ti,omap5-prm" },
+	{ .compatible =	"ti,dra7-prm" },
+	{ .compatible = "ti,am4-prcm" },
+	{ .compatible =	"ti,am3-prcm" },
+	{},
+};
+
+static struct platform_driver ti_reset_driver = {
+	.probe	= ti_reset_probe,
+	.remove	= ti_reset_remove,
+	.driver	= {
+		.name		= DRIVER_NAME,
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(ti_reset_of_match),
+	},
+};
+module_platform_driver(ti_reset_driver);
+
+MODULE_DESCRIPTION("PRCM reset driver for TI SoCs");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.7.9.5

