From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: MUSB regression in 2.6.31-rc6
Date: Sat, 15 Aug 2009 20:40:00 +0300
Message-ID: <20090815174000.GA13164@nokia.com>
References: <20090815174352.c2883585.jhnikula@gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0305398E07@dbde02.ent.ti.com>
 <20090815180701.7710de51.jhnikula@gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32875 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbZHORlG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 13:41:06 -0400
Content-Disposition: inline
In-Reply-To: <20090815180701.7710de51.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

On Sat, Aug 15, 2009 at 05:07:01PM +0200, ext Jarkko Nikula wrote:
> On Sat, 15 Aug 2009 20:19:17 +0530
> "Gadiyar, Anand" <gadiyar@ti.com> wrote:
> 
> > > diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> > > index 803adcb..e27ed96 100644
> > > --- a/drivers/usb/musb/Kconfig
> > > +++ b/drivers/usb/musb/Kconfig
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
> 
> I happened to have both of these below enabled and 2.6.31-rc5 was still
> booting.
> 
> CONFIG_TWL4030_USB=y
> CONFIG_NOP_USB_XCEIV=y
> 
> But anyway, I don't get Beagle booting with 2.6.31-rc6 if I disable any
> of them and IRCC another oops will follow if both are disabled.

There's a patch from me adding back the twl4030_usb pdata to beagle
board-file and another one from Paul which changed the defconfig.

It should be easy to find on the archives. Eduardo Valentin reported
that to me so I was asking him to test the stuff for me.

-- 
balbi
