From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 8/8] ARM: DRA7: dts: Add the dts files for dra7 SoC  and dra7-evm board
Date: Tue, 13 Aug 2013 11:05:45 +0100
Message-ID: <c20a9bef34091a7d996e946b13285fe8@www.loen.fr>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <1375183546-12758-9-git-send-email-rnayak@ti.com>
 <20130812114402.GB6616@e106331-lin.cambridge.arm.com>
 <5209DF2F.5040409@ti.com>
 <20130813094629.GH27165@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from inca-roads.misterjones.org ([213.251.177.50]:60645 "EHLO
	inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754064Ab3HMKFy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Aug 2013 06:05:54 -0400
In-Reply-To: <20130813094629.GH27165@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Rajendra Nayak <rnayak@ti.com>, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2013-08-13 10:46, Mark Rutland wrote:
> [Adding Marc to Cc]
>
> On Tue, Aug 13, 2013 at 08:24:31AM +0100, Rajendra Nayak wrote:
>> []..
>>
>> >> +
>> >> +       cpus {
>> >> +               cpu@0 {
>> >> +                       compatible = "arm,cortex-a15";
>> >> +                       timer {
>> >> +                               compatible = "arm,armv7-timer";
>> >> +                               /*
>> >> +                                * PPI secure/nonsecure IRQ,
>> >> +                                * active low level-sensitive
>> >> +                                */
>> >> +                               interrupts = <1 13 0x308>,
>> >> +                                            <1 14 0x308>;
>> >> +                               clock-frequency = <6144000>;
>> >> +                       };
>> >> +               };
>> >
>> > The cpu nodes should have a reg matching their unit-address, and a
>> > device_type = "cpu".
>> >
>> > The timer nodes should *not* be under the CPU nodes. They should 
>> be
>> > under under the root node. I realise that it makes intuitive sense 
>> to
>> > describe per-cpu resources this way, but that's not the way the 
>> bindings
>> > are intended to be used (does thei DT even work?).
>> >
>> > No virtual/hypervisor interrupts?
>>
>> Mark, all valid points. I just updated the patch to include all the 
>> missing
>> interrupts and registers for timer and gic and moved the timer node 
>> out as
>> its supposed to be.
>
> Great!
>
>>
>> >
>> > Do you really need the clock-frequency property? It's far 
>> preferrable to
>> > have your bootloader do the right thing and program CNTFRQ with 
>> the
>> > correct value.
>>
>> I kept the clock-frequency property since our bootloader does not 
>> handle this
>> and I am not sure if its a good idea to have the dependency on 
>> bootloader
>> to do this.
>
> There is precedent for handling it this way, but it would be far 
> nicer
> to fix the bootloader to set CNTFRQ. For one thing it's only 
> writeable
> from the secure side, so a host os can't fix it up for guests that 
> might
> depend on it rather than dt. I realise it's not necessarily as simple 
> as
> it sounds to fix that up, however.

Indeed, having the wrong CNTFRQ in the host has the unfortunate effect 
of propagating the crap into the guests.

While this can be worked around for Linux guests (you have to hack the 
DT passed to the guests, which is very unpleasant at best and varies 
from one host to another), there is nothing you can do for non-DT 
guests.

So please, fix it in your firmware/boot-ROM while it is still time.

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
