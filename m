From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2][RFC] OMAP4: sDMA driver: descriptor autoloading
 feature
Date: Mon, 31 Aug 2009 23:40:57 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA616D46@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C0037CE47C07@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36538 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbZHaSLN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 14:11:13 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C0037CE47C07@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Venkat,
Few comments other wise patch looks fine to me.
> -----Original Message-----
> From: S, Venkatraman
> Sent: Thursday, August 27, 2009 4:42 PM
> To: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; Shilimkar, Santosh
> Subject: [PATCH v2][RFC] OMAP4: sDMA driver: descriptor autoloading
> feature
>
> (Updated version of previous patch: http://marc.info/?l=linux-
> omap&m=125012097403050&w=2)
> Add sDMA driver support for descriptor autoloading feature.
>  Descriptor autoloading is OMAP4 sDMA hardware capability that can be
> exploited for scatter gather scenarios.
>
>  The feature works as described below
> 1) A sDMA channel is programmed to be in 'linked list' mode
> 2) The client (sDMA user) provides a list of descriptors in a linked list
> format
> 3) Each of the 'descriptor' (element in the linked list) contains an
> updated set of DMA configuration register values
> 4) Client starts DMA transfer
> 5) sDMA controller loads the first element to its register configuration
> memory and executes the transfer
> 6) After completion, loads the next element (in linked list) to
> configuration memory and executes the transfer, without MCU intervention.
> 7) Interrupt is generated after all transfers are completed; this can be
> configured to be done differently.
>
> Configurations and additional features
> 1) Fast mode & non-fast mode
>        Fast mode/non-fast decides on how the first transfer begins. In
> non-fast mode, the first element in the linked list is loaded only after
> completing the transfer according to the configurations already in the
> sDMA channel registers. In fast mode, the loading of the first element
> precedes the transfer.
>
> 2) Pause / resume of transfers
>        A transfer can be paused after a descriptor set has been loaded,
> provided the 'pause bit' is set in the linked list element.
> An ongoing transfer cannot be paused. If the 'pause bit' is set, transfer
> is not started after loading the register set from memory.
> Such a transfer can be resumed later.
Would it be good if we move this description just above those APIs. Even though this information is good to be here but later once merged, this would go in commit history.
Somebody reading code also would benefit from this info. I leave that decision to you.
> 3) Descriptor types
>        3 possible configurations of descriptors (initialized as linked
> list elements) are possible. Type 1 provides the maximum flexibility,
> which contains most register definitions of a DMA logical channel. Fewer
> options are present in type 2. Type 3 can just modify source/destinations
> address of transfers. In all transfers, unmodified registers settings are
> maintained for the next transfer.

This information too should be in source code somewhere.

