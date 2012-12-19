From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/RFT] ARM: OMAP1: fix USB host on 1710
Date: Wed, 19 Dec 2012 14:57:22 -0800
Message-ID: <20121219225722.GR4989@atomide.com>
References: <1355954828-4701-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20724 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750854Ab2LSW5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 17:57:25 -0500
Content-Disposition: inline
In-Reply-To: <1355954828-4701-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

Hi,

* Aaro Koskinen <aaro.koskinen@iki.fi> [121219 14:10]:
> There seems to be a longstanding bug that OHCI USB host controller
> does not respond on 1710, possibly because of wrong clocks. Has it ever
> worked?

Don't know about 770, but I used to have an old CF card reader
hooked to my osk5912 and it was working.

> See e.g. http://marc.info/?l=linux-omap&m=119634441229321&w=2. All
> register reads return just zeroes:
> 
> [    1.896606] ohci ohci: OMAP OHCI
> [    1.912597] ohci ohci: new USB bus registered, assigned bus number 1
> [    1.933776] ohci ohci: irq 38, io mem 0xfffba000
> [    2.012573] ohci ohci: init err (00000000 0000)
> [    2.030334] ohci ohci: can't start
> [    2.046661] ohci ohci: startup error -75
> [    2.063201] ohci ohci: USB bus 1 deregistered
> 
> After some experiments, it seems that when changing the usb_dc_ck /
> SOFT_REQ enable bit from USB_REQ_EN_SHIFT to SOFT_USB_OTG_DPLL_REQ_SHIFT
> (like done also on 7XX), the USB appears to work (tested on Nokia 770):
> 
> [    2.183959] ohci ohci: OMAP OHCI
> [    2.198242] ohci ohci: new USB bus registered, assigned bus number 1
> [    2.215820] ohci ohci: irq 38, io mem 0xfffba000
> [    2.324798] hub 1-0:1.0: USB hub found
> [    2.361267] hub 1-0:1.0: 3 ports detected

Cool seems like you've fixed a long standing bug :)
And also have tahvo-usb working?
 
> Can someone test if this works also on 16xx and 5912? It seems the current
> clock data format does not allow to make this change only for 1710...

Does not seem to make a difference, I get the following on
osk5912 with and without your patch:

hci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd: block sizes: ed 64 td 64
ohci ohci: OMAP OHCI
ohci ohci: new USB bus registered, assigned bus number 1
ohci ohci: starting USB Controller
ohci ohci: created debug files
ohci ohci: irq 38, io mem 0xfffba000
ohci ohci: OHCI controller state
ohci ohci: OHCI 1.0, NO legacy support registers, rh state running
ohci ohci: control 0x283 RWC HCFS=operational CBSR=3
ohci ohci: cmdstatus 0x00000 SOC=0
ohci ohci: intrstatus 0x00000004 SF
ohci ohci: intrenable 0x8000005a MIE RHSC UE RD WDH
ohci ohci: hcca frame #002f
ohci ohci: roothub.a 0a000003 POTPGT=10 NDP=3(3)
ohci ohci: roothub.b 000e0000 PPCM=000e DR=0000
ohci ohci: roothub.status 00008000 DRWE
ohci ohci: roothub.portstatus [0] 0x00000100 PPS
ohci ohci: roothub.portstatus [1] 0x00000100 PPS
ohci ohci: roothub.portstatus [2] 0x00000100 PPS
usb usb1: default language 0x0409
usb usb1: udev 1, busnum 1, minor = 0
usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OMAP OHCI
usb usb1: Manufacturer: Linux 3.7.0-00024-gf7c4407 ohci_hcd
usb usb1: SerialNumber: ohci
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: 250mA bus power budget for each child
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports

Regards,

Tony
