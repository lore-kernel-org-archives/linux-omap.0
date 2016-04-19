From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 01/12] usb: hcd: Initialize hcd->flags to 0
Date: Tue, 19 Apr 2016 09:56:22 +0800
Message-ID: <20160419015622.GH4477@shlinux2.ap.freescale.net>
References: <20160418022956.GB32090@shlinux2.ap.freescale.net>
 <Pine.LNX.4.44L0.1604181007240.1775-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1604181007240.1775-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 18, 2016 at 10:11:29AM -0400, Alan Stern wrote:
> On Mon, 18 Apr 2016, Peter Chen wrote:
> 
> > On Wed, Apr 06, 2016 at 09:32:22AM +0300, Roger Quadros wrote:
> > > On 06/04/16 09:09, Felipe Balbi wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> > > >> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > > >> index 2ca2cef..6b1930d 100644
> > > >> --- a/drivers/usb/core/hcd.c
> > > >> +++ b/drivers/usb/core/hcd.c
> > > >> @@ -2706,6 +2706,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
> > > >>  	int retval;
> > > >>  	struct usb_device *rhdev;
> > > >>  
> > > >> +	hcd->flags = 0;
> > > > 
> > > > seems like this would make more sense in usb_del_hcd() instead.
> > > > 
> > > 
> > > OK, I'll move it there.
> > > 
> > 
> > It depends on Alan's comments, whether only usb_add_hcd/usb_del_hcd
> > pair can be called repeat. If Alan acks it, I have no idea for it.
> 
> Most of the host controller drivers were not written with this in mind,
> but I think it would be a good thing to allow.  It would speed up the
> host/device role switches.
> 
> This might mean we need to fix up several drivers to make them work 
> correctly in an OTG environment.  It should be possible to do this.  Is 
> there any particular reason why it would be difficult for Chipidea?
> 

I just want to do clean remove at OTG environment, like rmmod, so I did
this when I worked on chipidea OTG design.
I am worried if there are some resources dedicated for host device, eg,
clocks, gpio. etc.

If OTG framework can know well hcd's add and remove, it is ok for chipidea
just calling usb_add_hcd/usb_del_hcd currently, but I suggested roger
adding platform hcd_ops as optional parameter in case the platform
has special requirement for hcd_ops.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
