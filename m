From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC 2/9] opp-modifier: Add opp-modifier-reg driver
Date: Fri, 14 Mar 2014 14:25:28 -0500
Message-ID: <1394825135-60110-3-git-send-email-d-gerlach@ti.com>
References: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1394825135-60110-1-git-send-email-d-gerlach@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
Cc: cpufreq@vger.kernel.org, devicetree@vger.kernel.org, kernel@pengutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jisheng Zhang <jszhang@marvell.com>, Anson Huang <Anson.Huang@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Driver to read from a register and depending on either set bits or
a specific known selectively enable or disable OPPs based on DT node.

Can support opp-modifier-reg-bit where single bits within the register
determine the availability of an OPP or opp-modifier-reg-val where a
certain value inside the register or a portion of it determine what the
maximum allowed OPP is.

The driver expects a device that has already has its OPPs loaded
and then will disable the OPPs not matching the criteria specified in
the opp-modifier table.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 .../devicetree/bindings/power/opp-modifier.txt     | 111 +++++++++
 drivers/power/opp/Makefile                         |   1 +
 drivers/power/opp/opp-modifier-reg.c               | 259 +++++++++++++++++++++
 3 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/opp-modifier.txt
 create mode 100644 drivers/power/opp/opp-modifier-reg.c

diff --git a/Documentation/devicetree/bindings/power/opp-modifier.txt b/Documentation/devicetree/bindings/power/opp-modifier.txt
new file mode 100644
index 0000000..af8a2e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/opp-modifier.txt
@@ -0,0 +1,111 @@
+* OPP-Modifier - opp modifier to selectively enable operating points
+
+Many SoCs that have selectively modifiable OPPs can specify
+all available OPPs in their operating-points listing and then define
+opp_modifiers to enable or disable the OPPs that are actually available
+on the specific hardware.
+
+* OPP Modifier Provider
+
+For single bits that define the availability of an OPP:
+-------------------------------------------
+Some SoCs define a bit in a register that indicates whether an OPP is
+available. This will disable any OPP with a frequency corresponding to
+the bit given if it is not set appropriately.
+
+properties:
+- compatible : Should be "opp-modifier-reg-bit"
+- reg : Address and length of the registers needed to identify available
+	OPPs, here we provide just the register containing OPP data.
+
+Optional Properties:
+- opp,reg-bit-enable-low: Take the complement of register before comparing mask
+		     defined below under opp-modifier.
+
+Sub-nodes:
+Sub-nodes are defined as a container to hold opp modifier table for a
+specific device with an operating-points table already defined
+
+Sub-node properties:
+- opp-modifier: A collection of rows consisting of the following entries to
+		allow specification of available OPPs:
+	-kHz: The opp to be enabled based on following criteria
+	-offset: Offset into register where relevant bits are located
+	-value: Bit that indicates availability of OPP
+
+Example:
+
+	opp_modifier: opp_modifier@0x44e107fc {
+		compatible = "opp-modifier-reg-bit";
+		reg = <0x44e107fc 0x04>;
+
+		mpu_opp_modifier: mpu_opp_modifier {
+			opp-modifier = <
+			/* kHz   offset  value */
+			1000000  0	BIT_1
+			720000   0	BIT_2
+			>;
+		};
+	};
+
+For a value that defines the maximum available OPP:
+-------------------------------------------
+Some SoCs define a value in a register that corresponds to an OPP. If
+that value is matched this will disable all OPPs greater than the
+associated frequency.
+
+properties:
+- compatible : Should be "opp-modifier-reg-val"
+- reg : Address and length of the registers needed to identify available
+	OPPs, here we provide just the register containing OPP data.
+
+Optional Properties:
+- opp,reg-mask: Only compare the bits masked off by this value.
+
+Sub-nodes:
+Sub-nodes are defined as a container to hold opp modifier table for a
+specific device with an operating-points table already defined
+
+Sub-node properties:
+- opp-modifier: A collection of rows consisting of the following entries to
+		allow specification of available OPPs:
+	-kHz: The opp to be enabled based on following criteria
+	-offset: Offset into register where relevant bits are located
+	-value: Value that indicates maximum available OPP
+
+Example:
+
+	opp_modifier: opp_modifier@0x44e107fc {
+		compatible = "opp-modifier-reg-val";
+		reg = <0x44e107fc 0x04>;
+
+		mpu_opp_modifier: mpu_opp_modifier {
+			opp-modifier = <
+			/* kHz   offset  value */
+			1000000  0	VAL_1
+			720000   0	VAL_2
+			>;
+		};
+	};
+
+* OPP Modifier Consumer
+
+Properties:
+- platform-opp-modifier: phandle to the sub-node of the proper opp-modifier
+		provider that contains the appropriate opp-modifier table
+
+Example:
+
+cpu@0 {
+        compatible = "arm,cortex-a8";
+        device_type = "cpu";
+
+        operating-points = <
+                /* kHz    uV */
+                1000000 1351000
+                720000  1285000
+        >;
+
+        platform-opp-modifier = <&mpu_opp_modifier>;
+};
+
diff --git a/drivers/power/opp/Makefile b/drivers/power/opp/Makefile
index 820eb10..7f60adc 100644
--- a/drivers/power/opp/Makefile
+++ b/drivers/power/opp/Makefile
@@ -1 +1,2 @@
 obj-y += core.o
