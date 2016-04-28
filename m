From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V2 13/14] dt-bindings: arm-gic: Add documentation for
 Tegra210 AGIC
Date: Thu, 28 Apr 2016 10:31:32 +0200
Message-ID: <CAMuHMdXGdkViRUffCcOqd5zVVPN51DiJqWAqSQr=AapsLnkQ0w@mail.gmail.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
	<1461150237-15580-14-git-send-email-jonathanh@nvidia.com>
	<20160422100052.GA10606@leverpostej>
	<571A0739.3090502@nvidia.com>
	<20160422112239.GF10606@leverpostej>
	<5720DC1D.1080802@nvidia.com>
	<20160427173810.GC7359@leverpostej>
	<5721C597.1010105@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5721C597.1010105@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On Thu, Apr 28, 2016 at 10:11 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
> On 27/04/16 18:38, Mark Rutland wrote:
>> On Wed, Apr 27, 2016 at 04:34:53PM +0100, Jon Hunter wrote:
>>> On 22/04/16 12:22, Mark Rutland wrote:
>>> [snip]
>>>>>>> I am not sure if it will be popular to add Tegra specific clock names
>>>>>>> to the GIC DT docs. However, in that case, then possibly the only
>>>>>>> alternative is to move the Tegra AGIC driver into its own file and
>>>>>>> expose the GIC APIs for it to use. Then we could add our own DT doc
>>>>>>> for the Tegra AGIC as well (based upon the ARM GIC).
>>>>>>
>>>>>> The clock-names don't seem right to me, as they sound like provide names
>>>>>> or global clock line names rather than consumer-side names ("clk" and
>>>>>> "apb_pclk").
>>>>>
>>>>> Yes that would be fine with me.
>>>>
>>>> Ok; if we model the apb_pclk as owned by the AXI switch (which it is),
>>>> then there's no change for the GIC binding, short of the additional
>>>> compatible string as an extension of "arm,gic-400", as we already model
>>>> that clock in the GIC-400 binding.
>>>
>>> I have been re-working this based upon the feedback received. In the GIC
>>> driver we have the following definitions ...
>>>
>>>  IRQCHIP_DECLARE(gic_400, "arm,gic-400", gic_of_init);
>>>  IRQCHIP_DECLARE(arm11mp_gic, "arm,arm11mp-gic", gic_of_init);
>>>  IRQCHIP_DECLARE(arm1176jzf_dc_gic, "arm,arm1176jzf-devchip-gic", gic_of_init);
>>>  IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
>>>  IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
>>>  IRQCHIP_DECLARE(cortex_a7_gic, "arm,cortex-a7-gic", gic_of_init);
>>>  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
>>>  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
>>>  IRQCHIP_DECLARE(pl390, "arm,pl390", gic_of_init);
>>>
>>>
>>> If I have something like the following in my dts ...
>>>
>>>      agic: interrupt-controller@702f9000 {
>>>              compatible = "nvidia,tegra210-agic", "arm,gic-400";
>>>              ...
>>>      };
>>>
>>> The problem with this is that it tries to register the interrupt controller
>>> early during of_irq_init() before the platform driver has chance to
>>> initialise it.
>>
>> Probe order strikes again...
>>
>>> To avoid this I got rid of the "nvidia,tegra210-agic" string and added
>>> the following for the platform driver ...
>>>
>>> static const struct of_device_id gic_match[] = {
>>>        { .compatible = "arm,arm11mp-gic-pm",    .data = &arm11mp_gic_data   },
>>>        { .compatible = "arm,cortex-a15-gic-pm", .data = &cortexa15_gic_data },
>>>        { .compatible = "arm,cortex-a9-gic-pm",  .data = &cortexa9_gic_data  },
>>>        { .compatible = "arm,gic400-pm",         .data = &gic400_data        },
>>>        { .compatible = "arm,pl390-pm",          .data = &pl390_data         },
>>>        {},
>>> };
>>>
>>> It is not ideal as now we have a *-pm variant of each compatible string :-(
>>
>> Yeah, that's a non-starter. :(
>
> That is what I feared. Understood.
>
>>> Another option would be to add some code in gic_of_init() to check for the
>>> presence of a "clocks" node in the DT binding and bail out of the early
>>> initialisation if found but may be that is a bit of a hack.
>>
>> I fear that someone may validly have a clocks property in their root GIC
>> node, at which point things would fall apart. I was under the impression
>> this was the case for some Renesas boards (though I didn't find an
>> example in tree).
>>
>> So I suspect that using the clocks property in that way isn't going to
>> work out well.
>>
>>> Mark, what are your thoughts on this?
>>
>> Collectively: "aargh", "oh no".
>
> Yes, exactly :-(
>
>> We could instead explicitly match "nvidia,tegra210-agic", bailing out if
>> we see that. Otherwise, if we can't handle it like a GIC-400, then we
>> can just drop the GIC-400 compatible string from the fallback list.
>
> Would it also be a none-starter to have "arm,gic-pm" instead of
> "nvidia,tegra210-agic"? At this point it is not really specific to tegra
> any more and so I was hoping to get rid of that. For example, ...
>
>         compatible = "arm,gic-pm", "arm,gic-400";

The "-pm" is not a property of the GIC, but of the SoC. So IMHO the compatible
value should be plain "arm,gic-400".

If a device node has "clocks", "interrupts", "power-domains"[*], ...
properties, and the corresponding providers are not yet available, a driver
typically returns -EPROBE_DEFER, and will be retried later by the driver core.

[*] For "power-domains" this is handled by the device core. I.e. .probe()
     won't even be called before the dependency has been fulfilled.

With IRQCHIP_DECLARE(), you don't have the retrying, and probe order (w.r.t.
to other subsystems) is fixed.

But as you said, gic_of_init() could just bail out if it "clocks" and/or
"power-domains" properties are present, but their providers aren't.
Later, the remaining GICs can be initialized from the platform driver.
You just have to make sure no GIC is initialized twice (I believe that's what
was plaguing me last time I tried your series).

That's probably the closest you can get to normal platform_driver
behavior, without converting the whole GIC driver to a normal platform_driver,
which may cause problems on platforms that are currently working fine.

Gr{oetje,eeting}s,

                        Geert
