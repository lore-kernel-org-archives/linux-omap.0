From: Michael Grzeschik <mgr-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: core: continue probe even if usb3 phy is
 not available
Date: Fri, 28 Jun 2013 22:06:01 +0200
Message-ID: <20130628200601.GK3523@pengutronix.de>
References: <1372238954-29047-1-git-send-email-george.cherian@ti.com>
 <20130626101647.GT12640@arwen.pp.htv.fi>
 <51CAD977.6040309@ti.com>
 <20130626121210.GA12640@arwen.pp.htv.fi>
 <874nclghu2.fsf@ashishki-desk.ger.corp.intel.com>
 <20130627061416.GI3523@pengutronix.de>
 <20130627063526.GG15455@arwen.pp.htv.fi>
 <20130627072408.GJ3523@pengutronix.de>
 <20130627073033.GN15455@arwen.pp.htv.fi>
 <20130628180000.GF25498@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130628180000.GF25498-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Alexander Shishkin <alexander.shishkin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 28, 2013 at 09:00:00PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Jun 27, 2013 at 10:30:33AM +0300, Felipe Balbi wrote:
> > Hi,
> > 
> > On Thu, Jun 27, 2013 at 09:24:08AM +0200, Michael Grzeschik wrote:
> > > > > > > right, but in DT you will define both instances and each instance will
> > > > > > > have a seaparate snps,maximum_speed attribute :-)
> > > > > > >
> > > > > > > I'm now considering if we should make maximum_speed a generic attribute,
> > > > > > > Kishon ? Alex ? Alan ?
> > > > > > >
> > > > > > > anyone else needs such thing ?
> > > > > > 
> > > > > > We have a force-full-speed attibute for chipidea on the way. This
> > > > > > maximum_speed looks like a more generic alternative. Michael, what say
> > > > > > you?
> > > > > 
> > > > > The maximum_speed attribute sounds more reasonable. I will change my
> > > > > patch to it.
> > > > 
> > > > thanks, perhaps we can add a generic helper in udc-core or usb-common ?
> > > 
> > > As this function is not only udc specific, this should go into usb-common.
> > > But right, we should go with a helper here. I will write one in addition
> > > to my full-speed patch as first user of it.
> > 
> > alright, thanks :-)
> 
> Michael, if you need any help with patching in maximum_speed attribute,
> let me know as I have some time to work on that part.

Feel free to begin with anything. I am currently short on time.
Do you need some pointers?

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
