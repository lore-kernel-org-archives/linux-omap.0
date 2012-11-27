From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Tue, 27 Nov 2012 09:02:23 -0800
Message-ID: <20121127170223.GB2687@kroah.com>
References: <CACVXFVNkp0+WmTyG2+YMjTvzCRi3sQZKmG6sG8diqZZj-hwg6g@mail.gmail.com>
 <Pine.LNX.4.44L0.1211271119380.1489-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1211271119380.1489-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 27, 2012 at 11:30:11AM -0500, Alan Stern wrote:
> On Tue, 27 Nov 2012, Ming Lei wrote:
> 
> > IMO, all matches mean the devices are inside the ehci-omap bus, so
> > the direct/simple way is to enable/disable the regulators in the probe() and
> > remove() of ehci-omap controller driver.
> 
> When this discussion started, Felipe argued against such an approach.  
> He pointed out that the same chip could be used in other platforms, and
> then the code added to ehci-omap.c would have to be duplicated in
> several other places.
> 
> We should have a more generic solution in a more central location, like 
> the device core.
> 
> For example, each struct platform_device could have a list of resources
> to be enabled when the device is bound to a driver and disabled when
> the device is unbound.  Such a list could include regulators, clocks,
> and whatever else people can invent.
> 
> In this case, when it is created the ehci-omap.0 platform device could
> get an entry pointing to the LAN95xx's regulator.  Then the regulator 
> would automatically be turned on when the platform device is bound to 
> the ehci-omap driver.
> 
> How does this sound?

That sounds much better, and it might come in handy for other types of
devices than platform devices, so feel free to put this on the core
'struct device' instead if needed.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
