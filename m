From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2 19/26] irqchip: atmel-aic: convert to handle_domain_irq
Date: Mon, 1 Sep 2014 11:32:47 +0200
Message-ID: <54043D3F.5000108@atmel.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com> <1409047421-27649-20-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409047421-27649-20-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux@lists.openrisc.net
Cc: mark.rutland@arm.com, tony@atomide.com, catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de, jonas@southpole.se, lorenzo.pieralisi@arm.com, linux@arm.linux.org.uk, shc_work@mail.ru, khilman@linaro.org, jason@lakedaemon.net, stefan.kristiansson@saunalahti.fi, larry.bassel@linaro.org, shawn.guo@freescale.com, baohua@kernel.org, sboyd@codeaurora.org, kernel@pengutronix.de, sudeep.holla@arm.com, schwidefsky@de.ibm.com, maxime.ripard@free-electrons.com, vkale@apm.com
List-Id: linux-omap@vger.kernel.org

On 26/08/2014 12:03, Marc Zyngier :
> Use the new handle_domain_irq method to handle interrupts.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Booting okay:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/irqchip/irq-atmel-aic.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
> index a82869e..9a2cf3c 100644
> --- a/drivers/irqchip/irq-atmel-aic.c
> +++ b/drivers/irqchip/irq-atmel-aic.c
> @@ -68,12 +68,10 @@ aic_handle(struct pt_regs *regs)
>  	irqnr = irq_reg_readl(gc->reg_base + AT91_AIC_IVR);
>  	irqstat = irq_reg_readl(gc->reg_base + AT91_AIC_ISR);
>  
> -	irqnr = irq_find_mapping(aic_domain, irqnr);
> -
>  	if (!irqstat)
>  		irq_reg_writel(0, gc->reg_base + AT91_AIC_EOICR);
>  	else
> -		handle_IRQ(irqnr, regs);
> +		handle_domain_irq(aic_domain, irqnr, regs);
>  }
>  
>  static int aic_retrigger(struct irq_data *d)
> 


-- 
Nicolas Ferre
