From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv3 4/4] ARM: OMAP3+: add prcm chain interrupts to the interrupt
 list
Date: Thu, 01 Mar 2012 12:31:07 +0530
Message-ID: <4F4F1EB3.6020707@ti.com>
References: <1330529106-10423-1-git-send-email-t-kristo@ti.com> <1330529106-10423-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:44373 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756313Ab2CAHBP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 02:01:15 -0500
Received: by ggnf1 with SMTP id f1so100042ggn.14
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 23:01:13 -0800 (PST)
In-Reply-To: <1330529106-10423-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Wednesday 29 February 2012 08:55 PM, Tero Kristo wrote:
> Currently PRCM chain handler for OMAP4 requires SPARSE_IRQ to be enabled
> from kernel config, however enabling this option breaks the OMAP kernel
> completely and it can't be used. Thus, OMAP_PRCM_IRQ_BASE was added
> to the end of the irq list, and the prm_common code was changed to use
> this instead of irq_desc allocation scheme.
>
> Once SPARSE_IRQ is enabled for OMAP kernel, this patch can be reverted.

Do you still need this, despite this fix from Benoit?
http://marc.info/?l=linux-arm-kernel&m=133043468329275&w=2

>
> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> ---
>   arch/arm/mach-omap2/prm_common.c       |   14 +-------------
>   arch/arm/plat-omap/include/plat/irqs.h |    6 +++++-
>   2 files changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> index 860118a..9ca829f 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c
> @@ -196,11 +196,6 @@ void omap_prcm_irq_cleanup(void)
>   	prcm_irq_setup->priority_mask = NULL;
>
>   	irq_set_chained_handler(prcm_irq_setup->irq, NULL);
> -
> -	if (prcm_irq_setup->base_irq>  0)
> -		irq_free_descs(prcm_irq_setup->base_irq,
> -			prcm_irq_setup->nr_regs * 32);
> -	prcm_irq_setup->base_irq = 0;
>   }
>
>   void omap_prcm_irq_prepare(void)
> @@ -282,14 +277,7 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
>
>   	irq_set_chained_handler(irq_setup->irq, omap_prcm_irq_handler);
>
> -	irq_setup->base_irq = irq_alloc_descs(-1, 0, irq_setup->nr_regs * 32,
> -		0);
> -
> -	if (irq_setup->base_irq<  0) {
> -		pr_err("PRCM: failed to allocate irq descs: %d\n",
> -			irq_setup->base_irq);
> -		goto err;
> -	}
> +	irq_setup->base_irq = OMAP_PRCM_IRQ_BASE;
>
>   	for (i = 0; i<= irq_setup->nr_regs; i++) {
>   		gc = irq_alloc_generic_chip("PRCM", 1,
> diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
> index 2efd645..fe1be1d 100644
> --- a/arch/arm/plat-omap/include/plat/irqs.h
> +++ b/arch/arm/plat-omap/include/plat/irqs.h
> @@ -428,8 +428,12 @@
>   #define OMAP_GPMC_NR_IRQS	8
>   #define OMAP_GPMC_IRQ_END	(OMAP_GPMC_IRQ_BASE + OMAP_GPMC_NR_IRQS)
>
> +/* PRCM chain handler */
> +#define OMAP_PRCM_IRQ_BASE	(OMAP_GPMC_IRQ_END)
> +#define OMAP_PRCM_NR_IRQS	64
> +#define OMAP_PRCM_IRQ_END	(OMAP_PRCM_IRQ_BASE + OMAP_PRCM_NR_IRQS)
>
> -#define NR_IRQS			OMAP_GPMC_IRQ_END
> +#define NR_IRQS			OMAP_PRCM_IRQ_END
>
>   #define OMAP_IRQ_BIT(irq)	(1<<  ((irq) % 32))
>

