From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH v2 6/7] OMAP2+: clockdomain: Add 2 APIs to control
 clockdomain from hwmod framework
Date: Sun, 26 Jun 2011 13:07:15 -0700
Message-ID: <20110626200715.GB2306@google.com>
References: <1308917193-16912-1-git-send-email-b-cousson@ti.com>
 <1308917193-16912-7-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:43315 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885Ab1FZUHX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Jun 2011 16:07:23 -0400
Content-Disposition: inline
In-Reply-To: <1308917193-16912-7-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org

On Fri, Jun 24, 2011 at 02:06:32PM +0200, Benoit Cousson wrote:
> Duplicate the existing API for clockdomain enable from clock to enable
> a clock domain from hwmod framework.
> This will be needed when the hwmod framework will move from the current
> clock centric approach to the module based approach.
> 
...
> +static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
> +{
> +	if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
> +		return -EINVAL;
> +
> +#ifdef DEBUG
> +	if (atomic_read(&clkdm->usecount) == 0) {
> +		WARN_ON(1); /* underflow */
> +		return -ERANGE;
> +	}
> +#endif
> +
> +	if (atomic_dec_return(&clkdm->usecount) > 0)
> +		return 0;

Suggest taking the error return out of the #ifdef DEBUG code (mainly
to lessen the chance that enabling debugging features makes problems
appear or disappear, although the WARN_ON should be a prominent clue
in this case), and maybe just have the function always handle
underflow.

...
> @@ -877,35 +911,93 @@ int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
>   */
>  int clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
>  {
> +	int ret = 0;
> +
>  	/*
>  	 * XXX Rewrite this code to maintain a list of enabled
>  	 * downstream clocks for debugging purposes?
>  	 */
>  
> -	if (!clkdm || !clk)
> +	if (!clk)
>  		return -EINVAL;
>  
> -	if (!arch_clkdm || !arch_clkdm->clkdm_clk_disable)
> +	ret = _clkdm_clk_hwmod_disable(clkdm);
> +
> +	/* All downstream clocks of this clockdomain are now disabled */
> +	pr_debug("clockdomain: clkdm %s: clk %s now disabled\n", clkdm->name,
> +		 clk->name);

The pr_debug should be printed only if ret == 0.

The comment seems true only if the clock domain's usecount went to zero.

The terminology here may be a bit confusing: the function does not actually
disable the named downstream clock in the usual sense
(as in clk_disable(clk), or any action to individually gate that
clock)  Similar comments for clkdm_clk_enable). 

Similar comments for clkdm_hwmod_disable.

