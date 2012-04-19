From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Thu, 19 Apr 2012 11:01:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204191059581.2070-100000@iolanthe.rowland.org>
References: <4F901CCC.9000703@compulab.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F901CCC.9000703-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 19 Apr 2012, Igor Grinberg wrote:

> ping
> 
> Alan, Felipe,
> Can this go into 3.5?

It's okay with me.

Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>

> The dependency patch has already reached Samuel's tree,
> what would be the best way to apply this one?
> Should I ask Samuel to apply this one also (after having your acks)
> via his tree, to reduce possible merge failures/conflicts?

Sure, go ahead.

> On 03/27/12 16:08, Igor Grinberg wrote:
> > When PHY reset pin is connected to a GPIO on external GPIO chip
> > (e.g. I2C), we should not call the gpio_set_value() function, but
> > gpio_set_value_cansleep().
> > 
> > Signed-off-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> > ---
> > This patch depends on the patch from Keshava [1]:
> > ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
> > 
> > [1] http://www.spinics.net/lists/linux-omap/msg66774.html
> > 
> >  drivers/usb/host/ehci-omap.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> > index 5c78f9e..26e9241 100644
> > --- a/drivers/usb/host/ehci-omap.c
> > +++ b/drivers/usb/host/ehci-omap.c
> > @@ -258,10 +258,10 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
> >  		udelay(10);
> >  
> >  		if (gpio_is_valid(pdata->reset_gpio_port[0]))
> > -			gpio_set_value(pdata->reset_gpio_port[0], 1);
> > +			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 1);
> >  
> >  		if (gpio_is_valid(pdata->reset_gpio_port[1]))
> > -			gpio_set_value(pdata->reset_gpio_port[1], 1);
> > +			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 1);
> >  	}
> >  
> >  	return 0;

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
