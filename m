From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 14/15] dt-bindings: arm-gic: Drop 'clock-names' from
 binding document
Date: Fri, 18 Mar 2016 10:13:36 +0100
Message-ID: <CAMuHMdV0QiWR0bML44zhAx+MStmQhQWKd=b_TMKnEdu_hw_ReA@mail.gmail.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
	<1458224359-32665-15-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458224359-32665-15-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On Thu, Mar 17, 2016 at 3:19 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Commit afbbd2338176 ("irqchip/gic: Document optional Clock and Power
> Domain properties") documented optional clock and power-dmoain properties
> for the ARM GIC. Currently, there are no users of these and for the
> Tegra210 Audio GIC (based upon the GIC-400) there are two clocks, a
> functional clock and interface clock, that need to be enabled.

The reason that there are no users for this is twofold:
  1. The GIC driver doesn't have Runtime PM support yet,
  2. There was no clean way to prevent the GIC's clock from being disabled.
Due to this, adding the clocks to the DTSes would mean that they will be
disabled during boot up as unused clocks, leading to a system lock-up.

I had hoped your series would fix part 1. I gave it a try on r8a7791/koelsch,
but unfortunately it seems the platform driver only supports non-root
controllers, while the r8a7791 GIC is the primary one...

Alternatively, part 2 can to be fixed by "clk: introduce CLK_ENABLE_HAND_OFF
flag", combined with the clock driver setting the flag when needed.
Unfortunately that patch is not yet upstream, and not even in -next.
Note that drivers/clk/renesas/renesas-cpg-mssr.c already handles
CLK_ENABLE_HAND_OFF if present, and else just ignores the clock.
So I could already add the clock to r8a7795.dtsi, which uses that driver.

For older SoCs, the module clocks are described in the dtsi, and I would need a
crude hack to enable CLK_ENABLE_HAND_OFF in the clock driver.

> To allow flexibility, drop the 'clock-names' from the GIC binding and
> just provide a list of clocks which the driver can parse. It is assumed
> that any clocks that are listed, need to be enabled in order to access
> the GIC.

Originally I just wanted to have "clocks", and let the details be handled by
SoC-specific code. However, Mark Rutland insisted on using the clock naming
from the GIC TRMs, as the number of clocks and their names depend on the
GIC variant.

Apparently they also depend on the SoC...

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
