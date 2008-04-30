From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: OMAP: Make DMA channels dynamic for multi-boot
Date: Wed, 30 Apr 2008 10:13:59 -0700
Message-ID: <1209575641-25613-2-git-send-email-tony@atomide.com>
References: omap-dma-2008-04-30
 <1209575641-25613-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61521 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756756AbYD3ROG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2008 13:14:06 -0400
In-Reply-To: <1209575641-25613-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Make DMA channels dynamic for multi-boot

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c        |   62 +++++++++++++++++++++++++-------------
 include/asm-arm/arch-omap/dma.h |    7 ++--
 2 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c00eda5..d0cfe2b 100644
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
@@ -729,7 +732,7 @@ omap_dma_set_prio_lch(int lch, unsigned char read_prio,
 {
 	u32 w;
 
-	if (unlikely((lch < 0 || lch >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((lch < 0 || lch >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid channel id\n");
 		return -EINVAL;
 	}
@@ -777,7 +780,7 @@ void omap_start_dma(int lch)
 {
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
-		char dma_chan_link_map[OMAP_LOGICAL_DMA_CH_COUNT];
+		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
 
 		dma_chan_link_map[lch] = 1;
 		/* Set the link register of the first channel */
@@ -821,7 +824,7 @@ void omap_stop_dma(int lch)
 {
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch = lch;
-		char dma_chan_link_map[OMAP_LOGICAL_DMA_CH_COUNT];
+		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
 
 		memset(dma_chan_link_map, 0, sizeof(dma_chan_link_map));
 		do {
@@ -1063,7 +1066,7 @@ int omap_request_dma_chain(int dev_id, const char *dev_name,
 	}
 
 	if (unlikely((no_of_chans < 1
-			|| no_of_chans > OMAP_LOGICAL_DMA_CH_COUNT))) {
+			|| no_of_chans > dma_lch_count))) {
 		printk(KERN_ERR "Invalid Number of channels requested\n");
 		return -EINVAL;
 	}
@@ -1140,7 +1143,7 @@ int omap_modify_dma_chain_params(int chain_id,
 
 	/* Check for input params */
 	if (unlikely((chain_id < 0
-			|| chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+			|| chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1178,7 +1181,7 @@ int omap_free_dma_chain(int chain_id)
 	u32 i;
 
 	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1218,7 +1221,7 @@ EXPORT_SYMBOL(omap_free_dma_chain);
 int omap_dma_chain_status(int chain_id)
 {
 	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1267,7 +1270,7 @@ int omap_dma_chain_a_transfer(int chain_id, int src_start, int dest_start,
 
 	/* Check for input params */
 	if (unlikely((chain_id < 0
-			|| chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+			|| chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1384,7 +1387,7 @@ int omap_start_dma_chain_transfers(int chain_id)
 	int *channels;
 	u32 w, i;
 
-	if (unlikely((chain_id < 0 || chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1437,7 +1440,7 @@ int omap_stop_dma_chain_transfers(int chain_id)
 	u32 sys_cf;
 
 	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1499,7 +1502,7 @@ int omap_get_dma_chain_index(int chain_id, int *ei, int *fi)
 	int *channels;
 
 	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1539,7 +1542,7 @@ int omap_get_dma_chain_dst_pos(int chain_id)
 	int *channels;
 
 	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1573,7 +1576,7 @@ int omap_get_dma_chain_src_pos(int chain_id)
 	int *channels;
 
 	/* Check for input params */
-	if (unlikely((chain_id < 0 || chain_id >= OMAP_LOGICAL_DMA_CH_COUNT))) {
+	if (unlikely((chain_id < 0 || chain_id >= dma_lch_count))) {
 		printk(KERN_ERR "Invalid chain id\n");
 		return -EINVAL;
 	}
@@ -1726,7 +1729,7 @@ static irqreturn_t omap2_dma_irq_handler(int irq, void *dev_id)
 			printk(KERN_WARNING "Spurious DMA IRQ\n");
 		return IRQ_HANDLED;
 	}
-	for (i = 0; i < OMAP_LOGICAL_DMA_CH_COUNT && val != 0; i++) {
+	for (i = 0; i < dma_lch_count && val != 0; i++) {
 		if (val & 1)
 			omap2_dma_handle_ch(i);
 		val >>= 1;
@@ -2108,6 +2111,25 @@ static int __init omap_init_dma(void)
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
@@ -2144,16 +2166,14 @@ static int __init omap_init_dma(void)
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
index be0431e..28492c3 100644
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
-- 
1.5.3.6

