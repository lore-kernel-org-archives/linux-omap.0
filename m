From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 02/25] ARM: common: edma: Remove unused functions
Date: Thu, 24 Sep 2015 13:01:49 +0300
Message-ID: <1443088932-21731-3-git-send-email-peter.ujfalusi@ti.com>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We no longer have users for these functions so they can be removed.
Remove also unused enums from the header file.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/common/edma.c             | 376 -------------------------------------
 include/linux/platform_data/edma.h |  33 ----
 2 files changed, 409 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 56fc339571f9..e9c4cb16a47e 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -510,62 +510,6 @@ static irqreturn_t dma_ccerr_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int reserve_contiguous_slots(int ctlr, unsigned int id,
-				     unsigned int num_slots,
-				     unsigned int start_slot)
-{
-	int i, j;
-	unsigned int count = num_slots;
-	int stop_slot = start_slot;
-	DECLARE_BITMAP(tmp_inuse, EDMA_MAX_PARAMENTRY);
-
-	for (i = start_slot; i < edma_cc[ctlr]->num_slots; ++i) {
-		j = EDMA_CHAN_SLOT(i);
-		if (!test_and_set_bit(j, edma_cc[ctlr]->edma_inuse)) {
-			/* Record our current beginning slot */
-			if (count == num_slots)
-				stop_slot = i;
-
-			count--;
-			set_bit(j, tmp_inuse);
-
-			if (count == 0)
-				break;
-		} else {
-			clear_bit(j, tmp_inuse);
-
-			if (id == EDMA_CONT_PARAMS_FIXED_EXACT) {
-				stop_slot = i;
-				break;
-			} else {
-				count = num_slots;
-			}
-		}
-	}
-
-	/*
-	 * We have to clear any bits that we set
-	 * if we run out parameter RAM slots, i.e we do find a set
-	 * of contiguous parameter RAM slots but do not find the exact number
-	 * requested as we may reach the total number of parameter RAM slots
-	 */
-	if (i == edma_cc[ctlr]->num_slots)
-		stop_slot = i;
-
-	j = start_slot;
-	for_each_set_bit_from(j, tmp_inuse, stop_slot)
-		clear_bit(j, edma_cc[ctlr]->edma_inuse);
-
-	if (count)
-		return -EBUSY;
-
-	for (j = i - num_slots + 1; j <= i; ++j)
-		memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(j),
-			&dummy_paramset, PARM_SIZE);
-
-	return EDMA_CTLR_CHAN(ctlr, i - num_slots + 1);
-}
-
 static int prepare_unused_channel_list(struct device *dev, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -818,186 +762,11 @@ void edma_free_slot(unsigned slot)
 }
 EXPORT_SYMBOL(edma_free_slot);
 
