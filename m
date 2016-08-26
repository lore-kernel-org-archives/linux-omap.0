From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] USB: ohci-omap - avoid including mach/irqs.h
Date: Fri, 26 Aug 2016 13:20:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1608261319550.1794-100000@iolanthe.rowland.org>
References: <20160826164351.GV5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160826164351.GV5783-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 26 Aug 2016, Russell King - ARM Linux wrote:

> On Mon, Aug 22, 2016 at 11:28:21AM -0400, Alan Stern wrote:
> > On Fri, 19 Aug 2016, Russell King wrote:
> > 
> > > ohci-omap doesn't need to include mach/irqs.h - nothing within this
> > > driver needs anything from this header file.  Remove this include.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
> > > ---
> > >  drivers/usb/host/ohci-omap.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
> > > index de7c68602a7e..495c1454b9e8 100644
> > > --- a/drivers/usb/host/ohci-omap.c
> > > +++ b/drivers/usb/host/ohci-omap.c
> > > @@ -36,7 +36,6 @@
> > >  #include <mach/mux.h>
> > >  
> > >  #include <mach/hardware.h>
> > > -#include <mach/irqs.h>
> > >  #include <mach/usb.h>
> > 
> > Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> 
> Thanks.  Will Greg be picking this up?

Yes, he should.  Unless you want it to go via a different tree...

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
