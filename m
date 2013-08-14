From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 8/8] ARM: DRA7: dts: Add the dts files for dra7 SoC
  and dra7-evm board
Date: Wed, 14 Aug 2013 15:10:58 +0530
Message-ID: <520B50AA.6050101@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com> <1375183546-12758-9-git-send-email-rnayak@ti.com> <20130812114402.GB6616@e106331-lin.cambridge.arm.com> <5209DF2F.5040409@ti.com> <20130813094629.GH27165@e106331-lin.cambridge.arm.com> <c20a9bef34091a7d996e946b13285fe8@www.loen.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49845 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab3HNJlc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Aug 2013 05:41:32 -0400
In-Reply-To: <c20a9bef34091a7d996e946b13285fe8@www.loen.fr>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, sourav.poddar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 13 August 2013 03:35 PM, Marc Zyngier wrote:
> On 2013-08-13 10:46, Mark Rutland wrote:
>> [Adding Marc to Cc]
>>
>> On Tue, Aug 13, 2013 at 08:24:31AM +0100, Rajendra Nayak wrote:
>>> []..
>>>
>>> >> +
>>> >> +       cpus {
>>> >> +               cpu@0 {
>>> >> +                       compatible = "arm,cortex-a15";
>>> >> +                       timer {
>>> >> +                               compatible = "arm,armv7-timer";
>>> >> +                               /*
>>> >> +                                * PPI secure/nonsecure IRQ,
>>> >> +                                * active low level-sensitive
>>> >> +                                */
>>> >> +                               interrupts = <1 13 0x308>,
>>> >> +                                            <1 14 0x308>;
>>> >> +                               clock-frequency = <6144000>;
>>> >> +                       };
>>> >> +               };
>>> >
>>> > The cpu nodes should have a reg matching their unit-address, and a
>>> > device_type = "cpu".
>>> >
>>> > The timer nodes should *not* be under the CPU nodes. They should be
>>> > under under the root node. I realise that it makes intuitive sense to
>>> > describe per-cpu resources this way, but that's not the way the bindings
>>> > are intended to be used (does thei DT even work?).
>>> >
>>> > No virtual/hypervisor interrupts?
>>>
>>> Mark, all valid points. I just updated the patch to include all the missing
>>> interrupts and registers for timer and gic and moved the timer node out as
>>> its supposed to be.
>>
>> Great!
>>
>>>
>>> >
>>> > Do you really need the clock-frequency property? It's far preferrable to
>>> > have your bootloader do the right thing and program CNTFRQ with the
>>> > correct value.
>>>
>>> I kept the clock-frequency property since our bootloader does not handle this
>>> and I am not sure if its a good idea to have the dependency on bootloader
>>> to do this.
>>
>> There is precedent for handling it this way, but it would be far nicer
>> to fix the bootloader to set CNTFRQ. For one thing it's only writeable
>> from the secure side, so a host os can't fix it up for guests that might
>> depend on it rather than dt. I realise it's not necessarily as simple as
>> it sounds to fix that up, however.
> 
> Indeed, having the wrong CNTFRQ in the host has the unfortunate effect of propagating the crap into the guests.
> 
> While this can be worked around for Linux guests (you have to hack the DT passed to the guests, which is very unpleasant at best and varies from one host to another), there is nothing you can do for non-DT guests.
> 
> So please, fix it in your firmware/boot-ROM while it is still time.

Marc, makes sense. Turns out our bootROM (for dra7) does not do this today but does have an api to do it.
So while we figure how to do this some place else, I will go ahead and drop this from dt for now.
Thanks for the review.

regards,
Rajendra

> 
> Thanks,
> 
>         M.

