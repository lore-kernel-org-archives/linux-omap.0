From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/5] irqchip: crossbar: Skip some irqs from getting mapped
 to crossbar
Date: Thu, 8 May 2014 20:25:21 -0400
Message-ID: <536C2071.8040502@ti.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>	<1399299527-10955-4-git-send-email-r.sricharan@ti.com>	<536BD9D8.4080905@ti.com>	<20140508203659.GA5620@kahuna>	<CAD=GYpbQQxQgKd3oZcAuWrxoD4VrkKzpybd11qwxs405HSUVGw@mail.gmail.com>	<536C0DC4.7090309@ti.com> <CAD=GYpav4mHaqo4jfb0ePchf3cvuvSnFKj_+osbrt_8-tYRRrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40132 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282AbaEIAZr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 20:25:47 -0400
In-Reply-To: <CAD=GYpav4mHaqo4jfb0ePchf3cvuvSnFKj_+osbrt_8-tYRRrQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <agnel.joel@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Joel Fernandes <joelf@ti.com>, "tony@atomide.com" <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Sricharan R <r.sricharan@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thursday 08 May 2014 08:13 PM, Joel Fernandes wrote:
> On Thu, May 8, 2014 at 6:05 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
> [..]
>>> Further since not everything goes through the crossbar and some are
>>> direct mapped like your diagram, the correct fix is probably making it
>>> an irqchip and doing the interrupt controller parenting correctly in
>>> DT.
>>>
>>> That would take care of A), because users of such direct mapped
>>> interrupts will go through the GIC interrupt controller directly.
>>>
>>> It will also take care of B), because if writing to cross bar has no
>>> effect for a particular IRQ, or if those IRQs are hard-wired to
>>> something, as you said, then that something should go through the GIC
>>> directly.
>>>
>>> I can try to whip up something like this if it makes sense, let me know...
>>>
>> I have been ignoring this series considering they were just fixes
>> but you comments are like re-inventing wheel. Please read all
>> the old threads and comments from Thomas and me on why we took
>> approach and why it is not an irqchip. There is no need to complicate
>> it further.
> 
> Are you talking about the discussion on this thread?
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/194318.html
> 
> I didn't really get a sense that there was a common agreement that
> irqchip is not the way to go there. I can stand corrected if there was
> a common consensus that irqchip is not the right solution (with any
> specific comments why). There was a concern in the thread that making
> it irqchip doesn't help dma reuse the infrastructure, but that concern
> seems moot now that the driver is proposed to live in drivers/irqchip.
> 
Obviously you haven't read all the threads... Please read [1]. There
was a reason I said read *all* the threads. Because anyone who looks
at this hardware IP block thinks it can be irqchip. You are not the
first one who said that.

The concern was really not where the code resides but what the actual
hardware is and how can it fit into Linux. The whole reason I was
actually against irqhcip from beginning of crossbar series was the
hardware is not irqchip rather just a router. Thomas the formally
NAKed that approach on thread [1]. If there are bugs, doesn't mean
we can make fit the hardware into some subsystem where it can't be
described.

Regards,
Santosh
[1] https://lkml.org/lkml/2013/9/13/413

