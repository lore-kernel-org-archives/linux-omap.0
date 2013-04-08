From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource
 flags
Date: Tue, 09 Apr 2013 00:44:05 +0200
Message-ID: <51634835.5010302@collabora.co.uk>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk> <51633F26.7000400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60121 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935888Ab3DHWoJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 18:44:09 -0400
In-Reply-To: <51633F26.7000400@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On 04/09/2013 12:05 AM, Rob Herring wrote:
> On 04/05/2013 02:48 AM, Javier Martinez Canillas wrote:
>> According to Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>> the "#interrupt-cells" property of an "interrupt-controller" is used
>> to define the number of cells needed to specify a single interrupt.
>> 
>> A commonly used variant is two cell on which #interrupt-cells = <2>
>> and the first cell defines the index of the interrupt in the controller
>> and the second cell is used to specify any of the following flags:
>> 
>>     - bits[3:0] trigger type and level flags
>>         1 = low-to-high edge triggered
>>         2 = high-to-low edge triggered
>>         4 = active high level-sensitive
>>         8 = active low level-sensitive
>> 
>> An example of an interrupt controller which use the two cell format is
>> the OMAP GPIO controller that allows GPIO lines to be used as IRQ
>> (Documentation/devicetree/bindings/gpio/gpio-omap.txt)
>> 
>> But setting #interrupt-cells = <2> on the OMAP GPIO device node and
>> specifying the GPIO-IRQ type and level flags on the second cell does not
>> store this value on the populated IORESOURCE_IRQ struct resource.
>> 
>> This is because when using an IRQ from an interrupt controller and
>> setting both cells (e.g:)
>> 
>> 	interrupt-parent = <&gpio6>;
>> 	interrupts = <16 8>;
>> 
>> A call to of_irq_to_resource() is made and this function calls to
>> irq_of_parse_and_map_type() to get the virtual IRQ mapped to the real
>> index for this interrupt controller. This IRQ number is populated on
>> the struct resource:
>> 
>> int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
>> {
>> 	int irq = irq_of_parse_and_map(dev, index);
>> 	..
>> 	r->start = r->end = irq;
>> }
>> 
>> irq_of_parse_and_map() calls to irq_create_of_mapping() which calls to
>> the correct xlate function handler according to "#interrupt-cells"
>> (irq_domain_xlate_onecell or irq_domain_xlate_twocell) and to
>> irq_set_irq_type() to set the IRQ type.
>> 
>> But the type is never returned so it can't be saved on the IRQ struct
>> resource flags member.
>> 
>> This means that drivers that need the IRQ type/level flags defined in
>> the DT won't be able to get it.
> 
> But the interrupt controllers that need the information should be able
> to get to it via irqd_get_trigger_type. What problem exactly are you
> trying to fix? What driver would use this?
>

Yes but this is not about the interrupt controller wanting this information but
a device driver that is using the IORESOURCE_IRQ struct resource that has the
information about the virtual IRQ associated with a GPIO-IRQ.

The driver doesn't know neither care if its IRQ line is connected to a line of
an real IRQ controller or to a GPIO controller that allows a GPIO line to be
used as an IRQ.

> My understanding of the IORESOURCE_IRQ_xxx (and DMA) bits are they are
> ISA specific and therefore should not be used on non-ISA buses.
> 

Many TI OMAP2+ SoC based boards have an SMSC LAN911x/912x controller
(drivers/net/ethernet/smsc/smsc911x.c) that is connected to the OMAP processor
through its General-Purpose Memory Controller (GPMC) and this LAN driver obtain
its IRQ and I/O address space from a struct resource IORESOURCE_IRQ and
IORESOURCE_MEM respectively, that is filled by the DeviceTree core.

It does this:

irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;

Since of_irq_to_resource() doesn't fill the trigger/level flags on the
IORESOURCE_IRQ struct resource, irq_flags will always be 0 regarding the value
specified on the second cell of the "interrupts" DT property.

A previous discussion about this can be found here [1].

> Rob
> 
> 

Thanks a lot and best regards,
Javier

[1]: https://patchwork.kernel.org/patch/2194911/
