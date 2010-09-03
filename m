From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 09/11] OMAP: DMA: Implement generic errata handling
Date: Fri, 03 Sep 2010 15:42:29 -0700
Message-ID: <87sk1qtpnu.fsf@deeprootsystems.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<1282647866-6918-10-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45827 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab0ICWmc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Sep 2010 18:42:32 -0400
Received: by pzk9 with SMTP id 9so692977pzk.19
        for <linux-omap@vger.kernel.org>; Fri, 03 Sep 2010 15:42:31 -0700 (PDT)
In-Reply-To: <1282647866-6918-10-git-send-email-manjugk@ti.com> (Manjunatha
	GK's message of "Tue, 24 Aug 2010 16:34:24 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Manjunatha GK <manjugk@ti.com> writes:

> This patch introduces generic way of handling all OMAP DMA
> errata's which are applicable for OMAP1 and OMAP2PLUS processors.
>
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap1/dma.c             |    6 ++++
>  arch/arm/mach-omap2/dma.c             |   34 +++++++++++++++++++++++
>  arch/arm/plat-omap/dma.c              |   48 ++++++++++++++++++--------------
>  arch/arm/plat-omap/include/plat/dma.h |    9 ++++++
>  4 files changed, 76 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> index 26ab6e3..615c5f5 100644
> --- a/arch/arm/mach-omap1/dma.c
> +++ b/arch/arm/mach-omap1/dma.c
> @@ -170,6 +170,12 @@ static int __init omap1_system_dma_init(void)
>  		goto exit_device_put;
>  	}
>  
> +	/* Errata handling for all omap1 plus processors */
> +	pdata->errata			= 0;

This isn't needed as you just kzalloc'd pdata.

> +	if (cpu_class_is_omap1() && !cpu_is_omap15xx())

You don't need cpu_class_is_omap1() as this is OMAP1 specific code.

> +		pdata->errata		|= OMAP3_3_ERRATUM;
> +
>  	d = pdata->dma_attr;
>  
>  	/* Valid attributes for omap1 plus processors */
> diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> index f369bee..8832bd1 100644
> --- a/arch/arm/mach-omap2/dma.c
> +++ b/arch/arm/mach-omap2/dma.c
> @@ -80,6 +80,40 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *user)
>  
>  	pdata->dma_attr		= (struct omap_dma_dev_attr *)oh->dev_attr;
>  
> +	/* Handling Errata's for all OMAP2PLUS processors */
> +	pdata->errata			= 0;

not needed, see above

> +	if (cpu_is_omap242x() ||
> +		(cpu_is_omap243x() &&  omap_type() <= OMAP2430_REV_ES1_0))
> +		pdata->errata		= DMA_CHAINING_ERRATA;
> +
> +	/*
> +	 * Errata: On ES2.0 BUFFERING disable must be set.
> +	 * This will always fail on ES1.0
> +	 */
> +	if (cpu_is_omap24xx())
> +		pdata->errata		|= DMA_BUFF_DISABLE_ERRATA;
> +
> +	/*
> +	 * Errata: OMAP2: sDMA Channel is not disabled
> +	 * after a transaction error. So we explicitely
> +	 * disable the channel
> +	 */
> +	if (cpu_class_is_omap2())
> +		pdata->errata		|= DMA_CH_DISABLE_ERRATA;
> +
> +	/* Errata: OMAP3 :

fix multi-line comment style

> +	 * A bug in ROM code leaves IRQ status for channels 0 and 1 uncleared
> +	 * after secure sram context save and restore. Hence we need to
> +	 * manually clear those IRQs to avoid spurious interrupts. This
> +	 * affects only secure devices.
> +	 */
> +	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
> +		pdata->errata		|= DMA_IRQ_STATUS_ERRATA;
> +
> +	/* Errata3.3: Applicable for all omap2 plus */
> +	pdata->errata			|= OMAP3_3_ERRATUM;
> +
>  	od = omap_device_build(name, 0, oh, pdata, sizeof(*pdata),
>  			omap2_dma_latency, ARRAY_SIZE(omap2_dma_latency), 0);
>  
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 36c3dde..409586a 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -187,6 +187,25 @@ static inline void set_gdma_dev(int req, int dev)
>  #define set_gdma_dev(req, dev)	do {} while (0)
>  #endif
>  
> +static void dma_ocpsysconfig_errata(u32 *sys_cf, bool flag)

Please use (or extend) hwmod layer for modifying device SYSCONFIG.

