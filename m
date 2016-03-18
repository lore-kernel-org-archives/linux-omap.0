From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 14/15] dt-bindings: arm-gic: Drop 'clock-names' from
 binding document
Date: Fri, 18 Mar 2016 14:02:46 +0100
Message-ID: <CAMuHMdVQSm3209URvxHWgHs8grqXHap413+9kHyDwvKACOcaLA@mail.gmail.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
	<1458224359-32665-15-git-send-email-jonathanh@nvidia.com>
	<CAMuHMdV0QiWR0bML44zhAx+MStmQhQWKd=b_TMKnEdu_hw_ReA@mail.gmail.com>
	<56EBD4E5.1060002@nvidia.com>
	<CAMuHMdWXqS9cru74Ckr47gFVTf2MkmjZUtMt4MeXW_1V7x+KHw@mail.gmail.com>
	<56EBDEFA.30102@nvidia.com>
	<CAMuHMdUkGiX6YWzbRVJaJ4BNskE8PUXq-7Zob40f=CEZyjtJiA@mail.gmail.com>
	<56EBF8E0.8020700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56EBF8E0.8020700-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Grygorii,

On Fri, Mar 18, 2016 at 1:47 PM, Grygorii Strashko
<grygorii.strashko-l0cyMroinI0@public.gmane.org> wrote:
> On 03/18/2016 02:05 PM, Geert Uytterhoeven wrote:
>> On Fri, Mar 18, 2016 at 11:56 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>> On 18/03/16 10:52, Geert Uytterhoeven wrote:
>>>> On Fri, Mar 18, 2016 at 11:13 AM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>>>> On 18/03/16 09:13, Geert Uytterhoeven wrote:
>>>>>> On Thu, Mar 17, 2016 at 3:19 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>>>>>> Commit afbbd2338176 ("irqchip/gic: Document optional Clock and Power
>>>>>>> Domain properties") documented optional clock and power-dmoain properties
>>>>>>> for the ARM GIC. Currently, there are no users of these and for the
>>>>>>> Tegra210 Audio GIC (based upon the GIC-400) there are two clocks, a
>>>>>>> functional clock and interface clock, that need to be enabled.
>>>>>>
>>>>>> The reason that there are no users for this is twofold:
>>>>>>    1. The GIC driver doesn't have Runtime PM support yet,
>>>>>>    2. There was no clean way to prevent the GIC's clock from being disabled.
>>>>>> Due to this, adding the clocks to the DTSes would mean that they will be
>>>>>> disabled during boot up as unused clocks, leading to a system lock-up.
>>>>>>
>>>>>> I had hoped your series would fix part 1. I gave it a try on r8a7791/koelsch,
>>>>>> but unfortunately it seems the platform driver only supports non-root
>>>>>> controllers, while the r8a7791 GIC is the primary one...
>>>>>
>>>>> Can you try making the following change ...
>>>>
>>>> Thanks! I gave it a try, but no difference.
>>>
>>> I assume you added the appropriate compatible flag? Any more details you
>>
>> Doh... bad assumption... Silly me.
>>
>>> can share about why it is not working? Is it not registered early enough?
>>
>> With
>>
>> +       { .compatible = "arm,gic-400", },
>>
>> the kernel no longer crashes due to accessing the GIC registers while the
>> GIC module clock is disabled.
>>
>> However, the system doesn't boot completely, and time outs on SPI transfers
>> make me believe interrupts are not working.
>> Both with and without "the following change".
>>
>
> Is my assumption correct that you are trying to enable RPM for primary GIC controller?

That's correct.

> If yes it may help to take a look on clocksource drivers which use early_platform_device/driver
> sh_cmt.c sh_mtu2.c sh_tmu.c
>
> The primary interrupt controller is initialized very early init_IRQ->irqchip_init->of_irq_init()
> (IRQCHIP_DECLARE) and, at least as i can see from st_xxx code, the same case is valid for
> clocksource devices and it was solved using early_platform_device/drive staff.

The GIC now depends on the clock driver, which may be a real platform driver,
not initialized from CLK_OF_DECLARE().

Or do you mean to make the clock driver an early platform driver?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
