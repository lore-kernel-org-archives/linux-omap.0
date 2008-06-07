From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/21] ARM: OMAP: DMA: Make channels dynamic for multi-boot
Date: Fri,  6 Jun 2008 18:30:36 -0700
Message-ID: <1212802253-17797-5-git-send-email-tony@atomide.com>
References: omap-upstream-2008-06-06-183049
 <1212802253-17797-1-git-send-email-tony@atomide.com>
 <1212802253-17797-2-git-send-email-tony@atomide.com>
 <1212802253-17797-3-git-send-email-tony@atomide.com>
 <1212802253-17797-4-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55264 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765128AbYFGBbD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 21:31:03 -0400
In-Reply-To: <1212802253-17797-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Make DMA channels dynamic for multi-boot

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 39c637b..02f00a9 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -72,7 +72,6 @@ struct omap_dma_lch {
 	long flags;
 };
 
-#ifndef CONFIG_ARCH_OMAP1
 struct dma_link_info {
 	int *linked_dmach_q;
 	int no_of_lchs_linked;
@@ -86,7 +85,9 @@ struct dma_link_info {
 
 };
 
-static struct dma_link_info dma_linked_lch[OMAP_LOGICAL_DMA_CH_COUNT];
+static struct dma_link_info *dma_linked_lch;
+
+#ifndef CONFIG_ARCH_OMAP1
 
 /* Chain handling macros */
 #define OMAP_DMA_CHAIN_QINIT(chain_id)					\
@@ -119,12 +120,14 @@ static struct dma_link_info dma_linked_lch[OMAP_LOGICAL_DMA_CH_COUNT];
 		dma_linked_lch[chain_id].q_count++; \
 	} while (0)
 #endif
+
+static int dma_lch_count;
 static int dma_chan_count;
 
 static spinlock_t dma_chan_lock;
-static struct omap_dma_lch dma_chan[OMAP_LOGICAL_DMA_CH_COUNT];
+static struct omap_dma_lch *dma_chan;
 
