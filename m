From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/7][RFC] OMAP4: Clock hack since clock management
	framework not in.
Date: Tue, 21 Apr 2009 11:37:34 -0700
Message-ID: <20090421183733.GM25864@atomide.com>
References: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-4-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-5-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-6-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50061 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758221AbZDUShg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Apr 2009 14:37:36 -0400
Content-Disposition: inline
In-Reply-To: <1240319293-19662-6-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [090421 06:08]:
> This patch update the cooomon clock.c file for OMAP4. The clk_get() and
> clk_put() sunctions are moved to  common place in arch/arm/common/clkdev.c
> Since on current OMAP$ platform clk management is still not supported, the
> internal file is hacked.
> Once the framework is ready the CONFIG_CLKDEV will be used.

Maybe set up a dummy clock44xx.c instead? Then add to the comments that
it's the placeholder for the upcoming omap4 clock framework.

Tony
 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/plat-omap/clock.c |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 2e06145..7eb96a0 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -36,10 +36,30 @@ static struct clk_functions *arch_clock;
>   * Standard clock functions defined in include/linux/clk.h
>   *-------------------------------------------------------------------------*/
>  
> +/* This functions is moved to arch/arm/common/clkdev.c. For OMAP4 since
> + * clock framework is not up , it is defined here to avoid rework in
> + * every driver */
> +
> +/* Dummy hooks only for OMAP4.For rest OMAPs, common clkdev is used */
> +#if defined(CONFIG_ARCH_OMAP4)
> +struct clk *clk_get(struct device *dev, const char *id)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_get);
> +
> +void clk_put(struct clk *clk)
> +{
> +}
> +EXPORT_SYMBOL(clk_put);
> +#endif
>  int clk_enable(struct clk *clk)
>  {
>  	unsigned long flags;
>  	int ret = 0;
> +	if (cpu_is_omap44xx())
> +		/* OMAP4 clk framework not supported yet */
> +		return 0;
>  
>  	if (clk == NULL || IS_ERR(clk))
>  		return -EINVAL;
> @@ -56,6 +76,9 @@ EXPORT_SYMBOL(clk_enable);
>  void clk_disable(struct clk *clk)
>  {
>  	unsigned long flags;
> +	if (cpu_is_omap44xx())
> +		/* OMAP4 clk framework not supported yet */
> +		return ;
>  
>  	if (clk == NULL || IS_ERR(clk))
>  		return;
> @@ -80,6 +103,9 @@ unsigned long clk_get_rate(struct clk *clk)
>  {
>  	unsigned long flags;
>  	unsigned long ret = 0;
> +	if (cpu_is_omap44xx())
> +		/* OMAP4 clk framework not supported yet */
> +		return 0;
>  
>  	if (clk == NULL || IS_ERR(clk))
>  		return 0;
> -- 
> 1.5.4.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
