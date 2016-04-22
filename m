From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V2 06/14] irqdomain: Don't set type when mapping an IRQ
Date: Fri, 22 Apr 2016 09:22:51 +0100
Message-ID: <5719DF5B.9010304@arm.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
 <1461150237-15580-7-git-send-email-jonathanh@nvidia.com>
 <5718F593.40605@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5718F593.40605-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On 21/04/16 16:45, Jon Hunter wrote:
> 
> On 20/04/16 12:03, Jon Hunter wrote:
>> Some IRQ chips, such as GPIO controllers or secondary level interrupt
>> controllers, may require require additional runtime power management
>> control to ensure they are accessible. For such IRQ chips, it makes sense
>> to enable the IRQ chip when interrupts are requested and disabled them
>> again once all interrupts have been freed.
>>
>> When mapping an IRQ, the IRQ type settings are read and then programmed.
>> The mapping of the IRQ happens before the IRQ is requested and so the
>> programming of the type settings occurs before the IRQ is requested. This
>> is a problem for IRQ chips that require additional power management
>> control because they may not be accessible yet. Therefore, when mapping
>> the IRQ, don't program the type settings, just save them and then program
>> these saved settings when the IRQ is requested (so long as if they are not
>> overridden via the call to request the IRQ).
>>
>> Add a stub function for irq_domain_free_irqs() to avoid any compilation
>> errors when CONFIG_IRQ_DOMAIN_HIERARCHY is not selected.
>>
>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  include/linux/irqdomain.h |  3 +++
>>  kernel/irq/irqdomain.c    | 17 +++++++++++++----
>>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> [snip]
>  
>> -	/* Set type if specified and different than the current one */
>> -	if (type != IRQ_TYPE_NONE &&
>> -	    type != irq_get_trigger_type(virq))
>> -		irq_set_irq_type(virq, type);
>> +	irq_data = irq_get_irq_data(virq);
>> +	if (!irq_data) {
>> +		if (irq_domain_is_hierarchy(domain))
>> +			irq_domain_free_irqs(virq, 1);
>> +		else
>> +			irq_dispose_mapping(virq);
>> +		return 0;
>> +	}
>> +
>> +	/* Store trigger type */
>> +	irqd_set_trigger_type(irq_data, type);
>> +
> 
> I appear to have missed another place for saving the irq type
> which I had change in this version. Next time I will triple
> check! Should have been ...
> 
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 2aed04396210..fc66876d1965 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -440,6 +440,9 @@ static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
>         return -1;
>  }
>  
> +static inline void irq_domain_free_irqs(unsigned int virq,
> +                                       unsigned int nr_irqs) { }
> +
>  static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
>  {
>         return false;
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 3d6ef5527b71..46ecf5d468b2 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -569,6 +569,7 @@ static void of_phandle_args_to_fwspec(struct of_phandle_args *irq_data,
>  unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>  {
>         struct irq_domain *domain;
> +       struct irq_data *irq_data;
>         irq_hw_number_t hwirq;
>         unsigned int type = IRQ_TYPE_NONE;
>         int virq;
> @@ -619,7 +620,11 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>                  * it now and return the interrupt number.
>                  */
>                 if (IRQ_TYPE_NONE == irq_get_trigger_type(virq)) {
> -                       irq_set_irq_type(virq, type);
> +                       irq_data = irq_get_irq_data(virq);
> +                       if (!irq_data)
> +                               return 0;

Can you point out in which circumstances irq_data can be NULL? If we can
lookup the interrupt in the domain, it'd better exist somewhere. Or am I
missing something obvious?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
