From: twebb <taliaferro62@gmail.com>
Subject: Re: usb-to-eth dongle on usb ehci host port
Date: Thu, 23 Apr 2009 16:00:00 -0400
Message-ID: <dbdb2ea60904231300q6fb09390hf0ab0222393bc2e@mail.gmail.com>
References: <dbdb2ea60904231213p7872804elc5cc6f72db445c55@mail.gmail.com>
	 <1240515055.7362.218.camel@sax-lx.fischerfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:48693 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbZDWUAE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 16:00:04 -0400
Received: by gxk10 with SMTP id 10so1542000gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 23 Apr 2009 13:00:02 -0700 (PDT)
In-Reply-To: <1240515055.7362.218.camel@sax-lx.fischerfamily.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: todd.fischer@ridgerun.com, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, "omapandroid-discussion@omapzoom.org" <omapandroid-discussion@omapzoom.org>

>
> Sounds like the usb device didn't get recognized as an ethernet adapt=
or.=A0 I
> use netgear fa120 USB ethernet adaptor with my beagleboard and it wor=
ks
> great.
>
> Next time include some boot output and we can likely provide more spe=
cific
> suggestions.
>
> Todd
>

Here are portions of output from kernel startup.  It does look like it
recognizes it ("REALTEK USB 10/100 LAN"), but how to tell if it
recognizes it specifically as a eth adaptor?

twebb

=2E..
usbcore: registered new interface driver asix
usbcore: registered new interface driver cdc_ether
usbcore: registered new interface driver net1080
usbcore: registered new interface driver cdc_subset
usbcore: registered new interface driver zaurus
i2c /dev entries driver
Driver 'sd' needs updating - please use bus_type methods
usbmon: debugfs is not available
drivers/usb/host/ehci-omap.c:omap_start_ehc, TLL is Active, val =3D 0x9=
, count =3D 5
000
ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
usb usb1: Product: OMAP-EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.27-omap1-svn168-dirty1 ehci_hcd
usb usb1: SerialNumber: ehci-omap.0
Initializing USB Mass Storage driver...
usb 1-2: new high speed USB device using ehci-omap and address 2
usb 1-2: configuration #1 chosen from 1 choice
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 3 ports detected
usb 1-2: New USB device found, idVendor=3D0424, idProduct=3D2513
usb 1-2: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
usb 1-2.2: new full speed USB device using ehci-omap and address 3
usb 1-2.2: configuration #1 chosen from 1 choice
usb 1-2.2: New USB device found, idVendor=3D0bda, idProduct=3D8150
usb 1-2.2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D=
3
usb 1-2.2: Product: USB 10/100 LAN
usb 1-2.2: Manufacturer: REALTEK
usb 1-2.2: SerialNumber: 8918
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbtest
zero gadget: Gadget Zero, version: Cinco de Mayo 2008
zero gadget: zero ready
musb_hdrc musb_hdrc: MUSB HDRC host driver
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 2
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0002
usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D=
1
usb usb2: Product: MUSB HDRC host driver
usb usb2: Manufacturer: Linux 2.6.27-omap1-svn168-dirty1 musb-hcd
usb usb2: SerialNumber: musb_hdrc
=2E..
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
