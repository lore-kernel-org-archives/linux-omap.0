From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource
 flags
Date: Mon, 08 Apr 2013 21:45:43 -0500
Message-ID: <516380D7.3060000@gmail.com>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk> <51633F26.7000400@gmail.com> <516341AF.7030207@wwwdotorg.org> <51634B1F.4030408@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44974 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933990Ab3DICpq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 22:45:46 -0400
Received: by mail-oa0-f46.google.com with SMTP id k1so6998899oag.33
        for <linux-omap@vger.kernel.org>; Mon, 08 Apr 2013 19:45:46 -0700 (PDT)
In-Reply-To: <51634B1F.4030408@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On 04/08/2013 05:56 PM, Javier Martinez Canillas wrote:
> On 04/09/2013 12:16 AM, Stephen Warren wrote:
>> On 04/08/2013 04:05 PM, Rob Herring wrote:
>>> On 04/05/2013 02:48 AM, Javier Martinez Canillas wrote:
>>>> According to Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>>> the "#interrupt-cells" property of an "interrupt-controller" is used
>>>> to define the number of cells needed to specify a single interrupt.
>> ...
>>>> But the type is never returned so it can't be saved on the IRQ struct
>>>> resource flags member.
>>>>
>>>> This means that drivers that need the IRQ type/level flags defined in
>>>> the DT won't be able to get it.
>>>
>>> But the interrupt controllers that need the information should be able
>>> to get to it via irqd_get_trigger_type. What problem exactly are you
>>> trying to fix? What driver would use this?
>>
>> FYI, that is indeed what I did in sound/soc/codecs/wm8903.c. Thinking
>> back, I'm not sure if that was the right thing or whether I should have
>> sent this same patch:-)
>>
> 
> Hi Stephen,
> 
> I'm glad you agree :-)
> 
> I could change drivers/net/ethernet/smsc/smsc911x.c to get the type flags for
> the IRQ with irqd_get_trigger_type() but I prefer $subject because:

irqd_get_trigger_type probably is not meant for outside of irqchips.
Creating an irq_get_irq_type function which takes an irq number would be
the right function as that does not expose struct irq_data.

> a) This works in the non-DT case with board files and filling the resources from
> platform data in arch/arm/mach-omap2/gpmc-smsc911x.c. So this is definitely a
> bug on the DT core.

And hackery/abuse like this:

arch/arm/mach-omap2/board-3630sdp.c:32:    .flags          =
GPMC_MUX_ADD_DATA | IORESOURCE_IRQ_LOWLEVEL,

> b) I don't see why of_irq_to_resource() should discard the type/level flags when
> filling the IORESOURCE_IRQ if it was specified on the DT.
> 
> c) We will have to change all drivers that expect to get the IRQ type flags from
> a IORESOURCE_IRQ struct resource.

I'm not convinced that is a high number of drivers. Nearly all the
occurrences of IORESOURCE_IRQ_ in drivers/ are for ISA (acpi/pnp) and
drivers for ISA devices.

Rob
