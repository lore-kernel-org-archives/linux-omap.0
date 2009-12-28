From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP4: PM: Remove the checks preventing OMAP4
 clockdomain validation
Date: Mon, 28 Dec 2009 11:47:31 -0800
Message-ID: <20091228194731.GL3512@atomide.com>
References: <1261391747-24066-1-git-send-email-abhijitpagare@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49740 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbZL1Trh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 14:47:37 -0500
Content-Disposition: inline
In-Reply-To: <1261391747-24066-1-git-send-email-abhijitpagare@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhijit Pagare <abhijitpagare@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

* Abhijit Pagare <abhijitpagare@ti.com> [091221 02:34]:
> The clockdomain related code beng in place it is now not necessary to have
> some of the clock code commented out. This would help the validation of the
> clockdomain functions using the clock level interfaces.

Why are tagging clock related  patches as "PM" in the subject?

All the clock related patches should be done directly against
the mainline kernel.

If there is some dependency to the pm branch, that should be
fixed and removed ASAP.

Regards,

Tony



 
> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/clock.c |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index 759c72a..a6d570a 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -181,7 +181,6 @@ static int _dpll_test_fint(struct clk *clk, u8 n)
>   * clockdomain pointer, and save it into the struct clk.  Intended to be
>   * called during clk_register().  No return value.
>   */
> -#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
>  void omap2_init_clk_clkdm(struct clk *clk)
>  {
>  	struct clockdomain *clkdm;
> @@ -199,7 +198,6 @@ void omap2_init_clk_clkdm(struct clk *clk)
>  			 "clkdm %s\n", clk->name, clk->clkdm_name);
>  	}
>  }
> -#endif
>  
>  /**
>   * omap2_init_clksel_parent - set a clksel clk's parent field from the hardware
> @@ -476,10 +474,8 @@ void omap2_clk_disable(struct clk *clk)
>  		_omap2_clk_disable(clk);
>  		if (clk->parent)
>  			omap2_clk_disable(clk->parent);
> -#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
>  		if (clk->clkdm)
>  			omap2_clkdm_clk_disable(clk->clkdm, clk);
> -#endif
>  
>  	}
>  }
> @@ -489,10 +485,8 @@ int omap2_clk_enable(struct clk *clk)
>  	int ret = 0;
>  
>  	if (clk->usecount++ == 0) {
> -#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
>  		if (clk->clkdm)
>  			omap2_clkdm_clk_enable(clk->clkdm, clk);
> -#endif
>  
>  		if (clk->parent) {
>  			ret = omap2_clk_enable(clk->parent);
> @@ -511,10 +505,8 @@ int omap2_clk_enable(struct clk *clk)
>  	return ret;
>  
>  err:
> -#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once clkdm f/w is in place */
>  	if (clk->clkdm)
>  		omap2_clkdm_clk_disable(clk->clkdm, clk);
> -#endif
>  	clk->usecount--;
>  	return ret;
>  }
> -- 
> 1.5.4.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
