From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 08/15] genirq: Add runtime power management support for
 IRQ chips
Date: Fri, 18 Mar 2016 13:11:00 +0200
Message-ID: <56EBE244.6070400@ti.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-9-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458224359-32665-9-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On 03/17/2016 04:19 PM, Jon Hunter wrote:
> Some IRQ chips may be located in a power domain outside of the CPU
> subsystem and hence will require device specific runtime power
> management. In order to support such IRQ chips, add a pointer for a
> device structure to the irq_chip structure, and if this pointer is
> populated by the IRQ chip driver and CONFIG_PM is selected in the kernel
> configuration, then the pm_runtime_get/put APIs for this chip will be
> called when an IRQ is requested/freed, respectively.
> 
> When entering system suspend and each interrupt is disabled if there is
> no wake-up set for that interrupt. For an IRQ chip that utilises runtime
> power management, print a warning message for each active interrupt that
> has no wake-up set because these interrupts may be unnecessarily keeping
> the IRQ chip enabled during system suspend.
> 
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>   include/linux/irq.h    |  5 +++++
>   kernel/irq/chip.c      | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   kernel/irq/internals.h |  1 +
>   kernel/irq/manage.c    | 14 +++++++++++---
>   kernel/irq/pm.c        |  3 +++
>   5 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index c4de62348ff2..82f36390048d 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -315,6 +315,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>   /**
>    * struct irq_chip - hardware interrupt chip descriptor
>    *
> + * @parent:		pointer to associated device
>    * @name:		name for /proc/interrupts
>    * @irq_startup:	start up the interrupt (defaults to ->enable if NULL)
>    * @irq_shutdown:	shut down the interrupt (defaults to ->disable if NULL)
> @@ -354,6 +355,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>    * @flags:		chip specific flags
>    */

[..]

>   
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index cea1de0161f1..ab436119084f 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -83,6 +83,9 @@ static bool suspend_device_irq(struct irq_desc *desc)
>   		 * suspend_device_irqs().
>   		 */
>   		return true;
> +	} else if (!irq_chip_pm_suspended(&desc->irq_data)) {
> +		pr_warn("irq %d has no wakeup set and has not been freed!\n",
> +			desc->irq_data.irq);

Sry. But I did not get this part of the patch :(

static bool suspend_device_irq(struct irq_desc *desc)
{
	if (!desc->action || irq_desc_is_chained(desc) ||
	    desc->no_suspend_depth) {
		pr_err("skip irq %d\n", irq_desc_get_irq(desc));
		return false;
	}

	if (irqd_is_wakeup_set(&desc->irq_data)) {
		irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
		/*
		 * We return true here to force the caller to issue
		 * synchronize_irq(). We need to make sure that the
		 * IRQD_WAKEUP_ARMED is visible before we return from
		 * suspend_device_irqs().
		 */
		pr_err("wakeup irq %d\n", irq_desc_get_irq(desc));
		return true;
	}

^^^^ Here you've added a warning 

	desc->istate |= IRQS_SUSPENDED;
	__disable_irq(desc);

^^^^ Here non wakeup IRQs will be disabled

	pr_err("%s __disable_irq irq %d\n", irq_desc_get_chip(desc)->name, irq_desc_get_irq(desc));

	/*
	 * Hardware which has no wakeup source configuration facility
	 * requires that the non wakeup interrupts are masked at the
	 * chip level. The chip implementation indicates that with
	 * IRQCHIP_MASK_ON_SUSPEND.
	 */
	if (irq_desc_get_chip(desc)->flags & IRQCHIP_MASK_ON_SUSPEND) {
		mask_irq(desc);
		pr_err("%s mask_irq irq %d\n", irq_desc_get_chip(desc)->name, irq_desc_get_irq(desc));
	}

	return true;
}

As result, there should be a ton of warnings if one IRQ (for example in GPIO irqchip)
is wakeup source, but all other are not. 

Also I'd like to note that:
- it is not expected that any IRQs have to be freed on enter Suspend
- Primary interrupt controller is expected to be suspended from syscore_suspend()
- not Primary interrupt controllers may be Suspended from:
  -- dpm_suspend() or dpm_suspend_late() - usual case for external interrupt controllers
  GPIO expanders (I2C, SPI ..)
  -- dpm_suspend_noirq() - usual case for SoC peripherals like OMAP GPIO
	dpm_suspend_noirq
	|- suspend_device_irqs()
	|- device_suspend_noirq() [1] <-- OMAP GPIO do suspend here.
  -- as always, some arches/maches may require hacks in platform code.
  
So, In my opinion, suspend has to be handled by each irqchip driver separately,
most probably at suspend_noirq level [1], because only  irqchip driver  
now sees a full picture and knows if it can suspend or not, and when, and how.
(may require to use pm_runtime_force_suspend/resume()).

I propose do not touch common/generic suspend code now. Any common code can be always
refactored later once there will be real drivers updated to use irqchip RPM
and which will support Suspend.


-- 
regards,
-grygorii
