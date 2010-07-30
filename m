From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH resend 11/11] sDMA: descriptor autoloading feature
Date: Fri, 30 Jul 2010 10:16:14 +0530
Message-ID: <1280465174-10928-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55223 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742Ab0G3EsO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Jul 2010 00:48:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Anand Sawant <sawant@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Basak Partha <p-basak2@ti.com>, Charulatha V <charu@ti.com>

From: Venkatraman S <svenkatr@ti.com>

Add sDMA driver support for descriptor autoloading feature.
Descriptor autoloading is OMAP sDMA v5 hardware capability that can be exploited
for scatter gather scenarios, currently available in OMAP3630 and OMAP4430.

The feature works as described below.
1. A sDMA channel is programmed to be in 'linked list' mode.
2) The client (sDMA user) provides a list of descriptors in a linked list format
3) Each of the 'descriptor' (element in the linked list) contains an updated set
of DMA configuration register values.
4) Client starts DMA transfer.
5) sDMA controller loads the first element to its register configuration memory
and executes the transfer.
6) After completion, loads the next element (in linked list) to configuration
memory and executes the transfer, without MCU intervention.
7) Interrupt is generated after all transfers are completed; this can be
configured to be done differently.

Configurations and additional features
1) Fast mode & non-fast mode
Fast mode/non-fast decides on how the first transfer begins. In non-fast mode,
the first element in the linked list is loaded only after completing the
transfer according to the configurations already in the sDMA channel registers.
In fast mode, the loading of the first element precedes the transfer.

2) Pause / resume of transfers
A transfer can be paused after a descriptor set has been loaded, provided the
pause bit' is set in the linked list element.
An ongoing transfer cannot be paused. If the 'pause bit' is set, transfer is not
started after loading the register set from memory.
Such a transfer can be resumed later.

3) Descriptor types
Three possible configurations of descriptors (initialized as linked list
elements) are possible.
Type 1 provides the maximum flexibility, which contains most register
definitions of a DMA logical channel.
Fewer options are present in type 2.
Type 3 can just modify source/destinations address of transfers. In all
transfers, unmodified registers settings are maintained for the next transfer.

Patch provides options / API for
1) Setting up a descriptor loading for DMA channel for sg type transfers
2) configuration with linked list elements
3) Starting / pause and resume of the said transfers, query state
4) Clearing the sglist mode

Signed-off-by: Venkatraman S <svenkatr@ti.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
 arch/arm/mach-omap1/dma.c              |    5 +
 arch/arm/mach-omap1/include/mach/dma.h |    2 +
 arch/arm/mach-omap2/dma.c              |  254 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/dma.h |  194 ++++++++++++++++++++++++
 arch/arm/plat-omap/dma.c               |    1 +
 5 files changed, 456 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index eadc160..1f10f62 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -304,6 +304,11 @@ void omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
 }
 EXPORT_SYMBOL(omap_dma_set_global_params);
 
+void omap_clear_dma_sglist_mode(int lch)
+{
+	return;
+}
+
 static int __init omap1_system_dma_init(void)
 {
 	struct platform_device *pdev;
diff --git a/arch/arm/mach-omap1/include/mach/dma.h b/arch/arm/mach-omap1/include/mach/dma.h
index 1eb0d31..afe486b 100644
--- a/arch/arm/mach-omap1/include/mach/dma.h
+++ b/arch/arm/mach-omap1/include/mach/dma.h
@@ -143,4 +143,6 @@ struct omap_dma_lch {
 	long flags;
 };
 
+/* Dummy function */
+extern void omap_clear_dma_sglist_mode(int lch);
 #endif /* __ASM_ARCH_OMAP1_DMA_H */
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 390c428..c24ed00 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -204,6 +204,77 @@ static void dma_ocpsysconfig_errata(u32 *sys_cf, bool flag)
 		dma_write(*sys_cf, OCP_SYSCONFIG);
 }
 
