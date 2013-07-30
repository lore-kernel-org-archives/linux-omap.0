From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 22/33] CLK: OMAP: update gate clock setup for OMAP3
Date: Tue, 30 Jul 2013 15:13:40 -0500
Message-ID: <51F81E74.9070609@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-23-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32967 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755719Ab3G3UOH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 16:14:07 -0400
In-Reply-To: <1374564028-11352-23-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 07/23/2013 02:20 AM, Tero Kristo wrote:
> OMAP3 gate clocks are handled through the clk driver now. Basic gate
> clock can't be used as the OMAP3 gate clocks have some special features,
> namely the idle status linkage which is on separate register.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>   drivers/clk/omap/gate.c |   27 +++++++++++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/omap/gate.c b/drivers/clk/omap/gate.c
> index 7186bb2..b560ff4 100644
> --- a/drivers/clk/omap/gate.c
> +++ b/drivers/clk/omap/gate.c
> @@ -28,12 +28,19 @@
>
>   #ifdef CONFIG_OF
>
> -static const struct clk_ops omap_gate_clk_ops = {
> +static const struct clk_ops omap_gate_clkdm_clk_ops = {
>   	.init		= &omap2_init_clk_clkdm,
>   	.enable		= &omap2_clkops_enable_clkdm,
>   	.disable	= &omap2_clkops_disable_clkdm,
>   };
>
> +static const struct clk_ops omap_gate_clk_ops = {
> +	.init		= &omap2_init_clk_clkdm,
> +	.enable		= &omap2_dflt_clk_enable,
> +	.disable	= &omap2_dflt_clk_disable,
> +	.is_enabled	= &omap2_dflt_clk_is_enabled,
> +};
> +
>   void __init of_omap_gate_clk_setup(struct device_node *node)
>   {
>   	struct clk *clk;
> @@ -43,6 +50,7 @@ void __init of_omap_gate_clk_setup(struct device_node *node)
>   	int num_parents;
>   	const char **parent_names;
>   	int i;
> +	u32 val;
>
>   	clk_hw = kzalloc(sizeof(struct clk_hw_omap), GFP_KERNEL);
>   	if (!clk_hw) {
> @@ -56,7 +64,22 @@ void __init of_omap_gate_clk_setup(struct device_node *node)
>   	of_property_read_string(node, "ti,clkdm-name", &clk_hw->clkdm_name);
>
>   	init.name = clk_name;
> -	init.ops = &omap_gate_clk_ops;
> +	init.flags = 0;
> +
> +	if (of_property_read_u32_index(node, "reg", 0, &val)) {
> +		/* No register, clkdm control only */
> +		init.ops = &omap_gate_clkdm_clk_ops;
> +	} else {
> +		init.ops = &omap_gate_clk_ops;
> +		clk_hw->enable_reg = of_iomap(node, 0);
> +		of_property_read_u32(node, "ti,enable-bit", &val);
> +		clk_hw->enable_bit = val;
> +
> +		if (of_property_read_bool(node, "ti,dss-clk"))
> +			clk_hw->ops = &clkhwops_omap3430es2_dss_usbhost_wait;

umm, it was going relatively ok so far, till i hit this :( it is 
probably a quirk... but still..

> +		else
> +			clk_hw->ops = &clkhwops_wait;
> +	}
>
>   	num_parents = of_clk_get_parent_count(node);
>   	if (num_parents < 1) {
>

but still no usage of "ti,omap-gate-clock" makes me question the need 
for this file.

-- 
Regards,
Nishanth Menon
