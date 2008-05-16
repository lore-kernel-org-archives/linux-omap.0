From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] clock34xx.c: fix spinlock reentry in
	omap3_noncore_dpll_enable()
Date: Fri, 16 May 2008 10:49:59 -0700
Message-ID: <20080516174958.GR23002@atomide.com>
References: <alpine.DEB.1.00.0805151445220.29298@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50817 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbYEPRt5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 13:49:57 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805151445220.29298@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080515 13:50]:
> 
> omap3_noncore_dpll_enable() calls clk_get_rate(), which causes an attempt 
> to re-enter the clockfw_lock spinlock.  Fix by calling 
> omap2_get_dpll_rate() instead.

Pushing.

Tony

> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> 
>  arch/arm/mach-omap2/clock34xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index 670c945..71357db 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -273,7 +273,7 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
>  	if (clk == &dpll3_ck)
>  		return -EINVAL;
>  
> -	if (clk->parent->rate == clk_get_rate(clk))
> +	if (clk->parent->rate == omap2_get_dpll_rate(clk))
>  		r = _omap3_noncore_dpll_bypass(clk);
>  	else
>  		r = _omap3_noncore_dpll_lock(clk);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
