From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 13/19] ARM: OMAP4: PM: Mark the PPI and SPI interrupts as non-secure for GP
Date: Wed, 16 May 2012 16:48:02 -0700
Message-ID: <87ipfv4ril.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-14-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:55125 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760765Ab2EPXsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 19:48:09 -0400
Received: by dalf4 with SMTP id f4so1463029dal.15
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 16:48:07 -0700 (PDT)
In-Reply-To: <1336990730-26892-14-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 14 May 2012 13:18:44 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Axel Haslam <axelhaslam@gmail.com>

Tero Kristo <t-kristo@ti.com> writes:

> From: Axel Haslam <axelhaslam@gmail.com>
>
> ROM code restores part of the GIC context during wakeup from device
> off mode from the SAR RAM. If the PPI and SPI interrupts are not
> marked as non-secure on GP chips, this crashes the device during
> wakeup, thus mark them as non-secure.
>
> Signed-off-by: Axel Haslam <axelhaslam@gmail.com>
> [t-kristo@ti.com: fixed commit message, merged multiple patches to one]
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/common.h           |    1 +
>  arch/arm/mach-omap2/omap-wakeupgen.c   |   21 +++++++++++++++++++++
>  arch/arm/mach-omap2/omap4-common.c     |    5 +++++
>  arch/arm/mach-omap2/omap4-sar-layout.h |    3 +++
>  4 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 48d1ebe..0fbb4e2 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -200,6 +200,7 @@ static inline void __iomem *omap4_get_scu_base(void)
>  
>  extern void __init gic_init_irq(void);
>  extern void gic_dist_disable(void);
> +extern u32 gic_readl(u32 offset, u8 idx);
>  extern void omap_smc1(u32 fn, u32 arg);
>  extern void __iomem *omap4_get_sar_ram_base(void);
>  extern void omap_do_wfi(void);
> diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
> index 805d08d..b2165e4 100644
> --- a/arch/arm/mach-omap2/omap-wakeupgen.c
> +++ b/arch/arm/mach-omap2/omap-wakeupgen.c
> @@ -41,6 +41,7 @@
>  #define CPU_ENA_OFFSET		0x400
>  #define CPU0_ID			0x0
>  #define CPU1_ID			0x1
> +#define GIC_ISR_NON_SECURE	0xffffffff

nit: alignment with preceeding #defines

>  static void __iomem *wakeupgen_base;
>  static void __iomem *sar_base;
> @@ -387,6 +388,7 @@ int __init omap_wakeupgen_init(void)
>  {
>  	int i;
>  	unsigned int boot_cpu = smp_processor_id();
> +	int max_spi_reg;
>  
>  	/* Not supported on OMAP4 ES1.0 silicon */
>  	if (omap_rev() == OMAP4430_REV_ES1_0) {
> @@ -422,6 +424,25 @@ int __init omap_wakeupgen_init(void)
>  	for (i = 0; i < NR_IRQS; i++)
>  		irq_target_cpu[i] = boot_cpu;
>  
> +	/*
> +	 * Find out how many interrupts are supported.
> +	 * OMAP4 supports max of 128 SPIs where as GIC can support
> +	 * up to 1020 interrupt sources. On OMAP4, maximum SPIs are
> +	 * fused in DIST_CTR bit-fields as 128. Hence the code is safe
> +	 * from reserved register writes since its well within 1020.
> +	 */
> +	max_spi_reg = gic_readl(GIC_DIST_CTR, 0) & 0x1f;
> +
> +	if (omap_type() == OMAP2_DEVICE_TYPE_GP) {
> +		sar_base = ioremap(OMAP44XX_SAR_RAM_BASE, SZ_16K);
> +		sar_writel(GIC_ISR_NON_SECURE, ICDISR_CPU0_OFFSET, 0);
> +		sar_writel(GIC_ISR_NON_SECURE, ICDISR_CPU1_OFFSET, 0);
> +		for (i = 0; i < max_spi_reg; i++)
> +			sar_writel(GIC_ISR_NON_SECURE, ICDISR_SPI_OFFSET, i);

The above 4 lines are begging for some comments (something like the
changelog).  Since later in the series more stuff is added here, the end
result has some readability problems.

> +		iounmap(sar_base);
> +		sar_base = NULL;
> +	}
>  	irq_hotplug_init();
>  	irq_pm_init();
>  
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 7ea4652..f6019f6 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -112,6 +112,11 @@ void gic_dist_disable(void)
>  		__raw_writel(0x0, gic_dist_base_addr + GIC_DIST_CTRL);
>  }
>  
> +u32 gic_readl(u32 offset, u8 idx)
> +{

probably want an 'if (gic_dist_base_addr)' like gic_dist_disable() 

> +	return __raw_readl(gic_dist_base_addr + offset + 4 * idx);
> +}
> +
>  #ifdef CONFIG_CACHE_L2X0
>  
>  void __iomem *omap4_get_l2cache_base(void)
> diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
> index eef2839..0056667 100644
> --- a/arch/arm/mach-omap2/omap4-sar-layout.h
> +++ b/arch/arm/mach-omap2/omap4-sar-layout.h
> @@ -85,6 +85,9 @@
>  #define SAR_BACKUP_STATUS_OFFSET		(SAR_BANK3_OFFSET + 0x500)
>  #define SAR_SECURE_RAM_SIZE_OFFSET		(SAR_BANK3_OFFSET + 0x504)
>  #define SAR_SECRAM_SAVED_AT_OFFSET		(SAR_BANK3_OFFSET + 0x508)
> +#define ICDISR_CPU0_OFFSET			(SAR_BANK3_OFFSET + 0x50c)
> +#define ICDISR_CPU1_OFFSET			(SAR_BANK3_OFFSET + 0x510)
> +#define ICDISR_SPI_OFFSET			(SAR_BANK3_OFFSET + 0x514)

SAR_ prefix?

>  /* WakeUpGen save restore offset from OMAP44XX_SAR_RAM_BASE */
>  #define WAKEUPGENENB_OFFSET_CPU0		(SAR_BANK3_OFFSET + 0x684)

Kevin
