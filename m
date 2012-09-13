From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V4 1/2] of: Add generic device tree DMA helpers
Date: Thu, 13 Sep 2012 17:00:28 -0500
Message-ID: <1347573629-21299-2-git-send-email-jon-hunter@ti.com>
References: <1347573629-21299-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42892 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758820Ab2IMWBK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 18:01:10 -0400
In-Reply-To: <1347573629-21299-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>

This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
to add some basic helpers to retrieve a DMA controller device_node and the
DMA request/channel information.

Aim of DMA helpers
- The purpose of device-tree is to describe the capabilites of the hardware.
  Thinking about DMA controllers purely from the context of the hardware to
  begin with, we can describe a device in terms of a DMA controller as
  follows ...
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
	1. How does the binding support devices with multiple DMA controllers?
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

1. Registering DMA controllers

   In the case of DMA controllers that are using DMA Engine, requesting a
   channel is performed by calling the following function.

	struct dma_chan *dma_request_channel(dma_cap_mask_t mask,
			dma_filter_fn filter_fn,
			void *filter_param);

   The mask variable is used to match a type of the device controller in a list
   of controllers. The filter_fn and filter_param are used to identify the
   required dma channel and return a handle to the dma channel of type dma_chan.

   From the examples I have seen, the mask and filter_fn are constant
   for a given DMA controller and therefore, we can specify these as controller
   specific data when registering the DMA controller with the device-tree DMA
   helpers.

   The filter_param variable is of an unknown type and is typically specific
   to the DMA engine implementation for a given DMA controller. To allow some
   flexibility in the type and formating of this filter_param we employ an
   xlate to translate the device-tree binding information into the appropriate
   format. The xlate function used for a DMA controller can also be specified
   when registering the DMA controller with the device-tree DMA helpers.

   Based upon the above, a function for registering the DMA controller with the
   DMA helpers now looks like the below. The data variable is used to pass a
   pointer to DMA controller specific data used by the xlate function.

	int of_dma_controller_register(struct device_node *np,
		struct dma_chan *(*of_dma_xlate)
		(struct of_phandle_args *, struct of_dma *),
		void *data)

   For example, in the case where DMA engine is used, we define the following
   structure (that stores the DMA engine capability mask and filter function)
   and pass this to the data variable in the above function.

	struct of_dma_filter_info {
		dma_cap_mask_t  dma_cap;
		dma_filter_fn   filter_fn;
	};

2. Representing and requesting channel information

   Please see the dma binding documentation included in this patch for a
   description of how DMA controllers and client information should be
   represented with device-tree. For more information on how this binding
   came about please see [3]. In addition to this, feedback received from
   the Linux kernel summit showed a consensus (among those who attended) to
   use a name to identify DMA client information [4].

   A DMA channel can be requested by calling the following function, where name
   is a required parameter used for identifying a DMA channel. This function
   has been designed to return a structure of type dma_chan to work with the
   DMA engine driver. Note that if DMA engine is used then drivers should be
   using the DMA engine API dma_request_slave_channel() (implemented in part 2
   of this series, "dmaengine: add helper function to request a slave DMA
   channel") which will in turn call the below function if device-tree is
   present. The aim being to have a common DMA engine interface regardless of
   whether device tree is being used.

	struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
						      char *name)

3. Supporting legacy devices not using DMA Engine

   These devices present a problem, as there may not be a uniform way to easily
   support them with regard to device tree. Ideally, these should be migrated
   to DMA engine. However, if this is not possible, then they should still be
   able to use this binding, the only constaint imposed by this implementation
   is that when requesting a DMA channel via of_dma_request_slave_channel(), it
   will return a type of dma_chan.

This implementation has been tested on OMAP4430 using the kernel v3.6-rc5. I
have validated that MMC is working on the PANDA board with this implementation.
My development branch for testing on OMAP can be found here [5].

v4: - revert the removal of xlate function from v3
    - update the proposed binding format and APIs based upon discussions [3]
v3: - avoid passing an xlate function and instead pass DMA engine parameters
    - define number of dma channels and requests in dma-controller node
v2: - remove of_dma_to_resource API
    - make property #dma-cells required (no fallback anymore)
    - another check in of_dma_xlate_onenumbercell() function

