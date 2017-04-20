From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] clk: ti: fix linker error with !SOC_OMAP4
Date: Thu, 20 Apr 2017 17:57:39 +0300
Message-ID: <9df5f73d-3e3a-ee33-1b75-c14a1a707ad9@ti.com>
References: <20170419214318.1605787-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170419214318.1605787-1-arnd@arndb.de>
Sender: linux-clk-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Tony Lindgren <tony@atomide.com>, Richard Watts <rrw@kynesim.co.uk>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 20/04/17 00:43, Arnd Bergmann wrote:
> When none of the OMAP4-generation SoCs are enabled, we run into a link
> error for am43xx/am43xx:
>
> drivers/clk/ti/dpll.o: In function `of_ti_am3_dpll_x2_setup':
> dpll.c:(.init.text+0xd8): undefined reference to `clkhwops_omap4_dpllmx'
>
> This is easily fixed by adding another #ifdef.
>
> While looking at the code, I also spotted another problem with the
> assignment of hw_ops variable that is not used again later. I'm
> changing this to setting clk_hw->ops instead, which I guess is what
> was intended here.

Good catch... It seems the corner case is masked in the testing I did 
locally so far.

>
> Fixes: 0565fb168d63 ("clk: ti: dpll: move omap3 DPLL functionality to clock driver")

However, I believe the fixes tag should point to this one in linux-next:

commit 473adbf4e02857a6b78dfb3d9fcf752638bbadb9
Author: Tero Kristo <t-kristo@ti.com>
Date:   Thu Feb 9 11:25:28 2017 +0200

     clk: ti: dpll44xx: fix clksel register initialization


> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Other than that:

Acked-by: Tero Kristo <t-kristo@ti.com>

> ---
>  drivers/clk/ti/dpll.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
> index 96d84888c6c5..fcf297fd2233 100644
> --- a/drivers/clk/ti/dpll.c
> +++ b/drivers/clk/ti/dpll.c
> @@ -312,7 +312,6 @@ static void _register_dpll_x2(struct device_node *node,
>  	struct clk_hw_omap *clk_hw;
>  	const char *name = node->name;
>  	const char *parent_name;
> -	int ret;
>
>  	parent_name = of_clk_get_parent_name(node, 0);
>  	if (!parent_name) {
> @@ -332,16 +331,21 @@ static void _register_dpll_x2(struct device_node *node,
>  	init.parent_names = &parent_name;
>  	init.num_parents = 1;
>
> +#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
> +        defined(CONFIG_SOC_DRA7XX)
>  	if (hw_ops == &clkhwops_omap4_dpllmx) {
> +		int ret;
> +
>  		/* Check if register defined, if not, drop hw-ops */
>  		ret = of_property_count_elems_of_size(node, "reg", 1);
>  		if (ret <= 0) {
> -			hw_ops = NULL;
> +			clk_hw->ops = NULL;
>  		} else if (ti_clk_get_reg_addr(node, 0, &clk_hw->clksel_reg)) {
>  			kfree(clk_hw);
>  			return;
>  		}
>  	}
> +#endif
>
>  	/* register the clock */
>  	clk = ti_clk_register(NULL, &clk_hw->hw, name);
>

