From: Venkatraman S <svenkatr@ti.com>
Subject: [Patch v4] OMAP: sDMA driver: descriptor autoloading feature
Date: Fri, 11 Dec 2009 20:31:34 +0530
Message-ID: <618f0c910912110701p771dcf6fg655bb0a7b9bdc96d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:64347 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758686AbZLKPB2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 10:01:28 -0500
Received: by pwj9 with SMTP id 9so624111pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 07:01:34 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kern

Here is the most updated version of the patch (thanks to Russell's
review). This patch is applicable to OMAP4xxx as well as OMAP3630
Reference to previous posts
v1  http://marc.info/?l=linux-omap&m=125012097403050&w=2
v2  http://marc.info/?l=linux-omap&m=125137152606644&w=2
v3  http://patchwork.kernel.org/patch/45408/

---
From: Venkatraman S <svenkatr@ti.com>
Date: Fri, 11 Dec 2009 19:52:39 +0530
Subject: [PATCH] Omap DMA: Descriptor autoloading feature

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 arch/arm/plat-omap/dma.c              |  299 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/dma.h |  138 +++++++++++++++
 2 files changed, 437 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index be4ce07..76f3871 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/dma-mapping.h>

 #include <asm/system.h>
 #include <mach/hardware.h>
@@ -46,13 +47,42 @@ enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE,
DMA_CH_STARTED,
 enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 #endif

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
 #define OMAP_DMA_ACTIVE			0x01
 #define OMAP_DMA_CCR_EN			(1 << 7)
 #define OMAP2_DMA_CSR_CLEAR_MASK	0xffe

 #define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
+#define OMAP_DMA_INVALID_FRAME_COUNT	(0xffff)
+#define OMAP_DMA_INVALID_ELEM_COUNT	(0xffffff)
+#define OMAP_DMA_INVALID_DESCRIPTOR_POINTER	(0xfffffffc)

 static int enable_1510_mode;
