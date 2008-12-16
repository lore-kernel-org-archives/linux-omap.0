From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2: PM: fix fault in enter_full_retention()
Date: Mon, 15 Dec 2008 16:24:14 -0800
Message-ID: <20081216002413.GH19551@atomide.com>
References: <1228550110-6675-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55871 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892AbYLPAYQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 19:24:16 -0500
Content-Disposition: inline
In-Reply-To: <1228550110-6675-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [081205 23:55]:
> In omap24xx_cpu_suspend assembly routine, the r2 register which holds
> the address of the SDRC_POWER reg is set to zero before the value is
> written back triggering a fault due to writing to address zero.
> 
> It's hard to tell where this change was introduced since this file
> has been moved and merged.

Pushing to l-o tree, and adding to omap-fixes queue for mainline.

> While this fix prevents a crash, suspend on my n810 is broken with
> current kernels.  I never come out of suspend.

Bummer.

Tony

> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/sleep24xx.S |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/sleep24xx.S b/arch/arm/mach-omap2/sleep24xx.S
> index 43336b9..bf9e961 100644
> --- a/arch/arm/mach-omap2/sleep24xx.S
> +++ b/arch/arm/mach-omap2/sleep24xx.S
> @@ -93,9 +93,8 @@ ENTRY(omap24xx_cpu_suspend)
>  	orr	r4, r4, #0x40		@ enable self refresh on idle req
>  	mov	r5, #0x2000		@ set delay (DPLL relock + DLL relock)
>  	str	r4, [r2]		@ make it so
> -	mov	r2, #0
>  	nop
> -	mcr	p15, 0, r2, c7, c0, 4	@ wait for interrupt
> +	mcr	p15, 0, r3, c7, c0, 4	@ wait for interrupt
>  	nop
>  loop:
>  	subs	r5, r5, #0x1		@ awake, wait just a bit
> -- 
> 1.6.0.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
