From: Peter Barada <peterb@logicpd.com>
Subject: RE: Question regarding MUSB and dynamic fifo sizing
Date: Fri, 07 Aug 2009 15:22:33 -0400
Message-ID: <1249672953.11736.76.camel@blitz>
References: <1249589441.10885.75.camel@blitz>
	 <5A47E75E594F054BAF48C5E4FC4B92AB0305398DE4@dbde02.ent.ti.com>
	 <1249665817.11736.21.camel@blitz>
	 <FCCFB4CDC6E5564B9182F639FC35608702F5988E89@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:25962 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933037AbZHGTSk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Aug 2009 15:18:40 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F5988E89@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, 2009-08-07 at 22:55 +0530, Pandita, Vikram wrote:
> 
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Peter
> >Barada
> >Sent: Friday, August 07, 2009 12:24 PM
> >To: Gadiyar, Anand
> >Cc: linux-omap
> >Subject: RE: Question regarding MUSB and dynamic fifo sizing
> >
> >On Fri, 2009-08-07 at 01:41 +0530, Gadiyar, Anand wrote:
> >> Peter Barada wrote:
> >> > I'm running into a problem where the MUSB controller stops talking with
> >> > the hardwired device on the other end, and I wasn to unload the musb as
> >> > a module and reload it to the connection working again.
> >> >
> >> > I can compile MSUB as a module, but when I load it the 2nd time it
> >> > complains with:
> >> >
> >> > OMAP-35x# modprobe musb_hdrc
> >> > musb_hdrc: version 6.0, pio, otg (peripheral+host), debug=0
> >> > musb_core_init 1421: reconfigure software for static FIFOs
> >> > musb_hdrc musb_hdrc: musb_init_controller failed with status -19
> >> >
> >> > This is due to the platform device wanting dynamic fifo sizing but the
> >> > CONFIGDATA register has DYNFIFO bit cleared.  Looking through the TRM, I
> >> > can't find informaiton on how the MUSB controller changes the state of
> >> > DYNFIFO - I'm guessing once any of the dynamic registers are written to
> >> > that the controller switches to Dynamic Fifo sizing.
> >>
> >> This patch from Ajay (already in mainline) should fix it for you.
> >>
> >> <http://marc.info/?l=linux-usb&m=124881724122257&w=2>
> >>
> >> The problem is not that the CONFIGDATA changes, but that we attempt
> >> to read from CONFIGDATA without having set the INDEX register to 0.
> >>
> >> CONFIGDATA is a read-only register.
> >
> >Thanks, that patch allows me to modprobe/rmmod the musb_hdrc module, but
> >shows another problem - after a modprobe/rmmod/modprobe of the musb_hdrc
> >driver I don't see any USB devices downstream of the MUSB:
> >
> >I have the following setup plugged in at boot(and left plugged in):
> >
> >MUSB -> OTG cable -> Hub -> thumbdrive
> >
> >When I modprobe the driver the first time I get:
> >
> >hub 1-1:1.0: hub_port_status failed (err = -110)
> >hub 1-1:1.0: hub_port_status failed (err = -110)
> >hub 1-1:1.0: hub_port_status failed (err = -110)
> >hub 1-1:1.0: hub_port_status failed (err = -110)
> >OMAP-35x# lsusb
> >Bus 001 Device 002: ID 05e3:0608 Genesys Logic, Inc.
> >Bus 001 Device 001: ID 1d6b:0002
> 
> 
> Do things work fine without the hub for multiple insmod/rmmod?
> Case = MUSB -> OTG cable -> thumbdrive
> 
> Is hub introducing some issue here looking at above logs?

Someting strange is going on.  If I boot with the MUSB->OTG adapter ->
thumbdrive plugged in, and then modprobe the driver, it finds the
thumbdrive.  I can then remove/reinsert the OTG adapter -> thumbdrive
multiple times, and each time it is enumerated.

If I boot w/o the OTG adapter -> thumbdrive plugged in, modprobe the
musb driver, and then plug in the OTG adaptor ->thumbdrive, it is not
enumerated.

Any idea why I need the OTG adapter -> thumbdrive plugged in at kernel
boot for it to enumerate the thumbdrive?


-- 
Peter Barada <peterb@logicpd.com>
Logic Product Development, Inc.
