From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 09/11] OMAP: DMA: Implement generic errata handling
Date: Fri, 17 Sep 2010 17:45:16 +0200
Message-ID: <4C938D0C.9000801@ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com> <1282647866-6918-10-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45845 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350Ab0IQPpV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 11:45:21 -0400
In-Reply-To: <1282647866-6918-10-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On 8/24/2010 1:04 PM, G, Manjunath Kondaiah wrote:
> This patch introduces generic way of handling all OMAP DMA
> errata's which are applicable for OMAP1 and OMAP2PLUS processors.

<...>

> diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> index f369bee..8832bd1 100644
> --- a/arch/arm/mach-omap2/dma.c
> +++ b/arch/arm/mach-omap2/dma.c
> @@ -80,6 +80,40 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *user)
>
>   	pdata->dma_attr		= (struct omap_dma_dev_attr *)oh->dev_attr;
>
> +	/* Handling Errata's for all OMAP2PLUS processors */
> +	pdata->errata			= 0;
> +
> +	if (cpu_is_omap242x() ||
> +		(cpu_is_omap243x()&&   omap_type()<= OMAP2430_REV_ES1_0))
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
> +	 * A bug in ROM code leaves IRQ status for channels 0 and 1 uncleared
> +	 * after secure sram context save and restore. Hence we need to
> +	 * manually clear those IRQs to avoid spurious interrupts. This
> +	 * affects only secure devices.
> +	 */
> +	if (cpu_is_omap34xx()&&  (omap_type() != OMAP2_DEVICE_TYPE_GP))
> +		pdata->errata		|= DMA_IRQ_STATUS_ERRATA;
> +
> +	/* Errata3.3: Applicable for all omap2 plus */
> +	pdata->errata			|= OMAP3_3_ERRATUM;
> +

The DMA_SYSCONFIG_ERRATA does not seems to be initialized there. How are 
you enabling that errata?

Benoit

>   	od = omap_device_build(name, 0, oh, pdata, sizeof(*pdata),
>   			omap2_dma_latency, ARRAY_SIZE(omap2_dma_latency), 0);
>
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 36c3dde..409586a 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -187,6 +187,25 @@ static inline void set_gdma_dev(int req, int dev)
>   #define set_gdma_dev(req, dev)	do {} while (0)
>   #endif
>
> +static void dma_ocpsysconfig_errata(u32 *sys_cf, bool flag)
> +{
> +	u32 l;
> +
> +	/*
> +	 * DMA Errata:
> +	 * Special programming model needed to disable DMA before end of block
> +	 */
> +	if (!flag) {
> +		*sys_cf = dma_read(OCP_SYSCONFIG);
> +		l = *sys_cf;
> +		/* Middle mode reg set no Standby */
> +		l&= ~((1<<  12)|(1<<  13));
> +		dma_write(l, OCP_SYSCONFIG);
> +	} else
> +		/* put back old value */
> +		dma_write(*sys_cf, OCP_SYSCONFIG);
> +}
> +
>   /* Omap1 only */
>   static void clear_lch_regs(int lch)
>   {
> @@ -971,22 +990,16 @@ void omap_start_dma(int lch)
>
>   			cur_lch = next_lch;
>   		} while (next_lch != -1);
> -	} else if (cpu_is_omap242x() ||
> -		(cpu_is_omap243x()&&   omap_type()<= OMAP2430_REV_ES1_0)) {
> +	}
>
> -		/* Errata: Need to write lch even if not using chaining */
> +	if (p->errata&  DMA_CHAINING_ERRATA)
>   		dma_write(lch, CLNK_CTRL(lch));
> -	}
>
>   	omap_enable_channel_irq(lch);
>
>   	l = dma_read(CCR(lch));
>
> -	/*
> -	 * Errata: On ES2.0 BUFFERING disable must be set.
> -	 * This will always fail on ES1.0
> -	 */
> -	if (cpu_is_omap24xx())
> +	if (p->errata&  DMA_BUFF_DISABLE_ERRATA)
>   		l |= OMAP_DMA_CCR_EN;
>
>   	l |= OMAP_DMA_CCR_EN;
> @@ -1660,7 +1673,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
>   {
>   	int *channels;
>   	u32 l, i;
> -	u32 sys_cf;
> +	u32 get_sysconfig;
>
>   	/* Check for input params */
>   	if (unlikely((chain_id<  0 || chain_id>= dma_lch_count))) {
> @@ -1675,15 +1688,8 @@ int omap_stop_dma_chain_transfers(int chain_id)
>   	}
>   	channels = dma_linked_lch[chain_id].linked_dmach_q;
>
> -	/*
> -	 * DMA Errata:
> -	 * Special programming model needed to disable DMA before end of block
> -	 */
> -	sys_cf = dma_read(OCP_SYSCONFIG);
> -	l = sys_cf;
> -	/* Middle mode reg set no Standby */
> -	l&= ~((1<<  12)|(1<<  13));
> -	dma_write(l, OCP_SYSCONFIG);
> +	if (p->errata&  DMA_SYSCONFIG_ERRATA)
> +		dma_ocpsysconfig_errata(&get_sysconfig, false);
>
>   	for (i = 0; i<  dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
>
> @@ -1702,8 +1708,8 @@ int omap_stop_dma_chain_transfers(int chain_id)
>   	/* Reset the Queue pointers */
>   	OMAP_DMA_CHAIN_QINIT(chain_id);
>
> -	/* Errata - put in the old value */
> -	dma_write(sys_cf, OCP_SYSCONFIG);
> +	if (p->errata&  DMA_SYSCONFIG_ERRATA)
> +		dma_ocpsysconfig_errata(&get_sysconfig, true);
>
>   	return 0;
>   }
> diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
> index a44b11b..ca251ac 100644
> --- a/arch/arm/plat-omap/include/plat/dma.h
> +++ b/arch/arm/plat-omap/include/plat/dma.h
> @@ -269,6 +269,14 @@
>   #define IS_WORD_16			(1<<  0xC)
>   #define IS_RW_PRIORIY			(1<<  0xD)
>
> +/* Errata Definitions */
> +#define	DMA_CHAINING_ERRATA		(1<<  0)
> +#define	DMA_BUFF_DISABLE_ERRATA		(1<<  1)
> +#define	OMAP3_3_ERRATUM			(1<<  2)
> +#define	DMA_SYSCONFIG_ERRATA		(1<<  3)
> +#define	DMA_CH_DISABLE_ERRATA		(1<<  4)
> +#define	DMA_IRQ_STATUS_ERRATA		(1<<  5)
> +
>   enum omap_dma_burst_mode {
>   	OMAP_DMA_DATA_BURST_DIS = 0,
>   	OMAP_DMA_DATA_BURST_4,
> @@ -346,6 +354,7 @@ struct omap_dma_dev_attr {
>   struct omap_system_dma_plat_info {
>   	struct omap_dma_dev_attr *dma_attr;
>   	void __iomem *omap_dma_base;
> +	u32 errata;
>   };
>
>   extern void omap_set_dma_priority(int lch, int dst_port, int priority);

