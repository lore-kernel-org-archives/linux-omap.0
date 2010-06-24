From: "Anders, David" <x0132446@ti.com>
Subject: RE: [PATCH] select NOP_USB_XCEIV for OMAP4
Date: Thu, 24 Jun 2010 09:38:27 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A879A8E0D9E@dlee01.ent.ti.com>
References: <1277318873-8260-1-git-send-email-x0132446@ti.com>
 <87k4ppqyk2.fsf@deeprootsystems.com>
 <61951E1F-DEBF-450C-AF06-E0119DA3B33E@student.utwente.nl>
 <5A47E75E594F054BAF48C5E4FC4B92AB032366AD24@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43789 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755562Ab0FXOib convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 10:38:31 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032366AD24@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Kevin Hilman <khilman@deeprootsystems.com>, "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

> -----Original Message-----
> From: Gadiyar, Anand
> Sent: Wednesday, June 23, 2010 6:03 PM
> To: Koen Kooi; Kevin Hilman; Hunter, Jon
> Cc: Anders, David; linux-usb@vger.kernel.org; linux-omap@vger.kernel.org;
> Gupta, Ajay Kumar; felipe.balbi@nokia.com
> Subject: RE: [PATCH] select NOP_USB_XCEIV for OMAP4
> 
> Koen Kooi wrote:
> > Op 23 jun 2010, om 22:33 heeft Kevin Hilman het volgende geschreven:
> > > David Anders <x0132446@ti.com> writes:
> > >
> > >> Add select statement to force selection of NOP_USB_XCEIV for OMAP4.
> > >>
> > >> Signed-off-by: David Anders <x0132446@ti.com>
> > >> ---
> > >> drivers/usb/musb/Kconfig |    1 +
> > >> 1 files changed, 1 insertions(+), 0 deletions(-)
> > >>
> > >> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> > >> index cfd38ed..e4624bc 100644
> > >> --- a/drivers/usb/musb/Kconfig
> > >> +++ b/drivers/usb/musb/Kconfig
> > >> @@ -11,6 +11,7 @@ config USB_MUSB_HDRC
> > >> 	depends on (USB || USB_GADGET)
> > >> 	depends on (ARM || (BF54x && !BF544) || (BF52x && !BF522 && !BF523))
> > >> 	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
> > >> +	select NOP_USB_XCEIV if ARCH_OMAP4
> > >> 	select TWL4030_USB if MACH_OMAP_3430SDP
> > >> 	select USB_OTG_UTILS
> > >> 	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
> > >
> > > Shouldn't this be a board-specific option, and not set for every
> > > OMAP4-based config?
> >
> > If that's true, why do the  davinci and blackfin archs force it?
> >
> 
> Kevin's right. For OMAP4 at least, this is something that is probably'
> best left up to the board to select.
> 
> For the davinci's and blackfins, they don't have an option. They have
> a fully transparent internal PHY which doesn't need any configuring.
> 
> 
> However, with the OMAP4, you could potentially use an external ULPI
> transceiver.
> This can be another transparent PHY for which we could select the
> NOP_XCEIV.
> Or it could be something like the PHY in the TWL5030 which may need
> configuring
> over an I2C interface.
> 
> 
> - Anand

Normally I would agree with you, however there are a number of items that I would like to iterate:

1. 100% of the currently known OMAP4 platforms use the NOP, wouldn't it be easier to add an exception if/when one exists rather than add each individual board that does require the NOP?

2. Including the NOP does not preclude the usage of another transceiver, simply don't register the NOP in your machine file.

3. The omap3_defconfig already has the NOP enabled. If we are pushing towards a unified defconfig for omap2/3/4, then the NOP will be enabled anyway. Linus is already pushing for more decisions to be made directly in the Kconfig and consoldation of defconfigs(and/or removal of them).

4. The NOP will need to be enabled if we intend to truly push for a "Multi-Boot" image that will boot multiple omap3 and omap4 platforms. For example if we have a kernel image that is intended to boot the 4430sdp, blaze, panda, and board-X(with an external transceiver), NOP is going to be included anyway.


If the community in general is going to push for consolidated defconfigs, more robust decision making in Kconfig, and Multi-Boot support, then the way we thinking about what goes into Kconfig will have to change as well.


Dave

