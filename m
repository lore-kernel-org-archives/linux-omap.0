From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH V2 10/19] irqchip: crossbar: DRA7: Fix unused crossbar
 list
Date: Thu, 12 Jun 2014 09:16:00 -0400
Message-ID: <20140612131600.GW8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-11-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402574007-13987-11-git-send-email-r.sricharan-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 12, 2014 at 05:23:18PM +0530, Sricharan R wrote:
> From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
> 
> On DRA7 compatible IRQ crossbar, IRQ 10 default mapped to L3_APP_IRQ,
> IRQ133 is default mapped to NMI pin, 139 and 140 crossbars are
> unused(not routed). Mark these as unused crossbar IRQs.
> 
> Technical Reference Manual documentation update expected
> DRA72x-TRMINC00067 is being used to track the update.
> 
> Reported-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Reported-by: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
> Reported-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/irqchip/irq-crossbar.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
> index 7d4db07..42a2e62 100644
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
> @@ -253,8 +253,8 @@ err1:
>  	return -ENOMEM;
>  }
>  
> -/* irq number 10 cannot be used because of hw bug */
> -static int dra_irqs_unused[] = { 10 };
> +/* irq number 10,133,139 and 140 cannot be used because of hw bug */
> +static int dra_irqs_unused[] = { 10 , 133, 139, 140 };

see my earlier comment regarding a potential dts property.

thx,

Jason.

>  static struct crossbar_data cb_dra_data = { dra_irqs_unused,
>  				     ARRAY_SIZE(dra_irqs_unused), 0 };
>  
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
