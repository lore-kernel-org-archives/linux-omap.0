From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource
 flags
Date: Thu, 06 Jun 2013 10:00:13 +0200
Message-ID: <51B0418D.7040708@collabora.co.uk>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk> <51633F26.7000400@gmail.com> <51634835.5010302@collabora.co.uk> <20130605232647.55C8B3E10E4@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:36025 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213Ab3FFIAU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jun 2013 04:00:20 -0400
In-Reply-To: <20130605232647.55C8B3E10E4@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <robherring2@gmail.com>, jgchunter@gmail.com, Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On 06/06/2013 01:26 AM, Grant Likely wrote:
> On Tue, 09 Apr 2013 00:44:05 +0200, Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:
>> On 04/09/2013 12:05 AM, Rob Herring wrote:
>> > On 04/05/2013 02:48 AM, Javier Martinez Canillas wrote:
>> >> This means that drivers that need the IRQ type/level flags defined in
>> >> the DT won't be able to get it.
>> > 
>> > But the interrupt controllers that need the information should be able
>> > to get to it via irqd_get_trigger_type. What problem exactly are you
>> > trying to fix? What driver would use this?
>> >
>> 
>> Yes but this is not about the interrupt controller wanting this information but
>> a device driver that is using the IORESOURCE_IRQ struct resource that has the
>> information about the virtual IRQ associated with a GPIO-IRQ.
>> 
>> The driver doesn't know neither care if its IRQ line is connected to a line of
>> an real IRQ controller or to a GPIO controller that allows a GPIO line to be
>> used as an IRQ.
>> 
>> > My understanding of the IORESOURCE_IRQ_xxx (and DMA) bits are they are
>> > ISA specific and therefore should not be used on non-ISA buses.
>> > 
>> 
>> Many TI OMAP2+ SoC based boards have an SMSC LAN911x/912x controller
>> (drivers/net/ethernet/smsc/smsc911x.c) that is connected to the OMAP processor
>> through its General-Purpose Memory Controller (GPMC) and this LAN driver obtain
>> its IRQ and I/O address space from a struct resource IORESOURCE_IRQ and
>> IORESOURCE_MEM respectively, that is filled by the DeviceTree core.
>> 
>> It does this:
>> 
>> irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;
>> 
>> Since of_irq_to_resource() doesn't fill the trigger/level flags on the
>> IORESOURCE_IRQ struct resource, irq_flags will always be 0 regarding the value
>> specified on the second cell of the "interrupts" DT property.
>> 
>> A previous discussion about this can be found here [1].
> 
> I can't remember if there was ever a reason for not returning the IRQ
> flags, but I don't have any major objection to doing so if drivers find
> them useful. The one concern I do have however is if it will cause any
> problems with drivers that expect flags == IORESOURCE_IRQ without any
> additional flags. Any users doing that are buggy anyway, but I do want
> to be careful about breakage.
> 
> I'll go over your patch and reply with comments.
> 
> g.
>

It turns out that if you don't pass a trigger type to the request_irq() call, it
will use the trigger type set by the irq chip earlier with .xlate

For some reasons it was not getting the right trigger type when I sent this
patch but now it is working correctly so probably there was a bug on the
irq_chip driver I was using (drivers/gpio/gpio-omap.c) and got fixed in the
meantime.

So I don't need this patch anymore to make the LAN chip work on my board and I
don't know if the fact that an empty edge/level flags defaults to what was set
using the .xlate function handler and this function is called in
irq_create_of_mapping() is a reason enough to not return the IRQ flags on the
struct resource.

Having said that, if you still think this patch is useful then I can send a v2
that take into account your comments on the patch.

Best regards,
Javier

