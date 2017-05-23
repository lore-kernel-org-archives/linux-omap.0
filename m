From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/3] usb: host: ohci-platform: Add basic runtime PM
 support
Date: Tue, 23 May 2017 10:46:50 -0700
Message-ID: <20170523174649.GX10472@atomide.com>
References: <20170522160007.9264-2-tony@atomide.com>
 <Pine.LNX.4.44L0.1705231250110.1853-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1705231250110.1853-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> [170523 09:57]:
> On Mon, 22 May 2017, Tony Lindgren wrote:
> > Alan, do you have some better ideas for the ohci_platform_remove()
> > path below?
...
> > --- a/drivers/usb/host/ohci-platform.c
> > +++ b/drivers/usb/host/ohci-platform.c
> > @@ -290,7 +294,14 @@ static int ohci_platform_remove(struct platform_device *dev)
> >  	struct usb_hcd *hcd = platform_get_drvdata(dev);
> >  	struct usb_ohci_pdata *pdata = dev_get_platdata(&dev->dev);
> >  	struct ohci_platform_priv *priv = hcd_to_ohci_priv(hcd);
> > -	int clk, rst;
> > +	int clk, rst, enabled;
> > +
> > +	enabled = pm_runtime_get_sync(&dev->dev);
> > +	if (enabled < 0) {
> > +		dev_warn(&dev->dev, "pm_runtime_get failed: %i\n",
> > +			 enabled);
> > +		pm_runtime_put_noidle(&dev->dev);
> > +	}
> 
> I wouldn't worry about checking the return value.  There's no 
> particular reason for this call to fail, is there?

OK yeah if it was to fail it would already fail on probe
already :)

> >  	usb_remove_hcd(hcd);
> >  
> > @@ -305,6 +316,10 @@ static int ohci_platform_remove(struct platform_device *dev)
> >  
> >  	usb_put_hcd(hcd);
> >  
> > +	if (enabled >= 0)
> > +		pm_runtime_put_sync(&dev->dev);
> > +	pm_runtime_disable(&dev->dev);
> 
> And here you could just do the put_sync, with no test.  If the get_sync
> failed then this will probably fail too, but you won't be any worse off
> for the attempt.

OK fine with me.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
