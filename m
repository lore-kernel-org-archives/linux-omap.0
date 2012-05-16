From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Wed, 16 May 2012 12:09:41 +0200
Message-ID: <4FB37CE5.1040707@ti.com>
References: <1336033721.14378.2.camel@deskari>   <WC20120503084938.900446@terrafix.co.uk>   <1336050442.14378.10.camel@deskari>   <WC20120504091902.970499@terrafix.co.uk> <1336139415.2552.4.camel@deskari>   <1336140072.2552.6.camel@deskari> <WC20120504140943.7604D0@terrafix.co.uk>   <1336143281.2552.21.camel@deskari> <1336143500.2552.23.camel@deskari>   <1336483598.5761.45.camel@deskari>  <WC20120514073642.6306D7@terrafix.co.uk> <1336982138.2532.32.camel@lappyti>  <alpine.DEB.2.00.1205151148440.16649@utopia.booyaka.com> <1337159300.7692.22.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39922 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759894Ab2EPKJt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 06:09:49 -0400
In-Reply-To: <1337159300.7692.22.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org

Hi Tomi,

On 5/16/2012 11:08 AM, Tomi Valkeinen wrote:
> On Tue, 2012-05-15 at 11:55 -0600, Paul Walmsley wrote:
>> Hello Tomi,
>>
>> On Mon, 14 May 2012, Tomi Valkeinen wrote:
>>
>>> I've been doing testing to understand the problem, but so far I don't
>>> have any idea why things go wrong. I haven't found out any logic in
>>> which configuration works and which doesn't. Looks to me that for some
>>> reason the PM prevents DSS from getting data fast enough with certain
>>> fifo thresholds.
>>>
>>> I have two ways to avoid the problem, but I've been reluctant to make
>>> patches for those because I feel it's just hiding the problem. One way
>>> is to change DISPC SIDLEMODE or MIDLEMODE to disallow idle/standby. The
>>> other is to use certain fifo threshold values, which just seem to work
>>> for unknown reasons.
>>>
>>> Considering that we already have a SIDLEMODE hack in DSS for omap3 when
>>> using DSI, I wonder if the omap3 PM + DSS combination is just plain
>>> broken, and we should disallow idle. I'm not quite sure what are the
>>> implications of that.
>>>
>>> I'd appreciate comments from the PM people =).
>>
>> This may be caused by one of the DPLLs going into autoidle.  This can
>> involve a significant wakeup latency.  I'd suggest looking at DPLL3, which
>> provides the DSS interface clock, and DPLL4, which can provide the DSS
>> functional clock.
>>
>> Could you try:
>>
>> 1. applying something like the patch at the bottom of this message and
>> seeing if it makes any difference?
>>
>> 2. if #1 does not work, changing the "dpll3" in the patch to "dpll4" ?
>>
>> 3. if #2 does not work, disabling autoidle on both dpll3 and dpll4?
>
> Disabling DPLL3 autoidle fixes the problem. Disabling DPLL4 autoidle
> doesn't affect the problem.

The issues your are facing seems to be the well known DSS low power 
refresh mode we've been trying to use since OMAP2 :-).

DPLL3 = CORE DPLL, whereas DPLL4 = PER DPLL, so that's normal that only 
the DPLL3 change is affecting the issue.

> But... Isn't the iface clock only needed to program DSS? When the DSS is
> just running independently, plain func clock should be enough, right? Or
> is iface clock used for the communication between DSS and
> CORE/DPLL/wakeup/something?

No, the DSS does have two ports, the slave one for the register access 
and a master one for the DMA inside the DSS to fetch the data from the 
memory.

So basically, what is happening is that as soon as you allow MSTANDBY to 
happen, the DSS will allow the iclk to be gated, and assuming the 
interconnect is not used by any other initiator (like USB), the CORE 
DPLL (DPLL3) can be gated.

The issue is that when the DSS will reach the low threshold, it will 
de-assert the MSTANDBY to be able to get some fresh data. But since the 
DPLL3 was in idle, it will take several tens of us before the clock is 
re-enabled and thus before the interconnect can be used by the DSS to 
get the data. Meanwhile the DSS FIFO is still getting low.

If the latency to re-enable the DPLL + interconnect is above the 
duration that the FIFO DSS can support, you do have some FIFO underflow.

> I also suspect that this could be just a plain DSS bug. The default FIFO
> low/high thresholds are 960/1023 bytes (i.e. DSS starts refilling the
> FIFO when there are 960 or less bytes in the fifo, and stops at 1023.
> The fifo is 1024 bytes). The values are calculated with fifo_size -
> burst_size and fifo_size - 1.
>
> We are now using FIFO merge features, which combines multiple fifos into
> one when possible, making the fifo size 1024*3 = 3072. Using the same
> low threshold and increasing the high threshold to 960/3071 works fine.
> Changing the high threshold to 3008 causes underflows. Increasing the
> low threshold to ~1600 makes DSS work again.

That's weird, in theory what should matter is only the diff between the 
high and low. Well the low value should be as high as possible as well 
to support the wakeup latency.

> So I think that the high thresholds of 3071 and 3008 are so close to
> each other that there shouldn't be any real difference in practice,
> presuming everything works. But, for whatever reason, fetching of the
> pixels becomes much more inefficient or with much higher start latency,
> causing the underflows.
>
> I guess we'd need HW people to debug this, but their interest in OMAP3
> is probably long gone. So I think I'll just have to use values that seem
> to work for the use cases we test.

Anyway, in this case, a PM QoS constraint should be set on the 
interconnect to ensure that potentially the DPLL3 will not be autogated 
as soon as the iclk is gated.

The point is that whereas you set the FIFO to support the wakeup latency 
or you prevent the idle mode because you conside the DSS cannot support 
that latency because FIFO cannot be merged.

Except that I'm not sure the PM QoS OMAP is in mainline yet :-(

Regards,
Benoit


