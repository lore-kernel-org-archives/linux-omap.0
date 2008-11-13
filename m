From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: OMAP3: Make sure clk_disable_unused() order is correct
Date: Thu, 13 Nov 2008 05:55:31 -0800
Message-ID: <87abc3loh8.fsf@deeprootsystems.com>
References: <1226482930-32017-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:33742 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbYKMNzg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 08:55:36 -0500
Received: by an-out-0708.google.com with SMTP id d40so405593and.1
        for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 05:55:35 -0800 (PST)
In-Reply-To: <1226482930-32017-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Wed\, 12 Nov 2008 11\:42\:10 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> Current implementation will disable clocks in the order defined in clock34xx.h,
> at least DPLL4_M2X2 will hang in certain cases (and prevent retention / off)
> if clocks are not disabled in correct order. This patch makes sure the parent
> clocks will be active when disabling a clock.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

And, pulling into next PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/clock.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index dbbc7c8..522ce6f 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -1012,7 +1012,11 @@ void omap2_clk_disable_unused(struct clk *clk)
>  		return;
>  
>  	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
> -	_omap2_clk_disable(clk);
> +	if (cpu_is_omap34xx()) {
> +		omap2_clk_enable(clk);
> +		omap2_clk_disable(clk);
> +	} else
> +		_omap2_clk_disable(clk);
>  	if (clk->clkdm.ptr != NULL)
>  		pwrdm_clkdm_state_switch(clk->clkdm.ptr);
>  }
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
