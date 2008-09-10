From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 06/12] Interrupt Controller context save/restore
Date: Wed, 10 Sep 2008 09:34:16 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809100931540.20446@utopia.booyaka.com>
References: <61325.192.168.10.89.1220276430.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47621 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbYIJPeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 11:34:17 -0400
In-Reply-To: <61325.192.168.10.89.1220276430.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hello Rajendra,

a few minor comments:

On Mon, 1 Sep 2008, Rajendra Nayak wrote:

> This patch adds the Intrpt controller context save/restore

This patch makes several references to '96'.  Please set up a macro for 
this number -- something like INTCPS_NR_IRQS, and use that in place of 
'96' throughout this patch.

> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  +0000                                  |binary
>  arch/arm/mach-omap2/.irq.c.swp         |    0
>  arch/arm/mach-omap2/irq.c              |   48 +++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/irqs.h |   14 +++++++++
>  2 files changed, 62 insertions(+)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/irq.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/irq.c	2008-09-01 18:11:28.000000000
> +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/irq.c	2008-09-01 18:11:54.000000000 +0530
> @@ -24,6 +24,9 @@
>  #define INTC_SYSCONFIG		0x0010
>  #define INTC_SYSSTATUS		0x0014
>  #define INTC_CONTROL		0x0048
> +#define INTC_PROTECTION		0x004C
> +#define INTC_IDLE		0x0050
> +#define INTC_THRESHOLD		0x0068
>  #define INTC_MIR_CLEAR0		0x0088
>  #define INTC_MIR_SET0		0x008c
>  #define INTC_PENDING_IRQ0	0x0098
> @@ -167,3 +170,48 @@ void __init omap_init_irq(void)
>  	}
>  }
> 
> +#ifdef CONFIG_ARCH_OMAP3
> +static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
> +void omap3_save_intc_ctx(void)
> +{
> +	int ind = 0, i = 0;
> +	for (ind = 0; ind < ARRAY_SIZE(irq_banks); ind++) {
> +		struct omap_irq_bank *bank = irq_banks + ind;
> +		intc_context[ind].sysconfig =
> +			intc_bank_read_reg(bank, INTC_SYSCONFIG);
> +		intc_context[ind].protection =
> +			intc_bank_read_reg(bank, INTC_PROTECTION);
> +		intc_context[ind].idle =
> +			intc_bank_read_reg(bank, INTC_IDLE);
> +		intc_context[ind].threshold =
> +			intc_bank_read_reg(bank, INTC_THRESHOLD);
> +		for (i = 0; i < 96; i++)
> +			intc_context[ind].ilr[i] =
> +				intc_bank_read_reg(bank, (0x100 + 0x4*ind));
> +	}
> +	/* MIRs are saved and restore with other PRCM registers */
> +}
> +
> +void omap3_restore_intc_ctx(void)
> +{
> +	int ind = 0, i = 0;
> +
> +	for (ind = 0; ind < ARRAY_SIZE(irq_banks); ind++) {
> +		struct omap_irq_bank *bank = irq_banks + ind;
> +		intc_bank_write_reg(intc_context[ind].sysconfig,
> +					bank, INTC_SYSCONFIG);
> +		intc_bank_write_reg(intc_context[ind].sysconfig,
> +					bank, INTC_SYSCONFIG);
> +		intc_bank_write_reg(intc_context[ind].protection,
> +					bank, INTC_PROTECTION);
> +		intc_bank_write_reg(intc_context[ind].idle,
> +					bank, INTC_IDLE);
> +		intc_bank_write_reg(intc_context[ind].threshold,
> +					bank, INTC_THRESHOLD);
> +		for (i = 0; i < 96; i++)
> +			intc_bank_write_reg(intc_context[ind].ilr[i],
> +				bank, (0x100 + 0x4*ind));
> +	}
> +	/* MIRs are saved and restore with other PRCM registers */
> +}
> +#endif /* CONFIG_ARCH_OMAP3 */
> Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/irqs.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/irqs.h	2008-09-01
> 18:11:28.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/irqs.h	2008-09-01
> 18:11:54.000000000 +0530
> @@ -368,8 +368,22 @@
>  #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
> 
>  #ifndef __ASSEMBLY__
> +/* Structure to save interrupt controller context */
> +struct omap3_intc_regs {
> +	u32 sysconfig;
> +	u32 protection;
> +	u32 idle;
> +	u32 threshold;
> +	u32 ilr[96];
> +	u32 mir_0;
> +	u32 mir_1;
> +	u32 mir_2;

There is no point including MIR regs here if they are not used.

> +};
> +
>  extern void omap_init_irq(void);
>  extern int omap_irq_pending(void);
> +void omap3_save_intc_ctx(void);
> +void omap3_restore_intc_ctx(void);
>  #endif
> 
>  #include <mach/hardware.h>


- Paul
