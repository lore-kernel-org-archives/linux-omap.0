From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 2/4] ARM: OMAP3+: clock: Move common clksel_rate &
 clock data to common file
Date: Thu, 28 Jun 2012 15:51:51 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA5D6E4@DBDE01.ent.ti.com>
References: <1338285402-11306-1-git-send-email-hvaibhav@ti.com>
 <1338285402-11306-3-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37921 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab2F1PwB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 11:52:01 -0400
In-Reply-To: <1338285402-11306-3-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, May 29, 2012 at 15:26:40, Hiremath, Vaibhav wrote:
> From: Paul Walmsley <paul@pwsan.com>
> 
> OMAP3, OMAP4 and AM33xx share some common data like, clksel_rate
> oscillator clock input (Virtual clock nodes), required for
> clock tree; so move common data to common data file so that it
> can be reused.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> [hvaibhav@ti.com: Created separate commit from Paul's developement
>   branch]
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Paul,

Any comments on this approach? If you are ok, I would want to split
this patch and take it forward separately.

Thanks,
Vaibhav


> ---
> I would like propose further data moment from clock tree perspective,
> 
>  - Move all "clksel_rate" to common clock data, since one or the
>    multiple clocktree's will use them.
>  - Move virtual clk data structures to common clock data.
>  - Move 32k clk structure to common clock data.
> 
>  arch/arm/mach-omap2/clock.h             |   12 +++++
>  arch/arm/mach-omap2/clock3xxx_data.c    |   20 ++------
>  arch/arm/mach-omap2/clock44xx_data.c    |   72 -----------------------------
>  arch/arm/mach-omap2/clock_common_data.c |   77 +++++++++++++++++++++++++++++++
>  4 files changed, 93 insertions(+), 88 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
> index a1bb23a..980b0a4 100644
> --- a/arch/arm/mach-omap2/clock.h
> +++ b/arch/arm/mach-omap2/clock.h
> @@ -155,4 +155,16 @@ extern const struct clkops clkops_omap3_noncore_dpll_ops;
>  extern const struct clkops clkops_omap3_core_dpll_ops;
>  extern const struct clkops clkops_omap4_dpllmx_ops;
> 
> +/* clksel_rate blocks shared between OMAP44xx and AM33xx */
> +extern const struct clksel_rate div_1_0_rates[];
> +extern const struct clksel_rate div_1_1_rates[];
> +extern const struct clksel_rate div_1_2_rates[];
> +extern const struct clksel_rate div_1_3_rates[];
> +extern const struct clksel_rate div_1_4_rates[];
> +extern const struct clksel_rate div31_1to31_rates[];
> +
> +/* clocks shared between various OMAP SoCs */
> +extern struct clk virt_19200000_ck;
> +extern struct clk virt_26000000_ck;
> +
>  #endif
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index 452b613..160ced3 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -93,18 +93,6 @@ static struct clk virt_16_8m_ck = {
>  	.rate		= 16800000,
>  };
> 
> -static struct clk virt_19_2m_ck = {
> -	.name		= "virt_19_2m_ck",
> -	.ops		= &clkops_null,
> -	.rate		= 19200000,
> -};
> -
> -static struct clk virt_26m_ck = {
> -	.name		= "virt_26m_ck",
> -	.ops		= &clkops_null,
> -	.rate		= 26000000,
> -};
> -
>  static struct clk virt_38_4m_ck = {
>  	.name		= "virt_38_4m_ck",
>  	.ops		= &clkops_null,
> @@ -145,8 +133,8 @@ static const struct clksel osc_sys_clksel[] = {
>  	{ .parent = &virt_12m_ck,   .rates = osc_sys_12m_rates },
>  	{ .parent = &virt_13m_ck,   .rates = osc_sys_13m_rates },
>  	{ .parent = &virt_16_8m_ck, .rates = osc_sys_16_8m_rates },
> -	{ .parent = &virt_19_2m_ck, .rates = osc_sys_19_2m_rates },
> -	{ .parent = &virt_26m_ck,   .rates = osc_sys_26m_rates },
> +	{ .parent = &virt_19200000_ck, .rates = osc_sys_19_2m_rates },
> +	{ .parent = &virt_26000000_ck,   .rates = osc_sys_26m_rates },
>  	{ .parent = &virt_38_4m_ck, .rates = osc_sys_38_4m_rates },
>  	{ .parent = NULL },
>  };
> @@ -3230,8 +3218,8 @@ static struct omap_clk omap3xxx_clks[] = {
>  	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_3XXX),
>  	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_3XXX),
>  	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2PLUS | CK_AM35XX  | CK_36XX),
> -	CLK(NULL,	"virt_19_2m_ck", &virt_19_2m_ck, CK_3XXX),
> -	CLK(NULL,	"virt_26m_ck",	&virt_26m_ck,	CK_3XXX),
> +	CLK(NULL,	"virt_19200000_ck", &virt_19200000_ck, CK_3XXX),
> +	CLK(NULL,	"virt_26000000_ck",	&virt_26000000_ck,	CK_3XXX),
>  	CLK(NULL,	"virt_38_4m_ck", &virt_38_4m_ck, CK_3XXX),
>  	CLK(NULL,	"osc_sys_ck",	&osc_sys_ck,	CK_3XXX),
>  	CLK(NULL,	"sys_ck",	&sys_ck,	CK_3XXX),
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index 2172f66..66c2e27 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -106,18 +106,6 @@ static struct clk virt_16800000_ck = {
>  	.rate		= 16800000,
>  };
> 
> -static struct clk virt_19200000_ck = {
> -	.name		= "virt_19200000_ck",
> -	.ops		= &clkops_null,
> -	.rate		= 19200000,
> -};
> -
> -static struct clk virt_26000000_ck = {
> -	.name		= "virt_26000000_ck",
> -	.ops		= &clkops_null,
> -	.rate		= 26000000,
> -};
> -
>  static struct clk virt_27000000_ck = {
>  	.name		= "virt_27000000_ck",
>  	.ops		= &clkops_null,
> @@ -130,31 +118,6 @@ static struct clk virt_38400000_ck = {
>  	.rate		= 38400000,
>  };
> 
> -static const struct clksel_rate div_1_0_rates[] = {
> -	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
> -	{ .div = 0 },
> -};
> -
> -static const struct clksel_rate div_1_1_rates[] = {
> -	{ .div = 1, .val = 1, .flags = RATE_IN_4430 },
> -	{ .div = 0 },
> -};
> -
> -static const struct clksel_rate div_1_2_rates[] = {
> -	{ .div = 1, .val = 2, .flags = RATE_IN_4430 },
> -	{ .div = 0 },
> -};
> -
> -static const struct clksel_rate div_1_3_rates[] = {
> -	{ .div = 1, .val = 3, .flags = RATE_IN_4430 },
> -	{ .div = 0 },
> -};
> -
> -static const struct clksel_rate div_1_4_rates[] = {
> -	{ .div = 1, .val = 4, .flags = RATE_IN_4430 },
> -	{ .div = 0 },
> -};
> -
>  static const struct clksel_rate div_1_5_rates[] = {
>  	{ .div = 1, .val = 5, .flags = RATE_IN_4430 },
>  	{ .div = 0 },
> @@ -288,41 +251,6 @@ static struct clk dpll_abe_x2_ck = {
>  	.recalc		= &omap3_clkoutx2_recalc,
>  };
> 
> -static const struct clksel_rate div31_1to31_rates[] = {
> -	{ .div = 1, .val = 1, .flags = RATE_IN_4430 },
> -	{ .div = 2, .val = 2, .flags = RATE_IN_4430 },
> -	{ .div = 3, .val = 3, .flags = RATE_IN_4430 },
> -	{ .div = 4, .val = 4, .flags = RATE_IN_4430 },
> -	{ .div = 5, .val = 5, .flags = RATE_IN_4430 },
> -	{ .div = 6, .val = 6, .flags = RATE_IN_4430 },
> -	{ .div = 7, .val = 7, .flags = RATE_IN_4430 },
> -	{ .div = 8, .val = 8, .flags = RATE_IN_4430 },
> -	{ .div = 9, .val = 9, .flags = RATE_IN_4430 },
> -	{ .div = 10, .val = 10, .flags = RATE_IN_4430 },
> -	{ .div = 11, .val = 11, .flags = RATE_IN_4430 },
> -	{ .div = 12, .val = 12, .flags = RATE_IN_4430 },
> -	{ .div = 13, .val = 13, .flags = RATE_IN_4430 },
> -	{ .div = 14, .val = 14, .flags = RATE_IN_4430 },
> -	{ .div = 15, .val = 15, .flags = RATE_IN_4430 },
> -	{ .div = 16, .val = 16, .flags = RATE_IN_4430 },
> -	{ .div = 17, .val = 17, .flags = RATE_IN_4430 },
> -	{ .div = 18, .val = 18, .flags = RATE_IN_4430 },
> -	{ .div = 19, .val = 19, .flags = RATE_IN_4430 },
> -	{ .div = 20, .val = 20, .flags = RATE_IN_4430 },
> -	{ .div = 21, .val = 21, .flags = RATE_IN_4430 },
> -	{ .div = 22, .val = 22, .flags = RATE_IN_4430 },
> -	{ .div = 23, .val = 23, .flags = RATE_IN_4430 },
> -	{ .div = 24, .val = 24, .flags = RATE_IN_4430 },
> -	{ .div = 25, .val = 25, .flags = RATE_IN_4430 },
> -	{ .div = 26, .val = 26, .flags = RATE_IN_4430 },
> -	{ .div = 27, .val = 27, .flags = RATE_IN_4430 },
> -	{ .div = 28, .val = 28, .flags = RATE_IN_4430 },
> -	{ .div = 29, .val = 29, .flags = RATE_IN_4430 },
> -	{ .div = 30, .val = 30, .flags = RATE_IN_4430 },
> -	{ .div = 31, .val = 31, .flags = RATE_IN_4430 },
> -	{ .div = 0 },
> -};
> -
>  static const struct clksel dpll_abe_m2x2_div[] = {
>  	{ .parent = &dpll_abe_x2_ck, .rates = div31_1to31_rates },
>  	{ .parent = NULL },
> diff --git a/arch/arm/mach-omap2/clock_common_data.c b/arch/arm/mach-omap2/clock_common_data.c
> index 6424d46..b9f3ba6 100644
> --- a/arch/arm/mach-omap2/clock_common_data.c
> +++ b/arch/arm/mach-omap2/clock_common_data.c
> @@ -43,3 +43,80 @@ const struct clksel_rate dsp_ick_rates[] = {
>  	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
>  	{ .div = 0 },
>  };
> +
> +
> +/* clksel_rate blocks shared between OMAP44xx and AM33xx */
> +
> +const struct clksel_rate div_1_0_rates[] = {
> +	{ .div = 1, .val = 0, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 0 },
> +};
> +
> +const struct clksel_rate div_1_1_rates[] = {
> +	{ .div = 1, .val = 1, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 0 },
> +};
> +
> +const struct clksel_rate div_1_2_rates[] = {
> +	{ .div = 1, .val = 2, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 0 },
> +};
> +
> +const struct clksel_rate div_1_3_rates[] = {
> +	{ .div = 1, .val = 3, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 0 },
> +};
> +
> +const struct clksel_rate div_1_4_rates[] = {
> +	{ .div = 1, .val = 4, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 0 },
> +};
> +
> +const struct clksel_rate div31_1to31_rates[] = {
> +	{ .div = 1, .val = 1, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 2, .val = 2, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 3, .val = 3, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 4, .val = 4, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 5, .val = 5, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 6, .val = 6, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 7, .val = 7, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 8, .val = 8, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 9, .val = 9, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 10, .val = 10, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 11, .val = 11, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 12, .val = 12, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 13, .val = 13, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 14, .val = 14, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 15, .val = 15, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 16, .val = 16, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 17, .val = 17, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 18, .val = 18, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 19, .val = 19, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 20, .val = 20, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 21, .val = 21, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 22, .val = 22, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 23, .val = 23, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 24, .val = 24, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 25, .val = 25, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 26, .val = 26, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 27, .val = 27, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 28, .val = 28, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 29, .val = 29, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 30, .val = 30, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 31, .val = 31, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
> +	{ .div = 0 },
> +};
> +
> +/* Clocks shared between various OMAP SoCs */
> +
> +struct clk virt_19200000_ck = {
> +	.name		= "virt_19200000_ck",
> +	.ops		= &clkops_null,
> +	.rate		= 19200000,
> +};
> +
> +struct clk virt_26000000_ck = {
> +	.name		= "virt_26000000_ck",
> +	.ops		= &clkops_null,
> +	.rate		= 26000000,
> +};
> --
> 1.7.0.4
> 
> 

