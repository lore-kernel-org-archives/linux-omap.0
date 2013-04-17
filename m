From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 17 Apr 2013 09:55:50 +0200
Message-ID: <CAAwP0s2M2pnSydyDvh_rejFO=w8bCo4WE5PkxrYuk0HQDixc-Q@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com>
 <515319D5.20105@wwwdotorg.org> <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com>
 <5155C902.7080207@wwwdotorg.org> <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
 <5165CB9D.1090202@wwwdotorg.org> <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com>
 <51671D7B.5060303@wwwdotorg.org> <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com>
 <51673D70.3010503@wwwdotorg.org> <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com>
 <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com>
 <516C31C3.9040505@wwwdotorg.org> <516C7C43.3040105@wwwdotorg.org>
 <516C8760.2050500@ti.com> <516D9B05.1000501@wwwdotorg.org>
 <516DA60A.5070000@ti.com> <516DCCA8.3070108@wwwdotorg.org>
 <516DDB4D.9020500@ti.com> <CAAwP0s0-VNUoeSKaGbvoDeD7m7kZRdp5rCJ7iVpFoFAaQtXcmQ@mail.gmail.com>
 <516E022F.5050708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33451 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965738Ab3DQH4K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Apr 2013 03:56:10 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so1600307ied.33
        for <linux-omap@vger.kernel.org>; Wed, 17 Apr 2013 00:56:10 -0700 (PDT)
