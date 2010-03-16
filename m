From: Ned Forrester <nforrester@whoi.edu>
Subject: Re: [spi-devel-general] SPI troubles
Date: Mon, 15 Mar 2010 22:24:58 -0400
Message-ID: <4B9EEBFA.4080208@whoi.edu>
References: <4b9d9f11.9a15f10a.3902.6dc3@mx.google.com>	<4B9E466E.3040405@whoi.edu> <4b9e58d3.11435e0a.1736.2cf9@mx.google.com>	<4B9E9F37.9030906@whoi.edu> <4b9ed99c.47bee70a.4f5a.4a5f@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from postal2-e0.whoi.edu ([128.128.76.88]:46412 "EHLO
	postal2.whoi.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937362Ab0CPCZD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 22:25:03 -0400
In-Reply-To: <4b9ed99c.47bee70a.4f5a.4a5f@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: beagleboard@googlegroups.com, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

On 03/15/2010 09:06 PM, Ben Gamari wrote:
> Thank you very much for your response. As you might have gathered, I seem to
> have it working but your feedback is really appreciated. I hope to do another
> run of these boards with these fixes.
> 
> On Mon, 15 Mar 2010 16:57:27 -0400, Ned Forrester <nforrester@whoi.edu> wrote:
>>
>> Your problem is likely caused by pulling the THREE STATE pin to 5V.  The
>> spec sheet is explicit (in the Absolute Maximum ratings on page 2, and
>> in the functional description on page 12 that this pin should be pulled
>> to VL, not VCC to enable the outputs.  Likely by pulling it to 5V the
>> some part of the chip is biased wrong and may cause OVL1 to be pulled
>> above VL.
> 
> You are absolutely right. I don't know how I missed that. I just reworked my
> existing board and it seems to be fine now. A very good find. Thanks a ton.

Glad I could help.

>> I can't exactly explain the symptoms you report above, based on the
>> mis-connected pin, but most anything could be happening in the MAX3390
>> once the absolute maximum ratings have been exceeded.  The 10K resistors
>> on the THREE STATE lines may have saved the circuit from permanent
>> damage, but they may not save it from improper operation.
> 
> Well, thankfully at least one of the channels works. Unfortunately, I somehow
> managed to replace one of the 10k resistors with a 1 ohm, so it's possible that
> one of the level shifters on this board is fried. Naturally, I've been sampling
> all of my parts thusfar and only now realized that the MAX1303 is unavailable
> through the traditional channels (e.g. Digikey, Newark).

www.findchips.com covers most of the usual US distributors.  It's not
really restricted to chips, any part number works fine.

Maxim encourages direct purchase from their web site, so sometimes that
is the best place to find stock.

There are 41 in stock at Avnet, in the TQFN package.  Not what you would
like to hand solder, but it can be done if the lands on the PCB are
designed to stick out farther than usual, so that you can get the iron
on the land (since you can't reach the pin itself).  A flux pen helps,
such as Kester #951 (but read the Material Safety Data Sheet).

As someone said on the net years ago (and still true, except for things
like ball grid arrays), "They haven't yet invented a surface mount part
that can't be hand soldered with a temperature controlled iron and $2000
worth of optics and lighting."

>> Other suggestions, nothing fatal...
>>
>> 1. The pinout of the MAX3390E on the drawing is for the TSSOP package.
>> Hopefully that is the package you actually used.
> 
> Yep, it is.
> 
>>
>> 2. All uncommitted inputs should be terminated high or low.  This
>> applies to: LS2 pins 4, 5 and 13; LS3 pin 13 and possibly unused pins on
>> the A/Ds and D/A.
>>
> Very good point. I really should be a little more careful about this.
> 
>> 3. The MAX3390E family has extremely low drive capability and slow
>> response.  Is this device really fast enough for your intended clock
>> rates?  Note that the device can only pull down 1ma, and can only pull
>> up 20ua.  If there are any pull-downs or pull-ups on the BeagleBoard,
>> the MAX3390E might not be able to drive them.
> 
> You are right. I had a remarkably difficult time sourcing level shifters for
> this project at first because I wasn't intending on getting a PCB made. For
> this reason, I standardized on TSSOP packages, which I could easily get DIP
> adapters for. I've since realized that getting a PCB made is definitely worth
> it.

I don't have boards hand assembled any more.  The parts are just too
small, and you have to have a really good tech (or be one) to get a job
as clean and reliable as with soldering in a oven.  There are lots of
assembly houses out there.

>> 4. I find it curious that the AVDD to the A/D and D/A is fed through a
>> 1ohm resistor that is paralleled by C11 and C12.  Likely you meant to
>> tie one side of each of C11 and C12 (the side now connected to C10
>> positive) to ground.  That connection would make a filter to reduce the
>> noise on AVDD rather than passing the noise along.
>>
> Ouch, you are definitely right. Screwed that up.
> 
>> 5. I see on the Maxim site that this series of translators is not
>> recommended for new design.  Likely the suggested alternatives have much
>> better specifications.
> 
> Yep, I went with these because they were available in TSSOP.
> 
> All things considering, I think it might be time to start off with a clean
> slate. This was an interesting first draft, but I think the constraints it was
> designed within are largely inapplicable now.
> 
> TI has some very nice converters that will operate directly on 1.8V signals,
> which would cut the chip count in half. Unfortunately they are in QFN packages,
> which seem difficult at best to solder by hand. On the other hand, there are
> also many higher-channel count TSSOP parts that look pretty enticing, although
> none of them seem to operate at 1.8V.

I have been using TI translators recently; that is, when I don't use a
CPLD or FPGA (there's nothing quite like a programmable device when you
think of a better idea).  TI has a line of translators in small
packages. See, for example, 74LVC1T45, a single translator in a 6 pin
SC70 package that you could hand solder.  Wider parts probably make more
sense for your design.

> I was hoping to finish this design up over the Spring break (now), but I guess
> our data-taking will just have to wait. Arg.

Ahh, student budget vs. student labor.  That will change the range of
outside services that you can use.

> Thanks a ton for your help. It's far too easy to overlook your own mistakes.
> 
> - Ben
> 
> 


-- 
Ned Forrester                                       nforrester@whoi.edu
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079

