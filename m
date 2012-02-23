From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 1/2] of: Add generic device tree DMA helpers
Date: Thu, 23 Feb 2012 11:03:30 +0100
Message-ID: <4F460EF2.9010000@ti.com>
References: <4F22DEF2.5000807@ti.com> <4F44CA82.9060906@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37837 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab2BWKEF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 05:04:05 -0500
In-Reply-To: <4F44CA82.9060906@atmel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Stephen Warren <swarren@nvidia.com>, Thomas Abraham <thomas.abraham@linaro.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Ludovic Desroches <ludovic.desroches@atmel.com>

Salut Nico,

On 2/22/2012 11:59 AM, Nicolas Ferre wrote:
> On 01/27/2012 06:29 PM, Cousson, Benoit :
>> Add some basic helpers to retrieve a DMA controller device_node
>> and the DMA request line number.
>>
>> For legacy reason another API will export the DMA request number
>> into a Linux resource of type IORESOURCE_DMA.
>> This API is usable only on system with an unique DMA controller.
>
> Hi,
>
> I followed that discussion and I like very much the biding that Benoit
> is proposing. It will help me a lot with my current work on Atmel DMA
> controller.
>
> If I understand correctly, some rework is needed before it can be
> integrated in a stable git tree (I mean before we can base our work on
> top of it). So, in the meantime, what should I do to help and make
> things go forward? to be quite frank, I would be interested to have a
> working DMA enabled device soon ;-)

