From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/27] OMAP3: PM: INTC context save/restore
Date: Wed, 14 Oct 2009 15:15:13 -0700
Message-ID: <20091014221512.GN12700@atomide.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [091014 15:10]:
> From: Rajendra Nayak <rnayak@ti.com>
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/irq.c              |   66 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/irqs.h |    5 ++
>  2 files changed, 71 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 8db0e3a..fa2524d 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -25,6 +25,10 @@
>  #define INTC_SYSSTATUS		0x0014
>  #define INTC_SIR		0x0040
>  #define INTC_CONTROL		0x0048
> +#define INTC_PROTECTION		0x004C
> +#define INTC_IDLE		0x0050
> +#define INTC_THRESHOLD		0x0068
> +#define INTC_MIR0		0x0084
>  #define INTC_MIR_CLEAR0		0x0088
>  #define INTC_MIR_SET0		0x008c
>  #define INTC_PENDING_IRQ0	0x0098
> @@ -48,6 +52,18 @@ static struct omap_irq_bank {
>  	},
>  };
>  
> +/* Structure to save interrupt controller context */
> +struct omap3_intc_regs {
> +	u32 sysconfig;
> +	u32 protection;
> +	u32 idle;
> +	u32 threshold;
> +	u32 ilr[INTCPS_NR_IRQS];
> +	u32 mir[INTCPS_NR_MIR_REGS];
> +};
> +
> +static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
> +
>  /* INTC bank register get/set */
>  
>  static void intc_bank_write_reg(u32 val, struct omap_irq_bank *bank, u16 reg)
> @@ -201,3 +217,53 @@ void __init omap_init_irq(void)
>  	}
>  }
>  
> +#ifdef CONFIG_ARCH_OMAP3
> +void omap3_intc_save_context(void)
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
> +		for (i = 0; i < INTCPS_NR_IRQS; i++)
> +			intc_context[ind].ilr[i] =
> +				intc_bank_read_reg(bank, (0x100 + 0x4*ind));
> +		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
> +			intc_context[ind].mir[i] =
> +				intc_bank_read_reg(&irq_banks[0], INTC_MIR0 +
> +				(0x20 * i));
> +	}
> +}
> +

These too look like they should work on 24xx and 34xx?


> +void omap3_intc_restore_context(void)
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
> +		for (i = 0; i < INTCPS_NR_IRQS; i++)
> +			intc_bank_write_reg(intc_context[ind].ilr[i],
> +				bank, (0x100 + 0x4*ind));
> +		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
> +			intc_bank_write_reg(intc_context[ind].mir[i],
> +				 &irq_banks[0], INTC_MIR0 + (0x20 * i));
> +	}
> +	/* MIRs are saved and restore with other PRCM registers */
> +}
> +#endif /* CONFIG_ARCH_OMAP3 */
> diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
> index 6a6d028..2473910 100644
> --- a/arch/arm/plat-omap/include/mach/irqs.h
> +++ b/arch/arm/plat-omap/include/mach/irqs.h
> @@ -477,9 +477,14 @@
>  
>  #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
>  
> +#define INTCPS_NR_MIR_REGS	3
> +#define INTCPS_NR_IRQS		96
> +
>  #ifndef __ASSEMBLY__
>  extern void omap_init_irq(void);
>  extern int omap_irq_pending(void);
> +void omap3_intc_save_context(void);
> +void omap3_intc_restore_context(void);
>  #endif
>  
>  #include <mach/hardware.h>
> -- 
> 1.6.4.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
