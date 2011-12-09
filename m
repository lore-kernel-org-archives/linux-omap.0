From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2/3: intc: Add DT support for TI interrupt
 controller
Date: Fri, 09 Dec 2011 09:22:12 -0600
Message-ID: <4EE227A4.2030209@gmail.com>
References: <1323291049-24964-1-git-send-email-b-cousson@ti.com> <1323291049-24964-3-git-send-email-b-cousson@ti.com> <4EDFD88B.8060008@gmail.com> <4EE0D0E6.3060202@ti.com> <4EE20B38.8050006@gmail.com> <4EE2209E.2040209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57315 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab1LIPWY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 10:22:24 -0500
Received: by yenm11 with SMTP id m11so2144215yen.19
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 07:22:24 -0800 (PST)
In-Reply-To: <4EE2209E.2040209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/09/2011 08:52 AM, Cousson, Benoit wrote:
> On 12/9/2011 2:20 PM, Rob Herring wrote:
>> On 12/08/2011 08:59 AM, Cousson, Benoit wrote:
>>> On 12/7/2011 10:20 PM, Rob Herring wrote:
>>>> On 12/07/2011 02:50 PM, Benoit Cousson wrote:
>>>
>>> [...]
>>>
>>>>> +#ifdef CONFIG_OF
>>>>> +int __init intc_of_init(struct device_node *node, struct device_node
>>>>> *parent)
>>>>> +{
>>>>> +    struct resource res;
>>>>> +    u32 nr_irqs;
>>>>> +
>>>>> +    if (WARN_ON(!node))
>>>>> +        return -ENODEV;
>>>>> +
>>>>> +    if (of_address_to_resource(node, 0,&res)) {
>>>>> +        WARN(1, "unable to get intc registers\n");
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +
>>>>> +    if (of_property_read_u32(node, "ti,intc-size",&nr_irqs)) {
>>>>> +        WARN(1, "unable to get intc-size\n");
>>>>> +        return -EINVAL;
>>>>
>>>> There is no default value that makes sense?
>>>
>>> So far we have 96 or 128, so I can put 96 as a default and just keep the
>>> warning without returning an error.
>>>
>>>>> +    }
>>>>> +
>>>>> +    omap_init_irq(res.start, nr_irqs);
>>>>> +    irq_domain_add_simple(node, 0);
>>>>
>>>> Have you read the NO_IRQ thread...
>>>
>>> Yeah, I tried, but that's a long email thread with some unclear
>>> conclusion...
>>> The point is that the few users of that API today are using 0 as a base
>>> as well, so I thought it was still valid.
>>>
>>>> Is 0 ever a valid interrupt for a driver? If so, you must not use 0 for
>>>> the base. I would pick 16 to skip over legacy ISA irqs.
>>>
>>> I do not have any 0 interrupts right now, my concern is that I still
>>> have some legacy non-DT drivers that expect the previous hwirq = irq
>>> mapping.
>>
>> I guess it depends how easily you can shift all the irq defines. You
>> allow specifying the base so that you can set it to 0 for non-DT and -1
>> (dynamic allocation) for DT.
> 
> The issue, is that the IRQs are not defined anymore but hard coded in
> the hwmod database. And the idea is that this is reflecting exactly the
> hwirq from the spec, so I do not want to add any artificial offset for
> the domain in the original data.
> 
>>>> irqdomains should always be enabled regardless of CONFIG_OF. So either
>>>> you can leave it as is if OF is always enabled for OMAP, or you should
>>>> move domain setup into omap_init_irq.
>>>
>>> OK, but it looks like I cannot really modify the current INTC to DT
>>> without having fully adapted the OMAP drivers to use
>>> irq_of_parse_and_map. Or did I miss something?
>>>
>>
>> No, the drivers should not need to be modified as long as they get the
>> irq's from platform device resources. You just want to make sure the
>> INTC has no knowledge of it's irq base so it can change.
> 
> OK, the driver will not have to change but the IRQ value will not be the
> same in the case of DT since it will use the irq_create_of_mapping.
> 
> Currently, the driver IRQ resource is 7 for example for the twl, this is
> the hwirq (= irq). If I use a domain with a base of 16, the resource
> will still be 7 except if the resource is created from OF, then it will
> be 23.
> 
> The only way I have today to maintain the legacy drivers to work without
> hacking the OMAP resource code is to keep the base_irq at 0.
> 

For non-DT case, that is fine. It should not be hard to support 0 for
legacy and !0 for DT.

> Since I do not have any hwirq at 0 so far, is it a big deal to keep the
> base_irq at 0 for the moment?
> It will be easier to transition to DT that way without breaking the
> existing drivers.

As long as it is trivial to change later. I'm afraid that if it is not
changed, then we won't know if it is trivial.

Rob

