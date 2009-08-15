From: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: MUSB regression in 2.6.31-rc6
Date: Sat, 15 Aug 2009 18:07:01 +0300
Message-ID: <20090815180701.7710de51.jhnikula@gmail.com>
References: <20090815174352.c2883585.jhnikula@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0305398E07@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0305398E07-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sat, 15 Aug 2009 20:19:17 +0530
"Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org> wrote:

> > diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> > index 803adcb..e27ed96 100644
> > --- a/drivers/usb/musb/Kconfig
> > +++ b/drivers/usb/musb/Kconfig
> > @@ -13,6 +13,7 @@ config USB_MUSB_HDRC
> >         select NOP_USB_XCEIV if ARCH_DAVINCI
> >         select TWL4030_USB if MACH_OMAP_3430SDP
> >         select NOP_USB_XCEIV if MACH_OMAP3EVM
> > +       select NOP_USB_XCEIV if MACH_OMAP3_BEAGLE
> 
> Shouldn't we be selecting TWL4030_USB if MACH_OMAP3_BEAGLE.
> The beagleboard does use the PHY in the TWL4030, and not
> a transparent PHY.
> 
Could be. I have no very much idea of these :-)

I happened to have both of these below enabled and 2.6.31-rc5 was still
booting.

CONFIG_TWL4030_USB=y
CONFIG_NOP_USB_XCEIV=y

But anyway, I don't get Beagle booting with 2.6.31-rc6 if I disable any
of them and IRCC another oops will follow if both are disabled.


-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
