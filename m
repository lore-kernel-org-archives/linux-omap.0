From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Mon, 04 Mar 2013 00:53:12 +0100
Message-ID: <5133E268.5010604@gmail.com>
References: <cover.1351870620.git.afzal@ti.com> <509420D8.1030307@gmail.com> <C8443D0743D26F4388EA172BF4E2A7A93EA0A1F2@DBDE01.ent.ti.com> <51312430.6060306@gmail.com> <87sj4cunp6.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:56139 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab3CCXxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 Mar 2013 18:53:17 -0500
In-Reply-To: <87sj4cunp6.fsf@dell.be.48ers.dk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, "Santhapuri, Damodar" <damodar.santhapuri@ti.com>, "B, Ravi" <ravibabu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, Kishon Vijay Abraham I <kishon@ti.com>

Hi Peter,

On 03.03.2013 23:24, Peter Korsgaard wrote:
>>>>>> "Daniel" == Daniel Mack <zonque@gmail.com> writes:
> 
> Hi,
> 
>  Daniel> On my board, the USB is purely used as host interface, with a
>  Daniel> type B plug soldered. In the DT, I'm using the following
>  Daniel> sniplet in accordance to the documentation of the bindings:
> 
>  Daniel> 	usb_otg_hs: usb@47400000 {
>  Daniel> 		compatible = "ti,musb-am33xx";
>  Daniel> 		reg = <0x47400000 0x1000	/* usbss */
>  Daniel> 		       0x47401000 0x800		/* musb instance 0 */
>  Daniel> 		       0x47401800 0x800>;	/* musb instance 1 */
>  Daniel> 		interrupt-parent = <&intc>;
>  Daniel> 		interrupts = <17		/* usbss */
>  Daniel> 			      18		/* musb instance 0 */
>  19> ;		/* musb instance 1 */
>  Daniel> 		multipoint = <1>;
>  Daniel> 		num-eps = <16>;
>  Daniel> 		ram-bits = <12>;
>  Daniel> 		port0-mode = <3>;
>  Daniel> 		port1-mode = <3>;
>  Daniel> 		power = <250>;
>  Daniel> 		ti,hwmods = "usb_otg_hs";
>  Daniel> 	};
> 
>  Daniel> The relevant config options are
> 
>  Daniel> CONFIG_USB_MUSB_HDRC=y
>  Daniel> # CONFIG_USB_MUSB_TUSB6010 is not set
>  Daniel> # CONFIG_USB_MUSB_OMAP2PLUS is not set
>  Daniel> # CONFIG_USB_MUSB_AM35X is not set
>  Daniel> CONFIG_USB_MUSB_DSPS=y
>  Daniel> CONFIG_MUSB_PIO_ONLY=y
>  Daniel> CONFIG_USB_GADGET=y
>  Daniel> CONFIG_USB_GADGET_DEBUG=y
>  Daniel> CONFIG_USB_GADGET_DEBUG_FILES=y
>  Daniel> CONFIG_USB_GADGET_DEBUG_FS=y
>  Daniel> CONFIG_USB_GADGET_VBUS_DRAW=2
>  Daniel> CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
>  Daniel> CONFIG_USB_GADGET_MUSB_HDRC=y
> 
> Ehh, I'm confused here. You talk about host mode, a single 'B' (gadget)
> connector

I'm sorry for the confusion caused. This is a stupid mistake - I'm in
fact talking about an 'A' type plug of course (host mode).

> and your device tree mentions 2 OTG ports.

That's what I said in a follow up - the same happens for mode '1'.

> What is the configuration exactly?

Again to summarize: host-only mode, type 'A' plug.

The gadget driver is is enabled in the config because the only
occurrence of usb_add_hcd() in the musb driver is in the gagdget part,
so supposedly, there has to be a gadget driver loaded in order to make
the host interface going.


Thanks,
Daniel

