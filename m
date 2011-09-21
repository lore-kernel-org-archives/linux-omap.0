From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 26/26] gpio/omap: add dbclk aliases for all gpio
 modules
Date: Wed, 21 Sep 2011 08:13:13 -0700
Message-ID: <20110921151313.GC2937@atomide.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
 <1315918979-26173-27-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:38147 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751872Ab1IUPNR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 11:13:17 -0400
Content-Disposition: inline
In-Reply-To: <1315918979-26173-27-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:29]:
> Unless the dbclk aliases are assigned, clk_get(bank->dev, "dbclk")
> would not fetch the associated clock handle. As a result, we would
> not be able to turn on/off the debounce clock. This was preventing
> the gpio modules going to low power mode whenever dbclk is enabled.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Looks OK to me, Paul should ack this one also:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/clock3xxx_data.c |    6 ++++++
>  arch/arm/mach-omap2/clock44xx_data.c |    6 ++++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index ffd55b1..7238ec1 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -3462,6 +3462,12 @@ static struct omap_clk omap3xxx_clks[] = {
>  	CLK("musb-am35x",	"fck",		&hsotgusb_fck_am35xx,	CK_AM35XX),
>  	CLK(NULL,	"hecc_ck",	&hecc_ck,	CK_AM35XX),
>  	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
> +	CLK("omap_gpio.1",	"dbclk",	&gpio1_dbck,	CK_3XXX),
> +	CLK("omap_gpio.2",	"dbclk",	&gpio2_dbck,	CK_3XXX),
> +	CLK("omap_gpio.3",	"dbclk",	&gpio3_dbck,	CK_3XXX),
> +	CLK("omap_gpio.4",	"dbclk",	&gpio4_dbck,	CK_3XXX),
> +	CLK("omap_gpio.5",	"dbclk",	&gpio5_dbck,	CK_3XXX),
> +	CLK("omap_gpio.6",	"dbclk",	&gpio6_dbck,	CK_3XXX),
>  };
>  
>  
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index 2af0e3f..4986069 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -3363,6 +3363,12 @@ static struct omap_clk omap44xx_clks[] = {
>  	CLK("usbhs-omap.0",	"usbhost_ick",		&dummy_ck,		CK_443X),
>  	CLK("usbhs-omap.0",	"usbtll_fck",		&dummy_ck,	CK_443X),
>  	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
> +	CLK("omap_gpio.1",	"dbclk",	&gpio1_dbclk,	CK_443X),
> +	CLK("omap_gpio.2",	"dbclk",	&gpio2_dbclk,	CK_443X),
> +	CLK("omap_gpio.3",	"dbclk",	&gpio3_dbclk,	CK_443X),
> +	CLK("omap_gpio.4",	"dbclk",	&gpio4_dbclk,	CK_443X),
> +	CLK("omap_gpio.5",	"dbclk",	&gpio5_dbclk,	CK_443X),
> +	CLK("omap_gpio.6",	"dbclk",	&gpio6_dbclk,	CK_443X),
>  };
>  
>  int __init omap4xxx_clk_init(void)
> -- 
> 1.7.0.4
> 
