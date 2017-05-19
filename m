From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/4] usb: host: ohci-platform: Add basic runtime PM
 support
Date: Fri, 19 May 2017 10:52:32 -0700
Message-ID: <20170519175232.GG10472@atomide.com>
References: <20170517225922.17723-2-tony@atomide.com>
 <Pine.LNX.4.44L0.1705181313320.1619-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1705181313320.1619-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org> [170518 10:24]:
> On Wed, 17 May 2017, Tony Lindgren wrote:
> 
> > This is needed in preparation of adding support for omap3 and
> > later OHCI. The runtime PM will only do something on platforms
> > that implement it.
> 
> > @@ -51,6 +52,10 @@ static int ohci_platform_power_on(struct platform_device *dev)
> >  	struct ohci_platform_priv *priv = hcd_to_ohci_priv(hcd);
> >  	int clk, ret, phy_num;
> >  
> > +	ret = pm_runtime_get_sync(&dev->dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> 
> I don't remember how probing for platform device drivers is set up.    
> So although this is definitely the wrong place for 
> pm_runtime_get_sync(), it may turn out that you need to do a 
> pm_runtime_get_noresume() before calling pm_runtime_enable(), and a 
> pm_runtime_put() at the end of ohci_platform_probe().  Otherwise 
> runtime PM might kick in during the middle of the probe sequence -- not 
> what you want.

Just removing those parts seems to work for probing.

> Similarly, you may need pm_runtime_get_sync() at the start of 
> ohci_platform_remove() and pm_runtime_put_noidle() at the end.

Yup that I noticed that too trying to rmmod it with no devices
connected.

While testing I also saw once "external abort on non-linefetch":

(ohci_hub_status_data [ohci_hcd]) from [<bf0298bc>]
(usb_hcd_poll_rh_status+0x3c/0x128 [usbcore])
(usb_hcd_poll_rh_status [usbcore]) from [<c01c790c>]
(call_timer_fn+0xb0/0x3f8)
(call_timer_fn) from [<c01c7d38>] (expire_timers+0xe4/0x220)
(expire_timers) from [<c01c7f08>] (run_timer_softirq+0x94/0x19c)
(run_timer_softirq) from [<c0141cf8>] (__do_softirq+0x140/0x570)

Also I'm still checking if legacy usb_phy vs phy needs handling.
So far it seems that no need to do anything because most devices
need a USB hub anyways unless they have USB serial transceiver
configured with drivers/mfd/omap-usb-host.c for LS/FS.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
