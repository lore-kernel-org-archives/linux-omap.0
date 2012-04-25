From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/3] IRQ: allow check_wakeup_irqs to notice level-triggered
 interrupts.
Date: Wed, 25 Apr 2012 10:50:15 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1204251018530.2542@ionos>
References: <20120425025637.7832.14013.stgit@notabene.brown> <20120425030524.7832.85239.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38054 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208Ab2DYIuW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 04:50:22 -0400
In-Reply-To: <20120425030524.7832.85239.stgit@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 25 Apr 2012, NeilBrown wrote:

> Level triggered interrupts do not cause IRQS_PENDING to be set, so
> check_wakeup_irqs ignores them.
> They don't need to set IRQS_PENDING as the level stays high which
> shows that they must be pending.  However if such an interrupt fired
> during late suspend, it will have been masked so the fact that it
> is still asserted will not cause the suspend to abort.
> 
> So if any wakeup interrupt is masked, unmask it when checking wakeup
> irqs.  If the interrupt is asserted, suspend will abort.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> 
>  kernel/irq/pm.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index 15e53b1..0d26206 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -106,6 +106,12 @@ int check_wakeup_irqs(void)
>  		if (irqd_is_wakeup_set(&desc->irq_data)) {
>  			if (desc->istate & IRQS_PENDING)
>  				return -EBUSY;
> +			if (irqd_irq_masked(&desc->irq_data))
> +				/* Probably a level interrupt
> +				 * which fired recently and was
> +				 * masked
> +				 */
> +				unmask_irq(desc);

Oh no. We don't unmask unconditionally. What about an interrupt which
is disabled, has no handler ..... ? That needs more thought.

Thanks,

	tglx
