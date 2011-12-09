From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2/3: intc: Add DT support for TI interrupt
 controller
Date: Fri, 09 Dec 2011 07:20:56 -0600
Message-ID: <4EE20B38.8050006@gmail.com>
References: <1323291049-24964-1-git-send-email-b-cousson@ti.com> <1323291049-24964-3-git-send-email-b-cousson@ti.com> <4EDFD88B.8060008@gmail.com> <4EE0D0E6.3060202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58461 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab1LINVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 08:21:09 -0500
Received: by ghbz2 with SMTP id z2so2489120ghb.19
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 05:21:08 -0800 (PST)
In-Reply-To: <4EE0D0E6.3060202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/08/2011 08:59 AM, Cousson, Benoit wrote:
> On 12/7/2011 10:20 PM, Rob Herring wrote:
>> On 12/07/2011 02:50 PM, Benoit Cousson wrote:
> 
> [...]
> 
>>> +#ifdef CONFIG_OF
>>> +int __init intc_of_init(struct device_node *node, struct device_node
>>> *parent)
>>> +{
>>> +    struct resource res;
>>> +    u32 nr_irqs;
>>> +
>>> +    if (WARN_ON(!node))
>>> +        return -ENODEV;
>>> +
>>> +    if (of_address_to_resource(node, 0,&res)) {
>>> +        WARN(1, "unable to get intc registers\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (of_property_read_u32(node, "ti,intc-size",&nr_irqs)) {
>>> +        WARN(1, "unable to get intc-size\n");
>>> +        return -EINVAL;
>>
>> There is no default value that makes sense?
> 
> So far we have 96 or 128, so I can put 96 as a default and just keep the
> warning without returning an error.
> 
>>> +    }
>>> +
>>> +    omap_init_irq(res.start, nr_irqs);
>>> +    irq_domain_add_simple(node, 0);
>>
>> Have you read the NO_IRQ thread...
> 
> Yeah, I tried, but that's a long email thread with some unclear
> conclusion...
> The point is that the few users of that API today are using 0 as a base
> as well, so I thought it was still valid.
> 
>> Is 0 ever a valid interrupt for a driver? If so, you must not use 0 for
>> the base. I would pick 16 to skip over legacy ISA irqs.
> 
> I do not have any 0 interrupts right now, my concern is that I still
> have some legacy non-DT drivers that expect the previous hwirq = irq
> mapping.

I guess it depends how easily you can shift all the irq defines. You
allow specifying the base so that you can set it to 0 for non-DT and -1
(dynamic allocation) for DT.

> 
>> irqdomains should always be enabled regardless of CONFIG_OF. So either
>> you can leave it as is if OF is always enabled for OMAP, or you should
>> move domain setup into omap_init_irq.
> 
> OK, but it looks like I cannot really modify the current INTC to DT
> without having fully adapted the OMAP drivers to use
> irq_of_parse_and_map. Or did I miss something?
> 

No, the drivers should not need to be modified as long as they get the
irq's from platform device resources. You just want to make sure the
INTC has no knowledge of it's irq base so it can change.

Rob
