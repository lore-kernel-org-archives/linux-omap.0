From: Ned Forrester <nforrester@whoi.edu>
Subject: Re: [spi-devel-general] SPI troubles
Date: Mon, 15 Mar 2010 16:57:27 -0400
Message-ID: <4B9E9F37.9030906@whoi.edu>
References: <4b9d9f11.9a15f10a.3902.6dc3@mx.google.com>	<4B9E466E.3040405@whoi.edu> <4b9e58d3.11435e0a.1736.2cf9@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from postal2-e0.whoi.edu ([128.128.76.88]:35342 "EHLO
	postal2.whoi.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757076Ab0COU5c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 16:57:32 -0400
In-Reply-To: <4b9e58d3.11435e0a.1736.2cf9@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: beagleboard@googlegroups.com, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

On 03/15/2010 11:57 AM, Ben Gamari wrote:
> When measuring the SIMO signal on the expansion connector with my daughterboard
> connected, I noticed that the daughterboard's level shifter appeared to be
> driving the signal higher than it should, to ~2.9 Volts. I then checked the
> 1.8V rail voltage and found that it too was higher than expected, again at 2.9
> volts. When I unplug the daughterboard, the 1.8V rail voltage returns to its
> expected value.
>
> On Mon, 15 Mar 2010 10:38:38 -0400, Ned Forrester <nforrester@whoi.edu> wrote:
>> I'd be happy to check your circuit for you, if it were posted in a more
>> widely used format.  How about a PDF of the schematic.
>>
> Certainly, it's a available at http://goldnerlab.physics.umass.edu/~bgamari/schematic.png.

Your problem is likely caused by pulling the THREE STATE pin to 5V.  The
spec sheet is explicit (in the Absolute Maximum ratings on page 2, and
in the functional description on page 12 that this pin should be pulled
to VL, not VCC to enable the outputs.  Likely by pulling it to 5V the
some part of the chip is biased wrong and may cause OVL1 to be pulled
above VL.

I can't exactly explain the symptoms you report above, based on the
mis-connected pin, but most anything could be happening in the MAX3390
once the absolute maximum ratings have been exceeded.  The 10K resistors
on the THREE STATE lines may have saved the circuit from permanent
damage, but they may not save it from improper operation.

Other suggestions, nothing fatal...

1. The pinout of the MAX3390E on the drawing is for the TSSOP package.
Hopefully that is the package you actually used.

2. All uncommitted inputs should be terminated high or low.  This
applies to: LS2 pins 4, 5 and 13; LS3 pin 13 and possibly unused pins on
the A/Ds and D/A.

3. The MAX3390E family has extremely low drive capability and slow
response.  Is this device really fast enough for your intended clock
rates?  Note that the device can only pull down 1ma, and can only pull
up 20ua.  If there are any pull-downs or pull-ups on the BeagleBoard,
the MAX3390E might not be able to drive them.

4. I find it curious that the AVDD to the A/D and D/A is fead through a
1ohm resistor that is paralleled by C11 and C12.  Likely you meant to
tie one side of each of C11 and C12 (the side now connected to C10
positive) to ground.  That connection would make a filter to reduce the
noise on AVDD rather than passing the noise along.

5. Is see on the Maxim site that this series of translators is not
recommended for new design.  Likely the suggested alternatives have much
better specifications.

-- 
Ned Forrester                                       nforrester@whoi.edu
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079