[1] http://article.gmane.org/gmane.linux.drivers.devicetree/12022
[2] http://article.gmane.org/gmane.linux.ports.arm.omap/73622
[3] http://marc.info/?l=linux-omap&m=133582085008539&w=2
[4] http://pad.linaro.org/arm-mini-summit-2012
[5] https://github.com/jonhunter/linux/tree/dev-dt-dma

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 Documentation/devicetree/bindings/dma/dma.txt |   62 +++++++
 drivers/of/Makefile                           |    2 +-
 drivers/of/dma.c                              |  215 +++++++++++++++++++++++++
 include/linux/of_dma.h                        |   45 ++++++
 4 files changed, 323 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/dma.txt
 create mode 100644 drivers/of/dma.c
 create mode 100644 include/linux/of_dma.h

diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
new file mode 100644
index 0000000..a7d35e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/dma.txt
@@ -0,0 +1,62 @@
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
+- #dma-cells: 		Must be at least 1. Used to provide DMA controller
+			specific information. See DMA client binding below for
+			more details.
+
+Optional properties:
+- #dma-channels: 	Number of DMA channels supported by the controller.
+- #dma-requests: 	Number of DMA requests signals supported by the
+			controller.
+
+Example:
+
+	sdma: dmaengine@48000000 {
+		compatible = "ti,omap-sdma"
+		reg = <0x48000000 0x1000>;
+		interrupts = <0 12 0x4
+			      0 13 0x4
+			      0 14 0x4
+			      0 15 0x4>;
+		#dma-cells = <1>;
+		#dma-channels = <32>;
+		#dma-requests = <127>;
+	};
+
+
+* DMA client
+
+Client drivers should specify the DMA property using a phandle to the controller
+followed by DMA controller specific data.
+
+Required property:
+- dmas:			List of one or more DMA specifiers, each consisting of
+			- A phandle pointing to DMA controller node
+			- A single integer cell containing DMA controller
+			  specific information. This typically contains a dma
+			  request line number or a channel number, but can
+			  contain any data that is used required for configuring
+			  a channel.
+- dma-names: 		Contains one identifier string for each dma specifier in
+			the dmas property. The specific strings that can be used
+			are defined in the binding of the DMA client device.
+
+Example:
+
+- One DMA write channel, one DMA read/write channel:
+
+	i2c1: i2c@1 {
+		...
+		dmas = <&sdma 2		/* read channel */
+			&sdma 3>;	/* write channel */
+		dma-names = "rx", "tx"
+		...
+	};
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index e027f44..eafa107 100644
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
index 0000000..4025f2f
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
+/**
+ * of_dma_find_controller - Find a DMA controller in DT DMA helpers list
+ * @np:		device node of DMA controller
+ */
+static struct of_dma *of_dma_find_controller(struct device_node *np)
+{
+	struct of_dma *ofdma;
+
+	if (list_empty(&of_dma_list)) {
+		pr_err("empty DMA controller list\n");
+		return NULL;
+	}
+
+	list_for_each_entry_rcu(ofdma, &of_dma_list, of_dma_controllers)
+		if (ofdma->of_node == np)
+			return ofdma;
+
+	return NULL;
+}
+
+/**
+ * of_dma_controller_register - Register a DMA controller to DT DMA helpers
+ * @np:			device node of DMA controller
+ * @of_dma_xlate:	translation function which converts a phandle
+ *			arguments list into a dma_chan structure
+ * @data		pointer to controller specific data to be used by
+ *			translation function
+ *
+ * Returns 0 on success or appropriate errno value on error.
+ *
+ * Allocated memory should be freed with appropriate of_dma_controller_free()
+ * call.
+ */
+int of_dma_controller_register(struct device_node *np,
+				struct dma_chan *(*of_dma_xlate)
+				(struct of_phandle_args *, struct of_dma *),
+				void *data)
+{
+	struct of_dma	*ofdma;
+	int		nbcells;
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
+	nbcells = be32_to_cpup(of_get_property(np, "#dma-cells", NULL));
+	if (!nbcells) {
+		pr_err("%s: #dma-cells property is missing or invalid\n",
+		       __func__);
+		return -EINVAL;
+	}
+
+	ofdma->of_node = np;
+	ofdma->of_dma_nbcells = nbcells;
+	ofdma->of_dma_xlate = of_dma_xlate;
+	ofdma->of_dma_data = data;
+
+	/* Now queue of_dma controller structure in list */
+	list_add_tail_rcu(&ofdma->of_dma_controllers, &of_dma_list);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_dma_controller_register);
+
+/**
+ * of_dma_controller_free - Remove a DMA controller from DT DMA helpers list
+ * @np:		device node of DMA controller
+ *
+ * Memory allocated by of_dma_controller_register() is freed here.
+ */
+void of_dma_controller_free(struct device_node *np)
+{
+	struct of_dma *ofdma;
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
+ * of_dma_find_channel - Find a DMA channel by name
+ * @np:		device node to look for DMA channels
+ * @name:	name of desired channel
+ * @dma_spec:	pointer to DMA specifier as found in the device tree
+ *
+ * Find a DMA channel by the name. Returns 0 on success or appropriate
+ * errno value on error.
+ */
+static int of_dma_find_channel(struct device_node *np, char *name,
+			       struct of_phandle_args *dma_spec)
+{
+	int count, i;
+	const char *s;
+
+	count = of_property_count_strings(np, "dma-names");
+	if (count < 0)
+		return count;
+
+	for (i = 0; i < count; i++) {
+		of_property_read_string_index(np, "dma-names", i, &s);
+
+		if (strcmp(name, s))
+			continue;
+
+		return of_parse_phandle_with_args(np, "dmas", "#dma-cells",
+							i, dma_spec);
+	}
+
+	return -ENODEV;
+}
+
+/**
+ * of_dma_request_slave_channel - Get the DMA slave channel
+ * @np:		device node to get DMA request from
+ * @name:	name of desired channel
+ *
+ * Returns pointer to appropriate dma channel on success or NULL on error.
+ */
+struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
+					      char *name)
+{
+	struct of_phandle_args	dma_spec;
+	struct of_dma		*ofdma;
+	struct dma_chan		*chan;
+	int			r;
+
+	if (!np || !name) {
+		pr_err("%s: not enough information provided\n", __func__);
+		return NULL;
+	}
+
+	r = of_dma_find_channel(np, name, &dma_spec);
+
+	if (r) {
+		pr_err("%s: can't find DMA channel\n", np->full_name);
+		return NULL;
+	}
+
+	ofdma = of_dma_find_controller(dma_spec.np);
+	if (!ofdma) {
+		pr_err("%s: can't find DMA controller %s\n", np->full_name,
+		       dma_spec.np->full_name);
+		return NULL;
+	}
+
+	if (dma_spec.args_count != ofdma->of_dma_nbcells) {
+		pr_err("%s: wrong #dma-cells for %s\n", np->full_name,
+		       dma_spec.np->full_name);
+		return NULL;
+	}
+
+	chan = ofdma->of_dma_xlate(&dma_spec, ofdma);
+
+	of_node_put(dma_spec.np);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(of_dma_request_slave_channel);
+
+/**
+ * of_dma_simple_xlate - Simple DMA engine translation function
+ * @dma_spec:	pointer to DMA specifier as found in the device tree
+ * @of_dma:	pointer to DMA controller data
+ *
+ * A simple translation function for devices that use a 32-bit value for the
+ * filter_param when calling the DMA engine dma_request_channel() function.
+ * Note that this translation function requires that #dma-cells is equal to 1
+ * and the argument of the dma specifier is the 32-bit filter_param. Returns
+ * pointer to appropriate dma channel on success or NULL on error.
+ */
+struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
+						struct of_dma *ofdma)
+{
+	int count = dma_spec->args_count;
+	struct of_dma_filter_info *info = ofdma->of_dma_data;
+
+	if (!info || !info->filter_fn)
+		return NULL;
+
+	if (count != 1)
+		return NULL;
+
+	return dma_request_channel(info->dma_cap, info->filter_fn,
+			&dma_spec->args[0]);
+}
diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
new file mode 100644
index 0000000..337823d
--- /dev/null
+++ b/include/linux/of_dma.h
@@ -0,0 +1,45 @@
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
+#include <linux/of.h>
+#include <linux/dmaengine.h>
+
+struct device_node;
+
+struct of_dma {
+	struct list_head	of_dma_controllers;
+	struct device_node	*of_node;
+	int			of_dma_nbcells;
+	struct dma_chan		*(*of_dma_xlate)
+				(struct of_phandle_args *, struct of_dma *);
+	void			*of_dma_data;
+};
+
+struct of_dma_filter_info {
+	dma_cap_mask_t	dma_cap;
+	dma_filter_fn	filter_fn;
+};
+
+extern int of_dma_controller_register(struct device_node *np,
+		struct dma_chan *(*of_dma_xlate)
+		(struct of_phandle_args *, struct of_dma *),
+		void *data);
+extern void of_dma_controller_free(struct device_node *np);
+extern struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
+						     char *name);
+extern struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
+		struct of_dma *ofdma);
+
+#endif /* __LINUX_OF_DMA_H */
-- 
1.7.9.5

