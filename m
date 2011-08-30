From: Bob Liu <lliubbo@gmail.com>
Subject: musb power issue on beagleboard-xM
Date: Tue, 30 Aug 2011 12:24:07 +0800
Message-ID: <CAA_GA1d_Em44nHc_jzZ_FcSbm8x+zsu160o+MgBd1q-K1LBuMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48947 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab1H3EYI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 00:24:08 -0400
Received: by qyk34 with SMTP id 34so4250942qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 21:24:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, folks

I tried to enable musb on beagleboard-xM. But it always failed with
"insufficient available bus power".

I am using linux-3.0 from linus git tree.
Do i need to use a hub?  But i heard that musb doesn't support hub.

Thanks.


# dmesg | grep 'musb'
musb-hdrc: version 6.0, pio, host
omap_device: musb-omap2430.-1: new worst case activate latency 0: 30517
musb-hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine, bulk
split, HB-ISO Rx, HB-ISO Tx, SoftConn)
musb-hdrc: MHDRC RTL version 1.800
musb-hdrc: setup fifo_mode 4
musb-hdrc: 28/31 max ep, 16384/16384 memory
musb-hdrc musb-hdrc: MUSB HDRC host driver
musb-hdrc musb-hdrc: new USB bus registered, assigned bus number 1
usb usb1: Manufacturer:  musb-hcd
usb usb1: SerialNumber: musb-hdrc
musb-hdrc musb-hdrc: USB OTG mode controller at fa0ab000 using PIO, IRQ 92
#
#
# usb 1-1: new high speed USB device number 2 using musb-hdrc
usb 1-1: New USB device found, idVendor=0781, idProduct=5406
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: U3 Cruzer Micro
usb 1-1: Manufacturer: SanDisk Corporation
usb 1-1: SerialNumber: 0000188A1671738F
usb 1-1: rejected 1 configuration due to insufficient available bus power
usb 1-1: no configuration chosen from 1 choice
#

-- 
Regards,
--Bob
