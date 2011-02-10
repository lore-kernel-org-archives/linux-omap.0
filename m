From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: Latest config warning
Date: Thu, 10 Feb 2011 13:48:54 +0200
Message-ID: <20110210114854.GJ3580@legolas.emea.dhcp.ti.com>
References: <20110107113506.GK1198@n2100.arm.linux.org.uk>
 <20110107164748.GC880@atomide.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024829AE8C@dbde02.ent.ti.com>
 <20110107192238.GD2272@legolas.emea.dhcp.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024894BC9D@dbde02.ent.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024894BC9D-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Premi, Sanjeev" <premi-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Feb 10, 2011 at 05:07:06PM +0530, Premi, Sanjeev wrote:
> > diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> > index 5a7c8f1..ac137d1 100644
> > --- a/drivers/usb/Kconfig
> > +++ b/drivers/usb/Kconfig
> > @@ -10,8 +10,6 @@ menuconfig USB_SUPPORT
> >           This option adds core support for Universal Serial Bus (USB).
> >           You will also need drivers from the following menu to make use
> > of it.
> > 
> > -if USB_SUPPORT
> > -
> >  # Host-side USB depends on having a host controller
> >  # NOTE:  dummy_hcd is always an option, but it's ignored here ...
> >  # NOTE:  SL-811 option should be board-specific ...
> > @@ -59,16 +57,9 @@ config USB_ARCH_HAS_OHCI
> >  # some non-PCI hcds implement EHCI
> >  config USB_ARCH_HAS_EHCI
> >         boolean
> > -       default y if PPC_83xx
> > -       default y if PPC_MPC512x
> > -       default y if SOC_AU1200
> > -       default y if ARCH_IXP4XX
> > -       default y if ARCH_W90X900
> > -       default y if ARCH_AT91SAM9G45
> > -       default y if ARCH_MXC
> > -       default y if ARCH_OMAP3
> > -       default y if ARCH_CNS3XXX
> > -       default PCI
> > +       default n
> > +
> > +if USB_SUPPORT
> > 
> >  # ARM SA1111 chips have a non-PCI based "OHCI-compatible" USB host
> > interface.
> >  config USB
> > 
> > and expect ARCH Kconfigs to select the features they have.
> > 
> > Greg, what do you think ?
> > 
> 
> I noticed same problem when building kernel from latest master today.
> 
> Felipe, Greg:
>  Do you have agreement on what would be good fix for this warning?

Yeah, I never got a reply about the proposal above. Greg, what do you
think ?

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
