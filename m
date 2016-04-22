From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V2 14/14] irqchip/gic: Add support for tegra AGIC
 interrupt controller
Date: Fri, 22 Apr 2016 10:57:53 +0100
Message-ID: <5719F5A1.6060301@arm.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
 <1461150237-15580-15-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461150237-15580-15-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 20/04/16 12:03, Jon Hunter wrote:
> Add a driver for the Tegra-AGIC interrupt controller which is compatible
> with the ARM GIC-400 interrupt controller.
> 
> The Tegra AGIC (Audio GIC) is part of the Audio Processing Engine (APE) on
> Tegra210 and can route interrupts to either the GIC for the CPU subsystem
> or the Audio DSP (ADSP) within the APE. The AGIC uses CPU interface 0 to
> route interrupts to the CPU GIC and CPU interface 1 to route interrupts to
> the ADSP.
> 
> The APE is located within its own power domain on the chip and so the
> AGIC needs to manage both the power domain and its clocks. Commit
> afbbd2338176 ("irqchip/gic: Document optional Clock and Power Domain
> properties") has already added clock and power-domain properties to the
> GIC binding and so we can make use of these for the AGIC.
> 
> With the AGIC being located in a different power domain to the main CPU
> cluster this means that:
> 1. The interrupt controller cannot be registered via IRQCHIP_DECLARE()
>    because it needs to be registered as a platform device so that the
>    generic PM domain core will ensure that the power domain is available
>    before probing.
> 2. The interrupt controller cannot be suspended/restored based upon
>    changes in the CPU power state and needs to use runtime-pm instead.
> 
> The GIC platform driver has been implemented by making the following
> changes to the core GIC driver:
> 1. Remove the dependency on CONFIG_CPU_PM from PM specific variables and
>    functions so that they can be used by the platform driver even when
>    CONFIG_CPU_PM is not selected.
> 2. Move the code that maps the GIC registers and parses the device-tree
>    blob into a new function called gic_of_setup() that can be used by
>    both the platform driver as well as the existing driver.
> 3. Add and register platform driver for the GIC. The platform driver
>    uses the PM_CLK framework for managing the clocks used by the GIC
>    and so select CONFIG_PM_CLK.
> 
> Finally, a couple other notes on the implementation are:
> 1. Currently the GIC platform driver only supports non-root GICs and
>    assumes that the GIC has a parent interrupt. It is assumed that
>    root interrupt controllers need to be initialised early.
> 2. There is no specific suspend handling for GICs registered as platform
>    devices. Non-wakeup interrupts will be disabled by the kernel during
>    late suspend, however, this alone will not power down the GIC if
>    interrupts have been requested and not freed. Therefore, requestors
>    of non-wakeup interrupts will need to free them on entering suspend
>    in order to power-down the GIC.
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> 
> Please note that so far I have not added all the clock names for the
> various GIC versions (as described by the DT documentation). I thought
> we could add these as they are needed.

So while the code looks OK, I'd like to stop adding more code to this
poor GIC driver, because it is starting to look like a huge mess.

What is preventing us to move this to a separate irq-gic-pm.c file?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
