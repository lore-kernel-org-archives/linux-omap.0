From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v3 1/5] mfd: tps65217: Add support for IRQs
Date: Fri, 17 Jun 2016 19:09:40 +0300
Message-ID: <576420C4.4060002@ti.com>
References: <20160616114110.23455-1-m.niestroj@grinn-global.com>
 <20160616114110.23455-2-m.niestroj@grinn-global.com>
 <5762A3AC.9010409@ti.com>
 <123e6759-fa44-48f0-860d-623aaa39f8ea@grinn-global.com>
 <57640C3C.1070001@ti.com>
 <062438af-c05f-00b3-adc6-ac27e7cec892@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <062438af-c05f-00b3-adc6-ac27e7cec892@grinn-global.com>
Sender: linux-pm-owner@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>, Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 06/17/2016 06:31 PM, Marcin Niestroj wrote:
> 
> 
> On 17.06.2016 16:42, Grygorii Strashko wrote:
>> On 06/17/2016 05:05 PM, Marcin Niestroj wrote:
>>>
>>> On 16.06.2016 15:03, Grygorii Strashko wrote:
>>>> On 06/16/2016 02:41 PM, Marcin Niestroj wrote:
>>>>> Add support for handling IRQs: power button, AC and USB power state
>>>>> changes. Mask and interrupt bits are shared within one register, which
>>>>> prevents us to use regmap_irq implementation. New irq_domain is
>>>>> created in
>>>>> order to add interrupt handling for each tps65217's subsystem. IRQ
>>>>> resources have been added for charger subsystem to be able to notify
>>>>> about
>>>>> AC and USB state changes.
>>>>>
>>>>> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
>>>>> ---
>>>>>   drivers/mfd/Kconfig          |   1 +
>>>>>   drivers/mfd/tps65217.c       | 194
>>>>> +++++++++++++++++++++++++++++++++++++++++--
>>>>>   include/linux/mfd/tps65217.h |  11 +++
>>>>>   3 files changed, 198 insertions(+), 8 deletions(-)
>>
>> [...]
>>
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    mutex_init(&tps->irq_lock);
>>>>> +
>>>>> +    /* Mask all interrupt sources */
>>>>> +    tps->irq_mask = (TPS65217_INT_RESERVEDM | TPS65217_INT_PBM
>>>>> +            | TPS65217_INT_ACM | TPS65217_INT_USBM);
>>>>> +    tps65217_reg_write(tps, TPS65217_REG_INT, tps->irq_mask,
>>>>> +            TPS65217_PROTECT_NONE);
>>>>> +
>>>>> +    tps->irq_domain = irq_domain_add_linear(tps->dev->of_node,
>>>>> +        TPS65217_NUM_IRQ, &tps65217_irq_domain_ops, tps);
>>>>> +    if (!tps->irq_domain) {
>>>>> +        dev_err(tps->dev, "Could not create IRQ domain\n");
>>>>> +        return -ENOMEM;
>>>>> +    }
>>>>> +
>>>>> +    ret = devm_request_threaded_irq(tps->dev, irq, NULL,
>>>>> +                    tps65217_irq_thread,
>>>>> +                    IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>>>>
>>>> Are there any reasons why IRQ trigger type specified here explicitly?
>>>
>>> Not really. I have configured it that way, it worked and I forgot about
>>> it when preparing patches. Could you give some hint here?
>>>
>>
>> It's better to get it from DT and in case of DT boot it will - the real
>> IRQ trigger type may depends on board.
>>
> 
> So what I understand, I need to remove IRQF_TRIGGER_RISING here.
> Addidional flags will be passed by 'irq_flags' in
> "interrupts = <irq_num irq_flags>" in DT, right?

Indeed. And usually it is not "Addidional flags" - its mandatory cell for
 the most of IRQ controllers.

The problem with hard-coded IRQ trigger type values in code is that on
different boards IRQ can be wired on different way - to the GIC/INTC,
to SoC GPIO, to GPIO expanders and .. And they can support different sets
of allowed IRQ triggering types. More over, on some boards IRQ signal can be
inverted, for example :P

So, It's more generic to not hard-code it if your driver is expected to be
used only with DT.
Also as per TRM http://www.ti.com/lit/ds/symlink/tps65217.pdf
nINT - interrupt output (active low, open drain). Pin is pulled low if an interrupt bit is set. The
       output goes high after the bit causing the interrupt in register INT has been read.
       The interrupt sources can be masked in register INT, so no interrupt is generated when the
       corresponding interrupt bit is set


-- 
regards,
-grygorii
