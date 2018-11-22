From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 06/17] soc: ti: pruss: Add a platform driver for PRUSS in TI SoCs
Date: Thu, 22 Nov 2018 13:39:02 +0200
Message-ID: <1542886753-17625-7-git-send-email-rogerq@ti.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The PRUSS platform driver deals with the overall PRUSS and is
used for managing the subsystem level resources like various
memories. It is responsible for the creation and deletion of
the platform devices for the child PRU devices and other child
devices (Interrupt Controller or MDIO node or some syscon nodes)
so that they can be managed by specific platform drivers.

This design provides flexibility in representing the different
modules of PRUSS accordingly, and at the same time allowing the
PRUSS driver to add some instance specific configuration within
an SoC.

The driver currently supports the AM335x SoC.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/soc/ti/Makefile |   2 +-
 drivers/soc/ti/pruss.c  | 116 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/soc/ti/pruss.h  |  44 ++++++++++++++++++
 3 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/ti/pruss.c
 create mode 100644 drivers/soc/ti/pruss.h

diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
index ac6b695..5a0c89d 100644
--- a/drivers/soc/ti/Makefile
+++ b/drivers/soc/ti/Makefile
@@ -8,4 +8,4 @@ obj-$(CONFIG_KEYSTONE_NAVIGATOR_DMA)	+= knav_dma.o
 obj-$(CONFIG_AMX3_PM)			+= pm33xx.o
 obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
 obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
-obj-$(CONFIG_TI_PRUSS)			+= pruss_soc_bus.o
+obj-$(CONFIG_TI_PRUSS)			+= pruss_soc_bus.o pruss.o
diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
new file mode 100644
index 0000000..0840b59
--- /dev/null
+++ b/drivers/soc/ti/pruss.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PRU-ICSS platform driver for various TI SoCs
+ *
+ * Copyright (C) 2014-2018 Texas Instruments Incorporated - http://www.ti.com/
+ *	Suman Anna <s-anna@ti.com>
+ *	Andrew F. Davis <afd@ti.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+
+#include "pruss.h"
+
+static int pruss_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *np;
+	struct pruss *pruss;
+	struct resource res;
+	int ret, i, index;
+	const char *mem_names[PRUSS_MEM_MAX] = { "dram0", "dram1", "shrdram2" };
+
+	if (!node) {
+		dev_err(dev, "Non-DT platform device not supported\n");
+		return -ENODEV;
+	}
+
+	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(dev, "dma_set_coherent_mask: %d\n", ret);
+		return ret;
+	}
+
+	pruss = devm_kzalloc(dev, sizeof(*pruss), GFP_KERNEL);
+	if (!pruss)
+		return -ENOMEM;
+
+	pruss->dev = dev;
+
+	np = of_get_child_by_name(node, "memories");
+	if (!np)
+		return -ENODEV;
+
+	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
+		index = of_property_match_string(np, "reg-names", mem_names[i]);
+		if (index < 0) {
+			of_node_put(np);
+			return index;
+		}
+
+		if (of_address_to_resource(np, index, &res)) {
+			of_node_put(np);
+			return -EINVAL;
+		}
+
+		pruss->mem_regions[i].va = devm_ioremap(dev, res.start,
+							resource_size(&res));
+		if (!pruss->mem_regions[i].va) {
+			dev_err(dev, "failed to parse and map memory resource %d %s\n",
+				i, mem_names[i]);
+			of_node_put(np);
+			return -ENOMEM;
+		}
+		pruss->mem_regions[i].pa = res.start;
+		pruss->mem_regions[i].size = resource_size(&res);
+
+		dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %p\n",
+			mem_names[i], &pruss->mem_regions[i].pa,
+			pruss->mem_regions[i].size, pruss->mem_regions[i].va);
+	}
+	of_node_put(np);
+
+	platform_set_drvdata(pdev, pruss);
+
+	dev_info(&pdev->dev, "creating PRU cores and other child platform devices\n");
+	ret = of_platform_populate(node, NULL, NULL, &pdev->dev);
+	if (ret)
+		dev_err(dev, "of_platform_populate failed\n");
+
+	return ret;
+}
+
+static int pruss_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	dev_info(dev, "remove PRU cores and other child platform devices\n");
+	of_platform_depopulate(dev);
+
+	return 0;
+}
+
+static const struct of_device_id pruss_of_match[] = {
+	{ .compatible = "ti,am3356-pruss", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, pruss_of_match);
+
+static struct platform_driver pruss_driver = {
+	.driver = {
+		.name = "pruss",
+		.of_match_table = pruss_of_match,
+	},
+	.probe  = pruss_probe,
+	.remove = pruss_remove,
+};
+module_platform_driver(pruss_driver);
+
+MODULE_AUTHOR("Suman Anna <s-anna@ti.com>");
+MODULE_DESCRIPTION("PRU-ICSS Subsystem Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/soc/ti/pruss.h b/drivers/soc/ti/pruss.h
new file mode 100644
index 0000000..dbdf475
--- /dev/null
+++ b/drivers/soc/ti/pruss.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PRU-ICSS sub-system specific definitions
+ *
+ * Copyright (C) 2014-2018 Texas Instruments Incorporated - http://www.ti.com/
+ *	Suman Anna <s-anna@ti.com>
+ */
+
+#ifndef _PRUSS_H_
+#define _PRUSS_H_
+
+/**
+ * enum pruss_mem - PRUSS memory range identifiers
+ */
+enum pruss_mem {
+	PRUSS_MEM_DRAM0 = 0,
+	PRUSS_MEM_DRAM1,
+	PRUSS_MEM_SHRD_RAM2,
+	PRUSS_MEM_MAX,
+};
+
+/**
+ * struct pruss_mem_region - PRUSS memory region structure
+ * @va: kernel virtual address of the PRUSS memory region
+ * @pa: physical (bus) address of the PRUSS memory region
+ * @size: size of the PRUSS memory region
+ */
+struct pruss_mem_region {
+	void __iomem *va;
+	phys_addr_t pa;
+	size_t size;
+};
+
+/**
+ * struct pruss - PRUSS parent structure
+ * @dev: pruss device pointer
+ * @mem_regions: data for each of the PRUSS memory regions
+ */
+struct pruss {
+	struct device *dev;
+	struct pruss_mem_region mem_regions[PRUSS_MEM_MAX];
+};
+
+#endif	/* _PRUSS_H_ */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
