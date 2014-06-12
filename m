From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH V2 09/19] irqchip: crossbar: fix kerneldoc warning
Date: Thu, 12 Jun 2014 09:14:34 -0400
Message-ID: <20140612131434.GV8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-10-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402574007-13987-10-git-send-email-r.sricharan-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 12, 2014 at 05:23:17PM +0530, Sricharan R wrote:
> From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> 
> kernel doc style is wrong in code. fix it to squelch
> kerneldoc warnings:

I would re-word the above to mention that we need to add missing
properties for kerneldoc (@write, @safemap), and we're doing some
cleanup of harmless warnings while we are here.

> Warning(drivers/irqchip/irq-crossbar.c:27): missing initial short description on line:
>  * struct crossbar_device: crossbar device description
> Info(drivers/irqchip/irq-crossbar.c:27): Scanning doc for struct
> Warning(drivers/irqchip/irq-crossbar.c:39): No description found for parameter 'write'
> Warning(drivers/irqchip/irq-crossbar.c:42): missing initial short description on line:
>  * struct crossbar_data: Platform specific data
> Info(drivers/irqchip/irq-crossbar.c:42): Scanning doc for struct
> Warning(drivers/irqchip/irq-crossbar.c:50): No description found for parameter 'safe_map'
> 4 warnings
> 
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/irqchip/irq-crossbar.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
> index 58790d4..7d4db07 100644
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
> @@ -23,11 +23,13 @@
>  #define IRQ_SKIP	-3
>  #define GIC_IRQ_START	32
>  
> -/*
> +/**
> + * struct crossbar_device - crossbar device descriptio

s/descriptio/description/

thx,

Jason.

>   * @int_max: maximum number of supported interrupts
>   * @irq_map: array of interrupts to crossbar number mapping
>   * @crossbar_base: crossbar base address
>   * @register_offsets: offsets for each irq number
> + * @write: register write function pointer
>   */
>  struct crossbar_device {
>  	uint int_max;
> @@ -39,9 +41,10 @@ struct crossbar_device {
>  };
>  
>  /**
> - * struct crossbar_data: Platform specific data
> + * struct crossbar_data - Platform specific data
>   * @irqs_unused: array of irqs that cannot be used because of hw erratas
>   * @size: size of the irqs_unused array
> + * @safe_map: safe value to write to crossbar register
>   */
>  struct crossbar_data {
>  	const uint *irqs_unused;
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
