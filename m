From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 clock: put DPLL into bypass if bypass rate =
	clk->rate, not hardware rate
Date: Fri, 3 Oct 2008 16:45:22 +0300
Message-ID: <20081003134521.GE6251@atomide.com>
References: <alpine.DEB.2.00.0809250837350.14535@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49651 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbYJCNmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 09:42:25 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0809250837350.14535@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tero.kristo@nokia.com, rnayak@ti.com

* Paul Walmsley <paul@pwsan.com> [080925 17:40]:
> 
> When a non-CORE DPLL is enabled via omap3_noncore_dpll_enable(), use
> the user's desired rate in clk->rate to determine whether to put the
> DPLL into bypass or lock mode, rather than reading the DPLL's current
> idle state from its hardware registers.
> 
> This fixes a bug observed when leaving retention. Non-CORE DPLLs were
> not being relocked when downstream clocks re-enabled; rather, the DPLL
> entered bypass mode.
> 
> Problem reported by Tero Kristo <tero.kristo@nokia.com>.

Pushing.

Tony

> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/clock34xx.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index c89d6bc..df258f7 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -281,9 +281,7 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
>  	if (!dd)
>  		return -EINVAL;
>  
> -	rate = omap2_get_dpll_rate(clk);
> -
> -	if (dd->bypass_clk->rate == rate)
> +	if (clk->rate == dd->bypass_clk->rate)
>  		r = _omap3_noncore_dpll_bypass(clk);
>  	else
>  		r = _omap3_noncore_dpll_lock(clk);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
