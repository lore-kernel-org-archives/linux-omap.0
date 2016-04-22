From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V2 13/14] dt-bindings: arm-gic: Add documentation for
 Tegra210 AGIC
Date: Fri, 22 Apr 2016 12:22:39 +0100
Message-ID: <20160422112239.GF10606@leverpostej>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
 <1461150237-15580-14-git-send-email-jonathanh@nvidia.com>
 <20160422100052.GA10606@leverpostej>
 <571A0739.3090502@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <571A0739.3090502-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 22, 2016 at 12:12:57PM +0100, Jon Hunter wrote:
> 
> On 22/04/16 11:00, Mark Rutland wrote:
> > On Wed, Apr 20, 2016 at 12:03:56PM +0100, Jon Hunter wrote:
> >> The Tegra AGIC interrupt controller is compatible with the ARM GIC-400
> >> interrupt controller.
> > 
> > The cover letter says it _is_ a GIC-400, just used in a slightly unusual
> > manner (i.e. not directly connected to CPUs).
> 
> Correct.
> 
> >> The Tegra AGIC requires two clocks, namely the
> >> "ape" (functional) and "apb2ape" (interface) clocks, to operate. Add
> >> the compatible string and clock information for the AGIC to the GIC
> >> device-tree binding documentation.
> > 
> > The GIC-400 spec only describes "CLK" (which is what I imagine "ape" is.
> > There isn't an APB clock described, and the manual seems to show GIC-400
> > directly connected to AXI rather than APB, so that doesn't seem to even
> > be the usual "apb_pclk".
> > 
> > Is there some wrapper logic around a GIC-400 to giove it an APB
> > interface? Or am I misudnerstanding the spec?
> 
> Looking at the Tegra documentation what we have is ...
> 
> APB --> AXI switch --> AGIC (GIC400)
> 
> I am not sure how such a switch would typically be modeled in DT but we
> need the apb clock to interface to the GIC registers. I am not sure if
> something like simple-pm-bus is appropriate here.

I think we need some representation of that AXI switch in the DT;
whether simple-pm-bus is appropriate is another question. We probably
need a specific compatible string / binding regardless.

Thanks,
Mark.

> 
> >> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >> ---
> >>
> >> I am not sure if it will be popular to add Tegra specific clock names
> >> to the GIC DT docs. However, in that case, then possibly the only
> >> alternative is to move the Tegra AGIC driver into its own file and
> >> expose the GIC APIs for it to use. Then we could add our own DT doc
> >> for the Tegra AGIC as well (based upon the ARM GIC).
> > 
> > The clock-names don't seem right to me, as they sound like provide names
> > or global clock line names rather than consumer-side names ("clk" and
> > "apb_pclk").
> 
> Yes that would be fine with me.

Ok; if we model the apb_pclk as owned by the AXI switch (which it is),
then there's no change for the GIC binding, short of the additional
compatible string as an extension of "arm,gic-400", as we already model
that clock in the GIC-400 binding.

Thanks,
Mark.
