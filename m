From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 06/12] Interrupt Controller context save/restore
Date: Thu, 04 Sep 2008 12:12:45 +0300
Message-ID: <87abeo1dgy.fsf@deeprootsystems.com>
References: <61325.192.168.10.89.1220276430.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.244]:4710 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937AbYIDJMx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 05:12:53 -0400
Received: by ag-out-0708.google.com with SMTP id 31so6666950agc.10
        for <linux-omap@vger.kernel.org>; Thu, 04 Sep 2008 02:12:51 -0700 (PDT)
In-Reply-To: <61325.192.168.10.89.1220276430.squirrel@dbdmail.itg.ti.com> (Rajendra Nayak's message of "Mon\, 1 Sep 2008 19\:10\:30 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"Rajendra Nayak" <rnayak@ti.com> writes:

> This patch adds the Intrpt controller context save/restore
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

OK, there's a pattern appearing for the naming.  For consistency,
might I suggest using:

   static struct omap3_<module>_regs <module>_context[<size>];

for the struct, and for the save/restore functions

   void omap3_<module>_save_context(void)
   void omap3_<module>_restore_context(void)

In this series, this naming is not consistent across modules which
makes it unnecessarily confusing.

Other than that, this patch looks OK.

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
> +};
> +
>  extern void omap_init_irq(void);
>  extern int omap_irq_pending(void);
> +void omap3_save_intc_ctx(void);
> +void omap3_restore_intc_ctx(void);
>  #endif
>
>  #include <mach/hardware.h>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
