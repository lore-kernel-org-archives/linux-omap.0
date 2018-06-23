From: "Derald D. Woods" <woods.technical@gmail.com>
Subject: Re: [PATCH] clk: ti: omap3: Fix am3517 mdio clock alias
Date: Sat, 23 Jun 2018 09:38:43 -0500
Message-ID: <20180623143824.GA14050@ethiopia>
References: <20180623110912.20633-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180623110912.20633-1-aford173@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: t-kristo@ti.com, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, tony@atomide.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 23, 2018 at 06:09:12AM -0500, Adam Ford wrote:
> A previous patch removed OMAP clock aliases that were perceived
> to be unnecessary.  Unfortunately, it broke the ethernet on the
> am3517-evm.  This patch renables the MDIO clock.
> 
> Fixes: 0ed266d7ae5e ("clk: ti: omap3: cleanup unnecessary clock aliases")
> Cc: stable@vger.kernel.org #4.16+
> 

On AM3517-EVM, you can add:

Tested-by: Derald D. Woods <woods.technical@gmail.com>

> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/clk/ti/clk-3xxx.c b/drivers/clk/ti/clk-3xxx.c
> index 8aa5f5793835..f84734bd0aa7 100644
> --- a/drivers/clk/ti/clk-3xxx.c
> +++ b/drivers/clk/ti/clk-3xxx.c
> @@ -254,6 +254,8 @@ static struct ti_dt_clk omap36xx_am35xx_omap3430es2plus_clks[] = {
>  };
>  
>  static struct ti_dt_clk am35xx_clks[] = {
> +	DT_CLK("davinci_emac.0", NULL, "emac_ick"),
> +	DT_CLK("davinci_mdio.0", NULL, "emac_fck"),
>  	DT_CLK(NULL, "hsotgusb_ick", "hsotgusb_ick_am35xx"),
>  	DT_CLK(NULL, "hsotgusb_fck", "hsotgusb_fck_am35xx"),
>  	DT_CLK(NULL, "uart4_ick", "uart4_ick_am35xx"),
> -- 
> 2.17.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
