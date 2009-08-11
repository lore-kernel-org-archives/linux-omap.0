From: Peter Barada <peterb@logicpd.com>
Subject: Re: Question regarding MUSB and dynamic fifo sizing
Date: Tue, 11 Aug 2009 11:21:17 -0400
Message-ID: <1250004077.18768.17.camel@blitz>
References: <20090807201712.GB9780@nokia.com>
	 <20090808064313.GA11613@nokia.com> <20090808071705.GA11844@nokia.com>
	 <1249914799.25044.4.camel@blitz> <20090810161605.GA4357@gandalf>
	 <1249923607.31495.13.camel@blitz> <20090810170236.GA3528@gandalf>
	 <1249925323.31495.31.camel@blitz> <20090810184818.GA4281@gandalf>
	 <1249936961.31495.87.camel@blitz>  <20090811063305.GB4573@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:17620 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753171AbZHKPRP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Aug 2009 11:17:15 -0400
In-Reply-To: <20090811063305.GB4573@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Tue, 2009-08-11 at 09:33 +0300, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Aug 10, 2009 at 10:42:41PM +0200, ext Peter Barada wrote:
> > Since the twl4030 thinks its got Vbus, I've added code to dump the
> > TWL4030 register accesses and other structure in the twl4030-usb.c code
> > to understand what its doing. So, from power up(with nothing connected),
> > I see:
> > 
> > twl4030_usb twl4030_usb: ++ twl4030_usb_ldo_init:
> > twl4030_usb twl4030_usb: -- twl4030_usb_ldo_init:
> > twl4030_usb twl4030_usb: ++ twl4030_usb_irq:
> > twl4030_usb twl4030_usb: twl4030_readb: module 12 address 0f data 72
> > twl4030_usb twl4030_usb: HW_CONDITIONS 0x72/114; link 1 (None)
> > twl4030_usb twl4030_usb: ++ twl4030_phy_suspend: controller_off 0
> > twl4030_usb twl4030_usb: -- twl4030_usb_irq:
> > twl4030_usb twl4030_usb: Initialized TWL4030 USB module
> > twl4030_usb twl4030_usb: twl4030_usb_write: address 0c data 20
> > 
> > 1) The only write is from twl4030_vbus_work to clear DRVBUS in OTG_CTRL
> > since HW_CONDITION shows Vbus and ID not set.
> 
> that's ok, so far.
> 
> > modprobe of the driver gives
> > 
> > OMAP-35x# modprobe musb_hdrc
> > musb_hdrc: version 6.0, pio, host, debug=3
> > twl4030_usb twl4030_usb: ++ twl4030_phy_resume:
> > twl4030_usb twl4030_usb: ++ twl4030_phy_power: on 1
> > twl4030_usb twl4030_usb: twl4030_readb: module 00 address fd data 01
> > twl4030_usb twl4030_usb: twl4030_i2c_write_u8_verify: module 00 address
> > fd data 00
> > twl4030_usb twl4030_usb: twl4030_readb: module 00 address fe data 06
> > twl4030_usb twl4030_usb: twl4030_usb_write: address fe data 06
> > twl4030_usb twl4030_usb: -- twl4030_phy_power:
> > twl4030_usb twl4030_usb: twl4030_i2c_access: on 1
> > twl4030_usb twl4030_usb: twl4030_readb: module 00 address fe data 06
> > twl4030_usb twl4030_usb: twl4030_i2c_write_u8_verify: module 00 address
> > fe data 07
> > twl4030_usb twl4030_usb: twl4030_readb: module 00 address ff data 01
> > twl4030_usb twl4030_usb: twl4030_readb: module 00 address ff data 01
> > twl4030_usb twl4030_usb: -- twl4030_i2c_access:
> > twl4030_usb twl4030_usb: twl4030_usb_set_mode: mode 1
> > twl4030_usb twl4030_usb: twl4030_usb_write: address 09 data 04
> > twl4030_usb twl4030_usb: twl4030_usb_write: address ad data 20
> > twl4030_usb twl4030_usb: twl4030_usb_write: address 06 data 1b
> > twl4030_usb twl4030_usb: -- twl4030_usb_set_mode:
> > twl4030_usb twl4030_usb: twl4030_i2c_access: on 0
> > twl4030_usb twl4030_usb: twl4030_readb: module 00 address fe data 07
> > twl4030_usb twl4030_usb: twl4030_i2c_write_u8_verify: module 00 address
> > fe data 06
> > twl4030_usb twl4030_usb: -- twl4030_i2c_access:
> > twl4030_usb twl4030_usb: -- twl4030_phy_resume:
> > HS USB OTG: revision 0x33, sysconfig 0x2010, sysstatus 0x1, intrfsel
> > 0x1, simenable  0x0
> > musb_hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine (X), bulk
> > split (X), HB-ISO Rx, HB-ISO Tx, SoftConn)
> > musb_hdrc: MHDRC RTL version 1.400
> > musb_hdrc: setup fifo_mode 4
> > musb_hdrc: 28/31 max ep, 16384/16384 memory
> > musb_hdrc: hw_ep 0shared, max 64
> > musb_hdrc: hw_ep 1tx, max 512
> > musb_hdrc: hw_ep 1rx, max 512
> > musb_hdrc: hw_ep 2tx, max 512
> > musb_hdrc: hw_ep 2rx, max 512
> > musb_hdrc: hw_ep 3tx, max 512
> > musb_hdrc: hw_ep 3rx, max 512
> > musb_hdrc: hw_ep 4tx, max 512
> > musb_hdrc: hw_ep 4rx, max 512
> > musb_hdrc: hw_ep 5tx, max 512
> > musb_hdrc: hw_ep 5rx, max 512
> > musb_hdrc: hw_ep 6tx, max 512
> > musb_hdrc: hw_ep 6rx, max 512
> > musb_hdrc: hw_ep 7tx, max 512
> > musb_hdrc: hw_ep 7rx, max 512
> > musb_hdrc: hw_ep 8tx, max 512
> > musb_hdrc: hw_ep 8rx, max 512
> > musb_hdrc: hw_ep 9tx, max 512
> > musb_hdrc: hw_ep 9rx, max 512
> > musb_hdrc: hw_ep 10tx, max 256
> > musb_hdrc: hw_ep 10rx, max 64
> > musb_hdrc: hw_ep 11tx, max 256
> > musb_hdrc: hw_ep 11rx, max 64
> > musb_hdrc: hw_ep 12tx, max 256
> > musb_hdrc: hw_ep 12rx, max 64
> > musb_hdrc: hw_ep 13shared, max 4096
> > musb_hdrc: hw_ep 14shared, max 1024
> > musb_hdrc: hw_ep 15shared, max 1024
> > musb_hdrc: USB Host mode controller at d80ab000 using PIO, IRQ 92
> > musb_hdrc musb_hdrc: MUSB HDRC host driver
> > musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
> > usb usb1: configuration #1 chosen from 1 choice
> > hub 1-0:1.0: USB hub found
> > hub 1-0:1.0: 1 port detected
> > musb_start 883: <== devctl 80
> > usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> > usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> > usb usb1: Product: MUSB HDRC host driver
> > usb usb1: Manufacturer: Linux 2.6.28-rc8-omap1-05704-gf6ea2bb-dirty
> > musb-hcd
> > usb usb1: SerialNumber: musb_hdrc
> > musb_init_controller 2057: HOST mode, status 0, devctl 81 B
> > twl4030_usb twl4030_usb: ++ twl4030_usb_irq:
> > twl4030_usb twl4030_usb: twl4030_readb: module 12 address 0f data f2
> > twl4030_usb twl4030_usb: HW_CONDITIONS 0xf2/242; link 2 (Vbus)
> > twl4030_usb twl4030_usb: ++ twl4030_phy_resume:
> > twl4030_usb twl4030_usb: -- twl4030_usb_irq:
> > twl4030_usb twl4030_usb: twl4030_usb_write: address 0c data 20
> > OMAP-35x# musb_stage2_irq 812: SUSPEND (b_idle) devctl 91 power e0
> > twl4030_usb twl4030_usb: ++ twl4030_usb_irq:
> > twl4030_usb twl4030_usb: twl4030_readb: module 12 address 0f data 72
> > twl4030_usb twl4030_usb: HW_CONDITIONS 0x72/114; link 1 (None)
> > twl4030_usb twl4030_usb: ++ twl4030_phy_suspend: controller_off 0
> > twl4030_usb twl4030_usb: ++ twl4030_phy_power: on 0
> > twl4030_usb twl4030_usb: twl4030_usb_write: address 0c data 20
> > twl4030_usb twl4030_usb: twl4030_readb: module 00 address fd data 00
> > twl4030_usb twl4030_usb: twl4030_i2c_write_u8_verify: module 00 address
> > fd data 01
> > twl4030_usb twl4030_usb: -- twl4030_phy_power:
> > twl4030_usb twl4030_usb: -- twl4030_phy_suspend:
> > twl4030_usb twl4030_usb: -- twl4030_usb_irq:
> > 
> > 
> > As you can see, the twl4030-usb interrupt triggers and HW_CONDITIONS
> > shows that Vbus is set. At this point, musb_hdrc (apparently) tries to
> > talk to the device that it assumes is attached, and since nothing is out
> > there, triggers the SUSPEND interrupt and then the twl4030 triggers to
> > pull Vbus.
> 
> weird you got a suspend irq. that should only come when musb sees 3
> consecutive SOFs.
> 
> Anyways, that shouldn't harm, and that new device found is just the
> roothub. Should be fine as well.
> 
> > > 1. connect micro-a cable and see what happens and what musb tells you ?
> > 
> > twl4030_usb twl4030_usb: ++ twl4030_usb_irq:
> > twl4030_usb twl4030_usb: twl4030_readb: module 12 address 0f data 76
> > twl4030_usb twl4030_usb: HW_CONDITIONS 0x76/118; link 3 (ID)
> > twl4030_usb twl4030_usb: ++ twl4030_phy_resume:
> > twl4030_usb twl4030_usb: ++ twl4030_phy_power: on 1
> > twl4030_usb twl4030_usb: twl4030_usb_write: address 0b data 20
> > twl4030_usb twl4030_usb: twl4030_readb: module 00 address fd data 01
> > twl4030_usb twl4030_usb: twl4030_i2c_write_u8_verify: module 00 address
> > fd data 00
> > twl4030_usb twl4030_usb: twl4030_readb: module 00 address fe data 06
> > twl4030_usb twl4030_usb: twl4030_usb_write: address fe data 06
> > twl4030_usb twl4030_usb: -- twl4030_phy_power:
> > twl4030_usb twl4030_usb: ++ twl4030_i2c_access: on 1
> > twl4030_usb twl4030_usb: twl4030_readb: module 00 address fe data 06
> > twl4030_usb twl4030_usb: twl4030_i2c_write_u8_verify: module 00 address
> > fe data 07
> > twl4030_usb twl4030_usb: twl4030_readb: module 00 address ff data 01
> > twl4030_usb twl4030_usb: twl4030_readb: module 00 address ff data 01
> > twl4030_usb twl4030_usb: -- twl4030_i2c_access:
> > twl4030_usb twl4030_usb: ++ twl4030_usb_set_mode: mode 1
> > twl4030_usb twl4030_usb: twl4030_usb_write: address 09 data 04
> > twl4030_usb twl4030_usb: twl4030_usb_write: address ad data 20
> > twl4030_usb twl4030_usb: twl4030_usb_write: address 06 data 1b
> > twl4030_usb twl4030_usb: -- twl4030_usb_set_mode:
> > twl4030_usb twl4030_usb: twl4030_i2c_access: on 0
> > twl4030_usb twl4030_usb: twl4030_readb: module 00 address fe data 07
> > twl4030_usb twl4030_usb: twl4030_i2c_write_u8_verify: module 00 address
> > fe data 06
> > twl4030_usb twl4030_usb: -- twl4030_i2c_access:
> > twl4030_usb twl4030_usb: -- twl4030_phy_resume:
> > twl4030_usb twl4030_usb: -- twl4030_usb_irq:
> 
> but this is weird. When you connect micro-A, vbus should go on and musb
> should set the session bit in the devctl register. Maybe that's what
> it's missing.
> 
> let's try some other hackish test, apply this patch and after connecting
> micro-a cable do: echo 1 > /sys/devices/platform/musb_hdrc/connect

Unfortunately, with the patch, and:

1) modprobe musb_hdrc
2) modprobe g_ether
3) connect micro-a cable
4) echo 1 > /sys/devices/platform/musb_hdrc/connect

Nothing happens - no isr or output.

-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
