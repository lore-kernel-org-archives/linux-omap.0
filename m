From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 21/33] CLK: OMAP: DPLL: add omap3 dpll support
Date: Wed, 31 Jul 2013 18:03:52 +0300
Message-ID: <51F92758.20405@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-22-git-send-email-t-kristo@ti.com> <51F81D3A.7080007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51395 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169Ab3GaPEW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Jul 2013 11:04:22 -0400
In-Reply-To: <51F81D3A.7080007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 07/30/2013 11:08 PM, Nishanth Menon wrote:
> On 07/23/2013 02:20 AM, Tero Kristo wrote:
>> OMAP3 has slightly different DPLLs from those compared to OMAP4. Modified
>> code for the same.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/clk/omap/dpll.c |   96
>> +++++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 85 insertions(+), 11 deletions(-)
>>
> :) wont repeat the binding crib again..
>
>> diff --git a/drivers/clk/omap/dpll.c b/drivers/clk/omap/dpll.c
>> index d8a958a..ecb1fbd 100644
>> --- a/drivers/clk/omap/dpll.c
>> +++ b/drivers/clk/omap/dpll.c
>> @@ -26,6 +26,11 @@
>>   #include <linux/of_address.h>
>>   #include <linux/clk/omap.h>
>>
>> +enum {
>> +    SUBTYPE_OMAP3_DPLL,
>> +    SUBTYPE_OMAP4_DPLL,
>> +};
>> +
>>   static const struct clk_ops dpll_m4xen_ck_ops = {
>>       .enable        = &omap3_noncore_dpll_enable,
>>       .disable    = &omap3_noncore_dpll_disable,
>> @@ -40,6 +45,13 @@ static const struct clk_ops dpll_core_ck_ops = {
>>       .get_parent    = &omap2_init_dpll_parent,
>>   };
>>
>> +static const struct clk_ops omap3_dpll_core_ck_ops = {
>> +    .init        = &omap2_init_clk_clkdm,
>> +    .get_parent    = &omap2_init_dpll_parent,
>> +    .recalc_rate    = &omap3_dpll_recalc,
>> +    .round_rate    = &omap2_dpll_round_rate,
>> +};
>> +
>>   static const struct clk_ops dpll_ck_ops = {
>>       .enable        = &omap3_noncore_dpll_enable,
>>       .disable    = &omap3_noncore_dpll_disable,
>> @@ -50,6 +62,26 @@ static const struct clk_ops dpll_ck_ops = {
>>       .init        = &omap2_init_clk_clkdm,
>>   };
>>
>> +static const struct clk_ops omap3_dpll_ck_ops = {
>> +    .init        = &omap2_init_clk_clkdm,
>> +    .enable        = &omap3_noncore_dpll_enable,
>> +    .disable    = &omap3_noncore_dpll_disable,
>> +    .get_parent    = &omap2_init_dpll_parent,
>> +    .recalc_rate    = &omap3_dpll_recalc,
>> +    .set_rate    = &omap3_noncore_dpll_set_rate,
>> +    .round_rate    = &omap2_dpll_round_rate,
>> +};
>> +
>> +static const struct clk_ops omap3_dpll_per_ck_ops = {
>> +    .init        = &omap2_init_clk_clkdm,
>> +    .enable        = &omap3_noncore_dpll_enable,
>> +    .disable    = &omap3_noncore_dpll_disable,
>> +    .get_parent    = &omap2_init_dpll_parent,
>> +    .recalc_rate    = &omap3_dpll_recalc,
>> +    .set_rate    = &omap3_dpll4_set_rate,
>> +    .round_rate    = &omap2_dpll_round_rate,
>> +};
>> +
>>   static const struct clk_ops dpll_x2_ck_ops = {
>>       .recalc_rate    = &omap3_clkoutx2_recalc,
>>   };
>> @@ -144,7 +176,9 @@ struct clk *omap_clk_register_dpll_x2(struct
>> device *dev, const char *name,
>>    * of_omap_dpll_setup() - Setup function for OMAP DPLL clocks
>>    */
>>   static void __init of_omap_dpll_setup(struct device_node *node,
>> -                    const struct clk_ops *ops)
>> +                    const struct clk_ops *ops, u32 freqsel,
>> +                    u32 modes, u8 mul_div_shift,
>> +                    int subtype)
>>   {
>>       struct clk *clk;
>>       const char *clk_name = node->name;
>> @@ -157,8 +191,8 @@ static void __init of_omap_dpll_setup(struct
>> device_node *node,
>>       u32 idlest_mask = 0x1;
>>       u32 enable_mask = 0x7;
>>       u32 autoidle_mask = 0x7;
>> -    u32 mult_mask = 0x7ff << 8;
>> -    u32 div1_mask = 0x7f;
>> +    u32 mult_mask = 0x7ff << (8 + mul_div_shift);
>> +    u32 div1_mask = 0x7f << mul_div_shift;
>>       u32 max_multiplier = 2047;
>>       u32 max_divider = 128;
>>       u32 min_divider = 1;
>> @@ -193,7 +227,7 @@ static void __init of_omap_dpll_setup(struct
>> device_node *node,
>>
>>       clkspec.np = of_parse_phandle(node, "ti,clk-ref", 0);
>>       dd->clk_ref = of_clk_get_from_provider(&clkspec);
>> -    if (!dd->clk_ref) {
>> +    if (IS_ERR(dd->clk_ref)) {
>
> belongs to original patch.

Agree.

>
>>           pr_err("%s: ti,clk-ref for %s not found\n", __func__,
>>               clk_name);
>>           goto cleanup;
>> @@ -201,7 +235,7 @@ static void __init of_omap_dpll_setup(struct
>> device_node *node,
>>
>>       clkspec.np = of_parse_phandle(node, "ti,clk-bypass", 0);
>>       dd->clk_bypass = of_clk_get_from_provider(&clkspec);
>> -    if (!dd->clk_bypass) {
>> +    if (IS_ERR(dd->clk_bypass)) {
>
> same

Ditto.

>
>>           pr_err("%s: ti,clk-bypass for %s not found\n", __func__,
>>               clk_name);
>>           goto cleanup;
>> @@ -225,14 +259,31 @@ static void __init of_omap_dpll_setup(struct
>> device_node *node,
>>       dd->enable_mask = enable_mask;
>>       dd->autoidle_mask = autoidle_mask;
>>
>> -    dd->modes = 0xa0;
>> +    if (!of_property_read_u32(node, "ti,recal-en-bit", &val))
>> +        dd->recal_en_bit = val;
>> +
>> +    if (!of_property_read_u32(node, "ti,recal-st-bit", &val))
>> +        dd->recal_st_bit = val;
>> +
>> +    if (!of_property_read_u32(node, "ti,auto-recal-bit", &val))
>> +        dd->auto_recal_bit = val;
>
> now I understand what it means.

I am not quite sure you do, as I don't quite get your comment here. :) 
You referring to that dd->modes part?

>
>> +
>> +    of_property_read_u32(node, "ti,modes", &modes);
> i see we pass in modes, and read ti,modes to &modes. it is a bit sketchy
> without bindings documentation.

ti,modes can be used to override the default modes.

>
>> +
>> +    dd->modes = modes;
>
> Should have belonged to original patch.

If I squash this then we are fine.

>
>> +
>> +    dd->freqsel_mask = freqsel;
>>
>>       if (of_property_read_bool(node, "ti,dpll-j-type")) {
>>           dd->sddiv_mask = 0xff000000;
>> -        mult_mask = 0xfff << 8;
>> -        div1_mask = 0xff;
>> +        mult_mask = 0xfff << (8 + mul_div_shift);
>>           max_multiplier = 4095;
>> -        max_divider = 256;
>> +        if (subtype == SUBTYPE_OMAP3_DPLL) {
>> +            dd->dco_mask = 0xe00000;
>> +        } else {
>> +            div1_mask = 0xff << mul_div_shift;
>> +            max_divider = 256;
>> +        }
>>       }
>>
>>       if (of_property_read_bool(node, "ti,dpll-regm4xen")) {
>> @@ -281,7 +332,30 @@ static void __init of_omap_dpll_x2_setup(struct
>> device_node *node)
>>
>>   __init void of_omap3_dpll_setup(struct device_node *node)
>>   {
>> -    /* XXX: to be done */
>> +    const struct clk_ops *ops;
>> +    u32 freqsel = 0xf0;
>> +    u32 modes = 0xa0;
>> +    u8 mul_div_shift = 0;
>> +
>> +    ops = &omap3_dpll_ck_ops;
>> +
>> +    if (of_property_read_bool(node, "ti,dpll-core")) {
>> +        ops = &omap3_dpll_core_ck_ops;
>> +        mul_div_shift = 8;
>> +        modes = 0x0;
>> +    }
>> +
>> +    if (of_property_read_bool(node, "ti,dpll-peripheral")) {
>> +        ops = &omap3_dpll_per_ck_ops;
>> +        freqsel = 0xf00000;
>> +    }
>> +
>> +    if (of_property_read_bool(node, "ti,dpll-j-type"))
>> +        freqsel = 0x0;
>> +
>> +    of_omap_dpll_setup(node, ops, freqsel, modes, mul_div_shift,
>> +        SUBTYPE_OMAP3_DPLL);
>> +
>>   }
>>   EXPORT_SYMBOL_GPL(of_omap3_dpll_setup);
>>   CLK_OF_DECLARE(omap3_dpll_clock, "ti,omap3-dpll-clock",
>> of_omap3_dpll_setup);
>> @@ -306,7 +380,7 @@ __init void of_omap4_dpll_setup(struct device_node
>> *node)
>>       if (of_property_read_bool(node, "ti,dpll-no-gate"))
>>           ops = &dpll_no_gate_ck_ops;
>>
>> -    of_omap_dpll_setup(node, ops);
>> +    of_omap_dpll_setup(node, ops, 0, 0xa0, 0, SUBTYPE_OMAP4_DPLL);
> what is 0xa0?

Magic modes for DPLL. I'll copy over the macro def as mentioned in one 
of the previous patches.

>
>>   }
>>   EXPORT_SYMBOL_GPL(of_omap4_dpll_setup);
>>   CLK_OF_DECLARE(omap4_dpll_clock, "ti,omap4-dpll-clock",
>> of_omap4_dpll_setup);
>>
>
> I think this should be squashed and a single dpll.c introduction to be
> done.

Ok.

>
>

