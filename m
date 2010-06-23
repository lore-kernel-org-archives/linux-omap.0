From: "Anders, David" <x0132446@ti.com>
Subject: RE: [PATCH] select NOP_USB_XCEIV for OMAP4
Date: Wed, 23 Jun 2010 16:10:59 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A879A845653@dlee01.ent.ti.com>
References: <1277318873-8260-1-git-send-email-x0132446@ti.com>
 <87k4ppqyk2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42596 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab0FWVLG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 17:11:06 -0400
In-Reply-To: <87k4ppqyk2.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Wednesday, June 23, 2010 3:33 PM
> To: Anders, David
> Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; Gupta, Ajay
> Kumar; felipe.balbi@nokia.com
> Subject: Re: [PATCH] select NOP_USB_XCEIV for OMAP4
> 
> David Anders <x0132446@ti.com> writes:
> 
> > Add select statement to force selection of NOP_USB_XCEIV for OMAP4.
> >
> > Signed-off-by: David Anders <x0132446@ti.com>
> > ---
> >  drivers/usb/musb/Kconfig |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> > index cfd38ed..e4624bc 100644
> > --- a/drivers/usb/musb/Kconfig
> > +++ b/drivers/usb/musb/Kconfig
> > @@ -11,6 +11,7 @@ config USB_MUSB_HDRC
> >  	depends on (USB || USB_GADGET)
> >  	depends on (ARM || (BF54x && !BF544) || (BF52x && !BF522 && !BF523))
> >  	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
> > +	select NOP_USB_XCEIV if ARCH_OMAP4
> >  	select TWL4030_USB if MACH_OMAP_3430SDP
> >  	select USB_OTG_UTILS
> >  	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
> 
> Shouldn't this be a board-specific option, and not set for every
> OMAP4-based config?
> 

As I understand it, any of the omap4 devices that are using the Inventra need to have at a minimum of the NOP USB Transceiver. Enabling the NOP transceiver doesn't preclude the use of other external transceivers. The NOP USB Transceiver will still need to be registered in the board-specific machine file therefore doesn't impact a board that doesn't use it.

Dave
