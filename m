From: "Sonasath, Moiz" <m-sonasath@ti.com>
Subject: RE: [PATCH 1/1] OMAP: I2C: Add mpu wake up latency constraint in	i2c
Date: Wed, 7 Oct 2009 10:34:08 -0500
Message-ID: <CD8CC2B65FEE304DA95744A5472698F2029E2BD969@dlee06.ent.ti.com>
References: <> <1253204923-21916-1-git-send-email-kalle.jokiniemi@digia.com>
	 <1253204923-21916-2-git-send-email-kalle.jokiniemi@digia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702F9F49663@dbde02.ent.ti.com>
	 <1254910234.22468.251.camel@ubuntu>  <4ACC722E.5060707@gmail.com>
 <1254927643.22468.315.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43905 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933773AbZJGPez convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Oct 2009 11:34:55 -0400
In-Reply-To: <1254927643.22468.315.camel@ubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Nishanth Menon <menon.nishanth@gmail.com>, "paul@pwsan.com" <paul@pwsan.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "jouni.hogander" <jouni.hogander@nokia.com>

Hello Jokiniemi,

> -----Original Message-----
> From: Kalle Jokiniemi [mailto:kalle.jokiniemi@digia.com]
> Sent: Wednesday, October 07, 2009 10:01 AM
> To: Nishanth Menon
> Cc: Pandita, Vikram; khilman@deeprootsystems.com; Sonasath, Moiz;
> jhnikula@gmail.com; linux-omap@vger.kernel.org; jouni.hogander
> Subject: Re: [PATCH 1/1] OMAP: I2C: Add mpu wake up latency constraint in
> i2c
> 
> On Wed, 2009-10-07 at 13:49 +0300, Nishanth Menon wrote:
> > Kalle Jokiniemi said the following on 10/07/2009 05:10 AM:
> > >>> extra delays and subsequent re-trys cause i2c clocks
> > >>> to be active more often. This has also an negative
> > >>> effect on power consumption.
> > >>>
> > >>> Added a constraint that allows MPU to wake up in few
> > >>> hundred usecs, which is roughly the average i2c wait
> > >>> period.
> > >>>
> > >> How did you arrive at the number 500us for the wakeup latency?
> > >>
> > >
> > > This was about the average time that I observed i2c-transfers to be
> > > (from clk_enable to clk_disable), when off mode was not enabled.
> > >
> > just a quick 2cents: I understand that the 500uSec might need to be
> > board dependent - here is why:
> > one theory we have regarding the timeout delay having to be modified on
> > zoom2 was that if the delay was 500uSec, the touch screen controller
> > timesout and pulls of the data in the middle of transfer.
> 
> You have a good point there. I think this will require changing the way
> of passing the bus-specific platform data: currently bus-id and bus-rate
> are passed as function parameters of omap_register_i2c_bus. IMO that
> would need to change to use just one omap_i2c_bus_platform_data
> structure that would contain these and the mpu wake up constraint.
> 
> The other option is to add another parameter to omap_register_i2c_bus,
> but that does not seem as extensible to me. It's much easier to add even
> another platform parameter to a struct, than adding a new function
> parameter. With struct you can always use some known good value in case
> the parameter is not defined, but in function parameter we need to
> always modify all the board files.
> 
> Either way, it will be a time consuming task to go through all those
> board files, since they currently use those function parameters. If I
> find that time, I'll do it.
> 
> BTW, those cpu idle C-state latencies and thresholds could also be
> board-specific. Reasons: we already set board specific voltage and
> oscillator setup times and we have different idle/active consumptions
> (due to differences in peripherals / pad configs etc.), which effect
> threshold values. Kevin, take note, maybe something to add to "TODO" in
> elinux wiki ;)

Sometime back, Paul Walmsley mentioned the calculation for coming up with platform dependent wake-up latency to avoid any receiver overrun problems, the link to that is here:
http://www.pwsan.com/omap/i2c-wakeup-latency.html

Based on this, we should calculate the wake-up latency in the i2c-omap.c file using the following equation:

Parameter to pass to MPU Wakeup latency = [(FIFO Depth)bytes - (FIFO THRSH)bytes]/ [I2C byte rate]

Where, I2C byte rate = [(dev->speed)/8] bytes/sec

This should solve our purpose for any platform.

Using this expression in Zoom2 scenario, with

FIFO depth = 8 Bytes
FIFO THRSH = 4 Bytes
I2C byte rate = 100K / 8 = 12500 Bytes/sec
(For I2C Bus2 running at 100KHz/sec on which we have the touch screen controller)

Parameter to pass to MPU Wakeup latency = 320 usec

Which, when applied overcomes the touch screen problem.

The reason why even 400 usec solved the issue was because the exit latency for C3 state was 410 usec and so with 400 usec in place, the system will only go to C2 state with exit latency of 18 usec.

Following link gives the full discussion that happened on some issue of spurious IRQ's and has a good explanation about this wake-up latency issue by Paul:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg11973.html




> > - Kalle
> 
> > Regards,
> > Nishanth Menon
> 

Regards
Moiz Sonasath
