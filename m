From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP gic_arch_extn
Date: Wed, 14 Sep 2011 22:19:55 +0530
Message-ID: <4E70DB33.5070501@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com> <20110913203616.GG24252@atomide.com> <CAMQu2gyYETPZRJu=4MWX6bULgmMaJb8MRwfhvURtOuyyWhLkAQ@mail.gmail.com> <20110914152116.GM24252@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:36876 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754825Ab1INQuF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 12:50:05 -0400
Received: by mail-gx0-f177.google.com with SMTP id 23so2438611gxk.36
        for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 09:50:04 -0700 (PDT)
In-Reply-To: <20110914152116.GM24252@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, "Woodruff, Richard" <r-woodruff2@ti.com>

On Wednesday 14 September 2011 08:51 PM, Tony Lindgren wrote:
> * Shilimkar, Santosh<santosh.shilimkar@ti.com>  [110913 22:01]:
>> Tony,
>> On Wed, Sep 14, 2011 at 2:06 AM, Tony Lindgren<tony@atomide.com>  wrote:
>>> * Santosh Shilimkar<santosh.shilimkar@ti.com>  [110904 06:23]:
>>>> OMAP WakeupGen is the interrupt controller extension used along
>>>> with ARM GIC to wake the CPU out from low power states on
>>>> external interrupts.
>>>>
>>>> The WakeupGen unit is responsible for generating wakeup event
>>>> from the incoming interrupts and enable bits. It is implemented
>>>> in MPU always ON power domain. During normal operation,
>>>> WakeupGen delivers external interrupts directly to the GIC.
>>> ...
>>>
>>>> +     /*
>>>> +      * Override GIC architecture specific functions to add
>>>> +      * OMAP WakeupGen interrupt controller along with GIC
>>>> +      */
>>>> +     gic_arch_extn.irq_mask = wakeupgen_mask;
>>>> +     gic_arch_extn.irq_unmask = wakeupgen_unmask;
>>>> +     gic_arch_extn.irq_set_wake = wakeupgen_set_wake;
>>>> +     gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
>>>
>>> As I've commented before, there should not be any need to tweak
>>> the wakeupgen registers for each interrupt during the runtime.
>>>
>> And I gave you all the reasons why it needs to be done this way.
>
> Hmm, I don't think you ever answered the main question:
>
> Why would you need to write the wakeupgen registers for every
> interrupt during the runtime instead of arming them only when
> entering idle?
>
I thought I did that in last thread.
Let me try again,

First and foremost, I have to go with the approach here because MPUSS
hardware team put a requirement that GIC and wakeupgen should always be
kept in sync. If needed we can discuss this off-the list with Richard.

Below is the extract from the veyron func specs.
-------------------------------------
Version 1.6 of veyron spec has this.

 From page 95, paragraph 2 on version 1.6:

"It is SW responsibility to program interrupt enabling/disabling
coherently in the GIC and in the Wugen enable registers. That is, a
given interrupt for a given CPU is either enable at both GIC and Wugen,
or disable at both, but no mix."
-------------------------------------

The way understand this IP is, even in normal scenario's every IRQ
will come to wakeupgen and then it will pass that to GIC. CPU clock
domains are kept under HW supervised always and they can enter inactive
any time without WFI. Only wakeup gen can bring the CPU out of inactive
state.

That's requirement really lead to this design choice. Just to add
all ARM SOC's using GIC has a gic extension interrupt controller and
follow the same approach for the secondary IRQCHIPO.

Below points as such don't matter after the strict hardware
requirement. Still .....


Let's say, we ignore the hardware recommendation and try
to do what you are suggesting.

How will you know while entering in idle which IRQ's to be
masked and which are to be unmasked ?
The only way is to run though entire 1024 possible IRQ's from GIC
and then check the state of each IRQ and set things accordingly.
At GIC level, mask and unmask registers are different so you will
end up reading those many registers. That also means you need to
export some non-standard APIs from GIC driver.

In system wide suspend, the core irq code, communicates
the wakeup and non-wakeup functionality using standard mask/
unmask APIs when used with IRQCHIP_MASK_ON_SUSPEND.
With what you are suggesting it won't work
as desired. Because that information is only passed
to the IRQ chips. So you will still need IRQCHIP and
mask/unmask APIs. That can be done as part of set_wake()
handler as well though.

The wakeupgen is within CPU cluster and the accesses
to it are not as expensive as like accessing 32 K timer or
GP timer.

By making the wakeupgen as an IRQCHIP, we meet the hardware
requirement and also make use of this IP properly for the
desired functionality using standard IRQCHIP interfaces
No need of non-standard hacking.

It also avoid platform code monkeing with common GIC code
and irq subsystem to hack the stuff.

Btw, not exactly related here, but because of common code consolidation, 
we need to actually use GIC common
save/restore hooks, even though OMAP has very
optimal software save and hardware restore mechanism
for GIC.

Hope this email summarise all previous multiple discussions
in one place.

Regards
Santosh
