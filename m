From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: musb bogosity
Date: Fri, 8 Aug 2008 17:51:46 +0900
Message-ID: <20080808085146.GB6580@linux-sh.org>
References: <20080808082722.GA6580@linux-sh.org> <20080808083245.GS30719@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080808083245.GS30719@gandalf.research.nokia.com>
Sender: linux-next-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-next@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 08, 2008 at 11:32:45AM +0300, Felipe Balbi wrote:
> On Fri, Aug 08, 2008 at 05:27:22PM +0900, ext Paul Mundt wrote:
> > This initial failure comes from the fact that musb handily uses "special"
> > I/O routines that it handily wraps, after having failed at grepping for
> > other users. Why this driver isn't using ioread/writeXX_rep() is beyond
> > me, as that's the portable interface we have for doing precisely this
> > sort of thing, without this bizarre PIO/MMIO wrapper munging that isn't
> > even going to work on most platforms.
> > 
[snip]

> > A quick grep suggests that blackfin is also going to get bitten by this, so
> > simply tossing a depends on (ARM && BROKEN) in wouldn't help matters either.
> > 
> > ---
> > 
> > diff --git a/drivers/usb/musb/musb_io.h b/drivers/usb/musb/musb_io.h
> > index 6bbedae..d0f812a 100644
> > --- a/drivers/usb/musb/musb_io.h
> > +++ b/drivers/usb/musb/musb_io.h
> > @@ -37,7 +37,7 @@
> >  
> >  #include <linux/io.h>
> >  
> > -#ifndef	CONFIG_ARM
> > +#if !defined(CONFIG_ARM) && !defined(CONFIG_SUPERH)
> >  static inline void readsl(const void __iomem *addr, void *buf, int len)
> >  	{ insl((unsigned long)addr, buf, len); }
> >  static inline void readsw(const void __iomem *addr, void *buf, int len)
> 
> The right way to fix this would be by removing all those defines and
> make that configuration come from platform_data. I have a patch for
> that, I'll send it to Greg and try to be sure it gets applied. I've been
> using it quite a while and it seems stable.
> 
Great. The fact the I/O routines are broken and that this doesn't build
on anything but ARM still remains a problem. Your generic ifdefs also
seem to be using __raw_xxx() as MMIO accessors while using the xxx()
variants as PIO accessors, irregardless of whether the platform sets
NO_IOPORT or not. If you aren't going to use generic routines, then
don't bother removing your architecture dependency in Kconfig. As it is,
your driver's assumptions on I/O accesses are simply bogus, which is
precisely why we have these portable interfaces in the first place.
