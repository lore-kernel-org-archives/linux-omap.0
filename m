From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH V2 05/19] irqchip: crossbar: Change allocation logic by
 reversing search for free irqs
Date: Thu, 12 Jun 2014 08:56:15 -0400
Message-ID: <20140612125615.GT8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-6-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402574007-13987-6-git-send-email-r.sricharan-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 12, 2014 at 05:23:13PM +0530, Sricharan R wrote:
> From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> 
> Reverse the search algorithm to ensure that address mapping and IRQ
> allocation logics are proper. This can open up new bugs which are
> easily fixable rather than wait till allocation logic approaches
> the limit to find new bugs.

Could you expand on this logic some more?  What class of bugs are you
hoping to discover more easily?

thx,

Jason.

> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/irqchip/irq-crossbar.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
> index 287d3ce..de021638 100644
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
> @@ -68,7 +68,7 @@ static inline int get_prev_map_irq(int cb_no)
>  {
>  	int i;
>  
> -	for (i = 0; i < cb->int_max; i++)
> +	for (i = cb->int_max - 1; i >= 0; i--)
>  		if (cb->irq_map[i] == cb_no)
>  			return i;
>  
> @@ -79,7 +79,7 @@ static inline int allocate_free_irq(int cb_no)
>  {
>  	int i;
>  
> -	for (i = 0; i < cb->int_max; i++) {
> +	for (i = cb->int_max - 1; i >= 0; i--) {
>  		if (cb->irq_map[i] == IRQ_FREE) {
>  			cb->irq_map[i] = cb_no;
>  			return i;
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
