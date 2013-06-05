From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource flags
Date: Thu, 06 Jun 2013 00:26:47 +0100
Message-ID: <20130605232647.55C8B3E10E4@localhost>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk> <51633F26.7000400@gmail.com> <51634835.5010302@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:39522 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab3FEX0w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jun 2013 19:26:52 -0400
Received: by mail-ee0-f50.google.com with SMTP id d49so760770eek.37
        for <linux-omap@vger.kernel.org>; Wed, 05 Jun 2013 16:26:50 -0700 (PDT)
In-Reply-To: <51634835.5010302@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Rob Herring <robherring2@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, 09 Apr 2013 00:44:05 +0200, Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:
> On 04/09/2013 12:05 AM, Rob Herring wrote:
> > On 04/05/2013 02:48 AM, Javier Martinez Canillas wrote:
> >> This means that drivers that need the IRQ type/level flags defined in
> >> the DT won't be able to get it.
> > 
> > But the interrupt controllers that need the information should be able
> > to get to it via irqd_get_trigger_type. What problem exactly are you
> > trying to fix? What driver would use this?
> >
> 
> Yes but this is not about the interrupt controller wanting this information but
> a device driver that is using the IORESOURCE_IRQ struct resource that has the
> information about the virtual IRQ associated with a GPIO-IRQ.
> 
> The driver doesn't know neither care if its IRQ line is connected to a line of
> an real IRQ controller or to a GPIO controller that allows a GPIO line to be
> used as an IRQ.
> 
> > My understanding of the IORESOURCE_IRQ_xxx (and DMA) bits are they are
> > ISA specific and therefore should not be used on non-ISA buses.
> > 
> 
> Many TI OMAP2+ SoC based boards have an SMSC LAN911x/912x controller
> (drivers/net/ethernet/smsc/smsc911x.c) that is connected to the OMAP processor
> through its General-Purpose Memory Controller (GPMC) and this LAN driver obtain
> its IRQ and I/O address space from a struct resource IORESOURCE_IRQ and
> IORESOURCE_MEM respectively, that is filled by the DeviceTree core.
> 
> It does this:
> 
> irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;
> 
> Since of_irq_to_resource() doesn't fill the trigger/level flags on the
> IORESOURCE_IRQ struct resource, irq_flags will always be 0 regarding the value
> specified on the second cell of the "interrupts" DT property.
> 
> A previous discussion about this can be found here [1].

I can't remember if there was ever a reason for not returning the IRQ
flags, but I don't have any major objection to doing so if drivers find
them useful. The one concern I do have however is if it will cause any
problems with drivers that expect flags == IORESOURCE_IRQ without any
additional flags. Any users doing that are buggy anyway, but I do want
to be careful about breakage.

I'll go over your patch and reply with comments.

g.

