From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 08/15] genirq: Add runtime power management support for
 IRQ chips
Date: Thu, 17 Mar 2016 15:02:00 +0000
Message-ID: <56EAC6E8.1070806@arm.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
 <1458224359-32665-9-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458224359-32665-9-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Jon,

On 17/03/16 14:19, Jon Hunter wrote:
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
>  include/linux/irq.h    |  5 +++++
>  kernel/irq/chip.c      | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/irq/internals.h |  1 +
>  kernel/irq/manage.c    | 14 +++++++++++---
>  kernel/irq/pm.c        |  3 +++
>  5 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index c4de62348ff2..82f36390048d 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -315,6 +315,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>  /**
>   * struct irq_chip - hardware interrupt chip descriptor
>   *
> + * @parent:		pointer to associated device
>   * @name:		name for /proc/interrupts
>   * @irq_startup:	start up the interrupt (defaults to ->enable if NULL)
>   * @irq_shutdown:	shut down the interrupt (defaults to ->disable if NULL)
> @@ -354,6 +355,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>   * @flags:		chip specific flags
>   */
>  struct irq_chip {
> +	struct device	*parent;

Nit: Please don't call this just "parent". We have parent fields in
irq_data and irq_domain structures, and they always are a pointer to the
same type, indicating some form of stacking. Here, we're pointing to a
different type altogether...

How about calling it "dev", or "device" instead? It would make it much
clearer that when crossing that pointer, we're in another subsystem
altogether.

I'll come back to the rest of the patch a bit later, but I wanted to put
that one out right away... ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