+obj-y += opp-modifier-reg.o
diff --git a/drivers/power/opp/opp-modifier-reg.c b/drivers/power/opp/opp-modifier-reg.c
new file mode 100644
index 0000000..f4dcf7a
--- /dev/null
+++ b/drivers/power/opp/opp-modifier-reg.c
@@ -0,0 +1,259 @@
+/*
+ * Single bit OPP Modifier Driver
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ * Dave Gerlach <d-gerlach@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/list.h>
+
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pm_opp.h>
+#include <linux/opp-modifier.h>
+
+static struct of_device_id opp_omap_of_match[];
+
+struct opp_reg_context {
+	struct device   *dev;
+	void __iomem    *reg;
+	u32	mask;
+	bool		enable_low;
+	int (*modify)(struct device *dev, const struct property *prop);
+};
+
+static struct opp_reg_context *opp_reg;
+
+static unsigned long opp_reg_read(int offset)
+{
+	return readl(opp_reg->reg + offset);
+}
+
+static int opp_modifier_reg_bit_enable(struct device *dev,
+				       const struct property *prop)
+{
+	const __be32 *val;
+	unsigned long reg_val, freq, offset, bit;
+	int idx;
+
+	val = prop->value;
+	idx = (prop->length / sizeof(u32)) / 3;
+	while (idx--) {
+		freq = be32_to_cpup(val++) * 1000;
+		offset = be32_to_cpup(val++);
+		bit = be32_to_cpup(val++);
+
+		reg_val = opp_reg_read(offset);
+
+		if (opp_reg->enable_low)
+			reg_val = ~reg_val;
+
+		if (!(reg_val & bit))
+			dev_pm_opp_disable(dev, freq);
+	}
+	return 0;
+}
+
+static int opp_modifier_reg_value_enable(struct device *dev,
+					 const struct property *prop)
+{
+	const __be32 *val;
+	unsigned long reg_val, freq, offset, bits;
+	unsigned long disable_freq, search_freq;
+	struct dev_pm_opp *disable_opp;
+	int idx, i, opp_count;
+
+	val = prop->value;
+	idx = (prop->length / sizeof(u32)) / 3;
+
+	while (idx--) {
+		freq = be32_to_cpup(val++) * 1000;
+		offset = be32_to_cpup(val++);
+		bits = be32_to_cpup(val++);
+
+		reg_val = opp_reg_read(offset);
+
+		if ((reg_val & opp_reg->mask) == bits) {
+			/*
+			 * Find all frequencies greater than current freq
+			 */
+			search_freq = freq + 1;
+			rcu_read_lock();
+			opp_count = dev_pm_opp_get_opp_count(dev);
+			rcu_read_unlock();
+
+			for (i = 0; i < opp_count; i++) {
+				rcu_read_lock();
+				disable_opp =
+					dev_pm_opp_find_freq_ceil(dev,
+								  &search_freq);
+				if (IS_ERR(disable_opp)) {
+					rcu_read_unlock();
+					break;
+				}
+				disable_freq =
+					dev_pm_opp_get_freq(disable_opp);
+				rcu_read_unlock();
+				dev_pm_opp_disable(dev, disable_freq);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int of_opp_check_availability(struct device *dev, struct device_node *np)
+{
+	const struct property *prop;
+	int nr;
+
+	if (!dev || !np)
+		return -EINVAL;
+
+	prop = of_find_property(np, "opp-modifier", NULL);
+	if (!prop)
+		return -EINVAL;
+	if (!prop->value)
+		return -EINVAL;
+
+	nr = prop->length / sizeof(u32);
+	if (nr % 3) {
+		pr_err("%s: Invalid OPP Available list\n", __func__);
+		return -EINVAL;
+	}
+
+	return opp_reg->modify(dev, prop);
+}
+
+static int opp_modifier_reg_device_modify(struct device *dev)
+{
+	struct device_node *np;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	np = of_parse_phandle(dev->of_node, "platform-opp-modifier", 0);
+
+	if (!np)
+		return -EINVAL;
+
+	ret = of_opp_check_availability(dev, np);
+
+	if (ret)
+		pr_err("Error modifying available OPPs\n");
+
+	of_node_put(np);
+
+	return ret;
+}
+
+static struct opp_modifier_ops opp_modifier_reg_ops = {
+	.modify = opp_modifier_reg_device_modify,
+};
+
+static struct opp_modifier_dev opp_modifier_reg_dev = {
+	.ops = &opp_modifier_reg_ops,
+};
+
+static struct of_device_id opp_modifier_reg_of_match[] = {
+	{
+		.compatible = "opp-modifier-reg-bit",
+		.data = &opp_modifier_reg_bit_enable,
+	},
+	{
+		.compatible = "opp-modifier-reg-val",
+		.data = &opp_modifier_reg_value_enable,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, opp_modifier_reg_of_match);
+
+static int opp_modifier_reg_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct resource *res;
+	struct device_node *np = pdev->dev.of_node;
+	int ret = 0;
+
+	opp_reg = devm_kzalloc(&pdev->dev, sizeof(*opp_reg), GFP_KERNEL);
+	if (!opp_reg) {
+		dev_err(opp_reg->dev, "reg context memory allocation failed\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	match = of_match_device(opp_modifier_reg_of_match, &pdev->dev);
+
+	if (!match) {
+		dev_err(&pdev->dev, "Invalid match data value\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	opp_reg->modify = (void *)match->data;
+
+	opp_reg->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "no memory resource for opp register\n");
+		ret = -ENXIO;
+		goto err;
+	}
+
+	opp_reg->reg = devm_request_and_ioremap(opp_reg->dev, res);
+	if (!opp_reg->reg) {
+		dev_err(opp_reg->dev, "could not ioremap opp register\n");
+		ret = -EADDRNOTAVAIL;
+		goto err;
+	}
+
+	if (of_get_property(np, "opp,reg-bit-enable-low", NULL))
+		opp_reg->enable_low = true;
+
+	of_property_read_u32(np, "opp,reg-mask", &opp_reg->mask);
+
+	opp_modifier_reg_dev.ops = &opp_modifier_reg_ops;
+	opp_modifier_reg_dev.of_node = pdev->dev.of_node;
+
+	opp_modifier_register(&opp_modifier_reg_dev);
+
+err:
+	return ret;
+}
+
+static int opp_modifier_reg_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver opp_modifier_reg_driver = {
+	.probe		= opp_modifier_reg_probe,
+	.remove		= opp_modifier_reg_remove,
+	.driver = {
+		.owner		= THIS_MODULE,
+		.name		= "opp-modifier-reg",
+		.of_match_table	= opp_modifier_reg_of_match,
+	},
+};
+
+module_platform_driver(opp_modifier_reg_driver);
+
+MODULE_AUTHOR("Dave Gerlach <d-gerlach@ti.com>");
+MODULE_DESCRIPTION("OPP Modifier driver for eFuse defined OPPs");
+MODULE_LICENSE("GPL v2");
-- 
1.9.0

