From: Manjunatha GK <manjugk@ti.com>
Subject: [RFC PATCH 07/10] OMAP2/3/4: DMA: Move chain API's to mach-omap2
Date: Fri,  9 Jul 2010 04:21:19 +0530
Message-ID: <1278629482-32501-8-git-send-email-manjugk@ti.com>
References: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37490 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088Ab0GHWya (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 18:54:30 -0400
In-Reply-To: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

The DMA chaining feature is supported from omap2 plus processors and not
supported in omap1. Moving DMA chain API's to mach-omap2.

Note: Existing DMA chain API's in plat-omap will be cleaned up in another
patch. This make sure that build is not broken with individual patches.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/dma.c              |  663 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/dma.h |   27 ++
 2 files changed, 690 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 548321b..f5fe0f5 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -30,6 +30,59 @@
 #include <plat/omap_device.h>
 #include <plat/dma.h>
 
+#define omap2_dma_read(reg)		__raw_readl(dma_base + reg)
+#define omap2_dma_write(val, reg)	__raw_writel(val, dma_base + reg)
+
+enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE, DMA_CH_STARTED,
+	DMA_CH_QUEUED, DMA_CH_NOTSTARTED, DMA_CH_PAUSED, DMA_CH_LINK_ENABLED
+};
+
+enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
+
+/* Chain handling macros */
+#define OMAP_DMA_CHAIN_QINIT(chain_id)					\
+	do {								\
+		dma_linked_lch[chain_id].q_head =			\
+		dma_linked_lch[chain_id].q_tail =			\
+		dma_linked_lch[chain_id].q_count = 0;			\
+	} while (0)
+#define OMAP_DMA_CHAIN_QFULL(chain_id)					\
+		(dma_linked_lch[chain_id].no_of_lchs_linked ==		\
+		dma_linked_lch[chain_id].q_count)
+#define OMAP_DMA_CHAIN_QLAST(chain_id)					\
+	do {								\
+		((dma_linked_lch[chain_id].no_of_lchs_linked-1) ==	\
+		dma_linked_lch[chain_id].q_count)			\
+	} while (0)
+#define OMAP_DMA_CHAIN_QEMPTY(chain_id)					\
+		(0 == dma_linked_lch[chain_id].q_count)
+#define __OMAP_DMA_CHAIN_INCQ(end)					\
+	((end) = ((end)+1) % dma_linked_lch[chain_id].no_of_lchs_linked)
+#define OMAP_DMA_CHAIN_INCQHEAD(chain_id)				\
+	do {								\
+		__OMAP_DMA_CHAIN_INCQ(dma_linked_lch[chain_id].q_head);	\
+		dma_linked_lch[chain_id].q_count--;			\
+	} while (0)
+
+#define OMAP_DMA_CHAIN_INCQTAIL(chain_id)				\
+	do {								\
+		__OMAP_DMA_CHAIN_INCQ(dma_linked_lch[chain_id].q_tail);	\
+		dma_linked_lch[chain_id].q_count++; \
+	} while (0)
+
+struct dma_link_info {
+	int *linked_dmach_q;
+	int no_of_lchs_linked;
+
+	int q_count;
+	int q_tail;
+	int q_head;
+
+	int chain_state;
+	int chain_mode;
+
+};
+
 struct omap_device_pm_latency omap2_dma_latency[] = {
 	{
 	.deactivate_func = omap_device_idle_hwmods,
@@ -81,6 +134,616 @@ static void __iomem *dma_base;
 static struct dma_link_info *dma_linked_lch;
 static u32 dma_chan_count;
 
+/* Create chain of DMA channesls */
+static void create_dma_lch_chain(int lch_head, int lch_queue)
+{
+	u32 reg, ch_reg_base, l;
+
+	/* Check if this is the first link in chain */
+	if (dma_chan[lch_head].next_linked_ch == -1) {
+		dma_chan[lch_head].next_linked_ch = lch_queue;
+		dma_chan[lch_head].prev_linked_ch = lch_queue;
+		dma_chan[lch_queue].next_linked_ch = lch_head;
+		dma_chan[lch_queue].prev_linked_ch = lch_head;
+	}
+
+	/* a link exists, link the new channel in circular chain */
+	else {
+		dma_chan[lch_queue].next_linked_ch =
+					dma_chan[lch_head].next_linked_ch;
+		dma_chan[lch_queue].prev_linked_ch = lch_head;
+		dma_chan[lch_head].next_linked_ch = lch_queue;
+		dma_chan[dma_chan[lch_queue].next_linked_ch].
+					prev_linked_ch = lch_queue;
+	}
+
+	ch_reg_base = r->lch_base * lch_head;
+	reg = ch_reg_base + r->common_ch.clnk_ctrl;
+	l = omap2_dma_read(reg);
+	l &= ~(0x1f);
+	l |= lch_queue;
+	omap2_dma_write(l, reg);
+
+	ch_reg_base = r->lch_base * lch_queue;
+	reg = ch_reg_base + r->common_ch.clnk_ctrl;
+	l = omap2_dma_read(reg);
+	l &= ~(0x1f);
+	l |= (dma_chan[lch_queue].next_linked_ch);
+	omap2_dma_write(l, reg);
+}
+
+/**
+ * @brief omap_request_dma_chain : Request a chain of DMA channels
+ *
+ * @param dev_id - Device id using the dma channel
+ * @param dev_name - Device name
+ * @param callback - Call back function
+ * @chain_id -
+ * @no_of_chans - Number of channels requested
+ * @chain_mode - Dynamic or static chaining : OMAP_DMA_STATIC_CHAIN
+ *					OMAP_DMA_DYNAMIC_CHAIN
+ * @params - Channel parameters
+ *
+ * @return -	Success : 0
+ *		Failure: -EINVAL/-ENOMEM
+ */
+int omap_request_dma_chain(int dev_id, const char *dev_name,
+				void (*callback) (int lch, u16 ch_status,
+						void *data),
+				int *chain_id, int no_of_chans, int chain_mode,
+				struct omap_dma_channel_params params)
+{
+	int *channels;
+	int i, err;
+
+	/* Is the chain mode valid ? */
+	if (chain_mode != OMAP_DMA_STATIC_CHAIN
+			&& chain_mode != OMAP_DMA_DYNAMIC_CHAIN) {
+		printk(KERN_ERR "Invalid chain mode requested\n");
+		return -EINVAL;
+	}
+
+	if (unlikely((no_of_chans < 1
+			|| no_of_chans > d->dma_lch_count))) {
+		printk(KERN_ERR "Invalid Number of channels requested\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Allocate a queue to maintain the status of the channels
+	 * in the chain
+	 */
+	channels = kmalloc(sizeof(*channels) * no_of_chans, GFP_KERNEL);
+	if (channels == NULL) {
+		printk(KERN_ERR "omap_dma: No memory for channel queue\n");
+		return -ENOMEM;
+	}
+
+	/* request and reserve DMA channels for the chain */
+	for (i = 0; i < no_of_chans; i++) {
+		err = omap_request_dma(dev_id, dev_name,
+					callback, NULL, &channels[i]);
+		if (err < 0) {
+			int j;
+			for (j = 0; j < i; j++)
+				omap_free_dma(channels[j]);
+			kfree(channels);
+			printk(KERN_ERR "omap_dma: Request failed %d\n", err);
+			return err;
+		}
+		dma_chan[channels[i]].prev_linked_ch = -1;
+		dma_chan[channels[i]].state = DMA_CH_NOTSTARTED;
+
+		/*
+		 * Allowing client drivers to set common parameters now,
+		 * so that later only relevant (src_start, dest_start
+		 * and element count) can be set
+		 */
+		omap_set_dma_params(channels[i], &params);
+	}
+
+	*chain_id = channels[0];
+	dma_linked_lch[*chain_id].linked_dmach_q = channels;
+	dma_linked_lch[*chain_id].chain_mode = chain_mode;
+	dma_linked_lch[*chain_id].chain_state = DMA_CHAIN_NOTSTARTED;
+	dma_linked_lch[*chain_id].no_of_lchs_linked = no_of_chans;
+
+	for (i = 0; i < no_of_chans; i++)
+		dma_chan[channels[i]].chain_id = *chain_id;
+
+	/* Reset the Queue pointers */
+	OMAP_DMA_CHAIN_QINIT(*chain_id);
+
+	/* Set up the chain */
+	if (no_of_chans == 1)
+		create_dma_lch_chain(channels[0], channels[0]);
+	else {
+		for (i = 0; i < (no_of_chans - 1); i++)
+			create_dma_lch_chain(channels[i], channels[i + 1]);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_request_dma_chain);
+
+/**
+ * @brief omap_modify_dma_chain_param : Modify the chain's params - Modify the
+ * params after setting it. Dont do this while dma is running!!
+ *
+ * @param chain_id - Chained logical channel id.
+ * @param params
+ *
+ * @return -	Success : 0
+ *		Failure : -EINVAL
+ */
+int omap_modify_dma_chain_params(int chain_id,
+				struct omap_dma_channel_params params)
+{
+	int *channels;
+	u32 i;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0
+			|| chain_id >= d->dma_lch_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+
+	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
+		/*
+		 * Allowing client drivers to set common parameters now,
+		 * so that later only relevant (src_start, dest_start
+		 * and element count) can be set
+		 */
+		omap_set_dma_params(channels[i], &params);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_modify_dma_chain_params);
+
+/**
+ * @brief omap_free_dma_chain - Free all the logical channels in a chain.
+ *
+ * @param chain_id
+ *
+ * @return -	Success : 0
+ *		Failure : -EINVAL
+ */
+int omap_free_dma_chain(int chain_id)
+{
+	int *channels;
+	u32 i;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >= d->dma_lch_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+	for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked; i++) {
+		dma_chan[channels[i]].next_linked_ch = -1;
+		dma_chan[channels[i]].prev_linked_ch = -1;
+		dma_chan[channels[i]].chain_id = -1;
+		dma_chan[channels[i]].state = DMA_CH_NOTSTARTED;
+		omap_free_dma(channels[i]);
+	}
+
+	kfree(channels);
+
+	dma_linked_lch[chain_id].linked_dmach_q = NULL;
+	dma_linked_lch[chain_id].chain_mode = -1;
+	dma_linked_lch[chain_id].chain_state = -1;
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_free_dma_chain);
+
+/**
+ * @brief omap_dma_chain_status - Check if the chain is in
+ * active / inactive state.
+ * @param chain_id
+ *
+ * @return -	Success : OMAP_DMA_CHAIN_ACTIVE/OMAP_DMA_CHAIN_INACTIVE
+ *		Failure : -EINVAL
+ */
+int omap_dma_chain_status(int chain_id)
+{
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >= d->dma_lch_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	pr_debug("CHAINID=%d, qcnt=%d\n", chain_id,
+			dma_linked_lch[chain_id].q_count);
+
+	if (OMAP_DMA_CHAIN_QEMPTY(chain_id))
+		return OMAP_DMA_CHAIN_INACTIVE;
+
+	return OMAP_DMA_CHAIN_ACTIVE;
+}
+EXPORT_SYMBOL(omap_dma_chain_status);
+
+/**
+ * @brief omap_dma_chain_a_transfer - Get a free channel from a chain,
+ * set the params and start the transfer.
+ *
+ * @param chain_id
+ * @param src_start - buffer start address
+ * @param dest_start - Dest address
+ * @param elem_count
+ * @param frame_count
+ * @param callbk_data - channel callback parameter data.
+ *
+ * @return  -	Success : 0
+ *		Failure: -EINVAL/-EBUSY
+ */
+int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
+			int elem_count, int frame_count, void *callbk_data)
+{
+	int *channels;
+	u32 reg, ch_reg_base, l, lch;
+	int start_dma = 0;
+
+	/*
+	 * if buffer size is less than 1 then there is
+	 * no use of starting the chain
+	 */
+	if (elem_count < 1) {
+		printk(KERN_ERR "Invalid buffer size\n");
+		return -EINVAL;
+	}
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0
+			|| chain_id >= d->dma_lch_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exist\n");
+		return -EINVAL;
+	}
+
+	/* Check if all the channels in chain are in use */
+	if (OMAP_DMA_CHAIN_QFULL(chain_id))
+		return -EBUSY;
+
+	/* Frame count may be negative in case of indexed transfers */
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get a free channel */
+	lch = channels[dma_linked_lch[chain_id].q_tail];
+
+	/* Store the callback data */
+	dma_chan[lch].data = callbk_data;
+
+	/* Increment the q_tail */
+	OMAP_DMA_CHAIN_INCQTAIL(chain_id);
+
+	ch_reg_base = r->lch_base * lch;
+	/* Set the params to the free channel */
+	if (src_start != 0) {
+		reg = ch_reg_base + r->ch_specific.cssa;
+		omap2_dma_write(src_start, reg);
+	}
+	if (dest_start != 0) {
+		reg = ch_reg_base + r->ch_specific.cdsa;
+		omap2_dma_write(src_start, reg);
+	}
+
+	/* Write the buffer size */
+	reg = ch_reg_base + r->common_ch.cen;
+	omap2_dma_write(elem_count, reg);
+	reg = ch_reg_base + r->common_ch.cfn;
+	omap2_dma_write(frame_count, reg);
+
+	/*
+	 * If the chain is dynamically linked,
+	 * then we may have to start the chain if its not active
+	 */
+	if (dma_linked_lch[chain_id].chain_mode == OMAP_DMA_DYNAMIC_CHAIN) {
+
+		/*
+		 * In Dynamic chain, if the chain is not started,
+		 * queue the channel
+		 */
+		if (dma_linked_lch[chain_id].chain_state ==
+						DMA_CHAIN_NOTSTARTED) {
+			/* Enable the link in previous channel */
+			if (dma_chan[dma_chan[lch].prev_linked_ch].state ==
+								DMA_CH_QUEUED)
+				omap_enable_lnk(dma_chan[lch].prev_linked_ch);
+			dma_chan[lch].state = DMA_CH_QUEUED;
+		}
+
+		/*
+		 * Chain is already started, make sure its active,
+		 * if not then start the chain
+		 */
+		else {
+			start_dma = 1;
+
+			if (dma_chan[dma_chan[lch].prev_linked_ch].state ==
+							DMA_CH_STARTED) {
+				ch_reg_base = r->lch_base *
+						dma_chan[lch].prev_linked_ch;
+
+				omap_enable_lnk(dma_chan[lch].prev_linked_ch);
+				dma_chan[lch].state = DMA_CH_QUEUED;
+				start_dma = 0;
+				reg = ch_reg_base + r->common_ch.ccr;
+				if (0 == ((1 << 7) & omap2_dma_read(reg))) {
+					omap_disable_lnk(dma_chan[lch].
+						    prev_linked_ch);
+					pr_debug("\n prev ch is stopped\n");
+					start_dma = 1;
+				}
+			}
+
+			else if (dma_chan[dma_chan[lch].prev_linked_ch].state
+							== DMA_CH_QUEUED) {
+				omap_enable_lnk(dma_chan[lch].prev_linked_ch);
+				dma_chan[lch].state = DMA_CH_QUEUED;
+				start_dma = 0;
+			}
+			omap_enable_channel_irq(lch);
+			ch_reg_base = r->lch_base * lch;
+			reg = ch_reg_base + r->common_ch.ccr;
+			l = omap2_dma_read(reg);
+
+			if ((0 == (l & (1 << 24))))
+				l &= ~(1 << 25);
+			else
+				l |= (1 << 25);
+			if (start_dma == 1) {
+				if (0 == (l & (1 << 7))) {
+					l |= (1 << 7);
+					dma_chan[lch].state = DMA_CH_STARTED;
+					pr_debug("starting %d\n", lch);
+					omap2_dma_write(l, reg);
+				} else
+					start_dma = 0;
+			} else {
+				if (0 == (l & (1 << 7)))
+					omap2_dma_write(l, reg);
+			}
+			dma_chan[lch].flags |= OMAP_DMA_ACTIVE;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_dma_chain_a_transfer);
+
+/**
+ * @brief omap_start_dma_chain_transfers - Start the chain
+ *
+ * @param chain_id
+ *
+ * @return -	Success : 0
+ *		Failure : -EINVAL/-EBUSY
+ */
+int omap_start_dma_chain_transfers(int chain_id)
+{
+	int *channels;
+	u32 reg, ch_reg_base, l, i;
+
+	if (unlikely((chain_id < 0 || chain_id >= d->dma_lch_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+
+	if (dma_linked_lch[channels[0]].chain_state == DMA_CHAIN_STARTED) {
+		printk(KERN_ERR "Chain is already started\n");
+		return -EBUSY;
+	}
+
+	if (dma_linked_lch[chain_id].chain_mode == OMAP_DMA_STATIC_CHAIN) {
+		for (i = 0; i < dma_linked_lch[chain_id].no_of_lchs_linked;
+									i++) {
+			omap_enable_lnk(channels[i]);
+			omap_enable_channel_irq(channels[i]);
+		}
+	} else {
+		omap_enable_channel_irq(channels[0]);
+	}
+
+	ch_reg_base = r->lch_base * channels[0];
+	reg = ch_reg_base + r->common_ch.ccr;
+	l = omap2_dma_read(reg);
+	l |= (1 << 7);
+	dma_linked_lch[chain_id].chain_state = DMA_CHAIN_STARTED;
+	dma_chan[channels[0]].state = DMA_CH_STARTED;
+
+	if ((0 == (l & (1 << 24))))
+		l &= ~(1 << 25);
+	else
+		l |= (1 << 25);
+	omap2_dma_write(l, reg);
+
+	dma_chan[channels[0]].flags |= OMAP_DMA_ACTIVE;
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_start_dma_chain_transfers);
+
+
+/**
+ * @brief omap_stop_dma_chain_transfers - Stop the dma transfer of a chain.
+ *
+ * @param chain_id
+ *
+ * @return -	Success : 0
+ *		Failure : EINVAL
+ */
+int omap_stop_dma_chain_transfers(int chain_id)
+{
+	/* Check for input params */
+	if (unlikely((chain_id < 0 ||
+		chain_id >= d->dma_lch_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+
+	if (omap2_pdata->errata & DMA_SYSCONFIG_ERRATA)
+		dma_ocpsysconfig_errata(chain_id);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_stop_dma_chain_transfers);
+
+/* Get the index of the ongoing DMA in chain */
+/**
+ * @brief omap_get_dma_chain_index - Get the element and frame index
+ * of the ongoing DMA in chain
+ *
+ * @param chain_id
+ * @param ei - Element index
+ * @param fi - Frame index
+ *
+ * @return -	Success : 0
+ *		Failure : -EINVAL
+ */
+int omap_get_dma_chain_index(int chain_id, int *ei, int *fi)
+{
+	int lch;
+	int *channels;
+	u32 reg;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 ||
+		chain_id >= d->dma_lch_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+	if ((!ei) || (!fi))
+		return -EINVAL;
+
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get the current channel */
+	lch = channels[dma_linked_lch[chain_id].q_head];
+
+	reg = (r->lch_base * lch) + r->ch_specific.ccen;
+	*ei = omap2_dma_read(reg);
+	reg = (r->lch_base * lch) + r->ch_specific.ccfn;
+	*fi = omap2_dma_read(reg);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_get_dma_chain_index);
+
+/**
+ * @brief omap_get_dma_chain_dst_pos - Get the destination position of the
+ * ongoing DMA in chain
+ *
+ * @param chain_id
+ *
+ * @return -	Success : Destination position
+ *		Failure : -EINVAL
+ */
+int omap_get_dma_chain_dst_pos(int chain_id)
+{
+	int lch;
+	int *channels;
+	u32 reg;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >= d->dma_lch_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get the current channel */
+	lch = channels[dma_linked_lch[chain_id].q_head];
+	reg = (r->lch_base * lch) + r->common_ch.cdac;
+
+	return omap2_dma_read(reg);
+}
+EXPORT_SYMBOL(omap_get_dma_chain_dst_pos);
+
+/**
+ * @brief omap_get_dma_chain_src_pos - Get the source position
+ * of the ongoing DMA in chain
+ * @param chain_id
+ *
+ * @return -	Success : Destination position
+ *		Failure : -EINVAL
+ */
+int omap_get_dma_chain_src_pos(int chain_id)
+{
+	int lch;
+	int *channels;
+	u32 reg;
+
+	/* Check for input params */
+	if (unlikely((chain_id < 0 || chain_id >= d->dma_lch_count))) {
+		printk(KERN_ERR "Invalid chain id\n");
+		return -EINVAL;
+	}
+
+	/* Check if the chain exists */
+	if (dma_linked_lch[chain_id].linked_dmach_q == NULL) {
+		printk(KERN_ERR "Chain doesn't exists\n");
+		return -EINVAL;
+	}
+
+	channels = dma_linked_lch[chain_id].linked_dmach_q;
+
+	/* Get the current channel */
+	lch = channels[dma_linked_lch[chain_id].q_head];
+	reg = (r->lch_base * lch) + r->common_ch.csac;
+
+	return omap2_dma_read(reg);
+}
+EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
+
 /* One time initializations */
 static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *user)
 {
diff --git a/arch/arm/mach-omap2/include/mach/dma.h b/arch/arm/mach-omap2/include/mach/dma.h
index a8d8fee..c7a67b3 100644
--- a/arch/arm/mach-omap2/include/mach/dma.h
+++ b/arch/arm/mach-omap2/include/mach/dma.h
@@ -73,4 +73,31 @@
 #define OMAP_DMA4_CNDP			(0xd4)
 #define OMAP_DMA4_CCDN			(0xd8)
 
+/* Chaining modes*/
+#define OMAP_DMA_STATIC_CHAIN		0x1
+#define OMAP_DMA_DYNAMIC_CHAIN		0x2
+#define OMAP_DMA_CHAIN_ACTIVE		0x1
+#define OMAP_DMA_CHAIN_INACTIVE		0x0
+
+/* Chaining APIs */
+extern int omap_request_dma_chain(int dev_id, const char *dev_name,
+				  void (*callback) (int lch, u16 ch_status,
+						    void *data),
+				  int *chain_id, int no_of_chans,
+				  int chain_mode,
+				  struct omap_dma_channel_params params);
+extern int omap_free_dma_chain(int chain_id);
+extern int omap_dma_chain_a_transfer(int chain_id, int src_start,
+				     int dest_start, int elem_count,
+				     int frame_count, void *callbk_data);
+extern int omap_start_dma_chain_transfers(int chain_id);
+extern int omap_stop_dma_chain_transfers(int chain_id);
+extern int omap_get_dma_chain_index(int chain_id, int *ei, int *fi);
+extern int omap_get_dma_chain_dst_pos(int chain_id);
+extern int omap_get_dma_chain_src_pos(int chain_id);
+
+extern int omap_modify_dma_chain_params(int chain_id,
+					struct omap_dma_channel_params params);
+extern int omap_dma_chain_status(int chain_id);
+
 #endif /* __ASM_ARCH_OMAP2_DMA_H */
-- 
1.7.0.4

