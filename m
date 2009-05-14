From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 9/9] omap mmc host: Use disable_irq_nosync() from
	within irq handlers.
Date: Thu, 14 May 2009 10:22:26 -0700
Message-ID: <20090514172226.GK5593@atomide.com>
References: <1239861321.29831.130.camel@linux-51e8.site> <20090426212118.19526712@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52372 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbZENRWg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 13:22:36 -0400
Content-Disposition: inline
In-Reply-To: <20090426212118.19526712@mjolnir.ossman.eu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: Carlos Aguiar <carlos.aguiar@indt.org.br>, Anderson Briglia <briglia.anderson@gmail.com>, "Syed Mohammed, Khasim" <x0khasim@ti.com>, Ben Nizette <bn@niasdigital.com>, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

* Pierre Ossman <pierre@ossman.eu> [090426 12:22]:
> Should I queue this up or do you want to do something differently for
> this?

Looks like a valid fix to me.

Acked-by: Tony Lindgren <tony@atomide.com>
 
> On Thu, 16 Apr 2009 15:55:21 +1000
> Ben Nizette <bn@niasdigital.com> wrote:
> 
> > 
> > disable_irq() should wait for all running handlers to complete
> > before returning.  As such, if it's used to disable an interrupt
> > from that interrupt's handler it will deadlock.  This replaces
> > the dangerous instances with the _nosync() variant which doesn't
> > have this problem.
> > 
> > Signed-off-by: Ben Nizette <bn@niasdigital.com>
> > ---
> > diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> > index 5570849..d5ea652 100644
> > --- a/drivers/mmc/host/omap.c
> > +++ b/drivers/mmc/host/omap.c
> > @@ -824,7 +824,7 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
> >  		del_timer(&host->cmd_abort_timer);
> >  		host->abort = 1;
> >  		OMAP_MMC_WRITE(host, IE, 0);
> > -		disable_irq(host->irq);
> > +		disable_irq_nosync(host->irq);
> >  		schedule_work(&host->cmd_abort_work);
> >  		return IRQ_HANDLED;
> >  	}
> 
> 
> -- 
>      -- Pierre Ossman
> 
>   WARNING: This correspondence is being monitored by the
>   Swedish government. Make sure your server uses encryption
>   for SMTP traffic and consider using PGP for end-to-end
>   encryption.


