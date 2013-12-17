From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv10 03/41] CLK: ti: add init support for clock IP blocks
Date: Tue, 17 Dec 2013 10:21:54 +0200
Message-ID: <52B009A2.5000107@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-4-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1312170745360.14039@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50156 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095Ab3LQIW0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 03:22:26 -0500
In-Reply-To: <alpine.DEB.2.02.1312170745360.14039@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 12/17/2013 10:14 AM, Paul Walmsley wrote:
> On Tue, 26 Nov 2013, Tero Kristo wrote:
>
>> ti_dt_clk_init_provider() can now be used to initialize the contents of
>> a single clock IP block. This parses all the clocks under the IP block
>> and calls the corresponding init function for them.
>>
>> This patch also introduces a helper function for the TI clock drivers
>> to get register info from DT and append the master IP info to this.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>
> ...
>
>> diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
>> index ef1a7cd..63f85e9 100644
>> --- a/drivers/clk/ti/clk.c
>> +++ b/drivers/clk/ti/clk.c
>> @@ -19,10 +19,15 @@
>>   #include <linux/clkdev.h>
>>   #include <linux/clk/ti.h>
>>   #include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/list.h>
>>
>>   #undef pr_fmt
>>   #define pr_fmt(fmt) "%s: " fmt, __func__
>>
>> +extern struct of_device_id __clk_of_table[];
>
> This results in a checkpatch.pl warning:
>
> WARNING: externs should be avoided in .c files
> #33: FILE: drivers/clk/ti/clk.c:28:
> +extern struct of_device_id __clk_of_table[];

This extern is only needed from this single file, and this code is 
duplicated from drivers/clk/clk.c.

> Please make sure your patches are checkpatch.pl-clean, with the exception
> of the 80-column warnings and any const-related warnings related to the
> clock framework.
>
>> +static int ti_dt_clk_regmap_index;
>> +
>>   /**
>>    * ti_dt_clocks_register - register DT alias clocks during boot
>>    * @oclks: list of clocks to register
>> @@ -53,3 +58,96 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
>>   		}
>>   	}
>>   }
>> +
>> +typedef int (*ti_of_clk_init_cb_t)(struct device_node *);
>
> Normally typedefs should be a red flag to reviewers due to
> Documentation/CodingStyle chapter 5.  Still it seems this patch is just
> duplicating the way that the CCF does it, so I'm not too worried about it.

This will be removed in next rev, and the standard typedef done by CCF 
will be used instead.

>
>> +
>> +struct clk_init_item {
>> +	int index;
>> +	struct device_node *np;
>> +	ti_of_clk_init_cb_t init_cb;
>> +	struct list_head node;
>> +};
>> +
>> +static LIST_HEAD(retry_list);
>> +
>> +/**
>> + * ti_clk_get_reg_addr - get register address for a clock register
>> + * @node: device node for the clock
>> + * @index: register index from the clock node
>> + *
>> + * Builds clock register address from device tree information. This
>> + * is a struct of type clk_omap_reg.
>> + */
>> +void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index)
>> +{
>> +	struct clk_omap_reg *reg;
>> +	u32 val;
>> +	u32 tmp;
>> +
>> +	reg = (struct clk_omap_reg *)&tmp;
>> +	reg->index = ti_dt_clk_regmap_index;
>> +
>> +	if (of_property_read_u32_index(node, "reg", index, &val)) {
>> +		pr_err("%s must have reg[%d]!\n", node->name, index);
>> +		return NULL;
>> +	}
>> +
>> +	reg->offset = val;
>> +
>> +	return (void __iomem *)tmp;
>> +}
>> +
>> +/**
>> + * ti_dt_clk_init_provider - init master clock provider
>> + * @parent: master node
>> + * @index: internal index for clk_reg_ops
>> + *
>> + * Initializes a master clock IP block and its child clock nodes.
>> + * Regmap is provided for accessing the register space for the
>> + * IP block and all the clocks under it.
>> + */
>> +void ti_dt_clk_init_provider(struct device_node *parent, int index)
>> +{
>> +	const struct of_device_id *match;
>> +	struct device_node *np;
>> +	ti_of_clk_init_cb_t clk_init_cb;
>> +	struct clk_init_item *retry;
>> +	struct clk_init_item *tmp;
>> +	int ret;
>> +
>> +	ti_dt_clk_regmap_index = index;
>> +
>> +	for_each_child_of_node(parent, np) {
>> +		match = of_match_node(__clk_of_table, np);
>> +		if (!match)
>> +			continue;
>> +		clk_init_cb = (ti_of_clk_init_cb_t)match->data;
>> +		pr_debug("%s: initializing: %s\n", __func__, np->name);
>> +		ret = clk_init_cb(np);
>> +		if (ret == -EAGAIN) {
>> +			pr_debug("%s: adding to again list...\n", np->name);
>> +			retry = kzalloc(sizeof(*retry), GFP_KERNEL);
>> +			retry->np = np;
>> +			retry->init_cb = clk_init_cb;
>> +			list_add(&retry->node, &retry_list);
>> +		} else if (ret) {
>> +			pr_err("%s: clock init failed for %s (%d)!\n", __func__,
>> +			       np->name, ret);
>> +		}
>> +	}
>> +
>> +	list_for_each_entry_safe(retry, tmp, &retry_list, node) {
>> +		pr_debug("%s: retry-init: %s\n", __func__, retry->np->name);
>> +		ti_dt_clk_regmap_index = retry->index;
>> +		ret = retry->init_cb(retry->np);
>> +		if (ret == -EAGAIN) {
>> +			pr_debug("%s failed again?\n", retry->np->name);
>
> This is presumably a serious error condition and should be a pr_warn() or
> pr_err(), right?

Not a serious, I think this can happen still if we have dependencies 
towards clocks from other IP blocks which provide clocks (e.g. DPLL uses 
source clocks from both PRM + CM IPs.)

> If retry_list won't be walked again, then it seems best to delete and free
> the list_entry no matter what the return value is from retry->init_cb(),
> since it's not like it will be retried.  Otherwise the code will leak
> memory.

It is actually retried, once the next IP block does its init.

-Tero

>
>> +		} else {
>> +			if (ret)
>> +				pr_err("%s: clock init failed for %s (%d)!\n",
>> +				       __func__, retry->np->name, ret);
>> +			list_del(&retry->node);
>> +			kfree(retry);
>> +		}
>> +	}
>> +}
>> diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
>> index df94c24..d6bf530 100644
>> --- a/include/linux/clk/ti.h
>> +++ b/include/linux/clk/ti.h
>> @@ -36,7 +36,21 @@ struct ti_dt_clk {
>>   		.node_name = name,	\
>>   	}
>>
>> +/* Maximum number of clock regmaps */
>> +#define CLK_MAX_REGMAPS			4
>>
>> +/**
>> + * struct clk_omap_reg - OMAP register declaration
>> + * @offset: offset from the master IP module base address
>> + * @index: index of the master IP module
>> + */
>> +struct clk_omap_reg {
>> +	u16 offset;
>> +	u16 index;
>> +};
>> +
>> +void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
>>   void ti_dt_clocks_register(struct ti_dt_clk *oclks);
>> +void ti_dt_clk_init_provider(struct device_node *np, int index);
>>
>>   #endif
>> --
>> 1.7.9.5
>>
>
>
> - Paul
>

