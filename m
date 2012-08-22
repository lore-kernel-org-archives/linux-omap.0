From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v6 05/10] ARM: OMAP2+: gpmc: find features by ip rev check
Date: Tue, 21 Aug 2012 21:08:39 -0500
Message-ID: <50343F27.4060101@ti.com>
References: <cover.1345524670.git.afzal@ti.com> <0b211272d0d6f9281df7db400cb2d6a968b31222.1345524670.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36553 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754833Ab2HVCIe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 22:08:34 -0400
In-Reply-To: <0b211272d0d6f9281df7db400cb2d6a968b31222.1345524670.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 08/21/2012 05:45 AM, Afzal Mohammed wrote:
> Newer IP's have wr_access and wr_data_mux_bus fields. Use
> IP revision values to determine availability of these
> fields and hence decide on whether to configure them.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 070fac5..68123d0 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -85,6 +85,11 @@
>  #define ENABLE_PREFETCH		(0x1 << 7)
>  #define DMA_MPU_MODE		2
>  
> +#define	GPMC_REVISION_MAJOR(l)		((l >> 4) & 0xf)
> +
> +#define	GPMC_HAS_WR_ACCESS		0x1
> +#define	GPMC_HAS_WR_DATA_MUX_BUS	0x2
> +
>  /* XXX: Only NAND irq has been considered,currently these are the only ones used
>   */
>  #define	GPMC_NR_IRQ		2
> @@ -131,6 +136,7 @@ static DEFINE_SPINLOCK(gpmc_mem_lock);
>  static unsigned int gpmc_cs_map;	/* flag for cs which are initialized */
>  static int gpmc_ecc_used = -EINVAL;	/* cs using ecc engine */
>  
> +static unsigned gpmc_capability;
>  static void __iomem *gpmc_base;
>  
>  static struct clk *gpmc_l3_clk;
> @@ -356,10 +362,10 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
>  	GPMC_SET_ONE(GPMC_CS_CONFIG1, 18, 19, wait_monitoring);
>  	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
>  
> -	if (cpu_is_omap34xx()) {
> +	if (gpmc_capability & GPMC_HAS_WR_DATA_MUX_BUS)
>  		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
> +	if (gpmc_capability & GPMC_HAS_WR_ACCESS)
>  		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
> -	}
>  
>  	/* caller is expected to have initialized CONFIG1 to cover
>  	 * at least sync vs async
> @@ -922,6 +928,8 @@ static int __init gpmc_init(void)
>  	clk_enable(gpmc_l3_clk);
>  
>  	l = gpmc_read_reg(GPMC_REVISION);
> +	if (GPMC_REVISION_MAJOR(l) > 0x4)
> +		gpmc_capability = GPMC_HAS_WR_ACCESS | GPMC_HAS_WR_DATA_MUX_BUS;
>  	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
>  	/* Set smart idle mode and automatic L3 clock gating */
>  	l = gpmc_read_reg(GPMC_SYSCONFIG);
> 

Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Thanks!
Jon
