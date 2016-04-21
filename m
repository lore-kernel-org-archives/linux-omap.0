From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V2 04/14] irqdomain: Fix handling of type settings for
 existing mappings
Date: Thu, 21 Apr 2016 12:31:55 +0100
Message-ID: <5718BA2B.2060708@nvidia.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
 <1461150237-15580-5-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461150237-15580-5-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 20/04/16 12:03, Jon Hunter wrote:
> When mapping an IRQ, it is possible that a mapping for the IRQ already
> exists. If mapping does exist then there are the following issues with
> regard to the handling of the IRQ type settings ...
> 1. If the domain is part of a hierarchy, then:
>    a. We do not check that the type settings for the existing mapping
>       match those of the new mapping.
>    b. We do not check to see if the type settings have been programmed
>       yet (and they might not have been) and so we may never set the
>       type.
> 2. If the domain is NOT part of a hierarchy, we will overwrite the
>    current type settings programmed if they are different from the
>    previous mapping. Please note that irq_create_mapping()
>    calls irq_find_mapping() to check if a mapping already exists.
> 
> Although, it may be unlikely that the type settings for a shared
> interrupt would not match, nonetheless we should check for this.
> Therefore, to fix this check if a mapping exists (regardless of whether
> the domain is part of a hierarchy or not) and if it does then:
> 1. Return the IRQ number if the type settings match or are not
>    specified.
> 2. Program the type settings and return the IRQ number if the type
>    settings have not been programmed yet.
> 3. Otherwise if the type setting do not match, then print a warning
>    and don't return the IRQ number.
> 
> Furthermore, add a warning if the type return by irq_domain_translate()
> has bits outside the sense mask set and then clear these bits. If these
> bits are not cleared then this will cause the comparision of the type
> settings for an existing mapping to fail with that of the new mapping
> even if the sense bit themselves match. The reason being is that the
> existing type settings are read by calling irq_get_trigger_type() which
> will clear any bits outside the sense mask. This will allow us to detect
> irqchips that are not correctly clearing these bits and fix them.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  kernel/irq/irqdomain.c | 38 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 245a485ffb61..88e9328b7aab 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -592,15 +592,43 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>  	if (irq_domain_translate(domain, fwspec, &hwirq, &type))
>  		return 0;
>  
> -	if (irq_domain_is_hierarchy(domain)) {
> +	/*
> +	 * WARN if the irqchip returns a type with bits
> +	 * outside the sense mask set and clear these bits.
> +	 */
> +	if (WARN_ON(type & ~IRQ_TYPE_SENSE_MASK))
> +		type &= IRQ_TYPE_SENSE_MASK;
> +
> +	/*
> +	 * If we've already configured this interrupt,
> +	 * don't do it again, or hell will break loose.
> +	 */
> +	virq = irq_find_mapping(domain, hwirq);
> +	if (virq) {
>  		/*
> -		 * If we've already configured this interrupt,
> -		 * don't do it again, or hell will break loose.
> +		 * If the trigger type is not specified or matches the
> +		 * current trigger type then we are done so return the
> +		 * interrupt number. Otherwise, if the trigger type does
> +		 * not match return 0.

I think I should have dropped this 'otherwise' sentence from here.

Jon
