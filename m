From: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: dwc3: core: continue probing if usb phy library
 returns -ENODEV/-ENXIO
Date: Mon, 27 Jan 2014 17:08:55 +0200
Message-ID: <20140127150855.GA17928@xps8300>
References: <1385373690-12170-1-git-send-email-kishon@ti.com>
 <1390299099-14764-1-git-send-email-kishon@ti.com>
 <20140121144725.GF30451@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140121144725.GF30451-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, george.cherian-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Tue, Jan 21, 2014 at 08:47:25AM -0600, Felipe Balbi wrote:
> On Tue, Jan 21, 2014 at 03:41:38PM +0530, Kishon Vijay Abraham I wrote:
> > Since PHYs for dwc3 is optional (not all SoCs that have DWC3 use PHYs),
> > do not return from probe if the USB PHY library returns -ENODEV as that
> 
> this isn't correct, they all have PHYs, some of them might not be
> controllable.
> 
> > indicates the platform does not have PHY.
> 
> not really, that indicates the current platform tried to grab a PHY and
> the PHY doesn't exist. If there's anybody with a non-controllable PHY
> and someone gives me a really good reason for not using the generic
> no-op PHY, then we should add a flag and we could:
> 
> 	if (!likely(dwc->flags & DWC3_USB2PHY_DRIVER_NOT_NEEDED))
> 		dwc3_grab_phys(dwc);

Why would you need to know if the PHY drivers are needed or not
explicitly in your controller driver?

> But I really want to see the argument against using no-op. As far as I
> could see, everybody needs a PHY driver one way or another, some
> platforms just haven't sent any PHY driver upstream and have their own
> hacked up solution to avoid using the PHY layer.

Not true in our case. Platforms using Intel's SoCs and chip sets may
or may not have controllable USB PHY. Quite often they don't. The
Baytrails have usually ULPI PHY for USB2, but that does not mean they
provide any vendor specific functions or any need for a driver in any
case.

Are we talking about the old USB PHY library or the new PHY framework
with the no-op PHY driver?

Well, in any case, I don't understand what is the purpose of the no-op
PHY driver. What are you drying to achieve with that?


Thanks,

-- 
heikki
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
