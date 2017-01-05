From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] ARM: omap3: beagleboard-xm: dt: Add ethernet to the
 device tree
Date: Thu, 5 Jan 2017 08:39:29 -0800
Message-ID: <20170105163928.GD4310@atomide.com>
References: <1480713097-5931-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <CAL_Jsq+M7RWiytEA7zPZvR+7CK37WCxN5ZBOQkpjdswjLHL4fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+M7RWiytEA7zPZvR+7CK37WCxN5ZBOQkpjdswjLHL4fA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170105 08:28]:
> On Fri, Dec 2, 2016 at 3:11 PM, Laurent Pinchart
> <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> > The Beagleboard-xM has a LAN9514 USB hub and ethernet controller,
> > connected to port 2 of the OMAP EHCI controller. The board however has
> > no EEPROM to store the ethernet MAC address, which is programmed by the
> > boot loader.
> >
> > To allow Linux to use the same MAC address as the boot loader (or for
> > that matter any fixed MAC address), we need a node in the device tree
> > for the ethernet controller that the boot loader can update at runtime
> > with a local-mac-address property. Add it, along with an alias for the
> > ethernet controller to let the boot loader locate it easily.
> >
> > Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > ---
> > Changes since v1:
> >
> > - Renamed usb2 DT node to hub
> > ---
> >  arch/arm/boot/dts/omap3-beagle-xm.dts | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
> > index 85e297ed0ea1..673cee2234b2 100644
> > --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
> > +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
> > @@ -27,6 +27,7 @@
> >         aliases {
> >                 display0 = &dvi0;
> >                 display1 = &tv0;
> > +               ethernet = &ethernet;
> 
> Sorry, just noticed this, but this should be dropped. It's not used
> nor do we want an alias here.

OK, will update locally as I have not pushed out yet.

> P.S. The display ones are questionable, too. Only OMAP has them and
> per platform alias names is not something we want.

OK. What about the mmc ones? Otherwise the MMC devices keep moving
around depending on the kernel version..

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
