From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 2/6] genirq: fix irqchip_set_wake_parent if IRQCHIP_SKIP_SET_WAKE
Date: Thu, 13 Aug 2015 11:33:21 +0100
Message-ID: <55CC7271.5040202@arm.com>
References: <1439401562-28874-1-git-send-email-grygorii.strashko@ti.com> <1439401562-28874-3-git-send-email-grygorii.strashko@ti.com> <55CC5B2F.7060503@arm.com> <55CC68A0.40101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55CC68A0.40101@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Marc Zyngier <Marc.Zyngier@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "tony@atomide.com" <tony@atomide.com>, "nsekhar@ti.com" <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "balbi@ti.com" <balbi@ti.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org



On 13/08/15 10:51, Grygorii Strashko wrote:
> On 08/13/2015 11:54 AM, Sudeep Holla wrote:
>>
>>
>> On 12/08/15 18:45, Grygorii Strashko wrote:

[...]

>>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>>> index 6de638b..bdb1b9d 100644
>>> --- a/kernel/irq/chip.c
>>> +++ b/kernel/irq/chip.c
>>> @@ -1024,6 +1024,10 @@ int irq_chip_set_vcpu_affinity_parent(struct
>>> irq_data *data, void *vcpu_info)
>>>    int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
>>>    {
>>>        data = data->parent_data;
>>> +
>>> +    if (irq_data_get_irq_chip(data)->flags & IRQCHIP_SKIP_SET_WAKE)
>>> +        return 0;
>>> +
>>
>> [Nit] I think the irq core can access data->chip directly. Either way,
>> it's better to be consistent, the statement following doesn't use helper
>> function.
>
> thanks. I'll change it to:
> 	if (data->chip->flags & IRQCHIP_SKIP_SET_WAKE)
> 		return 0;
>
>>
>> Otherwise looks good to me.
>
> Does it means that I can add your Reviewed-by: with above change?
>

Yes you can.

Regards,
Sudeep
