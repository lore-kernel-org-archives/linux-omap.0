From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP: Remove unused pieces of legacy DMA API
Date: Tue, 16 Sep 2014 17:36:28 -0700
Message-ID: <20140917003628.GA7987@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19655 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753039AbaIQAgt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2014 20:36:49 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

We're moving to the dmaengine API, so let's remove the unused
pieces of the omap legacy DMA code to make sure we don't get
any new users for these:

omap_set_dma_color_mode
omap_set_dma_src_index
omap_set_dma_dest_index
omap_dma_unlink_lch
omap_clear_dma
omap_dma_running
omap_dma_set_prio_lch
omap_set_dma_dst_endian_type
omap_set_dma_src_endian_type
omap_get_dma_index
omap_dma_disable_irq
omap_request_dma_chain
omap_free_dma_chain
omap_dma_chain_a_transfer
omap_start_dma_chain_transfers
omap_stop_dma_chain_transfers
omap_get_dma_chain_index
omap_get_dma_chain_dst_pos
omap_get_dma_chain_src_pos
omap_modify_dma_chain_params
omap_dma_chain_status

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -64,7 +64,9 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 
 static struct omap_system_dma_plat_info *p;
 static struct omap_dma_dev_attr *d;
-
+static void omap_clear_dma(int lch);
+static int omap_dma_set_prio_lch(int lch, unsigned char read_prio,
+				 unsigned char write_prio);
 static int enable_1510_mode;
 static u32 errata;
 
@@ -284,66 +286,6 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 }
 EXPORT_SYMBOL(omap_set_dma_transfer_params);
 
