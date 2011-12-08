From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2/3: intc: Add DT support for TI interrupt
 controller
Date: Thu, 8 Dec 2011 15:59:50 +0100
Message-ID: <4EE0D0E6.3060202@ti.com>
References: <1323291049-24964-1-git-send-email-b-cousson@ti.com> <1323291049-24964-3-git-send-email-b-cousson@ti.com> <4EDFD88B.8060008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51867 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394Ab1LHPAP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Dec 2011 10:00:15 -0500
In-Reply-To: <4EDFD88B.8060008@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/7/2011 10:20 PM, Rob Herring wrote:
> On 12/07/2011 02:50 PM, Benoit Cousson wrote:

[...]

>> +#ifdef CONFIG_OF
>> +int __init intc_of_init(struct device_node *node, struct device_node *parent)
>> +{
>> +	struct resource res;
>> +	u32 nr_irqs;
>> +
>> +	if (WARN_ON(!node))
>> +		return -ENODEV;
>> +
>> +	if (of_address_to_resource(node, 0,&res)) {
>> +		WARN(1, "unable to get intc registers\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (of_property_read_u32(node, "ti,intc-size",&nr_irqs)) {
>> +		WARN(1, "unable to get intc-size\n");
>> +		return -EINVAL;
>
> There is no default value that makes sense?

So far we have 96 or 128, so I can put 96 as a default and just keep the 
warning without returning an error.

>> +	}
>> +
>> +	omap_init_irq(res.start, nr_irqs);
>> +	irq_domain_add_simple(node, 0);
>
> Have you read the NO_IRQ thread...

Yeah, I tried, but that's a long email thread with some unclear 
conclusion...
The point is that the few users of that API today are using 0 as a base 
as well, so I thought it was still valid.

> Is 0 ever a valid interrupt for a driver? If so, you must not use 0 for
> the base. I would pick 16 to skip over legacy ISA irqs.

I do not have any 0 interrupts right now, my concern is that I still 
have some legacy non-DT drivers that expect the previous hwirq = irq 
mapping.

> irqdomains should always be enabled regardless of CONFIG_OF. So either
> you can leave it as is if OF is always enabled for OMAP, or you should
> move domain setup into omap_init_irq.

OK, but it looks like I cannot really modify the current INTC to DT 
without having fully adapted the OMAP drivers to use 
irq_of_parse_and_map. Or did I miss something?

Regards,
Benoit
