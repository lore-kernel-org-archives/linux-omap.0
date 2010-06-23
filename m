From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] select NOP_USB_XCEIV for OMAP4
Date: Thu, 24 Jun 2010 04:33:20 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032366AD24@dbde02.ent.ti.com>
References: <1277318873-8260-1-git-send-email-x0132446@ti.com>
 <87k4ppqyk2.fsf@deeprootsystems.com>
 <61951E1F-DEBF-450C-AF06-E0119DA3B33E@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <61951E1F-DEBF-450C-AF06-E0119DA3B33E-oe7qfRrRQfcdWmXj+hCI//P6llvjuJOh@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Hunter, Jon" <jon-hunter-l0cyMroinI0@public.gmane.org>
Cc: "Anders, David" <x0132446-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Koen Kooi wrote:
> Op 23 jun 2010, om 22:33 heeft Kevin Hilman het volgende geschreven:
> > David Anders <x0132446-l0cyMroinI0@public.gmane.org> writes:
> > 
> >> Add select statement to force selection of NOP_USB_XCEIV for OMAP4.
> >> 
> >> Signed-off-by: David Anders <x0132446-l0cyMroinI0@public.gmane.org>
> >> ---
> >> drivers/usb/musb/Kconfig |    1 +
> >> 1 files changed, 1 insertions(+), 0 deletions(-)
> >> 
> >> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> >> index cfd38ed..e4624bc 100644
> >> --- a/drivers/usb/musb/Kconfig
> >> +++ b/drivers/usb/musb/Kconfig
> >> @@ -11,6 +11,7 @@ config USB_MUSB_HDRC
> >> 	depends on (USB || USB_GADGET)
> >> 	depends on (ARM || (BF54x && !BF544) || (BF52x && !BF522 && !BF523))
> >> 	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
> >> +	select NOP_USB_XCEIV if ARCH_OMAP4
> >> 	select TWL4030_USB if MACH_OMAP_3430SDP
> >> 	select USB_OTG_UTILS
> >> 	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
> > 
> > Shouldn't this be a board-specific option, and not set for every
> > OMAP4-based config?
> 
> If that's true, why do the  davinci and blackfin archs force it?
> 

Kevin's right. For OMAP4 at least, this is something that is probably'
best left up to the board to select.

For the davinci's and blackfins, they don't have an option. They have
a fully transparent internal PHY which doesn't need any configuring.


However, with the OMAP4, you could potentially use an external ULPI transceiver.
This can be another transparent PHY for which we could select the NOP_XCEIV.
Or it could be something like the PHY in the TWL5030 which may need configuring
over an I2C interface.


- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