> +{
> +	u32 l;
> +
> +	/*
> +	 * DMA Errata:
> +	 * Special programming model needed to disable DMA before end of block
> +	 */

Please reference Errata#

> +	if (!flag) {
> +		*sys_cf = dma_read(OCP_SYSCONFIG);
> +		l = *sys_cf;
> +		/* Middle mode reg set no Standby */
> +		l &= ~((1 << 12)|(1 << 13));
> +		dma_write(l, OCP_SYSCONFIG);
> +	} else
> +		/* put back old value */
> +		dma_write(*sys_cf, OCP_SYSCONFIG);
> +}
> +
>  /* Omap1 only */
>  static void clear_lch_regs(int lch)
>  {
> @@ -971,22 +990,16 @@ void omap_start_dma(int lch)
>  
>  			cur_lch = next_lch;
>  		} while (next_lch != -1);
> -	} else if (cpu_is_omap242x() ||
> -		(cpu_is_omap243x() &&  omap_type() <= OMAP2430_REV_ES1_0)) {
> +	}
>  
> -		/* Errata: Need to write lch even if not using chaining */
> +	if (p->errata & DMA_CHAINING_ERRATA)
>  		dma_write(lch, CLNK_CTRL(lch));
> -	}
>  
>  	omap_enable_channel_irq(lch);
>  
>  	l = dma_read(CCR(lch));
>  
> -	/*
> -	 * Errata: On ES2.0 BUFFERING disable must be set.
> -	 * This will always fail on ES1.0
> -	 */
> -	if (cpu_is_omap24xx())
> +	if (p->errata & DMA_BUFF_DISABLE_ERRATA)
>  		l |= OMAP_DMA_CCR_EN;
>  
>  	l |= OMAP_DMA_CCR_EN;
> @@ -1660,7 +1673,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
>  {
>  	int *channels;
>  	u32 l, i;
> -	u32 sys_cf;
> +	u32 get_sysconfig;
>  
>  	/* Check for input params */
>  	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
> @@ -1675,15 +1688,8 @@ int omap_stop_dma_chain_transfers(int chain_id)
>  	}
>  	channels = dma_linked_lch[chain_id].linked_dmach_q;
>  
> -	/*
> -	 * DMA Errata:
> -	 * Special programming model needed to disable DMA before end of block
> -	 */
> -	sys_cf = dma_read(OCP_SYSCONFIG);
> -	l = sys_cf;
> -	/* Middle mode reg set no Standby */
> -	l &= ~((1 << 12)|(1 << 13));
> -	dma_write(l, OCP_SYSCONFIG);
> +	if (p->errata & DMA_SYSCONFIG_ERRATA)
> +		dma_ocpsysconfig_errata(&get_sysconfig, false);
>  
>  	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
>  
> @@ -1702,8 +1708,8 @@ int omap_stop_dma_chain_transfers(int chain_id)
>  	/* Reset the Queue pointers */
>  	OMAP_DMA_CHAIN_QINIT(chain_id);
>  
> -	/* Errata - put in the old value */
> -	dma_write(sys_cf, OCP_SYSCONFIG);
> +	if (p->errata & DMA_SYSCONFIG_ERRATA)
> +		dma_ocpsysconfig_errata(&get_sysconfig, true);
>  
>  	return 0;
>  }
> diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
> index a44b11b..ca251ac 100644
> --- a/arch/arm/plat-omap/include/plat/dma.h
> +++ b/arch/arm/plat-omap/include/plat/dma.h
> @@ -269,6 +269,14 @@
>  #define IS_WORD_16			(1 << 0xC)
>  #define IS_RW_PRIORIY			(1 << 0xD)
>  
> +/* Errata Definitions */
> +#define	DMA_CHAINING_ERRATA		(1 << 0)
> +#define	DMA_BUFF_DISABLE_ERRATA		(1 << 1)
> +#define	OMAP3_3_ERRATUM			(1 << 2)
> +#define	DMA_SYSCONFIG_ERRATA		(1 << 3)
> +#define	DMA_CH_DISABLE_ERRATA		(1 << 4)
> +#define	DMA_IRQ_STATUS_ERRATA		(1 << 5)
> +
>  enum omap_dma_burst_mode {
>  	OMAP_DMA_DATA_BURST_DIS = 0,
>  	OMAP_DMA_DATA_BURST_4,
> @@ -346,6 +354,7 @@ struct omap_dma_dev_attr {
>  struct omap_system_dma_plat_info {
>  	struct omap_dma_dev_attr *dma_attr;
>  	void __iomem *omap_dma_base;
> +	u32 errata;
>  };
>  
>  extern void omap_set_dma_priority(int lch, int dst_port, int priority);

Kevin