+static inline void omap_dma_list_set_ntype(struct omap_dma_sglist_node *node,
+					   int value)
+{
+	node->num_of_elem |= ((value) << 29);
+}
+
+static void omap_set_dma_sglist_pausebit(
+		struct omap_dma_list_config_params *lcfg, int nelem, int set)
+{
+	struct omap_dma_sglist_node *sgn = lcfg->sghead;
+
+	if (nelem > 0 && nelem < lcfg->num_elem) {
+		lcfg->pausenode = nelem;
+		sgn += nelem;
+
+		if (set)
+			sgn->next_desc_add_ptr |= DMA_LIST_DESC_PAUSE;
+		else
+			sgn->next_desc_add_ptr &= ~(DMA_LIST_DESC_PAUSE);
+	}
+}
+
+static int dma_sglist_set_phy_params(struct omap_dma_sglist_node *sghead,
+		dma_addr_t phyaddr, int nelem)
+{
+	struct omap_dma_sglist_node *sgcurr, *sgprev;
+	dma_addr_t elem_paddr = phyaddr;
+
+	for (sgprev = sghead;
+		sgprev < sghead + nelem;
+		sgprev++) {
+
+		sgcurr = sgprev + 1;
+		sgprev->next = sgcurr;
+		elem_paddr += (int)sizeof(*sgcurr);
+		sgprev->next_desc_add_ptr = elem_paddr;
+
+		switch (sgcurr->desc_type) {
+		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
+			omap_dma_list_set_ntype(sgprev, 1);
+			break;
+
+		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
+		/* intentional no break */
+		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
+			omap_dma_list_set_ntype(sgprev, 2);
+			break;
+
+		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
+			/* intentional no break */
+		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
+			omap_dma_list_set_ntype(sgprev, 3);
+			break;
+
+		default:
+			return -EINVAL;
+
+		}
+		if (sgcurr->flags & OMAP_DMA_LIST_SRC_VALID)
+			sgprev->num_of_elem |= DMA_LIST_DESC_SRC_VALID;
+		if (sgcurr->flags & OMAP_DMA_LIST_DST_VALID)
+			sgprev->num_of_elem |= DMA_LIST_DESC_DST_VALID;
+		if (sgcurr->flags & OMAP_DMA_LIST_NOTIFY_BLOCK_END)
+			sgprev->num_of_elem |= DMA_LIST_DESC_BLK_END;
+	}
+	sgprev--;
+	sgprev->next_desc_add_ptr = OMAP_DMA_INVALID_DESCRIPTOR_POINTER;
+	return 0;
+}
+
+
 void omap_dma_global_context_save(void)
 {
 	omap_dma_global_context.dma_irqenable_l0 =
@@ -861,6 +932,189 @@ void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
 }
 EXPORT_SYMBOL(omap_set_dma_write_mode);
 
