From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/5] irqchip: crossbar: Skip some irqs from getting mapped
 to crossbar
Date: Thu, 8 May 2014 19:05:40 -0400
Message-ID: <536C0DC4.7090309@ti.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>	<1399299527-10955-4-git-send-email-r.sricharan@ti.com>	<536BD9D8.4080905@ti.com>	<20140508203659.GA5620@kahuna> <CAD=GYpbQQxQgKd3oZcAuWrxoD4VrkKzpybd11qwxs405HSUVGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37504 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756030AbaEHXGF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 19:06:05 -0400
In-Reply-To: <CAD=GYpbQQxQgKd3oZcAuWrxoD4VrkKzpybd11qwxs405HSUVGw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <agnel.joel@gmail.com>, Nishanth Menon <nm@ti.com>
Cc: Joel Fernandes <joelf@ti.com>, "tony@atomide.com" <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Sricharan R <r.sricharan@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thursday 08 May 2014 06:43 PM, Joel Fernandes wrote:
> On Thu, May 8, 2014 at 3:37 PM, Nishanth Menon <nm@ti.com> wrote:
>> On 14:24-20140508, Joel Fernandes wrote:
>>> On 05/05/2014 09:18 AM, Sricharan R wrote:
>>>> From: Nishanth Menon <nm@ti.com>
>>>>
>>>> When, in the system due to varied reasons, interrupts might be unusable
>>>> due to hardware behavior, but register maps do exist, then those interrupts
>>>> should be skipped while mapping irq to crossbars.
>>>>
>>>
>>> Just wondering, instead of hardcoding this data in the code, and
>>> introducing additional flags (IRQ_SKIP), why not just put these GIC IRQs
>>> in the ti,irq-reserved property in DTS for platforms where such IRQs are
>>> not usable. That way you're skipping these IRQs anyway.
>>>
>>> Also that would avoid adding more hard coded data for future SoCs into
>>> the source for such IRQs that must be skipped, and also reduces LOC.
>>>
>>
>> Good question - lets try to explain the hardware a little here ->
>> obviously a driver that cannot use the hardware is useless compared to
>> reducing LOC count ;).. and apologies about the long reply..
>>
>> Basic understanding:
>> GIC has 160 SPIs and number of hardware block interrupt sources is around or
>> more than 400. So, in comes crossbar - which is basically a mapper by
>> allowing us to select an hardware block interrupt source (identified as
>> crossbar_number or cb_no in code). So all we have to do is to write to a
>> register in crossbar corresponding to GIC and viola, we now routed the
>> interrupt source to a GIC interrupt of our choice. At least the
>> Specification reads so.... until you drill down to the details.
> 
> Thanks for the long explanation and the diagrams!
> 
> Yes, I feel there is no other way and with so many HW bugs, I think it
> makes sense to make it a real irqchip driver.
>
It doesn't because its not an irqchip. 
 
> Further since not everything goes through the crossbar and some are
> direct mapped like your diagram, the correct fix is probably making it
> an irqchip and doing the interrupt controller parenting correctly in
> DT.
> 
> That would take care of A), because users of such direct mapped
> interrupts will go through the GIC interrupt controller directly.
> 
> It will also take care of B), because if writing to cross bar has no
> effect for a particular IRQ, or if those IRQs are hard-wired to
> something, as you said, then that something should go through the GIC
> directly.
> 
> I can try to whip up something like this if it makes sense, let me know...
> 
I have been ignoring this series considering they were just fixes
but you comments are like re-inventing wheel. Please read all
the old threads and comments from Thomas and me on why we took
approach and why it is not an irqchip. There is no need to complicate
it further.


Regards,
Santosh

