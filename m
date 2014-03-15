From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 3/5] net: cpsw: Add control-module macid driver
Date: Sat, 15 Mar 2014 14:07:42 +0100
Message-ID: <1394888864-11007-4-git-send-email-mpa@pengutronix.de>
References: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44281 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbaCONJK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Mar 2014 09:09:10 -0400
In-Reply-To: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

This driver extracts the hardware macid from the control module of
am335x processors. It exports a function cpsw_ctrl_macid_read for cpsw
to get the macid from within the processor.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 .../devicetree/bindings/net/cpsw-ctrl-macid.txt    |  32 +++++
 drivers/net/ethernet/ti/Kconfig                    |   1 +
 drivers/net/ethernet/ti/Makefile                   |   2 +-
 drivers/net/ethernet/ti/cpsw-ctrl-macid.c          | 138 +++++++++++++++++++++
 4 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
 create mode 100644 drivers/net/ethernet/ti/cpsw-ctrl-macid.c

diff --git a/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt b/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
new file mode 100644
index 0000000..4eb39f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
@@ -0,0 +1,32 @@
+TI CPSW ctrl macid Devicetree bindings
+--------------------------------------
+
+Required properties:
+ - compatible		: Should be "ti,am3352-cpsw-ctrl-macid"
+ - reg			: physical base address and size of the cpsw
+			  registers map
+ - reg-names		: names of the register map given in "reg" node
+ - #ti,mac-address-ctrl-cells	: Should be <1>
+
+When used from cpsw, "ti,mac-address-ctrl" should be a phandle to this device
+node with one argument, 0 or 1 to select the first or second macid
+respectively.
+
+Examples:
+
+	cpsw_ctrl_macid: cpsw-ctrl-macid@44e10630 {
+		compatible = "ti,am3352-cpsw-ctrl-macid";
+		#ti,mac-address-ctrl-cells = <1>;
+		reg = <0x44e10630 0x16>;
+		reg-names = "ctrl-macid";
+	};
+
+Used in cpsw slave nodes like this:
+
+	cpsw_emac0: slave@4a100200 {
+		ti,mac-address-ctrl = <&cpsw_ctrl_macid 0>;
+	};
+
+	cpsw_emac1: slave@4a100300 {
+		ti,mac-address-ctrl = <&cpsw_ctrl_macid 1>;
+	};
diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 53150c2..a8796d6 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -62,6 +62,7 @@ config TI_CPSW
 	select TI_DAVINCI_CPDMA
 	select TI_DAVINCI_MDIO
 	select TI_CPSW_PHY_SEL
+	select TI_CPSW_CTRL_MACID
 	---help---
 	  This driver supports TI's CPSW Ethernet Switch.
 
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 9cfaab8..fb24937 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -8,5 +8,5 @@ obj-$(CONFIG_TI_DAVINCI_EMAC) += davinci_emac.o
 obj-$(CONFIG_TI_DAVINCI_MDIO) += davinci_mdio.o
 obj-$(CONFIG_TI_DAVINCI_CPDMA) += davinci_cpdma.o
 obj-$(CONFIG_TI_CPSW_PHY_SEL) += cpsw-phy-sel.o
-obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
+obj-$(CONFIG_TI_CPSW) += ti_cpsw.o cpsw-ctrl-macid.o
 ti_cpsw-y := cpsw_ale.o cpsw.o cpts.o
