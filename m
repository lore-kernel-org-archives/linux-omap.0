From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH V2 11/19] irqchip: crossbar: fix memory leak incase of
 invalid entry
Date: Thu, 12 Jun 2014 09:20:23 -0400
Message-ID: <20140612132023.GX8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-12-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402574007-13987-12-git-send-email-r.sricharan-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 12, 2014 at 05:23:19PM +0530, Sricharan R wrote:
> From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> 
> When the provided unused skip list entry is greater than max irqs
> possible, we go to err3, but we fail to free register_offsets,
> should have returned to err4 instead which ensures that allocated

s/returned/jumped/

> register_offsets are freed as well.
> 
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/irqchip/irq-crossbar.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
> index 42a2e62..fea3e5d 100644
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
> @@ -225,7 +225,7 @@ static int __init crossbar_of_init(struct device_node *node,
>  
>  			if (entry > max) {
>  				pr_err("Invalid skip entry\n");
> -				goto err3;
> +				goto err4;

This would be a good opportunity to reduce the possibility of future
errors.  Please consider renaming err{1,2,3,4} to something more
recognizable while you are here.

thx,

Jason.

>  			}
>  			cb->irq_map[entry] = IRQ_SKIP;
>  		}
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
