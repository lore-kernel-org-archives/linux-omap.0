From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 2/6] genirq: fix irqchip_set_wake_parent if IRQCHIP_SKIP_SET_WAKE
Date: Fri, 14 Aug 2015 11:39:56 +0100
Message-ID: <55CDC57C.2030006@arm.com>
References: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com> <1439401562-28874-3-git-send-email-grygorii.strashko@ti.com> <55CC6AFF.8060400@arm.com> <55CC71E8.80604@ti.com> <55CC9493.9020101@ti.com> <55CDC089.1060309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55CDC089.1060309@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "tony@atomide.com" <tony@atomide.com>, Sudeep Holla <Sudeep.Holla@arm.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "nsekhar@ti.com" <nsekhar@ti.com>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "balbi@ti.com" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 14/08/15 11:18, Grygorii Strashko wrote:
> On 08/13/2015 03:58 PM, Grygorii Strashko wrote:
>> On 08/13/2015 01:31 PM, Grygorii Strashko wrote:
>>> On 08/13/2015 01:01 PM, Marc Zyngier wrote:
>>>> On 12/08/15 18:45, Grygorii Strashko wrote:
>>>>> The irqchip_set_wake_parent should not fail if IRQ chip
>>>>> specifies IRQCHIP_SKIP_SET_WAKE. Otherwise, IRQ wakeup
>>>>> configuration can't be propagated properly through IRQ
>>>>> domains hierarchy.
>>>>>
>>>>> In case of TI OMAP DRA7 the issue reproduced with following
>>>>> configuration:
>>>>> ARM GIC<-OMAP wakeupgen<-TI CBAR<-GPIO<-GPIO pcf857x<-gpio_key
>>>>>
>>>>> gpio_key is wakeup source
>>>>>
>>>>> Failure is reproduced during suspend/resume to RAM:
>>>>> suspend:
>>>>>    - gpio_keys_suspend
>>>>>      enable_irq_wake
>>>>>        + pcf857x_irq_set_wake
>>>>>          + omap_gpio_wake_enable
>>>>>            + TI CBAR irq_chip_set_wake_parent
>>>>>              + OMAP wakeupgen has no .irq_set_wake()
>>>>
>>>> Most importantly, wakeupgen has IRQCHIP_SKIP_SET_WAKE set.
>>>>
>>>>>              and -ENOSYS will be returned
>>>>>
>>>>> resume:
>>>>>    - gpio_keys_resume
>>>>>      + disable_irq_wake
>>>>>        + irq_set_irq_wake
>>>>>          + WARN(1, "Unbalanced IRQ %d wake disable\n", irq);
>>>>>
>>>>> Fixes: 08b55e2a9208 ('genirq: Add irqchip_set_wake_parent')
>>>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>>> ---
>>>>>    kernel/irq/chip.c | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>>>>> index 6de638b..bdb1b9d 100644
>>>>> --- a/kernel/irq/chip.c
>>>>> +++ b/kernel/irq/chip.c
>>>>> @@ -1024,6 +1024,10 @@ int irq_chip_set_vcpu_affinity_parent(struct
>>>>> irq_data *data, void *vcpu_info)
>>>>>    int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
>>>>>    {
>>>>>        data = data->parent_data;
>>>>> +
>>>>> +    if (irq_data_get_irq_chip(data)->flags & IRQCHIP_SKIP_SET_WAKE)
>>>>> +        return 0;
>>>>> +
>>>>>        if (data->chip->irq_set_wake)
>>>>>            return data->chip->irq_set_wake(data, on);
>>>>>
>>>>>
>>>>
>>>> We have a more general issue with chip flags, and how they combine
>>>> within a stack of irqchips.
>>>
>>> Indeed. Problem looks similar to IRQCHIP_MASK_ON_SUSPEND flag usage.
>>>
>>>>
>>>> What if you remove the irq_chip_set_wake_parent from the crossbar
>>>> driver, and instead set IRQCHIP_SKIP_SET_WAKE?
>>>
>>> I've thought about this and it should work for me.
>>> One question - what if crossbar will be not the last one in
>>> IRQ domains hierarchy?
>>>
>>
>> I can confirm, if I revert this patch, add IRQCHIP_SKIP_SET_WAKE to
>> the crossbar and remove irq_chip_set_wake_parent wakeups still works.
>> What do you prefer me to do: add additional patch for the crossbar,
>> drop/keep this patch?
>>
> 
> OK. There are two possibilities to fix set_wake functionality for TI OMAPs
> where below HW configurations are used:
>   OMAP4/5: GIC <- OMAP wakeupgen
>   DRA7: GIC <- OMAP wakeupgen <- TI CBAR
> 
> 
> 1) ensure that IRQCHIP_SKIP_SET_WAKE flag is set only for GIC and
> use irq_chip_set_wake_parent() in both wakeupgen and crossbar 
>  [this patch is required]
> 
> 2) ensure that IRQCHIP_SKIP_SET_WAKE flag is set and drop 
> .irq_set_wake()/irq_chip_set_wake_parent() for all IRQ chips
> in IRQ domains hierarchy.
>  [this patch can be dropped]
> 
> I'm going to select approach 2 and re-send.

Yeah, I'd like to go for the minimal approach for now, and work out what
exactly are the propagation semantics (I had something at some point,
need to find what I did with those patches...).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
