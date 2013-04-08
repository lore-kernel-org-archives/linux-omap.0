From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource
 flags
Date: Mon, 08 Apr 2013 17:05:26 -0500
Message-ID: <51633F26.7000400@gmail.com>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:51879 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759408Ab3DHWF3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 18:05:29 -0400
Received: by mail-ob0-f171.google.com with SMTP id v19so3168897obq.16
        for <linux-omap@vger.kernel.org>; Mon, 08 Apr 2013 15:05:29 -0700 (PDT)
In-Reply-To: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>, Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On 04/05/2013 02:48 AM, Javier Martinez Canillas wrote:
> According to Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> the "#interrupt-cells" property of an "interrupt-controller" is used
> to define the number of cells needed to specify a single interrupt.
> 
> A commonly used variant is two cell on which #interrupt-cells = <2>
> and the first cell defines the index of the interrupt in the controller
> and the second cell is used to specify any of the following flags:
> 
>     - bits[3:0] trigger type and level flags
>         1 = low-to-high edge triggered
>         2 = high-to-low edge triggered
>         4 = active high level-sensitive
>         8 = active low level-sensitive
> 
> An example of an interrupt controller which use the two cell format is
> the OMAP GPIO controller that allows GPIO lines to be used as IRQ
> (Documentation/devicetree/bindings/gpio/gpio-omap.txt)
> 
> But setting #interrupt-cells = <2> on the OMAP GPIO device node and
> specifying the GPIO-IRQ type and level flags on the second cell does not
> store this value on the populated IORESOURCE_IRQ struct resource.
> 
> This is because when using an IRQ from an interrupt controller and
> setting both cells (e.g:)
> 
> 	interrupt-parent = <&gpio6>;
> 	interrupts = <16 8>;
> 
> A call to of_irq_to_resource() is made and this function calls to
> irq_of_parse_and_map_type() to get the virtual IRQ mapped to the real
> index for this interrupt controller. This IRQ number is populated on
> the struct resource:
> 
> int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
> {
> 	int irq = irq_of_parse_and_map(dev, index);
> 	..
> 	r->start = r->end = irq;
> }
> 
> irq_of_parse_and_map() calls to irq_create_of_mapping() which calls to
> the correct xlate function handler according to "#interrupt-cells"
> (irq_domain_xlate_onecell or irq_domain_xlate_twocell) and to
> irq_set_irq_type() to set the IRQ type.
> 
> But the type is never returned so it can't be saved on the IRQ struct
> resource flags member.
> 
> This means that drivers that need the IRQ type/level flags defined in
> the DT won't be able to get it.

But the interrupt controllers that need the information should be able
to get to it via irqd_get_trigger_type. What problem exactly are you
trying to fix? What driver would use this?

My understanding of the IORESOURCE_IRQ_xxx (and DMA) bits are they are
ISA specific and therefore should not be used on non-ISA buses.

Rob


