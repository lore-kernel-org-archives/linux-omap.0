From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv9 11/43] CLK: TI: add support for gate clock
Date: Mon, 4 Nov 2013 14:23:06 +0200
Message-ID: <527791AA.6090908@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-12-git-send-email-t-kristo@ti.com> <52740AFB.5050706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41037 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789Ab3KDMXi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Nov 2013 07:23:38 -0500
In-Reply-To: <52740AFB.5050706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 11/01/2013 10:11 PM, Nishanth Menon wrote:
> On 10/25/2013 10:57 AM, Tero Kristo wrote:
>> This patch adds support for TI specific gate clocks. These behave as basic
>> gate-clock, but have different ops / hw-ops for controlling the actual
>> gate, for example waiting until the clock is ready. Several sub-types
>> are supported:
>> - ti,gate-clock: basic gate clock with default ops/hwops
>> - ti,clkdm-gate-clock: clockdomain level gate control
>> - ti,dss-gate-clock: gate clock with DSS specific hardware handling
>> - ti,am35xx-gate-clock: gate clock with AM35xx specific hardware handling
>> - ti,hsdiv-gate-clock: gate clock with OMAP36xx hardware errata handling
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   .../devicetree/bindings/clock/ti/gate.txt          |   77 ++++++
>>   arch/arm/mach-omap2/clock.h                        |   29 ---
>>   drivers/clk/ti/Makefile                            |    2 +-
>>   drivers/clk/ti/gate.c                              |  258 ++++++++++++++++++++
>>   include/linux/clk/ti.h                             |   36 +++
>>   5 files changed, 372 insertions(+), 30 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/clock/ti/gate.txt
>>   create mode 100644 drivers/clk/ti/gate.c
>>
>> diff --git a/Documentation/devicetree/bindings/clock/ti/gate.txt b/Documentation/devicetree/bindings/clock/ti/gate.txt
>> new file mode 100644
>> index 0000000..18c4d86
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/ti/gate.txt
>> @@ -0,0 +1,77 @@
>> +Binding for Texas Instruments gate clock.
>> +
>> +Binding status: Unstable - ABI compatibility may be broken in the future
>> +
>> +This binding uses the common clock binding[1]. This clock is
>> +quite much similar to the basic gate-clock [2], however,
>> +it supports a number of additional features. If no register
>> +is provided for this clock, the code assumes that a clockdomain
>> +will be controlled instead and the corresponding hw-ops for
>> +that is used.
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +[2] Documentation/devicetree/bindings/clock/gate-clock.txt
>> +[3] Documentation/devicetree/bindings/clock/ti/clockdomain.txt
>
> i think you may want to sequence patch #12 before this if you would
> like to refer to this.

Yea, can re-order based on this. Compiler doesn't really catch issues 
like this. :)

>
>> +
>> +Required properties:
>> +- compatible : shall be one of:
>> +  "ti,gate-clock" - basic gate clock
>> +  "ti,wait-gate-clock" - gate clock which waits until clock is active before
>> +			 returning from clk_enable()
> an example will be nice for this.

Will add.

>
> [...]
>> diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
>> new file mode 100644
>> index 0000000..1a201f8
>> --- /dev/null
>> +++ b/drivers/clk/ti/gate.c
>
> [...]
>> +/**
>> + * omap36xx_gate_clk_enable_with_hsdiv_restore - enable clocks suffering
>> + *         from HSDivider PWRDN problem Implements Errata ID: i556.
>> + * @clk: DPLL output struct clk
>> + *
>> + * 3630 only: dpll3_m3_ck, dpll4_m2_ck, dpll4_m3_ck, dpll4_m4_ck,
>> + * dpll4_m5_ck & dpll4_m6_ck dividers gets loaded with reset
>> + * valueafter their respective PWRDN bits are set.  Any dummy write
>> + * (Any other value different from the Read value) to the
>> + * corresponding CM_CLKSEL register will refresh the dividers.
>> + */
>> +static int omap36xx_gate_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
>> +{
>> +	struct clk_divider *parent;
>> +	struct clk_hw *parent_hw;
>> +	u32 dummy_v, orig_v;
>> +	int ret;
>> +
>> +	/* Clear PWRDN bit of HSDIVIDER */
>> +	ret = omap2_dflt_clk_enable(clk);
>> +
>> +	/* Parent is the x2 node, get parent of parent for the m2 div */
>> +	parent_hw = __clk_get_hw(__clk_get_parent(__clk_get_parent(clk->clk)));
>> +	parent = to_clk_divider(parent_hw);
>> +
>> +	/* Restore the dividers */
>> +	if (!ret) {
>> +		orig_v = __raw_readl(parent->reg);
>> +		dummy_v = orig_v;
>> +
>> +		/* Write any other value different from the Read value */
>> +		dummy_v ^= (1 << parent->shift);
>> +		__raw_writel(dummy_v, parent->reg);
>> +
>> +		/* Write the original divider */
>> +		__raw_writel(orig_v, parent->reg);
>
> i think we already did state that these need to be regmap_updatebits..

Yea.

>
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int __init _of_ti_gate_clk_setup(struct device_node *node,
>> +					const struct clk_ops *ops,
>> +					const struct clk_hw_omap_ops *hw_ops,
>> +					struct regmap *regmap)
>> +{
>> +	struct clk *clk;
>> +	struct clk_init_data init = { NULL };
>> +	struct clk_hw_omap *clk_hw;
>> +	const char *clk_name = node->name;
>> +	const char *parent_name;
>> +	u32 val;
>> +
>> +	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
>> +	if (!clk_hw) {
>> +		pr_err("%s: could not allocate clk_hw_omap\n", __func__);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	clk_hw->hw.init = &init;
>> +
>> +	of_property_read_string(node, "clock-output-names", &clk_name);
>> +
>> +	init.name = clk_name;
>> +	init.ops = ops;
>> +
>> +	if (!of_property_read_u32(node, "reg", &val))
>> +		clk_hw->enable_reg = (void *)val;
>
> seems reg is a mandatory as per bindings for everything other than
> ti,clkdm-gate-clock.. no error handling?

Will add.

>
>> +
>> +	clk_hw->regmap = regmap;
>> +
>> +	if (!of_property_read_u32(node, "ti,bit-shift", &val))
>> +		clk_hw->enable_bit = val;
>
> Again -> bindings state this is mandatory for non ti,clkdm-gate-clock
> clocks. no error handling?

Will add.

>
>> +	clk_hw->ops = hw_ops;
>> +
>> +	parent_name = of_clk_get_parent_name(node, 0);
>> +	init.parent_names = &parent_name;
>> +	init.num_parents = 1;
>
> error checks for parent clk which seems to be mandatory?

Will add.

>
>> +
>> +	if (of_property_read_bool(node, "ti,set-rate-parent"))
>> +		init.flags |= CLK_SET_RATE_PARENT;
>> +
>> +	if (of_property_read_bool(node, "ti,set-bit-to-disable"))
>> +		clk_hw->flags |= INVERT_ENABLE;
>> +
>> +	clk = clk_register(NULL, &clk_hw->hw);
>> +
>> +	if (!IS_ERR(clk)) {
>> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
>> +		return 0;
>> +	}
>> +
>
> free(clk_hw)?

Hmm yea, missing.

>
>> +	return PTR_ERR(clk);
>> +}
>> +
>
>
>

