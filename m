From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC 01/11] drivers: reset: TI: SoC reset controller support.
Date: Wed, 30 Apr 2014 12:50:54 -0500
Message-ID: <536137FE.2070300@ti.com>
References: <1398802790-29287-1-git-send-email-dmurphy@ti.com>	 <1398802790-29287-2-git-send-email-dmurphy@ti.com> <1398846045.19894.16.camel@paszta.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40813 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945934AbaD3Rv2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Apr 2014 13:51:28 -0400
In-Reply-To: <1398846045.19894.16.camel@paszta.hi.pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, devicetree@vger.kernel.org, t-kristo@ti.com, s-anna@ti.com

Philipp and Arnd

Thank you for the comments

On 04/30/2014 03:20 AM, Philipp Zabel wrote:
> Hi Dan,
>
> Am Dienstag, den 29.04.2014, 15:19 -0500 schrieb Dan Murphy:
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
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>  drivers/reset/Kconfig            |    1 +
>>  drivers/reset/Makefile           |    1 +
>>  drivers/reset/ti/Kconfig         |    8 ++
>>  drivers/reset/ti/Makefile        |    1 +
>>  drivers/reset/ti/reset-ti-data.h |   58 ++++++++++++
>>  drivers/reset/ti/reset-ti.c      |  195 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/reset_ti.h         |   25 +++++
>>  7 files changed, 289 insertions(+)
>>  create mode 100644 drivers/reset/ti/Kconfig
>>  create mode 100644 drivers/reset/ti/Makefile
>>  create mode 100644 drivers/reset/ti/reset-ti-data.h
>>  create mode 100644 drivers/reset/ti/reset-ti.c
>>  create mode 100644 include/linux/reset_ti.h
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
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 4f60caf..1c8c444 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -1,3 +1,4 @@
>>  obj-$(CONFIG_RESET_CONTROLLER) += core.o
>>  obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
>>  obj-$(CONFIG_ARCH_STI) += sti/
>> +obj-$(CONFIG_RESET_TI) += ti/
>> diff --git a/drivers/reset/ti/Kconfig b/drivers/reset/ti/Kconfig
>> new file mode 100644
>> index 0000000..dcdce90
>> --- /dev/null
>> +++ b/drivers/reset/ti/Kconfig
>> @@ -0,0 +1,8 @@
>> +config RESET_TI
>> +	depends on RESET_CONTROLLER
>> +	bool "TI reset controller"
>> +	help
>> +	  Reset controller support for TI SoC's
>> +
>> +	  Reset controller found in TI's AM series of SoC's like
>> +	  AM335x and AM43x and OMAP SoC's like OMAP5 and DRA7
>> diff --git a/drivers/reset/ti/Makefile b/drivers/reset/ti/Makefile
>> new file mode 100644
>> index 0000000..55ab3f5
>> --- /dev/null
>> +++ b/drivers/reset/ti/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_RESET_TI) += reset-ti.o
>> diff --git a/drivers/reset/ti/reset-ti-data.h b/drivers/reset/ti/reset-ti-data.h
>> new file mode 100644
>> index 0000000..6afdf37
>> --- /dev/null
>> +++ b/drivers/reset/ti/reset-ti-data.h
>> @@ -0,0 +1,58 @@
>> +/*
>> + * PRCM reset driver for TI SoC's
>> + *
>> + * Copyright 2014 Texas Instruments Inc.
>> + *
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
>> +#include <linux/of_device.h>
>> +#include <linux/reset-controller.h>
>> +
>> +/**
>> + * struct ti_reset_reg_data - Structure of the reset register information
>> + * 	for a particular SoC.
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
>> +	u32	rstctrl_offs;
>> +	u32	rstst_offs;
>> +	u8	rstctrl_bit;
>> +	u8	rstst_bit;
> You are only ever using these as (1 << rstctrl_bit) and as
> (1 << rstst_bit). You could store the mask here directly,
> like the regulator framework does.
>

Yes we can store the mask as opposed to the bit.
I will look into it for v2.

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
>     trailing whitespace

Got it will fix v2.

>> + */
>> +struct ti_reset_data {
>> +	struct ti_reset_reg_data *reg_data;
>> +	struct reset_controller_dev rcdev;
>> +	void __iomem *reg_base;
>> +	u8	nr_resets;
>> +};
>> +
>> +#endif
>> diff --git a/drivers/reset/ti/reset-ti.c b/drivers/reset/ti/reset-ti.c
>> new file mode 100644
>> index 0000000..1d38069
>> --- /dev/null
>> +++ b/drivers/reset/ti/reset-ti.c
>> @@ -0,0 +1,195 @@
>> +/*
>> + * PRCM reset driver for TI SoC's
>> + *
>> + * Copyright 2014 Texas Instruments Inc.
>> + *
>> + * Author: Dan Murphy <dmurphy@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/slab.h>
>> +
>> +#include <linux/reset_ti.h>
>> +#include <linux/reset.h>
>> +
>> +#include "reset-ti-data.h"
>> +
>> +static void ti_reset_wait_on_reset(struct reset_controller_dev *rcdev,
>> +			       unsigned long id)
>> +{
>> +	struct ti_reset_data *reset_data = container_of(rcdev,
>> +													struct ti_reset_data,
>> +													rcdev);
> Please consider taking a few steps to the left.

Got it will fix v2.

>
>> +	void __iomem *status_reg;
>> +	u32 val = 0;
>> +	u8 status_bit = 0;
>> +
>> +	if (id < 0) {
>> +		pr_err("%s: ID passed is invalid\n", __func__);
>> +		return;
>> +	}
>> +
>> +	/* Clear the reset status bit to reflect the current status */
>> +	status_reg = reset_data->reg_base + reset_data->reg_data[id].rstst_offs;
>> +	status_bit = reset_data->reg_data[id].rstst_bit;
>> +	do {
>> +		val = readl(status_reg);
>> +		if (!(val & (1 << status_bit)))
>> +			break;
>> +	} while (1);
> Is the status bit guaranteed to clear after a few cycles?

