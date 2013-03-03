From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 0/5] usb: musb: am335x support
Date: Sun, 03 Mar 2013 23:24:05 +0100
Message-ID: <87sj4cunp6.fsf@dell.be.48ers.dk>
References: <cover.1351870620.git.afzal@ti.com> <509420D8.1030307@gmail.com>
	<C8443D0743D26F4388EA172BF4E2A7A93EA0A1F2@DBDE01.ent.ti.com>
	<51312430.6060306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:58840 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649Ab3CCWYL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 Mar 2013 17:24:11 -0500
In-Reply-To: <51312430.6060306@gmail.com> (Daniel Mack's message of "Fri, 01
	Mar 2013 22:57:04 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, "Santhapuri, Damodar" <damodar.santhapuri@ti.com>, "B, Ravi" <ravibabu@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, Kishon Vijay Abraham I <kishon@ti.com>

>>>>> "Daniel" == Daniel Mack <zonque@gmail.com> writes:

Hi,

 Daniel> On my board, the USB is purely used as host interface, with a
 Daniel> type B plug soldered. In the DT, I'm using the following
 Daniel> sniplet in accordance to the documentation of the bindings:

 Daniel> 	usb_otg_hs: usb@47400000 {
 Daniel> 		compatible = "ti,musb-am33xx";
 Daniel> 		reg = <0x47400000 0x1000	/* usbss */
 Daniel> 		       0x47401000 0x800		/* musb instance 0 */
 Daniel> 		       0x47401800 0x800>;	/* musb instance 1 */
 Daniel> 		interrupt-parent = <&intc>;
 Daniel> 		interrupts = <17		/* usbss */
 Daniel> 			      18		/* musb instance 0 */
 19> ;		/* musb instance 1 */
 Daniel> 		multipoint = <1>;
 Daniel> 		num-eps = <16>;
 Daniel> 		ram-bits = <12>;
 Daniel> 		port0-mode = <3>;
 Daniel> 		port1-mode = <3>;
 Daniel> 		power = <250>;
 Daniel> 		ti,hwmods = "usb_otg_hs";
 Daniel> 	};

 Daniel> The relevant config options are

 Daniel> CONFIG_USB_MUSB_HDRC=y
 Daniel> # CONFIG_USB_MUSB_TUSB6010 is not set
 Daniel> # CONFIG_USB_MUSB_OMAP2PLUS is not set
 Daniel> # CONFIG_USB_MUSB_AM35X is not set
 Daniel> CONFIG_USB_MUSB_DSPS=y
 Daniel> CONFIG_MUSB_PIO_ONLY=y
 Daniel> CONFIG_USB_GADGET=y
 Daniel> CONFIG_USB_GADGET_DEBUG=y
 Daniel> CONFIG_USB_GADGET_DEBUG_FILES=y
 Daniel> CONFIG_USB_GADGET_DEBUG_FS=y
 Daniel> CONFIG_USB_GADGET_VBUS_DRAW=2
 Daniel> CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
 Daniel> CONFIG_USB_GADGET_MUSB_HDRC=y

Ehh, I'm confused here. You talk about host mode, a single 'B' (gadget)
connector and your device tree mentions 2 OTG ports.

What is the configuration exactly?

-- 
Bye, Peter Korsgaard
