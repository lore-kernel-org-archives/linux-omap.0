From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource flags
Date: Tue, 9 Apr 2013 10:26:38 +0200
Message-ID: <CABxcv==GPmsC+-1-arFrA4xF5RbOtK1h-UMUDyft0PcbJCuF7A@mail.gmail.com>
References: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk>
	<51633F26.7000400@gmail.com>
	<516341AF.7030207@wwwdotorg.org>
	<51634B1F.4030408@collabora.co.uk>
	<516380D7.3060000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:35669 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935065Ab3DII0k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 04:26:40 -0400
Received: by mail-we0-f176.google.com with SMTP id s43so5245333wey.35
        for <linux-omap@vger.kernel.org>; Tue, 09 Apr 2013 01:26:39 -0700 (PDT)
In-Reply-To: <516380D7.3060000@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, Apr 9, 2013 at 4:45 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 04/08/2013 05:56 PM, Javier Martinez Canillas wrote:
>> On 04/09/2013 12:16 AM, Stephen Warren wrote:
>>> On 04/08/2013 04:05 PM, Rob Herring wrote:
>>>> On 04/05/2013 02:48 AM, Javier Martinez Canillas wrote:
>>>>> According to Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>>>> the "#interrupt-cells" property of an "interrupt-controller" is used
>>>>> to define the number of cells needed to specify a single interrupt.
>>> ...
>>>>> But the type is never returned so it can't be saved on the IRQ struct
>>>>> resource flags member.
>>>>>
>>>>> This means that drivers that need the IRQ type/level flags defined in
>>>>> the DT won't be able to get it.
>>>>
>>>> But the interrupt controllers that need the information should be able
>>>> to get to it via irqd_get_trigger_type. What problem exactly are you
>>>> trying to fix? What driver would use this?
>>>
>>> FYI, that is indeed what I did in sound/soc/codecs/wm8903.c. Thinking
>>> back, I'm not sure if that was the right thing or whether I should have
>>> sent this same patch:-)
>>>
>>
>> Hi Stephen,
>>
>> I'm glad you agree :-)
>>
>> I could change drivers/net/ethernet/smsc/smsc911x.c to get the type flags for
>> the IRQ with irqd_get_trigger_type() but I prefer $subject because:
>
> irqd_get_trigger_type probably is not meant for outside of irqchips.
> Creating an irq_get_irq_type function which takes an irq number would be
> the right function as that does not expose struct irq_data.
>

Ok, I can add an irqd_get_trigger_type() that just return the flags to
the caller without exposing the struct irq_data and using it on the
SMSC 911x driver instead using struct resource *irq_res->flags

I hope networking folks understand why this change is needed in this
driver to get the type/level flags for an IRQ defined on a DT...

>> a) This works in the non-DT case with board files and filling the resources from
>> platform data in arch/arm/mach-omap2/gpmc-smsc911x.c. So this is definitely a
>> bug on the DT core.
>
> And hackery/abuse like this:
>
> arch/arm/mach-omap2/board-3630sdp.c:32:    .flags          =
> GPMC_MUX_ADD_DATA | IORESOURCE_IRQ_LOWLEVEL,
>
>> b) I don't see why of_irq_to_resource() should discard the type/level flags when
>> filling the IORESOURCE_IRQ if it was specified on the DT.
>>
>> c) We will have to change all drivers that expect to get the IRQ type flags from
>> a IORESOURCE_IRQ struct resource.
>
> I'm not convinced that is a high number of drivers. Nearly all the
> occurrences of IORESOURCE_IRQ_ in drivers/ are for ISA (acpi/pnp) and
> drivers for ISA devices.
>

If IORESOURCE_IRQ is just supposed to be used for ISA devices drivers
that use ACPI/PnP instead DT, then of_irq_to_resource() callers should
just use irq_of_parse_and_map() that returns the virtual IRQ number
for an index within a controller instead of a struct resource.

In fact I wonder what's the point to have an of_irq_to_resource()
function at all if  IORESOURCE_IRQ is not supposed to be used for
devices connected through dumb buses that need a DT and the struct
resource will only hold the mapped virtual IRQ number and no the IRQ
flags.

> Rob
>

Best regards,
Javier