In-Reply-To: <516E022F.5050708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 17, 2013 at 4:00 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> On 04/16/2013 07:41 PM, Javier Martinez Canillas wrote:
>> On Wed, Apr 17, 2013 at 1:14 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>>>
>>> On 04/16/2013 05:11 PM, Stephen Warren wrote:
>>>> On 04/16/2013 01:27 PM, Jon Hunter wrote:
>>>>>
>>>>> On 04/16/2013 01:40 PM, Stephen Warren wrote:
>>>>>> On 04/15/2013 05:04 PM, Jon Hunter wrote:
>>>> ...
>>>>>>> If some driver is calling gpio_request() directly, then they will most
>>>>>>> likely just call gpio_to_irq() when requesting the interrupt and so the
>>>>>>> xlate function would not be called in this case (mmc drivers are a good
>>>>>>> example). So I don't see that as being a problem. In fact that's the
>>>>>>> benefit of this approach as AFAICT it solves this problem.
>>>>>>
>>>>>> Oh. That assumption seems very fragile. What about drivers that actually
>>>>>> do have platform data (or DT bindings) that provide both the IRQ and
>>>>>> GPIO IDs, and hence don't use gpio_to_irq()? That's entirely possible.
>>>>>
>>>>> Right. In the DT case though, if someone does provide the IRQ and GPIO
>>>>> IDs then at least they would use a different xlate function. Another
>>>>> option to consider would be defining the #interrupt-cells = <3> where we
>>>>> would have ...
>>>>>
>>>>> cell-#1 --> IRQ domain ID
>>>>> cell-#2 --> Trigger type
>>>>> cell-#3 --> GPIO ID
>>>>>
>>>>> Then we could have a generic xlate for 3 cells that would also request
>>>>> the GPIO. Again not sure if people are against a gpio being requested in
>>>>> the xlate but just an idea. Or given that irq_of_parse_and_map() calls
>>>>> the xlate, we could have this function call gpio_request() if the
>>>>> interrupt controller is a gpio and there are 3 cells.
>>>>
>>>> I rather dislike this approach since:
>>>>
>>>> a) It requires changes to the DT bindings, which are already defined.
>>>> Admittedly it's backwards-compatible, but still.
>>>>
>>>> b) There isn't really any need for the DT to represent this; the
>>>> GPIO+IRQ driver itself already knows which IRQ ID is which GPIO ID and
>>>> vice-versa (if the HW has such a concept), so there's no need for the DT
>>>> to contain this information. This seems like pushing Linux's internal
>>>> requirements into the design of the DT binding.
>>>
>>> Yes, so the only alternative is to use irq_to_gpio to avoid this.
>>>
>>>> c) I have the feeling that hooking the of_xlate function for this is a
>>>> bit of an abuse of the function.
>>>
>>> I was wondering about that. So I was grep'ing through the various xlate
>>> implementations and found this [1]. Also you may recall that in the
>>> of_dma_simple_xlate() we call the dma_request_channel() to allocate the
>>> channel, which is very similar. However, I don't wish to get a
>>> reputation as abusing APIs so would be good to know if this really is
>>> abuse or not ;-)
>>>
>>> Cheers
>>> Jon
>>>
>>> [1] http://permalink.gmane.org/gmane.linux.ports.arm.kernel/195124
>>
>> I was looking at [1] shared by Jon and come up with the following
>> patch that does something similar for OMAP GPIO. This has the
>> advantage that is local to gpio-omap instead changing gpiolib-of and
>> also doesn't require DT changes
>>
>> But I don't want to get a reputation for abusing APIs neither :-)
>>
>> Best regards,
>> Javier
>>
>> From 23368eb72b125227fcf4b22be19ea70b4ab94556 Mon Sep 17 00:00:00 2001
>> From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Date: Wed, 17 Apr 2013 02:03:08 +0200
>> Subject: [PATCH 1/1] gpio/omap: add custom xlate function handler
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  drivers/gpio/gpio-omap.c |   29 ++++++++++++++++++++++++++++-
>>  1 files changed, 28 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 8524ce5..77216f9 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -1097,6 +1097,33 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
>>  static const struct of_device_id omap_gpio_match[];
>>  static void omap_gpio_init_context(struct gpio_bank *p);
>>
>> +static int omap_gpio_irq_domain_xlate(struct irq_domain *d,
>> +                                   struct device_node *ctrlr,
>> +                                   const u32 *intspec, unsigned int intsize,
>> +                                   irq_hw_number_t *out_hwirq,
>> +                                   unsigned int *out_type)
>> +{
>> +     int ret;
>> +     struct gpio_bank *bank = d->host_data;
>> +     int gpio = bank->chip.base + intspec[0];
>> +
>> +     if (WARN_ON(intsize < 2))
>> +             return -EINVAL;
>> +
>> +     ret = gpio_request_one(gpio, GPIOF_IN, ctrlr->full_name);
>> +     if (ret)
>> +             return ret;
>> +
>> +     *out_hwirq = intspec[0];
>> +     *out_type = (intsize > 1) ? intspec[1] : IRQ_TYPE_NONE;
>> +
>> +     return 0;
>> +}
>> +
>> +static struct irq_domain_ops omap_gpio_irq_ops = {
>> +     .xlate  = omap_gpio_irq_domain_xlate,
>> +};
>> +
>>  static int omap_gpio_probe(struct platform_device *pdev)
>>  {
>>       struct device *dev = &pdev->dev;
>> @@ -1144,7 +1171,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
>>
>>
>>       bank->domain = irq_domain_add_linear(node, bank->width,
>> -                                          &irq_domain_simple_ops, NULL);
>> +                                          &omap_gpio_irq_ops, bank);
>>       if (!bank->domain)
>>               return -ENODEV;
>>
>
> That would work for omap, in fact I posted pretty much the same thing a
> day ago [1] ;-)
>

Hi Jon,

There are so many patches flying around in this thread that I missed it :-)

Sorry about that...

> I was trying to see if we could find a common solution that everyone
> could use as it seems that ideally we should all be requesting the gpio.
>
> Cheers
> Jon
>
> [1] http://marc.info/?l=linux-arm-kernel&m=136606204823845&w=1

btw, I shared the latest patch with only build testing it, but today I
gave a try and I found a problem with this approach. The .xlate
function is being called twice for each GPIO-IRQ so the first time
gpio_request_one() succeeds but the second time it fails returning
-EBUSY.

This raises a warning on drivers/of/platform.c
(WARN_ON(of_irq_to_resource_table(np, res, num_irq) != num_irq)):

    0.285308] ------------[ cut here ]------------
