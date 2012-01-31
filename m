From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC PATCH 1/2] of: Add generic device tree DMA helpers
Date: Tue, 31 Jan 2012 22:26:19 +0100
Message-ID: <4F285C7B.102@ti.com>
References: <4F22DEF2.5000807@ti.com> <20120128180602.GC2501@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53358 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab2AaV0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 16:26:36 -0500
In-Reply-To: <20120128180602.GC2501@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>, Stephen Warren <swarren@nvidia.com>, Thomas Abraham <thomas.abraham@linaro.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Grant,

On 1/28/2012 7:06 PM, Grant Likely wrote:
> On Fri, Jan 27, 2012 at 06:29:22PM +0100, Cousson, Benoit wrote:
>> Add some basic helpers to retrieve a DMA controller device_node
>> and the DMA request line number.
>>
>> For legacy reason another API will export the DMA request number
>> into a Linux resource of type IORESOURCE_DMA.
>> This API is usable only on system with an unique DMA controller.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Rob Herring<rob.herring@calxeda.com>
>
> Hey Benoit.
>
> Good start to this.  Comments below.
>
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
>
> I know gpio and interrupt controllers do this, but I'm not convinced
> it is necessary.  The compatible binding for the device will
> implicitly state that the device is a dma controller and adopts the
> generic dma binding.

That's fine by me, I was just thinking of a mechanism similar to the IRQ 
controller to iterate over the dma controllers at early boot. But I 
guess such approach should become useless with the deferred probe mechanism.

>> +    - #dma-cells: Number of cell for each DMA line, must be one.
>
> Must be one?  Then why bother with the property?

Must be higher that one was the idea, but it looks like from Stephen's 
comment that some simple DMA controller with only one line might even exist.

>
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
>
> Nit: inconsistent indentation (tabs/spaces)... and it looks like
> you've got your tabs set to 4 characters.  All rightstanding coders know
> that the only holy and blessed tab stop is 8 characters, so remind me to
> ridicule that 4 character nonsense out of you the next time we're in
> the same room.>:-}

Outch, I got caught!
I might have argued that this is my Python setting... but in fact the 
PEP8 recommend the usage of 4 spaces... so I do not have any valid 
excuse :-)


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
>
> As Stephen mentioned, the -names should not be required.

Yep, the code is already doing that, the documentation was wrong.

BTW, should it be dma-request or dma-requests?

>
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
>
> This makes the assumption that dma specifiers will only ever be 1
> cell.  I think to be generally useful, the full dma specifier needs to
> be either handed to the dma controller to get a cookie or passed back
> to the caller in its entirety.
>
> I think this function is fine if you want to use it internally in
> OMAP-only device drivers, but doing that way probably ties the OMAP
> drivers to directly access the OMAP dma controllers API instead of
> through dmaengine.

Well it was meant to be generic, but knowing only the OMAP case, I did 
the minimal support to make OMAP, and the two custom DMA bindings I 
found, working.

> To do it generically will require some form of .xlate function like
> with irqs so that the dma controller driver can perform its own
> interpretation of the dma spec.

OK, I'll make that more generic.

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
>
> This is identical to what needs to be done to count gpios and clks.
> Create a generic of_count_phandle_with_args() please.
>
> However, after writing my comments on the function below, this
> function may not actually be needed either.  of_gpio_count isn't used
> by any core code, it is only currently used by spi drivers that want
> to know how many chip selects they have.  Since I don't want to
> resolve DMA references at device registration time, I wonder if there
> is any need for an of_dma_count() function.

Today, I'm using that to build the resource array that will contain the
IORESOURCE_DMA resources for legacy OMAP drivers.

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
>
> How do you see this function being used?  I ask because I don't want
> to add it to the DT device registration code (of_platform_populate()).

Yep, that was the plan :-)

> I actually want to reduce the amount of work being done at device
> registration time and push resolving irqs out to the device drivers.
> The reason for this is so that drivers can resolve irqs supplied by
> other device drivers once I've got deferred probe merged.

That make senses, but that will break all the drivers that are expecting 
IRQ and DMA resources to be already there at probe time. These drivers 
are still relying on the good old platform_get_resource() API.
That will add some extra effort to the drivers migration to DT:-(

> This isn't currently possible because a lot of drivers parse the
> resources table directly.  Those users first need to be migrated to
> use the platform_get_irq*() APIs.

But even in that case, the device should still have the resources 
populated before probe. I'm not sure I fully understand what you mean here.

> DMAs have the same issue, so it is important that device drivers
> resolve the dma specifier at .probe() time so that it can use dma
> channels supplied by a dma device driver.
>
> I suspect having a common of_parse_named_phandle_with_args() will
> useful when needing to resolve named dma resources from device
> drivers.

So it looks like you really have a plan to deprecate all the 
platform_get_resource APIs usage from driver? At least for DMA and IRQ?

Thanks for the feedback,
Benoit
