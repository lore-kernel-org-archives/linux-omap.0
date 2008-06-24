From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/8] PRCM: Workaround for pwrdn_x control
Date: Tue, 24 Jun 2008 01:28:18 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806240118000.9741@utopia.booyaka.com>
References: <87iqw85xlo.fsf@trdhcp146196.ntc.nokia.com> <1213687856-29932-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35473 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbYFXH2T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 03:28:19 -0400
In-Reply-To: <1213687856-29932-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

Hello Jouni,

On Tue, 17 Jun 2008, Jouni Hogander wrote:

> Clock path should be powered down only after all it's clients are
> properly disabled. Generally we don't have working implementation for
> checking wether some clock is enabled or disabled.

Just wanted to revisit this again briefly.  Is this patch intended to fix 
DPLL output powerdown paths?  Or do all clocks need this for some reason?

If the former, what do you think instead about adding a custom disable 
function for the DPLL outputs which would include the udelay()?
That way we might be able to avoid adding the udelay() to all clock 
disable calls.

- Paul

>  arch/arm/mach-omap2/clock.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index ed15868..9099ba6 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -329,6 +329,9 @@ void omap2_clk_disable(struct clk *clk)
>  {
>  	if (clk->usecount > 0 && !(--clk->usecount)) {
>  		_omap2_clk_disable(clk);
> +		/* XXX Currently we don't have working code for
> +		 * checking wether clock is really disabled */
> +		udelay(10);
>  		if (clk->parent)
>  			omap2_clk_disable(clk->parent);
>  		if (clk->clkdm)
> @@ -974,6 +977,12 @@ void omap2_clk_disable_unused(struct clk *clk)
>  		return;
>  
>  	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
> -	_omap2_clk_disable(clk);
> +	/* XXX In case of omap3 we need to make sure that sequence is
> +	 * correct when disabling clocks */
> +	if (cpu_is_omap34xx()) {
> +		omap2_clk_enable(clk);
> +		omap2_clk_disable(clk);
> +	} else
> +		_omap2_clk_disable(clk);
>  }
>  #endif
> -- 
> 1.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
