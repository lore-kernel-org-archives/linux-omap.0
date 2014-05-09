From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/5] irqchip: crossbar: Skip some irqs from getting mapped
 to crossbar
Date: Fri, 9 May 2014 16:41:18 -0400
Message-ID: <536D3D6E.8030304@ti.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>	<1399299527-10955-4-git-send-email-r.sricharan@ti.com>	<536BD9D8.4080905@ti.com>	<20140508203659.GA5620@kahuna>	<CAD=GYpbQQxQgKd3oZcAuWrxoD4VrkKzpybd11qwxs405HSUVGw@mail.gmail.com>	<536C0DC4.7090309@ti.com>	<CAD=GYpav4mHaqo4jfb0ePchf3cvuvSnFKj_+osbrt_8-tYRRrQ@mail.gmail.com>	<536C2071.8040502@ti.com> <CAD=GYpbRn=LEthpAUX9LNBGTB4iDs7TGiSSgLJuuS0tSatRRJQ@mail.gmail.com> <536CD01F.2070506@ti.com> <536CD7BE.5020407@ti.com> <536CD9DB.4010508@ti.com> <536CDBDF.10600@ti.com> <536CDF94.7000900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44278 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757476AbaEIUlq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 16:41:46 -0400
In-Reply-To: <536CDF94.7000900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Joel Fernandes <agnel.joel@gmail.com>
Cc: Joel Fernandes <joelf@ti.com>, "tony@atomide.com" <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Sricharan R <r.sricharan@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Friday 09 May 2014 10:00 AM, Nishanth Menon wrote:
> On 05/09/2014 08:45 AM, Santosh Shilimkar wrote:
>> On Friday 09 May 2014 09:36 AM, Nishanth Menon wrote:
[..]

>> Looks like I am missing something. Is the issue because of SPI offset (32)
>> which makes above confusion ?
> 
> The way we modelled crossbar is that the irqchip is GIC and routable
> mapper is crossbar - which makes sense. now for every "interrupts"
> description we try to find a map using the crossbar driver as the irq
> framework rightly identifies that peripheral interrupts are routable
> and crossbar driver is the guy who knows how to map these to a proper
> GIC interrupt number. So far, we are good.
> 
> Now the trouble starts when our hardware description in dts assumes
> that every peripheral interrupt is a routable interrupt - as this
> thread describes - that is NOT the case.
> 
> Now the question is how do you differentiate?
> 
> interrupts = <GIC_SPI Number Level>
> 
> GIC_SPI is correct since we are attempting to describe the SPI
> interrupt (offset what ever it is, is a NOP from conceptual discussion).
> 
> Level is fine as well.
> 
> Number: what does this indicate? crossbar number is what we have
> assumed so far. however, then you loose the ability to describe
> interrupts on GIC SPI which dont have crossbar interrupts.
> 
> Question is how do we differentiate between the two?
> 
Updating the thread about an off-list discussion on $subject.
Nishant understood the how he was indirectly changing the meaning
of IRQ bindings and why its a bad idea. The point which
didn't came out clearly on the list was also the limited set
of route-able IRQ registers at cross-bar which is utter non-sense
and broken hardware. And since we are patching up the cross-bar
hardware bugs, it should be done such a way that the cross-bar
device tree bindings reflect that.

Here is the way forward we decided...
Add additional/optional properties to cross-bar binding
so that you can represent IRQs which can't be routed by
cross-bar. Something like 'MAX_ROUTABLE_IRQS'.

Then on the cleint modules which has the shortcoming, you just
add MAX_ROUTABLE_IRQS to those IRQs. That way cross-bar
driver fails to route them and just returns the offset
IRQline thinking it is already hard wired.

As a proof of concept I suggest you to just create a bidnig
patch with example usage of such case in the Documentation
and send it for review.

Copy Device Tree folks and Thomas to see if they are ok with it
or can suggest some better way to deal with the issue.

Thanks for the patience and explaining the issue repeatedly.

regards,
Santosh





