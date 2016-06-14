From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH v10 03/14] usb: hcd.h: Add OTG to HCD interface
Date: Tue, 14 Jun 2016 10:21:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1606141018530.1574-100000@iolanthe.rowland.org>
References: <575FBD8D.7090700@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <575FBD8D.7090700-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 14 Jun 2016, Roger Quadros wrote:

> +Alan
> 
> On 10/06/16 16:07, Roger Quadros wrote:
> > The OTG core will use struct otg_hcd_ops to interface
> > with the HCD (Host Controller Driver).
> > 
> > The main purpose of this interface is to avoid directly
> > calling HCD APIs from the OTG core as they
> > wouldn't be defined in the built-in symbol table if
> > CONFIG_USB is m.
> > 
> > Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> > Acked-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
> > ---
> >  include/linux/usb/hcd.h | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> > index 66fc137..7729c1f 100644
> > --- a/include/linux/usb/hcd.h
> > +++ b/include/linux/usb/hcd.h
> > @@ -400,6 +400,30 @@ struct hc_driver {
> >  
> >  };
> >  
> > +/**
> > + * struct otg_hcd_ops - Interface between OTG core and HCD
> > + *
> > + * Provided by the HCD core to allow the OTG core to interface with the HCD

Add:  * in case the OTG core is built-in and the HCD core is built as a module.

Otherwise, for patches 1, 3, and 12:

Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
