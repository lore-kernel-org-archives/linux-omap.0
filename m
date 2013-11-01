From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv9 12/43] CLK: TI: add support for clockdomain binding
Date: Fri, 1 Nov 2013 15:22:17 -0500
Message-ID: <52740D79.3090107@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com> <1382716658-6964-13-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32939 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab3KAUWn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Nov 2013 16:22:43 -0400
In-Reply-To: <1382716658-6964-13-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 10/25/2013 10:57 AM, Tero Kristo wrote:
[...]
> diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
> new file mode 100644
> index 0000000..1b3099e
> --- /dev/null
> +++ b/drivers/clk/ti/clockdomain.c
> @@ -0,0 +1,58 @@
> +/*
> + * OMAP clockdomain support
> + *
> + * Copyright (C) 2013 Texas Instruments, Inc.
> + *
> + * Tero Kristo <t-kristo@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/clk/ti.h>
> +
> +static void __init of_ti_clockdomain_setup(struct device_node *node)
> +{
> +	struct clk *clk;
> +	struct clk_hw *clk_hw;
> +	const char *clkdm_name = node->name;
> +	int i;
> +	int num_clks;
> +
> +	num_clks = of_count_phandle_with_args(node, "clocks", "#clock-cells");
> +
> +	for (i = 0; i < num_clks; i++) {
> +		clk = of_clk_get(node, i);
> +		if (__clk_get_flags(clk) & CLK_IS_BASIC) {
> +			pr_warn("%s: can't setup clkdm for basic clk %s\n",
> +				__func__, __clk_get_name(clk));
> +			continue;
> +		}
> +		clk_hw = __clk_get_hw(clk);
> +		to_clk_hw_omap(clk_hw)->clkdm_name = clkdm_name;
> +		omap2_init_clk_clkdm(clk_hw);

eventually, this can disappear ofcourse.. and that will pave way to
remove the clock domain data to dts as well.. but yes, we have to find
a proper home for this away from current location..

> +	}
> +}
> +
> +static struct of_device_id ti_clkdm_match_table[] __initdata = {
> +	{ .compatible = "ti,clockdomain" },
> +	{ }
> +};
> +
> +void __init ti_dt_clockdomains_setup(void)

since we are using of_clk_get, it will be good to provide
documentation w.r.t when the call is expected to be invoked.

> +{
> +	struct device_node *np;
> +	for_each_matching_node(np, ti_clkdm_match_table) {
> +		of_ti_clockdomain_setup(np);
> +	}
> +}



-- 
Regards,
Nishanth Menon
