From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V2 13/14] dt-bindings: arm-gic: Add documentation for
 Tegra210 AGIC
Date: Mon, 9 May 2016 10:32:53 +0100
Message-ID: <57305945.1080805@arm.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
 <1461150237-15580-14-git-send-email-jonathanh@nvidia.com>
 <20160422100052.GA10606@leverpostej> <571A0739.3090502@nvidia.com>
 <20160422112239.GF10606@leverpostej> <5720DC1D.1080802@nvidia.com>
 <20160427173810.GC7359@leverpostej> <5721C597.1010105@nvidia.com>
 <20160428095525.GB21145@leverpostej> <572C56A6.7020408@nvidia.com>
 <CAMuHMdX+egbNPP4QQ2R28GbyVkg9qBrwYfUy8EE0PdB6od+LBg@mail.gmail.com>
 <572F302A.6010506@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <572F302A.6010506-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 08/05/16 13:25, Jon Hunter wrote:
> Hi Geert,
> 
> On 07/05/16 15:10, Geert Uytterhoeven wrote:
>> Hi Jon,
>>
>> On Fri, May 6, 2016 at 10:32 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>>> The "nvidia,tegra210-agic" string can be taken as describing any
>>>> Tegra-210 specific integration quirks, though I agree that's also not
>>>> fantastic for extending PM support beyond Tegra 210 and variants
>>>> thereof.
>>>>
>>>> So maybe the best approach is bailing out in the presence of clocks
>>>> and/or power domains after all, on the assumption that nothing today has
>>>> those properties, though I fear we may have problems with that later
>>>> down the line if/when people describe those for the root GIC to describe
>>>> those must be hogged, even if not explicitly managed.
>>>
>>> On further testing, by bailing out in the presence of clocks and/or
>>> power-domains, the problem I now see is that although the primary gic-400
>>> has been registered, we still try to probe it again later as it matches
>>> the platform driver. One way to avoid this would be ...
>>>
>>> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
>>> index e7bfc175b8e1..631da7ad0dbf 100644
>>> --- a/drivers/of/irq.c
>>> +++ b/drivers/of/irq.c
>>> @@ -556,6 +556,8 @@ void __init of_irq_init(const struct of_device_id *matches)
>>>                          * its children can get processed in a subsequent pass.
>>>                          */
>>>                         list_add_tail(&desc->list, &intc_parent_list);
>>> +
>>> +                       of_node_set_flag(desc->dev, OF_POPULATED);
>>>                 }
>>
>> That sounds like the right thing to do to me...
> 
> OK. The more I think about this, it does seem silly to create a device
> and pdata for a device that has already been instantiated.
> 
>>> If this is not appropriate then I guess I will just need to use
>>> "tegra210-agic" for the compatibility flag.
>>
>> As I want this for plain gic-400, I'd be unhappy ;-)
> 
> No problem. However, there is more work that would be needed to get this
> to work for root controllers which I think that you want.

All this brings the discussion back to the root of the problem: irqchips
(and timers) are not first class devices, because we need them too early
for that.

I'd really like to solve this, but the kernel init is incredibly
complicated, and the subsystem dependencies completely undocumented. It
looks like we need the timer early because the we fork a thread for
PID-1, and the scheduler is going to need some form of tick.

So ideally, we'd be able to move the irq/timer stuff *after* the device
framework (which itself requires devtmpfs to be up and running, hence
dragging the whole VM and VFS), but before the scheduler is initialized.
I'm sure there is plenty of other dependencies I haven't worked out yet.

If anyone has some spare time and willing to help, please speak now! ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
