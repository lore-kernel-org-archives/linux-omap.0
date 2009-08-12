From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][PATCH 2/2] OMAP4: sDMA driver: descriptor autoloading feature
Date: Wed, 12 Aug 2009 16:49:14 -0700
Message-ID: <87y6pooao5.fsf@deeprootsystems.com>
References: <0680EC522D0CC943BC586913CF3768C003790C62AE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:51910 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbZHLXtQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 19:49:16 -0400
Received: by wf-out-1314.google.com with SMTP id 26so116788wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 16:49:17 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003790C62AE@dbde02.ent.ti.com> (Venkatraman S.'s message of "Thu\, 13 Aug 2009 01\:39\:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

"S, Venkatraman" <svenkatr@ti.com> writes:

> This patch adds the essential APIs for using the linked list mode of OMAP4 sDMA.
>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>

Your detailed description from PATCH 0/2 would be better placed here.

In addition to dropping the #ifdef, additional comments below...

> ---
>  arch/arm/plat-omap/dma.c              |  284 +++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/dma.h |  100 ++++++++++++
>  2 files changed, 384 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 7677a4a..dd4990a 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -29,6 +29,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/io.h>
> +#include <linux/dma-mapping.h>
>  
>  #include <asm/system.h>
>  #include <mach/hardware.h>
> @@ -52,8 +53,23 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
>  
>  #define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
>  
> +#define OMAP_DMALIST_SET_NTYPE(nod_, val_) \
> +	do { \
> +		(nod_)->num_of_elem |= ((val_) << 29); \
> +	} while (0)
> +

Use static inline function.

>  static int enable_1510_mode;
>  
> +#ifdef CONFIG_OMAP_DMA_DESCRIPTOR_LOAD
> +struct omap_dma_list_config_params {
> +	int chid;
> +	int num_elem;
> +	struct omap_dma_sglist_node *sghead;
> +	int sgheadphy;
> +	int pausenode;
> +};
> +#endif
> +
>  struct omap_dma_lch {
>  	int next_lch;
>  	int dev_id;
> @@ -72,6 +88,10 @@ struct omap_dma_lch {
>  
>  	int status;
>  #endif
> +
> +#ifdef CONFIG_OMAP_DMA_DESCRIPTOR_LOAD
> +	void *list_config;
> +#endif
>  	long flags;
>  };
>  
> @@ -1787,6 +1807,267 @@ EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
>  #endif	/* ifndef CONFIG_ARCH_OMAP1 */
>  
>  /*----------------------------------------------------------------------------*/
> +#ifdef CONFIG_OMAP_DMA_DESCRIPTOR_LOAD
> +
> +int omap_request_dma_sglist(int dev_id, const char *dev_name,
> +	void (*callback) (int channel_id, u16 ch_status, void *data),
> +	int *listid, int nelem, struct omap_dma_sglist_node **elems)
> +{
> +	struct omap_dma_list_config_params *lcfg;
> +	struct omap_dma_sglist_node *desc;
> +	int dma_lch;
> +	int rc, i;
> +
> +	if (unlikely(nelem <= 2)) {
> +		printk(KERN_ERR "omap DMA: Need >2 elements in the list\n");
> +		return -EINVAL;
> +	}
> +	rc = omap_request_dma(dev_id, dev_name,
> +			  callback, NULL, &dma_lch);
> +	if (rc < 0) {
> +		printk(KERN_ERR "omap_dma_list: Request failed %d\n", rc);
> +		return rc;
> +	}
> +	*listid = dma_lch;
> +	dma_chan[dma_lch].state = DMA_CH_NOTSTARTED;
> +	lcfg = kmalloc(sizeof(*lcfg), GFP_KERNEL);
> +	if (NULL == lcfg)
> +		goto error1;
> +	dma_chan[dma_lch].list_config = lcfg;
> +
> +	lcfg->num_elem = nelem;
> +
> +	*elems = desc = lcfg->sghead = dma_alloc_coherent(NULL,
> +		sizeof(*desc), &(lcfg->sgheadphy), 0);
> +	if (NULL == desc)
> +		goto error1;
> +
> +	for (i = 1; i < nelem; i++) {
> +		desc->next = dma_alloc_coherent(NULL,
> +			sizeof(*(desc->next)), &(desc->next_desc_add_ptr), 0);
> +		if (NULL == desc->next)
> +			goto error1;
> +		desc = desc->next;
> +		desc->next = NULL;
> +	}
> +	desc->next_desc_add_ptr = 0xfffffffc;
> +
> +	/* TRM Sec 1.4.21.4.3 */

A summary of that TRM section would be preferred, followed by the
section reference.

> +	dma_write(0, CCDN(dma_lch));
> +	dma_write(0xffff, CCFN(dma_lch));
> +	dma_write(0xffffff, CCEN(dma_lch));

Some symbolic names for these constants would be preferred.

> +	return 0;
> +
> +error1:
> +	omap_release_dma_sglist(dma_lch);
> +	return -ENOMEM;
> +
> +}
> +EXPORT_SYMBOL(omap_request_dma_sglist);
> +
> +/* The client can choose to not preconfigure the DMA registers
> + * In fast mode,the DMA controller uses the first element in the list to
> + * program the registers first, and then starts the transfer
> + */
> +
> +int omap_set_dma_sglist_params(const int listid,
> +	struct omap_dma_sglist_node *sghead,
> +	struct omap_dma_channel_params *chparams)
> +{
> +	struct omap_dma_list_config_params *lcfg;
> +	struct omap_dma_sglist_node *sgitcurr, *sgitprev;
> +	int l = 0x100; /* Enable Linked list mode in CDP */

Define these fields above using BIT() and use the symbolic
names in the code.

> +	lcfg = dma_chan[listid].list_config;
> +	if (lcfg->sghead != sghead) {
> +		printk(KERN_ERR "Unknown config pointer passed\n");
> +		return -EPERM;
> +	}
> +
> +	if (NULL == chparams)
> +		l |= 0x400;  /* FAST mode bit:10 */

ditto

> +	else
> +		omap_set_dma_params(listid, chparams);
> +		/* The client can set the dma params and still use fast mode
> +		 * by using the set fast mode api
> +		 */
> +	dma_write(l, CDP(listid));
> +
> +	sgitprev = sghead;
> +	sgitcurr = sgitprev->next;
> +
> +	while (sgitcurr != NULL) {
> +		switch (sgitcurr->desc_type) {
> +		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
> +			OMAP_DMALIST_SET_NTYPE(sgitprev, 1);
> +			break;
> +
> +		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
> +			/* intentional no break */
> +		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
> +			OMAP_DMALIST_SET_NTYPE(sgitprev, 2);
> +			break;
> +
> +		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
> +			/* intentional no break */
> +		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
> +			OMAP_DMALIST_SET_NTYPE(sgitprev, 3);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		if (sgitcurr->flags & OMAP_DMA_LIST_SRC_VALID)
> +			sgitprev->next_desc_add_ptr |= 1<<24;

use BIT()

> +		if (sgitcurr->flags & OMAP_DMA_LIST_DST_VALID)
> +			sgitprev->next_desc_add_ptr |= 1<<26;

ditto

> +		if (sgitcurr->flags & OMAP_DMA_LIST_NOTIFY_BLOCK_END)
> +			sgitprev->next_desc_add_ptr |= 1<<28;

ditto

> +
> +		sgitprev = sgitcurr;
> +		sgitcurr = sgitcurr->next;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap_set_dma_sglist_params);
> +
> +int omap_start_dma_sglist_transfers(const int listid, const int pauseafter)
> +{
> +	struct omap_dma_list_config_params *lcfg;
> +	struct omap_dma_sglist_node *sgn;
> +	unsigned int l, typeid;
> +
> +	lcfg = dma_chan[listid].list_config;
> +	lcfg->pausenode = 0;
> +	sgn = lcfg->sghead;
> +	if (pauseafter > 0 && pauseafter <= lcfg->num_elem) {
> +		for (l = 0; l < pauseafter; l++)
> +			sgn = sgn->next;
> +		sgn->next_desc_add_ptr |= 0x1;
> +		lcfg->pausenode = pauseafter;
> +	}
> +
> +	switch (lcfg->sghead->desc_type) {
> +	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
> +		typeid = 1;
> +		break;
> +	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
> +	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
> +		typeid = 2;
> +		break;
> +	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
> +	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
> +		typeid = 3;
> +		break;
> +	default:
> +		BUG();
> +	}
> +
> +	l = dma_read(CDP(listid));
> +	l |= (typeid << 4);

some symbolic names for the typeid values and the shift value
would be more readable.

> +	if (lcfg->sghead->flags & OMAP_DMA_LIST_SRC_VALID)
> +		l |= (1 << 2);

BIT()

> +	if (lcfg->sghead->flags & OMAP_DMA_LIST_DST_VALID)
> +		l |= 1;

BIT()

you get the picture...

> +	dma_write(l, CDP(listid));
> +	dma_write(0, CCDN(listid));
> +
> +	dma_write((lcfg->sgheadphy), CNDP(listid));
> +	printk(KERN_DEBUG "Start list transfer for list %x\n",
> +		lcfg->sgheadphy);
> +	omap_start_dma(listid);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap_start_dma_sglist_transfers);
> +
> +int omap_resume_dma_sglist_transfers(const int listid, const int pauseafter)
> +{
> +	struct omap_dma_list_config_params *lcfg;
> +	struct omap_dma_sglist_node *sgn;
> +	int l;
> +
> +	lcfg = dma_chan[listid].list_config;
> +	sgn = lcfg->sghead;
> +	/* Clear the previous pause, if any */
> +	lcfg->pausenode = 0;
> +
> +	if (pauseafter > 0 && pauseafter <= lcfg->num_elem) {
> +		for (l = 0; l < pauseafter; l++)
> +			sgn = sgn->next;
> +		sgn->next_desc_add_ptr |= 0x1;
> +		lcfg->pausenode = pauseafter;
> +	}
> +
> +	/* Clear pause bit in CDP */
> +	l = dma_read(CDP(listid));
> +	printk(KERN_DEBUG "Resuming after pause CDP=%x\n", l);
> +	l &= 0x77f;
> +	dma_write(l, CDP(listid));
> +	omap_start_dma(listid);
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap_resume_dma_sglist_transfers);
> +
> +int omap_release_dma_sglist(const int listid)
> +{
> +	struct omap_dma_list_config_params *lcfg;
> +	struct omap_dma_sglist_node *sgn, *sgn2;
> +
> +	lcfg = dma_chan[listid].list_config;
> +	sgn = lcfg->sghead;
> +
> +	if (NULL != sgn) {
> +		sgn = sgn->next;
> +		do {
> +			sgn2 = sgn->next;
> +			dma_free_coherent(NULL, sizeof(*sgn), sgn,
> +				sgn->next_desc_add_ptr);
> +			sgn = sgn2;
> +		} while (sgn2 != NULL);
> +
> +		dma_free_coherent(NULL, sizeof(*(lcfg->sghead)),
> +			lcfg->sghead, lcfg->sgheadphy);
> +	}
> +	if (NULL != dma_chan[listid].list_config)
> +		kfree(dma_chan[listid].list_config);
> +	dma_chan[listid].list_config = NULL;
> +	omap_free_dma(listid);
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap_release_dma_sglist);
> +
> +int omap_get_completed_sglist_nodes(const int listid)
> +{
> +	int list_count;
> +
> +	list_count = dma_read(CCDN(listid));
> +	return list_count & 0xffff;
> +}
> +EXPORT_SYMBOL(omap_get_completed_sglist_nodes);
> +
> +int omap_dma_sglist_is_paused(const int listid)
> +{
> +	int list_state;
> +
> +	list_state = dma_read(CDP(listid));
> +	return (list_state & 0x80) ? 1 : 0;

BIT()

> +}
> +EXPORT_SYMBOL(omap_dma_sglist_is_paused);
> +
> +void omap_dma_set_sglist_fastmode(const int listid, const int fastmode)
> +{
> +	int l = dma_read(CDP(listid));
> +
> +	if (fastmode)
> +		l |= 0x400;

BIT()

> +	else
> +		l &= 0xffffffdf;
> +	dma_write(l, CDP(listid));
> +}
> +EXPORT_SYMBOL(omap_dma_set_sglist_fastmode);
> +#endif
>  
>  #ifdef CONFIG_ARCH_OMAP1
>  
> @@ -2418,6 +2699,9 @@ static int __init omap_init_dma(void)
>  		omap_clear_dma(ch);
>  		dma_chan[ch].dev_id = -1;
>  		dma_chan[ch].next_lch = -1;
> +#ifdef CONFIG_OMAP_DMA_DESCRIPTOR_LOAD
> +		dma_chan[ch].list_config = NULL;
> +#endif
>  
>  		if (ch >= 6 && enable_1510_mode)
>  			continue;
> diff --git a/arch/arm/plat-omap/include/mach/dma.h b/arch/arm/plat-omap/include/mach/dma.h
> index 72f680b..df4a7b8 100644
> --- a/arch/arm/plat-omap/include/mach/dma.h
> +++ b/arch/arm/plat-omap/include/mach/dma.h
> @@ -112,8 +112,12 @@
>  #define OMAP1_DMA_COLOR_U(n)		(0x40 * (n) + 0x22)
>  #define OMAP1_DMA_CCR2(n)		(0x40 * (n) + 0x24)
>  #define OMAP1_DMA_LCH_CTRL(n)		(0x40 * (n) + 0x2a)	/* not on 15xx */
> +#define OMAP1_DMA_COLOR(n)		0
>  #define OMAP1_DMA_CCEN(n)		0
>  #define OMAP1_DMA_CCFN(n)		0
> +#define OMAP1_DMA_CDP(n)		0
> +#define OMAP1_DMA_CNDP(n)		0
> +#define OMAP1_DMA_CCDN(n)		0
>  
>  /* Channel specific registers only on omap2 */
>  #define OMAP_DMA4_CSSA(n)		(0x60 * (n) + 0x9c)
> @@ -576,6 +580,86 @@ struct omap_dma_channel_params {
>  #endif
>  };
>  
> +#ifdef CONFIG_OMAP_DMA_DESCRIPTOR_LOAD
> +struct omap_dma_sglist_type1_params {
> +	u32 src_addr;
> +	u32 dst_addr;
> +	u16 cfn_fn;
> +	u16 cicr;
> +	u16 dst_elem_idx;
> +	u16 src_elem_idx;
> +	u32 dst_frame_idx_or_pkt_size;
> +	u32 src_frame_idx_or_pkt_size;
> +	u32 color;
> +	u32 csdp;
> +	u32 clnk_ctrl;
> +	u32 ccr;
> +};
> +
> +struct omap_dma_sglist_type2a_params {
> +	u32 src_addr;
> +	u32 dst_addr;
> +	u16 cfn_fn;
> +	u16 cicr;
> +	u16 dst_elem_idx;
> +	u16 src_elem_idx;
> +	u32 dst_frame_idx_or_pkt_size;
> +	u32 src_frame_idx_or_pkt_size;
> +};
> +
> +struct omap_dma_sglist_type2b_params {
> +	u32 src_or_dest_addr;
> +	u16 cfn_fn;
> +	u16 cicr;
> +	u16 dst_elem_idx;
> +	u16 src_elem_idx;
> +	u32 dst_frame_idx_or_pkt_size;
> +	u32 src_frame_idx_or_pkt_size;
> +};
> +
> +struct omap_dma_sglist_type3a_params {
> +	u32 src_addr;
> +	u32 dst_addr;
> +};
> +
> +struct omap_dma_sglist_type3b_params {
> +	u32 src_or_dest_addr;
> +};
> +
> +enum omap_dma_sglist_descriptor_select {
> +	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1,
> +	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a,
> +	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b,
> +	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a,
> +	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b,
> +};
> +
> +union omap_dma_sglist_node_type{
> +	struct omap_dma_sglist_type1_params t1;
> +	struct omap_dma_sglist_type2a_params t2a;
> +	struct omap_dma_sglist_type2b_params t2b;
> +	struct omap_dma_sglist_type3a_params t3a;
> +	struct omap_dma_sglist_type3b_params t3b;
> +};
> +
> +struct omap_dma_sglist_node {
> +
> +	/* Common elements for all descriptors */
> +	u32 next_desc_add_ptr;
> +	u32 num_of_elem;
> +	/* Type specific elements */
> +	union omap_dma_sglist_node_type sg_node;
> +	/* Control fields */
> +	int flags;
> +	/* Fields that can be set in flags variable */
> +	#define OMAP_DMA_LIST_SRC_VALID		(1)
> +	#define OMAP_DMA_LIST_DST_VALID		(2)
> +	#define OMAP_DMA_LIST_NOTIFY_BLOCK_END	(4)
> +	u32 desc_type;
> +	struct omap_dma_sglist_node *next;
> +};
> +
> +#endif
>  
>  extern void omap_set_dma_priority(int lch, int dst_port, int priority);
>  extern int omap_request_dma(int dev_id, const char *dev_name,
> @@ -656,6 +740,22 @@ extern int omap_modify_dma_chain_params(int chain_id,
>  extern int omap_dma_chain_status(int chain_id);
>  #endif
>  
> +#ifdef CONFIG_OMAP_DMA_DESCRIPTOR_LOAD
> +extern int omap_request_dma_sglist(int dev_id, const char *dev_name,
> +		void (*callback) (int channel_id, u16 ch_status, void *data),
> +		int *listid, int nelem, struct omap_dma_sglist_node **elems);
> +extern int omap_set_dma_sglist_params(const int listid,
> +				      struct omap_dma_sglist_node *sghead,
> +				      struct omap_dma_channel_params *chparams);
> +extern int omap_start_dma_sglist_transfers(const int listid,
> +					   const int pauseafter);
> +extern int omap_resume_dma_sglist_transfers(const int listid,
> +					    const int pauseafter);
> +extern int omap_release_dma_sglist(const int listid);
> +int omap_get_completed_sglist_nodes(const int listid);
> +int omap_dma_sglist_is_paused(const int listid);
> +void omap_dma_set_sglist_fastmode(const int listid, const int fastmode);
> +#endif
>  /* LCD DMA functions */
>  extern int omap_request_lcd_dma(void (*callback)(u16 status, void *data),
>  				void *data);
> ---
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kevin
