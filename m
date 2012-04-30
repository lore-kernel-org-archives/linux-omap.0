From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Mon, 30 Apr 2012 16:17:59 -0500
Message-ID: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34493 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755652Ab2D3VSk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 17:18:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: device-tree <devicetree-discuss@lists.ozlabs.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>

From: Jon Hunter <jon-hunter@ti.com>

This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
to add some basic helpers to retrieve a DMA controller device_node and the
DMA request/channel information.

Aim of DMA helpers
- The purpose of device-tree (as far as I understand), is to describe the
  capabilites of the hardware. Thinking about DMA controllers purely from the
  context of the hardware to begin with, we can describe a device in terms of
  a DMA controller as follows ...
  	1. Number of DMA controllers
	2. Number of channels (maybe physical or logical)
	3. Mapping of DMA requests signals to DMA controller
	4. Number of DMA interrupts
	5. Mapping of DMA interrupts to channels
- With the above in mind the aim of the DT DMA helper functions is to extract
  the above information from the DT and provide to the appropriate driver.
  However, due to the vast number of DMA controllers and not all are using a
  common driver (such as DMA Engine) it has been seen that this is not a
  trivial task. In previous discussions on this topic the following concerns
  have been raised ...
	1. How does the binding identify when there are multiple DMA
	   controllers?
  	2. How to support both legacy DMA controllers not using DMA Engine as
	   well as those that support DMA Engine.
	3. When using with DMA Engine how do we support the various
	   implementations where the opaque filter function parameter differs
	   between implementations?
	4. How do we handle DMA channels that are identified with a string
	   versus a integer?
- Hence the design of the DMA helpers has to accomodate the above or align on
  an agreement what can be or should be supported.

Design of DMA helpers

1. Supporting devices with multiple DMA controllers

   In the case of DMA controllers that are using DMA Engine, requesting a
   channel is performed by calling the following function.

	struct dma_chan *dma_request_channel(dma_cap_mask_t mask,
			dma_filter_fn filter_fn,
			void *filter_param);

   The mask variable is used to identify the device controller in a list of
   controllers. The filter_fn and filter_param are used to identify the
   required dma channel and return a handle to the dma channel of type
   dma_chan. From the examples I have seen, the mask and filter_fn are constant
   for a given DMA controller. Therefore, when registering a DMA controller with
   device tree we can pass these parameters and store them so that a device can
   request them when requesting a channel. Hence, based upon this our register
   function for the DMA controller now looks like this.

	int of_dma_controller_register(struct device_node *np,
		dma_cap_mask_t *mask, dma_filter_fn fn);

2. Supporting legacy devices not using DMA Engine

   These devices present a problem, as there may not be a uniform way to easily
   support them with regard to device tree. However, _IF_ legacy devices that
   are not using DMA Engine, only have a single DMA controller, then this
   problem is a lot simpler. For example, if we look at the previously proposed
   API for registering a DMA controller (where we pass the mask and function
   pointer to the DMA Engine filter function) we can simply pass NULL and hence,
   a driver requesting the DMA channel information would receive NULL for the
   DMA Engine specific parameters. Then for legacy devices we simply need a
   means to return the channel information (more on this later). If there are
   legacy devices that do have multiple DMA controllers, then maybe they need to
   be converted to support DMA Engine. I am not sure if this is unreasonable???

3. Representing and requesting channel information

   From a hardware perspective, a DMA channel could be represented as ...

   i. channel index/number
   ii. channel transfer type (optional)
   iii. DMA interrupt mapping (optional)

  Please note that the transfer type is used to indicate if the transfer is to
  device from memory, to memory from device, to memory from memory, etc. This
  can be useful when there is a device such as an MMC device that uses two DMA
  channels, one for reading (RX) and one for writing (TX).

  Forgetting device tree for now, some drivers use strings to represent a
  DMA channel instead of using an integer. I assume that these drivers then
  employ some sort of look-up table to convert the string into a channel
  number/index that the hardware understands. If this assumption is correct
  then when moving to a device tree implementation having such look-up tables
  in the driver should no longer be necessary as the device tree will provide
  the mapping of channel index/number to the device. Furthermore, it makes
  sense that device tree uses integers to represent channel as opposed to
  strings to save the driver having to convert the string into a integer at
  some later stage.

  Next we need to think about how the DMA controller and channels are described
  in the device tree itself. The following device tree node example describes
  the properties of the DMA controller that includes, the register address
  range, number of interrupt supported, number of channels and number of request
  signals. This has been enhanced from the previous versions by adding number of
  channels and number of request signals.

	sdma: dma-controller@4A056000 {
		compatible = "ti,omap4-sdma";
		reg = <0x4A056000 0x1000>;
		interrupts = <4>;
		#dma-cells = <2>;
		#dma-channels = <32>;
		#dma-requests = <127>;
	};

  Given the above controller definition, DMA resources for a device, such as an
  MMC that uses two DMA channels, can be declared as follows.

	mmc1: mmc@4809c000 {
		...
		dma = <&sdma 61 1 &sdma 62 2>;
		...
	};

   The above syntax to represent each DMA resource is "controller-phandle +
   dma-channel + transfer-type". The transfer-type here is defined to match the
   types in DMA Engine dma_transfer_direction enumeration
   (see include/linux/dmaengine.h). Hence, a "1" means DMA_MEM_TO_DEV and a "2"
   means "DMA_DEV_TO_MEM". This will be helpful later when requesting the
   channel information. You will also notice here that there is no entry for
   representing the interrupt used by the DMA channel and this is because this
   version has not added this capability. I believe that this will be important
   to define in the device tree, but at the moment this has been left out purely
   because passing this information was not supported for the device (OMAP) that
   I was using to implement this. This could be easily added if people find this
   implementation acceptable.

   A driver can now request the DMA channel information by calling the following
   function.

	int of_get_dma_channel_info(struct device_node *np, int type,
		       struct of_dma_channel_info *info)

   Where type represents the transfer-type (again the DMA Engine
   dma_transfer_direction enumeration can be used here regardless of if DMA
   Engine is used) and of_dma_channel_info is defined as follows.

	struct of_dma_channel_info {
		int		dma_channel;
		dma_cap_mask_t	dma_cap;
		dma_filter_fn	dma_filter_func;
	};

   Here dma_channel will always be valid and the other fields are optional
   depending on whether DMA Engine is used.

