From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] The clockdomain of clkout2_src_ck fixed
Date: Wed, 3 Sep 2008 18:44:48 -0700
Message-ID: <20080904014448.GP23085@atomide.com>
References: <1220021309-17275-1-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50094 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbYIDBou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 21:44:50 -0400
Content-Disposition: inline
In-Reply-To: <1220021309-17275-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [080829 07:50]:
> The clockdomain of clkout2_src_ck was set to "core_clkdm", which does not
> exist.

Can you please reply with your Signed-off-by?

Thanks,

Tony

> ---
>  arch/arm/mach-omap2/clock34xx.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
> index d7d6ffd..3504e48 100644
> --- a/arch/arm/mach-omap2/clock34xx.h
> +++ b/arch/arm/mach-omap2/clock34xx.h
> @@ -1010,7 +1010,7 @@ static struct clk clkout2_src_ck = {
>  	.clksel_mask	= OMAP3430_CLKOUT2SOURCE_MASK,
>  	.clksel		= clkout2_src_clksel,
>  	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
> -	.clkdm		= { .name = "core_clkdm" },
> +	.clkdm		= { .name = "core_l4_clkdm" },
>  	.recalc		= &omap2_clksel_recalc,
>  };
>  
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