+static int dma_caps0_status;
+
+struct omap_dma_list_config_params {
+	unsigned int num_elem;
+	struct omap_dma_sglist_node *sghead;
+	dma_addr_t sgheadphy;
+	unsigned int pausenode;
+	struct device *ddev;
+};

 static struct omap_dma_global_context_registers {
 	u32 dma_irqenable_l0;
@@ -78,6 +108,8 @@ struct omap_dma_lch {

 	int status;
 #endif
+
+	struct omap_dma_list_config_params *list_config;
 	long flags;
 };

@@ -215,6 +247,28 @@ static void clear_lch_regs(int lch)
 		__raw_writew(0, lch_base + i);
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
 void omap_set_dma_priority(int lch, int dst_port, int priority)
 {
 	unsigned long reg;
@@ -1820,6 +1874,249 @@ EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
 #endif	/* ifndef CONFIG_ARCH_OMAP1 */

 /*----------------------------------------------------------------------------*/
+int omap_request_dma_sglist(struct device *ddev, int dev_id,
+	const char *dev_name, void (*callback) (int channel_id,
+	u16 ch_status, void *data),	int *listid, int nelem,
+	struct omap_dma_sglist_node **elems)
+{
+	struct omap_dma_list_config_params *lcfg;
+	struct omap_dma_sglist_node *desc;
+	int dma_lch;
+	int rc, i;
+
+	if ((dma_caps0_status & DMA_CAPS_SGLIST_SUPPORT) == 0) {
+		printk(KERN_ERR "omap DMA: sglist feature not supported\n");
+		return -EPERM;
+	}
+	if (nelem <= 2) {
+		printk(KERN_ERR "omap DMA: Need >2 elements in the list\n");
+		return -EINVAL;
+	}
+	rc = omap_request_dma(dev_id, dev_name,
+			  callback, NULL, &dma_lch);
+	if (rc < 0) {
+		printk(KERN_ERR "omap DMA: Request failed %d\n", rc);
+		return rc;
+	}
+	*listid = dma_lch;
+	dma_chan[dma_lch].state = DMA_CH_NOTSTARTED;
+	lcfg = kmalloc(sizeof(*lcfg), GFP_KERNEL);
+	if (NULL == lcfg)
+		goto error1;
+	dma_chan[dma_lch].list_config = lcfg;
+
+	lcfg->num_elem = nelem;
+	lcfg->ddev = ddev;
+
+	lcfg->sghead = dma_alloc_coherent(ddev,
+		sizeof(*desc) * nelem, &(lcfg->sgheadphy), 0);
+	if (!lcfg->sghead)
+		goto error1;
+
+	*elems = desc = lcfg->sghead;
+
+	for (i = 1; i < nelem; desc++, i++) {
+		desc->next = desc + 1;
+		desc->next_desc_add_ptr = lcfg->sgheadphy + (i * sizeof(*desc));
+	}
+	desc->next_desc_add_ptr = OMAP_DMA_INVALID_DESCRIPTOR_POINTER;
+
+	dma_write(0, CCDN(dma_lch)); /* Reset List index numbering */
+	/* Initialize frame and element counters to invalid values */
+	dma_write(OMAP_DMA_INVALID_FRAME_COUNT, CCFN(dma_lch));
+	dma_write(OMAP_DMA_INVALID_ELEM_COUNT, CCEN(dma_lch));
+	return 0;
+
+error1:
+	omap_release_dma_sglist(dma_lch);
+	return -ENOMEM;
+
+}
+EXPORT_SYMBOL(omap_request_dma_sglist);
+
+/* The client can choose to not preconfigure the DMA registers
+ * In fast mode,the DMA controller uses the first element in the list to
+ * program the registers first, and then starts the transfer
+ */
+
+int omap_set_dma_sglist_params(int listid,
+	struct omap_dma_channel_params *chparams)
+{
+	struct omap_dma_list_config_params *lcfg;
+	struct omap_dma_sglist_node *sgcurr, *sgprev;
+	struct omap_dma_sglist_node *sghead;
+	int l = DMA_LIST_CDP_LISTMODE; /* Enable Linked list mode in CDP */
+
+	lcfg = dma_chan[listid].list_config;
+	sghead = lcfg->sghead;
+	if (NULL == chparams)
+		l |= DMA_LIST_CDP_FASTMODE;
+	else
+		omap_set_dma_params(listid, chparams);
+		/* The client can set the dma params and still use fast mode
+		 * by using the set fast mode api
+		 */
+	dma_write(l, CDP(listid));
+
+	for (sgprev = sghead;
+		sgprev < sghead + lcfg->num_elem;
+		sgprev++) {
+
+		sgcurr = sgprev + 1;
+
+		switch (sgcurr->desc_type) {
+		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
+			omap_dma_list_set_ntype(sgprev, 1);
+			break;
+
+		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
+			/* intentional no break */
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
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_set_dma_sglist_params);
+
+int omap_start_dma_sglist_transfers(int listid, int pauseafter)
+{
+	struct omap_dma_list_config_params *lcfg;
+	struct omap_dma_sglist_node *sgn;
+	unsigned int l, type_id;
+
+	lcfg = dma_chan[listid].list_config;
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
+	l = dma_read(CDP(listid));
+	l |= type_id;
+	if (lcfg->sghead->flags & OMAP_DMA_LIST_SRC_VALID)
+		l |= DMA_LIST_CDP_SRC_VALID;
+	if (lcfg->sghead->flags & OMAP_DMA_LIST_DST_VALID)
+		l |= DMA_LIST_CDP_DST_VALID;
+
+	dma_write(l, CDP(listid));
+
+	dma_write((lcfg->sgheadphy), CNDP(listid));
+	printk(KERN_DEBUG "Start list transfer for list %x\n",
+		lcfg->sgheadphy);
+	omap_start_dma(listid);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_start_dma_sglist_transfers);
+
+int omap_resume_dma_sglist_transfers(int listid, int pauseafter)
+{
+	struct omap_dma_list_config_params *lcfg;
+	struct omap_dma_sglist_node *sgn;
+	int l;
+
+	lcfg = dma_chan[listid].list_config;
+	sgn = lcfg->sghead;
+
+	/* Clear previous pause and set new value */
+	omap_set_dma_sglist_pausebit(lcfg, lcfg->pausenode, 0);
+	omap_set_dma_sglist_pausebit(lcfg, pauseafter, 1);
+
+	/* Clear pause bit in CDP */
+	l = dma_read(CDP(listid));
+	printk(KERN_DEBUG "Resuming after pause: CDP=%x\n", l);
+	l &= ~(DMA_LIST_CDP_PAUSEMODE);
+	dma_write(l, CDP(listid));
+	omap_start_dma(listid);
+	return 0;
+}
+EXPORT_SYMBOL(omap_resume_dma_sglist_transfers);
+
+int omap_release_dma_sglist(int listid)
+{
+	struct omap_dma_list_config_params *lcfg;
+	struct omap_dma_sglist_node *sgn;
+
+	lcfg = dma_chan[listid].list_config;
+	sgn = lcfg->sghead;
+
+	dma_free_coherent(lcfg->ddev, lcfg->num_elem * sizeof(*sgn),
+		sgn, lcfg->sgheadphy);
+	if (NULL != dma_chan[listid].list_config)
+		kfree(dma_chan[listid].list_config);
+
+	dma_chan[listid].list_config = NULL;
+	omap_free_dma(listid);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_release_dma_sglist);
+
+int omap_get_completed_sglist_nodes(int listid)
+{
+	int list_count;
+
+	list_count = dma_read(CCDN(listid));
+	return list_count & 0xffff; /* only 16 LSB bits are valid */
+}
+EXPORT_SYMBOL(omap_get_completed_sglist_nodes);
+
+int omap_dma_sglist_is_paused(int listid)
+{
+	int list_state;
+
+	list_state = dma_read(CDP(listid));
+	return (list_state & DMA_LIST_CDP_PAUSEMODE) ? 1 : 0;
+}
+EXPORT_SYMBOL(omap_dma_sglist_is_paused);
+
+void omap_dma_set_sglist_fastmode(int listid, int fastmode)
+{
+	int l = dma_read(CDP(listid));
+
+	if (fastmode)
+		l |= DMA_LIST_CDP_FASTMODE;
+	else
+		l &= ~(DMA_LIST_CDP_FASTMODE);
+	dma_write(l, CDP(listid));
+}
+EXPORT_SYMBOL(omap_dma_set_sglist_fastmode);
+

 #ifdef CONFIG_ARCH_OMAP1

@@ -2439,6 +2736,7 @@ static int __init omap_init_dma(void)
 			r = -ENOMEM;
 			goto out_free;
 		}
+		dma_caps0_status = dma_read(CAPS_0);
 	}

 	if (cpu_is_omap15xx()) {
@@ -2490,6 +2788,7 @@ static int __init omap_init_dma(void)
 		omap_clear_dma(ch);
 		dma_chan[ch].dev_id = -1;
 		dma_chan[ch].next_lch = -1;
+		dma_chan[ch].list_config = NULL;

 		if (ch >= 6 && enable_1510_mode)
 			continue;
diff --git a/arch/arm/plat-omap/include/plat/dma.h
b/arch/arm/plat-omap/include/plat/dma.h
index 1c017b2..be128c9 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -21,6 +21,8 @@
 #ifndef __ASM_ARCH_DMA_H
 #define __ASM_ARCH_DMA_H

+#include <linux/device.h>
+
 /* Hardware registers for omap1 */
 #define OMAP1_DMA_BASE			(0xfffed800)

@@ -112,8 +114,12 @@
 #define OMAP1_DMA_COLOR_U(n)		(0x40 * (n) + 0x22)
 #define OMAP1_DMA_CCR2(n)		(0x40 * (n) + 0x24)
 #define OMAP1_DMA_LCH_CTRL(n)		(0x40 * (n) + 0x2a)	/* not on 15xx */
+#define OMAP1_DMA_COLOR(n)		0
 #define OMAP1_DMA_CCEN(n)		0
 #define OMAP1_DMA_CCFN(n)		0
+#define OMAP1_DMA_CDP(n)		0
+#define OMAP1_DMA_CNDP(n)		0
+#define OMAP1_DMA_CCDN(n)		0

 /* Channel specific registers only on omap2 */
 #define OMAP_DMA4_CSSA(n)		(0x60 * (n) + 0x9c)
@@ -132,6 +138,8 @@
 #define OMAP1_DMA_IRQSTATUS_L0		0
 #define OMAP1_DMA_IRQENABLE_L0		0
 #define OMAP1_DMA_OCP_SYSCONFIG		0
+#define OMAP1_DMA_CAPS_0		0
+
 #define OMAP_DMA4_HW_ID			0
 #define OMAP_DMA4_CAPS_0_L		0
 #define OMAP_DMA4_CAPS_0_U		0
@@ -576,6 +584,83 @@ struct omap_dma_channel_params {
 #endif
 };

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
+	#define OMAP_DMA_LIST_SRC_VALID		(1)
+	#define OMAP_DMA_LIST_DST_VALID		(2)
+	#define OMAP_DMA_LIST_NOTIFY_BLOCK_END	(4)
+	enum omap_dma_sglist_descriptor_select desc_type;
+	struct omap_dma_sglist_node *next;
+};

 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
@@ -660,6 +745,59 @@ extern int omap_modify_dma_chain_params(int chain_id,
 					struct omap_dma_channel_params params);
 extern int omap_dma_chain_status(int chain_id);
 #endif
+/* omap_request_dma_sglist:
+ * Request to setup a DMA channel to transfer in linked list mode of nelem
+ * elements. The memory for the list will be allocated and returned in
+ * elems structure
+ */
+extern int omap_request_dma_sglist(struct device *ddev, int dev_id,
+		const char *dev_name, void (*callback) (int channel_id,
+		u16 ch_status, void *data),	int *listid, int nelem,
+		struct omap_dma_sglist_node **elems);
+/* omap_set_dma_sglist_params
+ * Provide the configuration parameters for the sglist channel
+ * sghead should contain a fully populated list of nelems
+ * which completely describe the transfer. chparams, if not NULL, will
+ * set the appropriate parameters directly into the DMA register.
+ * If chparams is NULL, fastmode will be enabled automatically
+ */
+extern int omap_set_dma_sglist_params(const int listid,
+		struct omap_dma_channel_params *chparams);
+/* omap_start_dma_sglist_transfers
+ * Starts the linked list based DMA transfer for the specified listid
+ * If no pause is required, -1 is to be set in pauseafter.
+ * Else, the transfer will suspend after pauseafter elements.
+ */
+extern int omap_start_dma_sglist_transfers(const int listid,
+							const int pauseafter);
+/* omap_resume_dma_sglist_transfers
+ * Resumes the previously paused transfer.
+ * Can be again set to pause at pauseafter node of the linked list
+ * The index is absolute (from the head of the list)
+ */
+extern int omap_resume_dma_sglist_transfers(const int listid,
+							const int pauseafter);
+/* omap_release_dma_sglist
+ * Releases the list based DMA channel and the associated list descriptors
+ */
+extern int omap_release_dma_sglist(const int listid);
+/* omap_get_completed_sglist_nodes
+ * Returns the number of completed elements in the linked list
+ * The value is transient if the API is invoked for an ongoing transfer
+ */
+int omap_get_completed_sglist_nodes(const int listid);
+/* omap_dma_sglist_is_paused
+ * Returns non zero if the linked list is currently in pause state
+ */
+int omap_dma_sglist_is_paused(const int listid);
+/* omap_dma_set_sglist_fastmode
+ * Set or clear the fastmode status of the transfer
+ * In fastmode, DMA register settings are updated from the first element
+ * of the linked list, before initiating the tranfer.
+ * In non-fastmode, the first element is used only after completing the
+ * transfer as already configured in the registers
+ */
+void omap_dma_set_sglist_fastmode(const int listid, const int fastmode);

 /* LCD DMA functions */
 extern int omap_request_lcd_dma(void (*callback)(u16 status, void *data),
-- 
1.5.4.7
