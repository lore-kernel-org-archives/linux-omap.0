From: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/3] usb: dwc3: dwc3-st: Add st-dwc3 devicetree
 bindings documentation
Date: Thu, 21 Aug 2014 15:03:47 +0100
Message-ID: <20140821140347.GA21073@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1406734091-16202-1-git-send-email-peter.griffin@linaro.org>
 <1406734091-16202-3-git-send-email-peter.griffin@linaro.org>
 <20140820180005.GU24500@saruman.home>
 <20140821133340.GC17487@griffinp-ThinkPad-X1-Carbon-2nd>
 <20140821135620.GD9608@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140821135620.GD9608-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peppe.cavallaro-qxv4g6HH51o@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Thu, 21 Aug 2014, Felipe Balbi wrote:

> > Currently (in the vendor tree) one of the phys lives in
> > drivers/usb/phy and the other in drivers/phy.
> > I believe that is because one is only a usb phy and the other is a
> > multi function phy which can drive PCI-E or USB3.
> 
> right, but for mainline, we can have both PHYs in drivers/phy only.

Ah ok, I didn't know that, so thanks for that info.
> 
> > So to make that work, when dwc3/core.c gets the PHYS in
> > dwc3_core_get_phy() we need to use the different bindings.
> > 
> > I think we are the only platform using "one of each", but luckily
> > dwc3_core_get_phy() has been written generically enough that it "just
> > works" :-).
> 
> true, but I want to drop support for the legacy drivers/usb/phy layer
> from dwc3. I'll try to move all PHYs to drivers/phy for v3.18.

Ok, so for the next re-spin I will change this to just use the generic phy binding
for both usb2 & usb3 phys.

In parallel I will also migrate over the drivers/usb/phy driver to be just a generic phy
before I attempt to upstream it.

regards,

Peter



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
