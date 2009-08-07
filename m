From: Peter Barada <peterb@logicpd.com>
Subject: RE: Question regarding MUSB and dynamic fifo sizing
Date: Fri, 07 Aug 2009 13:23:37 -0400
Message-ID: <1249665817.11736.21.camel@blitz>
References: <1249589441.10885.75.camel@blitz>
	 <5A47E75E594F054BAF48C5E4FC4B92AB0305398DE4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:16415 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751839AbZHGRTo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Aug 2009 13:19:44 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0305398DE4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Fri, 2009-08-07 at 01:41 +0530, Gadiyar, Anand wrote:
> Peter Barada wrote:
> > I'm running into a problem where the MUSB controller stops talking with
> > the hardwired device on the other end, and I wasn to unload the musb as
> > a module and reload it to the connection working again.
> > 
> > I can compile MSUB as a module, but when I load it the 2nd time it
> > complains with:
> > 
> > OMAP-35x# modprobe musb_hdrc
> > musb_hdrc: version 6.0, pio, otg (peripheral+host), debug=0
> > musb_core_init 1421: reconfigure software for static FIFOs
> > musb_hdrc musb_hdrc: musb_init_controller failed with status -19
> > 
> > This is due to the platform device wanting dynamic fifo sizing but the
> > CONFIGDATA register has DYNFIFO bit cleared.  Looking through the TRM, I
> > can't find informaiton on how the MUSB controller changes the state of
> > DYNFIFO - I'm guessing once any of the dynamic registers are written to
> > that the controller switches to Dynamic Fifo sizing.
> 
> This patch from Ajay (already in mainline) should fix it for you.
> 
> <http://marc.info/?l=linux-usb&m=124881724122257&w=2>
> 
> The problem is not that the CONFIGDATA changes, but that we attempt
> to read from CONFIGDATA without having set the INDEX register to 0.
> 
> CONFIGDATA is a read-only register.

Thanks, that patch allows me to modprobe/rmmod the musb_hdrc module, but
shows another problem - after a modprobe/rmmod/modprobe of the musb_hdrc
driver I don't see any USB devices downstream of the MUSB:

I have the following setup plugged in at boot(and left plugged in):

MUSB -> OTG cable -> Hub -> thumbdrive

When I modprobe the driver the first time I get:

OMAP-35x# modprobe musb_hdrc
musb_hdrc: version 6.0, pio, host, debug=0
musb_hdrc: USB Host mode controller at d80ab000 using PIO, IRQ 92
musb_hdrc musb_hdrc: MUSB HDRC host driver
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: MUSB HDRC host driver
usb usb1: Manufacturer: Linux 2.6.28-rc8-omap1-05704-gf6ea2bb-dirty
musb-hcd
usb usb1: SerialNumber: musb_hdrc
usb 1-1: new high speed USB device using musb_hdrc and address 2
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-1: New USB device found, idVendor=05e3, idProduct=0608
usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
usb 1-1: Product: USB2.0 Hub
hub 1-1:1.0: hub_port_status failed (err = -110)
hub 1-1:1.0: hub_port_status failed (err = -110)
hub 1-1:1.0: hub_port_status failed (err = -110)
hub 1-1:1.0: hub_port_status failed (err = -110)
OMAP-35x# lsusb
Bus 001 Device 002: ID 05e3:0608 Genesys Logic, Inc.
Bus 001 Device 001: ID 1d6b:0002
OMAP-35x#

Rmmod'ng the driver shows:

OMAP-35x# rmmod musb_hdrc
musb_hdrc musb_hdrc: remove, state 1
usb usb1: USB disconnect, address 1
usb 1-1: USB disconnect, address 2
musb_hdrc musb_hdrc: USB bus 1 deregistered

But modprobing the musb_hdrc driver a 2nd time shows:

OMAP-35x# modprobe musb_hdrc
musb_hdrc: version 6.0, pio, host, debug=0
musb_hdrc: USB Host mode controller at d80ab000 using PIO, IRQ 92
musb_hdrc musb_hdrc: MUSB HDRC host driver
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: MUSB HDRC host driver
usb usb1: Manufacturer: Linux 2.6.28-rc8-omap1-05704-gf6ea2bb-dirty
musb-hcd
usb usb1: SerialNumber: musb_hdrc
OMAP-35x#
OMAP-35x# lsusb
Bus 001 Device 001: ID 1d6b:0002

And it fails to find the hub or thumbdrive.

1) Any idea why I'd see -ETIMEDOUT from musb_hdrc on the first modprobe?

2) Any ideas why musb_hdrc finds the hub/thumbdrive on the first
modprobe, but not the 2nd?

3) I don't see any twl4030_usb interrupts from kernel boot - should I
see them?

Thanks in advance!

-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
