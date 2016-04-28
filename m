From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V2 13/14] dt-bindings: arm-gic: Add documentation for
 Tegra210 AGIC
Date: Thu, 28 Apr 2016 10:55:25 +0100
Message-ID: <20160428095525.GB21145@leverpostej>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
 <1461150237-15580-14-git-send-email-jonathanh@nvidia.com>
 <20160422100052.GA10606@leverpostej>
 <571A0739.3090502@nvidia.com>
 <20160422112239.GF10606@leverpostej>
 <5720DC1D.1080802@nvidia.com>
 <20160427173810.GC7359@leverpostej>
 <5721C597.1010105@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5721C597.1010105-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 28, 2016 at 09:11:03AM +0100, Jon Hunter wrote:
> 
> On 27/04/16 18:38, Mark Rutland wrote:
> > On Wed, Apr 27, 2016 at 04:34:53PM +0100, Jon Hunter wrote:
> >>
> >> On 22/04/16 12:22, Mark Rutland wrote:
> >>
> >> [snip]
> >>
> >>>>>> I am not sure if it will be popular to add Tegra specific clock names
> >>>>>> to the GIC DT docs. However, in that case, then possibly the only
> >>>>>> alternative is to move the Tegra AGIC driver into its own file and
> >>>>>> expose the GIC APIs for it to use. Then we could add our own DT doc
> >>>>>> for the Tegra AGIC as well (based upon the ARM GIC).
> >>>>>
> >>>>> The clock-names don't seem right to me, as they sound like provide names
> >>>>> or global clock line names rather than consumer-side names ("clk" and
> >>>>> "apb_pclk").
> >>>>
> >>>> Yes that would be fine with me.
> >>>
> >>> Ok; if we model the apb_pclk as owned by the AXI switch (which it is),
> >>> then there's no change for the GIC binding, short of the additional
> >>> compatible string as an extension of "arm,gic-400", as we already model
> >>> that clock in the GIC-400 binding.
> >>
> >> I have been re-working this based upon the feedback received. In the GIC
> >> driver we have the following definitions ...
> >>
> >>  IRQCHIP_DECLARE(gic_400, "arm,gic-400", gic_of_init);
> >>  IRQCHIP_DECLARE(arm11mp_gic, "arm,arm11mp-gic", gic_of_init);
> >>  IRQCHIP_DECLARE(arm1176jzf_dc_gic, "arm,arm1176jzf-devchip-gic", gic_of_init);
> >>  IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
> >>  IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
> >>  IRQCHIP_DECLARE(cortex_a7_gic, "arm,cortex-a7-gic", gic_of_init);
> >>  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
> >>  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
> >>  IRQCHIP_DECLARE(pl390, "arm,pl390", gic_of_init);
> >>
> >>
> >> If I have something like the following in my dts ...
> >>
> >> 	agic: interrupt-controller@702f9000 {
> >> 		compatible = "nvidia,tegra210-agic", "arm,gic-400";
> >> 		...
> >> 	};
> >>
> >> The problem with this is that it tries to register the interrupt controller
> >> early during of_irq_init() before the platform driver has chance to
> >> initialise it.

[...]

> > We could instead explicitly match "nvidia,tegra210-agic", bailing out if
> > we see that. Otherwise, if we can't handle it like a GIC-400, then we
> > can just drop the GIC-400 compatible string from the fallback list.
> 
> Would it also be a none-starter to have "arm,gic-pm" instead of
> "nvidia,tegra210-agic"? At this point it is not really specific to tegra
> any more and so I was hoping to get rid of that. For example, ...
> 
> 	compatible = "arm,gic-pm", "arm,gic-400";

I'm not keen on the "*-pm" approach, as such compatible strings aren't
reall describing HW, but rather the SW policy to apply, and really would
only be there to bodge around a structural issue we have in Linux today
w.r.t. the device model split and probe ordering.

The "nvidia,tegra210-agic" string can be taken as describing any
Tegra-210 specific integration quirks, though I agree that's also not
fantastic for extending PM support beyond Tegra 210 and variants
thereof.

So maybe the best approach is bailing out in the presence of clocks
and/or power domains after all, on the assumption that nothing today has
those properties, though I fear we may have problems with that later
down the line if/when people describe those for the root GIC to describe
those must be hogged, even if not explicitly managed.

Thanks,
Mark.
