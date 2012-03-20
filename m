From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH v2 1/2] of: Add generic device tree DMA helpers
Date: Tue, 20 Mar 2012 11:13:31 +0100
Message-ID: <6b5dc1fadfd03a48093338b6981c0a7ae7662212.1332237596.git.nicolas.ferre@atmel.com>
References: <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:52602 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab2CTKOZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Mar 2012 06:14:25 -0400
In-Reply-To: <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, plagnioj@jcrosoft.com, vinod.koul@linux.intel.com, Nicolas Ferre <nicolas.ferre@atmel.com>, Stephen Warren <swarren@nvidia.com>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>

Add some basic helpers to retrieve a DMA controller device_node and the
DMA request specifications. By making DMA controllers register a generic
translation function, we allow the management of any type of DMA requests
specification.
The void * output of an of_dma_xlate() function that will be implemented
by the DMA controller can carry any type of "dma-request" argument.

The DMA client will search its associated DMA controller in the list and
call the registered of_dam_xlate() function to retrieve the request values.

One simple xlate function is provided for the "single number" type of
request binding.

This implementation is independent from dmaengine so it can also be used
by legacy drivers.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
Hi all,

v2: - remove of_dma_to_resource API
    - make property #dma-cells required (no fallback anymore)
    - another check in of_dma_xlate_onenumbercell() function

This patch is just for the record as it seems that those helpers will not cover
every people expectations. So I let interested people build on top of this or
redo the whole stuff from the gound up.

Bye,

 Documentation/devicetree/bindings/dma/dma.txt |   45 +++++
 drivers/of/Makefile                           |    2 +-
 drivers/of/dma.c                              |  215 +++++++++++++++++++++++++
 include/linux/of_dma.h                        |   60 +++++++
 4 files changed, 321 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/dma.txt
 create mode 100644 drivers/of/dma.c
 create mode 100644 include/linux/of_dma.h

diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
new file mode 100644
index 0000000..c49e98d
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/dma.txt
@@ -0,0 +1,45 @@
+* Generic DMA Controller and DMA request bindings
+
+Generic binding to provide a way for a driver to retrieve the
+DMA request line that goes from an IP to a DMA controller.
+
+
+* DMA controller
+
+Required property:
+    - #dma-cells: Number of cells for each DMA line.
+
+
+Example:
+
+	sdma: dma-controller@48000000 {
+		compatible = "ti,sdma-omap4"
+		reg = <0x48000000 0x1000>;
+		interrupts = <12>;
+		#dma-cells = <1>;
+	};
+
+
+
+* DMA client
+
+Client drivers should specify the DMA request property using a phandle to
+the controller. If needed, the DMA request identity on that controller is then
+added followed by optional request specifications.
+
+Required property:
+    - dma-request: List of phandle + dma-request + request specifications,
+      one group per request "line".
+Optional property:
+    - dma-request-names: list of strings in the same order as the dma-request
+      in the dma-request property.
+
+
+Example:
+
+	i2c1: i2c@1 {
+		...
+		dma-request = <&sdma 2 &sdma 3>;
+		dma-request-names = "tx", "rx";
+		...
+	};
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index a73f5a5..338c2ee 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1,4 +1,4 @@
-obj-y = base.o
+obj-y = base.o dma.o
 obj-$(CONFIG_OF_FLATTREE) += fdt.o
 obj-$(CONFIG_OF_PROMTREE) += pdt.o
 obj-$(CONFIG_OF_ADDRESS)  += address.o
