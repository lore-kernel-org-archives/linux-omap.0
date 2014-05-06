From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC] [v2 Patch 1/6] drivers: reset: TI: SoC reset controller
 support.
Date: Tue, 6 May 2014 08:14:04 -0500
Message-ID: <5368E01C.9000709@ti.com>
References: <1399320567-3639-1-git-send-email-dmurphy@ti.com> <1399320567-3639-2-git-send-email-dmurphy@ti.com> <20140505213306.GA3732@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41760 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbaEFNOb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 May 2014 09:14:31 -0400
In-Reply-To: <20140505213306.GA3732@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com

Felipe

Thanks for the comments

On 05/05/2014 04:33 PM, Felipe Balbi wrote:
> Hi,
>
> On Mon, May 05, 2014 at 03:09:22PM -0500, Dan Murphy wrote:
>> The TI SoC reset controller support utilizes the
>> reset controller framework to give device drivers or
>> function drivers a common set of APIs to call to reset
>> a module.
>>
>> The reset-ti is a common interface to the reset framework.
>>  The register data is retrieved during initialization
>>  of the reset driver through the reset-ti-data
>> file.  The array of data is associated with the compatible from the
>> respective DT entry.
>>
>> Once the data is available then this is derefenced within the common
>> interface.
>>
>> The device driver has the ability to assert, deassert or perform a
>> complete reset.
>>
>> This code was derived from previous work by Rajendra Nayak and Afzal Mohammed.
>> The code was changed to adopt to the reset core and abstract away the SoC information.
> you should break your commit log at around 72 characters at most.

Do you mean 72 characters per line?

>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>  drivers/reset/Kconfig            |    1 +
>>  drivers/reset/Makefile           |    1 +
>>  drivers/reset/ti/Kconfig         |    8 ++
>>  drivers/reset/ti/Makefile        |    1 +
>>  drivers/reset/ti/reset-ti-data.h |   56 ++++++++
>>  drivers/reset/ti/reset-ti.c      |  267 ++++++++++++++++++++++++++++++++++++++
>>  6 files changed, 334 insertions(+)
>>  create mode 100644 drivers/reset/ti/Kconfig
>>  create mode 100644 drivers/reset/ti/Makefile
>>  create mode 100644 drivers/reset/ti/reset-ti-data.h
>>  create mode 100644 drivers/reset/ti/reset-ti.c
>>
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index 0615f50..a58d789 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -13,3 +13,4 @@ menuconfig RESET_CONTROLLER
>>  	  If unsure, say no.
>>  
>>  source "drivers/reset/sti/Kconfig"
>> +source "drivers/reset/ti/Kconfig"
> this driver is so small that I'm not sure you need a directory for it.

Yeah.  Carry over from v1 when we had the object data files which made
things bigger I will put them back.

>
>> diff --git a/drivers/reset/ti/Kconfig b/drivers/reset/ti/Kconfig
>> new file mode 100644
>> index 0000000..dcdce90
>> --- /dev/null
>> +++ b/drivers/reset/ti/Kconfig
>> @@ -0,0 +1,8 @@
>> +config RESET_TI
>> +	depends on RESET_CONTROLLER
> don't you want to depend on ARCH_OMAP || COMPILE_TEST ?

Yes