I will look into this question

>> +}
>> +
>> +static int ti_reset_assert(struct reset_controller_dev *rcdev,
>> +			       unsigned long id)
>> +{
>> +	struct ti_reset_data *reset_data = container_of(rcdev,
>> +													struct ti_reset_data,
>> +													rcdev);
> Very long lines again.

Yep.  Will fix v2 copy/paste problem

>
>> +	void __iomem *reg;
>> +	void __iomem *status_reg;
>> +	u32 val = 0;
>> +	u8 bit = 0;
>> +	u8 status_bit = 0;
>> +
>> +	if (id < 0) {
> The id parameter is _unsigned_ long.

OK got it.

>
>> +		pr_err("%s: ID passed is invalid\n", __func__);
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Clear the reset status bit to reflect the current status */
>> +	status_reg = reset_data->reg_base + reset_data->reg_data[id].rstst_offs;
>> +	status_bit = reset_data->reg_data[id].rstst_bit;
>> +	writel(1 << status_bit, status_reg);
> See the first comment, all the left shifts could be done by the compiler
> if you store the bit mask instead of the bit offset.

Per my reply I will look into this

>
>> +	reg = reset_data->reg_base + reset_data->reg_data[id].rstctrl_offs;
>> +	bit = reset_data->reg_data[id].rstctrl_bit;
>> +	val = readl(reg);
>> +	if (!(val & (1 << bit))) {
>> +		val |= (1 << bit);
>> +		writel(val, reg);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_reset_deassert(struct reset_controller_dev *rcdev,
>> +			       unsigned long id)
>> +{
>> +
>> +	struct ti_reset_data *reset_data;
>> +	void __iomem *reg;
>> +	void __iomem *status_reg;
>> +	u32 val = 0;
>> +	u8 bit = 0;
>> +	u8 status_bit = 0;
>> +
>> +	if (id < 0) {
> Again, unsigned.
>
>> +		pr_err("%s: reset ID passed is invalid\n", __func__);
>> +		return -ENODEV;
>> +	}
>> +
>> +	reset_data = container_of(rcdev, struct ti_reset_data, rcdev);
>> +
>> +	/* Clear the reset status bit to reflect the current status */
>> +	status_reg = reset_data->reg_base + reset_data->reg_data[id].rstst_offs;
>> +	status_bit = reset_data->reg_data[id].rstst_bit;
>> +	writel(1 << status_bit, status_reg);
>> +
>> +	reg = reset_data->reg_base + reset_data->reg_data[id].rstctrl_offs;
>> +	bit = reset_data->reg_data[id].rstctrl_bit;
>> +	val = readl(reg);
>> +	if (val & (1 << bit)) {
>> +		val &= ~(1 << bit);
>> +		writel(val, reg);
>> +	}
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
>> +static struct reset_control_ops ti_reset_ops = {
>> +	.reset = ti_reset_reset,
>> +	.assert = ti_reset_assert,
>> +	.deassert = ti_reset_deassert,
>> +};
>> +
>> +static const struct of_device_id ti_reset_of_match[] = {
>> +	{},
>> +};
>> +
>> +const struct of_device_id *ti_reset_get_data(struct device_node *parent)
>> +{
>> +	const struct of_device_id *dev_node;
>> +
>> +	dev_node = of_match_node(ti_reset_of_match, parent);
>> +	if (!dev_node) {
>> +		pr_err("%s: No compatible for resets for %s\n",
>> +			__func__, parent->name);
>> +		return NULL;
>> +	}
>> +
>> +	return dev_node;
>> +}
>> +
>> +void __init ti_dt_reset_init(void)
> Is there a reason not to just register this as a platform device?

To answer this comment as well as Arnd's.  To be honest this was a remnant of my development.
You are both correct and this can be called during the init as a platform driver.

I will fix this in v2.  Which will in turn remove one patch as well as a header file.

Dan

<snip>


-- 
------------------
Dan Murphy

