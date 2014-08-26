From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 24/26] ARM: omap2: irq: convert to handle_domain_irq
Date: Tue, 26 Aug 2014 13:57:29 -0700
Message-ID: <20140826205729.GB16006@atomide.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
 <1409047421-27649-25-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409047421-27649-25-git-send-email-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux@lists.openrisc.net, linux@arm.linux.org.uk, shawn.guo@freescale.com, kernel@pengutronix.de, catalin.marinas@arm.com, will.deacon@arm.com, jonas@southpole.se, tglx@linutronix.de, jason@lakedaemon.net, shc_work@mail.ru, baohua@kernel.org, maxime.ripard@free-electrons.com, khilman@linaro.org, sboyd@codeaurora.org, lorenzo.pieralisi@arm.com, larry.bassel@linaro.org, mark.rutland@arm.com, sudeep.holla@arm.com, stefan.kristiansson@saunalahti.fi, vkale@apm.com, schwidefsky@de.ibm.com
List-Id: linux-omap@vger.kernel.org

* Marc Zyngier <marc.zyngier@arm.com> [140826 03:05]:
> Use the new handle_domain_irq method to handle interrupts.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Seems to boot:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/irq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 35b8590..a62ba5a 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -248,8 +248,7 @@ out:
>  		irqnr &= ACTIVEIRQ_MASK;
>  
>  		if (irqnr) {
> -			irqnr = irq_find_mapping(domain, irqnr);
> -			handle_IRQ(irqnr, regs);
> +			handle_domain_irq(domain, irqnr, regs);
>  			handled_irq = 1;
>  		}
>  	} while (irqnr);
> -- 
> 2.0.4
> 
