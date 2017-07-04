From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [BISECTED, REGRESSION] v4.12-rc: omapdrm fails to probe on Nokia
 N900
Date: Tue, 4 Jul 2017 17:09:02 +0200
Message-ID: <20170704150902.GB10703@localhost>
References: <20170614221133.k7gmbzzjsbmbjgbc@darkstar.musicnaut.iki.fi>
 <f7697b9f-b506-bf18-43f9-921ed7f27607@ti.com>
 <20170629185013.aec7qhvrl3waifww@darkstar.musicnaut.iki.fi>
 <e0373c98-a2e3-1231-3aa9-2092d012fe7e@ti.com>
 <20170630085851.j5apctivufhmhp64@darkstar.musicnaut.iki.fi>
 <5bc9976e-228c-5cba-c2ae-bfc5135f17a0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5bc9976e-228c-5cba-c2ae-bfc5135f17a0@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-omap@vger.kernel.org

Hi!

> >>>> Are you sure it doesn't probe? It fails the omapdss_stack_is_ready()
> >>>> check?
> >>>
> >>> It appears the reason was that I didn't have
> >>> CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV enabled.
> >>>
> >>> I think that's wrong. I don't own an analog TV, so why should I enable
> >>> such option to get device's built-in display working?
> >>
> >> Indeed. Unfortunately I don't have a solution for that.
> >>
> >> DRM doesn't support adding devices after probe. So at omapdrm probe time
> >> we have to decide which displays to use. In the dts file, n900 defines
> >> the lcd and analog tv. omapdrm sees those, and, of course, must wait
> >> until their respective drivers have probed. If you don't have the
> >> display driver enabled, it's never loaded and omapdrm never probes as it
> >> keeps waiting for those.
> > 
> > Could you at least print some kind of message early in the boot ("omapdrm
> > is waiting for drivers for display x and y")?
> 
> That could be quite spammy. omapdrm will defer probe if the displays are
> not present, and the deferred probing machinery will then cause a new
> omapdrm probe later. That can happen a lot of times before the drivers
> are there.

Well doing printk just once should not be a problem...?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