Me too, but unfortunately, I was busy trying to add irq_domain and 
fixing issues with SPARSE_IRQ on OMAP :-(

> Do you think that 3.4 is out of reach?

Maybe not, from the comments, it looks like we should add a .xlate 
callback to allow any custom parsing of the DMA nodes attributes.

I'll be more than happy, if you can finalize that patch :-)

Thanks,
Benoit



>
> Best regards,
>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Rob Herring<rob.herring@calxeda.com>
>> ---
>>   Documentation/devicetree/bindings/dma/dma.txt |   44 +++++++++
>>   drivers/of/Kconfig                            |    5 +
>>   drivers/of/Makefile                           |    1 +
>>   drivers/of/dma.c                              |  130 +++++++++++++++++++++++++
>>   include/linux/of_dma.h                        |   49 +++++++++
>>   5 files changed, 229 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/dma/dma.txt
>>   create mode 100644 drivers/of/dma.c
>>   create mode 100644 include/linux/of_dma.h
>>
>> diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
>> new file mode 100644
>> index 0000000..7f2a301
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/dma.txt
>> @@ -0,0 +1,44 @@
>> +* Generic DMA Controller and DMA request bindings
>> +
>> +Generic binding to provide a way for a driver to retrieve the
>> +DMA request line that goes from an IP to a DMA controller.
>> +
>> +
>> +* DMA controller
>> +
>> +Required properties:
>> +    - dma-controller: Mark the device as a DMA controller
>> +    - #dma-cells: Number of cell for each DMA line, must be one.
>> +
>> +
>> +Example:
>> +
>> +	sdma: dma-controller@48000000 {
>> +		compatible = "ti,sdma-omap4"
>> +		reg =<0x48000000 0x1000>;
>> +		interrupts =<12>;
>> +        dma-controller;
>> +		#dma-cells =<1>;
>> +	};
>> +
>> +
>> +
>> +* DMA client
>> +
>> +Client drivers should specify the DMA request numbers using a phandle to
>> +the controller + the DMA request number on that controller.
>> +
>> +Required properties:
>> +    - dma-request: List of pair phandle + dma-request per line
>> +    - dma-request-names: list of strings in the same order as the dma-request
>> +      in the dma-request property.
>> +
>> +
>> +Example:
>> +
>> +    i2c1: i2c@1 {
>> +        ...
>> +        dma-request =<&sdma 2&sdma 3>;
>> +        dma-request-names = "tx", "rx";
>> +        ...
>> +    };
>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>> index 268163d..7d1f06b 100644
>> --- a/drivers/of/Kconfig
>> +++ b/drivers/of/Kconfig
>> @@ -90,4 +90,9 @@ config OF_PCI_IRQ
>>   	help
>>   	  OpenFirmware PCI IRQ routing helpers
>>
>> +config OF_DMA
>> +	def_bool y
>> +	help
>> +	  Device Tree DMA routing helpers
>> +
>>   endmenu # OF
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index a73f5a5..d08443b 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -12,3 +12,4 @@ obj-$(CONFIG_OF_SELFTEST) += selftest.o
>>   obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
>>   obj-$(CONFIG_OF_PCI)	+= of_pci.o
>>   obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
>> +obj-$(CONFIG_OF_DMA)  += dma.o
>> diff --git a/drivers/of/dma.c b/drivers/of/dma.c
>> new file mode 100644
>> index 0000000..d4927e2
>> --- /dev/null
>> +++ b/drivers/of/dma.c
>> @@ -0,0 +1,130 @@
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
>> +#include<linux/device.h>
>> +#include<linux/err.h>
>> +#include<linux/module.h>
>> +#include<linux/of.h>
>> +#include<linux/of_dma.h>
>> +
>> +/**
>> + * of_get_dma_request() - Get a DMA request number and dma-controller node
>> + * @np:		device node to get DMA request from
>> + * @propname:	property name containing DMA specifier(s)
>> + * @index:	index of the DMA request
>> + * @ctrl_np:	a device_node pointer to fill in
>> + *
>> + * Returns DMA number along to the dma controller node, or one of the errno
>> + * value on the error condition. If @ctrl_np is not NULL the function also
>> + * fills in the DMA controller device_node pointer.
>> + */
>> +int of_get_dma_request(struct device_node *np, int index,
>> +		       struct device_node **ctrl_np)
>> +{
>> +	int ret = -EINVAL;
>> +	struct of_phandle_args dma_spec;
>> +
>> +	ret = of_parse_phandle_with_args(np, "dma-request", "#dma-cells",
>> +					 index,&dma_spec);
>> +	if (ret) {
>> +		pr_debug("%s: can't parse dma property\n", __func__);
>> +		goto err0;
>> +	}
>> +
>> +	if (dma_spec.args_count>  0)
>> +		ret = dma_spec.args[0];
>> +
>> +	if (ctrl_np)
>> +		*ctrl_np = dma_spec.np;
>> +	else
>> +		of_node_put(dma_spec.np);
>> +
>> +err0:
>> +	pr_debug("%s exited with status %d\n", __func__, ret);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(of_get_dma_request);
>> +
>> +/**
>> + * of_dma_count - Count DMA requests for a device
>> + * @np:		device node to count DMAs for
>> + *
>> + * The function returns the count of DMA requests specified for a node.
>> + *
>> + * Note that the empty DMA specifiers counts too. For example,
>> + *
>> + * dma-request =<0
>> + *&sdma 1
>> + *                0
>> + *&sdma 3>;
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
>> +		/* A hole in the dma-request =<>  counts anyway. */
>> +		if (ret<  0&&  ret != -EEXIST)
>> +			break;
>> +	} while (++cnt);
>> +
>> +	return cnt;
>> +}
>> +EXPORT_SYMBOL(of_dma_count);
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
>> +
>> +	if (!r)
>> +		return -EINVAL;
>> +
>> +	dma = of_get_dma_request(dev, index, NULL);
>> +	if (dma<  0)
>> +		return dma;
>> +
>> +	/*
>> +	 * Get optional "dma-request-names" property to add a name
>> +	 * to the resource.
>> +	 */
>> +	of_property_read_string_index(dev, "dma-request-names", index,
>> +				&name);
>> +
>> +	r->start = dma;
>> +	r->end = dma;
>> +	r->flags = IORESOURCE_DMA;
>> +	r->name = name ? name : dev->full_name;
>> +
>> +	return dma;
>> +}
>> +EXPORT_SYMBOL_GPL(of_dma_to_resource);
>> diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
>> new file mode 100644
>> index 0000000..575163d
>> --- /dev/null
>> +++ b/include/linux/of_dma.h
>> @@ -0,0 +1,49 @@
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
>> +#include<linux/of.h>
>> +
>> +struct device_node;
>> +
>> +#ifdef CONFIG_OF_GPIO
>> +
>> +extern int of_get_dma_request(struct device_node *np, int index,
>> +		       struct device_node **ctrl_np);
>> +extern unsigned int of_dma_count(struct device_node *np);
>> +extern int of_dma_to_resource(struct device_node *dev, int index,
>> +			      struct resource *r);
>> +
>> +#else /* CONFIG_OF_DMA */
>> +
>> +static int of_get_dma_request(struct device_node *np, int index,
>> +			      struct device_node **ctrl_np);
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
>> +#endif /* CONFIG_OF_DMA */
>> +
>> +#endif /* __LINUX_OF_DMA_H */
>
>

