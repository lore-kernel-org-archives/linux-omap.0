From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 02/31] CLK: TI: Add DPLL clock support
Date: Mon, 19 Aug 2013 16:34:45 +0300
Message-ID: <52121EF5.9040706@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com> <1375460751-23676-3-git-send-email-t-kristo@ti.com> <20130813105042.GJ27165@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53155 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705Ab3HSNfX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Aug 2013 09:35:23 -0400
In-Reply-To: <20130813105042.GJ27165@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "nm@ti.com" <nm@ti.com>, "rnayak@ti.com" <rnayak@ti.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 08/13/2013 01:50 PM, Mark Rutland wrote:
> Hi,
>
> On Fri, Aug 02, 2013 at 05:25:21PM +0100, Tero Kristo wrote:
>> The OMAP clock driver now supports DPLL clock type. This patch also
>> adds support for DT DPLL nodes.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   .../devicetree/bindings/clock/ti/dpll.txt          |   70 +++
>>   arch/arm/mach-omap2/clock.h                        |  144 +-----
>>   arch/arm/mach-omap2/clock3xxx.h                    |    2 -
>>   drivers/clk/Makefile                               |    1 +
>>   drivers/clk/ti/Makefile                            |    3 +
>>   drivers/clk/ti/dpll.c                              |  488 ++++++++++++++++++++
>>   include/linux/clk/ti.h                             |  164 +++++++
>>   7 files changed, 727 insertions(+), 145 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/clock/ti/dpll.txt
>>   create mode 100644 drivers/clk/ti/Makefile
>>   create mode 100644 drivers/clk/ti/dpll.c
>>   create mode 100644 include/linux/clk/ti.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Documentation/devicetree/bindings/clock/ti/dpll.txt
>> new file mode 100644
>> index 0000000..dcd6e63
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/ti/dpll.txt
>> @@ -0,0 +1,70 @@
>> +Binding for Texas Instruments DPLL clock.
>> +
>> +This binding uses the common clock binding[1].  It assumes a
>> +register-mapped DPLL with usually two selectable input clocks
>> +(reference clock and bypass clock), with digital phase locked
>> +loop logic for multiplying the input clock to a desired output
>> +clock. This clock also typically supports different operation
>> +modes (locked, low power stop etc.) This binding has several
>> +sub-types, which effectively result in slightly different setup
>> +for the actual DPLL clock.
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Required properties:
>> +- compatible : shall be one of:
>> +               "ti,omap4-dpll-x2-clock",
>> +               "ti,omap3-dpll-clock",
>> +               "ti,omap3-dpll-core-clock",
>> +               "ti,omap3-dpll-per-clock",
>> +               "ti,omap3-dpll-per-j-type-clock",
>> +               "ti,omap4-dpll-clock",
>> +               "ti,omap4-dpll-core-clock",
>> +               "ti,omap4-dpll-m4xen-clock",
>> +               "ti,omap4-dpll-j-type-clock",
>> +               "ti,omap4-dpll-no-gate-clock",
>> +               "ti,omap4-dpll-no-gate-j-type-clock",
>> +
>> +- #clock-cells : from common clock binding; shall be set to 0.
>> +- clocks : link phandles of parent clocks (clk-ref and clk-bypass)
>
> It might be a good idea to use clock-names to clarify which clocks are
> present (I notice your examples contain only one clock input).

All DPLLs have both bypass and reference clocks, but these can be the 
same. Is it better to just list both always (and hence drop 
clock-names), or provide clock-names always?

>
>> +- reg : array of register base addresses for controlling the DPLL (some
>> +  of these can also be left as NULL):
>> +       reg[0] = control register
>> +       reg[1] = idle status register
>> +       reg[2] = autoidle register
>> +       reg[3] = multiplier / divider set register
>
> Are all of these always present? Using reg-names seems sensible here.

Not always, I'll change the code. I am quite new to DT and didn't 
actually know of the existence of reg-names prop.

>
>> +- ti,clk-ref : link phandle for the reference clock
>> +- ti,clk-bypass : link phandle for the bypass clock
>
> You already have these in clocks, why do you need them again here?

Yea good point. Will fix based on the above.

>
>> +
>> +Optional properties:
>> +- ti,modes : available modes for the DPLL
>
> Huh? What type is that property? What does it mean?

Will add some documentation to this.

>
>> +- ti,recal-en-bit : recalibration enable bit
>> +- ti,recal-st-bit : recalibration status bit
>> +- ti,auto-recal-bit : auto recalibration enable bit
>
> These seem rather low-level, but I see other clock bindings are doing
> similar things. When are these needed, and why? What type are they?

Bit shift values for the auto recalibration feature. HOWEVER, it seems 
these are actually legacy, kernel does not have support for these 
anymore if it ever had.... I think I can just drop these for now as they 
are unused by the support code even.

>
>> +- ti,clkdm-name : clockdomain name for the DPLL
>
> Could you elaborate on what this is for? What constitutes a valid name?
>
> I'm not sure a string is the best way to define the linkage of several
> elements to a domain...

Well, I am not sure if we can do this any better at this point, we don't 
have DT nodes for clockdomain at the moment (I am not sure if we will 
have those either as there are only a handful of those per SoC) but I'll 
add some more documentation for this.

>
>> +
>> +Examples:
>> +       dpll_core_ck: dpll_core_ck@44e00490 {
>> +               #clock-cells = <0>;
>> +               compatible = "ti,omap4-dpll-core-clock";
>> +               clocks = <&sys_clkin_ck>;
>> +               reg = <0x44e00490 0x4>, <0x44e0045c 0x4>, <0x0 0x4>,
>> +                               <0x44e00468 0x4>;
>> +               ti,clk-ref = <&sys_clkin_ck>;
>> +               ti,clk-bypass = <&sys_clkin_ck>;
>
> Huh? Why aren't these both in the clocks property?

Will fix based on comments above.

>
> [...]
>
>> +static inline void __iomem *get_dt_register(struct device_node *node,
>> +                                           int index)
>> +{
>> +       u32 val;
>> +
>> +       of_property_read_u32_index(node, "reg", 2 * index, &val);
>> +       if (val)
>> +               return of_iomap(node, index);
>> +       else
>> +               return NULL;
>
> NAK. Use reg-names to handle registers being optional.

Yea will change this.

>
> [...]
>
>> +       clkspec.np = of_parse_phandle(node, "ti,clk-ref", 0);
>> +       dd->clk_ref = of_clk_get_from_provider(&clkspec);
>> +       if (IS_ERR(dd->clk_ref)) {
>> +               pr_err("%s: ti,clk-ref for %s not found\n", __func__,
>> +                      clk_name);
>> +               goto cleanup;
>> +       }
>> +
>> +       clkspec.np = of_parse_phandle(node, "ti,clk-bypass", 0);
>> +       dd->clk_bypass = of_clk_get_from_provider(&clkspec);
>> +       if (IS_ERR(dd->clk_bypass)) {
>> +               pr_err("%s: ti,clk-bypass for %s not found\n", __func__,
>> +                      clk_name);
>> +               goto cleanup;
>> +       }
>
> You can get these from the standard clocks property. Don't do this.
>
> Look at of_clk_get_by_name().

Or of_clk_get(node, index), which would be better?

-Tero

>
> Thanks,
> Mark.
>

