From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 13/43] clk: ti: add support for basic mux clock
Date: Tue, 5 Nov 2013 10:09:28 +0200
Message-ID: <5278A7B8.5020400@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-14-git-send-email-t-kristo@ti.com> <5274169B.70004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33115 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848Ab3KEIJ5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Nov 2013 03:09:57 -0500
In-Reply-To: <5274169B.70004@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 11/01/2013 11:01 PM, Nishanth Menon wrote:
> On 10/25/2013 10:57 AM, Tero Kristo wrote:
> [...]
>> diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
>> new file mode 100644
>> index 0000000..9c5259a
>> --- /dev/null
>> +++ b/drivers/clk/ti/mux.c
> [...]
>> +/**
>> + * of_mux_clk_setup() - Setup function for simple mux rate clock
>> + */
>> +static int of_mux_clk_setup(struct device_node *node, struct regmap *regmap)
>
> $ ./scripts/kernel-doc drivers/clk/ti/mux.c >/dev/null
> Warning(drivers/clk/ti/mux.c:29): No description found for parameter
> 'node'
> Warning(drivers/clk/ti/mux.c:29): No description found for parameter
> 'regmap'
>
> I suggest in the next rev we do a verification if we have kernel doc
> errors as well..
>
>> +{
>> +	struct clk *clk;
>> +	const char *clk_name = node->name;
>> +	void __iomem *reg;
>> +	int num_parents;
>> +	const char **parent_names;
>> +	int i;
>> +	u8 clk_mux_flags = 0;
>> +	u32 mask = 0;
>> +	u32 shift = 0;
>> +	u32 flags = 0;
>> +	u32 val;
>> +
>> +	num_parents = of_clk_get_parent_count(node);
>> +	if (num_parents < 1) {
>> +		pr_err("%s: mux-clock %s must have parent(s)\n",
>> +		       __func__, node->name);
>> +		return -EINVAL;
>> +	}
>> +	parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
>> +	if (!parent_names) {
>> +		pr_err("%s: memory alloc failed\n", __func__);
>
> as discussed, could be dropped.

Yep.

>
>> +		return -ENOMEM;
>> +	}
>> +
>> +	for (i = 0; i < num_parents; i++)
>> +		parent_names[i] = of_clk_get_parent_name(node, i);
>> +
>> +	of_property_read_u32(node, "reg", &val);
>
> is'nt this mandatory? error check?

Will add.

>
>> +	reg = (void *)val;
>> +
>> +	if (of_property_read_u32(node, "ti,bit-shift", &shift)) {
>> +		pr_debug("%s: bit-shift property defaults to 0x%x for %s\n",
>> +			 __func__, shift, node->name);
>
> why a debug if this is optional?

Well, it might be good for debugging if someone forgets the shift when 
he was supposed to add one. I could also make this a required property, 
but this will increase the dtb size slightly, there are quite a few 
mux-clocks around with 0 bit-shift atm.

>
>> +	}
>> +
>> +	if (of_property_read_bool(node, "ti,index-starts-at-one"))
>> +		clk_mux_flags |= CLK_MUX_INDEX_ONE;
>> +
>> +	if (of_property_read_bool(node, "ti,set-rate-parent"))
>> +		flags |= CLK_SET_RATE_PARENT;
>> +
>> +	/* Generate bit-mask based on parent info */
>> +	mask = num_parents;
>> +	if (!(clk_mux_flags & CLK_MUX_INDEX_ONE))
>> +		mask--;
>
> we are assuming there wont be holes in the map (like reserved mux option?)

Yes. Currently this is the case at least, but we can add more beef to 
the binding to handle holes if this comes up in future. Or alternatively 
just add dummy-ck as mux parent and cover the holes that way.

>
>> +
>> +	mask = (1 << fls(mask)) - 1;
>> +
>> +	clk = clk_register_mux_table_regmap(NULL, clk_name, parent_names,
>> +					    num_parents, flags, reg, regmap,
>> +					    shift, mask, clk_mux_flags, NULL,
>> +					    NULL);
>> +
>> +	if (!IS_ERR(clk)) {
>> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
>> +		return 0;
>> +	}
>> +
>
> kfree(parent_names)?

Yea, will add.

>
>> +	return PTR_ERR(clk);
>> +}
>> +CLK_OF_DECLARE(mux_clk, "ti,mux-clock", of_mux_clk_setup);
>> +
>> +static int __init of_ti_composite_mux_clk_setup(struct device_node *node,
>> +						struct regmap *regmap)
>> +{
>> +	struct clk_mux *mux;
>> +	int num_parents;
>> +	int ret;
>> +	u32 val;
>> +
>> +	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
>> +	if (!mux)
>> +		return -ENOMEM;
>> +
>> +	of_property_read_u32(node, "reg", &val);
> is'nt this mandatory? error check?

Will add.

>
>> +
>> +	mux->reg = (void *)val;
>> +	mux->regmap = regmap;
>> +
>> +	if (of_property_read_u32(node, "ti,bit-shift", &val)) {
>> +		pr_debug("%s: no bit-shift for %s, default=0\n",
>> +			 __func__, node->name);
>> +		val = 0;
>> +	}
>> +	mux->shift = val;
>> +
>> +	num_parents = of_clk_get_parent_count(node);
>
> mandatory parameter without check?

Will add.

>
> ti,index-starts-at-one, ti,set-rate-parent
> these seem not supported here even though the bindings dont tell us that.

Yeah, composite-mux-clock documentation is somewhat broken at the 
moment, will look at that.

>
>> +
>> +	mux->mask = num_parents - 1;
>> +	mux->mask = (1 << fls(mux->mask)) - 1;
>> +
>> +	ret = ti_clk_add_component(node, &mux->hw, CLK_COMPONENT_TYPE_MUX);
>> +	if (!ret)
>> +		return 0;
>> +
>> +	kfree(mux);
>> +	return -ret;
>> +}
>> +CLK_OF_DECLARE(ti_composite_mux_clk_setup, "ti,composite-mux-clock",
>> +	       of_ti_composite_mux_clk_setup);
>>
>
>

