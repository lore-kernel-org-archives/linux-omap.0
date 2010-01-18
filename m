From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV2 1/2] OMAP3630: Clock: add clksel_shift to struct clk
Date: Mon, 18 Jan 2010 10:48:57 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001181047500.3977@utopia.booyaka.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DBC11@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48794 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab0ARRs6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 12:48:58 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DBC11@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Turquette, Mike" <mturquette@ti.com>

Another comment.

On Mon, 18 Jan 2010, G.N, Vijayakumar wrote:

> diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
> index 6473247..ed17501 100755
> --- a/arch/arm/mach-omap2/clock34xx_data.c
> +++ b/arch/arm/mach-omap2/clock34xx_data.c
> @@ -537,6 +537,7 @@ static struct clk dpll3_m3_ck = {
>  	.init		= &omap2_init_clksel_parent,
>  	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
>  	.clksel_mask	= OMAP3430_DIV_DPLL3_MASK,
> +	.clksel_shift	= OMAP3430_DIV_DPLL3_SHIFT,
>  	.clksel		= div16_dpll3_clksel,
>  	.clkdm_name	= "dpll3_clkdm",
>  	.recalc		= &omap2_clksel_recalc,
> @@ -677,6 +678,7 @@ static struct clk dpll4_m2_ck_3630 __initdata  = {
>  	.init		= &omap2_init_clksel_parent,
>  	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, OMAP3430_CM_CLKSEL3),
>  	.clksel_mask	= OMAP3630_DIV_96M_MASK,
> +	.clksel_shift	= OMAP3430_DIV_96M_SHIFT,
>  	.clksel		= div32_dpll4_clksel,
>  	.clkdm_name	= "dpll4_clkdm",
>  	.recalc		= &omap2_clksel_recalc,

What commit is this patch supposed to apply on?  If it's not mainline then 
you need to state what commit or branch it's intended to apply on top of.


- Paul