-static const u8 omap1_dma_irq[OMAP_LOGICAL_DMA_CH_COUNT] = {
+static const u8 omap1_dma_irq[OMAP1_LOGICAL_DMA_CH_COUNT] = {
 	INT_DMA_CH0_6, INT_DMA_CH1_7, INT_DMA_CH2_8, INT_DMA_CH3,
 	INT_DMA_CH4, INT_DMA_CH5, INT_1610_DMA_CH6, INT_1610_DMA_CH7,
 	INT_1610_DMA_CH8, INT_1610_DMA_CH9, INT_1610_DMA_CH10,
@@ -727,7 +730,7 @@ omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 {
 	u32 w;
 
-	if (unlikely((lch < 0 || lch >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((lch < 0 || lch >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid channel id\n");
 		return -EINVAL;
 	}
@@ -775,7 +778,7 @@ void omap_start_dma(int lch)
 {
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
-		char dma_chan_link_map[OMAP_LOGICAL_DMA_CH_COUNT];
+		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
 
 		dma_chan_link_map[lch] = 1;
 		/* Set the link register of the first channel */
@@ -819,7 +822,7 @@ void omap_stop_dma(int lch)
 {
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
-		char dma_chan_link_map[OMAP_LOGICAL_DMA_CH_COUNT];
+		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
 
 		memset(dma_chan_link_map, 0, sizeof(dma_chan_link_map));
 		do {
@@ -1061,7 +1064,7 @@ int omap_request_dma_chain(int dev_id, const char *dev_name,
 	}
 
 	if (unlikely((no_of_chans < 1
-			|| no_of_chans > OMAP_LOGICAL_DMA_CH_COUNT))) {
+			|| no_of_chans > dma_lch_count))) {
 		printk(KERN_ERR "Invalid Number of channels requested\n");
 		return -EINVAL;
 	}
@@ -1138,7 +1141,7 @@ int omap_modify_dma_chain_params(int chain_id,
 
 	/* Check for input params */
 	if (unlikely((chain_id < 0
-			|| chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+			|| chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1176,7 +1179,7 @@ int omap_free_dma_chain(int chain_id)
 	u32 i;
 
 	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1216,7 +1219,7 @@ EXPORT_SYMBOL(omap_free_dma_chain);
 int omap_dma_chain_status(int chain_id)
 {
 	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1265,7 +1268,7 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 
 	/* Check for input params */
 	if (unlikely((chain_id < 0
-			|| chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+			|| chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1382,7 +1385,7 @@ int omap_start_dma_chain_transfers(int chain_id)
 	int *channels;
 	u32 w, i;
 
-	if (unlikely((chain_id < 0 || chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1435,7 +1438,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	u32 sys_cf;
 
 	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1497,7 +1500,7 @@ int omap_get_dma_chain_index(int chain_id, int *ei, int *fi)
 	int *channels;
 
 	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1537,7 +1540,7 @@ int omap_get_dma_chain_dst_pos(int chain_id)
 	int *channels;
 
 	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1571,7 +1574,7 @@ int omap_get_dma_chain_src_pos(int chain_id)
 	int *channels;
 
 	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1724,7 +1727,7 @@ static irqreturn_t omap2_dma_irq_handler(int irq, void *dev_id)
 			printk(KERN_WARNING "Spurious DMA IRQ\n");
 		return IRQ_HANDLED;
 	}
-	for (i = 0; i < OMAP_LOGICAL_DMA_CH_COUNT && val != 0; i++) {
+	for (i = 0; i < dma_lch_count && val != 0; i++) {
 		if (val & 1)
 			omap2_dma_handle_ch(i);
 		val >>= 1;
@@ -2106,6 +2109,25 @@ static int __init omap_init_dma(void)
 {
 	int ch, r;
 
+	if (cpu_class_is_omap1())
+		dma_lch_count = OMAP1_LOGICAL_DMA_CH_COUNT;
+	else
+		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
+
+	dma_chan = kzalloc(sizeof(struct omap_dma_lch) * dma_lch_count,
+				GFP_KERNEL);
+	if (!dma_chan)
+		return -ENOMEM;
+
+	if (cpu_class_is_omap2()) {
+		dma_linked_lch = kzalloc(sizeof(struct dma_link_info) *
+						dma_lch_count, GFP_KERNEL);
+		if (!dma_linked_lch) {
+			kfree(dma_chan);
+			return -ENOMEM;
+		}
+	}
+
 	if (cpu_is_omap15xx()) {
 		printk(KERN_INFO "DMA support for OMAP15xx initialized\n");
 		dma_chan_count = 9;
@@ -2142,16 +2164,14 @@ static int __init omap_init_dma(void)
 		u8 revision = omap_readb(OMAP_DMA4_REVISION);
 		printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
 		       revision >> 4, revision & 0xf);
-		dma_chan_count = OMAP_LOGICAL_DMA_CH_COUNT;
+		dma_chan_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else {
 		dma_chan_count = 0;
 		return 0;
 	}
 
-	memset(&lcd_dma, 0, sizeof(lcd_dma));
 	spin_lock_init(&lcd_dma.lock);
 	spin_lock_init(&dma_chan_lock);
-	memset(&dma_chan, 0, sizeof(dma_chan));
 
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		omap_clear_dma(ch);
diff --git a/include/asm-arm/arch-omap/dma.h b/include/asm-arm/arch-omap/dma.h
index 24acf09..46fe5a4 100644
--- a/include/asm-arm/arch-omap/dma.h
+++ b/include/asm-arm/arch-omap/dma.h
@@ -68,9 +68,10 @@
 #define OMAP_DMA4_CAPS_3		(OMAP_DMA4_BASE + 0x70)
 #define OMAP_DMA4_CAPS_4		(OMAP_DMA4_BASE + 0x74)
 
-#ifdef CONFIG_ARCH_OMAP1
+#define OMAP1_LOGICAL_DMA_CH_COUNT	17
+#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
 
-#define OMAP_LOGICAL_DMA_CH_COUNT	17
+#ifdef CONFIG_ARCH_OMAP1
 
 /* Common channel specific registers for omap1 */
 #define OMAP_DMA_CSDP_REG(n)		__REG16(OMAP_DMA_BASE + 0x40 * (n) + 0x00)
@@ -89,8 +90,6 @@
 
 #else
 
-#define OMAP_LOGICAL_DMA_CH_COUNT	32	/* REVISIT: Is this 32 + 2? */
-
 /* Common channel specific registers for omap2 */
 #define OMAP_DMA_CCR_REG(n)		__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x80)
 #define OMAP_DMA_CLNK_CTRL_REG(n)	__REG32(OMAP_DMA4_BASE + 0x60 * (n) + 0x84)
