From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESUBMIT][PATCH 6/7] OMAP4: Clock stubs since clock
	management framework not in.
Date: Sat, 16 May 2009 11:14:04 +0100
Message-ID: <20090516101404.GM15328@n2100.arm.linux.org.uk>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-5-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-6-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53577 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900AbZEPKOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 06:14:12 -0400
Content-Disposition: inline
In-Reply-To: <1241677756-28756-6-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, May 07, 2009 at 11:59:15AM +0530, Santosh Shilimkar wrote:
> This patch update the cooomon clock.c file for OMAP4. The clk_get() and

Spelling - "common".

> +/* This functions is moved to arch/arm/common/clkdev.c. For OMAP4 since
> + * clock framework is not up , it is defined here to avoid rework in
> + * every driver */
> +
> +/* Dummy hooks only for OMAP4.For rest OMAPs, common clkdev is used */
> +#if defined(CONFIG_ARCH_OMAP4)
> +struct clk *clk_get(struct device *dev, const char *id)
> +{
> +	return NULL;

Okay, so all clk's are NULL pointers on OMAP4 currently.

> +}
> +EXPORT_SYMBOL(clk_get);
> +
> +void clk_put(struct clk *clk)
> +{
> +}
> +EXPORT_SYMBOL(clk_put);
> +void omap2_clk_prepare_for_reboot(void)
> +{
> +}
> +EXPORT_SYMBOL(omap2_clk_prepare_for_reboot);
> +#endif
>  int clk_enable(struct clk *clk)
>  {
>  	unsigned long flags;
>  	int ret = 0;
> +	if (cpu_is_omap44xx())
> +		/* OMAP4 clk framework not supported yet */
> +		return 0;

And this enables things to work.

>  
>  	if (clk == NULL || IS_ERR(clk))
>  		return -EINVAL;
> @@ -56,6 +80,9 @@ EXPORT_SYMBOL(clk_enable);
>  void clk_disable(struct clk *clk)
>  {
>  	unsigned long flags;
> +	if (cpu_is_omap44xx())
> +		/* OMAP4 clk framework not supported yet */
> +		return ;
>  
>  	if (clk == NULL || IS_ERR(clk))
>  		return;

If a NULL pointer is passed to clk_disable() then we return, so I think
the additional protection you've added is not required.

> @@ -80,6 +107,9 @@ unsigned long clk_get_rate(struct clk *clk)
>  {
>  	unsigned long flags;
>  	unsigned long ret = 0;
> +	if (cpu_is_omap44xx())
> +		/* OMAP4 clk framework not supported yet */
> +		return 0;
>  
>  	if (clk == NULL || IS_ERR(clk))
>  		return 0;

Same here.
