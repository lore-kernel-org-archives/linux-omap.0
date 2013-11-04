From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv9 12/43] CLK: TI: add support for clockdomain binding
Date: Mon, 4 Nov 2013 16:30:32 +0200
Message-ID: <5277AF88.7030306@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-13-git-send-email-t-kristo@ti.com> <52740D79.3090107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52740D79.3090107-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/01/2013 10:22 PM, Nishanth Menon wrote:
> On 10/25/2013 10:57 AM, Tero Kristo wrote:
> [...]
>> diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
>> new file mode 100644
>> index 0000000..1b3099e
>> --- /dev/null
>> +++ b/drivers/clk/ti/clockdomain.c
>> @@ -0,0 +1,58 @@
>> +/*
>> + * OMAP clockdomain support
>> + *
>> + * Copyright (C) 2013 Texas Instruments, Inc.
>> + *
>> + * Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
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
>> +static void __init of_ti_clockdomain_setup(struct device_node *node)
>> +{
>> +	struct clk *clk;
>> +	struct clk_hw *clk_hw;
>> +	const char *clkdm_name = node->name;
>> +	int i;
>> +	int num_clks;
>> +
>> +	num_clks = of_count_phandle_with_args(node, "clocks", "#clock-cells");
>> +
>> +	for (i = 0; i < num_clks; i++) {
>> +		clk = of_clk_get(node, i);
>> +		if (__clk_get_flags(clk) & CLK_IS_BASIC) {
>> +			pr_warn("%s: can't setup clkdm for basic clk %s\n",
>> +				__func__, __clk_get_name(clk));
>> +			continue;
>> +		}
>> +		clk_hw = __clk_get_hw(clk);
>> +		to_clk_hw_omap(clk_hw)->clkdm_name = clkdm_name;
>> +		omap2_init_clk_clkdm(clk_hw);
>
> eventually, this can disappear ofcourse.. and that will pave way to
> remove the clock domain data to dts as well.. but yes, we have to find
> a proper home for this away from current location..
>
>> +	}
>> +}
>> +
>> +static struct of_device_id ti_clkdm_match_table[] __initdata = {
>> +	{ .compatible = "ti,clockdomain" },
>> +	{ }
>> +};
>> +
>> +void __init ti_dt_clockdomains_setup(void)
>
> since we are using of_clk_get, it will be good to provide
> documentation w.r.t when the call is expected to be invoked.

I'll add some kerneldoc here.

-Tero

>
>> +{
>> +	struct device_node *np;
>> +	for_each_matching_node(np, ti_clkdm_match_table) {
>> +		of_ti_clockdomain_setup(np);
>> +	}
>> +}
>
>
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
