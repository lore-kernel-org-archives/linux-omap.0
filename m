From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: usb generalization
Date: Thu, 24 Apr 2008 21:51:51 +0300
Message-ID: <1209063112-30352-1-git-send-email-felipe.balbi@nokia.com>
References: <200804241129.28213.david-b@pacbell.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:65071 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbYDXSxr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 14:53:47 -0400
In-Reply-To: <200804241129.28213.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: david-b@pacbell.net

Hi all,

Here's an updated version of the usb generalization.

Please give it a good review, it might be that I missed something in the
middle although it seems to be working nice in my 3430sdp.

I need someone to test on 2430sdp and give it an ack as well.

Here's some output from minicom:

ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
ehci-omap ehci-omap.0: USB 0.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OMAP-EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.25-omap1-08065-g11978e7 ehci_hcd
usb usb1: SerialNumber: ehci-omap.0
zero gadget: Gadget Zero, version: Lughnasadh, 2007
zero gadget: using musb_hdrc, OUT ep1out IN ep1in
musb_hdrc musb_hdrc.0: MUSB HDRC host driver
musb_hdrc musb_hdrc.0: new USB bus registered, assigned bus number 2
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: MUSB HDRC host driver
usb usb2: Manufacturer: Linux 2.6.25-omap1-08065-g11978e7 musb-hcd
usb usb2: SerialNumber: musb_hdrc.0

BR,
	- Balbi