>
>> diff --git a/drivers/reset/ti/reset-ti-data.h b/drivers/reset/ti/reset-ti-data.h
>> new file mode 100644
>> index 0000000..4d2a6d5
>> --- /dev/null
>> +++ b/drivers/reset/ti/reset-ti-data.h
>> @@ -0,0 +1,56 @@
>> +/*
>> + * PRCM reset driver for TI SoC's
>> + *
>> + * Copyright 2014 Texas Instruments Inc.
> this is not the TI aproved way for copyright notices. Yeah,
> nit-picking...

Hmm.  Will need to look at other TI files to correct then.

>
>> + * Author: Dan Murphy <dmurphy@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef _RESET_TI_DATA_H_
>> +#define _RESET_TI_DATA_H_
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/reset-controller.h>
>> +
>> +/**
>> + * struct ti_reset_reg_data - Structure of the reset register information
>> + *		for a particular SoC.
>> + * @rstctrl_offs: This is the reset control offset value from
>> + *		from the parent reset node.
>> + * @rstst_offs: This is the reset status offset value from
>> + *		from the parent reset node.
>> + * @rstctrl_bit: This is the reset control bit for the module.
>> + * @rstst_bit: This is the reset status bit for the module.
>> + *
>> + * This structure describes the reset register control and status offsets.
>> + * The bits are also defined for the same.
>> + */
>> +struct ti_reset_reg_data {
>> +	void __iomem *reg_base;
>> +	u32	rstctrl_offs;
>> +	u32	rstst_offs;
>> +	u32	rstctrl_bit;
>> +	u32	rstst_bit;
> this structure can be folded into struct ti_reset_data and all of that
> can be initialized during probe.

I could do that.  It will simplify the de-referencing as well.

>> +};
>> +
>> +/**
>> + * struct ti_reset_data - Structure that contains the reset register data
>> + *	as well as the total number of resets for a particular SoC.
>> + * @reg_data:	Pointer to the register data structure.
>> + * @nr_resets:	Total number of resets for the SoC in the reset array.
>> + *
>> + * This structure contains a pointer to the register data and the modules
>> + * register base.  The number of resets and reset controller device data is
>> + * stored within this structure.
>> + *
>> + */
>> +struct ti_reset_data {
>> +	struct ti_reset_reg_data *reg_data;
>> +	struct reset_controller_dev rcdev;
>> +};
>> +
>> +#endif
> this entire file can be moved into the .c file. It's too small and the
> only user for these new types is the .c driver anyway.

This was another carry over from v1 when I had other data within.
So I can collapse this now.

>> diff --git a/drivers/reset/ti/reset-ti.c b/drivers/reset/ti/reset-ti.c
>> new file mode 100644
>> index 0000000..349f4fb
>> --- /dev/null
>> +++ b/drivers/reset/ti/reset-ti.c
>> @@ -0,0 +1,267 @@
>> +/*
>> + * PRCM reset driver for TI SoC's
>> + *
>> + * Copyright 2014 Texas Instruments Inc.
>> + *
>> + * Author: Dan Murphy <dmurphy@ti.com>
> fix copyright notice here too
>
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset.h>
>> +#include <linux/slab.h>
>> +
>> +#include "reset-ti-data.h"
>> +
>> +#define DRIVER_NAME "prcm_reset_ti"
>> +
>> +static struct ti_reset_data *ti_data;
> NAK, you *really* don't need and don't to have this global here. It only
> creates problems. And avoid arguing that "there's only one reset
> controller anyway" because that has bitten us in the past. Also, it's
> not a lot of work to make proper use of dev_set/get_drvdata() and
> container_of() to find your struct ti_reset_data pointer.

Agreed will fix

>
>> +static int ti_reset_get_of_data(struct ti_reset_reg_data *reset_data,
>> +				unsigned long id)
>> +{
>> +	struct device_node *dev_node;
>> +	struct device_node *parent;
>> +	struct device_node *prcm_parent;
>> +	struct device_node *reset_parent;
>> +	int ret = -EINVAL;
>> +
>> +	dev_node = of_find_node_by_phandle((phandle) id);
>> +	if (!dev_node) {
>> +		pr_err("%s: Cannot find phandle node\n", __func__);
> pass a struct device pointer as argument so you can convert these to
> dev_err().

Agreed

>
>> +		return ret;
>> +	}
>> +
>> +	/* node parent */
>> +	parent = of_get_parent(dev_node);
>> +	if (!parent) {
>> +		pr_err("%s: Cannot find parent reset node\n", __func__);
>> +		return ret;
>> +	}
>> +	/* prcm reset parent */
>> +	reset_parent = of_get_next_parent(parent);
>> +	if (!reset_parent) {
>> +		pr_err("%s: Cannot find parent reset node\n", __func__);
>> +		return ret;
>> +	}
>> +	/* PRCM Parent */
>> +	reset_parent = of_get_parent(reset_parent);
>> +	if (!prcm_parent) {
>> +		pr_err("%s: Cannot find parent reset node\n", __func__);
>> +		return ret;
>> +	}
>> +
>> +	reset_data->reg_base = of_iomap(reset_parent, 0);
> please don't. of_iomap() is the stupidest helper in the kernel. Find
> your resource using platform_get_resource() and map it with
> devm_ioremap_resource() since that will properly request_mem_region()
> and correctly map the resource with or without caching.

Thanks for the information.  The reason this is here so that if there are multiple PRCM
modules I can just get the base address for the phandle of interest.

