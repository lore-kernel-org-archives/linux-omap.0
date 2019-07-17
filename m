From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 2/6] irqchip/irq-pruss-intc: Add a PRUSS irqchip driver
 for PRUSS interrupts
Date: Wed, 17 Jul 2019 13:56:25 -0500
Message-ID: <0c81706f-3a86-8e84-312a-5001e34fc5a2@ti.com>
References: <20190708035243.12170-1-s-anna@ti.com>
 <20190708035243.12170-3-s-anna@ti.com>
 <3d91800b-e858-8c73-5ea8-e99e5ea30e8e@lechnology.com>
 <54e871a8-dfa4-f65b-5869-d1661144cbf0@ti.com>
 <5241ecb9-4ab2-b01c-367c-38c554c056c4@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5241ecb9-4ab2-b01c-367c-38c554c056c4@lechnology.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: Tony Lindgren <tony@atomide.com>, "Andrew F. Davis" <afd@ti.com>, Roger Quadros <rogerq@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Sekhar Nori <nsekhar@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 7/17/19 12:21 PM, David Lechner wrote:
> On 7/16/19 12:21 PM, Suman Anna wrote:
>>>> +static int pruss_intc_probe(struct platform_device *pdev)
>>>> +{
>>>> +    static const char * const irq_names[] = {
>>>> +                "host0", "host1", "host2", "host3",
>>>> +                "host4", "host5", "host6", "host7", };
>>>> +    struct device *dev = &pdev->dev;
>>>> +    struct pruss_intc *intc;
>>>> +    struct resource *res;
>>>> +    struct irq_chip *irqchip;
>>>> +    int i, irq;
>>>> +
>>>> +    intc = devm_kzalloc(dev, sizeof(*intc), GFP_KERNEL);
>>>> +    if (!intc)
>>>> +        return -ENOMEM;
>>>> +    platform_set_drvdata(pdev, intc);
>>>> +
>>>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +    intc->base = devm_ioremap_resource(dev, res);
>>>> +    if (IS_ERR(intc->base)) {
>>>> +        dev_err(dev, "failed to parse and map intc memory
>>>> resource\n");
>>>> +        return PTR_ERR(intc->base);
>>>> +    }
>>>> +
>>>> +    dev_dbg(dev, "intc memory: pa %pa size 0x%zx va %pK\n",
>>>> &res->start,
>>>> +        (size_t)resource_size(res), intc->base);
>>>> +
>>>> +    mutex_init(&intc->lock);
>>>> +
>>>> +    pruss_intc_init(intc);
>>>> +
>>>> +    irqchip = devm_kzalloc(dev, sizeof(*irqchip), GFP_KERNEL);
>>>> +    if (!irqchip)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    irqchip->irq_ack = pruss_intc_irq_ack;
>>>> +    irqchip->irq_mask = pruss_intc_irq_mask;
>>>> +    irqchip->irq_unmask = pruss_intc_irq_unmask;
>>>> +    irqchip->irq_retrigger = pruss_intc_irq_retrigger;
>>>> +    irqchip->irq_request_resources = pruss_intc_irq_reqres;
>>>> +    irqchip->irq_release_resources = pruss_intc_irq_relres;
>>>> +    irqchip->name = dev_name(dev);
>>>
>>> Should we also set `irqchip->parent_device = dev;` here?
>>>
>>> I tried it and had to add pm runtime stuff as well, otherwise
>>> requesting irqs would fail.
>>
>> I haven't seen any during my local testing. What sort of failure are you
>> seeing?
>>
>> The clocking for the overall PRUSS module will be handled in either the
>> ti-sysc driver for OMAP SoCs or in the pruss platform driver.
>>
> I was getting -EACCESS bubbling up from rpm_resume() in drivers/base/
> power/runtime.c. It was probably a mix of how I set up the device tree
> and the dummy PRUSS bus driver I made.
> 
> I'm sure it will be fine with a proper PRUSS platform driver.

Yeah, ok. You just need to have the power-domains property added in the
pruss node, and the pm_runtime calls in the pruss platform driver which
are missing in Roger's series.

I have the following line on my da850 pruss node.
power-domains = <&psc0 13>;

regards
Suman
