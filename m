From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap2: off by 1
Date: Thu, 14 May 2009 15:15:42 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905141513010.17514@utopia.booyaka.com>
References: <49A5425C.9050405@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56441 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533AbZENVPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 17:15:41 -0400
In-Reply-To: <49A5425C.9050405@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org, tony@atomide.com, Andrew Morton <akpm@linux-foundation.org>

On Wed, 25 Feb 2009, Roel Kluin wrote:

> with while (i++ < MAX_CLOCK_ENABLE_WAIT); i can reach MAX_CLOCK_ENABLE_WAIT + 1
> after the loop, so if (i == MAX_CLOCK_ENABLE_WAIT) that's still success.

Hi Roel

it's a worst-case bailout value that is significantly larger than it needs 
to be, so being off by 1 doesn't matter here.  But I'll take the patch on 
pedantic grounds.  Queued in the omap-clocks-upstream branch.

- Paul

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
>  arch/arm/mach-omap2/clock.c       |    2 +-
>  arch/arm/mach-omap2/powerdomain.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index ce4d46a..da185ff 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -202,7 +202,7 @@ int omap2_wait_clock_ready(void __iomem *reg, u32 mask, const char *name)
>  		udelay(1);
>  	}
>  
> -	if (i < MAX_CLOCK_ENABLE_WAIT)
> +	if (i <= MAX_CLOCK_ENABLE_WAIT)
>  		pr_debug("Clock %s stable after %d loops\n", name, i);
>  	else
>  		printk(KERN_ERR "Clock %s didn't enable in %d tries\n",
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 73e2971..983f1cb 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -1099,7 +1099,7 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
>  	       (c++ < PWRDM_TRANSITION_BAILOUT))
>  		udelay(1);
>  
> -	if (c >= PWRDM_TRANSITION_BAILOUT) {
> +	if (c > PWRDM_TRANSITION_BAILOUT) {
>  		printk(KERN_ERR "powerdomain: waited too long for "
>  		       "powerdomain %s to complete transition\n", pwrdm->name);
>  		return -EAGAIN;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