+int omap_set_dma_sglist_mode(int lch, struct omap_dma_sglist_node *sgparams,
+	dma_addr_t padd, int nelem, struct omap_dma_channel_params *chparams)
+{
+	struct omap_dma_list_config_params *lcfg;
+	int l = DMA_LIST_CDP_LISTMODE; /* Enable Linked list mode in CDP */
+
+	if ((dma_caps0_status & DMA_CAPS_SGLIST_SUPPORT) == 0) {
+		printk(KERN_ERR "omap DMA: sglist feature not supported\n");
+		return -EPERM;
+	}
+	if (dma_chan[lch].flags & OMAP_DMA_ACTIVE) {
+		printk(KERN_ERR "omap DMA: configuring active DMA channel\n");
+		return -EPERM;
+	}
+
+	if (padd == 0) {
+		printk(KERN_ERR "omap DMA: sglist invalid dma_addr\n");
+		return -EINVAL;
+	}
+	lcfg = &dma_chan[lch].list_config;
+
+	lcfg->sghead = sgparams;
+	lcfg->num_elem = nelem;
+	lcfg->sgheadphy = padd;
+	lcfg->pausenode = -1;
+
+
+	if (NULL == chparams)
+		l |= DMA_LIST_CDP_FASTMODE;
+	else
+		omap_set_dma_params(lch, chparams);
+
+	dma_write(l, CDP(lch));
+	dma_write(0, CCDN(lch)); /* Reset List index numbering */
+	/* Initialize frame and element counters to invalid values */
+	dma_write(OMAP_DMA_INVALID_FRAME_COUNT, CCFN(lch));
+	dma_write(OMAP_DMA_INVALID_ELEM_COUNT, CCEN(lch));
+
+	return dma_sglist_set_phy_params(sgparams, lcfg->sgheadphy, nelem);
+
+}
+EXPORT_SYMBOL(omap_set_dma_sglist_mode);
+
+void omap_clear_dma_sglist_mode(int lch)
+{
+	/* Clear entire CDP which is related to sglist handling */
+	dma_write(0, CDP(lch));
+	dma_write(0, CCDN(lch));
+	/**
+	 * Put back the original enabled irqs, which
+	 * could have been overwritten by type 1 or type 2
+	 * descriptors
+	 */
+	dma_write(dma_chan[lch].enabled_irqs, CICR(lch));
+	return;
+}
+EXPORT_SYMBOL(omap_clear_dma_sglist_mode);
+
+int omap_start_dma_sglist_transfers(int lch, int pauseafter)
+{
+	struct omap_dma_list_config_params *lcfg;
+	struct omap_dma_sglist_node *sgn;
+	unsigned int l, type_id;
+
+	lcfg = &dma_chan[lch].list_config;
+	sgn = lcfg->sghead;
+
+	lcfg->pausenode = 0;
+	omap_set_dma_sglist_pausebit(lcfg, pauseafter, 1);
+
+	/* Program the head descriptor's properties into CDP */
+	switch (lcfg->sghead->desc_type) {
+	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
+		type_id = DMA_LIST_CDP_TYPE1;
+		break;
+	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
+	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
+		type_id = DMA_LIST_CDP_TYPE2;
+		break;
+	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
+	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
+		type_id = DMA_LIST_CDP_TYPE3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	l = dma_read(CDP(lch));
+	l |= type_id;
+	if (lcfg->sghead->flags & OMAP_DMA_LIST_SRC_VALID)
+		l |= DMA_LIST_CDP_SRC_VALID;
+	if (lcfg->sghead->flags & OMAP_DMA_LIST_DST_VALID)
+		l |= DMA_LIST_CDP_DST_VALID;
+
+	dma_write(l, CDP(lch));
+	dma_write((lcfg->sgheadphy), CNDP(lch));
+	/**
+	 * Barrier needed as writes to the
+	 * descriptor memory needs to be flushed
+	 * before it's used by DMA controller
+	 */
+	wmb();
+	omap_start_dma(lch);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_start_dma_sglist_transfers);
+
+int omap_resume_dma_sglist_transfers(int lch, int pauseafter)
+{
+	struct omap_dma_list_config_params *lcfg;
+	struct omap_dma_sglist_node *sgn;
+	int l, get_sysconfig;
+
+	lcfg = &dma_chan[lch].list_config;
+	sgn = lcfg->sghead;
+
+	/* Maintain the pause state in descriptor */
+	omap_set_dma_sglist_pausebit(lcfg, lcfg->pausenode, 0);
+	omap_set_dma_sglist_pausebit(lcfg, pauseafter, 1);
+
+	/**
+	 * Barrier needed as writes to the
+	 * descriptor memory needs to be flushed
+	 * before it's used by DMA controller
+	 */
+	wmb();
+
+	if (p->errata & DMA_SYSCONFIG_ERRATA)
+		dma_ocpsysconfig_errata(&get_sysconfig, false);
+
+	/* Clear pause bit in CDP */
+	l = dma_read(CDP(lch));
+	l &= ~(DMA_LIST_CDP_PAUSEMODE);
+	dma_write(l, CDP(lch));
+
+	omap_start_dma(lch);
+
+	if (p->errata & DMA_SYSCONFIG_ERRATA)
+		dma_ocpsysconfig_errata(&get_sysconfig, true);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_resume_dma_sglist_transfers);
+
+void omap_release_dma_sglist(int lch)
+{
+	omap_clear_dma_sglist_mode(lch);
+	omap_free_dma(lch);
+
+	return;
+}
+EXPORT_SYMBOL(omap_release_dma_sglist);
+
+int omap_get_completed_sglist_nodes(int lch)
+{
+	int list_count;
+
+	list_count = dma_read(CCDN(lch));
+	return list_count & 0xffff; /* only 16 LSB bits are valid */
+}
+EXPORT_SYMBOL(omap_get_completed_sglist_nodes);
+
+int omap_dma_sglist_is_paused(int lch)
+{
+	int list_state;
+	list_state = dma_read(CDP(lch));
+	return (list_state & DMA_LIST_CDP_PAUSEMODE) ? 1 : 0;
+}
+EXPORT_SYMBOL(omap_dma_sglist_is_paused);
+
+void omap_dma_set_sglist_fastmode(int lch, int fastmode)
+{
+	int l = dma_read(CDP(lch));
+
+	if (fastmode)
+		l |= DMA_LIST_CDP_FASTMODE;
+	else
+		l &= ~(DMA_LIST_CDP_FASTMODE);
+	dma_write(l, CDP(lch));
+}
+EXPORT_SYMBOL(omap_dma_set_sglist_fastmode);
+
 static int omap2_dma_handle_ch(int ch)
 {
 	u32 status = dma_read(CSR(ch));
diff --git a/arch/arm/mach-omap2/include/mach/dma.h b/arch/arm/mach-omap2/include/mach/dma.h
index f3e21d5..e039ea4 100644
--- a/arch/arm/mach-omap2/include/mach/dma.h
+++ b/arch/arm/mach-omap2/include/mach/dma.h
@@ -143,6 +143,112 @@
 #define OMAP_DMA4_GSCR				0
 #define OMAP1_DMA_REVISION			0
 
+/* CDP Register bitmaps */
+#define DMA_LIST_CDP_DST_VALID	(BIT(0))
+#define DMA_LIST_CDP_SRC_VALID	(BIT(2))
+#define DMA_LIST_CDP_TYPE1	(BIT(4))
+#define DMA_LIST_CDP_TYPE2	(BIT(5))
+#define DMA_LIST_CDP_TYPE3	(BIT(4) | BIT(5))
+#define DMA_LIST_CDP_PAUSEMODE	(BIT(7))
+#define DMA_LIST_CDP_LISTMODE	(BIT(8))
+#define DMA_LIST_CDP_FASTMODE	(BIT(10))
+/* CAPS register bitmaps */
+#define DMA_CAPS_SGLIST_SUPPORT	(BIT(20))
+
+#define DMA_LIST_DESC_PAUSE	(BIT(0))
+#define DMA_LIST_DESC_SRC_VALID	(BIT(24))
+#define DMA_LIST_DESC_DST_VALID	(BIT(26))
+#define DMA_LIST_DESC_BLK_END	(BIT(28))
+
+#define OMAP_DMA_INVALID_FRAME_COUNT	(0xffff)
+#define OMAP_DMA_INVALID_ELEM_COUNT	(0xffffff)
+#define OMAP_DMA_INVALID_DESCRIPTOR_POINTER	(0xfffffffc)
+
+struct omap_dma_list_config_params {
+	unsigned int num_elem;
+	struct omap_dma_sglist_node *sghead;
+	dma_addr_t sgheadphy;
+	unsigned int pausenode;
+};
+
+struct omap_dma_sglist_type1_params {
+	u32 src_addr;
+	u32 dst_addr;
+	u16 cfn_fn;
+	u16 cicr;
+	u16 dst_elem_idx;
+	u16 src_elem_idx;
+	u32 dst_frame_idx_or_pkt_size;
+	u32 src_frame_idx_or_pkt_size;
+	u32 color;
+	u32 csdp;
+	u32 clnk_ctrl;
+	u32 ccr;
+};
+
+struct omap_dma_sglist_type2a_params {
+	u32 src_addr;
+	u32 dst_addr;
+	u16 cfn_fn;
+	u16 cicr;
+	u16 dst_elem_idx;
+	u16 src_elem_idx;
+	u32 dst_frame_idx_or_pkt_size;
+	u32 src_frame_idx_or_pkt_size;
+};
+
+struct omap_dma_sglist_type2b_params {
+	u32 src_or_dest_addr;
+	u16 cfn_fn;
+	u16 cicr;
+	u16 dst_elem_idx;
+	u16 src_elem_idx;
+	u32 dst_frame_idx_or_pkt_size;
+	u32 src_frame_idx_or_pkt_size;
+};
+
+struct omap_dma_sglist_type3a_params {
+	u32 src_addr;
+	u32 dst_addr;
+};
+
+struct omap_dma_sglist_type3b_params {
+	u32 src_or_dest_addr;
+};
+
+enum omap_dma_sglist_descriptor_select {
+	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1,
+	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a,
+	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b,
+	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a,
+	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b,
+};
+
+union omap_dma_sglist_node_type{
+	struct omap_dma_sglist_type1_params t1;
+	struct omap_dma_sglist_type2a_params t2a;
+	struct omap_dma_sglist_type2b_params t2b;
+	struct omap_dma_sglist_type3a_params t3a;
+	struct omap_dma_sglist_type3b_params t3b;
+};
+
+struct omap_dma_sglist_node {
+
+	/* Common elements for all descriptors */
+	dma_addr_t next_desc_add_ptr;
+	u32 num_of_elem;
+	/* Type specific elements */
+	union omap_dma_sglist_node_type sg_node;
+	/* Control fields */
+	unsigned short flags;
+	/* Fields that can be set in flags variable */
+	#define OMAP_DMA_LIST_SRC_VALID		BIT(0)
+	#define OMAP_DMA_LIST_DST_VALID		BIT(1)
+	#define OMAP_DMA_LIST_NOTIFY_BLOCK_END	BIT(2)
+	enum omap_dma_sglist_descriptor_select desc_type;
+	struct omap_dma_sglist_node *next;
+};
+
 struct omap_dma_lch {
 	int next_lch;
 	int dev_id;
@@ -158,8 +264,96 @@ struct omap_dma_lch {
 	int state;
 	int chain_id;
 	int status;
+	struct omap_dma_list_config_params list_config;
 };
 
+/**
+ * omap_set_dma_sglist_mode()	Switch channel to scatter gather mode
+ * @lch:	Logical channel to switch to sglist mode
+ * @sghead:	Contains the descriptor elements to be executed
+ *		Should be allocated using dma_alloc_coherent
+ * @padd:	The dma address of sghead, as returned by dma_alloc_coherent
+ * @nelem:	Number of elements in sghead
+ * @chparams:	DMA channel transfer parameters. Can be NULL
+ */
+extern int omap_set_dma_sglist_mode(int lch,
+	struct omap_dma_sglist_node *sghead, dma_addr_t padd,
+	int nelem, struct omap_dma_channel_params *chparams);
+
+/**
+ * omap_clear_dma_sglist_mode()	Switch from scatter gather mode
+ *				to normal mode
+ * @lch:	The logical channel to be switched to normal mode
+ *
+ * Switches the requested logical channel to normal mode
+ * from scatter gather mode
+ */
+extern void omap_clear_dma_sglist_mode(int lch);
+
+/**
+ * omap_start_dma_sglist_transfers()	Starts the sglist transfer
+ * @lch:	logical channel on which sglist transfer to be started
+ * @pauseafter:	index of the element on which to pause the transfer
+ *		set to -1 if no pause is needed till end of transfer
+ *
+ * Start the dma transfer in list mode
+ * The index (in pauseafter) is absolute (from the head of the list)
+ * User should have previously called omap_set_dma_sglist_mode()
+ */
+extern int omap_start_dma_sglist_transfers(int lch, int pauseafter);
+
+/**
+ * omap_resume_dma_sglist_transfers()	Resumes a previously paused
+ *					sglist transfer
+ * @lch:	The logical channel to be resumed
+ * @pauseafter:	The index of sglist to be paused again
+ *		set to -1 if no pause is needed till end of transfer
+ *
+ * Resume the previously paused transfer
+ * The index (in pauseafter) is absolute (from the head of the list)
+ */
+extern int omap_resume_dma_sglist_transfers(int lch, int pauseafter);
+
+/**
+ * omap_release_dma_sglist()	Releases a previously requested
+ *				DMA channel which is in sglist mode
+ * @lch:	The logical channel to be released
+ */
+extern void omap_release_dma_sglist(int lch);
+
+/**
+ * omap_get_completed_sglist_nodes()	Returns a list of completed
+ *					sglist nodes
+ * @lch:	The logical on which the query is to be made
+ *
+ * Returns the number of completed elements in the linked list
+ * The value is transient if the API is invoked for an ongoing transfer
+ */
+int omap_get_completed_sglist_nodes(int lch);
+
+/**
+ * omap_dma_sglist_is_paused()	Query is the logical channel in
+ *				sglist mode is paused or note
+ * @lch:	The logical on which the query is to be made
+ *
+ * Returns non zero if the linked list is currently in pause state
+ */
+int omap_dma_sglist_is_paused(int lch);
+
+/**
+ * omap_dma_set_sglist_fastmode() Set the sglist transfer to fastmode
+ * @lch:	The logical channel which is to be changed to fastmode
+ * @fastmode:	Set or clear the fastmode status
+ *		1 = set fastmode
+ *		0 = clear fastmode
+ *
+ * In fastmode, DMA register settings are updated from the first element
+ * of the linked list, before initiating the tranfer.
+ * In non-fastmode, the first element is used only after completing the
+ * transfer as already configured in the registers
+ */
+void omap_dma_set_sglist_fastmode(int lch, int fastmode);
+
 /* Chaining APIs */
 extern int omap_request_dma_chain(int dev_id, const char *dev_name,
 				  void (*callback) (int lch, u16 ch_status,
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 643f538..daac49c 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -543,6 +543,7 @@ void omap_free_dma(int lch)
 		/* Make sure the DMA transfer is stopped. */
 		dma_write(0, CCR(lch));
 		omap_clear_dma(lch);
+		omap_clear_dma_sglist_mode(lch);
 	}
 
 	spin_lock_irqsave(&dma_chan_lock, flags);
-- 
1.7.0.4

