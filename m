From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [RFC PATCH V2 2/8] irqdomain: Don't set type when mapping an IRQ
Date: Fri, 18 Mar 2016 10:16:07 +0100
Message-ID: <CAMuHMdULUMy2oi3fXVT-DNXAOg+KqjOVFAW2+CLVCDYFcjKO1w@mail.gmail.com>
References: <1450349309-8107-1-git-send-email-jonathanh@nvidia.com>
	<1450349309-8107-3-git-send-email-jonathanh@nvidia.com>
	<56793191.30502@ti.com>
	<56793A5B.4040302@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56793A5B.4040302-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 22, 2015 at 12:56 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> On 22/12/15 11:18, Grygorii Strashko wrote:
>> On 12/17/2015 12:48 PM, Jon Hunter wrote:
>>> Some IRQ chips, such as GPIO controllers or secondary level interrupt
>>> controllers, may require require additional runtime power management
>>> control to ensure they are accessible. For such IRQ chips, it makes sense
>>> to enable the IRQ chip when interrupts are requested and disabled them
>>> again once all interrupts have been freed.
>>>
>>> When mapping an IRQ, the IRQ type settings are read and then programmed.
>>> The mapping of the IRQ happens before the IRQ is requested and so the
>>> programming of the type settings occurs before the IRQ is requested. This
>>> is a problem for IRQ chips that require additional power management
>>> control because they may not be accessible yet. Therefore, when mapping
>>> the IRQ, don't program the type settings, just save them and then program
>>> these saved settings when the IRQ is requested (so long as if they are not
>>> overridden via the call to request the IRQ).
>>>
>>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

>> This patch has side effect - some boards which have
>> ARM TWD timer will produce below backtrace on boot:
>>
>>  genirq: Setting trigger mode 4 for irq 17 failed (gic_set_type+0x0/0x58)
>>  twd: can't register interrupt 17 (-22)
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 0 at arch/arm/kernel/smp_twd.c:405 twd_local_timer_of_register+0x68/0x7c()

>> This happens, most probably, because TWD IRQs definitions in DT
>> do not corresponds HW and gic_configure_irq() will return -EINVAL
>> example (am4372.dtsi):
>>       local_timer: timer@48240600 {
>>               compatible = "arm,cortex-a9-twd-timer";
>>               reg = <0x48240600 0x100>;
>>               interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
>>               interrupt-parent = <&gic>;
>>               clocks = <&mpu_periphclk>;
>>               status = "disabled";
>>       };
>
>
> Hmm ... that's interesting. Looking at the GIC documentation, it does
> say that it is "implementation defined" whether you can program the type
> bit for a PPI. Therefore, I am wondering if we should convert the error
> into a WARN instead? It would be hard to know which of the below would
> be impacted from just looking at the DT files.
>
>> So, some additional fixes might be required. Potentially problematic files are:

>> arch/arm/boot/dts/r8a7779.dts
>> arch/arm/boot/dts/sh73a0.dtsi

The above two are affected. Sending patches...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