[    0.285369] WARNING: at drivers/of/platform.c:171
of_device_alloc+0x154/0x168()
[    0.285430] Modules linked in:
[    0.285491] [<c001a944>] (unwind_backtrace+0x0/0xf0) from
[<c0041edc>] (warn_slowpath_common+0x4c/0x68)
[    0.285552] [<c0041edc>] (warn_slowpath_common+0x4c/0x68) from
[<c0041f14>] (warn_slowpath_null+0x1c/0x24)
[    0.285614] [<c0041f14>] (warn_slowpath_null+0x1c/0x24) from
[<c041ac3c>] (of_device_alloc+0x154/0x168)
[    0.285675] [<c041ac3c>] (of_device_alloc+0x154/0x168) from
[<c041ac84>] (of_platform_device_create_pdata+0x34/0x80)
[    0.285736] [<c041ac84>]
(of_platform_device_create_pdata+0x34/0x80) from [<c0027364>]
(gpmc_probe_generic_child+0x180/0x240)
[    0.285827] [<c0027364>] (gpmc_probe_generic_child+0x180/0x240)
from [<c00278d8>] (gpmc_probe+0x4b4/0x614)
[    0.285888] [<c00278d8>] (gpmc_probe+0x4b4/0x614) from [<c0325514>]
(platform_drv_probe+0x18/0x1c)
[    0.285949] [<c0325514>] (platform_drv_probe+0x18/0x1c) from
[<c0324354>] (driver_probe_device+0x108/0x21c)
[    0.286010] [<c0324354>] (driver_probe_device+0x108/0x21c) from
[<c0322b2c>] (bus_for_each_drv+0x5c/0x88)
[    0.286071] [<c0322b2c>] (bus_for_each_drv+0x5c/0x88) from
[<c0324218>] (device_attach+0x78/0x90)
[    0.286132] [<c0324218>] (device_attach+0x78/0x90) from
[<c0323868>] (bus_probe_device+0x88/0xac)
[    0.286193] [<c0323868>] (bus_probe_device+0x88/0xac) from
[<c03220e8>] (device_add+0x4b0/0x584)
[    0.286254] [<c03220e8>] (device_add+0x4b0/0x584) from [<c041acac>]
(of_platform_device_create_pdata+0x5c/0x80)
[    0.286315] [<c041acac>]
(of_platform_device_create_pdata+0x5c/0x80) from [<c041ad9c>]
(of_platform_bus_create+0xcc/0x278)
[    0.286376] [<c041ad9c>] (of_platform_bus_create+0xcc/0x278) from
[<c041adfc>] (of_platform_bus_create+0x12c/0x278)
[    0.286468] [<c041adfc>] (of_platform_bus_create+0x12c/0x278) from
[<c041afa8>] (of_platform_populate+0x60/0x98)
[    0.286529] [<c041afa8>] (of_platform_populate+0x60/0x98) from
[<c070c5f8>] (omap_generic_init+0x24/0x60)
[    0.286590] [<c070c5f8>] (omap_generic_init+0x24/0x60) from
[<c06fe4c4>] (customize_machine+0x1c/0x28)
[    0.286651] [<c06fe4c4>] (customize_machine+0x1c/0x28) from
[<c00086a4>] (do_one_initcall+0x34/0x178)
[    0.286712] [<c00086a4>] (do_one_initcall+0x34/0x178) from
[<c06fb8f4>] (kernel_init_freeable+0xfc/0x1c8)
[    0.286804] [<c06fb8f4>] (kernel_init_freeable+0xfc/0x1c8) from
[<c04e4668>] (kernel_init+0x8/0xe4)
[    0.286865] [<c04e4668>] (kernel_init+0x8/0xe4) from [<c0013170>]
(ret_from_fork+0x14/0x24)
[    0.287139] ---[ end trace d49d2507892be205 ]---

I probably won't have time to dig further on this until later this
week but I wanted to share with you in case you know why is being
calling twice and if you thought about a solution.

It works if I don't check the return gpio_request_one() (or better if
we don't return on omap_gpio_irq_domain_xlate) but of course is not
the right solution.

Thanks a lot and best regards,
Javier
