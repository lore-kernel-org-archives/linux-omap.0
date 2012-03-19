From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Mon, 19 Mar 2012 14:30:05 +0100
Message-ID: <4F6734DD.3020203@atmel.com>
References: <4F22DEF2.5000807@ti.com> <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com> <20120317094059.7C2333E08E2@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:65003 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757738Ab2CSNav (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 09:30:51 -0400
In-Reply-To: <20120317094059.7C2333E08E2@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>
Cc: rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

On 03/17/2012 10:40 AM, Grant Likely :
> On Thu, 15 Mar 2012 09:38:10 +0100, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>> Add some basic helpers to retrieve a DMA controller device_node and the
>> DMA request specifications. By making DMA controllers register a generic
>> translation function, we allow the management of any type of DMA requests
>> specification.
>> The void * output of an of_dma_xlate() function that will be implemented
>> by the DMA controller can carry any type of "dma-request" argument.
>>
>> The DMA client will search its associated DMA controller in the list and
>> call the registered of_dam_xlate() function to retrieve the request values.
>>
>> One simple xlate function is provided for the "single number" type of
>> request binding.
>>
>> This implementation is independent from dmaengine so it can also be used
>> by legacy drivers.
>>
>> For legacy reason another API will export the DMA request number into a
>> Linux resource of type IORESOURCE_DMA.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> 
> Hi Nicolas,
> 
> Comments below.
> 
>> Cc: Stephen Warren <swarren@nvidia.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> ---
>>  Documentation/devicetree/bindings/dma/dma.txt |   45 +++++
>>  drivers/of/Kconfig                            |    5 +
>>  drivers/of/Makefile                           |    1 +
>>  drivers/of/dma.c                              |  260 +++++++++++++++++++++++++
>>  include/linux/of_dma.h                        |   67 +++++++
>>  5 files changed, 378 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/dma/dma.txt
>>  create mode 100644 drivers/of/dma.c
>>  create mode 100644 include/linux/of_dma.h
>>
>> diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
>> new file mode 100644
>> index 0000000..c49e98d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/dma.txt
>> @@ -0,0 +1,45 @@
>> +* Generic DMA Controller and DMA request bindings
>> +
>> +Generic binding to provide a way for a driver to retrieve the
>> +DMA request line that goes from an IP to a DMA controller.
>> +
>> +
>> +* DMA controller
>> +
>> +Required property:
>> +    - #dma-cells: Number of cells for each DMA line.
>> +
>> +
>> +Example:
>> +
>> +	sdma: dma-controller@48000000 {
>> +		compatible = "ti,sdma-omap4"
>> +		reg = <0x48000000 0x1000>;
>> +		interrupts = <12>;
>> +		#dma-cells = <1>;
>> +	};
>> +
>> +
>> +
>> +* DMA client
>> +
>> +Client drivers should specify the DMA request property using a phandle to
>> +the controller. If needed, the DMA request identity on that controller is then
>> +added followed by optional request specifications.
>> +
>> +Required property:
>> +    - dma-request: List of phandle + dma-request + request specifications,
>> +      one group per request "line".
>> +Optional property:
>> +    - dma-request-names: list of strings in the same order as the dma-request
>> +      in the dma-request property.
>> +
>> +
>> +Example:
>> +
>> +	i2c1: i2c@1 {
>> +		...
>> +		dma-request = <&sdma 2 &sdma 3>;
>> +		dma-request-names = "tx", "rx";
>> +		...
>> +	};
>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>> index 268163d..7d1f06b 100644
>> --- a/drivers/of/Kconfig
>> +++ b/drivers/of/Kconfig
>> @@ -90,4 +90,9 @@ config OF_PCI_IRQ
>>  	help
>>  	  OpenFirmware PCI IRQ routing helpers
>>  
>> +config OF_DMA
>> +	def_bool y
>> +	help
>> +	  Device Tree DMA routing helpers
> 
> Not really any point in having this config symbol at all if it is
> always enabled.

Well, it is the same for:
config OF_DEVICE

But for sure, I can remove it: so I will add it to
obj-y = base.o <here>
in the Makefile.

>>  endmenu # OF
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index a73f5a5..6eb50c6 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -12,3 +12,4 @@ obj-$(CONFIG_OF_SELFTEST) += selftest.o
>>  obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
>>  obj-$(CONFIG_OF_PCI)	+= of_pci.o
>>  obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
>> +obj-$(CONFIG_OF_DMA)	+= dma.o
>> diff --git a/drivers/of/dma.c b/drivers/of/dma.c
>> new file mode 100644
>> index 0000000..3315844
>> --- /dev/null
>> +++ b/drivers/of/dma.c
>> @@ -0,0 +1,260 @@
>> +/*
>> + * Device tree helpers for DMA request / controller
>> + *
>> + * Based on of_gpio.c
>> + *
>> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/rculist.h>
>> +#include <linux/slab.h>
>> +#include <linux/of.h>
>> +#include <linux/of_dma.h>
>> +
>> +static LIST_HEAD(of_dma_list);
>> +
>> +struct of_dma {
>> +	struct list_head of_dma_controllers;
>> +	struct device_node *of_node;
>> +	int of_dma_n_cells;
>> +	int (*of_dma_xlate)(struct of_phandle_args *dma_spec, void *data);
>> +};
> 
> This _xlate is nearly useless as a generic API.  It solves the problem for
> the specific case where the driver is hard-coded to know which DMA engine
> to talk to, but since the returned data doesn't provide any context, it
> isn't useful if there are multiple DMA controllers to choose from.

You mean, if there is no DMA controller phandle specified in the
property? I think that it is not the purpose of this API to choose a DMA
controller, Nor to provide a channel. The only purpose of this API is to
give a HW request to be used by a DMA slave driver. This slave should
already have a channel to use and a controller to talk to.

> The void *data pointer must be replaced with a typed structure so that
> context can be returned.

I am not sure to follow you entirely... How do I address the fact that
several types of request value can be returned then?

BTW, can we imagine a phandle property with a sting as a argument?
should it be written this way?
dma-request = <&testdmac1>, "slave-rx", "slave-tx";

If yes, the of_parse_phandle_with_args() is not working on this type...

(I realize that there seems to be no way out for a generic API: maybe we
should move to one or two cases to address and concentrate on them).

>> +
>> +/**
>> + * of_dma_find_controller() - Find a DMA controller in DT DMA helpers list
>> + * @np:		device node of DMA controller
>> + */
>> +static struct of_dma *of_dma_find_controller(struct device_node *np)
>> +{
>> +	struct of_dma	*ofdma;
>> +
>> +	list_for_each_entry_rcu(ofdma, &of_dma_list, of_dma_controllers) {
>> +		if (ofdma->of_node == np)
>> +			return ofdma;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +/**
>> + * of_dma_controller_register() - Register a DMA controller to DT DMA helpers
>> + * @np:			device node of DMA controller
>> + * @of_dma_xlate:	generic translation function which converts a phandle
>> + *			arguments list into a generic output value
>> + *
>> + * Returns 0 on success or appropriate errno value on error.
>> + *
>> + * If #dma-cells is not specified in DMA controller device tree node, we assume
>> + * that the DMA controller phandle will come without argument.
>> + *
>> + * Allocated memory should be freed with appropriate of_dma_controller_free()
>> + * call.
>> + */
>> +int of_dma_controller_register(struct device_node *np,
>> +			int (*of_dma_xlate)(struct of_phandle_args *, void *))
>> +{
>> +	struct of_dma	*ofdma;
>> +	const __be32	*nbcells;
>> +
>> +	if (!np || !of_dma_xlate) {
>> +		pr_err("%s: not enough information provided\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ofdma = kzalloc(sizeof(*ofdma), GFP_KERNEL);
>> +	if (!ofdma)
>> +		return -ENOMEM;
>> +
>> +	nbcells = of_get_property(np, "#dma-cells", NULL);
>> +	if (!nbcells)
>> +		/*
>> +		 * no #dma-cells properties: assume no argument to
>> +		 * dma-request property on slave side
>> +		 */
>> +		ofdma->of_dma_n_cells = 0;
>> +	else
>> +		ofdma->of_dma_n_cells = be32_to_cpup(nbcells);
> 
> Make #dma-cells a required property

Ok.

>> +
>> +	ofdma->of_node = np;
>> +	ofdma->of_dma_xlate = of_dma_xlate;
>> +
>> +	/* Now queue of_dma controller structure in list */
>> +	list_add_tail_rcu(&ofdma->of_dma_controllers, &of_dma_list);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(of_dma_controller_register);
>> +
>> +/**
>> + * of_dma_controller_free() - Remove a DMA controller from DT DMA helpers list
>> + * @np:		device node of DMA controller
>> + *
>> + * Memory allocated by of_dma_controller_register() is freed here.
>> + */
>> +void of_dma_controller_free(struct device_node *np)
>> +{
>> +	struct of_dma	*ofdma;
>> +
>> +	ofdma = of_dma_find_controller(np);
>> +	if (ofdma) {
>> +		list_del_rcu(&ofdma->of_dma_controllers);
>> +		kfree(ofdma);
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(of_dma_controller_free);
>> +
>> +/**
>> + * of_get_dma_request() - Get the associated DMA request data
>> + * @np:		device node to get DMA request from
>> + * @index:	index of the DMA request
>> + * @out_data:	a output that can be filled in by the of_dma_xlate() function
>> + *
>> + * Returns return value of of_dma_xlate() and fills out_data (if provided).
>> + * On error returns the appropriate errno value.
>> + */
>> +int of_get_dma_request(struct device_node *np, int index,
>> +		       void *out_data)
>> +{
>> +	struct of_phandle_args	dma_spec;
>> +	struct of_dma		*ofdma;
>> +	int			ret;
>> +
>> +	ret = of_parse_phandle_with_args(np, "dma-request", "#dma-cells",
>> +					 index, &dma_spec);
>> +	if (ret) {
>> +		pr_err("%s: can't parse dma property\n", np->full_name);
>> +		goto err0;
>> +	}
>> +
>> +	if (list_empty(&of_dma_list)) {
>> +		pr_debug("%s: empty DMA controller list\n",
>> +			 np->full_name);
>> +		ret = -ENOENT;
>> +		goto err1;
>> +	}
>> +
>> +	ofdma = of_dma_find_controller(dma_spec.np);
>> +	if (!ofdma) {
>> +		pr_debug("%s: DMA controller %s isn't registered\n",
>> +			 np->full_name, dma_spec.np->full_name);
>> +		ret = -ENODEV;
>> +		goto err1;
>> +	}
>> +
>> +	if (dma_spec.args_count != ofdma->of_dma_n_cells) {
>> +		pr_debug("%s: wrong #dma-cells for %s\n",
>> +			 np->full_name, dma_spec.np->full_name);
>> +		ret = -EINVAL;
>> +		goto err1;
>> +	}
>> +
>> +	ret = ofdma->of_dma_xlate(&dma_spec, out_data);
>> +
>> +err1:
>> +	of_node_put(dma_spec.np);
>> +err0:
>> +	pr_debug("%s exited with status %d\n", __func__, ret);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(of_get_dma_request);
>> +
>> +/**
>> + * of_dma_xlate_onenumbercell() - Generic DMA xlate for direct one cell bindings
>> + *
>> + * Device Tree DMA translation function which works with one cell bindings
>> + * where the cell values map directly to the hardware request number understood
>> + * by the DMA controller.
>> + */
>> +int of_dma_xlate_onenumbercell(struct of_phandle_args *dma_spec, void *dma_req)
>> +{
>> +	if (!dma_spec)
>> +		return -EINVAL;
>> +	if (WARN_ON(dma_spec->args_count != 1))
>> +		return -EINVAL;
>> +	*(int *)dma_req = dma_spec->args[0];
> 
> Following on from comment above; the void *dma_req parameter is dangerous.  How
> does this function know that it has been passed an int* pointer?

Well, that is a drawback that comes from having to address generic
cases. But anyway, if the DMA controller decide to register a .xlate()
function that returns an integer, the slave driver that will ask a
"request line" to this DMA controller will be aware that an integer has
to be passed to of_get_dma_request().

(
but I realize that a test on dma_req is certainly missing:
if (!dma_req) return -ENOBUFS;
)

It is true also that if we can find something generic and cleaner, I
will vote for it...

>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(of_dma_xlate_onenumbercell);
>> +
>> +/**
>> + * of_dma_count - Count DMA requests for a device
>> + * @np:		device node to count DMAs for
>> + *
>> + * The function returns the count of DMA requests specified for a node.
>> + *
>> + * Note that the empty DMA specifiers counts too. For example,
>> + *
>> + * dma-request = <0
>> + *                &sdma 1
>> + *                0
>> + *                &sdma 3>;
>> + *
>> + * defines four DMAs (so this function will return 4), two of which
>> + * are not specified.
>> + */
>> +unsigned int of_dma_count(struct device_node *np)
>> +{
>> +	unsigned int cnt = 0;
>> +
>> +	do {
>> +		int ret;
>> +
>> +		ret = of_parse_phandle_with_args(np, "dma-request",
>> +						 "#dma-cells", cnt, NULL);
>> +		/* A hole in the dma-request = <> counts anyway. */
>> +		if (ret < 0 && ret != -EEXIST)
>> +			break;
>> +	} while (++cnt);
>> +
>> +	return cnt;
>> +}
>> +EXPORT_SYMBOL_GPL(of_dma_count);
>> +
>> +/**
>> + * of_dma_to_resource - Decode a node's DMA and return it as a resource
>> + * @dev: pointer to device tree node
>> + * @index: zero-based index of the DMA request
>> + * @r: pointer to resource structure to return result into.
>> + *
>> + * Using a resource to export a DMA request number to a driver should
>> + * be used only for legacy purpose and on system when only one DMA controller
>> + * is present.
>> + * The proper and only scalable way is to use the native of_get_dma_request API
>> + * in order retrieve both the DMA controller device node and the DMA request
>> + * line for that controller.
>> + */
>> +int of_dma_to_resource(struct device_node *dev, int index, struct resource *r)
>> +{
>> +	const char *name = NULL;
>> +	int dma;
>> +	int ret;
>> +
>> +	if (!r)
>> +		return -EINVAL;
>> +
>> +	ret = of_get_dma_request(dev, index, &dma);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/*
>> +	 * Get optional "dma-request-names" property to add a name
>> +	 * to the resource.
>> +	 */
>> +	of_property_read_string_index(dev, "dma-request-names", index,
>> +				      &name);
>> +
>> +	r->start = dma;
>> +	r->end = dma;
>> +	r->flags = IORESOURCE_DMA;
>> +	r->name = name ? name : dev->full_name;
> 
> I'll reiterate my concern here.  The dual meaning of r->name depending
> on the presence of a dma-request-names property is a real problem.  I know
> this patch set hasn't introduced the problem since it already exists for
> register regions and irqs, but it is expanding it.

After discussion between Benoit and Arnd it is clear now that the
of_dma_to_resource() API will go away.

>> +
>> +	return dma;
>> +}
>> +EXPORT_SYMBOL_GPL(of_dma_to_resource);
>> diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
>> new file mode 100644
>> index 0000000..c6147bb
>> --- /dev/null
>> +++ b/include/linux/of_dma.h
>> @@ -0,0 +1,67 @@
>> +/*
>> + * OF helpers for DMA request / controller
>> + *
>> + * Based on of_gpio.h
>> + *
>> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef __LINUX_OF_DMA_H
>> +#define __LINUX_OF_DMA_H
>> +
>> +#include <linux/of.h>
>> +
>> +struct device_node;
>> +
>> +#ifdef CONFIG_OF_DMA
>> +
>> +extern int of_dma_controller_register(struct device_node *np,
>> +			int (*of_dma_xlate)(struct of_phandle_args *, void *));
>> +extern void of_dma_controller_free(struct device_node *np);
>> +extern int of_get_dma_request(struct device_node *np, int index,
>> +			      void *out_data);
>> +extern unsigned int of_dma_count(struct device_node *np);
>> +extern int of_dma_to_resource(struct device_node *dev, int index,
>> +			      struct resource *r);
>> +
>> +extern int of_dma_xlate_onenumbercell(struct of_phandle_args *dma_spec,
>> +				      void *dma_req);
>> +#else /* CONFIG_OF_DMA */
>> +
>> +static int of_dma_controller_register(struct device_node *np,
>> +			int (*of_dma_xlate)(struct of_phandle_args *, void *))
>> +{
>> +	return -ENOSYS;
>> +}
>> +
>> +static void of_dma_controller_free(struct device_node *np) {}
>> +
>> +extern int of_get_dma_request(struct device_node *np, int index,
>> +			      void *out_data)
>> +{
>> +	return -ENOSYS;
>> +}
>> +
>> +static inline unsigned int of_dma_count(struct device_node *np)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int of_dma_to_resource(struct device_node *dev, int index,
>> +			      struct resource *r);
>> +{
>> +	return -ENOSYS;
>> +}
>> +
>> +static int of_dma_xlate_onenumbercell(struct of_phandle_args *dma_spec,
>> +				      void *dma_req)
>> +{
>> +	return -ENOSYS;
>> +}
>> +#endif /* CONFIG_OF_DMA */
>> +
>> +#endif /* __LINUX_OF_DMA_H */
>> -- 
>> 1.7.9
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Nicolas Ferre
