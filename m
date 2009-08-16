From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: MUSB regression in 2.6.31-rc6
Date: Sun, 16 Aug 2009 09:17:47 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404322AA358@dbde02.ent.ti.com>
References: <20090815174352.c2883585.jhnikula@gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0305398E07@dbde02.ent.ti.com>
 <20090815180701.7710de51.jhnikula@gmail.com>,<20090815174000.GA13164@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51675 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242AbZHPDr7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 23:47:59 -0400
In-Reply-To: <20090815174000.GA13164@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > > @@ -13,6 +13,7 @@ config USB_MUSB_HDRC
> > >         select NOP_USB_XCEIV if ARCH_DAVINCI
> > >         select TWL4030_USB if MACH_OMAP_3430SDP
> > >         select NOP_USB_XCEIV if MACH_OMAP3EVM
> > > +       select NOP_USB_XCEIV if MACH_OMAP3_BEAGLE
> >
> > Shouldn't we be selecting TWL4030_USB if MACH_OMAP3_BEAGLE.
> > The beagleboard does use the PHY in the TWL4030, and not
> > a transparent PHY.
> >
> Could be. I have no very much idea of these :-)

Beagle has to use TWL4030_USB only and not NOP_USB_XCEIV. 

The NOP registration was removed from common file usb-musb.c
to board specific file because different board uses different transceiver.

>
> I happened to have both of these below enabled and 2.6.31-rc5 was still
> booting.
>
> CONFIG_TWL4030_USB=y
> CONFIG_NOP_USB_XCEIV=y
>
> But anyway, I don't get Beagle booting with 2.6.31-rc6 if I disable any
> of them and IRCC another oops will follow if both are disabled.

For Beagle;  only CONFIG_TWL4030_USB=y is required and should work with that alone.

> There's a patch from me adding back the twl4030_usb pdata to beagle
> board-file and another one from Paul which changed the defconfig.

It seems this dependency might be the cause why CONFIG_TWL4030_USB=y alone
didn't work as reported by Nikula.

> It should be easy to find on the archives. Eduardo Valentin reported
> that to me so I was asking him to test the stuff for me.


