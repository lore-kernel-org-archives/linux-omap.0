From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv5 02/10] ARM: OMAP3+: voltage: add support for
	voltagedomain usecounts
Date: Tue, 25 Sep 2012 10:41:00 +0100
Message-ID: <20120925094100.GK31374@n2100.arm.linux.org.uk>
References: <1348565565-14744-1-git-send-email-t-kristo@ti.com> <1348565565-14744-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39771 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab2IYJlI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 05:41:08 -0400
Content-Disposition: inline
In-Reply-To: <1348565565-14744-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, Sep 25, 2012 at 12:32:37PM +0300, Tero Kristo wrote:
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index ba49029..ca54aec 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -1475,10 +1477,16 @@ int pwrdm_state_switch(struct powerdomain *pwrdm)
>   */
>  void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
>  {
> +	unsigned long flags;
> +
>  	if (!pwrdm)
>  		return;
>  
> -	atomic_inc(&pwrdm->usecount);
> +	if (atomic_inc_return(&pwrdm->usecount) == 1) {
> +		spin_lock_irqsave(&pwrdm->lock, flags);
> +		voltdm_pwrdm_enable(pwrdm->voltdm.ptr);
> +		spin_unlock_irqrestore(&pwrdm->lock, flags);
> +	}

This looks like the classic "I like atomic types because they have magic
properties" brain-deadness.

What would happen to users of this if you had this sequence:

pwrdm->usecount starts off as 1.

Thread0				Thread1
atomic_inc_return() (returns 1)
				atomic_inc_return() (returns 2)
				starts using stuff in power domain
spin_lock_irqsave()
voltdm_pwrdm_enable()
spin_unlock_irqrestore()

?