This implementation has been tested on OMAP4430 using Russell King's latest
DMA Engine series for OMAP [3] and with Benoit Cousson latest DT changes for
OMAP4 [4]. I have validated that MMC is working on the PANDA board with this
implementation. I have not included all the changes for PANDA board here but
just wished to share the implementation.

My aim here was to restart the dialogue on this topic. Please let me know your
thoughts and if there are any glaring short-comings with my assumptions and
ideas :-)

v3: - avoid passing an xlate function and instead pass DMA engine parameters
    - define number of dma channels and requests in dma-controller node

v2: - remove of_dma_to_resource API
    - make property #dma-cells required (no fallback anymore)
    - another check in of_dma_xlate_onenumbercell() function

[1] http://article.gmane.org/gmane.linux.drivers.devicetree/12022
[2] http://article.gmane.org/gmane.linux.ports.arm.omap/73622
[3] http://article.gmane.org/gmane.linux.ports.arm.omap/75366
[4] http://permalink.gmane.org/gmane.linux.ports.arm.omap/73263

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 Documentation/devicetree/bindings/dma/dma.txt |   47 ++++++
 drivers/of/Makefile                           |    2 +-
 drivers/of/dma.c                              |  203 +++++++++++++++++++++++++
 include/linux/of_dma.h                        |   35 +++++
 4 files changed, 286 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/dma.txt
 create mode 100644 drivers/of/dma.c
 create mode 100644 include/linux/of_dma.h

diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
new file mode 100644
index 0000000..b9e838d
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/dma.txt
@@ -0,0 +1,47 @@
+* Generic DMA Controller and DMA request bindings
+
+Generic binding to provide a way for a driver using DMA Engine to retrieve the
+DMA request or channel information that goes from a hardware device to a DMA
+controller.
+
+
+* DMA controller
+
+Required property:
+    - #dma-cells: Number elements to describe DMA channel information. Must be
+                  2 with current implementation but in future we could allow
+		  more than 2 to describe interrupt mapping as well.
+    - #dma-channels: Number of DMA channels supported by the controller.
+    - #dma-requests: Number of DMA requests signals supported by the controller.
+
+Example:
+
+	sdma: dmaengine@48000000 {
+		compatible = "ti,omap4-sdma"
+		reg = <0x48000000 0x1000>;
+		interrupts = <4>;
+		#dma-cells = <2>;
+		#dma-channels = <32>;
+		#dma-requests = <127>;
+	};
+
+
+* DMA client
+
+Client drivers should specify the DMA property using a phandle to the controller
+followed by the number of DMA request/channel and the transfer type of the
+channel (eg. device-to-memory, memory-to-device, memory-to-memory, etc). Drivers
+should use the DMA Engine enum dma_transfer_direction (eg. DMA_DEV_TO_MEM,
+DMA_MEM_TO_DEV, etc) for specifying the transfer type.
+
+Required property:
+    - dma: List of phandle + dma-request/channel + transfer-type,
+      one group per request "line".
+
+Example:
+
+	i2c1: i2c@1 {
+		...
+		dma = <&sdma 2 1 &sdma 3 2>;
+		...
+	};
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index aa90e60..fd9f4eb 100644
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
index 0000000..c9d4f34
--- /dev/null
+++ b/drivers/of/dma.c
@@ -0,0 +1,203 @@
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
+	struct list_head	of_dma_controllers;
+	struct device_node	*of_node;
+	int			of_dma_n_cells;
+	dma_cap_mask_t		of_dma_cap;
+	dma_filter_fn		of_dma_filter_func;
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
+ * @np:		device node of DMA controller
+ * @fn:		DMA Engine filter function that is used to call architecture
+ *		specific function for requesting a DMA channel. Optional for
+ *		legacy drivers not using DMA Engine.
+ *
+ * Returns 0 on success or appropriate errno value on error.
+ *
+ * Allocated memory should be freed with appropriate of_dma_controller_free()
+ * call.
+ */
+int of_dma_controller_register(struct device_node *np, dma_cap_mask_t *mask,
+		dma_filter_fn fn)
+{
+	struct of_dma	*ofdma;
+	int		nbcells;
+
+	if (!np) {
+		pr_err("%s: not enough information provided\n", __func__);
+		return -EINVAL;
+	}
+
+	ofdma = kzalloc(sizeof(*ofdma), GFP_KERNEL);
+	if (!ofdma)
+		return -ENOMEM;
+
+	nbcells = be32_to_cpup(of_get_property(np, "#dma-cells", NULL));
+	if (nbcells != 2) {
+		pr_err("%s: #dma-cells property must be set to 2 (%d)\n",
+			__func__, nbcells);
+		return -EINVAL;
+	}
+
+	ofdma->of_dma_n_cells = nbcells;
+	ofdma->of_node = np;
+	ofdma->of_dma_filter_func = fn;
+
+	if (mask)
+		ofdma->of_dma_cap = *mask;
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
+ * of_dma_find_channel - Find the DMA channel for a given device that matches
+ *		the transfer type specified
+ * @np:		device node to look for DMA channels
+ * @type:	DMA Engine transfer type
+ * @dma_spec:	DMA specifier as found in the device tree
+ *
+ * Returns 0 on success or appropriate errno value on error.
+ */
+unsigned int of_dma_find_channel(struct device_node *np, int type,
+				struct of_phandle_args *dma_spec)
+{
+	int ret;
+	unsigned int cnt = 0;
+
+	do {
+		ret = of_parse_phandle_with_args(np, "dma",
+						 "#dma-cells", cnt, dma_spec);
+		/* A hole in the dma = <> continues ... */
+		if (ret < 0 && ret != -EEXIST)
+			break;
+		/* If the type matches, we have found the
+		 * DMA channel requested and so return
+		 */
+		if (dma_spec->args[1] == type)
+			break;
+	} while (++cnt);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_dma_find_channel);
+
+/**
+ * of_get_dma_channel_info() - Get the DMA channel informration
+ * @np:		device node to get DMA request from
+ * @type:	dma engine transfer type
+ * @info:	pointer to dma channel information
+ *
+ * Returns 0 on success or appropriate errno value on error.
+ */
+int of_get_dma_channel_info(struct device_node *np, int type,
+		       struct of_dma_channel_info *info)
+{
+	struct of_phandle_args	dma_spec;
+	struct of_dma		*ofdma;
+	int			ret;
+
+	if (!np || !info) {
+		pr_err("%s: not enough information provided\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = of_dma_find_channel(np, type, &dma_spec);
+	if (ret < 0) {
+		pr_err("%s: can't find dma channel\n", np->full_name);
+		goto err0;
+	}
+
+	if (list_empty(&of_dma_list)) {
+		pr_err("%s: empty DMA controller list\n",
+			 np->full_name);
+		ret = -ENODEV;
+		goto err1;
+	}
+
+	ofdma = of_dma_find_controller(dma_spec.np);
+	if (!ofdma) {
+		pr_err("%s: DMA controller %s isn't registered\n",
+			 np->full_name, dma_spec.np->full_name);
+		ret = -ENODEV;
+		goto err1;
+	}
+
+	if (dma_spec.args_count != ofdma->of_dma_n_cells) {
+		pr_err("%s: wrong #dma-cells for %s\n",
+			 np->full_name, dma_spec.np->full_name);
+		ret = -EINVAL;
+		goto err1;
+	}
+
+	info->dma_cap = ofdma->of_dma_cap;
+	info->dma_channel = (int)dma_spec.args[0];
+	info->dma_filter_func = ofdma->of_dma_filter_func;
+
+err1:
+	of_node_put(dma_spec.np);
+err0:
+	pr_debug("%s exited with status %d\n", __func__, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_get_dma_channel_info);
diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
new file mode 100644
index 0000000..5ff0a6f
--- /dev/null
+++ b/include/linux/of_dma.h
@@ -0,0 +1,35 @@
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
+#include <linux/dmaengine.h>
+
+struct device_node;
+
+struct of_dma_channel_info {
+	int		dma_channel;
+	dma_cap_mask_t	dma_cap;
+	dma_filter_fn	dma_filter_func;
+};
+
+extern int of_dma_controller_register(struct device_node *np,
+			dma_cap_mask_t *mask,
+			bool (*of_dma_filer_fn)(struct dma_chan *, void *));
+extern void of_dma_controller_free(struct device_node *np);
+extern int of_get_dma_channel_info(struct device_node *np, int index,
+			struct of_dma_channel_info *info);
+
+#endif /* __LINUX_OF_DMA_H */
-- 
1.7.5.4

