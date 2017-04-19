From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] clk: ti: divider: try to fix ti_clk_register_divider
Date: Wed, 19 Apr 2017 13:05:06 -0700
Message-ID: <20170419200506.GB19537@atomide.com>
References: <20170419174507.4055014-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170419174507.4055014-1-arnd@arndb.de>
Sender: linux-clk-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [170419 10:48]:
> The newly introduced function is entirely bogus as I found when looking
> at this warning:
> 
> drivers/clk/ti/divider.c: In function 'ti_clk_register_divider':
> drivers/clk/ti/divider.c:460:8: error: 'reg' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> Treating a 'u32' variable as a structure leads to a stack overflow here,
> and the register address we pass down is never initialized.
> 
> As the code in its original form makes no sense, I can only guess what
> the intention was, and change it to take the address from div->reg.ptr
> instead.
> 
> Fixes: d96f774b2538 ("clk: ti: divider: add support for legacy divider init")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/clk/ti/divider.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
> index d6dcb283b72b..a6d3bbfbbd31 100644
> --- a/drivers/clk/ti/divider.c
> +++ b/drivers/clk/ti/divider.c
> @@ -428,22 +428,17 @@ struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup)
>  
>  struct clk *ti_clk_register_divider(struct ti_clk *setup)
>  {
> -	struct ti_clk_divider *div;
> -	struct clk_omap_reg *reg_setup;
> -	u32 reg;
> +	struct ti_clk_divider *div = setup->data;
> +	struct clk_omap_reg reg_setup = {
> +		.index = div->module,
> +		.offset = div->reg,
> +	};
>  	u8 width;
>  	u32 flags = 0;
>  	u8 div_flags = 0;
>  	const struct clk_div_table *table;
>  	struct clk *clk;
>  
> -	div = setup->data;
> -
> -	reg_setup = (struct clk_omap_reg *)&reg;
> -
> -	reg_setup->index = div->module;
> -	reg_setup->offset = div->reg;
> -
>  	if (div->flags & CLKF_INDEX_STARTS_AT_ONE)
>  		div_flags |= CLK_DIVIDER_ONE_BASED;
>  
> @@ -458,7 +453,7 @@ struct clk *ti_clk_register_divider(struct ti_clk *setup)
>  		return (struct clk *)table;
>  
>  	clk = _register_divider(NULL, setup->name, div->parent,
> -				flags, (void __iomem *)reg, div->bit_shift,
> +				flags, &reg_setup, div->bit_shift,
>  				width, div_flags, table);
>  
>  	if (IS_ERR(clk))

Yeah seems broken. I wonder if this explains some of the omapdrm
issues we're seeing in next?

Regards,

Tony