> Patch provides options / API for
> 1) Setting up a descriptor loading for DMA channel for sg type transfers
> 2) configuration with linked list elements
> 3) Starting / pause and resume of the said transfers, query state
> 4) Closing/Releasing the DMA channel
>
> The patches are generated against kernel 2.6.31-rc1, tested on OMAP4
> simulator platform.
>
> Summary:
> OMAP sDMA driver changes for descriptor autoloading feature.
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>
> ---
>  arch/arm/plat-omap/dma.c              |  303
> +++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/dma.h |   98 +++++++++++
>  2 files changed, 401 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 7677a4a..3a75272 100644
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
> @@ -46,13 +47,42 @@ enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE,
> DMA_CH_STARTED,
>  enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
>  #endif
>
> +/* CDP Register bitmaps */
> +#define DMA_LIST_CDP_DST_VALID       (BIT(0))
> +#define DMA_LIST_CDP_SRC_VALID       (BIT(2))
> +#define DMA_LIST_CDP_TYPE1   (BIT(4))
> +#define DMA_LIST_CDP_TYPE2   (BIT(5))
> +#define DMA_LIST_CDP_TYPE3   (BIT(4) | BIT(5))
> +#define DMA_LIST_CDP_PAUSEMODE       (BIT(7))
> +#define DMA_LIST_CDP_LISTMODE        (BIT(8))
> +#define DMA_LIST_CDP_FASTMODE        (BIT(10))
> +/* CAPS register bitmaps */
> +#define DMA_CAPS_SGLIST_SUPPORT      (BIT(20))
> +
> +#define DMA_LIST_DESC_PAUSE  (BIT(0))
> +#define DMA_LIST_DESC_SRC_VALID      (BIT(24))
> +#define DMA_LIST_DESC_DST_VALID      (BIT(26))
> +#define DMA_LIST_DESC_BLK_END        (BIT(28))
> +
>  #define OMAP_DMA_ACTIVE                      0x01
>  #define OMAP_DMA_CCR_EN                      (1 << 7)
>  #define OMAP2_DMA_CSR_CLEAR_MASK     0xffe
>
>  #define OMAP_FUNC_MUX_ARM_BASE               (0xfffe1000 + 0xec)
> +#define OMAP_DMA_INVALID_FRAME_COUNT (0xffff)
> +#define OMAP_DMA_INVALID_ELEM_COUNT  (0xffffff)
> +#define OMAP_DMA_INVALID_DESCRIPTOR_POINTER  (0xfffffffc)
>
>  static int enable_1510_mode;
> +static int dma_caps0_status;
> +
> +struct omap_dma_list_config_params {
> +     int chid;
> +     int num_elem;
> +     struct omap_dma_sglist_node *sghead;
> +     int sgheadphy;
> +     int pausenode;
> +};
>
>  struct omap_dma_lch {
>       int next_lch;
> @@ -72,6 +102,8 @@ struct omap_dma_lch {
>
>       int status;
>  #endif
> +
> +     void *list_config;
>       long flags;
>  };
>
> @@ -209,6 +241,12 @@ static void clear_lch_regs(int lch)
>               __raw_writew(0, lch_base + i);
>  }
>
> +static inline void omap_dma_list_set_ntype(struct omap_dma_sglist_node
> *node,
> +                                        int value)
> +{
> +     node->num_of_elem |= ((value) << 29);
> +}
> +
>  void omap_set_dma_priority(int lch, int dst_port, int priority)
>  {
>       unsigned long reg;
> @@ -1787,6 +1825,269 @@ EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
>  #endif       /* ifndef CONFIG_ARCH_OMAP1 */
>
>  /*-----------------------------------------------------------------------
> -----*/
> +int omap_request_dma_sglist(int dev_id, const char *dev_name,
> +     void (*callback) (int channel_id, u16 ch_status, void *data),
> +     int *listid, int nelem, struct omap_dma_sglist_node **elems)
> +{
> +     struct omap_dma_list_config_params *lcfg;
> +     struct omap_dma_sglist_node *desc;
> +     int dma_lch;
> +     int rc, i;
> +
> +     if (unlikely((dma_caps0_status & DMA_CAPS_SGLIST_SUPPORT) == 0)) {
> +             printk(KERN_ERR "omap DMA: sglist feature not supported\n");
> +             return -EPERM;
> +     }
Don't you need this check in all exported Descriptor API's ?

> +     if (unlikely(nelem <= 2)) {
> +             printk(KERN_ERR "omap DMA: Need >2 elements in the list\n");
> +             return -EINVAL;
> +     }
> +     rc = omap_request_dma(dev_id, dev_name,
> +                       callback, NULL, &dma_lch);
> +     if (rc < 0) {
> +             printk(KERN_ERR "omap_dma_list: Request failed %d\n", rc);
> +             return rc;
> +     }
> +     *listid = dma_lch;
> +     dma_chan[dma_lch].state = DMA_CH_NOTSTARTED;
You have updated channel status here but below allocations can still fail.
Safer is to update this once all allocation and variable population done.

> +     lcfg = kmalloc(sizeof(*lcfg), GFP_KERNEL);
> +     if (NULL == lcfg)
> +             goto error1;
> +     dma_chan[dma_lch].list_config = lcfg;
> +
> +     lcfg->num_elem = nelem;
> +
> +     *elems = desc = lcfg->sghead = dma_alloc_coherent(NULL,
> +             sizeof(*desc), &(lcfg->sgheadphy), 0);
> +     if (NULL == desc)
> +             goto error1;
> +
> +     for (i = 1; i < nelem; i++) {
> +             desc->next = dma_alloc_coherent(NULL,
> +                     sizeof(*(desc->next)), &(desc->next_desc_add_ptr), 0);
> +             if (NULL == desc->next)
> +                     goto error1;
> +             desc = desc->next;
> +             desc->next = NULL;
> +     }
> +     desc->next_desc_add_ptr = OMAP_DMA_INVALID_DESCRIPTOR_POINTER;
> +
> +     dma_write(0, CCDN(dma_lch)); /* Reset List index numbering */
> +     /* Initialize frame and element counters to invalid values */
> +     dma_write(OMAP_DMA_INVALID_FRAME_COUNT, CCFN(dma_lch));
> +     dma_write(OMAP_DMA_INVALID_ELEM_COUNT, CCEN(dma_lch));
> +     return 0;
> +
> +error1:
> +     omap_release_dma_sglist(dma_lch);
> +     return -ENOMEM;
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
> +     struct omap_dma_sglist_node *sghead,
> +     struct omap_dma_channel_params *chparams)
> +{
> +     struct omap_dma_list_config_params *lcfg;
> +     struct omap_dma_sglist_node *sgitcurr, *sgitprev;
> +     int l = DMA_LIST_CDP_LISTMODE; /* Enable Linked list mode in CDP */
> +
> +     lcfg = dma_chan[listid].list_config;
> +     if (lcfg->sghead != sghead) {
> +             printk(KERN_ERR "Unknown config pointer passed\n");
> +             return -EPERM;
> +     }
> +
> +     if (NULL == chparams)
> +             l |= DMA_LIST_CDP_FASTMODE;
> +     else
> +             omap_set_dma_params(listid, chparams);
> +             /* The client can set the dma params and still use fast mode
> +              * by using the set fast mode api
> +              */
> +     dma_write(l, CDP(listid));
> +
> +     sgitprev = sghead;
> +     sgitcurr = sgitprev->next;
> +
> +     while (sgitcurr != NULL) {
> +             switch (sgitcurr->desc_type) {
> +             case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
> +                     omap_dma_list_set_ntype(sgitprev, 1);
> +                     break;
> +
> +             case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
> +                     /* intentional no break */
> +             case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
> +                     omap_dma_list_set_ntype(sgitprev, 2);
> +                     break;
> +
> +             case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
> +                     /* intentional no break */
> +             case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
> +                     omap_dma_list_set_ntype(sgitprev, 3);
> +                     break;
> +             default:
> +                     return -EINVAL;
> +             }
> +             if (sgitcurr->flags & OMAP_DMA_LIST_SRC_VALID)
> +                     sgitprev->num_of_elem |= DMA_LIST_DESC_SRC_VALID;
> +             if (sgitcurr->flags & OMAP_DMA_LIST_DST_VALID)
> +                     sgitprev->num_of_elem |= DMA_LIST_DESC_DST_VALID;
> +             if (sgitcurr->flags & OMAP_DMA_LIST_NOTIFY_BLOCK_END)
> +                     sgitprev->num_of_elem |= DMA_LIST_DESC_BLK_END;
> +
> +             sgitprev = sgitcurr;
> +             sgitcurr = sgitcurr->next;
> +     }
> +
> +     return 0;
> +}
> +EXPORT_SYMBOL(omap_set_dma_sglist_params);
> +
> +int omap_start_dma_sglist_transfers(const int listid, const int
> pauseafter)
> +{
> +     struct omap_dma_list_config_params *lcfg;
> +     struct omap_dma_sglist_node *sgn;
> +     unsigned int l, type_id;
> +
> +     lcfg = dma_chan[listid].list_config;
> +     lcfg->pausenode = 0;
> +     sgn = lcfg->sghead;
> +     if (pauseafter > 0 && pauseafter <= lcfg->num_elem) {
> +             for (l = 0; l < pauseafter; l++)
> +                     sgn = sgn->next;
> +             sgn->next_desc_add_ptr |= DMA_LIST_DESC_PAUSE;
> +             lcfg->pausenode = pauseafter;
> +     }
> +
> +     /* Program the head descriptor's properties into CDP */
> +     switch (lcfg->sghead->desc_type) {
> +     case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
> +             type_id = DMA_LIST_CDP_TYPE1;
> +             break;
> +     case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
> +     case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
> +             type_id = DMA_LIST_CDP_TYPE2;
> +             break;
> +     case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
> +     case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
> +             type_id = DMA_LIST_CDP_TYPE3;
> +             break;
> +     default:
> +             return -EINVAL;
> +     }
> +
> +     l = dma_read(CDP(listid));
> +     l |= type_id;
> +     if (lcfg->sghead->flags & OMAP_DMA_LIST_SRC_VALID)
> +             l |= DMA_LIST_CDP_SRC_VALID;
> +     if (lcfg->sghead->flags & OMAP_DMA_LIST_DST_VALID)
> +             l |= DMA_LIST_CDP_DST_VALID;
> +
> +     dma_write(l, CDP(listid));
> +
> +     dma_write((lcfg->sgheadphy), CNDP(listid));
> +     printk(KERN_DEBUG "Start list transfer for list %x\n",
> +             lcfg->sgheadphy);
> +     omap_start_dma(listid);
> +
> +     return 0;
> +}
> +EXPORT_SYMBOL(omap_start_dma_sglist_transfers);
> +
> +int omap_resume_dma_sglist_transfers(const int listid, const int
> pauseafter)
> +{
> +     struct omap_dma_list_config_params *lcfg;
> +     struct omap_dma_sglist_node *sgn;
> +     int l;
> +
> +     lcfg = dma_chan[listid].list_config;
> +     sgn = lcfg->sghead;
> +     /* Clear the previous pause, if any */
> +     lcfg->pausenode = 0;
> +
> +     if (pauseafter > 0 && pauseafter <= lcfg->num_elem) {
> +             for (l = 0; l < pauseafter; l++)
> +                     sgn = sgn->next;
> +             sgn->next_desc_add_ptr |= DMA_LIST_DESC_PAUSE;
> +             lcfg->pausenode = pauseafter;
> +     }
> +
> +     /* Clear pause bit in CDP */
> +     l = dma_read(CDP(listid));
> +     printk(KERN_DEBUG "Resuming after pause: CDP=%x\n", l);
> +     l &= ~(DMA_LIST_CDP_PAUSEMODE);
> +     dma_write(l, CDP(listid));
> +     omap_start_dma(listid);
> +     return 0;
> +}
> +EXPORT_SYMBOL(omap_resume_dma_sglist_transfers);
> +
> +int omap_release_dma_sglist(const int listid)
> +{
> +     struct omap_dma_list_config_params *lcfg;
> +     struct omap_dma_sglist_node *sgn, *sgn2;
> +
> +     lcfg = dma_chan[listid].list_config;
> +     sgn = lcfg->sghead;
> +
> +     if (NULL != sgn) {
> +             sgn = sgn->next;
> +             do {
> +                     sgn2 = sgn->next;
> +                     dma_free_coherent(NULL, sizeof(*sgn), sgn,
> +                             sgn->next_desc_add_ptr);
> +                     sgn = sgn2;
> +             } while (sgn2 != NULL);
> +
> +             dma_free_coherent(NULL, sizeof(*(lcfg->sghead)),
> +                     lcfg->sghead, lcfg->sgheadphy);
> +     }
> +     if (NULL != dma_chan[listid].list_config)
> +             kfree(dma_chan[listid].list_config);
> +     dma_chan[listid].list_config = NULL;
> +     omap_free_dma(listid);
> +     return 0;
> +}
> +EXPORT_SYMBOL(omap_release_dma_sglist);
> +
> +int omap_get_completed_sglist_nodes(const int listid)
> +{
> +     int list_count;
> +
> +     list_count = dma_read(CCDN(listid));
> +     return list_count & 0xffff; /* only 16 LSB bits are valid */
A mask would have been nice.
> +}
> +EXPORT_SYMBOL(omap_get_completed_sglist_nodes);
> +
> +int omap_dma_sglist_is_paused(const int listid)
> +{
> +     int list_state;
> +
> +     list_state = dma_read(CDP(listid));
> +     return (list_state & DMA_LIST_CDP_PAUSEMODE) ? 1 : 0;
> +}
> +EXPORT_SYMBOL(omap_dma_sglist_is_paused);
> +
> +void omap_dma_set_sglist_fastmode(const int listid, const int fastmode)
> +{
> +     int l = dma_read(CDP(listid));
> +
> +     if (fastmode)
> +             l |= DMA_LIST_CDP_FASTMODE;
> +     else
> +             l &= ~(DMA_LIST_CDP_FASTMODE);
> +     dma_write(l, CDP(listid));
> +}
> +EXPORT_SYMBOL(omap_dma_set_sglist_fastmode);
> +
>
>  #ifdef CONFIG_ARCH_OMAP1
>
> @@ -2367,6 +2668,7 @@ static int __init omap_init_dma(void)
>                       kfree(dma_chan);
>                       return -ENOMEM;
>               }
> +             dma_caps0_status = dma_read(CAPS_0);
>       }
>
>       if (cpu_is_omap15xx()) {
> @@ -2418,6 +2720,7 @@ static int __init omap_init_dma(void)
>               omap_clear_dma(ch);
>               dma_chan[ch].dev_id = -1;
>               dma_chan[ch].next_lch = -1;
> +             dma_chan[ch].list_config = NULL;
>
>               if (ch >= 6 && enable_1510_mode)
>                       continue;
> diff --git a/arch/arm/plat-omap/include/mach/dma.h b/arch/arm/plat-
> omap/include/mach/dma.h
> index 72f680b..fcc58ad 100644
> --- a/arch/arm/plat-omap/include/mach/dma.h
> +++ b/arch/arm/plat-omap/include/mach/dma.h
> @@ -112,8 +112,12 @@
>  #define OMAP1_DMA_COLOR_U(n)         (0x40 * (n) + 0x22)
>  #define OMAP1_DMA_CCR2(n)            (0x40 * (n) + 0x24)
>  #define OMAP1_DMA_LCH_CTRL(n)                (0x40 * (n) + 0x2a)     /* not
> on 15xx */
> +#define OMAP1_DMA_COLOR(n)           0
>  #define OMAP1_DMA_CCEN(n)            0
>  #define OMAP1_DMA_CCFN(n)            0
> +#define OMAP1_DMA_CDP(n)             0
> +#define OMAP1_DMA_CNDP(n)            0
> +#define OMAP1_DMA_CCDN(n)            0
>
>  /* Channel specific registers only on omap2 */
>  #define OMAP_DMA4_CSSA(n)            (0x60 * (n) + 0x9c)
> @@ -132,6 +136,8 @@
>  #define OMAP1_DMA_IRQSTATUS_L0               0
>  #define OMAP1_DMA_IRQENABLE_L0               0
>  #define OMAP1_DMA_OCP_SYSCONFIG              0
> +#define OMAP1_DMA_CAPS_0             0
> +
>  #define OMAP_DMA4_HW_ID                      0
>  #define OMAP_DMA4_CAPS_0_L           0
>  #define OMAP_DMA4_CAPS_0_U           0
> @@ -576,6 +582,83 @@ struct omap_dma_channel_params {
>  #endif
>  };
>
> +struct omap_dma_sglist_type1_params {
> +     u32 src_addr;
> +     u32 dst_addr;
> +     u16 cfn_fn;
> +     u16 cicr;
> +     u16 dst_elem_idx;
> +     u16 src_elem_idx;
> +     u32 dst_frame_idx_or_pkt_size;
> +     u32 src_frame_idx_or_pkt_size;
> +     u32 color;
> +     u32 csdp;
> +     u32 clnk_ctrl;
> +     u32 ccr;
> +};
> +
> +struct omap_dma_sglist_type2a_params {
> +     u32 src_addr;
> +     u32 dst_addr;
> +     u16 cfn_fn;
> +     u16 cicr;
> +     u16 dst_elem_idx;
> +     u16 src_elem_idx;
> +     u32 dst_frame_idx_or_pkt_size;
> +     u32 src_frame_idx_or_pkt_size;
> +};
> +
> +struct omap_dma_sglist_type2b_params {
> +     u32 src_or_dest_addr;
> +     u16 cfn_fn;
> +     u16 cicr;
> +     u16 dst_elem_idx;
> +     u16 src_elem_idx;
> +     u32 dst_frame_idx_or_pkt_size;
> +     u32 src_frame_idx_or_pkt_size;
> +};
> +
> +struct omap_dma_sglist_type3a_params {
> +     u32 src_addr;
> +     u32 dst_addr;
> +};
> +
> +struct omap_dma_sglist_type3b_params {
> +     u32 src_or_dest_addr;
> +};
> +
> +enum omap_dma_sglist_descriptor_select {
> +     OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1,
> +     OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a,
> +     OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b,
> +     OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a,
> +     OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b,
> +};
> +
> +union omap_dma_sglist_node_type{
> +     struct omap_dma_sglist_type1_params t1;
> +     struct omap_dma_sglist_type2a_params t2a;
> +     struct omap_dma_sglist_type2b_params t2b;
> +     struct omap_dma_sglist_type3a_params t3a;
> +     struct omap_dma_sglist_type3b_params t3b;
> +};
> +
> +struct omap_dma_sglist_node {
> +
> +     /* Common elements for all descriptors */
> +     u32 next_desc_add_ptr;
> +     u32 num_of_elem;
> +     /* Type specific elements */
> +     union omap_dma_sglist_node_type sg_node;
> +     /* Control fields */
> +     int flags;
> +     /* Fields that can be set in flags variable */
> +     #define OMAP_DMA_LIST_SRC_VALID         (1)
> +     #define OMAP_DMA_LIST_DST_VALID         (2)
> +     #define OMAP_DMA_LIST_NOTIFY_BLOCK_END  (4)
> +     u32 desc_type;
> +     struct omap_dma_sglist_node *next;
> +};
>
>  extern void omap_set_dma_priority(int lch, int dst_port, int priority);
>  extern int omap_request_dma(int dev_id, const char *dev_name,
> @@ -656,6 +739,21 @@ extern int omap_modify_dma_chain_params(int chain_id,
>  extern int omap_dma_chain_status(int chain_id);
>  #endif
>
> +extern int omap_request_dma_sglist(int dev_id, const char *dev_name,
> +             void (*callback) (int channel_id, u16 ch_status, void *data),
> +             int *listid, int nelem, struct omap_dma_sglist_node **elems);
With this code callback after fewer nodes is not supported right ?
> +extern int omap_set_dma_sglist_params(const int listid,
> +                                   struct omap_dma_sglist_node *sghead,
> +                                   struct omap_dma_channel_params *chparams);
> +extern int omap_start_dma_sglist_transfers(const int listid,
> +                                        const int pauseafter);
> +extern int omap_resume_dma_sglist_transfers(const int listid,
> +                                         const int pauseafter);
> +extern int omap_release_dma_sglist(const int listid);
> +int omap_get_completed_sglist_nodes(const int listid);
> +int omap_dma_sglist_is_paused(const int listid);
> +void omap_dma_set_sglist_fastmode(const int listid, const int fastmode);
> +
>  /* LCD DMA functions */
>  extern int omap_request_lcd_dma(void (*callback)(u16 status, void *data),
>                               void *data);
> ---
