From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V3 02/17] irqchip/gic: WARN if setting the interrupt type
 for a PPI fails
Date: Thu, 5 May 2016 13:06:09 +0100
Message-ID: <572B3731.80602@arm.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
 <1462379130-11742-3-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462379130-11742-3-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On 04/05/16 17:25, Jon Hunter wrote:
> Setting the interrupt type for private peripheral interrupts (PPIs) may
> not be supported by a given GIC because it is IMPLEMENTATION DEFINED
> whether this is allowed. There is no way to know if setting the type is
> supported for a given GIC and so the value written is read back to
> verify it matches the desired configuration. If it does not match then
> an error is return.
> 
> There are cases where the interrupt configuration read from firmware
> (such as a device-tree blob), has been incorrect and hence
> gic_configure_irq() has returned an error. This error has gone
> undetected because the error code returned was ignored but the interrupt
> still worked fine because the configuration for the interrupt could not
> be overwritten.
> 
> Given that this has done undetected and that failing to set the
> configuration for a PPI may not be a catastrophic, don't return an error
> but WARN if we fail to configure a PPI. This will allows us to fix up
> any places in the kernel where we should be checking the return status
> and maintain backward compatibility with firmware images that may have
> incorrect PPI configurations.
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Acked-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/irqchip/irq-gic-common.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
> index ffff5a45f1e3..9fa92a17225c 100644
> --- a/drivers/irqchip/irq-gic-common.c
> +++ b/drivers/irqchip/irq-gic-common.c
> @@ -56,12 +56,15 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
>  
>  	/*
>  	 * Write back the new configuration, and possibly re-enable
> -	 * the interrupt. If we fail to write a new configuration,
> -	 * return an error.
> +	 * the interrupt. WARN if we fail to write a new configuration
> +	 * and return an error if we failed to write the configuration
> +	 * for an SPI. If we fail to write the configuration for a PPI
> +	 * this is most likely because the GIC does not allow us to set
> +	 * the configuration and so it is not a catastrophic failure.
>  	 */
>  	writel_relaxed(val, base + GIC_DIST_CONFIG + confoff);
> -	if (readl_relaxed(base + GIC_DIST_CONFIG + confoff) != val)
> -		ret = -EINVAL;
> +	if (WARN_ON(readl_relaxed(base + GIC_DIST_CONFIG + confoff) != val))
> +		ret = irq < 32 ? 0 : -EINVAL;
>  
>  	if (sync_access)
>  		sync_access();
> 

I'm going to slightly backpedal on that one:

When running in non-secure mode, you can reconfigure secure interrupts
(for obvious reasons). But you don't know which mode you're running in
either. A typical example is the arch timer, which requests both secure
and non-secure interrupts, because we cannot know which side of the CPU
we're running on. In the non-secure case, we end-up with a splat that
is rather undeserved.

So I'm tempted to tone down the splat in the PPI case like this:

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 083c303..1605e42 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -63,8 +63,17 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	 * the configuration and so it is not a catastrophic failure.
 	 */
 	writel_relaxed(val, base + GIC_DIST_CONFIG + confoff);
-	if (WARN_ON(readl_relaxed(base + GIC_DIST_CONFIG + confoff) != val))
-		ret = irq < 32 ? 0 : -EINVAL;
+	oldval = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
+	if (oldval != val) {
+		if (irq < 32) {
+			pr_warn("GIC: PPI%d is either secure or misconfigured\n",
+				irq - 16);
+			ret = 0;
+		} else {
+			WARN_ON(1);
+			ret = -EINVAL;
+		}
+	}
 
 	if (sync_access)
 		sync_access();

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny...
