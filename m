From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/10] omap: Move dmtimer defines to dmtimer.h
Date: Tue, 29 Mar 2011 10:44:57 -0700
Message-ID: <20110329174457.GL4016@atomide.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
 <20110328222134.4046.53842.stgit@baageli.muru.com>
 <87mxkdygbn.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:29493 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab1C2RpB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 13:45:01 -0400
Content-Disposition: inline
In-Reply-To: <87mxkdygbn.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Kevin Hilman <khilman@ti.com> [110329 10:39]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> [...]
> 
> > diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> > index 330bd17..66c4b34 100644
> > --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> > +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> > @@ -92,5 +92,130 @@ void omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value
> >  
> >  int omap_dm_timers_active(void);
> >  
> > +/*
> > + * Do not the defines below, they are not needed. They should be only
> 
> Do not what?    ;)

Looks like the nasty parts got censored ;) Should say "Do not use".

Tony