diff --git a/drivers/of/dma.c b/drivers/of/dma.c
new file mode 100644
index 0000000..e58a0dd
--- /dev/null
+++ b/drivers/of/dma.c
@@ -0,0 +1,215 @@
+/*
+ * Device tree helpers for DMA request / controller
+ *
+ * Based on of_gpio.c
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/rculist.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+
+static LIST_HEAD(of_dma_list);
+
+struct of_dma {
+	struct list_head of_dma_controllers;
+	struct device_node *of_node;
+	int of_dma_n_cells;
+	int (*of_dma_xlate)(struct of_phandle_args *dma_spec, void *data);
+};
+
+/**
+ * of_dma_find_controller() - Find a DMA controller in DT DMA helpers list
+ * @np:		device node of DMA controller
+ */
+static struct of_dma *of_dma_find_controller(struct device_node *np)
+{
+	struct of_dma	*ofdma;
+
+	list_for_each_entry_rcu(ofdma, &of_dma_list, of_dma_controllers) {
+		if (ofdma->of_node == np)
+			return ofdma;
+	}
+
+	return NULL;
+}
+
+/**
+ * of_dma_controller_register() - Register a DMA controller to DT DMA helpers
+ * @np:			device node of DMA controller
+ * @of_dma_xlate:	generic translation function which converts a phandle
+ *			arguments list into a generic output value
+ *
+ * Returns 0 on success or appropriate errno value on error.
+ *
+ * Allocated memory should be freed with appropriate of_dma_controller_free()
+ * call.
+ */
+int of_dma_controller_register(struct device_node *np,
+			int (*of_dma_xlate)(struct of_phandle_args *, void *))
+{
+	struct of_dma	*ofdma;
+	const __be32	*nbcells;
+
+	if (!np || !of_dma_xlate) {
+		pr_err("%s: not enough information provided\n", __func__);
+		return -EINVAL;
+	}
+
+	ofdma = kzalloc(sizeof(*ofdma), GFP_KERNEL);
+	if (!ofdma)
+		return -ENOMEM;
+
+	nbcells = of_get_property(np, "#dma-cells", NULL);
+	if (!nbcells) {
+		pr_err("%s: #dma-cells property is required\n", __func__);
+		return -EINVAL;
+	} else {
+		ofdma->of_dma_n_cells = be32_to_cpup(nbcells);
+	}
+
+	ofdma->of_node = np;
+	ofdma->of_dma_xlate = of_dma_xlate;
+
+	/* Now queue of_dma controller structure in list */
+	list_add_tail_rcu(&ofdma->of_dma_controllers, &of_dma_list);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_dma_controller_register);
+
+/**
+ * of_dma_controller_free() - Remove a DMA controller from DT DMA helpers list
+ * @np:		device node of DMA controller
+ *
+ * Memory allocated by of_dma_controller_register() is freed here.
+ */
+void of_dma_controller_free(struct device_node *np)
+{
+	struct of_dma	*ofdma;
+
+	ofdma = of_dma_find_controller(np);
+	if (ofdma) {
+		list_del_rcu(&ofdma->of_dma_controllers);
+		kfree(ofdma);
+	}
+}
+EXPORT_SYMBOL_GPL(of_dma_controller_free);
+
+/**
+ * of_get_dma_request() - Get the associated DMA request data
+ * @np:		device node to get DMA request from
+ * @index:	index of the DMA request
+ * @out_data:	a output that can be filled in by the of_dma_xlate() function
+ *
+ * Returns return value of of_dma_xlate() and fills out_data (if provided).
+ * On error returns the appropriate errno value.
+ */
+int of_get_dma_request(struct device_node *np, int index,
+		       void *out_data)
+{
+	struct of_phandle_args	dma_spec;
+	struct of_dma		*ofdma;
+	int			ret;
+
+	ret = of_parse_phandle_with_args(np, "dma-request", "#dma-cells",
+					 index, &dma_spec);
+	if (ret) {
+		pr_err("%s: can't parse dma property\n", np->full_name);
+		goto err0;
+	}
+
+	if (list_empty(&of_dma_list)) {
+		pr_debug("%s: empty DMA controller list\n",
+			 np->full_name);
+		ret = -ENODEV;
+		goto err1;
+	}
+
+	ofdma = of_dma_find_controller(dma_spec.np);
+	if (!ofdma) {
+		pr_debug("%s: DMA controller %s isn't registered\n",
+			 np->full_name, dma_spec.np->full_name);
+		ret = -ENODEV;
+		goto err1;
+	}
+
+	if (dma_spec.args_count != ofdma->of_dma_n_cells) {
+		pr_debug("%s: wrong #dma-cells for %s\n",
+			 np->full_name, dma_spec.np->full_name);
+		ret = -EINVAL;
+		goto err1;
+	}
+
+	ret = ofdma->of_dma_xlate(&dma_spec, out_data);
+
+err1:
+	of_node_put(dma_spec.np);
+err0:
+	pr_debug("%s exited with status %d\n", __func__, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_get_dma_request);
+
+/**
+ * of_dma_xlate_onenumbercell() - Generic DMA xlate for direct one cell bindings
+ *
+ * Device Tree DMA translation function which works with one cell bindings
+ * where the cell values map directly to the hardware request number understood
+ * by the DMA controller.
+ */
+int of_dma_xlate_onenumbercell(struct of_phandle_args *dma_spec, void *dma_req)
+{
+	if (!dma_spec)
+		return -EINVAL;
+	if (!dma_req)
+		return -ENOBUFS;
+	if (WARN_ON(dma_spec->args_count != 1))
+		return -EINVAL;
+	*(int *)dma_req = dma_spec->args[0];
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_dma_xlate_onenumbercell);
+
+/**
+ * of_dma_count - Count DMA requests for a device
+ * @np:		device node to count DMAs for
+ *
+ * The function returns the count of DMA requests specified for a node.
+ *
+ * Note that the empty DMA specifiers counts too. For example,
+ *
+ * dma-request = <0
+ *                &sdma 1
+ *                0
+ *                &sdma 3>;
+ *
+ * defines four DMAs (so this function will return 4), two of which
+ * are not specified.
+ */
+unsigned int of_dma_count(struct device_node *np)
+{
+	unsigned int cnt = 0;
+
+	do {
+		int ret;
+
+		ret = of_parse_phandle_with_args(np, "dma-request",
+						 "#dma-cells", cnt, NULL);
+		/* A hole in the dma-request = <> counts anyway. */
+		if (ret < 0 && ret != -EEXIST)
+			break;
+	} while (++cnt);
+
+	return cnt;
+}
+EXPORT_SYMBOL_GPL(of_dma_count);
diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
new file mode 100644
index 0000000..2865480
--- /dev/null
+++ b/include/linux/of_dma.h
@@ -0,0 +1,60 @@
+/*
+ * OF helpers for DMA request / controller
+ *
+ * Based on of_gpio.h
+ *
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_OF_DMA_H
+#define __LINUX_OF_DMA_H
+
+#include <linux/ioport.h>
+#include <linux/of.h>
+
+struct device_node;
+
+#ifdef CONFIG_OF_DMA
+
+extern int of_dma_controller_register(struct device_node *np,
+			int (*of_dma_xlate)(struct of_phandle_args *, void *));
+extern void of_dma_controller_free(struct device_node *np);
+extern int of_get_dma_request(struct device_node *np, int index,
+			      void *out_data);
+extern unsigned int of_dma_count(struct device_node *np);
+
+extern int of_dma_xlate_onenumbercell(struct of_phandle_args *dma_spec,
+				      void *dma_req);
+#else /* CONFIG_OF_DMA */
+
+static int of_dma_controller_register(struct device_node *np,
+			int (*of_dma_xlate)(struct of_phandle_args *, void *))
+{
+	return -ENOSYS;
+}
+
+static void of_dma_controller_free(struct device_node *np) {}
+
+extern int of_get_dma_request(struct device_node *np, int index,
+			      void *out_data)
+{
+	return -ENOSYS;
+}
+
+static inline unsigned int of_dma_count(struct device_node *np)
+{
+	return 0;
+}
+
+static int of_dma_xlate_onenumbercell(struct of_phandle_args *dma_spec,
+				      void *dma_req)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_OF_DMA */
+
+#endif /* __LINUX_OF_DMA_H */
-- 
1.7.9

