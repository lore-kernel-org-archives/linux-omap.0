From: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Subject: Re: [PATCH v3 1/5] mfd: tps65217: Add support for IRQs
Date: Fri, 17 Jun 2016 17:31:29 +0200
Message-ID: <062438af-c05f-00b3-adc6-ac27e7cec892@grinn-global.com>
References: <20160616114110.23455-1-m.niestroj@grinn-global.com>
 <20160616114110.23455-2-m.niestroj@grinn-global.com>
 <5762A3AC.9010409@ti.com>
 <123e6759-fa44-48f0-860d-623aaa39f8ea@grinn-global.com>
 <57640C3C.1070001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57640C3C.1070001-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 17.06.2016 16:42, Grygorii Strashko wrote:
> On 06/17/2016 05:05 PM, Marcin Niestroj wrote:
>>
>> On 16.06.2016 15:03, Grygorii Strashko wrote:
>>> On 06/16/2016 02:41 PM, Marcin Niestroj wrote:
>>>> Add support for handling IRQs: power button, AC and USB power state
>>>> changes. Mask and interrupt bits are shared within one register, which
>>>> prevents us to use regmap_irq implementation. New irq_domain is
>>>> created in
>>>> order to add interrupt handling for each tps65217's subsystem. IRQ
>>>> resources have been added for charger subsystem to be able to notify
>>>> about
>>>> AC and USB state changes.
>>>>
>>>> Signed-off-by: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
>>>> ---
>>>>   drivers/mfd/Kconfig          |   1 +
>>>>   drivers/mfd/tps65217.c       | 194
>>>> +++++++++++++++++++++++++++++++++++++++++--
>>>>   include/linux/mfd/tps65217.h |  11 +++
>>>>   3 files changed, 198 insertions(+), 8 deletions(-)
>
> [...]
>
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    mutex_init(&tps->irq_lock);
>>>> +
>>>> +    /* Mask all interrupt sources */
>>>> +    tps->irq_mask = (TPS65217_INT_RESERVEDM | TPS65217_INT_PBM
>>>> +            | TPS65217_INT_ACM | TPS65217_INT_USBM);
>>>> +    tps65217_reg_write(tps, TPS65217_REG_INT, tps->irq_mask,
>>>> +            TPS65217_PROTECT_NONE);
>>>> +
>>>> +    tps->irq_domain = irq_domain_add_linear(tps->dev->of_node,
>>>> +        TPS65217_NUM_IRQ, &tps65217_irq_domain_ops, tps);
>>>> +    if (!tps->irq_domain) {
>>>> +        dev_err(tps->dev, "Could not create IRQ domain\n");
>>>> +        return -ENOMEM;
>>>> +    }
>>>> +
>>>> +    ret = devm_request_threaded_irq(tps->dev, irq, NULL,
>>>> +                    tps65217_irq_thread,
>>>> +                    IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>>>
>>> Are there any reasons why IRQ trigger type specified here explicitly?
>>
>> Not really. I have configured it that way, it worked and I forgot about
>> it when preparing patches. Could you give some hint here?
>>
>
> It's better to get it from DT and in case of DT boot it will - the real
> IRQ trigger type may depends on board.
>

So what I understand, I need to remove IRQF_TRIGGER_RISING here.
Addidional flags will be passed by 'irq_flags' in
"interrupts = <irq_num irq_flags>" in DT, right?

-- 
Marcin Niestroj
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
