From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH 3/5] irqchip: crossbar: Skip some irqs from getting mapped
 to crossbar
Date: Fri, 9 May 2014 09:13:24 -0500
Message-ID: <536CE284.9090209@ti.com>
References: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>	<1399299527-10955-4-git-send-email-r.sricharan@ti.com>	<536BD9D8.4080905@ti.com>	<20140508203659.GA5620@kahuna>	<CAD=GYpbQQxQgKd3oZcAuWrxoD4VrkKzpybd11qwxs405HSUVGw@mail.gmail.com>	<536C0DC4.7090309@ti.com>	<CAD=GYpav4mHaqo4jfb0ePchf3cvuvSnFKj_+osbrt_8-tYRRrQ@mail.gmail.com>	<536C2071.8040502@ti.com> <CAD=GYpbRn=LEthpAUX9LNBGTB4iDs7TGiSSgLJuuS0tSatRRJQ@mail.gmail.com> <536CD01F.2070506@ti.com> <536CD7BE.5020407@ti.com> <536CD9DB.4010508@ti.com> <536CDBDF.10600@ti.com> <536CDF94.7000900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58741 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbaEION7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 10:13:59 -0400
In-Reply-To: <536CDF94.7000900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Joel Fernandes <agnel.joel@gmail.com>
Cc: "tony@atomide.com" <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>, Sricharan R <r.sricharan@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 05/09/2014 09:00 AM, Nishanth Menon wrote:
> On 05/09/2014 08:45 AM, Santosh Shilimkar wrote:
>> On Friday 09 May 2014 09:36 AM, Nishanth Menon wrote:
>>> On 05/09/2014 08:27 AM, Santosh Shilimkar wrote:
>>>> On Friday 09 May 2014 08:54 AM, Nishanth Menon wrote:
>>>>> On 05/08/2014 11:22 PM, Joel Fernandes wrote:
>>>>>> On Thu, May 8, 2014 at 7:25 PM, Santosh Shilimkar
>>>>>> <santosh.shilimkar@ti.com> wrote:
>>>>> [...]
>>>>>> Ok, thanks for pointing to the post.
>>>>>>
>>>>>
>>>>>
>>>>> Yep - thanks Santosh for clarifying this. Now, we still have the
>>>>> issues that I pointed out in [1] - without resolving which, we should
>>>>> not enable crossbar for dra74x/72x.
>>>>>
>>>>> A. taking example of PMU
>>>>> 	interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>
>>>>> this wont work. instead the crossbar driver needs some sort of a hint
>>>>> to know that it should not map these on crossbar register instead
>>>>> assign GIC mapping directly.
>>>>>
>>>>> I propose doing the following
>>>>> #define GIC_CROSSBAR_PASSTHROUGH(irq_no) ((irq_no) | (0x1 << 31))
>>>>>
>>>>> and dts will define the following:
>>>>> interrupts = <GIC_SPI GIC_CROSSBAR_PASSTHROUGH(131) IRQ_TYPE_LEVEL_HIGH>
>>>>>
>>>>> This will also work for the other cases (B.2, B.3)
>>>>>
>>>>> For B.2: L3_APP_IRQ:
>>>>> instead of:
>>>>> interrupts = <GIC_SPI  5 IRQ_TYPE_LEVEL_HIGH>
>>>>> we do:
>>>>> interrupts = <GIC_SPI GIC_CROSSBAR_PASSTHROUGH(10) IRQ_TYPE_LEVEL_HIGH>
>>>>>
>>>>> For B.3: NMI
>>>>> interrupts = <GIC_SPI GIC_CROSSBAR_PASSTHROUGH(133) IRQ_TYPE_LEVEL_HIGH>
>>>>>
>>>> We can't do add a flag to generic interrupt controller flags since its
>>>> very specific to cross-bar.
>>>>
>>>>> xlate is easy ->
>>>>>
>>>>> diff --git a/drivers/irqchip/irq-crossbar.c
>>>>> b/drivers/irqchip/irq-crossbar.c
>>>>> index de021638..fd09ab4 100644
>>>>> --- a/drivers/irqchip/irq-crossbar.c
>>>>> +++ b/drivers/irqchip/irq-crossbar.c
>>>>> @@ -112,6 +112,10 @@ static int crossbar_domain_xlate(struct
>>>>> irq_domain *d,
>>>>>  {
>>>>>         unsigned long ret;
>>>>>
>>>>> +       /* Check to see if direct GIC mapping is required */
>>>>> +       if (intspec[1] & BIT(31))
>>>>> +               return intspec[1] & ~BIT[31];
>>>>> +
>>>>>         ret = get_prev_map_irq(intspec[1]);
>>>>>         if (!IS_ERR_VALUE(ret))
>>>>>                 goto found;
>>>>>
>>>>> But then, crossbar_domain_map and crossbar_domain_unmap need hints as
>>>>> well to know that there is no corresponding crossbar registers.
>>>>> Have'nt thought through that yet. Looking to hear about opinions here.
>>>>>
>>>>>
>>>> May be we need additional property like reserved to take care of 1:1
>>>> map.
>>>>
>>>> ti,irqs-direct-map = <131 132>;
>>>>
>>> We already have equivalents for these -> reserved and skip. Problem is
>>> how does crossbar driver know the difference between direct maps and
>>> crossbar value?
>>>
>>> 6 is one of those reserved ones. dts for a device says:
>>> interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>
>>>
>>>
>>> Now, xlate gets intspec[1] = 6.  6 is valid crossbar number
>>> PRM_IRQ_MPU, however GIC 6 is mapped to WD_TIMER_MPU_C1_IRQ_WARN ->
>>> you need to be able to get a hint that this is direct mapping dts
>>> intended.
>>>
>>> in the "6" example:
>>>
>>> How do i get PRM_IRQ_MPU?
>>> interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>
>>>
>>> How do I get WD_TIMER_MPU_C1_IRQ_WARN?
>>> interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH> ????? - that wont work as
>>> crossbar driver thinks it is crossbar 6 (PRM_IRQ_MPU)
>>>
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

IMO even the direct-mapped ones can go come from a list, trouble is with
the buggy hardware hard-coded mappings which map some random crossbar to
some random GIC and can't be changed.

Only way to handle this is with a sort of an associative map in DT, not
a list. But that's far more overkill than anyone could imagine, and the
suggestion to set BIT 31 is cleaner without needing any lists at all,
while hiding all the complexity within the crossbar driver. After xlate,
the IRQ number is corrected, so the flag disappears, and the info that
its DIRECT can be stored to retrieved later during map/unmap.

thanks,

-Joel

