From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/5] ARM: OMAP1: Add dmtimer clock data
Date: Tue, 22 May 2012 19:06:12 -0500
Message-ID: <4FBC29F4.5000702@ti.com>
References: <1337717869-20678-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41569 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757726Ab2EWAGN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 May 2012 20:06:13 -0400
In-Reply-To: <1337717869-20678-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Tarun Kanti <tarun.kanti@ti.com>


On 05/22/2012 03:17 PM, Jon Hunter wrote:
> From: Jon Hunter <jon-hunter@ti.com>
> 
> Add clock data for the 8 dmtimers present on OMAP16xx (including OMAP5912)
> and OMAP17xx devices. These timers support 3 different clock sources which
> are the 32kHz clock, ARMXOR clock and an external clock source.

A couple additional comments here. This patch also ...

1. Adds clock nodes for the omap1 32kHz clock source and the dmtimer
   external clock source.
2. Defines a clk_set_parent() function for OMAP1 devices.
3. Adds a call to propagate_rate() for the 32kHz clock source, so that
   any clocks that default to the 32kHz clock are populated with the
   correct rate on start-up. I noticed that when rebooting the 5912 OSK
   that if the dmtimer was previously set to the 32kHz clock on the
   next boot the parent would still be 32kHz but the rate would show up
   as 0. This fixed the problem.

> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap1/clock_data.c |  140 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
> 
> diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
> index d60f690..27acf4c 100644
> --- a/arch/arm/mach-omap1/clock_data.c
> +++ b/arch/arm/mach-omap1/clock_data.c
> @@ -83,6 +83,12 @@ static struct clk ck_ref = {
>  	.rate		= 12000000,
>  };
>  
> +static struct clk ck_32k = {
> +	.name		= "ck_32k",
> +	.ops		= &clkops_null,
> +	.rate		= 32768,
> +};
> +
>  static struct clk ck_dpll1 = {
>  	.name		= "ck_dpll1",
>  	.ops		= &clkops_null,
> @@ -677,6 +683,127 @@ static struct clk i2c_ick = {
>  	.recalc		= &followparent_recalc,
>  };
>  
> +static const struct clksel_rate div_1_0_rates[] = {
> +	{ .div = 1, .val = 0, .flags = CK_16XX | CK_1710 },
> +	{ .div = 0 },
> +};
> +static const struct clksel_rate div_1_1_rates[] = {
> +	{ .div = 1, .val = 1, .flags = CK_16XX | CK_1710 },
> +	{ .div = 0 },
> +};
> +static const struct clksel_rate div_1_2_rates[] = {
> +	{ .div = 1, .val = 2, .flags = CK_16XX | CK_1710 },
> +	{ .div = 0 },
> +};
> +
> +static struct clk timer_extclk = {
> +	.name		= "timer_extclk",
> +	.ops		= &clkops_null,
> +};
> +
> +static const struct clksel timer_sel[] = {
> +	{ .parent = &armxor_ck.clk, .rates = div_1_0_rates },
> +	{ .parent = &ck_32k, .rates = div_1_1_rates },
> +	{ .parent = &timer_extclk, .rates = div_1_2_rates },
> +	{ .parent = NULL },
> +};
> +
> +static struct clk timer1_fck = {
> +	.name		= "timer1_fck",
> +	.ops		= &clkops_generic,
> +	.init		= &omap_init_clksel_parent,
> +	.clksel		= timer_sel,
> +	.clksel_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
> +	.clksel_mask	= BIT(1) | BIT(0),
> +	.parent		= &armxor_ck.clk,
> +	.flags		= CLOCK_NO_IDLE_PARENT,
> +	.recalc		= &followparent_recalc,
> +};
> +
> +static struct clk timer2_fck = {
> +	.name		= "timer2_fck",
> +	.ops		= &clkops_generic,
> +	.init		= &omap_init_clksel_parent,
> +	.clksel		= timer_sel,
> +	.clksel_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
> +	.clksel_mask	= BIT(3) | BIT(2),
> +	.parent		= &armxor_ck.clk,
> +	.flags		= CLOCK_NO_IDLE_PARENT,
> +	.recalc		= &followparent_recalc,
> +};
> +
> +static struct clk timer3_fck = {
> +	.name		= "timer3_fck",
> +	.ops		= &clkops_generic,
> +	.init		= &omap_init_clksel_parent,
> +	.clksel		= timer_sel,
> +	.clksel_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
> +	.clksel_mask	= BIT(5) | BIT(4),
> +	.parent		= &armxor_ck.clk,
> +	.flags		= CLOCK_NO_IDLE_PARENT,
> +	.recalc		= &followparent_recalc,
> +};
> +
> +static struct clk timer4_fck = {
> +	.name		= "timer4_fck",
> +	.ops		= &clkops_generic,
> +	.init		= &omap_init_clksel_parent,
> +	.clksel		= timer_sel,
> +	.clksel_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
> +	.clksel_mask	= BIT(7) | BIT(6),
> +	.parent		= &armxor_ck.clk,
> +	.flags		= CLOCK_NO_IDLE_PARENT,
> +	.recalc		= &followparent_recalc,
> +};
> +
> +static struct clk timer5_fck = {
> +	.name		= "timer5_fck",
> +	.ops		= &clkops_generic,
> +	.init		= &omap_init_clksel_parent,
> +	.clksel		= timer_sel,
> +	.clksel_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
> +	.clksel_mask	= BIT(9) | BIT(8),
> +	.parent		= &armxor_ck.clk,
> +	.flags		= CLOCK_NO_IDLE_PARENT,
> +	.recalc		= &followparent_recalc,
> +};
> +
> +static struct clk timer6_fck = {
> +	.name		= "timer6_fck",
> +	.ops		= &clkops_generic,
> +	.init		= &omap_init_clksel_parent,
> +	.clksel		= timer_sel,
> +	.clksel_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
> +	.clksel_mask	= BIT(11) | BIT(10),
> +	.parent		= &armxor_ck.clk,
> +	.flags		= CLOCK_NO_IDLE_PARENT,
> +	.recalc		= &followparent_recalc,
> +};
> +
> +static struct clk timer7_fck = {
> +	.name		= "timer7_fck",
> +	.ops		= &clkops_generic,
> +	.init		= &omap_init_clksel_parent,
> +	.clksel		= timer_sel,
> +	.clksel_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
> +	.clksel_mask	= BIT(13) | BIT(12),
> +	.parent		= &armxor_ck.clk,
> +	.flags		= CLOCK_NO_IDLE_PARENT,
> +	.recalc		= &followparent_recalc,
> +};
> +
> +static struct clk timer8_fck = {
> +	.name		= "timer8_fck",
> +	.ops		= &clkops_generic,
> +	.init		= &omap_init_clksel_parent,
> +	.clksel		= timer_sel,
> +	.clksel_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
> +	.clksel_mask	= BIT(15) | BIT(14),
> +	.parent		= &armxor_ck.clk,
> +	.flags		= CLOCK_NO_IDLE_PARENT,
> +	.recalc		= &followparent_recalc,
> +};
> +
>  /*
>   * clkdev integration
>   */
> @@ -698,6 +825,15 @@ static struct omap_clk omap_clks[] = {
>  	CLK("omap_wdt", "ick",		&dummy_ck,	CK_1510 | CK_310),
>  	CLK(NULL,	"arminth_ck",	&arminth_ck1510, CK_1510 | CK_310),
>  	CLK(NULL,	"arminth_ck",	&arminth_ck16xx, CK_16XX),
> +	CLK(NULL,	"timer_sys_ck",	&armxor_ck.clk,	CK_16XX | CK_1710),
> +	CLK("omap_timer.1", "fck",	&timer1_fck,	CK_16XX | CK_1710),
> +	CLK("omap_timer.2", "fck",	&timer2_fck,	CK_16XX | CK_1710),
> +	CLK("omap_timer.3", "fck",	&timer3_fck,	CK_16XX | CK_1710),
> +	CLK("omap_timer.4", "fck",	&timer4_fck,	CK_16XX | CK_1710),
> +	CLK("omap_timer.5", "fck",	&timer5_fck,	CK_16XX | CK_1710),
> +	CLK("omap_timer.6", "fck",	&timer6_fck,	CK_16XX | CK_1710),
> +	CLK("omap_timer.7", "fck",	&timer7_fck,	CK_16XX | CK_1710),
> +	CLK("omap_timer.8", "fck",	&timer8_fck,	CK_16XX | CK_1710),
>  	/* CK_GEN2 clocks */
>  	CLK(NULL,	"dsp_ck",	&dsp_ck,	CK_16XX | CK_1510 | CK_310),
>  	CLK(NULL,	"dspmmu_ck",	&dspmmu_ck,	CK_16XX | CK_1510 | CK_310),
> @@ -719,6 +855,7 @@ static struct omap_clk omap_clks[] = {
>  	CLK(NULL,	"lcd_ck",	&lcd_ck_16xx,	CK_16XX | CK_7XX),
>  	CLK(NULL,	"lcd_ck",	&lcd_ck_1510.clk, CK_1510 | CK_310),
>  	/* ULPD clocks */
> +	CLK(NULL,	"timer_32k_ck",	&ck_32k,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
>  	CLK(NULL,	"uart1_ck",	&uart1_1510,	CK_1510 | CK_310),
>  	CLK(NULL,	"uart1_ck",	&uart1_16xx.clk, CK_16XX),
>  	CLK(NULL,	"uart1_ck",	&uart1_7xx,	CK_7XX),
> @@ -759,6 +896,7 @@ static struct omap_clk omap_clks[] = {
>  	CLK("omap-mcbsp.1", "fck",	&dspxor_ck,	CK_16XX | CK_1510 | CK_310),
>  	CLK("omap-mcbsp.2", "fck",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),
>  	CLK("omap-mcbsp.3", "fck",	&dspxor_ck,	CK_16XX | CK_1510 | CK_310),
> +	CLK(NULL,	"timer_ext_ck",	&timer_extclk,	CK_16XX | CK_1710),
>  };
>  
>  /*
> @@ -771,6 +909,7 @@ static struct clk_functions omap1_clk_functions = {
>  	.clk_round_rate		= omap1_clk_round_rate,
>  	.clk_set_rate		= omap1_clk_set_rate,
>  	.clk_disable_unused	= omap1_clk_disable_unused,
> +	.clk_set_parent		= omap_clksel_set_parent,
>  };
>  
>  static void __init omap1_show_rates(void)
> @@ -882,6 +1021,7 @@ int __init omap1_clk_init(void)
>  			}
>  		}
>  	}
> +	propagate_rate(&ck_32k);
>  	propagate_rate(&ck_dpll1);
>  	/* Cache rates for clocks connected to ck_ref (not dpll1) */
>  	propagate_rate(&ck_ref);
