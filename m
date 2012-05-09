From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: remove incorrect irq_chip ack field
Date: Wed, 9 May 2012 10:36:06 -0700
Message-ID: <20120509173605.GS5088@atomide.com>
References: <1336262212-4455-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:19664 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756805Ab2EIRgI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 13:36:08 -0400
Content-Disposition: inline
In-Reply-To: <1336262212-4455-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [120505 17:00]:
> Each irq_chip for the main interrupt controller has offsets set for irq
> masking registers, which added to respective base results in a pointer
> to appropriate hardware register. However this is not correct for
> INTC_CONTROL as there is only one INTC_CONTROL register. This does not
> cause problems because generic ack code is never called, but remove
> this assignment to avoid confusion.

Thanks applying into fixes-non-critical.

Regards,

Tony
 
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  arch/arm/mach-omap2/irq.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 65f0d25..c11e8a8 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -149,7 +149,6 @@ omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
>  	ct->chip.irq_mask = irq_gc_mask_disable_reg;
>  	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
>  
> -	ct->regs.ack = INTC_CONTROL;
>  	ct->regs.enable = INTC_MIR_CLEAR0;
>  	ct->regs.disable = INTC_MIR_SET0;
>  	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
> -- 
> 1.7.0.4
> 
