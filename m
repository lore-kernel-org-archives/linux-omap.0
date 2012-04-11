From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 03/12] arm: omap3: Only sleep in cpuidle driver if I/O
 wake-ups work
Date: Wed, 11 Apr 2012 15:37:47 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204111532280.29473@utopia.booyaka.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com> <1334171147-7517-4-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50607 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987Ab2DKVhs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 17:37:48 -0400
In-Reply-To: <1334171147-7517-4-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

Hi

On Wed, 11 Apr 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Currently, the OMAP3 cpuidle driver calls omap3_enter_idle()
> which calls omap_sram_idle().  omap_sram_idle() eventually
> causes a 'wfi' instruction to be executed effectively putting
> the system to sleep.  It is assumed that an I/O wake-up event
> will occur to wake the system up again.  This doesn't work on
> systems that don't support I/O wake-ups (indicated by
> omap3_has_io_wakeup() returning false).
> 
> To handle this, follow the same path in omap3_enter_idle()
> that would be followed if an interrupt were pending.

I don't quite understand this patch.  Are you saying that AM3517/3505 
can't wake from WFI?  That would seem odd.

There are other sources of wakeup on the system other than I/O wakeup.  
I/O wakeup only applies to wakeups from the I/O pads when the chip is in 
RETENTION or OFF.  And as I understand it, neither of those apply to 
AM3517/3505?

Even if I/O wakeups aren't supported, many of the IP blocks on the system 
should be able to cause the ARM to exit WFI by asserting their 
SWAKEUP lines and raising their interrupt lines.

So this change doesn't seem quite right to me...

More broadly, if AM3517/3505 only supports powerdomains ON, then you 
should probably use your own CPUIdle driver that doesn't touch the 
powerdomain states at all.


- Paul


> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 5358664..12cf81d 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -100,7 +100,7 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
>  	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
>  	pwrdm_set_next_pwrst(core_pd, core_state);
>  
> -	if (omap_irq_pending() || need_resched())
> +	if (omap_irq_pending() || need_resched() || !omap3_has_io_wakeup())
>  		goto return_sleep_time;
>  
>  	/* Deny idle for C1 */
> -- 
> 1.7.9.4
> 


- Paul