>
>> +	if (!reset_data->reg_base) {
>> +		pr_err("%s: Cannot map reset parent.\n", __func__);
>> +		return ret;
>> +	}
>> +
>> +	ret = of_property_read_u32_index(parent, "reg", 0,
>> +					 &reset_data->rstctrl_offs);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = of_property_read_u32_index(parent, "reg", 1,
>> +					 &reset_data->rstst_offs);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = of_property_read_u32(dev_node, "control-bit",
>> +				   &reset_data->rstctrl_bit);
>> +	if (ret < 0)
>> +		pr_err("%s: No entry in %s for rstst_offs\n", __func__,
>> +			   dev_node->name);
>> +
>> +	ret = of_property_read_u32(dev_node, "status-bit",
>> +				   &reset_data->rstst_bit);
>> +	if (ret < 0)
>> +		pr_err("%s: No entry in %s for rstst_offs\n", __func__,
>> +			   dev_node->name);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ti_reset_wait_on_reset(struct reset_controller_dev *rcdev,
>> +				unsigned long id)
>> +{
> right here you should have:
>
> 	struct ti_reset_data *ti_data = container_of(rcdev,
> 		struct ti_reset_data, rcdev);

I had that in v1.  Should have kept that.
I will change

>
>> +	struct ti_reset_reg_data *temp_reg_data;
>> +	void __iomem *status_reg;
>> +	u32 bit_mask = 0;
>> +	u32 val = 0;
>> +
>> +	temp_reg_data = kzalloc(sizeof(struct ti_reset_reg_data), GFP_KERNEL);
> let's think about this for a second:
>
> user asks for a reset, then ->assert() method gets called, which will
> allocate memory, do some crap, free the allocated memory, then you call
> your ->deassert() method which will, allocate memory, do something, free
> memory, then this method is called which will allocate memory, do
> something, free memory.
>
> Note that *all* of your allocations a) are unnecessary and b) will break
> resets from inside IRQ context...

This made also think that this is not thread safe as this reset calls can be called
from multiple callers so I think a semaphore is order for this function plus the other calls.

>
>> +	ti_reset_get_of_data(temp_reg_data, id);
> this means that *every time* a reset is asserted/deasserted/waited on,
> you will parse *ONE MORE TIME* the DTB. Why ? Why don't you parse it
> once during probe() and cache the results ?

Cache it into what, a list?
I had implemented a list before and received comments do not use a list.  Because you
have to iterate through the list every time.  And a list would need to contain some sort
of indexing agent which defeats the purpose of a phandle.  Then the DTB and kernel images
would have to be in sync for the indexes.

If I put it into an array I run into issues with a bounded array and need to introduce
the index anyway.  So passing the phandle is futile which means I have to introduce the
indexing from the V1 series again.

For my information why is parsing the DTB worse then iterating through a list?
Is there a possibility that the DTB will be over written?


>
>> +	/* Clear the reset status bit to reflect the current status */
>> +	status_reg = temp_reg_data->reg_base + temp_reg_data->rstst_offs;
>> +	bit_mask = temp_reg_data->rstst_bit;
>> +	do {
>> +		val = readl(status_reg);
>> +		if (!(val & (1 << bit_mask)))
>> +			break;
>> +	} while (1);
> also, none of these loops have a timeout. You are creating the
> possibility of hanging the platform completely if the HW misbehaves.

Agreed.  Philip commented on that on v1 I overlooked that comment.

