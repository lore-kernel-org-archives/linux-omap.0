From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2-clk: Add missing lcdc clock definition
Date: Tue, 30 Oct 2012 11:18:38 -0700
Message-ID: <20121030181837.GM11908@atomide.com>
References: <1351698962-3923-1-git-send-email-panto@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351698962-3923-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>
List-Id: linux-omap@vger.kernel.org

* Pantelis Antoniou <panto@antoniou-consulting.com> [121030 11:04]:
> Looks like the lcdc clock definition got dropped.
> It is required for the LCD controller to work. Reintroduce.

This looks like a regression, can you also add the commit
causing it?

Regards,

Tony
 
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> ---
>  arch/arm/mach-omap2/clock33xx_data.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
> index 1a45d6b..b7b7995 100644
> --- a/arch/arm/mach-omap2/clock33xx_data.c
> +++ b/arch/arm/mach-omap2/clock33xx_data.c
> @@ -867,6 +867,16 @@ static struct clk lcd_gclk = {
>  	.recalc		= &followparent_recalc,
>  };
>  
> +static struct clk lcdc_fck = {
> +	.name           = "lcdc_fck",
> +	.clkdm_name     = "lcdc_clkdm",
> +	.parent         = &lcd_gclk,
> +	.enable_reg     = AM33XX_CM_PER_LCDC_CLKCTRL,
> +	.enable_bit     = AM33XX_MODULEMODE_SWCTRL,
> +	.ops            = &clkops_omap2_dflt,
> +	.recalc         = &followparent_recalc,
> +};
> +
>  static struct clk mmc_clk = {
>  	.name		= "mmc_clk",
>  	.clkdm_name	= "l4ls_clkdm",
> @@ -1075,6 +1085,7 @@ static struct omap_clk am33xx_clks[] = {
>  	CLK(NULL,	"clkout2_ck",		&clkout2_ck,	CK_AM33XX),
>  	CLK(NULL,	"timer_32k_ck",		&clkdiv32k_ick,	CK_AM33XX),
>  	CLK(NULL,	"timer_sys_ck",		&sys_clkin_ck,	CK_AM33XX),
> +	CLK("da8xx_lcdc.0",     NULL,           &lcdc_fck,      CK_AM33XX),
>  };
>  
>  int __init am33xx_clk_init(void)
> -- 
> 1.7.12
> 
