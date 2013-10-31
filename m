From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv9 04/43] CLK: TI: Add DPLL clock support
Date: Thu, 31 Oct 2013 10:25:02 -0500
Message-ID: <5272764E.6070707@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-5-git-send-email-t-kristo@ti.com> <52726704.5070300@ti.com> <52726F89.4000409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46894 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611Ab3JaPZ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Oct 2013 11:25:29 -0400
In-Reply-To: <52726F89.4000409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 10/31/2013 09:56 AM, Tero Kristo wrote:
> On 10/31/2013 04:19 PM, Nishanth Menon wrote:
>> On 10/25/2013 10:56 AM, Tero Kristo wrote:
>> [...]
>>
>>> diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Documentation/devicetree/bindings/clock/ti/dpll.txt
>>> new file mode 100644
>>> index 0000000..7b87721
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/ti/dpll.txt
[...]

>>
>>> +  ti,am3-* dpll types list the registers in the same order, except "autoidle"
>>> +  register is left out as this hardware does not have it, e.g.:
>>> +	reg = <0x40>, <0x50>, <0x60>;
>>> +  results in following register map:
>>> +	base + 0x40 - control
>>> +	base + 0x50 - idlest
>>> +	base + 0x60 - mult-div1
>>> +
>>> +Optional properties:
>>> +- DPLL mode setting - defining any one or more of the following overrides
>>> +  default setting.
>>> +	- ti,low-power-stop : DPLL supports low power stop mode, gating output
>>> +	- ti,low-power-bypass : DPLL output matches rate of parent bypass clock
>>> +	- ti,lock : DPLL locks in programmed rate
>>
>>> arch/arm/mach-omap2/cclock3xxx_data.c:  .modes          = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
>>> arch/arm/mach-omap2/cclock3xxx_data.c:  .modes          = (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
>>> arch/arm/mach-omap2/cclock3xxx_data.c:  .modes          = (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
>>> arch/arm/mach-omap2/cclock3xxx_data.c:  .modes          = ((1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED) |
>>> arch/arm/mach-omap2/cclock3xxx_data.c:  .modes          = (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
>>> arch/arm/mach-omap2/dpll3xxx.c: _omap3_dpll_write_clken(clk, DPLL_LOCKED);
>>
>> There is no if checks for DPLL_LOCKED which is set with ti,lock,
>> should we just drop it?
> 
> Probably better to keep it in, as there might be some code in future 
> which needs this. Kind of better for readability also, as the field is 
> specified to list the valid modes for the DPLL. One could argue that 
> current kernel code is wrong for _omap3_dpll_write_clken(clk, 
> DPLL_LOCKED) as it does not check if the mode is valid for the DPLL or not.

yep, the thought did cross my mind.

> 
>>
>> [...]
>>> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
>>> new file mode 100644
>>> index 0000000..89733c9
>>> --- /dev/null
>>> +++ b/drivers/clk/ti/dpll.c
>>
>> [...]
>>
>>> +/**
>>> + * ti_clk_register_dpll() - Registers the DPLL clock
>>> + * @name:	Name of the clock node
>>> + * @parent_names: list of parent names
>>> + * @num_parents: num of parents in parent_names
>>> + * @flags:	init flags
>>> + * @dpll_data:	DPLL data
>>> + * @ops:	ops for DPLL
>>> + */
>>> +static struct clk *ti_clk_register_dpll(const char *name,
>>> +					const char **parent_names,
>>> +					int num_parents, unsigned long flags,
>>> +					struct dpll_data *dpll_data,
>>> +					const struct clk_ops *ops,
>>> +					struct regmap *regmap)
>>> +{
>>> +	struct clk *clk;
>>> +	struct clk_init_data init = { NULL };
>>> +	struct clk_hw_omap *clk_hw;
>>> +
>>> +	/* allocate the divider */
>>> +	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
>>> +	if (!clk_hw) {
>>> +		pr_err("%s: could not allocate clk_hw_omap\n", __func__);
>>
>> here and in every other driver - please dont add pr_err for kzalloc
>> not able to allocate, kzalloc will provide the warning anyways.
> 
> Oh it does? Never seen that happen as kzalloc never failed for me. :) 
> However, I can remove these as I don't think they will ever happen anyway.

There have been cleanups such as commit
38bb5253a95f2eb8cb765b7ab88aac686de6cb12 etc.. we dont want to
introduce new ones now.

>>> +	clk_hw->ops = hw_ops;
>>> +	of_property_read_u32(node, "reg", (u32 *)&clk_hw->clksel_reg);
>>> +	clk_hw->regmap = regmap;
>>> +	clk_hw->hw.init = &init;
>>> +
>>> +	init.name = name;
>>> +	init.ops = ops;
>>> +	init.parent_names = &parent_name;
>>> +	init.num_parents = 1;
>>> +
>>> +	/* register the clock */
>>> +	clk = clk_register(NULL, &clk_hw->hw);
>>> +
>>> +	if (IS_ERR(clk))
>>> +		kfree(clk_hw);
>>> +	else
>>> +		omap2_init_clk_hw_omap_clocks(clk);
>>> +
>>> +	return clk;
>>> +}
>>> +#endif
>> [...]
>>> +
>>> +#ifdef CONFIG_ARCH_OMAP3
>>
>> just a mention - I understand we are still in transition and we need
>> these #ifdefs, but eventually, we should be able to make the dpll.c
>> independent of SoC variant #ifdefs.
> 
> Eventually yes. Currently it fails to compile if you do OMAP4 / OMAP5 
> only build, as you don't have the OMAP3 support routines in.
fair enough.


-- 
Regards,
Nishanth Menon
