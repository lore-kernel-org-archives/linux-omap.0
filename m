From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH V2 15/19] irqchip: crossbar: Add kerneldoc for
 crossbar_domain_unmap callback
Date: Thu, 12 Jun 2014 09:49:09 -0400
Message-ID: <20140612134909.GA8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-16-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402574007-13987-16-git-send-email-r.sricharan@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, tglx@linutronix.de
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 12, 2014 at 05:23:23PM +0530, Sricharan R wrote:
> The crossbar_domain_map/unmap callbacks need not be called same number
> of times for a particular irq. But still use counting is not needed
> here, because unmap(irq) gets called when irq_desc(irq) is disposed.
> After this the irq is anyways unusable and have to mapped again.

There's no need to duplicate the code comment in the commit log ;-)

> 
> Adding the above kerneldoc for unmap callback clarity.
> 
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
>  drivers/irqchip/irq-crossbar.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
> index 5f3e75a..2a73a66 100644
> --- a/drivers/irqchip/irq-crossbar.c
> +++ b/drivers/irqchip/irq-crossbar.c
> @@ -101,6 +101,16 @@ static int crossbar_domain_map(struct irq_domain *d, unsigned int irq,
>  	return 0;
>  }
>  
> +/**
> + * crossbar_domain_unmap - unmap a crossbar<->irq connection
> + * @d: domain of irq to unmap
> + * @irq: virq number
> + *
> + * The map/unmap callbacks need not be called same number of times for

s/same/the same/

> + * a particular irq. But still use counting is not needed here, because
> + * unmap(irq) gets called when irq_desc(irq) is disposed. After this the
> + * irq is anyways unusuable and have to be mapped again.

Please re-word this.  If I were new to the driver (I am ;-) ) I would
have no idea what this means (and I don't :( )

thx,

Jason.

> + */
>  static void crossbar_domain_unmap(struct irq_domain *d, unsigned int irq)
>  {
>  	irq_hw_number_t hw = irq_get_irq_data(irq)->hwirq;
> -- 
> 1.7.9.5
> 
