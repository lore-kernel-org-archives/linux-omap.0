From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: Question regarding MUSB and dynamic fifo sizing
Date: Fri, 7 Aug 2009 22:55:57 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5988E89@dbde02.ent.ti.com>
References: <1249589441.10885.75.camel@blitz>
	 <5A47E75E594F054BAF48C5E4FC4B92AB0305398DE4@dbde02.ent.ti.com>
 <1249665817.11736.21.camel@blitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59014 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbZHGR0N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 13:26:13 -0400
In-Reply-To: <1249665817.11736.21.camel@blitz>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peterb@logicpd.com>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Peter
>Barada
>Sent: Friday, August 07, 2009 12:24 PM
>To: Gadiyar, Anand
>Cc: linux-omap
>Subject: RE: Question regarding MUSB and dynamic fifo sizing
>
>On Fri, 2009-08-07 at 01:41 +0530, Gadiyar, Anand wrote:
>> Peter Barada wrote:
>> > I'm running into a problem where the MUSB controller stops talking with
>> > the hardwired device on the other end, and I wasn to unload the musb as
>> > a module and reload it to the connection working again.
>> >
>> > I can compile MSUB as a module, but when I load it the 2nd time it
>> > complains with:
>> >
>> > OMAP-35x# modprobe musb_hdrc
>> > musb_hdrc: version 6.0, pio, otg (peripheral+host), debug=0
>> > musb_core_init 1421: reconfigure software for static FIFOs
>> > musb_hdrc musb_hdrc: musb_init_controller failed with status -19
>> >
>> > This is due to the platform device wanting dynamic fifo sizing but the
>> > CONFIGDATA register has DYNFIFO bit cleared.  Looking through the TRM, I
>> > can't find informaiton on how the MUSB controller changes the state of
>> > DYNFIFO - I'm guessing once any of the dynamic registers are written to
>> > that the controller switches to Dynamic Fifo sizing.
>>
>> This patch from Ajay (already in mainline) should fix it for you.
>>
>> <http://marc.info/?l=linux-usb&m=124881724122257&w=2>
>>
>> The problem is not that the CONFIGDATA changes, but that we attempt
>> to read from CONFIGDATA without having set the INDEX register to 0.
>>
>> CONFIGDATA is a read-only register.
>
>Thanks, that patch allows me to modprobe/rmmod the musb_hdrc module, but
>shows another problem - after a modprobe/rmmod/modprobe of the musb_hdrc
>driver I don't see any USB devices downstream of the MUSB:
>
>I have the following setup plugged in at boot(and left plugged in):
>
>MUSB -> OTG cable -> Hub -> thumbdrive
>
>When I modprobe the driver the first time I get:
>
>hub 1-1:1.0: hub_port_status failed (err = -110)
>hub 1-1:1.0: hub_port_status failed (err = -110)
>hub 1-1:1.0: hub_port_status failed (err = -110)
>hub 1-1:1.0: hub_port_status failed (err = -110)
>OMAP-35x# lsusb
>Bus 001 Device 002: ID 05e3:0608 Genesys Logic, Inc.
>Bus 001 Device 001: ID 1d6b:0002


Do things work fine without the hub for multiple insmod/rmmod?
Case = MUSB -> OTG cable -> thumbdrive

Is hub introducing some issue here looking at above logs?