>
>> +static int ti_reset_assert(struct reset_controller_dev *rcdev,
>> +			       unsigned long id)
>> +{
>> +	struct ti_reset_reg_data *temp_reg_data;
>> +	void __iomem *reg;
>> +	void __iomem *status_reg;
>> +	u32 status_bit = 0;
>> +	u32 bit_mask = 0;
>> +	u32 val = 0;
>> +
>> +	temp_reg_data = kzalloc(sizeof(struct ti_reset_reg_data), GFP_KERNEL);
>> +	ti_reset_get_of_data(temp_reg_data, id);
>> +
>> +	/* Clear the reset status bit to reflect the current status */
>> +	status_reg = temp_reg_data->reg_base + temp_reg_data->rstst_offs;
>> +	status_bit = temp_reg_data->rstst_bit;
>> +	writel(1 << status_bit, status_reg);
>> +
>> +	reg = temp_reg_data->reg_base + temp_reg_data->rstctrl_offs;
>> +	bit_mask = temp_reg_data->rstctrl_bit;
>> +	val = readl(reg);
>> +	if (!(val & bit_mask)) {
>> +		val |= bit_mask;
>> +		writel(val, reg);
>> +	}
>> +
>> +	kfree(temp_reg_data);
> same comments as previous callback

Same answer here

>
>> +	return 0;
>> +}
>> +
>> +static int ti_reset_deassert(struct reset_controller_dev *rcdev,
>> +			       unsigned long id)
>> +{
>> +
>> +	struct ti_reset_reg_data *temp_reg_data;
>> +	void __iomem *reg;
>> +	void __iomem *status_reg;
>> +	u32 status_bit = 0;
>> +	u32 bit_mask = 0;
>> +	u32 val = 0;
>> +
>> +	temp_reg_data = kzalloc(sizeof(struct ti_reset_reg_data), GFP_KERNEL);
>> +	ti_reset_get_of_data(temp_reg_data, id);
>> +
>> +	/* Clear the reset status bit to reflect the current status */
>> +	status_reg = temp_reg_data->reg_base + temp_reg_data->rstst_offs;
>> +	status_bit = temp_reg_data->rstst_bit;
>> +	writel(1 << status_bit, status_reg);
>> +
>> +	reg = temp_reg_data->reg_base + temp_reg_data->rstctrl_offs;
>> +	bit_mask = temp_reg_data->rstctrl_bit;
>> +	val = readl(reg);
>> +	if (val & bit_mask) {
>> +		val &= ~bit_mask;
>> +		writel(val, reg);
>> +	}
> and here. Also, this is leaking temp_reg_data.

and here

>
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_reset_reset(struct reset_controller_dev *rcdev,
>> +				  unsigned long id)
>> +{
>> +	ti_reset_assert(rcdev, id);
>> +	ti_reset_deassert(rcdev, id);
>> +	ti_reset_wait_on_reset(rcdev, id);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_reset_xlate(struct reset_controller_dev *rcdev,
>> +			const struct of_phandle_args *reset_spec)
>> +{
>> +	struct device_node *dev_node;
>> +
>> +	if (WARN_ON(reset_spec->args_count != rcdev->of_reset_n_cells))
>> +		return -EINVAL;
>> +
>> +	/* Verify that the phandle exists */
>> +	dev_node = of_find_node_by_phandle((phandle) reset_spec->args[0]);
>> +	if (!dev_node) {
>> +		pr_err("%s: Cannot find phandle node\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return reset_spec->args[0];
>> +}
>> +
>> +static struct reset_control_ops ti_reset_ops = {
>> +	.reset = ti_reset_reset,
>> +	.assert = ti_reset_assert,
>> +	.deassert = ti_reset_deassert,
>> +};
>> +
>> +static int ti_reset_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *resets;
> here you should have something like:
>
> 	struct ti_reset_data *ti_data;
>
> 	[...]
>
> 	ti_data = devm_kzalloc(sizeof(*ti_data), GFP_KERNEL);
> 	if (!ti_data)
> 		return -ENOMEM;
>
> 	platform_get_resource(...);
>
> 	ti_data->base = devm_ioremap_resource(res);
> 	if (IS_ERR(ti_data->base))
> 		return PTR_ERR(ti_data->base);
>
> 	platform_set_drvdata(pdev, ti_data);

agreed.  Did not think of this when I made this a module.

>
>> +	resets = of_find_node_by_name(NULL, "resets");
>> +	if (!resets) {
>> +		pr_err("%s: missing 'resets' child node.\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ti_data = kzalloc(sizeof(*ti_data), GFP_KERNEL);
>> +	if (!ti_data)
>> +		return -ENOMEM;
>> +
>> +	ti_data->rcdev.owner = THIS_MODULE;
>> +	ti_data->rcdev.of_node = resets;
>> +	ti_data->rcdev.ops = &ti_reset_ops;
>> +
>> +	ti_data->rcdev.of_reset_n_cells = 1;
>> +	ti_data->rcdev.of_xlate = &ti_reset_xlate;
>> +
>> +	reset_controller_register(&ti_data->rcdev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_reset_remove(struct platform_device *pdev)
>> +{
> and here:
>
> 	struct ti_reset_data *ti_data = platform_get_drvdata(pdev);
>
> 	reset_controller_unregister(&ti_data->rcdev);
>
>> +	reset_controller_unregister(&ti_data->rcdev);
>> +
>> +	return 0;
>> +}


-- 
------------------
Dan Murphy

