From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: DMTIMER: Ack pending interrupt always when
 stopping a timer
Date: Tue, 1 Jun 2010 10:40:48 +0300
Message-ID: <20100601074048.GD841@atomide.com>
References: <1274797036-21107-1-git-send-email-tero.kristo@nokia.com>
 <87d3wkner2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60811 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab0FAHkz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 03:40:55 -0400
Content-Disposition: inline
In-Reply-To: <87d3wkner2.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <tero.kristo@nokia.com>, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [100525 19:07]:
> Tero Kristo <tero.kristo@nokia.com> writes:
> 
> > From: Tero Kristo <tero.kristo@nokia.com>
> >
> > The kernel timer queue is being run currently from a GP timer running in a one
> > shot mode, which works in a way that when it expires, it will also stop.
> > Usually during this situation, the interrupt handler will ack the interrupt,
> > load a new value to the timer and start it again. During suspend, the
> > situation is slightly different, as we disable interrupts just before
> > timekeeping is suspended, which leaves a small window where the timer can
> > expire before it is stopped, and will leave the interrupt flag pending.
> > This pending interrupt will prevent ARM sleep entry, thus now we ack it always
> > when we are attempting to stop a timer.
> >
> > Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> > ---
> >  arch/arm/plat-omap/dmtimer.c |    8 +++++---
> >  1 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> > index c64875f..023d664 100644
> > --- a/arch/arm/plat-omap/dmtimer.c
> > +++ b/arch/arm/plat-omap/dmtimer.c
> > @@ -541,11 +541,13 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
> >  		  * timer is stopped
> >  		  */
> >  		udelay(3500000 / clk_get_rate(timer->fclk) + 1);
> > -		/* Ack possibly pending interrupt */
> > -		omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
> > -				OMAP_TIMER_INT_OVERFLOW);
> >  #endif
> >  	}
> > +#ifdef CONFIG_ARCH_OMAP2PLUS
> > +	/* Ack possibly pending interrupt */
> > +	omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
> > +			OMAP_TIMER_INT_OVERFLOW);
> > +#endif
> >  }
> >  EXPORT_SYMBOL_GPL(omap_dm_timer_stop);

I'll add this to omap-fixes queue, but will remove the
ifdef CONFIG_ARCH_OMAP2PLUS around clearing the interrupt
as the situation would be the same for omap1 if ever used
the same way.

Regards,

Tony
