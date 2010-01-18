From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV2 1/2] OMAP3630: Clock: add clksel_shift to struct clk
Date: Mon, 18 Jan 2010 10:41:48 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001181037490.3977@utopia.booyaka.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DBC11@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42530 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab0ARRlt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 12:41:49 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DBC11@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Turquette, Mike" <mturquette@ti.com>

Mike, Vijayakumar,

On Mon, 18 Jan 2010, G.N, Vijayakumar wrote:

> >From f9a7f877368830fdf28f9892940d05517f07a582 Mon Sep 17 00:00:00 2001
> From: Mike Turquette <mturquette@ti.com>
> Date: Tue, 12 Jan 2010 16:58:39 +0530
> Subject: [PATCH 1/2] OMAP3630: Clock: add clksel_shift to struct clk

Please don't post all this junk at the top of a patch, otherwise one of us 
has to edit the patch description by hand.  The "From:" line should be all 
that's necessary.

> Introduces clksel_shift to struct clk and populates the same for
> dpll4_m3_ck, dpll4_m4_ck, dpll4_m2_ck, dpll4_m6, dpll4_m5_ck and dpll3_m3.
> The purpose of this change is to make it easy for a generic function to
> refresh specific CM_CLKSEL registers on a per-clock basis by first
> adding then subtracting the shift value from the register.This is the 
> recommended sequence to solve HSDivider PWRDN limitations in OMAP3630.
> 
> Signed-off-by: Mike Turquette <mturquette@ti.com>
> Signed-off-by: Vijaykumar GN <vijaykumar.gn@ti.com>
> ---
>  arch/arm/mach-omap2/clock34xx_data.c    |    6 ++++++
>  arch/arm/plat-omap/include/plat/clock.h |    1 +
>  2 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
> index 6473247..ed17501 100755
> --- a/arch/arm/mach-omap2/clock34xx_data.c
> +++ b/arch/arm/mach-omap2/clock34xx_data.c
> @@ -537,6 +537,7 @@ static struct clk dpll3_m3_ck = {
>  	.init		= &omap2_init_clksel_parent,
>  	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
>  	.clksel_mask	= OMAP3430_DIV_DPLL3_MASK,
> +	.clksel_shift	= OMAP3430_DIV_DPLL3_SHIFT,

Any reason why this is needed if the code can just do __ffs(clksel_mask) 
to get the shift offset?  This will chew up another (4 bytes * number of 
struct clks) and it doesn't seem necessary.


- Paul
