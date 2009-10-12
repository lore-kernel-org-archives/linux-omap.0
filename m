From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3] OMAP4: sDMA driver: descriptor autoloading feature
Date: Mon, 12 Oct 2009 10:53:30 +0100
Message-ID: <20091012095330.GB29310@n2100.arm.linux.org.uk>
References: <0680EC522D0CC943BC586913CF3768C0037CE48838@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C0037CE48838@dbde02.ent.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 04, 2009 at 12:04:08AM +0530, S, Venkatraman wrote:
> +static int dma_caps0_status;
> +
> +struct omap_dma_list_config_params {
> +	  int chid;

This seems to be unused.

> +	  int num_elem;

This might want to be unsigned.

> +	  struct omap_dma_sglist_node *sghead;
> +	  int sgheadphy;

This should be dma_addr_t.

> +	  int pausenode;

Should this also be unsigned?  (If so, the 'pauseafter' parameter should
be as well.

> +};


> +int omap_request_dma_sglist(int dev_id, const char *dev_name,
> +       void (*callback) (int channel_id, u16 ch_status, void *data),
> +       int *listid, int nelem, struct omap_dma_sglist_node **elems)
> +{
> +       struct omap_dma_list_config_params *lcfg;
> +       struct omap_dma_sglist_node *desc;
> +       int dma_lch;
> +       int rc, i;
> +
> +       if (unlikely((dma_caps0_status & DMA_CAPS_SGLIST_SUPPORT) == 0)) {
> +               printk(KERN_ERR "omap DMA: sglist feature not supported\n");
> +               return -EPERM;
> +       }
> +       if (unlikely(nelem <= 2)) {
> +               printk(KERN_ERR "omap DMA: Need >2 elements in the list\n");
> +               return -EINVAL;
> +       }

I'm not sure these unlikely()'s help for two reasons:
1. gcc probably has already worked that out (later versions have become
   quite a bit better at this.)
2. since we're calling allocation functions, this isn't a hot path, so
   the few cycles the above _may_ save really isn't worth it

> +       rc = omap_request_dma(dev_id, dev_name,
> +                         callback, NULL, &dma_lch);
> +       if (rc < 0) {
> +               printk(KERN_ERR "omap_dma_list: Request failed %d\n", rc);

You use a prefix of "omap DMA" above, but "omap_dma_list" here - it would
be nice to be consistent.

> +               return rc;
> +       }
> +       *listid = dma_lch;
> +       dma_chan[dma_lch].state = DMA_CH_NOTSTARTED;
> +       lcfg = kmalloc(sizeof(*lcfg), GFP_KERNEL);
> +       if (NULL == lcfg)
> +               goto error1;
> +       dma_chan[dma_lch].list_config = lcfg;
> +
> +       lcfg->num_elem = nelem;
> +
> +       *elems = desc = lcfg->sghead = dma_alloc_coherent(NULL,
> +               sizeof(*desc), &(lcfg->sgheadphy), 0);
> +       if (NULL == desc)
> +               goto error1;
> +
> +       for (i = 1; i < nelem; i++) {
> +               desc->next = dma_alloc_coherent(NULL,
> +                       sizeof(*(desc->next)), &(desc->next_desc_add_ptr), 0);
> +               if (NULL == desc->next)
> +                       goto error1;
> +               desc = desc->next;
> +               desc->next = NULL;
> +       }

The smallest allocation unit available from dma_alloc_coherent() is one
page.  You really don't want to allocate one page per descriptor.
Instead, you want to do this:

	lcfg->sghead = dma_alloc_coherent(/*some device*/,
			sizeof(*desc) * nelem, &lcfg->sgheadphy, 0);
	if (!lcfg->sghead)
		goto error1;

	*elems = desc = lcfg->sghead;
	desc_dma = lcfg->sgheadphy;
	for (i = 1; i < nelem; i++, desc++) {
		desc->next = desc + 1;
		desc->next_desc_add_ptr = desc_dma + sizeof(*desc);
	}

This might also mean that you can get rid of the desc->next walking
and just use a plain for loop.

Also, using a struct device for the device actually doing the DMA would
be a Good Thing - this becomes much more relevent when we want to be
able to allocate coherent DMA pages from highmem (since passing NULL
means we have to allocate from the low DMA region.)

> +       desc->next_desc_add_ptr = OMAP_DMA_INVALID_DESCRIPTOR_POINTER;
> +
> +       dma_write(0, CCDN(dma_lch)); /* Reset List index numbering */
> +       /* Initialize frame and element counters to invalid values */
> +       dma_write(OMAP_DMA_INVALID_FRAME_COUNT, CCFN(dma_lch));
> +       dma_write(OMAP_DMA_INVALID_ELEM_COUNT, CCEN(dma_lch));
> +       return 0;
> +
> +error1:
> +       omap_release_dma_sglist(dma_lch);
> +       return -ENOMEM;
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
> +       struct omap_dma_sglist_node *sghead,
> +       struct omap_dma_channel_params *chparams)
> +{
> +       struct omap_dma_list_config_params *lcfg;
> +       struct omap_dma_sglist_node *sgitcurr, *sgitprev;
> +       int l = DMA_LIST_CDP_LISTMODE; /* Enable Linked list mode in CDP */
> +
> +       lcfg = dma_chan[listid].list_config;
> +       if (lcfg->sghead != sghead) {
> +               printk(KERN_ERR "Unknown config pointer passed\n");
> +               return -EPERM;
> +       }

If sghead can't be anything different from lcfg->sghead, what is the
purpose of passing sghead into this function?

> +
> +       if (NULL == chparams)
> +               l |= DMA_LIST_CDP_FASTMODE;
> +       else
> +               omap_set_dma_params(listid, chparams);
> +               /* The client can set the dma params and still use fast mode
> +                * by using the set fast mode api
> +                */
> +       dma_write(l, CDP(listid));
> +
> +       sgitprev = sghead;
> +       sgitcurr = sgitprev->next;
> +
> +       while (sgitcurr != NULL) {
> +               switch (sgitcurr->desc_type) {
> +               case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
> +                       omap_dma_list_set_ntype(sgitprev, 1);
> +                       break;
> +
> +               case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
> +                       /* intentional no break */
> +               case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
> +                       omap_dma_list_set_ntype(sgitprev, 2);
> +                       break;
> +
> +               case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
> +                       /* intentional no break */
> +               case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
> +                       omap_dma_list_set_ntype(sgitprev, 3);
> +                       break;
> +               default:
> +                       return -EINVAL;
> +               }
> +               if (sgitcurr->flags & OMAP_DMA_LIST_SRC_VALID)
> +                       sgitprev->num_of_elem |= DMA_LIST_DESC_SRC_VALID;
> +               if (sgitcurr->flags & OMAP_DMA_LIST_DST_VALID)
> +                       sgitprev->num_of_elem |= DMA_LIST_DESC_DST_VALID;
> +               if (sgitcurr->flags & OMAP_DMA_LIST_NOTIFY_BLOCK_END)
> +                       sgitprev->num_of_elem |= DMA_LIST_DESC_BLK_END;
> +
> +               sgitprev = sgitcurr;
> +               sgitcurr = sgitcurr->next;
> +       }

This becomes:
	for (sgprev = lcfg->sghead;
	     sgcurr = sgprev + 1, sgcurr < lcfg->sghead + lcfg->num_elem;
	     sgprev = sgcurr) {
		switch (sgcurr->desc_type) {
			...
		}
	}

> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(omap_set_dma_sglist_params);
> +
> +int omap_start_dma_sglist_transfers(const int listid, const int pauseafter)

'const' for non-pointer function parameters doesn't have a benefit for
code generation - the only thing it does is issue a warning if you write
to them.  Are they serving a special purpose here?

> +{
> +       struct omap_dma_list_config_params *lcfg;
> +       struct omap_dma_sglist_node *sgn;
> +       unsigned int l, type_id;
> +
> +       lcfg = dma_chan[listid].list_config;
> +       lcfg->pausenode = 0;
> +       sgn = lcfg->sghead;
> +       if (pauseafter > 0 && pauseafter <= lcfg->num_elem) {
> +               for (l = 0; l < pauseafter; l++)
> +                       sgn = sgn->next;

Are you sure this code is correct?  Two problems:

1. If 'pauseafter' is 1, sgn is the second entry in the list, not the
   first, so you can't pause after the first descriptor.

2. If 'pauseafter' is 'nelem' then sgn will be NULL, resulting in an oops.

> +               sgn->next_desc_add_ptr |= DMA_LIST_DESC_PAUSE;

Assuming you have an out-by-one error above, this becomes:
		sgn[pauseafter].next_desc_add_ptr |= DMA_LIST_DESC_PAUSE;

> +               lcfg->pausenode = pauseafter;
> +       }
> +
> +       /* Program the head descriptor's properties into CDP */
> +       switch (lcfg->sghead->desc_type) {
> +       case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
> +               type_id = DMA_LIST_CDP_TYPE1;
> +               break;
> +       case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
> +       case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
> +               type_id = DMA_LIST_CDP_TYPE2;
> +               break;
> +       case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
> +       case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
> +               type_id = DMA_LIST_CDP_TYPE3;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       l = dma_read(CDP(listid));
> +       l |= type_id;
> +       if (lcfg->sghead->flags & OMAP_DMA_LIST_SRC_VALID)
> +               l |= DMA_LIST_CDP_SRC_VALID;
> +       if (lcfg->sghead->flags & OMAP_DMA_LIST_DST_VALID)
> +               l |= DMA_LIST_CDP_DST_VALID;
> +
> +       dma_write(l, CDP(listid));
> +
> +       dma_write((lcfg->sgheadphy), CNDP(listid));
> +       printk(KERN_DEBUG "Start list transfer for list %x\n",
> +               lcfg->sgheadphy);
> +       omap_start_dma(listid);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(omap_start_dma_sglist_transfers);
> +
> +int omap_resume_dma_sglist_transfers(const int listid, const int pauseafter)

Same comment as above wrt 'const' parameters.

> +{
> +       struct omap_dma_list_config_params *lcfg;
> +       struct omap_dma_sglist_node *sgn;
> +       int l;
> +
> +       lcfg = dma_chan[listid].list_config;
> +       sgn = lcfg->sghead;
> +       /* Clear the previous pause, if any */
> +       lcfg->pausenode = 0;
> +
> +       if (pauseafter > 0 && pauseafter <= lcfg->num_elem) {
> +               for (l = 0; l < pauseafter; l++)
> +                       sgn = sgn->next;
> +               sgn->next_desc_add_ptr |= DMA_LIST_DESC_PAUSE;

Same comments as per omap_start_dma_sglist_transfers().

> +               lcfg->pausenode = pauseafter;
> +       }

Incidentally, shouldn't this be an inline function or something like that,
since this seems to be a duplication of what's happening in
omap_start_dma_sglist_transfers() ?

> +
> +       /* Clear pause bit in CDP */
> +       l = dma_read(CDP(listid));
> +       printk(KERN_DEBUG "Resuming after pause: CDP=%x\n", l);
> +       l &= ~(DMA_LIST_CDP_PAUSEMODE);
> +       dma_write(l, CDP(listid));
> +       omap_start_dma(listid);
> +       return 0;
> +}
> +EXPORT_SYMBOL(omap_resume_dma_sglist_transfers);
> +
> +int omap_release_dma_sglist(const int listid)
> +{
> +       struct omap_dma_list_config_params *lcfg;
> +       struct omap_dma_sglist_node *sgn, *sgn2;
> +
> +       lcfg = dma_chan[listid].list_config;
> +       sgn = lcfg->sghead;
> +
> +       if (NULL != sgn) {
> +               sgn = sgn->next;
> +               do {
> +                       sgn2 = sgn->next;
> +                       dma_free_coherent(NULL, sizeof(*sgn), sgn,
> +                               sgn->next_desc_add_ptr);
> +                       sgn = sgn2;
> +               } while (sgn2 != NULL);
> +
> +               dma_free_coherent(NULL, sizeof(*(lcfg->sghead)),
> +                       lcfg->sghead, lcfg->sgheadphy);

As a result of the way these are allocated, this can become the much
simpler:

		dma_free_coherent(/*some device */,
			sizeof(*lcfg->sghead) * lcfg->num_elem,
			lcfg->sghead, lcfg->sgheadphy);

> +       }
> +       if (NULL != dma_chan[listid].list_config)
> +               kfree(dma_chan[listid].list_config);
> +       dma_chan[listid].list_config = NULL;
> +       omap_free_dma(listid);
> +       return 0;
> +}
> +EXPORT_SYMBOL(omap_release_dma_sglist);
> +
> +int omap_get_completed_sglist_nodes(const int listid)
> +{
> +       int list_count;
> +
> +       list_count = dma_read(CCDN(listid));
> +       return list_count & 0xffff; /* only 16 LSB bits are valid */
> +}
> +EXPORT_SYMBOL(omap_get_completed_sglist_nodes);
> +
> +int omap_dma_sglist_is_paused(const int listid)
> +{
> +       int list_state;
> +
> +       list_state = dma_read(CDP(listid));
> +       return (list_state & DMA_LIST_CDP_PAUSEMODE) ? 1 : 0;
> +}
> +EXPORT_SYMBOL(omap_dma_sglist_is_paused);
> +
> +void omap_dma_set_sglist_fastmode(const int listid, const int fastmode)
> +{
> +       int l = dma_read(CDP(listid));
> +
> +       if (fastmode)
> +               l |= DMA_LIST_CDP_FASTMODE;
> +       else
> +               l &= ~(DMA_LIST_CDP_FASTMODE);
> +       dma_write(l, CDP(listid));
> +}
> +EXPORT_SYMBOL(omap_dma_set_sglist_fastmode);
> +
> 
>  #ifdef CONFIG_ARCH_OMAP1
> 
> @@ -2367,6 +2668,7 @@ static int __init omap_init_dma(void)
>                         kfree(dma_chan);
>                         return -ENOMEM;
>                 }
> +               dma_caps0_status = dma_read(CAPS_0);
>         }
> 
>         if (cpu_is_omap15xx()) {
> @@ -2418,6 +2720,7 @@ static int __init omap_init_dma(void)
>                 omap_clear_dma(ch);
>                 dma_chan[ch].dev_id = -1;
>                 dma_chan[ch].next_lch = -1;
> +               dma_chan[ch].list_config = NULL;
> 
>                 if (ch >= 6 && enable_1510_mode)
>                         continue;
> diff --git a/arch/arm/plat-omap/include/mach/dma.h b/arch/arm/plat-omap/include/mach/dma.h
> index 72f680b..ca2970d 100644
> --- a/arch/arm/plat-omap/include/mach/dma.h
> +++ b/arch/arm/plat-omap/include/mach/dma.h
> @@ -112,8 +112,12 @@
>  #define OMAP1_DMA_COLOR_U(n)           (0x40 * (n) + 0x22)
>  #define OMAP1_DMA_CCR2(n)              (0x40 * (n) + 0x24)
>  #define OMAP1_DMA_LCH_CTRL(n)          (0x40 * (n) + 0x2a)     /* not on 15xx */
> +#define OMAP1_DMA_COLOR(n)             0
>  #define OMAP1_DMA_CCEN(n)              0
>  #define OMAP1_DMA_CCFN(n)              0
> +#define OMAP1_DMA_CDP(n)               0
> +#define OMAP1_DMA_CNDP(n)              0
> +#define OMAP1_DMA_CCDN(n)              0
> 
>  /* Channel specific registers only on omap2 */
>  #define OMAP_DMA4_CSSA(n)              (0x60 * (n) + 0x9c)
> @@ -132,6 +136,8 @@
>  #define OMAP1_DMA_IRQSTATUS_L0         0
>  #define OMAP1_DMA_IRQENABLE_L0         0
>  #define OMAP1_DMA_OCP_SYSCONFIG                0
> +#define OMAP1_DMA_CAPS_0               0
> +
>  #define OMAP_DMA4_HW_ID                        0
>  #define OMAP_DMA4_CAPS_0_L             0
>  #define OMAP_DMA4_CAPS_0_U             0
> @@ -576,6 +582,83 @@ struct omap_dma_channel_params {
>  #endif
>  };
> 
> +struct omap_dma_sglist_type1_params {
> +       u32 src_addr;
> +       u32 dst_addr;
> +       u16 cfn_fn;
> +       u16 cicr;
> +       u16 dst_elem_idx;
> +       u16 src_elem_idx;
> +       u32 dst_frame_idx_or_pkt_size;
> +       u32 src_frame_idx_or_pkt_size;
> +       u32 color;
> +       u32 csdp;
> +       u32 clnk_ctrl;
> +       u32 ccr;
> +};
> +
> +struct omap_dma_sglist_type2a_params {
> +       u32 src_addr;
> +       u32 dst_addr;
> +       u16 cfn_fn;
> +       u16 cicr;
> +       u16 dst_elem_idx;
> +       u16 src_elem_idx;
> +       u32 dst_frame_idx_or_pkt_size;
> +       u32 src_frame_idx_or_pkt_size;
> +};
> +
> +struct omap_dma_sglist_type2b_params {
> +       u32 src_or_dest_addr;
> +       u16 cfn_fn;
> +       u16 cicr;
> +       u16 dst_elem_idx;
> +       u16 src_elem_idx;
> +       u32 dst_frame_idx_or_pkt_size;
> +       u32 src_frame_idx_or_pkt_size;
> +};
> +
> +struct omap_dma_sglist_type3a_params {
> +       u32 src_addr;
> +       u32 dst_addr;
> +};
> +
> +struct omap_dma_sglist_type3b_params {
> +       u32 src_or_dest_addr;
> +};
> +
> +enum omap_dma_sglist_descriptor_select {
> +       OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1,
> +       OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a,
> +       OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b,
> +       OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a,
> +       OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b,
> +};
> +
> +union omap_dma_sglist_node_type{
> +       struct omap_dma_sglist_type1_params t1;
> +       struct omap_dma_sglist_type2a_params t2a;
> +       struct omap_dma_sglist_type2b_params t2b;
> +       struct omap_dma_sglist_type3a_params t3a;
> +       struct omap_dma_sglist_type3b_params t3b;
> +};
> +
> +struct omap_dma_sglist_node {
> +
> +       /* Common elements for all descriptors */
> +       u32 next_desc_add_ptr;

For correct typing, this should be:

	dma_addr_t next_desc_add_ptr;

DMA addresses have type 'dma_addr_t' not u32.

> +       u32 num_of_elem;
> +       /* Type specific elements */
> +       union omap_dma_sglist_node_type sg_node;
> +       /* Control fields */
> +       int flags;

Maybe unsigned?

> +       /* Fields that can be set in flags variable */
> +       #define OMAP_DMA_LIST_SRC_VALID         (1)
> +       #define OMAP_DMA_LIST_DST_VALID         (2)
> +       #define OMAP_DMA_LIST_NOTIFY_BLOCK_END  (4)

And if you're only using a small number of flags, do you need 32 bits for
them?  Maybe something a little smaller like unsigned short?

> +       u32 desc_type;

Isn't this enum omap_dma_sglist_descriptor_select ?  If you correctly
type this, the compiler can check that you're handling all cases in a
switch statement automatically, which means if you add to the enum,
it'll tell you the place you missed.

> +       struct omap_dma_sglist_node *next;
> +};
> 
>  extern void omap_set_dma_priority(int lch, int dst_port, int priority);
>  extern int omap_request_dma(int dev_id, const char *dev_name,
> @@ -655,6 +738,59 @@ extern int omap_modify_dma_chain_params(int chain_id,
>                                         struct omap_dma_channel_params params);
>  extern int omap_dma_chain_status(int chain_id);
>  #endif
> +/* omap_request_dma_sglist:
> + * Request to setup a DMA channel to transfer in linked list mode of nelem
> + * elements. The memory for the list will be allocated and returned in
> + * elems structure
> + */
> +extern int omap_request_dma_sglist(int dev_id, const char *dev_name,
> +               void (*callback) (int channel_id, u16 ch_status, void *data),
> +               int *listid, int nelem, struct omap_dma_sglist_node **elems);
> +/* omap_set_dma_sglist_params
> + * Provide the configuration parameters for the sglist channel
> + * sghead should contain a fully populated list of nelems
> + * which completely describe the transfer. chparams, if not NULL, will
> + * set the appropriate parameters directly into the DMA register.
> + * If chparams is NULL, fastmode will be enabled automatically
> + */
> +extern int omap_set_dma_sglist_params(const int listid,
> +                                     struct omap_dma_sglist_node *sghead,
> +                                     struct omap_dma_channel_params *chparams);
> +/* omap_start_dma_sglist_transfers
> + * Starts the linked list based DMA transfer for the specified listid
> + * If no pause is required, -1 is to be set in pauseafter.
> + * Else, the transfer will suspend after pauseafter elements.
> + */
> +extern int omap_start_dma_sglist_transfers(const int listid,
> +                                          const int pauseafter);
> +/* omap_resume_dma_sglist_transfers
> + * Resumes the previously paused transfer.
> + * Can be again set to pause at pauseafter node of the linked list
> + * The index is absolute (from the head of the list)
> + */
> +extern int omap_resume_dma_sglist_transfers(const int listid,
> +                                           const int pauseafter);
> +/* omap_release_dma_sglist
> + * Releases the list based DMA channel and the associated list descriptors
> + */
> +extern int omap_release_dma_sglist(const int listid);
> +/* omap_get_completed_sglist_nodes
> + * Returns the number of completed elements in the linked list
> + * The value is transient if the API is invoked for an ongoing transfer
> + */
> +int omap_get_completed_sglist_nodes(const int listid);
> +/* omap_dma_sglist_is_paused
> + * Returns non zero if the linked list is currently in pause state
> + */
> +int omap_dma_sglist_is_paused(const int listid);
> +/* omap_dma_set_sglist_fastmode
> + * Set or clear the fastmode status of the transfer
> + * In fastmode, DMA register settings are updated from the first element
> + * of the linked list, before initiating the tranfer.
> + * In non-fastmode, the first element is used only after completing the
> + * transfer as already configured in the registers
> + */
> +void omap_dma_set_sglist_fastmode(const int listid, const int fastmode);
> 
>  /* LCD DMA functions */
>  extern int omap_request_lcd_dma(void (*callback)(u16 status, void *data),
> ---
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
