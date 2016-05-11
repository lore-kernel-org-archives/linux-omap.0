From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 13/14] dt-bindings: arm-gic: Add documentation for
 Tegra210 AGIC
Date: Wed, 11 May 2016 11:30:18 -0500
Message-ID: <CAL_Jsq+ZhwUOSfQG-8V9xgxiXBj2j3Q6k48d=BWtWK9pEHH_MQ@mail.gmail.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
 <1461150237-15580-14-git-send-email-jonathanh@nvidia.com> <20160422100052.GA10606@leverpostej>
 <571A0739.3090502@nvidia.com> <20160422112239.GF10606@leverpostej>
 <5720DC1D.1080802@nvidia.com> <20160427173810.GC7359@leverpostej>
 <5721C597.1010105@nvidia.com> <20160428095525.GB21145@leverpostej>
 <572C56A6.7020408@nvidia.com> <CAMuHMdX+egbNPP4QQ2R28GbyVkg9qBrwYfUy8EE0PdB6od+LBg@mail.gmail.com>
 <CAL_Jsq+HSH7e1T9y47nHV_x5NvZ-52cfDEKKFkr16ax671FxSw@mail.gmail.com>
 <573358F9.6000108@nvidia.com> <57335AD3.7070109@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57335AD3.7070109-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, May 11, 2016 at 11:16 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>
> On 11/05/16 17:08, Jon Hunter wrote:
>> Hi Rob,
>>
>> On 11/05/16 16:51, Rob Herring wrote:
>>> On Sat, May 7, 2016 at 9:10 AM, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
>>>> Hi Jon,
>>>>
>>>> On Fri, May 6, 2016 at 10:32 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>>>>> The "nvidia,tegra210-agic" string can be taken as describing any
>>>>>> Tegra-210 specific integration quirks, though I agree that's also not
>>>>>> fantastic for extending PM support beyond Tegra 210 and variants
>>>>>> thereof.
>>>>>>
>>>>>> So maybe the best approach is bailing out in the presence of clocks
>>>>>> and/or power domains after all, on the assumption that nothing today has
>>>>>> those properties, though I fear we may have problems with that later
>>>>>> down the line if/when people describe those for the root GIC to describe
>>>>>> those must be hogged, even if not explicitly managed.
>>>>>
>>>>> On further testing, by bailing out in the presence of clocks and/or
>>>>> power-domains, the problem I now see is that although the primary gic-400
>>>>> has been registered, we still try to probe it again later as it matches
>>>>> the platform driver. One way to avoid this would be ...
>>>>>
>>>>> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
>>>>> index e7bfc175b8e1..631da7ad0dbf 100644
>>>>> --- a/drivers/of/irq.c
>>>>> +++ b/drivers/of/irq.c
>>>>> @@ -556,6 +556,8 @@ void __init of_irq_init(const struct of_device_id *matches)
>>>>>                          * its children can get processed in a subsequent pass.
>>>>>                          */
>>>>>                         list_add_tail(&desc->list, &intc_parent_list);
>>>>> +
>>>>> +                       of_node_set_flag(desc->dev, OF_POPULATED);
>>>>>                 }
>>>>
>>>> That sounds like the right thing to do to me...
>>>
>>> Seems fine to me, but it would be a problem since this is a global
>>> decision if you wanted to have some hand-off from an "early driver" to
>>> a platform driver. I guess setting the flag could move to drivers that
>>> need it although I don't think drivers should be touching the flags.
>>
>> Isn't this the other way around? Setting this flag means that I have
>> been populated and so don't bother creating a platform device for this
>> device as it isn't needed. A by-product if this, is that if we did
>> happen to have a platform driver for the irqchip that also has an early
>> driver, then the hand-off would never happen if the early init was
>> successful.
>>
>> The driver would still have to decide whether to hand-off and to do that
>> it would need to return an error from the early driver [0].
>>
>>>>> If this is not appropriate then I guess I will just need to use
>>>>> "tegra210-agic" for the compatibility flag.
>>>>
>>>> As I want this for plain gic-400, I'd be unhappy ;-)
>>>
>>> IMO, the plain gic-400 should not have these dependencies and you
>>> should use SoC specific compatible strings should you need to deal
>>> with this problem.
>>
>> It is fine for my case, but it does mean I cannot say ...
>>
>>       compatible = "tegra210-agic", "gic-400";
>>
>> ... because this will always match the early driver (unless we do
>> something like I have suggested above). So I would have ...
>
> Sorry this is wrong. The above will always match the early driver.
>
> The problem with the above compatibility string is that, if the platform
> driver matches "gic-400" then it will try to probe all gic-400s even if
> they have been initialised early and this is definitely not what we
> want. This could be solved by setting the OF_POPULATED flag.

A platform driver for just gic-400 is wrong IMO until we have platform
drivers for all interrupt controllers.

Another reason to set OF_POPULATED flag is we are needlessly creating
platform devices for irq controllers that will never have platform
drivers. So I'd go with that approach.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
