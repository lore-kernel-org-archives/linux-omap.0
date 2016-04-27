From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V2 13/14] dt-bindings: arm-gic: Add documentation for
 Tegra210 AGIC
Date: Wed, 27 Apr 2016 18:38:10 +0100
Message-ID: <20160427173810.GC7359@leverpostej>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
 <1461150237-15580-14-git-send-email-jonathanh@nvidia.com>
 <20160422100052.GA10606@leverpostej>
 <571A0739.3090502@nvidia.com>
 <20160422112239.GF10606@leverpostej>
 <5720DC1D.1080802@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5720DC1D.1080802-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 27, 2016 at 04:34:53PM +0100, Jon Hunter wrote:
> 
> On 22/04/16 12:22, Mark Rutland wrote:
> 
> [snip]
> 
> >>>> I am not sure if it will be popular to add Tegra specific clock names
> >>>> to the GIC DT docs. However, in that case, then possibly the only
> >>>> alternative is to move the Tegra AGIC driver into its own file and
> >>>> expose the GIC APIs for it to use. Then we could add our own DT doc
> >>>> for the Tegra AGIC as well (based upon the ARM GIC).
> >>>
> >>> The clock-names don't seem right to me, as they sound like provide names
> >>> or global clock line names rather than consumer-side names ("clk" and
> >>> "apb_pclk").
> >>
> >> Yes that would be fine with me.
> > 
> > Ok; if we model the apb_pclk as owned by the AXI switch (which it is),
> > then there's no change for the GIC binding, short of the additional
> > compatible string as an extension of "arm,gic-400", as we already model
> > that clock in the GIC-400 binding.
> 
> I have been re-working this based upon the feedback received. In the GIC
> driver we have the following definitions ...
> 
>  IRQCHIP_DECLARE(gic_400, "arm,gic-400", gic_of_init);
>  IRQCHIP_DECLARE(arm11mp_gic, "arm,arm11mp-gic", gic_of_init);
>  IRQCHIP_DECLARE(arm1176jzf_dc_gic, "arm,arm1176jzf-devchip-gic", gic_of_init);
>  IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
>  IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
>  IRQCHIP_DECLARE(cortex_a7_gic, "arm,cortex-a7-gic", gic_of_init);
>  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
>  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
>  IRQCHIP_DECLARE(pl390, "arm,pl390", gic_of_init);
> 
> 
> If I have something like the following in my dts ...
> 
> 	agic: interrupt-controller@702f9000 {
> 		compatible = "nvidia,tegra210-agic", "arm,gic-400";
> 		...
> 	};
> 
> The problem with this is that it tries to register the interrupt controller
> early during of_irq_init() before the platform driver has chance to
> initialise it.

Probe order strikes again...

> To avoid this I got rid of the "nvidia,tegra210-agic" string and added
> the following for the platform driver ...
> 
> static const struct of_device_id gic_match[] = {
>        { .compatible = "arm,arm11mp-gic-pm",    .data = &arm11mp_gic_data   },
>        { .compatible = "arm,cortex-a15-gic-pm", .data = &cortexa15_gic_data },
>        { .compatible = "arm,cortex-a9-gic-pm",  .data = &cortexa9_gic_data  },
>        { .compatible = "arm,gic400-pm",         .data = &gic400_data        },
>        { .compatible = "arm,pl390-pm",          .data = &pl390_data         },
>        {},
> };
> 
> It is not ideal as now we have a *-pm variant of each compatible string :-(

Yeah, that's a non-starter. :(

> Another option would be to add some code in gic_of_init() to check for the
> presence of a "clocks" node in the DT binding and bail out of the early 
> initialisation if found but may be that is a bit of a hack.

I fear that someone may validly have a clocks property in their root GIC
node, at which point things would fall apart. I was under the impression
this was the case for some Renesas boards (though I didn't find an
example in tree).

So I suspect that using the clocks property in that way isn't going to
work out well.

> Mark, what are your thoughts on this?

Collectively: "aargh", "oh no".

We could instead explicitly match "nvidia,tegra210-agic", bailing out if
we see that. Otherwise, if we can't handle it like a GIC-400, then we
can just drop the GIC-400 compatible string from the fallback list.

Thanks,
Mark.
