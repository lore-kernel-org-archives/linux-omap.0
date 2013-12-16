From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv10 10/41] CLK: TI: add support for clockdomain binding
Date: Mon, 16 Dec 2013 10:13:08 +0200
Message-ID: <52AEB614.3080705@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-11-git-send-email-t-kristo@ti.com> <20131215042303.23538.19248@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41315 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402Ab3LPINf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Dec 2013 03:13:35 -0500
In-Reply-To: <20131215042303.23538.19248@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 12/15/2013 06:23 AM, Mike Turquette wrote:
> Quoting Tero Kristo (2013-11-26 00:05:51)
>> Some OMAP clocks require knowledge about their parent clockdomain for
>> book keeping purposes. This patch creates a new DT binding for TI
>> clockdomains, which act as a collection of device clocks.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   .../devicetree/bindings/clock/ti/clockdomain.txt   |   21 ++++++
>>   arch/arm/mach-omap2/clock.h                        |    1 -
>>   drivers/clk/ti/Makefile                            |    3 +-
>>   drivers/clk/ti/clockdomain.c                       |   70 ++++++++++++++++++++
>>   include/linux/clk/ti.h                             |    3 +
>>   5 files changed, 96 insertions(+), 2 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/clock/ti/clockdomain.txt
>>   create mode 100644 drivers/clk/ti/clockdomain.c
>>
>> diff --git a/Documentation/devicetree/bindings/clock/ti/clockdomain.txt b/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
>> new file mode 100644
>> index 0000000..45e6f7c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
>> @@ -0,0 +1,21 @@
>> +Binding for Texas Instruments clockdomain.
>> +
>> +Binding status: Unstable - ABI compatibility may be broken in the future
>> +
>> +This binding uses the common clock binding[1]. Every clock on
>
> The patch looks fine to me but I think that the binding description
> should capture the fact that you are re-using the common clock binding
> but that this binding definition does not define any new clocks or clock
> controllers in the way that a typical clock binding would.
>
> This code uses the 'clocks' property the same way that any other
> consumer binding definition would, such as an MMC controller or UART.
> Those bindings do not say that they are based on the common clock
> binding AFAIK.
>

Ok, will modify the doc accordingly.

-Tero

> Regards,
> Mike
>
>> +TI SoC belongs to one clockdomain, but software only needs this
>> +information for specific clocks which require their parent
>> +clockdomain to be controlled when the clock is enabled/disabled.
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Required properties:
>> +- compatible : shall be "ti,clockdomain"
>> +- #clock-cells : from common clock binding; shall be set to 0.
>> +- clocks : link phandles of clocks within this domain
>> +
>> +Examples:
>> +       dss_clkdm: dss_clkdm {
>> +               compatible = "ti,clockdomain";
>> +               clocks = <&dss1_alwon_fck_3430es2>, <&dss_ick_3430es2>;
>> +       };
>> diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
>> index bc0f9fc..6bd72b5 100644
>> --- a/arch/arm/mach-omap2/clock.h
>> +++ b/arch/arm/mach-omap2/clock.h
>> @@ -38,7 +38,6 @@ struct omap_clk {
>>          }
>>
>>   struct clockdomain;
>> -#define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
>>
>>   #define DEFINE_STRUCT_CLK(_name, _parent_array_name, _clkops_name)     \
>>          static struct clk _name = {                             \
>> diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
>> index 7cba389..67056fb 100644
>> --- a/drivers/clk/ti/Makefile
>> +++ b/drivers/clk/ti/Makefile
>> @@ -1,4 +1,5 @@
>>   ifneq ($(CONFIG_OF),)
>>   obj-y                                  += clk.o dpll.o autoidle.o divider.o \
>> -                                          fixed-factor.o gate.o composite.o
>> +                                          fixed-factor.o gate.o clockdomain.o \
>> +                                          composite.o
>>   endif
>> diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
>> new file mode 100644
>> index 0000000..f1e0038
>> --- /dev/null
>> +++ b/drivers/clk/ti/clockdomain.c
>> @@ -0,0 +1,70 @@
>> +/*
>> + * OMAP clockdomain support
>> + *
>> + * Copyright (C) 2013 Texas Instruments, Inc.
>> + *
>> + * Tero Kristo <t-kristo@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/slab.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/clk/ti.h>
>> +
>> +#undef pr_fmt
>> +#define pr_fmt(fmt) "%s: " fmt, __func__
>> +
>> +static void __init of_ti_clockdomain_setup(struct device_node *node)
>> +{
>> +       struct clk *clk;
>> +       struct clk_hw *clk_hw;
>> +       const char *clkdm_name = node->name;
>> +       int i;
>> +       int num_clks;
>> +
>> +       num_clks = of_count_phandle_with_args(node, "clocks", "#clock-cells");
>> +
>> +       for (i = 0; i < num_clks; i++) {
>> +               clk = of_clk_get(node, i);
>> +               if (__clk_get_flags(clk) & CLK_IS_BASIC) {
>> +                       pr_warn("can't setup clkdm for basic clk %s\n",
>> +                               __clk_get_name(clk));
>> +                       continue;
>> +               }
>> +               clk_hw = __clk_get_hw(clk);
>> +               to_clk_hw_omap(clk_hw)->clkdm_name = clkdm_name;
>> +               omap2_init_clk_clkdm(clk_hw);
>> +       }
>> +}
>> +
>> +static struct of_device_id ti_clkdm_match_table[] __initdata = {
>> +       { .compatible = "ti,clockdomain" },
>> +       { }
>> +};
>> +
>> +/**
>> + * ti_dt_clockdomains_setup - setup device tree clockdomains
>> + *
>> + * Initializes clockdomain nodes for a SoC. This parses through all the
>> + * nodes with compatible = "ti,clockdomain", and add the clockdomain
>> + * info for all the clocks listed under these. This function shall be
>> + * called after rest of the DT clock init has completed and all
>> + * clock nodes have been registered.
>> + */
>> +void __init ti_dt_clockdomains_setup(void)
>> +{
>> +       struct device_node *np;
>> +       for_each_matching_node(np, ti_clkdm_match_table) {
>> +               of_ti_clockdomain_setup(np);
>> +       }
>> +}
>> diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
>> index 872ff2a..231b071 100644
>> --- a/include/linux/clk/ti.h
>> +++ b/include/linux/clk/ti.h
>> @@ -204,6 +204,8 @@ struct clk_omap_reg {
>>          u16 index;
>>   };
>>
>> +#define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
>> +
>>   void omap2_init_clk_hw_omap_clocks(struct clk *clk);
>>   int omap3_noncore_dpll_enable(struct clk_hw *hw);
>>   void omap3_noncore_dpll_disable(struct clk_hw *hw);
>> @@ -232,6 +234,7 @@ int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
>>   void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
>>   void ti_dt_clocks_register(struct ti_dt_clk *oclks);
>>   void ti_dt_clk_init_provider(struct device_node *np, int index);
>> +void ti_dt_clockdomains_setup(void);
>>   int of_ti_clk_autoidle_setup(struct device_node *node);
>>   int ti_clk_add_component(struct device_node *node, struct clk_hw *hw, int type);
>>
>> --
>> 1.7.9.5
>>

