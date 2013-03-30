From: Marc Murphy <marcmltd@marcm.co.uk>
Subject: AM3517 USB and OTG issues 3.9-rc1 kernel.
Date: Sat, 30 Mar 2013 09:01:21 +0000
Message-ID: <F690310232FDDF4AB457E8B3EF90DDE07A474399@MARCM-SBS2011.marcmltd.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm4.bt.bullet.mail.ird.yahoo.com ([212.82.108.235]:35741 "EHLO
	nm4.bt.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755239Ab3C3JBq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 30 Mar 2013 05:01:46 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello All,
I have a question about the updates/changes that have been made to the USB OTG support in the latest 3.9-rc1 kernel

My platform is using an AM3517 processor and I am in the progress of moving from 3.6 to 3.9 kernel because I need some of the iio support in the latest 3.9 kernel.
The last hurdle I have is in trying to get the USB OTG support working in HOST mode, as I am using it to connect a storage device to.

If I configure the kernel in the same way as I do for 3.6 it doesn't bring the interface up.
The log output is ;
[    0.897552] usbcore: registered new interface driver carl9170
[    0.903900] usbcore: registered new interface driver cdc_ether
[    0.910400] usbcore: registered new interface driver cdc_ncm
[    0.917327] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.924499] ehci-omap.0 supply hsusb0 not found, using dummy regulator
[    0.931549] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[    0.937927] ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
[    1.949218] ehci-omap ehci-omap.0: irq 93, io mem 0x48064800
[    1.968811] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
[    1.975067] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.982269] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.989929] usb usb1: Product: OMAP-EHCI Host Controller
[    1.995544] usb usb1: Manufacturer: Linux 3.9.0-rc1 ehci_hcd
[    2.001556] usb usb1: SerialNumber: ehci-omap.0
[    2.007507] hub 1-0:1.0: USB hub found
[    2.011596] hub 1-0:1.0: 3 ports detected
[    2.016967] usbcore: registered new interface driver cdc_wdm
[    2.023010] Initializing USB Mass Storage driver...
[    2.028472] usbcore: registered new interface driver usb-storage
[    2.034851] USB Mass Storage support registered.
[    2.040283] usbcore: registered new interface driver usbserial
[    2.046447] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
[    2.054107] 6Waiting for PHY clock good...
[    2.070343] mousedev: PS/2 mouse device common for all mice

The output from 3.6 shows usb2 being initialised and recognising the connected device.
[    1.369934] usbcore: registered new interface driver cdc_ether
[    1.376373] usbcore: registered new interface driver cdc_ncm
[    1.383361] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.390380] ehci-omap.0 supply hsusb0 not found, using dummy regulator
[    1.397399] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[    1.403717] ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
[    2.443176] ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
[    2.458770] ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
[    2.464935] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.472106] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.479675] usb usb1: Product: OMAP-EHCI Host Controller
[    2.485290] usb usb1: Manufacturer: Linux 3.6.0-rc6 ehci_hcd
[    2.491241] usb usb1: SerialNumber: ehci-omap.0
[    2.497039] hub 1-0:1.0: USB hub found
[    2.501098] hub 1-0:1.0: 3 ports detected
[    2.506134] usbcore: registered new interface driver cdc_wdm
[    2.512329] usbcore: registered new interface driver uas
[    2.517913] Initializing USB Mass Storage driver...
[    2.523345] usbcore: registered new interface driver usb-storage
[    2.529663] USB Mass Storage support registered.
[    2.534484] musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
[    2.541778] 6Waiting for PHY clock good...
[    2.560424] musb-hdrc musb-hdrc: MUSB HDRC host driver
[    2.566223] musb-hdrc musb-hdrc: new USB bus registered, assigned bus number 2
[    2.574035] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    2.581176] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.588775] usb usb2: Product: MUSB HDRC host driver
[    2.593994] usb usb2: Manufacturer: Linux 3.6.0-rc6 musb-hcd
[    2.599945] usb usb2: SerialNumber: musb-hdrc
[    2.605651] hub 2-0:1.0: USB hub found
[    2.609680] hub 2-0:1.0: 1 port detected
[    2.614166] musb-hdrc musb-hdrc: USB Host mode controller at d080e000 using PIO, IRQ 71
[    2.623504] mousedev: PS/2 mouse device common for all mice

Is there a known issue with the HOST support for OTG ? Or could there be something missing from the config ?
I have looked but can't see anything obvious.

Any help greatly appreciated.

Thanks
Marc


