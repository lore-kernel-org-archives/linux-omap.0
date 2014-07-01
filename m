From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: am335x: linux 3.16-rc3: USB DMA issue
Date: Tue, 1 Jul 2014 15:03:48 +0200
Message-ID: <CAGm1_kuA8nYvqHXYbg5kULCujzOYEBW6AAijeQt3yzg_P9=EHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:61485 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbaGANEI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 09:04:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: linux-usb <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Roger Quadros <rogerq@ti.com>

I have following system:

USB0: host mode (USB hub is soldered internally)
USB1: OTG mode with OTG connector

My DTS: http://pastebin.com/KB3iTehQ

If I enable DMA in the kernel, I get USB0 working, i.e. USB hub is
detected and USB devices, that are connected to this hub are also
detected and working. The USB thumb drive connected to USB1 won't be
detected.

# lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 2: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
        |__ Port 3: Dev 3, If 0, Class=Communications, Driver=cdc_acm, 12M
        |__ Port 3: Dev 3, If 1, Class=CDC Data, Driver=cdc_acm, 12M

of_get_named_gpiod_flags: can't parse gpios property of node
'/ocp/usb@47400000/usb-phy@47401300[0]'
47401300.usb-phy supply vcc not found, using dummy regulator
musb-hdrc musb-hdrc.0.auto: Failed to request rx1.
musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
platform musb-hdrc.0.auto: Driver musb-hdrc requests probe deferral
of_get_named_gpiod_flags: can't parse gpios property of node
'/ocp/usb@47400000/usb-phy@47401b00[0]'
47401b00.usb-phy supply vcc not found, using dummy regulator
musb-hdrc musb-hdrc.1.auto: Failed to request rx1.
musb-hdrc musb-hdrc.1.auto: musb_init_controller failed with status -517
platform musb-hdrc.1.auto: Driver musb-hdrc requests probe deferral
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk
split, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
musb-hdrc musb-hdrc.0.auto: MUSB HDRC host driver
musb-hdrc musb-hdrc.0.auto: new USB bus registered, assigned bus number 1
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: MUSB HDRC host driver
usb usb1: Manufacturer: Linux 3.16.0-rc3-00006-g16874b2 musb-hcd
usb usb1: SerialNumber: musb-hdrc.0.auto
musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk
split, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
musb-hdrc musb-hdrc.1.auto: MUSB HDRC host driver
musb-hdrc musb-hdrc.1.auto: new USB bus registered, assigned bus number 2
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: MUSB HDRC host driver
usb usb2: Manufacturer: Linux 3.16.0-rc3-00006-g16874b2 musb-hcd
usb usb2: SerialNumber: musb-hdrc.1.auto
usb 1-1: new high-speed USB device number 2 using musb-hdrc
usb 1-1: New USB device found, idVendor=05e3, idProduct=0608
usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 1-1: Product: USB2.0 Hub
usb 1-1.3: new full-speed USB device number 3 using musb-hdrc
usb 1-1.3: New USB device found, idVendor=1546, idProduct=01a7
usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1.3: Product: u-blox 7 - GPS/GNSS Receiver
usb 1-1.3: Manufacturer: u-blox AG - www.u-blox.com
usb 1-1.2: new high-speed USB device number 4 using musb-hdrc
usb 1-1.2: New USB device found, idVendor=1307, idProduct=0165
usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1.2: Product: USB Mass Storage Device
usb 1-1.2: Manufacturer: USBest Technology
usb 1-1.2: SerialNumber: 00000000000504
usb-storage 1-1.2:1.0: USB Mass Storage device detected
scsi0 : usb-storage 1-1.2:1.0

If I disable DMA in the kernel, I have reverse behavior: USB1 is
working, USB0 doesn't see the hub.

# lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Mass Storage, Driver=usb-storage, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=musb-hdrc/1p, 480M

of_get_named_gpiod_flags: can't parse gpios property of node
'/ocp/usb@47400000/usb-phy@47401300[0]'
47401300.usb-phy supply vcc not found, using dummy regulator
musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk
split, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
musb-hdrc musb-hdrc.0.auto: MUSB HDRC host driver
musb-hdrc musb-hdrc.0.auto: new USB bus registered, assigned bus number 1
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: MUSB HDRC host driver
usb usb1: Manufacturer: Linux 3.16.0-rc3-00006-g16874b2 musb-hcd
usb usb1: SerialNumber: musb-hdrc.0.auto
of_get_named_gpiod_flags: can't parse gpios property of node
'/ocp/usb@47400000/usb-phy@47401b00[0]'
47401b00.usb-phy supply vcc not found, using dummy regulator
musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk
split, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 2.0
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
musb-hdrc musb-hdrc.1.auto: MUSB HDRC host driver
musb-hdrc musb-hdrc.1.auto: new USB bus registered, assigned bus number 2
usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: MUSB HDRC host driver
usb usb2: Manufacturer: Linux 3.16.0-rc3-00006-g16874b2 musb-hcd
usb usb2: SerialNumber: musb-hdrc.1.auto
usb0: HOST MAC 02:97:91:6a:a9:c6
usb0: MAC 06:cf:9d:85:16:7f
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
usb 1-1: new high-speed USB device number 2 using musb-hdrc
usb 1-1: new high-speed USB device number 3 using musb-hdrc
usb 1-1: new high-speed USB device number 4 using musb-hdrc
usb 1-1: new high-speed USB device number 5 using musb-hdrc
usb 2-1: new high-speed USB device number 2 using musb-hdrc
usb 2-1: New USB device found, idVendor=1b8f, idProduct=0305
usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 2-1: Product: EXPRESS DUO
usb 2-1: Manufacturer: STT
usb 2-1: SerialNumber: 09021000000110490000000154
usb-storage 2-1:1.0: USB Mass Storage device detected
scsi0 : usb-storage 2-1:1.0

In 3.15 both interfaces were working. The only problem was, that my
GPS card didn't work with USB0 in DMA mode.

Regards,
Yegor
