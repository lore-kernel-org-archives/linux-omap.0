From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/2] clk: ti: divider: try to fix ti_clk_register_divider
Date: Thu, 20 Apr 2017 18:46:35 +0300
Message-ID: <7f0c996e-df53-ffb7-2c02-2f7fa66d2b94@ti.com>
References: <20170419174507.4055014-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170419174507.4055014-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 19/04/17 20:44, Arnd Bergmann wrote:
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

Actually, I believe the code you are fixing works before this commit:

commit 6c0afb503937a12a8d20a805fcf263e31afa9871
Author: Tero Kristo <t-kristo@ti.com>
Date:   Thu Feb 9 11:24:37 2017 +0200

     clk: ti: convert to use proper register definition for all accesses


... it attempted to convert all the register accesses to the new format 
and change the size of the clk_omap_reg in bulk but I missed converting 
this one. Previously the size of the clk_omap_reg definition was u32, 
but this was confusing and bug prone so I changed it.

The failing piece of code is only executed for legacy boot mode OMAP3 
right now, which could be potentially stripped out of the kernel already 
(I think Tony removed the support for non-DT boot OMAP3 boards 
already...?) This explains why I didn't notice the issue in my local 
testing either.

>
> Fixes: d96f774b2538 ("clk: ti: divider: add support for legacy divider init")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

So, this patch itself is fine, but the desc should be updated to reflect 
the above somehow.

And the "Fixes:" line should be updated to point to the commit mentioned 
above also.

-Tero

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

reg_setup here could be just named as 'reg' as I've done elsewhere.

-Tero

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
>
