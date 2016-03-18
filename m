From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 14/15] dt-bindings: arm-gic: Drop 'clock-names' from
 binding document
Date: Fri, 18 Mar 2016 10:13:57 +0000
Message-ID: <56EBD4E5.1060002@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-15-git-send-email-jonathanh@nvidia.com>
 <CAMuHMdV0QiWR0bML44zhAx+MStmQhQWKd=b_TMKnEdu_hw_ReA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdV0QiWR0bML44zhAx+MStmQhQWKd=b_TMKnEdu_hw_ReA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 18/03/16 09:13, Geert Uytterhoeven wrote:
> Hi Jon,
> 
> On Thu, Mar 17, 2016 at 3:19 PM, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> Commit afbbd2338176 ("irqchip/gic: Document optional Clock and Power
>> Domain properties") documented optional clock and power-dmoain properties
>> for the ARM GIC. Currently, there are no users of these and for the
>> Tegra210 Audio GIC (based upon the GIC-400) there are two clocks, a
>> functional clock and interface clock, that need to be enabled.
> 
> The reason that there are no users for this is twofold:
>   1. The GIC driver doesn't have Runtime PM support yet,
>   2. There was no clean way to prevent the GIC's clock from being disabled.
> Due to this, adding the clocks to the DTSes would mean that they will be
> disabled during boot up as unused clocks, leading to a system lock-up.
> 
> I had hoped your series would fix part 1. I gave it a try on r8a7791/koelsch,
> but unfortunately it seems the platform driver only supports non-root
> controllers, while the r8a7791 GIC is the primary one...

Can you try making the following change ...

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 9e7cf7abf757..2e971e600036 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1372,7 +1372,7 @@ static int gic_probe(struct platform_device *pdev)
        void __iomem *dist_base;
        void __iomem *cpu_base;
        u32 percpu_offset;
-       int ret, irq;
+       int ret, irq = 0;
 
        if (dev->of_node == NULL)
                return -EINVAL;
@@ -1393,11 +1393,8 @@ static int gic_probe(struct platform_device *pdev)
        if (ret < 0)
                goto rpm_disable;
 
-       irq = irq_of_parse_and_map(dev->of_node, 0);
-       if (!irq) {
-               ret = -EINVAL;
-               goto rpm_put;
-       }
+       if (of_irq_count(dev->of_node) > 0)
+               irq = irq_of_parse_and_map(dev->of_node, 0);
 
        ret = gic_of_setup(dev->of_node, &dist_base, &cpu_base, &percpu_offset);
        if (ret)
@@ -1411,7 +1408,8 @@ static int gic_probe(struct platform_device *pdev)
 
        gic->chip.parent = dev;
 
-       irq_set_chained_handler_and_data(irq, gic_handle_cascade_irq, gic);
+       if (irq)
+               irq_set_chained_handler_and_data(irq, gic_handle_cascade_irq, gic);
 
        pm_runtime_put(dev);
 
@@ -1424,7 +1422,6 @@ gic_unmap:
        iounmap(cpu_base);
 irq_dispose:
        irq_dispose_mapping(irq);
-rpm_put:
        pm_runtime_put_sync(dev);
 rpm_disable:
        pm_runtime_disable(dev);

 
> Alternatively, part 2 can to be fixed by "clk: introduce CLK_ENABLE_HAND_OFF
> flag", combined with the clock driver setting the flag when needed.
> Unfortunately that patch is not yet upstream, and not even in -next.
> Note that drivers/clk/renesas/renesas-cpg-mssr.c already handles
> CLK_ENABLE_HAND_OFF if present, and else just ignores the clock.
> So I could already add the clock to r8a7795.dtsi, which uses that driver.
> 
> For older SoCs, the module clocks are described in the dtsi, and I would need a
> crude hack to enable CLK_ENABLE_HAND_OFF in the clock driver.
> 
>> To allow flexibility, drop the 'clock-names' from the GIC binding and
>> just provide a list of clocks which the driver can parse. It is assumed
>> that any clocks that are listed, need to be enabled in order to access
>> the GIC.
> 
> Originally I just wanted to have "clocks", and let the details be handled by
> SoC-specific code. However, Mark Rutland insisted on using the clock naming
> from the GIC TRMs, as the number of clocks and their names depend on the
> GIC variant.
> 
> Apparently they also depend on the SoC...

Yes this case is a little different because the GIC is a 2nd level GIC.

Cheers
Jon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