-void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode, u32 color)
-{
-	BUG_ON(omap_dma_in_1510_mode());
-
-	if (dma_omap1()) {
-		u16 w;
-
-		w = p->dma_read(CCR2, lch);
-		w &= ~0x03;
-
-		switch (mode) {
-		case OMAP_DMA_CONSTANT_FILL:
-			w |= 0x01;
-			break;
-		case OMAP_DMA_TRANSPARENT_COPY:
-			w |= 0x02;
-			break;
-		case OMAP_DMA_COLOR_DIS:
-			break;
-		default:
-			BUG();
-		}
-		p->dma_write(w, CCR2, lch);
-
-		w = p->dma_read(LCH_CTRL, lch);
-		w &= ~0x0f;
-		/* Default is channel type 2D */
-		if (mode) {
-			p->dma_write(color, COLOR, lch);
-			w |= 1;		/* Channel type G */
-		}
-		p->dma_write(w, LCH_CTRL, lch);
-	}
-
-	if (dma_omap2plus()) {
-		u32 val;
-
-		val = p->dma_read(CCR, lch);
-		val &= ~((1 << 17) | (1 << 16));
-
-		switch (mode) {
-		case OMAP_DMA_CONSTANT_FILL:
-			val |= 1 << 16;
-			break;
-		case OMAP_DMA_TRANSPARENT_COPY:
-			val |= 1 << 17;
-			break;
-		case OMAP_DMA_COLOR_DIS:
-			break;
-		default:
-			BUG();
-		}
-		p->dma_write(val, CCR, lch);
-
-		color &= 0xffffff;
-		p->dma_write(color, COLOR, lch);
-	}
-}
-EXPORT_SYMBOL(omap_set_dma_color_mode);
-
 void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
 {
 	if (dma_omap2plus()) {
@@ -417,16 +359,6 @@ void omap_set_dma_params(int lch, struct omap_dma_channel_params *params)
 }
 EXPORT_SYMBOL(omap_set_dma_params);
 
-void omap_set_dma_src_index(int lch, int eidx, int fidx)
-{
-	if (dma_omap2plus())
-		return;
-
-	p->dma_write(eidx, CSEI, lch);
-	p->dma_write(fidx, CSFI, lch);
-}
-EXPORT_SYMBOL(omap_set_dma_src_index);
-
 void omap_set_dma_src_data_pack(int lch, int enable)
 {
 	u32 l;
@@ -510,16 +442,6 @@ void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
 }
 EXPORT_SYMBOL(omap_set_dma_dest_params);
 
-void omap_set_dma_dest_index(int lch, int eidx, int fidx)
-{
-	if (dma_omap2plus())
-		return;
-
-	p->dma_write(eidx, CDEI, lch);
-	p->dma_write(fidx, CDFI, lch);
-}
-EXPORT_SYMBOL(omap_set_dma_dest_index);
-
 void omap_set_dma_dest_data_pack(int lch, int enable)
 {
 	u32 l;
@@ -843,7 +765,7 @@ EXPORT_SYMBOL(omap_dma_set_global_params);
  * Both of the above can be set with one of the following values :
  * 	DMA_CH_PRIO_HIGH/DMA_CH_PRIO_LOW
  */
-int
+static int
 omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 		      unsigned char write_prio)
 {
@@ -864,13 +786,13 @@ omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 
 	return 0;
 }
-EXPORT_SYMBOL(omap_dma_set_prio_lch);
+
 
 /*
  * Clears any DMA state so the DMA engine is ready to restart with new buffers
  * through omap_start_dma(). Any buffers in flight are discarded.
  */
-void omap_clear_dma(int lch)
+static void omap_clear_dma(int lch)
 {
 	unsigned long flags;
 
@@ -878,7 +800,6 @@ void omap_clear_dma(int lch)
 	p->clear_dma(lch);
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(omap_clear_dma);
 
 void omap_start_dma(int lch)
 {
@@ -1167,652 +1088,6 @@ void omap_dma_link_lch(int lch_head, int lch_queue)
 }
 EXPORT_SYMBOL(omap_dma_link_lch);
 
-/*
- * Once the DMA queue is stopped, we can destroy it.
- */
-void omap_dma_unlink_lch(int lch_head, int lch_queue)
-{
-	if (omap_dma_in_1510_mode()) {
-		if (lch_head == lch_queue) {
-			p->dma_write(p->dma_read(CCR, lch_head) & ~(3 << 8),
-								CCR, lch_head);
-			return;
-		}
-		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
-		BUG();
-		return;
-	}
-
-	if (dma_chan[lch_head].next_lch != lch_queue ||
-	    dma_chan[lch_head].next_lch == -1) {
-		pr_err("omap_dma: trying to unlink non linked channels\n");
-		dump_stack();
-	}
-
-	if ((dma_chan[lch_head].flags & OMAP_DMA_ACTIVE) ||
-	    (dma_chan[lch_queue].flags & OMAP_DMA_ACTIVE)) {
-		pr_err("omap_dma: You need to stop the DMA channels before unlinking\n");
-		dump_stack();
-	}
-
-	dma_chan[lch_head].next_lch = -1;
-}
-EXPORT_SYMBOL(omap_dma_unlink_lch);
-
-#ifndef CONFIG_ARCH_OMAP1
-/* Create chain of DMA channesls */
-static void create_dma_lch_chain(int lch_head, int lch_queue)
-{
-	u32 l;
-
-	/* Check if this is the first link in chain */
-	if (dma_chan[lch_head].next_linked_ch == -1) {
-		dma_chan[lch_head].next_linked_ch = lch_queue;
-		dma_chan[lch_head].prev_linked_ch = lch_queue;
-		dma_chan[lch_queue].next_linked_ch = lch_head;
-		dma_chan[lch_queue].prev_linked_ch = lch_head;
-	}
-
-	/* a link exists, link the new channel in circular chain */
-	else {
-		dma_chan[lch_queue].next_linked_ch =
-					dma_chan[lch_head].next_linked_ch;
-		dma_chan[lch_queue].prev_linked_ch = lch_head;
-		dma_chan[lch_head].next_linked_ch = lch_queue;
-		dma_chan[dma_chan[lch_queue].next_linked_ch].prev_linked_ch =
-					lch_queue;
-	}
-
-	l = p->dma_read(CLNK_CTRL, lch_head);
-	l &= ~(0x1f);
-	l |= lch_queue;
-	p->dma_write(l, CLNK_CTRL, lch_head);
-
-	l = p->dma_read(CLNK_CTRL, lch_queue);
-	l &= ~(0x1f);
-	l |= (dma_chan[lch_queue].next_linked_ch);
-	p->dma_write(l, CLNK_CTRL, lch_queue);
-}
-
-/**
- * @brief omap_request_dma_chain : Request a chain of DMA channels
- *
- * @param dev_id - Device id using the dma channel
- * @param dev_name - Device name
- * @param callback - Call back function
- * @chain_id -
- * @no_of_chans - Number of channels requested
- * @chain_mode - Dynamic or static chaining : OMAP_DMA_STATIC_CHAIN
- * 					      OMAP_DMA_DYNAMIC_CHAIN
- * @params - Channel parameters
- *
- * @return - Success : 0
- * 	     Failure: -EINVAL/-ENOMEM
- */
-int omap_request_dma_chain(int dev_id, const char *dev_name,
-			   void (*callback) (int lch, u16 ch_status,
-					     void *data),
-			   int *chain_id, int no_of_chans, int chain_mode,
-			   struct omap_dma_channel_params params)
-{
-	int *channels;
-	int i, err;
-
-	/* Is the chain mode valid ? */
-	if (chain_mode != OMAP_DMA_STATIC_CHAIN
-			&& chain_mode != OMAP_DMA_DYNAMIC_CHAIN) {
-		printk(KERN_ERR "Invalid chain mode requested\n");
-		return -EINVAL;
-	}
-
-	if (unlikely((no_of_chans < 1
-			|| no_of_chans > dma_lch_count))) {
-		printk(KERN_ERR "Invalid Number of channels requested\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * Allocate a queue to maintain the status of the channels
-	 * in the chain
-	 */
-	channels = kmalloc(sizeof(*channels) * no_of_chans, GFP_KERNEL);
-	if (channels == NULL) {
-		printk(KERN_ERR "omap_dma: No memory for channel queue\n");
-		return -ENOMEM;
-	}
-
-	/* request and reserve DMA channels for the chain */
-	for (i = 0; i < no_of_chans; i++) {
-		err = omap_request_dma(dev_id, dev_name,
-					callback, NULL, &channels[i]);
-		if (err < 0) {
-			int j;
-			for (j = 0; j < i; j++)
-				omap_free_dma(channels[j]);
-			kfree(channels);
-			printk(KERN_ERR "omap_dma: Request failed %d\n", err);
-			return err;
-		}
-		dma_chan[channels[i]].prev_linked_ch = -1;
-		dma_chan[channels[i]].state = DMA_CH_NOTSTARTED;
-
-		/*
-		 * Allowing client drivers to set common parameters now,
-		 * so that later only relevant (src_start, dest_start
-		 * and element count) can be set
-		 */
-		omap_set_dma_params(channels[i], &params);
-	}
-
-	*chain_id = channels[0];
-	dma_linked_lch[*chain_id].linked_dmach_q = channels;
-	dma_linked_lch[*chain_id].chain_mode = chain_mode;
-	dma_linked_lch[*chain_id].chain_state = DMA_CHAIN_NOTSTARTED;
-	dma_linked_lch[*chain_id].no_of_lchs_linked = no_of_chans;
-
-	for (i = 0; i < no_of_chans; i++)
-		dma_chan[channels[i]].chain_id = *chain_id;
-
-	/* Reset the Queue pointers */
-	OMAP_DMA_CHAIN_QINIT(*chain_id);
-
-	/* Set up the chain */
-	if (no_of_chans == 1)
-		create_dma_lch_chain(channels[0], channels[0]);
-	else {
-		for (i = 0; i < (no_of_chans - 1); i++)
-			create_dma_lch_chain(channels[i], channels[i + 1]);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_request_dma_chain);
-
-/**
- * @brief omap_modify_dma_chain_param : Modify the chain's params - Modify the
- * params after setting it. Dont do this while dma is running!!
- *
- * @param chain_id - Chained logical channel id.
- * @param params
- *
- * @return - Success : 0
- * 	     Failure : -EINVAL
- */
-int omap_modify_dma_chain_params(int chain_id,
-				struct omap_dma_channel_params params)
-{
-	int *channels;
-	u32 i;
-
-	/* Check for input params */
-	if (unlikely((chain_id < 0
-			|| chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-
-	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
-		/*
-		 * Allowing client drivers to set common parameters now,
-		 * so that later only relevant (src_start, dest_start
-		 * and element count) can be set
-		 */
-		omap_set_dma_params(channels[i], &params);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_modify_dma_chain_params);
-
-/**
- * @brief omap_free_dma_chain - Free all the logical channels in a chain.
- *
- * @param chain_id
- *
- * @return - Success : 0
- * 	     Failure : -EINVAL
- */
-int omap_free_dma_chain(int chain_id)
-{
-	int *channels;
-	u32 i;
-
-	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
-		dma_chan[channels[i]].next_linked_ch = -1;
-		dma_chan[channels[i]].prev_linked_ch = -1;
-		dma_chan[channels[i]].chain_id = -1;
-		dma_chan[channels[i]].state = DMA_CH_NOTSTARTED;
-		omap_free_dma(channels[i]);
-	}
-
-	kfree(channels);
-
-	dma_linked_lch[chain_id].linked_dmach_q = NULL;
-	dma_linked_lch[chain_id].chain_mode = -1;
-	dma_linked_lch[chain_id].chain_state = -1;
-
-	return (0);
-}
-EXPORT_SYMBOL(omap_free_dma_chain);
-
-/**
- * @brief omap_dma_chain_status - Check if the chain is in
- * active / inactive state.
- * @param chain_id
- *
- * @return - Success : OMAP_DMA_CHAIN_ACTIVE/OMAP_DMA_CHAIN_INACTIVE
- * 	     Failure : -EINVAL
- */
-int omap_dma_chain_status(int chain_id)
-{
-	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-	pr_debug("CHAINID=%d, qcnt=%d\n", chain_id,
-			dma_linked_lch[chain_id].q_count);
-
-	if (OMAP_DMA_CHAIN_QEMPTY(chain_id))
-		return OMAP_DMA_CHAIN_INACTIVE;
-
-	return OMAP_DMA_CHAIN_ACTIVE;
-}
-EXPORT_SYMBOL(omap_dma_chain_status);
-
-/**
- * @brief omap_dma_chain_a_transfer - Get a free channel from a chain,
- * set the params and start the transfer.
- *
- * @param chain_id
- * @param src_start - buffer start address
- * @param dest_start - Dest address
- * @param elem_count
- * @param frame_count
- * @param callbk_data - channel callback parameter data.
- *
- * @return  - Success : 0
- * 	      Failure: -EINVAL/-EBUSY
- */
-int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
-			int elem_count, int frame_count, void *callbk_data)
-{
-	int *channels;
-	u32 l, lch;
-	int start_dma = 0;
-
-	/*
-	 * if buffer size is less than 1 then there is
-	 * no use of starting the chain
-	 */
-	if (elem_count < 1) {
-		printk(KERN_ERR "Invalid buffer size\n");
-		return -EINVAL;
-	}
-
-	/* Check for input params */
-	if (unlikely((chain_id < 0
-			|| chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exist\n");
-		return -EINVAL;
-	}
-
-	/* Check if all the channels in chain are in use */
-	if (OMAP_DMA_CHAIN_QFULL(chain_id))
-		return -EBUSY;
-
-	/* Frame count may be negative in case of indexed transfers */
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-
-	/* Get a free channel */
-	lch = channels[dma_linked_lch[chain_id].q_tail];
-
-	/* Store the callback data */
-	dma_chan[lch].data = callbk_data;
-
-	/* Increment the q_tail */
-	OMAP_DMA_CHAIN_INCQTAIL(chain_id);
-
-	/* Set the params to the free channel */
-	if (src_start != 0)
-		p->dma_write(src_start, CSSA, lch);
-	if (dest_start != 0)
-		p->dma_write(dest_start, CDSA, lch);
-
-	/* Write the buffer size */
-	p->dma_write(elem_count, CEN, lch);
-	p->dma_write(frame_count, CFN, lch);
-
-	/*
-	 * If the chain is dynamically linked,
-	 * then we may have to start the chain if its not active
-	 */
-	if (dma_linked_lch[chain_id].chain_mode == OMAP_DMA_DYNAMIC_CHAIN) {
-
-		/*
-		 * In Dynamic chain, if the chain is not started,
-		 * queue the channel
-		 */
-		if (dma_linked_lch[chain_id].chain_state ==
-						DMA_CHAIN_NOTSTARTED) {
-			/* Enable the link in previous channel */
-			if (dma_chan[dma_chan[lch].prev_linked_ch].state ==
-								DMA_CH_QUEUED)
-				enable_lnk(dma_chan[lch].prev_linked_ch);
-			dma_chan[lch].state = DMA_CH_QUEUED;
-		}
-
-		/*
-		 * Chain is already started, make sure its active,
-		 * if not then start the chain
-		 */
-		else {
-			start_dma = 1;
-
-			if (dma_chan[dma_chan[lch].prev_linked_ch].state ==
-							DMA_CH_STARTED) {
-				enable_lnk(dma_chan[lch].prev_linked_ch);
-				dma_chan[lch].state = DMA_CH_QUEUED;
-				start_dma = 0;
-				if (0 == ((1 << 7) & p->dma_read(
-					CCR, dma_chan[lch].prev_linked_ch))) {
-					disable_lnk(dma_chan[lch].
-						    prev_linked_ch);
-					pr_debug("\n prev ch is stopped\n");
-					start_dma = 1;
-				}
-			}
-
-			else if (dma_chan[dma_chan[lch].prev_linked_ch].state
-							== DMA_CH_QUEUED) {
-				enable_lnk(dma_chan[lch].prev_linked_ch);
-				dma_chan[lch].state = DMA_CH_QUEUED;
-				start_dma = 0;
-			}
-			omap_enable_channel_irq(lch);
-
-			l = p->dma_read(CCR, lch);
-
-			if ((0 == (l & (1 << 24))))
-				l &= ~(1 << 25);
-			else
-				l |= (1 << 25);
-			if (start_dma == 1) {
-				if (0 == (l & (1 << 7))) {
-					l |= (1 << 7);
-					dma_chan[lch].state = DMA_CH_STARTED;
-					pr_debug("starting %d\n", lch);
-					p->dma_write(l, CCR, lch);
-				} else
-					start_dma = 0;
-			} else {
-				if (0 == (l & (1 << 7)))
-					p->dma_write(l, CCR, lch);
-			}
-			dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
-		}
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_dma_chain_a_transfer);
-
-/**
- * @brief omap_start_dma_chain_transfers - Start the chain
- *
- * @param chain_id
- *
- * @return - Success : 0
- * 	     Failure : -EINVAL/-EBUSY
- */
-int omap_start_dma_chain_transfers(int chain_id)
-{
-	int *channels;
-	u32 l, i;
-
-	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-
-	if (dma_linked_lch[channels[0]].chain_state == DMA_CHAIN_STARTED) {
-		printk(KERN_ERR "Chain is already started\n");
-		return -EBUSY;
-	}
-
-	if (dma_linked_lch[chain_id].chain_mode == OMAP_DMA_STATIC_CHAIN) {
-		for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked;
-									i++) {
-			enable_lnk(channels[i]);
-			omap_enable_channel_irq(channels[i]);
-		}
-	} else {
-		omap_enable_channel_irq(channels[0]);
-	}
-
-	l = p->dma_read(CCR, channels[0]);
-	l |= (1 << 7);
-	dma_linked_lch[chain_id].chain_state = DMA_CHAIN_STARTED;
-	dma_chan[channels[0]].state = DMA_CH_STARTED;
-
-	if ((0 == (l & (1 << 24))))
-		l &= ~(1 << 25);
-	else
-		l |= (1 << 25);
-	p->dma_write(l, CCR, channels[0]);
-
-	dma_chan[channels[0]].flags |= OMAP_DMA_ACTIVE;
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_start_dma_chain_transfers);
-
-/**
- * @brief omap_stop_dma_chain_transfers - Stop the dma transfer of a chain.
- *
- * @param chain_id
- *
- * @return - Success : 0
- * 	     Failure : EINVAL
- */
-int omap_stop_dma_chain_transfers(int chain_id)
-{
-	int *channels;
-	u32 l, i;
-	u32 sys_cf = 0;
-
-	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-
-	if (IS_DMA_ERRATA(DMA_ERRATA_i88)) {
-		sys_cf = p->dma_read(OCP_SYSCONFIG, 0);
-		l = sys_cf;
-		/* Middle mode reg set no Standby */
-		l &= ~((1 << 12)|(1 << 13));
-		p->dma_write(l, OCP_SYSCONFIG, 0);
-	}
-
-	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
-
-		/* Stop the Channel transmission */
-		l = p->dma_read(CCR, channels[i]);
-		l &= ~(1 << 7);
-		p->dma_write(l, CCR, channels[i]);
-
-		/* Disable the link in all the channels */
-		disable_lnk(channels[i]);
-		dma_chan[channels[i]].state = DMA_CH_NOTSTARTED;
-
-	}
-	dma_linked_lch[chain_id].chain_state = DMA_CHAIN_NOTSTARTED;
-
-	/* Reset the Queue pointers */
-	OMAP_DMA_CHAIN_QINIT(chain_id);
-
-	if (IS_DMA_ERRATA(DMA_ERRATA_i88))
-		p->dma_write(sys_cf, OCP_SYSCONFIG, 0);
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_stop_dma_chain_transfers);
-
-/* Get the index of the ongoing DMA in chain */
-/**
- * @brief omap_get_dma_chain_index - Get the element and frame index
- * of the ongoing DMA in chain
- *
- * @param chain_id
- * @param ei - Element index
- * @param fi - Frame index
- *
- * @return - Success : 0
- * 	     Failure : -EINVAL
- */
-int omap_get_dma_chain_index(int chain_id, int *ei, int *fi)
-{
-	int lch;
-	int *channels;
-
-	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-	if ((!ei) || (!fi))
-		return -EINVAL;
-
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-
-	/* Get the current channel */
-	lch = channels[dma_linked_lch[chain_id].q_head];
-
-	*ei = p->dma_read(CCEN, lch);
-	*fi = p->dma_read(CCFN, lch);
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_get_dma_chain_index);
-
-/**
- * @brief omap_get_dma_chain_dst_pos - Get the destination position of the
- * ongoing DMA in chain
- *
- * @param chain_id
- *
- * @return - Success : Destination position
- * 	     Failure : -EINVAL
- */
-int omap_get_dma_chain_dst_pos(int chain_id)
-{
-	int lch;
-	int *channels;
-
-	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-
-	/* Get the current channel */
-	lch = channels[dma_linked_lch[chain_id].q_head];
-
-	return p->dma_read(CDAC, lch);
-}
-EXPORT_SYMBOL(omap_get_dma_chain_dst_pos);
-
-/**
- * @brief omap_get_dma_chain_src_pos - Get the source position
- * of the ongoing DMA in chain
- * @param chain_id
- *
- * @return - Success : Destination position
- * 	     Failure : -EINVAL
- */
-int omap_get_dma_chain_src_pos(int chain_id)
-{
-	int lch;
-	int *channels;
-
-	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid chain id\n");
-		return -EINVAL;
-	}
-
-	/* Check if the chain exists */
-	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
-		printk(KERN_ERR "Chain doesn't exists\n");
-		return -EINVAL;
-	}
-
-	channels = dma_linked_lch[chain_id].linked_dmach_q;
-
-	/* Get the current channel */
-	lch = channels[dma_linked_lch[chain_id].q_head];
-
-	return p->dma_read(CSAC, lch);
-}
-EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
-#endif	/* ifndef CONFIG_ARCH_OMAP1 */
-
 /*----------------------------------------------------------------------------*/
 
 #ifdef CONFIG_ARCH_OMAP1
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -306,15 +306,12 @@ extern void omap_set_dma_transfer_params(int lch, int data_type,
 					 int elem_count, int frame_count,
 					 int sync_mode,
 					 int dma_trigger, int src_or_dst_synch);
-extern void omap_set_dma_color_mode(int lch, enum omap_dma_color_mode mode,
-				    u32 color);
 extern void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode);
 extern void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode);
 
 extern void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 				    unsigned long src_start,
 				    int src_ei, int src_fi);
-extern void omap_set_dma_src_index(int lch, int eidx, int fidx);
 extern void omap_set_dma_src_data_pack(int lch, int enable);
 extern void omap_set_dma_src_burst_mode(int lch,
 					enum omap_dma_burst_mode burst_mode);
@@ -322,7 +319,6 @@ extern void omap_set_dma_src_burst_mode(int lch,
 extern void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
 				     unsigned long dest_start,
 				     int dst_ei, int dst_fi);
-extern void omap_set_dma_dest_index(int lch, int eidx, int fidx);
 extern void omap_set_dma_dest_data_pack(int lch, int enable);
 extern void omap_set_dma_dest_burst_mode(int lch,
 					 enum omap_dma_burst_mode burst_mode);
@@ -331,52 +327,19 @@ extern void omap_set_dma_params(int lch,
 				struct omap_dma_channel_params *params);
 
 extern void omap_dma_link_lch(int lch_head, int lch_queue);
-extern void omap_dma_unlink_lch(int lch_head, int lch_queue);
 
 extern int omap_set_dma_callback(int lch,
 			void (*callback)(int lch, u16 ch_status, void *data),
 			void *data);
 extern dma_addr_t omap_get_dma_src_pos(int lch);
 extern dma_addr_t omap_get_dma_dst_pos(int lch);
-extern void omap_clear_dma(int lch);
 extern int omap_get_dma_active_status(int lch);
 extern int omap_dma_running(void);
 extern void omap_dma_set_global_params(int arb_rate, int max_fifo_depth,
 				       int tparams);
-extern int omap_dma_set_prio_lch(int lch, unsigned char read_prio,
-				 unsigned char write_prio);
-extern void omap_set_dma_dst_endian_type(int lch, enum end_type etype);
-extern void omap_set_dma_src_endian_type(int lch, enum end_type etype);
-extern int omap_get_dma_index(int lch, int *ei, int *fi);
-
 void omap_dma_global_context_save(void);
 void omap_dma_global_context_restore(void);
 
-extern void omap_dma_disable_irq(int lch);
-
-/* Chaining APIs */
-#ifndef CONFIG_ARCH_OMAP1
-extern int omap_request_dma_chain(int dev_id, const char *dev_name,
-				  void (*callback) (int lch, u16 ch_status,
-						    void *data),
-				  int *chain_id, int no_of_chans,
-				  int chain_mode,
-				  struct omap_dma_channel_params params);
-extern int omap_free_dma_chain(int chain_id);
-extern int omap_dma_chain_a_transfer(int chain_id, int src_start,
-				     int dest_start, int elem_count,
-				     int frame_count, void *callbk_data);
-extern int omap_start_dma_chain_transfers(int chain_id);
-extern int omap_stop_dma_chain_transfers(int chain_id);
-extern int omap_get_dma_chain_index(int chain_id, int *ei, int *fi);
-extern int omap_get_dma_chain_dst_pos(int chain_id);
-extern int omap_get_dma_chain_src_pos(int chain_id);
-
-extern int omap_modify_dma_chain_params(int chain_id,
-					struct omap_dma_channel_params params);
-extern int omap_dma_chain_status(int chain_id);
-#endif
-
 #if defined(CONFIG_ARCH_OMAP1) && IS_ENABLED(CONFIG_FB_OMAP)
 #include <mach/lcd_dma.h>
 #else
