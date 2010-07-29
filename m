From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH 11/11] sDMA: descriptor autoloading feature
Date: Thu, 29 Jul 2010 16:00:47 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402707512CA@dbde02.ent.ti.com>
References: <1280397545-27323-1-git-send-email-manjugk@ti.com>
 <1280397545-27323-12-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54320 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601Ab0G2Kav convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jul 2010 06:30:51 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6TAUmM6027224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 29 Jul 2010 05:30:51 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o6TAUmGv000140
	for <linux-omap@vger.kernel.org>; Thu, 29 Jul 2010 16:00:48 +0530 (IST)
In-Reply-To: <1280397545-27323-12-git-send-email-manjugk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of G, 
> Manjunath Kondaiah
> Sent: Thursday, July 29, 2010 3:29 PM
> To: linux-omap@vger.kernel.org
> Cc: S, Venkatraman; Cousson, Benoit; Kevin Hilman; Paul 
> Walmsley; Tony Lindgren; Sawant, Anand; Shilimkar, Santosh; 
> Nayak, Rajendra; Basak, Partha; Varadarajan, Charulatha
> Subject: [PATCH 11/11] sDMA: descriptor autoloading feature
> 
> From: Venkatraman S <svenkatr@ti.com>
> 
> Add sDMA driver support for descriptor autoloading feature.
> Descriptor autoloading is OMAP sDMA v5 hardware capability 
> that can be exploited
> for scatter gather scenarios, currently available in OMAP3630 
> and OMAP4430.
> 
> The feature works as described below.
> 1. A sDMA channel is programmed to be in 'linked list' mode.
> 2) The client (sDMA user) provides a list of descriptors in a 
> linked list format
> 3) Each of the 'descriptor' (element in the linked list) 
> contains an updated set
> of DMA configuration register values.
> 4) Client starts DMA transfer.
> 5) sDMA controller loads the first element to its register 
> configuration memory
> and executes the transfer.
> 6) After completion, loads the next element (in linked list) 
> to configuration
> memory and executes the transfer, without MCU intervention.
> 7) Interrupt is generated after all transfers are completed; 
> this can be
> configured to be done differently.
> 
> Configurations and additional features
> 1) Fast mode & non-fast mode
> Fast mode/non-fast decides on how the first transfer begins. 
> In non-fast mode,
> the first element in the linked list is loaded only after 
> completing the
> transfer according to the configurations already in the sDMA 
> channel registers.
> In fast mode, the loading of the first element precedes the transfer.
> 
> 2) Pause / resume of transfers
> A transfer can be paused after a descriptor set has been 
> loaded, provided the
> pause bit' is set in the linked list element.
> An ongoing transfer cannot be paused. If the 'pause bit' is 
> set, transfer is not
> started after loading the register set from memory.
> Such a transfer can be resumed later.
> 
> 3) Descriptor types
> Three possible configurations of descriptors (initialized as 
> linked list
> elements) are possible.
> Type 1 provides the maximum flexibility, which contains most register
> definitions of a DMA logical channel.
> Fewer options are present in type 2.
> Type 3 can just modify source/destinations address of 
> transfers. In all
> transfers, unmodified registers settings are maintained for 
> the next transfer.
> 
> Patch provides options / API for
> 1) Setting up a descriptor loading for DMA channel for sg 
> type transfers
> 2) configuration with linked list elements
> 3) Starting / pause and resume of the said transfers, query state
> 4) Clearing the sglist mode
> 
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> ---
>  arch/arm/mach-omap1/dma.c              |    5 +
>  arch/arm/mach-omap1/include/mach/dma.h |    2 +
>  arch/arm/mach-omap2/dma.c              |  254 
> ++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/include/mach/dma.h |  194 
> ++++++++++++++++++++++++
>  arch/arm/plat-omap/dma.c               |    1 +
>  5 files changed, 456 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> index eadc160..1f10f62 100644
> --- a/arch/arm/mach-omap1/dma.c
> +++ b/arch/arm/mach-omap1/dma.c
> @@ -304,6 +304,11 @@ void omap_dma_set_global_params(int 
> arb_rate, int max_fifo_depth, int tparams)
>  }
>  EXPORT_SYMBOL(omap_dma_set_global_params);
>  
> +void omap_clear_dma_sglist_mode(int lch)
> +{
> +	return;
> +}
> +
>  static int __init omap1_system_dma_init(void)
>  {
>  	struct platform_device *pdev;
> diff --git a/arch/arm/mach-omap1/include/mach/dma.h 
> b/arch/arm/mach-omap1/include/mach/dma.h
> index 1eb0d31..afe486b 100644
> --- a/arch/arm/mach-omap1/include/mach/dma.h
> +++ b/arch/arm/mach-omap1/include/mach/dma.h
> @@ -143,4 +143,6 @@ struct omap_dma_lch {
>  	long flags;
>  };
>  
> +/* Dummy function */
> +extern void omap_clear_dma_sglist_mode(int lch);
>  #endif /* __ASM_ARCH_OMAP1_DMA_H */
> diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> index 390c428..c24ed00 100644
> --- a/arch/arm/mach-omap2/dma.c
> +++ b/arch/arm/mach-omap2/dma.c
> @@ -204,6 +204,77 @@ static void dma_ocpsysconfig_errata(u32 
> *sys_cf, bool flag)
>  		dma_write(*sys_cf, OCP_SYSCONFIG);
>  }
>  
> +static inline void omap_dma_list_set_ntype(struct 
> omap_dma_sglist_node *node,
> +					   int value)
> +{
> +	node->num_of_elem |= ((value) << 29);
> +}
> +
> +static void omap_set_dma_sglist_pausebit(
> +		struct omap_dma_list_config_params *lcfg, int 
> nelem, int set)
> +{
> +	struct omap_dma_sglist_node *sgn = lcfg->sghead;
> +
> +	if (nelem > 0 && nelem < lcfg->num_elem) {
> +		lcfg->pausenode = nelem;
> +		sgn += nelem;
> +
> +		if (set)
> +			sgn->next_desc_add_ptr |= DMA_LIST_DESC_PAUSE;
> +		else
> +			sgn->next_desc_add_ptr &= 
> ~(DMA_LIST_DESC_PAUSE);
> +	}
> +}
> +
> +static int dma_sglist_set_phy_params(struct 
> omap_dma_sglist_node *sghead,
> +		dma_addr_t phyaddr, int nelem)
> +{
> +	struct omap_dma_sglist_node *sgcurr, *sgprev;
> +	dma_addr_t elem_paddr = phyaddr;
> +
> +	for (sgprev = sghead;
> +		sgprev < sghead + nelem;
> +		sgprev++) {
> +
> +		sgcurr = sgprev + 1;
> +		sgprev->next = sgcurr;
> +		elem_paddr += (int)sizeof(*sgcurr);
> +		sgprev->next_desc_add_ptr = elem_paddr;
> +
> +		switch (sgcurr->desc_type) {
> +		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
> +			omap_dma_list_set_ntype(sgprev, 1);
> +			break;
> +
> +		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
> +		/* intentional no break */
> +		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
> +			omap_dma_list_set_ntype(sgprev, 2);
> +			break;
> +
> +		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
> +			/* intentional no break */
> +		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
> +			omap_dma_list_set_ntype(sgprev, 3);
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +
> +		}
> +		if (sgcurr->flags & OMAP_DMA_LIST_SRC_VALID)
> +			sgprev->num_of_elem |= DMA_LIST_DESC_SRC_VALID;
> +		if (sgcurr->flags & OMAP_DMA_LIST_DST_VALID)
> +			sgprev->num_of_elem |= DMA_LIST_DESC_DST_VALID;
> +		if (sgcurr->flags & OMAP_DMA_LIST_NOTIFY_BLOCK_END)
> +			sgprev->num_of_elem |= DMA_LIST_DESC_BLK_END;
> +	}
> +	sgprev--;
> +	sgprev->next_desc_add_ptr = OMAP_DMA_INVALID_DESCRIPTOR_POINTER;
> +	return 0;
> +}
> +
> +
>  void omap_dma_global_context_save(void)
>  {
>  	omap_dma_global_context.dma_irqenable_l0 =
> @@ -861,6 +932,189 @@ void omap_set_dma_write_mode(int lch, 
> enum omap_dma_write_mode mode)
>  }
>  EXPORT_SYMBOL(omap_set_dma_write_mode);
>  
> +int omap_set_dma_sglist_mode(int lch, struct 
> omap_dma_sglist_node *sgparams,
> +	dma_addr_t padd, int nelem, struct 
> omap_dma_channel_params *chparams)
> +{
> +	struct omap_dma_list_config_params *lcfg;
> +	int l = DMA_LIST_CDP_LISTMODE; /* Enable Linked list 
> mode in CDP */
> +
> +	if ((dma_caps0_status & DMA_CAPS_SGLIST_SUPPORT) == 0) {
> +		printk(KERN_ERR "omap DMA: sglist feature not 
> supported\n");
> +		return -EPERM;
> +	}
> +	if (dma_chan[lch].flags & OMAP_DMA_ACTIVE) {
> +		printk(KERN_ERR "omap DMA: configuring active 
> DMA channel\n");
> +		return -EPERM;
> +	}
> +
> +	if (padd == 0) {
> +		printk(KERN_ERR "omap DMA: sglist invalid dma_addr\n");
> +		return -EINVAL;
> +	}
> +	lcfg = &dma_chan[lch].list_config;
> +
> +	lcfg->sghead = sgparams;
> +	lcfg->num_elem = nelem;
> +	lcfg->sgheadphy = padd;
> +	lcfg->pausenode = -1;
> +
> +
> +	if (NULL == chparams)
> +		l |= DMA_LIST_CDP_FASTMODE;
> +	else
> +		omap_set_dma_params(lch, chparams);
> +
> +	dma_write(l, CDP(lch));
> +	dma_write(0, CCDN(lch)); /* Reset List index numbering */
> +	/* Initialize frame and element counters to invalid values */
> +	dma_write(OMAP_DMA_INVALID_FRAME_COUNT, CCFN(lch));
> +	dma_write(OMAP_DMA_INVALID_ELEM_COUNT, CCEN(lch));
> +
> +	return dma_sglist_set_phy_params(sgparams, 
> lcfg->sgheadphy, nelem);
> +
> +}
> +EXPORT_SYMBOL(omap_set_dma_sglist_mode);
> +
> +void omap_clear_dma_sglist_mode(int lch)
> +{
> +	/* Clear entire CDP which is related to sglist handling */
> +	dma_write(0, CDP(lch));
> +	dma_write(0, CCDN(lch));
> +	/**
> +	 * Put back the original enabled irqs, which
> +	 * could have been overwritten by type 1 or type 2
> +	 * descriptors
> +	 */
> +	dma_write(dma_chan[lch].enabled_irqs, CICR(lch));
> +	return;
> +}
> +EXPORT_SYMBOL(omap_clear_dma_sglist_mode);
> +
> +int omap_start_dma_sglist_transfers(int lch, int pauseafter)
> +{
> +	struct omap_dma_list_config_params *lcfg;
> +	struct omap_dma_sglist_node *sgn;
> +	unsigned int l, type_id;
> +
> +	lcfg = &dma_chan[lch].list_config;
> +	sgn = lcfg->sghead;
> +
> +	lcfg->pausenode = 0;
> +	omap_set_dma_sglist_pausebit(lcfg, pauseafter, 1);
> +
> +	/* Program the head descriptor's properties into CDP */
> +	switch (lcfg->sghead->desc_type) {
> +	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
> +		type_id = DMA_LIST_CDP_TYPE1;
> +		break;
> +	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
> +	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
> +		type_id = DMA_LIST_CDP_TYPE2;
> +		break;
> +	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
> +	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
> +		type_id = DMA_LIST_CDP_TYPE3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	l = dma_read(CDP(lch));
> +	l |= type_id;
> +	if (lcfg->sghead->flags & OMAP_DMA_LIST_SRC_VALID)
> +		l |= DMA_LIST_CDP_SRC_VALID;
> +	if (lcfg->sghead->flags & OMAP_DMA_LIST_DST_VALID)
> +		l |= DMA_LIST_CDP_DST_VALID;
> +
> +	dma_write(l, CDP(lch));
> +	dma_write((lcfg->sgheadphy), CNDP(lch));
> +	/**
> +	 * Barrier needed as writes to the
> +	 * descriptor memory needs to be flushed
> +	 * before it's used by DMA controller
> +	 */
> +	wmb();
> +	omap_start_dma(lch);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap_start_dma_sglist_transfers);
> +
> +int omap_resume_dma_sglist_transfers(int lch, int pauseafter)
> +{
> +	struct omap_dma_list_config_params *lcfg;
> +	struct omap_dma_sglist_node *sgn;
> +	int l, get_sysconfig;
> +
> +	lcfg = &dma_chan[lch].list_config;
> +	sgn = lcfg->sghead;
> +
> +	/* Maintain the pause state in descriptor */
> +	omap_set_dma_sglist_pausebit(lcfg, lcfg->pausenode, 0);
> +	omap_set_dma_sglist_pausebit(lcfg, pauseafter, 1);
> +
> +	/**
> +	 * Barrier needed as writes to the
> +	 * descriptor memory needs to be flushed
> +	 * before it's used by DMA controller
> +	 */
> +	wmb();
> +
> +	if (p->errata & DMA_SYSCONFIG_ERRATA)
> +		dma_ocpsysconfig_errata(&get_sysconfig, false)

Sorry. I missed ; here and forgot to commit this in last patch. 

-Manjunath