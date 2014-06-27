From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH V4 00/16] irqchip: crossbar: Driver fixes
Date: Fri, 27 Jun 2014 08:01:51 -0400
Message-ID: <20140627120151.GC23978@titan.lakedaemon.net>
References: <1403766634-18543-1-git-send-email-r.sricharan@ti.com>
 <20140626074209.GE28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140626074209.GE28884-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 26, 2014 at 12:42:09AM -0700, Tony Lindgren wrote:
> * Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org> [140626 00:14]:
> > This series does some cleanups, fixes for handling two interrupts
> > getting mapped twice to same crossbar and provides support for
> > hardwired IRQ and crossbar definitions.
> > 
> > On certain platforms such as DRA7, SPIs 0, 1, 2, 3, 5, 6, 10,
> > 131, 132, 133 are direct wired to hardware blocks bypassing
> > crossbar. This quirky implementation is *NOT* supposed to be the
> > expectation of crossbar hardware usage. This series adds support
> > to represent such hard-wired irqs through DT and avoid generic
> > allocation/programming of crossbar in the driver.
> > 
> > This way of supporting hard-wired irqs was a result of
> > the below discussions.
> > http://www.spinics.net/lists/arm-kernel/msg329946.html
> > 
> > Based on 3.16 rc2 mainline.
> 
> Jason, once these patches look OK for merging, can you please
> set them up into an immutable branch so I too can merge them in?

Sure thing.

thx,

Jason.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
