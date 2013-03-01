From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: omap: IORESOURCE_IRQ flags not set when defining a GPIO-IRQ from DT
Date: Fri, 1 Mar 2013 17:17:57 +0100
Message-ID: <CAAwP0s3ZzGf+_diZiQ7DSfWj74Sh=E9F+j=4UGnw8meHDR2AZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:32885 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab3CAQSS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 11:18:18 -0500
Received: by mail-ia0-f174.google.com with SMTP id u20so2748866iag.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Mar 2013 08:18:17 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>

Hi Jon,

NOTE: I'm changing $subject to something more relevant to stop adding
noise on the original thread.

On Thu, Feb 28, 2013 at 9:49 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> On 02/28/2013 06:17 AM, Javier Martinez Canillas wrote:
>> On Thu, Feb 28, 2013 at 12:16 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>>>
>>> On 02/26/2013 09:57 PM, Javier Martinez Canillas wrote:
>>>
>>> [snip]
>>>
>>>> Something like that would definitely solve the GPIO request issue but
>>>> we still have the issue that the current OMAP GPIO controller binding
>>>> does not support #interrupt-cells = <2>.
>>>>
>>>> So, we can't pass the trigger type and level flags for an IRQ-GPIO
>>>> when using an GPIO controller as the interrupt-parent for a device
>>>> node.
>>>>
>>>> Do you have any comments on that issue?
>>>
>>> Can you elaborate a bit more on why you say this is not supported?
>>>
>>> I have been playing with this today on an omap board and if I set the
>>> #interrupt-cells = <2>, then I do see that irq_domain_xlate_onetwocell()
>>> is called and the irq number and flags read as expected. Following which
>>> I then see it will call the omap_irq_type() to set type. So AFAICT it works.
>>>
>>
>> Yes, it does.
>>
>> I (wrongly) assumed that it was not working since the GPIO OMAP
>> binding documentation says that #interrupt-cells should be <2> but all
>> OMAP2+ DTs use <1> instead. Also, when trying to change to <2> I had
>> the kernel hang.
>>
>> But it was indeed that the GPIO bank was not enabled before calling
>> gpio_irq_type() and this made the kernel to hang. Your patch fixed the
>> issue and allowed me to find the cause.
>>
>> The problem was that when using the DT hack of defining the GPIO in
>> the ethernet chip regulator,  the calls to
>> irq_domain_xlate_onetwocell() and gpio_irq_type() were made before the
>> call to gpio_request_one() so the GPIO bank was not enabled.
>>
>> If gpio_request() is called in gpmc_probe_dt(), then the GPIO bank is
>> enabled and gpio_irq_type() succeeds.
>>
>> So, it was just me being stupid and don't understanding the implementation.
>
> No problem. Glad we are on the same page :-)
>
>>> Please note I do see that when the SMC driver calls request_irq() in
>>> smc_drv_probe() it is also settings the trigger type to
>>> IRQ_TYPE_EDGE_RISING (default). So if you are setting to low-level
>>> sensitive in DT, then this is being overwritten. We could fix this by
>>> setting SMC_IRQ_FLAGS to -1 for OMAP.
>>>
>>
>> Please note that I'm using a SMSC 911x chip and not a SMSC 91x, so the
>> driver is not smc91x but smc911x. It has the same behaviour though
>> (IRQ flags overwritten somehow), just to be sure that we are on the
>> same page.
>>
>> I don't know if just setting SMC_IRQ_FLAGS to -1 will be enough to fix
>> the smc91x since request_irq() is just passing whatever value is in
>> irq_flags.
>>
>> By looking at the two drivers (smc91x and smsc911x) it seems that the
>> only difference on how they manage the flags is that smc91x does:
>>
>> unsigned long irq_flags = SMC_IRQ_FLAGS;
>> ...
>>        if (irq_flags == -1 || ires->flags & IRQF_TRIGGER_MASK)
>>                 irq_flags = ires->flags & IRQF_TRIGGER_MASK;
>>
>> while smsc911x driver's probe function uses the flags from the
>> resource unconditionally:
>>
>> irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;
>>
>> So, at the end both will set irq_flags to whatever is on the
>> IORESOURCE_IRQ struct resource flags member.
>
> Actually, that's not the case for smc91x. By default SMC_IRQ_FLAGS != -1
> (for omap) and so it will not set irq_flags to ires->flags &
> IRQF_TRIGGER_MASK. However, if I force irq_flags to be -1, then I see
> that irq_flags are to 0.
>

Yes, I meant that the behaviour is the same if you define
SMC_IRQ_FLAGS to -1 for omap.

>> The real problem is irq_flags to be 0 instead of the value defined on
>> the second cell of the "interrupts" property.
>
> So the resource flags for each irq is set in
> of_irq_to_resource() which just does ...
>
>         r->start = r->end = irq;
>         r->flags = IORESOURCE_IRQ;
>         r->name = name ? name : dev->full_name;
>
>
> of_irq_to_resource() calls irq_to_parse_and_map() which eventually just
> calls irq_set_irq_type() but type/flags is not returned and not populated.
>
> I am wondering if this is intentional.

Indeed, I was wondering the same.

>The irq_type is being correctly
> configured by irq_set_irq_type() when of_irq_to_resource() is called. In
> the smc driver, if irq_flags are 0, then when request_irq() is called
> the trigger type will not be set again (which is ok). __setup_irq has
> the following ...
>
>         /* Setup the type (level, edge polarity) if configured: */
>         if (new->flags & IRQF_TRIGGER_MASK) {
>                 ret = __irq_set_trigger(desc, irq,
>                         new->flags & IRQF_TRIGGER_MASK);
>
> Cheers
> Jon

I'll try to take a deeper look to this later next week.

Thanks a lot for your help!

Regards,
Javier
