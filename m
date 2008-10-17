From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: Fix for omap3_noncore_dpll_enable() warning
Date: Fri, 17 Oct 2008 16:15:00 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810171613520.3833@utopia.booyaka.com>
References: <E1KqrhH-0001Gl-1p@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46725 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYJQWPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 18:15:01 -0400
In-Reply-To: <E1KqrhH-0001Gl-1p@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>
Cc: linux-omap@vger.kernel.org

Hi Rick,

On Fri, 17 Oct 2008, Rick Bronson wrote:

>   This patch fixes this warning which, as Tomi Valkeinen pointed out, is
> really an error.

thanks for the patch - but _omap3_noncore_dpll_bypass() and 
_omap3_noncore_dpll_lock() don't return rates.  Will post a patch to fix 
this bug shortly.


- Paul

>   CC      arch/arm/mach-omap2/clock34xx.o
> arch/arm/mach-omap2/clock34xx.c: In function 'omap3_noncore_dpll_enable':
> arch/arm/mach-omap2/clock34xx.c:290: warning: 'rate' is used uninitialized in this function
> 
> --- linux-omap-2.6/arch/arm/mach-omap2/clock34xx.c.~1~	2008-10-16 13:33:26.000000000 -0700
> +++ linux-omap-2.6/arch/arm/mach-omap2/clock34xx.c	2008-10-17 07:35:50.000000000 -0700
> @@ -270,8 +270,7 @@ static int _omap3_noncore_dpll_stop(stru
>   */
>  static int omap3_noncore_dpll_enable(struct clk *clk)
>  {
> -	int r;
> -	long rate;
> +	int rate;
>  	struct dpll_data *dd;
>  
>  	if (clk == &dpll3_ck)
> @@ -282,14 +281,14 @@ static int omap3_noncore_dpll_enable(str
>  		return -EINVAL;
>  
>  	if (clk->rate == dd->bypass_clk->rate)
> -		r = _omap3_noncore_dpll_bypass(clk);
> +		rate = _omap3_noncore_dpll_bypass(clk);
>  	else
> -		r = _omap3_noncore_dpll_lock(clk);
> +		rate = _omap3_noncore_dpll_lock(clk);
>  
> -	if (!r)
> +	if (!rate)
>  		clk->rate = rate;
>  
> -	return r;
> +	return rate;
>  }
>  
>  /**
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
