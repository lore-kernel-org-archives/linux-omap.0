From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V3 06/17] irqdomain: Don't set type when mapping an IRQ
Date: Mon, 9 May 2016 16:10:31 +0100
Message-ID: <5730A867.9070504@arm.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
 <1462379130-11742-7-git-send-email-jonathanh@nvidia.com>
 <5730813B.7060206@arm.com> <57308D0D.4080800@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57308D0D.4080800-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 09/05/16 14:13, Jon Hunter wrote:
> 
> On 09/05/16 13:23, Marc Zyngier wrote:
>> On 04/05/16 17:25, Jon Hunter wrote:
>>> Some IRQ chips, such as GPIO controllers or secondary level interrupt
>>> controllers, may require require additional runtime power management
>>> control to ensure they are accessible. For such IRQ chips, it makes sense
>>> to enable the IRQ chip when interrupts are requested and disabled them
>>> again once all interrupts have been freed.
>>>
>>> When mapping an IRQ, the IRQ type settings are read and then programmed.
>>> The mapping of the IRQ happens before the IRQ is requested and so the
>>> programming of the type settings occurs before the IRQ is requested. This
>>> is a problem for IRQ chips that require additional power management
>>> control because they may not be accessible yet. Therefore, when mapping
>>> the IRQ, don't program the type settings, just save them and then program
>>> these saved settings when the IRQ is requested (so long as if they are not
>>> overridden via the call to request the IRQ).
>>>
>>> Add a stub function for irq_domain_free_irqs() to avoid any compilation
>>> errors when CONFIG_IRQ_DOMAIN_HIERARCHY is not selected.
>>>
>>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  include/linux/irqdomain.h |  3 +++
>>>  kernel/irq/irqdomain.c    | 23 ++++++++++++++++++-----
>>>  2 files changed, 21 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
>>> index 2aed04396210..fc66876d1965 100644
>>> --- a/include/linux/irqdomain.h
>>> +++ b/include/linux/irqdomain.h
>>> @@ -440,6 +440,9 @@ static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
>>>  	return -1;
>>>  }
>>>  
>>> +static inline void irq_domain_free_irqs(unsigned int virq,
>>> +					unsigned int nr_irqs) { }
>>> +
>>>  static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
>>>  {
>>>  	return false;
>>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>>> index d68371213fc9..bbf5b9b8ac3d 100644
>>> --- a/kernel/irq/irqdomain.c
>>> +++ b/kernel/irq/irqdomain.c
>>> @@ -564,6 +564,7 @@ static void of_phandle_args_to_fwspec(struct of_phandle_args *irq_data,
>>>  unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>>>  {
>>>  	struct irq_domain *domain;
>>> +	struct irq_data *irq_data;
>>>  	irq_hw_number_t hwirq;
>>>  	unsigned int type = IRQ_TYPE_NONE;
>>>  	int virq;
>>> @@ -613,7 +614,11 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>>>  		 * it now and return the interrupt number.
>>>  		 */
>>>  		if (irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
>>> -			irq_set_irq_type(virq, type);
>>> +			irq_data = irq_get_irq_data(virq);
>>> +			if (!irq_data)
>>> +				return 0;
>>> +
>>> +			irqd_set_trigger_type(irq_data, type);
>>>  			return virq;
>>>  		}
>>>  
>>> @@ -633,10 +638,18 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>>>  			return virq;
>>>  	}
>>>  
>>> -	/* Set type if specified and different than the current one */
>>> -	if (type != IRQ_TYPE_NONE &&
>>> -	    type != irq_get_trigger_type(virq))
>>> -		irq_set_irq_type(virq, type);
>>> +	irq_data = irq_get_irq_data(virq);
>>> +	if (!irq_data) {
>>> +		if (irq_domain_is_hierarchy(domain))
>>> +			irq_domain_free_irqs(virq, 1);
>>> +		else
>>> +			irq_dispose_mapping(virq);
>>> +		return 0;
>>> +	}
>>> +
>>> +	/* Store trigger type */
>>> +	irqd_set_trigger_type(irq_data, type);
>>> +
>>>  	return virq;
>>>  }
>>>  EXPORT_SYMBOL_GPL(irq_create_fwspec_mapping);
>>>
>>
>> This patch have the effect of making misconfigured PPIs absolutely
>> obvious. I still need to wrap my head around the root cause, but here's
>> the findings I have so far:
>>
>> - kvmtool generates a DT with the wrong trigger information (edge
>> instead of level) for the timer.
>> - with this patch applied, "cyclictest -S" reliably locks up when run in
>> a guest (missing a timer interrupt, goodbye CPU).
>> - Either fixing kvmtool or reverting that patch makes it work reliably
>> again.
>>
>> My gut feeling is that until that patch, the failing irq_set_irq_type()
>> wasn't affecting the kernel's view of the trigger (it was still treated
>> as level). With this patch, the kernel now trusts whatever is coming
>> from the firmware, and the misconfiguration becomes obvious. And just
>> grepping through the DT files for arm and arm64 sends makes me thing
>> "Holly effin' crap!".
>>
>> I'm not saying that we shouldn't perform this change though. But it is
>> quite obvious that it is going to break an awful lot of existing code
>> and platforms. I'm also cooking a small patch for the arch timer (which
>> seems to be described in DT with a fairly high level of brokenness), so
>> that we can mop-up most of the brain damage.
> 
> Hmmm ... yes I see. I wonder if we should make the setting of the type
> here dependent upon PM being enabled for an irqchip? We could check to
> see if the .parent_device is populated and if so only then save the type
> and otherwise just set it as we do today.

I don't really like the idea of having multiple code paths for the same thing.
This is very error prone, and likely to bitrot pretty quickly.

> We could add a WARN to the existing irq_set_irq_type() or may be just a
> pr_warn() if a WARN is too verbose so people can fix up any issues.
> 
> I am also wondering if patch 4/17 "iqdomain: Fix handling of type
> settings for existing mappings" could generate a lot of reports
> interrupts failing due to bad firmware? I wonder if I should tone this
> patch down to a warning message as well as opposed to a complete failure.

We'll see. We can always tone it down a notch, should it prove to be too noisy...
So far, I haven't seen it firing. On the other hand, I get the following stuff
on my APM board:

[    0.000000] GIC: PPI0 is either secure or misconfigured
[    0.000000] GIC: PPI13 is either secure or misconfigured
[    0.000000] arm_arch_timer: WARNING: Invalid trigger for IRQ1, assuming level low
[    0.000000] arm_arch_timer: WARNING: Please fix your firmware
[    0.000000] arm_arch_timer: WARNING: Invalid trigger for IRQ2, assuming level low
[    0.000000] arm_arch_timer: WARNING: Please fix your firmware

Pretty awesome...

	M.
-- 
Jazz is not dead. It just smells funny...
