From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Question regarding MUSB and dynamic fifo sizing
Date: Mon, 10 Aug 2009 21:48:19 +0300
Message-ID: <20090810184818.GA4281@gandalf>
References: <FCCFB4CDC6E5564B9182F639FC35608702F5988E89@dbde02.ent.ti.com>
 <1249672953.11736.76.camel@blitz>
 <20090807201712.GB9780@nokia.com>
 <20090808064313.GA11613@nokia.com>
 <20090808071705.GA11844@nokia.com>
 <1249914799.25044.4.camel@blitz>
 <20090810161605.GA4357@gandalf>
 <1249923607.31495.13.camel@blitz>
 <20090810170236.GA3528@gandalf>
 <1249925323.31495.31.camel@blitz>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43218 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbZHJSsa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 14:48:30 -0400
Content-Disposition: inline
In-Reply-To: <1249925323.31495.31.camel@blitz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>
Cc: me@felipebalbi.com, felipe.balbi@nokia.com, "Pandita, Vikram" <vikram.pandita@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, Aug 10, 2009 at 01:28:43PM -0400, Peter Barada wrote:
> On Mon, 2009-08-10 at 20:02 +0300, Felipe Balbi wrote:
> > Hi,
> > 
> > On Mon, Aug 10, 2009 at 01:00:07PM -0400, Peter Barada wrote:
> > > Actually, not quite.  I noticed that twl4030_vbus_work only sets Vbus,
> > > never clears it. 
> > > With that change and the driver configured for OTG mode (I had it host
> > > when I tested), it doesn't enumerate.
> > > 
> > > I added code to decipher the link state, and on startup I now see:
> > > 
> > > Jan  1 00:00:13 OMAP-35x user.debug kernel: twl4030_usb twl4030_usb:
> > > HW_CONDITIONS 0x72/114; link 1 (None)
> > > 
> > > Then when I load the driver:
> > > 
> > > Jan  1 00:01:30 OMAP-35x user.debug kernel: twl4030_usb twl4030_usb:
> > > HW_CONDITIONS 0xf2/242; link 2 (Vbus)
> > > Jan  1 00:01:30 OMAP-35x user.debug kernel: twl4030_usb twl4030_usb:
> > > HW_CONDITIONS 0x72/114; link 1 (None)
> > > 
> > > And when I plug in the OTG adapter/thumbdrive:
> > > 
> > > Jan  1 00:02:24 OMAP-35x user.debug kernel: twl4030_usb twl4030_usb:
> > > HW_CONDITIONS 0x76/118; link 3 (ID)
> > > 
> > > and Vbus goes to +5V 30mS after ID grounds, and stays at 5V for only
> > > 30mS then goes back to ground.  Pulling out and reinserting repeast the
> > > cycle.
> > > 
> > > During this total time, only two interrupts occur ont he MUSB
> > > controller.  It looks like the connect interrupt is not occuring.
> > > 
> > > I'm adding more code to track the interrupts for both the twl4030-usb
> > > and musb_hdrc so I can understand better what's happening (and more
> > > importantly what's not).
> > 
> > good you reported :-)
> > 
> > I was about to send a version to linux-usb. Let's see what's going on:
> > 
> > on you setup:
> > 
> > # echo 3 > /sys/modules/musb_hdrc/parameters/debug
> > # echo 9 > /proc/sysrq-trigger
> > 
> > this will give you more verbose output of what musb sees. BTW, it's odd
> > you get a VBUS link irq when there shouldn't be any unless you have the
> > board attached to pc at that time.
> 
> Nothing's attached to the OTG port at that time.  W/nothing plugged in
> from powerup, The log first shows:
> 
> Jan  1 12:26:13 OMAP-35x user.debug kernel: twl4030_usb twl4030_usb:
> HW_CONDITIONS 0x72/114; link 1 (None)
> 
> I rebuild with musb_debug=3 to get messages from the module on startup,
> and nothing plugges in from powerup, loading the module comes back with:
> 
> OMAP-35x# modprobe musb_hdrc
> musb_hdrc: version 6.0, pio, host, debug=3
> HS USB OTG: revision 0x33, sysconfig 0x2010, sysstatus 0x1, intrfsel
> 0x1, simenable  0x0
> musb_hdrc: ConfigData=0xde (UTMI-8, dyn FIFOs, bulk combine (X), bulk
> split (X), HB-ISO Rx, HB-ISO Tx, SoftConn)
> musb_hdrc: MHDRC RTL version 1.400
> musb_hdrc: setup fifo_mode 4
> musb_hdrc: 28/31 max ep, 16384/16384 memory
> musb_hdrc: hw_ep 0shared, max 64
> musb_hdrc: hw_ep 1tx, max 512
> musb_hdrc: hw_ep 1rx, max 512
> musb_hdrc: hw_ep 2tx, max 512
> musb_hdrc: hw_ep 2rx, max 512
> musb_hdrc: hw_ep 3tx, max 512
> musb_hdrc: hw_ep 3rx, max 512
> musb_hdrc: hw_ep 4tx, max 512
> musb_hdrc: hw_ep 4rx, max 512
> musb_hdrc: hw_ep 5tx, max 512
> musb_hdrc: hw_ep 5rx, max 512
> musb_hdrc: hw_ep 6tx, max 512
> musb_hdrc: hw_ep 6rx, max 512
> musb_hdrc: hw_ep 7tx, max 512
> musb_hdrc: hw_ep 7rx, max 512
> musb_hdrc: hw_ep 8tx, max 512
> musb_hdrc: hw_ep 8rx, max 512
> musb_hdrc: hw_ep 9tx, max 512
> musb_hdrc: hw_ep 9rx, max 512
> musb_hdrc: hw_ep 10tx, max 256
> musb_hdrc: hw_ep 10rx, max 64
> musb_hdrc: hw_ep 11tx, max 256
> musb_hdrc: hw_ep 11rx, max 64
> musb_hdrc: hw_ep 12tx, max 256
> musb_hdrc: hw_ep 12rx, max 64
> musb_hdrc: hw_ep 13shared, max 4096
> musb_hdrc: hw_ep 14shared, max 1024
> musb_hdrc: hw_ep 15shared, max 1024
> musb_hdrc: USB Host mode controller at d80ab000 using PIO, IRQ 92
> musb_hdrc musb_hdrc: MUSB HDRC host driver
> musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
> usb usb1: configuration #1 chosen from 1 choice
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> musb_start 883: <== devctl 80
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: MUSB HDRC host driver
> usb usb1: Manufacturer: Linux 2.6.28-rc8-omap1-05704-gf6ea2bb-dirty
> musb-hcd
> usb usb1: SerialNumber: musb_hdrc
> musb_init_controller 2057: HOST mode, status 0, devctl 81 B
> twl4030_usb twl4030_usb: HW_CONDITIONS 0xf2/242; link 2 (Vbus)
> OMAP-35x# musb_stage2_irq 812: SUSPEND (b_idle) devctl 91 power e0
> twl4030_usb twl4030_usb: HW_CONDITIONS 0x72/114; link 1 (None)
> 
> Looking at the schematics, outside of a 4.7uF between Vbus and ground,
> nothing else is connected to the OTG D+, D-, ID, or Vbus except the
> connector...
> 
> 1) With the twl4030 triggering Vbus, the MUSB must think its a
> peripheral, and then goes into suspend - why would the twl4030 think its
> getting Vbus supplied to it?

donno yet, no clue unfortunately.

but could you try the following

1. connect micro-a cable and see what happens and what musb tells you ?
2. disconnect micro-a and connect micro-b to pc, what happens in that
case ?
3. remove micro-b and go back to micro-a, what happens now ?

please get such logs and post it here so we can discuss it further

-- 
balbi
