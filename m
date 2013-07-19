From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Date: Thu, 18 Jul 2013 23:29:41 -0700
Message-ID: <20130719062941.GA23611@kroah.com>
References: <1374129984-765-1-git-send-email-kishon@ti.com>
 <1374129984-765-2-git-send-email-kishon@ti.com>
 <20130718072004.GA16720@kroah.com>
 <51E7AE88.3050007@ti.com>
 <20130718154954.GA31961@kroah.com>
 <51E8D086.809@ti.com>
 <20130719054311.GA14638@kroah.com>
 <51E8D4E0.8060200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51E8D4E0.8060200-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 19, 2013 at 11:25:44AM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Friday 19 July 2013 11:13 AM, Greg KH wrote:
> > On Fri, Jul 19, 2013 at 11:07:10AM +0530, Kishon Vijay Abraham I wrote:
> >>>>>> +	ret = dev_set_name(&phy->dev, "%s.%d", dev_name(dev), id);
> >>>>>
> >>>>> Your naming is odd, no "phy" anywhere in it?  You rely on the sender to
> >>>>> never send a duplicate name.id pair?  Why not create your own ids based
> >>>>> on the number of phys in the system, like almost all other classes and
> >>>>> subsystems do?
> >>>>
> >>>> hmm.. some PHY drivers use the id they provide to perform some of their
> >>>> internal operation as in [1] (This is used only if a single PHY provider
> >>>> implements multiple PHYS). Probably I'll add an option like PLATFORM_DEVID_AUTO
> >>>> to give the PHY drivers an option to use auto id.
> >>>>
> >>>> [1] ->
> >>>> http://archive.arm.linux.org.uk/lurker/message/20130628.134308.4a8f7668.ca.html
> >>>
> >>> No, who cares about the id?  No one outside of the phy core ever should,
> >>> because you pass back the only pointer that they really do care about,
> >>> if they need to do anything with the device.  Use that, and then you can
> >>
> >> hmm.. ok.
> >>
> >>> rip out all of the "search for a phy by a string" logic, as that's not
> >>
> >> Actually this is needed for non-dt boot case. In the case of dt boot, we use a
> >> phandle by which the controller can get a reference to the phy. But in the case
> >> of non-dt boot, the controller can get a reference to the phy only by label.
> > 
> > I don't understand.  They registered the phy, and got back a pointer to
> > it.  Why can't they save it in their local structure to use it again
> > later if needed?  They should never have to "ask" for the device, as the
> 
> One is a *PHY provider* driver which is a driver for some PHY device. This will
> use phy_create to create the phy.
> The other is a *PHY consumer* driver which might be any controller driver (can
> be USB/SATA/PCIE). The PHY consumer will use phy_get to get a reference to the
> phy (by *phandle* in the case of dt boot and *label* in the case of non-dt boot).
> > device id might be unknown if there are multiple devices in the system.
> 
> I agree with you on the device id part. That need not be known to the PHY driver.

How does a consumer know which "label" to use in a non-dt system if
there are multiple PHYs in the system?

Do you have any drivers that are non-dt using this yet?

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
