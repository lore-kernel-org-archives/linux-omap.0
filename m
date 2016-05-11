From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V2 13/14] dt-bindings: arm-gic: Add documentation for
 Tegra210 AGIC
Date: Wed, 11 May 2016 17:10:59 +0100
Message-ID: <57335993.2010809@nvidia.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
 <1461150237-15580-14-git-send-email-jonathanh@nvidia.com>
 <20160422100052.GA10606@leverpostej> <571A0739.3090502@nvidia.com>
 <20160422112239.GF10606@leverpostej> <5720DC1D.1080802@nvidia.com>
 <20160427173810.GC7359@leverpostej> <5721C597.1010105@nvidia.com>
 <20160428095525.GB21145@leverpostej> <572C56A6.7020408@nvidia.com>
 <CAMuHMdX+egbNPP4QQ2R28GbyVkg9qBrwYfUy8EE0PdB6od+LBg@mail.gmail.com>
 <CAL_Jsq+HSH7e1T9y47nHV_x5NvZ-52cfDEKKFkr16ax671FxSw@mail.gmail.com>
 <573358F9.6000108@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <573358F9.6000108@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


On 11/05/16 17:08, Jon Hunter wrote:
> Hi Rob,
> 
> On 11/05/16 16:51, Rob Herring wrote:
>> On Sat, May 7, 2016 at 9:10 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> Hi Jon,
>>>
>>> On Fri, May 6, 2016 at 10:32 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>> The "nvidia,tegra210-agic" string can be taken as describing any
>>>>> Tegra-210 specific integration quirks, though I agree that's also not
>>>>> fantastic for extending PM support beyond Tegra 210 and variants
>>>>> thereof.
>>>>>
>>>>> So maybe the best approach is bailing out in the presence of clocks
>>>>> and/or power domains after all, on the assumption that nothing today has
>>>>> those properties, though I fear we may have problems with that later
>>>>> down the line if/when people describe those for the root GIC to describe
>>>>> those must be hogged, even if not explicitly managed.
>>>>
>>>> On further testing, by bailing out in the presence of clocks and/or
>>>> power-domains, the problem I now see is that although the primary gic-400
>>>> has been registered, we still try to probe it again later as it matches
>>>> the platform driver. One way to avoid this would be ...
>>>>
>>>> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
>>>> index e7bfc175b8e1..631da7ad0dbf 100644
>>>> --- a/drivers/of/irq.c
>>>> +++ b/drivers/of/irq.c
>>>> @@ -556,6 +556,8 @@ void __init of_irq_init(const struct of_device_id *matches)
>>>>                          * its children can get processed in a subsequent pass.
>>>>                          */
>>>>                         list_add_tail(&desc->list, &intc_parent_list);
>>>> +
>>>> +                       of_node_set_flag(desc->dev, OF_POPULATED);
>>>>                 }
>>>
>>> That sounds like the right thing to do to me...
>>
>> Seems fine to me, but it would be a problem since this is a global
>> decision if you wanted to have some hand-off from an "early driver" to
>> a platform driver. I guess setting the flag could move to drivers that
>> need it although I don't think drivers should be touching the flags.
> 
> Isn't this the other way around? Setting this flag means that I have
> been populated and so don't bother creating a platform device for this
> device as it isn't needed. A by-product if this, is that if we did
> happen to have a platform driver for the irqchip that also has an early
> driver, then the hand-off would never happen if the early init was
> successful.
> 
> The driver would still have to decide whether to hand-off and to do that
> it would need to return an error from the early driver [0].

I mean, the "early driver would still have to decide whether to hand-off
..."

Jon
