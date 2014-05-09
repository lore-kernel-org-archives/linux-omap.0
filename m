From: Joel Fernandes <agnel.joel@gmail.com>
Subject: Re: [PATCH 3/5] irqchip: crossbar: Skip some irqs from getting mapped
 to crossbar
Date: Thu, 8 May 2014 19:13:31 -0500
Message-ID: <CAD=GYpav4mHaqo4jfb0ePchf3cvuvSnFKj_+osbrt_8-tYRRrQ@mail.gmail.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
	<1399299527-10955-4-git-send-email-r.sricharan@ti.com>
	<536BD9D8.4080905@ti.com>
	<20140508203659.GA5620@kahuna>
	<CAD=GYpbQQxQgKd3oZcAuWrxoD4VrkKzpybd11qwxs405HSUVGw@mail.gmail.com>
	<536C0DC4.7090309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:45930 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbaEIANb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 20:13:31 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so4031201oah.35
        for <linux-omap@vger.kernel.org>; Thu, 08 May 2014 17:13:31 -0700 (PDT)
In-Reply-To: <536C0DC4.7090309@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Joel Fernandes <joelf@ti.com>, "tony@atomide.com" <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Sricharan R <r.sricharan@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thu, May 8, 2014 at 6:05 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
[..]
>> Further since not everything goes through the crossbar and some are
>> direct mapped like your diagram, the correct fix is probably making it
>> an irqchip and doing the interrupt controller parenting correctly in
>> DT.
>>
>> That would take care of A), because users of such direct mapped
>> interrupts will go through the GIC interrupt controller directly.
>>
>> It will also take care of B), because if writing to cross bar has no
>> effect for a particular IRQ, or if those IRQs are hard-wired to
>> something, as you said, then that something should go through the GIC
>> directly.
>>
>> I can try to whip up something like this if it makes sense, let me know...
>>
> I have been ignoring this series considering they were just fixes
> but you comments are like re-inventing wheel. Please read all
> the old threads and comments from Thomas and me on why we took
> approach and why it is not an irqchip. There is no need to complicate
> it further.

Are you talking about the discussion on this thread?
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/194318.html

I didn't really get a sense that there was a common agreement that
irqchip is not the way to go there. I can stand corrected if there was
a common consensus that irqchip is not the right solution (with any
specific comments why). There was a concern in the thread that making
it irqchip doesn't help dma reuse the infrastructure, but that concern
seems moot now that the driver is proposed to live in drivers/irqchip.

Further, I don't think my comments are re-inventing anything because
the brand-new bugs that are being found now weren't found then and my
comments were more related to these bugs.

As for complexity, it appears there will be signficant hacks coming up
that are required to handle the corner cases by adding more lists and
dt-properties. So its already on a complicated path.. Even with such
hacks, Nishanth pointed out that the implementation can break. Its
already like a deck of cards in my opinion and complicates things for
everyone using it. You said you hadn't gone through the fixes in this
series, you should go over them and see the new lists added to skip
and reserve various things.

thanks,

  -Joel
