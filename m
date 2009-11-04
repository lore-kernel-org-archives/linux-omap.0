From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [RFC] [PATCH] OMAP3630 PM: Correct width for CLKSEL Fields
Date: Wed, 4 Nov 2009 11:51:30 +0200
Message-ID: <20091104095130.GB24213@shisha.kicks-ass.net>
References: <FCCFB4CDC6E5564B9182F639FC35608702FA42EC95@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.welho.com ([213.243.153.38]:33501 "EHLO smtp4.welho.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825AbZKDJzG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Nov 2009 04:55:06 -0500
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA42EC95@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Nov 04, 2009 at 04:58:40 +0530, Sripathy, Vishwanath wrote:
> @@ -134,13 +135,13 @@ static struct omap_clk omap34xx_clks[] = {
>  	CLK(NULL,	"omap_12m_fck",	&omap_12m_fck,	CK_343X),
>  	CLK(NULL,	"dpll4_m2_ck",	&dpll4_m2_ck,	CK_343X),
>  	CLK(NULL,	"dpll4_m2x2_ck", &dpll4_m2x2_ck, CK_343X),
> -	CLK(NULL,	"dpll4_m3_ck",	&dpll4_m3_ck,	CK_343X),
> +	CLK(NULL,	"dpll4_m3_ck",	&dpll4_m3_ck,	CK_343X | CK_363X),
>  	CLK(NULL,	"dpll4_m3x2_ck", &dpll4_m3x2_ck, CK_343X),
> -	CLK(NULL,	"dpll4_m4_ck",	&dpll4_m4_ck,	CK_343X),
> +	CLK(NULL,	"dpll4_m4_ck",	&dpll4_m4_ck,	CK_343X | CK_363X),
>  	CLK(NULL,	"dpll4_m4x2_ck", &dpll4_m4x2_ck, CK_343X),
> -	CLK(NULL,	"dpll4_m5_ck",	&dpll4_m5_ck,	CK_343X),
> +	CLK(NULL,	"dpll4_m5_ck",	&dpll4_m5_ck,	CK_343X | CK_363X),
>  	CLK(NULL,	"dpll4_m5x2_ck", &dpll4_m5x2_ck, CK_343X),
> -	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck,	CK_343X),
> +	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck,	CK_343X | CK_363X),
>  	CLK(NULL,	"dpll4_m6x2_ck", &dpll4_m6x2_ck, CK_343X),
>  	CLK(NULL,	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_343X),
>  	CLK(NULL,	"dpll5_ck",	&dpll5_ck,	CK_3430ES2),

Doesn't it make more sense to have separate dpll4_*_ck's for 363X so as to
avoid the clksel_mask_3630?

> @@ -1216,6 +1217,10 @@ int __init omap2_clk_init(void)
>  			cpu_mask |= RATE_IN_3430ES2;
>  			cpu_clkflg |= CK_3430ES2;
>  		}
> +	if (cpu_is_omap36xx()) {
> +		dpll4_dd.mult_mask = OMAP3630_PERIPH_DPLL_MULT_MASK;
> +		cpu_mask  |= RATE_IN_363X;

Extra space before '|'.

> +		}
>  	}

I think there's an indentation problem.

>  
>  	clk_init(&omap2_clk_functions);
> @@ -1225,6 +1230,11 @@ int __init omap2_clk_init(void)
>  
>  	for (c = omap34xx_clks; c < omap34xx_clks + ARRAY_SIZE(omap34xx_clks); c++)
>  		if (c->cpu & cpu_clkflg) {
> +			/* for 3630, change the mask value for clocks which are
> +				marked as CK_363X*/
> +			if (cpu_is_omap36xx())
> +				if (c->cpu  & CK_363X)

Extra space before '&'.

> +					c->lk.clk->clksel_mask = c->lk.clk->clksel_mask_3630;

This looks longer than normally allowed.

Regards,
--
Alex