diff --git a/drivers/net/ethernet/ti/cpsw-ctrl-macid.c b/drivers/net/ethernet/ti/cpsw-ctrl-macid.c
new file mode 100644
index 0000000..3362bed
--- /dev/null
+++ b/drivers/net/ethernet/ti/cpsw-ctrl-macid.c
@@ -0,0 +1,138 @@
+/* CPSW Control Module MACID driver
+ *
+ * Copyright (C) 2014 Markus Pargmann <mpa@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include "cpsw.h"
+
+#define AM33XX_CTRL_MAC_LO_REG(id) (0x8 * id)
+#define AM33XX_CTRL_MAC_HI_REG(id) (0x8 * id + 0x4)
+
+struct cpsw_ctrl_macid {
+	struct device *dev;
+	u8 __iomem *ctrl_macid;
+	void (*cpsw_macid_provide)(struct cpsw_ctrl_macid *priv, int slave,
+			u8 *mac_addr);
+};
+
+static void cpsw_ctrl_get_macid(struct cpsw_ctrl_macid *priv, int slave,
+		u8 *mac_addr)
+{
+	u32 macid_lo;
+	u32 macid_hi;
+
+	macid_lo = readl(priv->ctrl_macid + AM33XX_CTRL_MAC_LO_REG(slave));
+	macid_hi = readl(priv->ctrl_macid + AM33XX_CTRL_MAC_HI_REG(slave));
+
+	mac_addr[5] = (macid_lo >> 8) & 0xff;
+	mac_addr[4] = macid_lo & 0xff;
+	mac_addr[3] = (macid_hi >> 24) & 0xff;
+	mac_addr[2] = (macid_hi >> 16) & 0xff;
+	mac_addr[1] = (macid_hi >> 8) & 0xff;
+	mac_addr[0] = macid_hi & 0xff;
+}
+
+static struct platform_driver cpsw_ctrl_macid_driver;
+
+static int cpsw_ctrl_macid_match(struct device *dev, void *data)
+{
+	struct device_node *node = (struct device_node *)data;
+
+	return dev->of_node == node &&
+		dev->driver == &cpsw_ctrl_macid_driver.driver;
+}
+
+int cpsw_ctrl_macid_read(struct device_node *np, u8 *mac_addr)
+{
+	struct device *ctrl_dev;
+	struct cpsw_ctrl_macid *priv;
+	struct of_phandle_args args;
+	int ret;
+
+	ret = of_parse_phandle_with_args(np, "ti,mac-address-ctrl",
+			"#ti,mac-address-ctrl-cells", 0, &args);
+	if (ret)
+		return ret;
+
+	if (args.args_count != 1 || args.args[0] < 0 || args.args[0] > 1) {
+		pr_err("Failed to parse ti,mac-address-module phandle because of invalid arguments\n");
+		return -EINVAL;
+	}
+
+	ctrl_dev = bus_find_device(&platform_bus_type, NULL, args.np,
+			cpsw_ctrl_macid_match);
+	priv = dev_get_drvdata(ctrl_dev);
+	of_node_put(args.np);
+	if (priv == NULL)
+		return -EPROBE_DEFER;
+
+	priv->cpsw_macid_provide(priv, args.args[0], mac_addr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpsw_ctrl_macid_read);
+
+static const struct of_device_id cpsw_ctrl_macid_of_ids[] = {
+	{
+		.compatible	= "ti,am3352-cpsw-ctrl-macid",
+		.data		= cpsw_ctrl_get_macid,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, cpsw_ctrl_macid_of_ids);
+
+static int cpsw_ctrl_macid_probe(struct platform_device *pdev)
+{
+	struct resource	*res;
+	const struct of_device_id *of_id;
+	struct cpsw_ctrl_macid *priv;
+
+	of_id = of_match_node(cpsw_ctrl_macid_of_ids, pdev->dev.of_node);
+	if (!of_id)
+		return -EINVAL;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(&pdev->dev, "unable to alloc memory for cpsw-ctrl-macid\n");
+		return -ENOMEM;
+	}
+
+	priv->cpsw_macid_provide = of_id->data;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl-macid");
+	priv->ctrl_macid = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->ctrl_macid))
+		return PTR_ERR(priv->ctrl_macid);
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	dev_info(&pdev->dev, "TI CPSW ctrl macid loaded\n");
+	return 0;
+}
+
+static struct platform_driver cpsw_ctrl_macid_driver = {
+	.probe		= cpsw_ctrl_macid_probe,
+	.driver		= {
+		.name	= "cpsw-ctrl-macid",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(cpsw_ctrl_macid_of_ids),
+	},
+};
+
+module_platform_driver(cpsw_ctrl_macid_driver);
+MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.0