-
-/**
- * edma_alloc_cont_slots- alloc contiguous parameter RAM slots
- * The API will return the starting point of a set of
- * contiguous parameter RAM slots that have been requested
- *
- * @id: can only be EDMA_CONT_PARAMS_ANY or EDMA_CONT_PARAMS_FIXED_EXACT
- * or EDMA_CONT_PARAMS_FIXED_NOT_EXACT
- * @count: number of contiguous Paramter RAM slots
- * @slot  - the start value of Parameter RAM slot that should be passed if id
- * is EDMA_CONT_PARAMS_FIXED_EXACT or EDMA_CONT_PARAMS_FIXED_NOT_EXACT
- *
- * If id is EDMA_CONT_PARAMS_ANY then the API starts looking for a set of
- * contiguous Parameter RAM slots from parameter RAM 64 in the case of
- * DaVinci SOCs and 32 in the case of DA8xx SOCs.
- *
- * If id is EDMA_CONT_PARAMS_FIXED_EXACT then the API starts looking for a
- * set of contiguous parameter RAM slots from the "slot" that is passed as an
- * argument to the API.
- *
- * If id is EDMA_CONT_PARAMS_FIXED_NOT_EXACT then the API initially tries
- * starts looking for a set of contiguous parameter RAMs from the "slot"
- * that is passed as an argument to the API. On failure the API will try to
- * find a set of contiguous Parameter RAM slots from the remaining Parameter
- * RAM slots
- */
-int edma_alloc_cont_slots(unsigned ctlr, unsigned int id, int slot, int count)
-{
-	/*
-	 * The start slot requested should be greater than
-	 * the number of channels and lesser than the total number
-	 * of slots
-	 */
-	if ((id != EDMA_CONT_PARAMS_ANY) &&
-		(slot < edma_cc[ctlr]->num_channels ||
-		slot >= edma_cc[ctlr]->num_slots))
-		return -EINVAL;
-
-	/*
-	 * The number of parameter RAM slots requested cannot be less than 1
-	 * and cannot be more than the number of slots minus the number of
-	 * channels
-	 */
-	if (count < 1 || count >
-		(edma_cc[ctlr]->num_slots - edma_cc[ctlr]->num_channels))
-		return -EINVAL;
-
-	switch (id) {
-	case EDMA_CONT_PARAMS_ANY:
-		return reserve_contiguous_slots(ctlr, id, count,
-						 edma_cc[ctlr]->num_channels);
-	case EDMA_CONT_PARAMS_FIXED_EXACT:
-	case EDMA_CONT_PARAMS_FIXED_NOT_EXACT:
-		return reserve_contiguous_slots(ctlr, id, count, slot);
-	default:
-		return -EINVAL;
-	}
-
-}
-EXPORT_SYMBOL(edma_alloc_cont_slots);
-
-/**
- * edma_free_cont_slots - deallocate DMA parameter RAM slots
- * @slot: first parameter RAM of a set of parameter RAM slots to be freed
- * @count: the number of contiguous parameter RAM slots to be freed
- *
- * This deallocates the parameter RAM slots allocated by
- * edma_alloc_cont_slots.
- * Callers/applications need to keep track of sets of contiguous
- * parameter RAM slots that have been allocated using the edma_alloc_cont_slots
- * API.
- * Callers are responsible for ensuring the slots are inactive, and will
- * not be activated.
- */
-int edma_free_cont_slots(unsigned slot, int count)
-{
-	unsigned ctlr, slot_to_free;
-	int i;
-
-	ctlr = EDMA_CTLR(slot);
-	slot = EDMA_CHAN_SLOT(slot);
-
-	if (slot < edma_cc[ctlr]->num_channels ||
-		slot >= edma_cc[ctlr]->num_slots ||
-		count < 1)
-		return -EINVAL;
-
-	for (i = slot; i < slot + count; ++i) {
-		ctlr = EDMA_CTLR(i);
-		slot_to_free = EDMA_CHAN_SLOT(i);
-
-		memcpy_toio(edmacc_regs_base[ctlr] + PARM_OFFSET(slot_to_free),
-			&dummy_paramset, PARM_SIZE);
-		clear_bit(slot_to_free, edma_cc[ctlr]->edma_inuse);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(edma_free_cont_slots);
-
 /*-----------------------------------------------------------------------*/
 
 /* Parameter RAM operations (i) -- read/write partial slots */
 
 /**
- * edma_set_src - set initial DMA source address in parameter RAM slot
- * @slot: parameter RAM slot being configured
- * @src_port: physical address of source (memory, controller FIFO, etc)
- * @addressMode: INCR, except in very rare cases
- * @fifoWidth: ignored unless @addressMode is FIFO, else specifies the
- *	width to use when addressing the fifo (e.g. W8BIT, W32BIT)
- *
- * Note that the source address is modified during the DMA transfer
- * according to edma_set_src_index().
- */
-void edma_set_src(unsigned slot, dma_addr_t src_port,
-				enum address_mode mode, enum fifo_width width)
-{
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(slot);
-	slot = EDMA_CHAN_SLOT(slot);
-
-	if (slot < edma_cc[ctlr]->num_slots) {
-		unsigned int i = edma_parm_read(ctlr, PARM_OPT, slot);
-
-		if (mode) {
-			/* set SAM and program FWID */
-			i = (i & ~(EDMA_FWID)) | (SAM | ((width & 0x7) << 8));
-		} else {
-			/* clear SAM */
-			i &= ~SAM;
-		}
-		edma_parm_write(ctlr, PARM_OPT, slot, i);
-
-		/* set the source port address
-		   in source register of param structure */
-		edma_parm_write(ctlr, PARM_SRC, slot, src_port);
-	}
-}
-EXPORT_SYMBOL(edma_set_src);
-
-/**
- * edma_set_dest - set initial DMA destination address in parameter RAM slot
- * @slot: parameter RAM slot being configured
- * @dest_port: physical address of destination (memory, controller FIFO, etc)
- * @addressMode: INCR, except in very rare cases
- * @fifoWidth: ignored unless @addressMode is FIFO, else specifies the
- *	width to use when addressing the fifo (e.g. W8BIT, W32BIT)
- *
- * Note that the destination address is modified during the DMA transfer
- * according to edma_set_dest_index().
- */
-void edma_set_dest(unsigned slot, dma_addr_t dest_port,
-				 enum address_mode mode, enum fifo_width width)
-{
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(slot);
-	slot = EDMA_CHAN_SLOT(slot);
-
-	if (slot < edma_cc[ctlr]->num_slots) {
-		unsigned int i = edma_parm_read(ctlr, PARM_OPT, slot);
-
-		if (mode) {
-			/* set DAM and program FWID */
-			i = (i & ~(EDMA_FWID)) | (DAM | ((width & 0x7) << 8));
-		} else {
-			/* clear DAM */
-			i &= ~DAM;
-		}
-		edma_parm_write(ctlr, PARM_OPT, slot, i);
-		/* set the destination port address
-		   in dest register of param structure */
-		edma_parm_write(ctlr, PARM_DST, slot, dest_port);
-	}
-}
-EXPORT_SYMBOL(edma_set_dest);
-
-/**
  * edma_get_position - returns the current transfer point
  * @slot: parameter RAM slot being examined
  * @dst:  true selects the dest position, false the source
@@ -1017,110 +786,6 @@ dma_addr_t edma_get_position(unsigned slot, bool dst)
 }
 
 /**
- * edma_set_src_index - configure DMA source address indexing
- * @slot: parameter RAM slot being configured
- * @src_bidx: byte offset between source arrays in a frame
- * @src_cidx: byte offset between source frames in a block
- *
- * Offsets are specified to support either contiguous or discontiguous
- * memory transfers, or repeated access to a hardware register, as needed.
- * When accessing hardware registers, both offsets are normally zero.
- */
-void edma_set_src_index(unsigned slot, s16 src_bidx, s16 src_cidx)
-{
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(slot);
-	slot = EDMA_CHAN_SLOT(slot);
-
-	if (slot < edma_cc[ctlr]->num_slots) {
-		edma_parm_modify(ctlr, PARM_SRC_DST_BIDX, slot,
-				0xffff0000, src_bidx);
-		edma_parm_modify(ctlr, PARM_SRC_DST_CIDX, slot,
-				0xffff0000, src_cidx);
-	}
-}
-EXPORT_SYMBOL(edma_set_src_index);
-
-/**
- * edma_set_dest_index - configure DMA destination address indexing
- * @slot: parameter RAM slot being configured
- * @dest_bidx: byte offset between destination arrays in a frame
- * @dest_cidx: byte offset between destination frames in a block
- *
- * Offsets are specified to support either contiguous or discontiguous
- * memory transfers, or repeated access to a hardware register, as needed.
- * When accessing hardware registers, both offsets are normally zero.
- */
-void edma_set_dest_index(unsigned slot, s16 dest_bidx, s16 dest_cidx)
-{
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(slot);
-	slot = EDMA_CHAN_SLOT(slot);
-
-	if (slot < edma_cc[ctlr]->num_slots) {
-		edma_parm_modify(ctlr, PARM_SRC_DST_BIDX, slot,
-				0x0000ffff, dest_bidx << 16);
-		edma_parm_modify(ctlr, PARM_SRC_DST_CIDX, slot,
-				0x0000ffff, dest_cidx << 16);
-	}
-}
-EXPORT_SYMBOL(edma_set_dest_index);
-
-/**
- * edma_set_transfer_params - configure DMA transfer parameters
- * @slot: parameter RAM slot being configured
- * @acnt: how many bytes per array (at least one)
- * @bcnt: how many arrays per frame (at least one)
- * @ccnt: how many frames per block (at least one)
- * @bcnt_rld: used only for A-Synchronized transfers; this specifies
- *	the value to reload into bcnt when it decrements to zero
- * @sync_mode: ASYNC or ABSYNC
- *
- * See the EDMA3 documentation to understand how to configure and link
- * transfers using the fields in PaRAM slots.  If you are not doing it
- * all at once with edma_write_slot(), you will use this routine
- * plus two calls each for source and destination, setting the initial
- * address and saying how to index that address.
- *
- * An example of an A-Synchronized transfer is a serial link using a
- * single word shift register.  In that case, @acnt would be equal to
- * that word size; the serial controller issues a DMA synchronization
- * event to transfer each word, and memory access by the DMA transfer
- * controller will be word-at-a-time.
- *
- * An example of an AB-Synchronized transfer is a device using a FIFO.
- * In that case, @acnt equals the FIFO width and @bcnt equals its depth.
- * The controller with the FIFO issues DMA synchronization events when
- * the FIFO threshold is reached, and the DMA transfer controller will
- * transfer one frame to (or from) the FIFO.  It will probably use
- * efficient burst modes to access memory.
- */
-void edma_set_transfer_params(unsigned slot,
-		u16 acnt, u16 bcnt, u16 ccnt,
-		u16 bcnt_rld, enum sync_dimension sync_mode)
-{
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(slot);
-	slot = EDMA_CHAN_SLOT(slot);
-
-	if (slot < edma_cc[ctlr]->num_slots) {
-		edma_parm_modify(ctlr, PARM_LINK_BCNTRLD, slot,
-				0x0000ffff, bcnt_rld << 16);
-		if (sync_mode == ASYNC)
-			edma_parm_and(ctlr, PARM_OPT, slot, ~SYNCDIM);
-		else
-			edma_parm_or(ctlr, PARM_OPT, slot, SYNCDIM);
-		/* Set the acount, bcount, ccount registers */
-		edma_parm_write(ctlr, PARM_A_B_CNT, slot, (bcnt << 16) | acnt);
-		edma_parm_write(ctlr, PARM_CCNT, slot, ccnt);
-	}
-}
-EXPORT_SYMBOL(edma_set_transfer_params);
-
-/**
  * edma_link - link one parameter RAM slot to another
  * @from: parameter RAM slot originating the link
  * @to: parameter RAM slot which is the link target
@@ -1145,26 +810,6 @@ void edma_link(unsigned from, unsigned to)
 }
 EXPORT_SYMBOL(edma_link);
 
-/**
- * edma_unlink - cut link from one parameter RAM slot
- * @from: parameter RAM slot originating the link
- *
- * The originating slot should not be part of any active DMA transfer.
- * Its link is set to 0xffff.
- */
-void edma_unlink(unsigned from)
-{
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(from);
-	from = EDMA_CHAN_SLOT(from);
-
-	if (from >= edma_cc[ctlr]->num_slots)
-		return;
-	edma_parm_or(ctlr, PARM_LINK_BCNTRLD, from, 0xffff);
-}
-EXPORT_SYMBOL(edma_unlink);
-
 /*-----------------------------------------------------------------------*/
 
 /* Parameter RAM operations (ii) -- read/write whole parameter sets */
@@ -1402,27 +1047,6 @@ void edma_clean_channel(unsigned channel)
 EXPORT_SYMBOL(edma_clean_channel);
 
 /*
- * edma_clear_event - clear an outstanding event on the DMA channel
- * Arguments:
- *	channel - channel number
- */
-void edma_clear_event(unsigned channel)
-{
-	unsigned ctlr;
-
-	ctlr = EDMA_CTLR(channel);
-	channel = EDMA_CHAN_SLOT(channel);
-
-	if (channel >= edma_cc[ctlr]->num_channels)
-		return;
-	if (channel < 32)
-		edma_write(ctlr, EDMA_ECR, BIT(channel));
-	else
-		edma_write(ctlr, EDMA_ECRH, BIT(channel - 32));
-}
-EXPORT_SYMBOL(edma_clear_event);
-
-/*
  * edma_assign_channel_eventq - move given channel to desired eventq
  * Arguments:
  *	channel - channel number
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index bdb2710e2aab..c1862423b356 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -72,20 +72,6 @@ struct edmacc_param {
 #define EDMA_DMA_TC1_ERROR 3
 #define EDMA_DMA_TC2_ERROR 4
 
-enum address_mode {
-	INCR = 0,
-	FIFO = 1
-};
-
-enum fifo_width {
-	W8BIT = 0,
-	W16BIT = 1,
-	W32BIT = 2,
-	W64BIT = 3,
-	W128BIT = 4,
-	W256BIT = 5
-};
-
 enum dma_event_q {
 	EVENTQ_0 = 0,
 	EVENTQ_1 = 1,
@@ -94,11 +80,6 @@ enum dma_event_q {
 	EVENTQ_DEFAULT = -1
 };
 
-enum sync_dimension {
-	ASYNC = 0,
-	ABSYNC = 1
-};
-
 #define EDMA_CTLR_CHAN(ctlr, chan)	(((ctlr) << 16) | (chan))
 #define EDMA_CTLR(i)			((i) >> 16)
 #define EDMA_CHAN_SLOT(i)		((i) & 0xffff)
@@ -121,22 +102,9 @@ void edma_free_channel(unsigned channel);
 int edma_alloc_slot(unsigned ctlr, int slot);
 void edma_free_slot(unsigned slot);
 
-/* alloc/free a set of contiguous parameter RAM slots */
-int edma_alloc_cont_slots(unsigned ctlr, unsigned int id, int slot, int count);
-int edma_free_cont_slots(unsigned slot, int count);
-
 /* calls that operate on part of a parameter RAM slot */
-void edma_set_src(unsigned slot, dma_addr_t src_port,
-				enum address_mode mode, enum fifo_width);
-void edma_set_dest(unsigned slot, dma_addr_t dest_port,
-				 enum address_mode mode, enum fifo_width);
 dma_addr_t edma_get_position(unsigned slot, bool dst);
-void edma_set_src_index(unsigned slot, s16 src_bidx, s16 src_cidx);
-void edma_set_dest_index(unsigned slot, s16 dest_bidx, s16 dest_cidx);
-void edma_set_transfer_params(unsigned slot, u16 acnt, u16 bcnt, u16 ccnt,
-		u16 bcnt_rld, enum sync_dimension sync_mode);
 void edma_link(unsigned from, unsigned to);
-void edma_unlink(unsigned from);
 
 /* calls that operate on an entire parameter RAM slot */
 void edma_write_slot(unsigned slot, const struct edmacc_param *params);
@@ -146,7 +114,6 @@ void edma_read_slot(unsigned slot, struct edmacc_param *params);
 int edma_start(unsigned channel);
 void edma_stop(unsigned channel);
 void edma_clean_channel(unsigned channel);
-void edma_clear_event(unsigned channel);
 void edma_pause(unsigned channel);
 void edma_resume(unsigned channel);
 
-- 
2.5.2
