From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH V2 07/14] genirq: Add runtime power management support for IRQ chips
Date: Wed, 20 Apr 2016 10:11:53 -0700
Message-ID: <7h37qgb3xi.fsf@baylibre.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
	<1461150237-15580-8-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461150237-15580-8-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> (Jon
	Hunter's message of "Wed, 20 Apr 2016 12:03:50 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> writes:

> Some IRQ chips may be located in a power domain outside of the CPU
> subsystem and hence will require device specific runtime power
> management. In order to support such IRQ chips, add a pointer for a
> device structure to the irq_chip structure, and if this pointer is
> populated by the IRQ chip driver and CONFIG_PM is selected in the kernel
> configuration, then the pm_runtime_get/put APIs for this chip will be
> called when an IRQ is requested/freed, respectively.
>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

[...]

> @@ -1891,10 +1906,18 @@ int setup_percpu_irq(unsigned int irq, struct irqaction *act)
>  
>  	if (!desc || !irq_settings_is_per_cpu_devid(desc))
>  		return -EINVAL;
> +
> +	retval = irq_chip_pm_get(&desc->irq_data);
> +	if (retval < 0)
> +		return retval;
> +
>  	chip_bus_lock(desc);
>  	retval = __setup_irq(irq, desc, act);
>  	chip_bus_sync_unlock(desc);
>  
> +	if (retval)
> +		irq_chip_pm_get(&desc->irq_data);
> +

Shouldn't this one be a _put() ?

Otherwise, LGTM

Reviewed-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Kevin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
