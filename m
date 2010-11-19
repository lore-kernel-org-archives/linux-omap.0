From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] OMAP3: PM: PRCM interrupt: Fix warning "MPU wakeup but no wakeup sources"
Date: Fri, 19 Nov 2010 08:36:24 -0800
Message-ID: <8739qxe0dz.fsf@deeprootsystems.com>
References: <1290175355-32444-1-git-send-email-ext-madhusudhan.1.gowda@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43376 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755753Ab0KSQg2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 11:36:28 -0500
Received: by gyb11 with SMTP id 11so21430gyb.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 08:36:28 -0800 (PST)
In-Reply-To: <1290175355-32444-1-git-send-email-ext-madhusudhan.1.gowda@nokia.com>
	(Madhusudhan Gowda's message of "Fri, 19 Nov 2010 16:02:35 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Gowda <ext-madhusudhan.1.gowda@nokia.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

Madhusudhan Gowda <ext-madhusudhan.1.gowda@nokia.com> writes:

> A corner case where prcm_interrupt handler is handling the WKST_WKUP and
> before acknowledging the wakeup sources if an IO Pad wakeup ST_IO is
> indicated then hits the below warning since the wakeup sources are already
> cleared.
> 	WARN(c == 0, "prcm: WARNING: PRCM indicated "
> 		"MPU wakeup but no wakeup sources "
> 		"are marked\n");
>
> Since the above warning condition is only valid if the prcm_interrupt
> handler is called but no wakeup sources are marked in first iteration.
>
> The patch fixes this corner case.
>
> Updated after Paul Walmsley's "only handle selected PRCM interrupts" patch.

Can you have a look at the recent work by Thomas Petazzoni:

    [PATCH] omap: prcm: switch to a chained IRQ handler mechanism

where the PRCM IRQ handler is broken up to see if this problem still
exists?  I suspect the problem is gone as each type of interrupt is
separated out, but should be verified.

Kevin

>
> Signed-off-by: Madhusudhan Gowda <ext-madhusudhan.1.gowda@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 75c0cd1..2ed3662 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -266,6 +266,7 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>  {
>  	u32 irqenable_mpu, irqstatus_mpu;
>  	int c = 0;
> +	int ct = 0;
>  
>  	irqenable_mpu = prm_read_mod_reg(OCP_MOD,
>  					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
> @@ -277,13 +278,15 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>  		if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
>  				     OMAP3430_IO_ST_MASK)) {
>  			c = _prcm_int_handle_wakeup();
> +			ct++;
>  
>  			/*
>  			 * Is the MPU PRCM interrupt handler racing with the
>  			 * IVA2 PRCM interrupt handler ?
>  			 */
> -			WARN(c == 0, "prcm: WARNING: PRCM indicated MPU wakeup "
> -			     "but no wakeup sources are marked\n");
> +			WARN(!c && (ct == 1), "prcm: WARNING: PRCM indicated "
> +					"MPU wakeup but no wakeup sources "
> +					"are marked\n");
>  		} else {
>  			/* XXX we need to expand our PRCM interrupt handler */
>  			WARN(1, "prcm: WARNING: PRCM interrupt received, but "
