From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3 clock: Access only available clock bits
Date: Fri, 20 Mar 2009 15:48:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903201523220.4676@utopia.booyaka.com>
References: <4d34a0a70903192015j4ea44b1fn4f7bb045da32d218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54156 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbZCTVsF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 17:48:05 -0400
In-Reply-To: <4d34a0a70903192015j4ea44b1fn4f7bb045da32d218@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, kyungmin.park@samsung.com, Tony Lindgren <tony@atomide.com>, bhmin@samsung.com

Hello Kyuwon,

On Fri, 20 Mar 2009, Kim Kyuwon wrote:

> I found a problem on PM Branch with OMAP3430 ES3.1 Board when enabling
> OMAP_RESET_CLOCKS feature.
> In clk_disable_unsed() function, as soon as sad2d_ick is disabled,
> prcm interrupt is generated and its handler can't exit loop at next
> statement!
> 
> while (prm_read_mod_reg(OCP_MOD, OMAP2_PRM_IRQSTATUS_MPU_OFFSET));

We encountered a similar problem a few months ago.  The problem is 
probably the pad mux settings on the d2d_mstdby and d2d_swakeup pads.  
These are usually configured by the bootloader.  My recollection is that 
they should be pulled up, but I don't recall for sure.  Yes, we should 
have a patch in the PM branch to at least detect whether these pads are 
configured incorrectly...

> I also found that sad2d_ick is available only OMAP3430 ES1. I fixed
> this problem with below patch.

Thanks for your patch, but, sad2d_ick is indeed present on ES2+. TI 
removed the documenation from the main TRM and moved it to the "OMAP34xx 
Stacked Mode Addendum" (SWCU048).  Ill-advised, in my opinion!


- Paul

> 
> Your better solutions or comments appreciated.
> 
> Sincerely,
> Kyuwon
> --
> This patch prevents setting or clearing reserved bits of 'Clock Enable
> Register', in the clk_disable_unused() function. Especially, this
> patch prevents using the sad2d_ick which doesn't exist in OMAP3430
> ES2+.
> 
> Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>
> ---
>  arch/arm/mach-omap2/clock34xx.h |    2 +-
>  arch/arm/plat-omap/clock.c      |   10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
> index e0dd7f3..039f7dd 100644
> --- a/arch/arm/mach-omap2/clock34xx.h
> +++ b/arch/arm/mach-omap2/clock34xx.h
> @@ -1279,7 +1279,7 @@ static struct clk sad2d_ick = {
>  	.prcm_mod	= CORE_MOD,
>  	.enable_reg	= CM_ICLKEN1,
>  	.enable_bit	= OMAP3430_EN_SAD2D_SHIFT,
> -	.flags		= CLOCK_IN_OMAP343X,
> +	.flags		= CLOCK_IN_OMAP3430ES1,
>  	.clkdm		= { .name = "d2d_clkdm" },
>  	.recalc		= &followparent_recalc,
>  };
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 2eed047..b16c6c3 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -775,6 +775,16 @@ static int __init clk_disable_unused(void)
>  		if (cpu_class_is_omap1() && ck->enable_reg == 0)
>  			continue;
> 
> +		if (cpu_is_omap34xx()) {
> +			if ((omap_rev() == OMAP3430_REV_ES1_0) &&
> +					(ck->flags & CLOCK_IN_OMAP3430ES2))
> +				continue;
> +
> +			/* In this case, board Rev. is greater then ES1 */
> +			if (ck->flags & CLOCK_IN_OMAP3430ES1)
> +				continue;
> +		}
> +
>  		spin_lock_irqsave(&clockfw_lock, flags);
>  		if (arch_clock->clk_disable_unused)
>  			arch_clock->clk_disable_unused(ck);
> -- 
> 1.5.2.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
