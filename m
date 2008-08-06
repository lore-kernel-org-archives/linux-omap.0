From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 1/3] ARM: OMAP: OneNAND for OMAP3
Date: Wed, 06 Aug 2008 09:55:37 +0300
Message-ID: <48994AE9.9000000@nokia.com>
References: <4892C533.50904@nokia.com> <20080804140243.GG8885@atomide.com> <48994A83.8040904@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28100 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbYHFGyP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 02:54:15 -0400
In-Reply-To: <48994A83.8040904@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Update OneNAND support for OMAP3.

Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
---
 drivers/mtd/onenand/omap2.c |  588 +++++++++++++++++++++++++++++--------------
 1 files changed, 404 insertions(+), 184 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index ba83900..b1f0df1 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/mtd/onenand/omap2.c
  *
- *  OneNAND driver for OMAP2
+ *  OneNAND driver for OMAP2 / OMAP3
  *
  *  Copyright (C) 2005-2006 Nokia Corporation
  *
@@ -47,7 +47,7 @@
 
 #include <asm/arch/board.h>
 
-#define DRIVER_NAME "omap2-onenand"
+#define DRIVER_NAME "omap2-onenand"
 
 #define ONENAND_IO_SIZE		SZ_128K
 #define ONENAND_BUFRAM_SIZE	(1024 * 5)
@@ -67,36 +67,50 @@ struct omap2_onenand {
 	int (*setup)(void __iomem *base, int freq);
 };
 
-static unsigned short omap2_onenand_readw(void __iomem *addr)
+static void omap2_onenand_dma_cb(int lch, u16 ch_status, void *data)
 {
-	return readw(addr);
+	struct omap2_onenand *c = data;
+
+	complete(&c->dma_done);
 }
 
-static void omap2_onenand_writew(unsigned short value, void __iomem *addr)
+static irqreturn_t omap2_onenand_interrupt(int irq, void *dev_id)
 {
-	writew(value, addr);
+	struct omap2_onenand *c = dev_id;
+
+	complete(&c->irq_done);
+
+	return IRQ_HANDLED;
 }
 
-static void omap2_onenand_dma_cb(int lch, u16 ch_status, void *data)
+static inline unsigned short read_reg(struct omap2_onenand *c, int reg)
 {
-	struct omap2_onenand *info = data;
-
-	complete(&info->dma_done);
+	return readw(c->onenand.base + reg);
 }
 
-static irqreturn_t omap2_onenand_interrupt(int irq, void *dev_id)
+static inline void write_reg(struct omap2_onenand *c, unsigned short value,
+			     int reg)
 {
-	struct omap2_onenand *info = dev_id;
+	writew(value, c->onenand.base + reg);
+}
 
-	complete(&info->irq_done);
+static void wait_err(char *msg, int state, unsigned int ctrl, unsigned int intr)
+{
+	printk(KERN_ERR "onenand_wait: %s! state %d ctrl 0x%04x intr 0x%04x\n",
+	       msg, state, ctrl, intr);
+}
 
-	return IRQ_HANDLED;
+static void wait_warn(char *msg, int state, unsigned int ctrl,
+		      unsigned int intr)
+{
+	printk(KERN_WARNING "onenand_wait: %s! state %d ctrl 0x%04x "
+	       "intr 0x%04x\n", msg, state, ctrl, intr);
 }
 
 static int omap2_onenand_wait(struct mtd_info *mtd, int state)
 {
-	struct omap2_onenand *info = container_of(mtd, struct omap2_onenand, mtd);
-	unsigned int interrupt = 0;
+	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
+	unsigned int intr = 0;
 	unsigned int ctrl;
 	unsigned long timeout;
 	u32 syscfg;
@@ -106,17 +120,17 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
 
 		for (i = 0; i < 20; i++) {
 			udelay(1);
-			interrupt = omap2_onenand_readw(info->onenand.base + ONENAND_REG_INTERRUPT);
-			if (interrupt & ONENAND_INT_MASTER)
+			intr = read_reg(c, ONENAND_REG_INTERRUPT);
+			if (intr & ONENAND_INT_MASTER)
 				break;
 		}
-		ctrl = omap2_onenand_readw(info->onenand.base + ONENAND_REG_CTRL_STATUS);
+		ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
 		if (ctrl & ONENAND_CTRL_ERROR) {
-			printk(KERN_ERR "onenand_wait: reset error! ctrl 0x%04x intr 0x%04x\n", ctrl, interrupt);
+			wait_err("controller error", state, ctrl, intr);
 			return -EIO;
 		}
-		if (!(interrupt & ONENAND_INT_RESET)) {
-			printk(KERN_ERR "onenand_wait: reset timeout! ctrl 0x%04x intr 0x%04x\n", ctrl, interrupt);
+		if (!(intr & ONENAND_INT_RESET)) {
+			wait_err("timeout", state, ctrl, intr);
 			return -EIO;
 		}
 		return 0;
@@ -124,88 +138,103 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
 
 	if (state != FL_READING) {
 		int result;
+
 		/* Turn interrupts on */
-		syscfg = omap2_onenand_readw(info->onenand.base + ONENAND_REG_SYS_CFG1);
+		syscfg = read_reg(c, ONENAND_REG_SYS_CFG1);
 		syscfg |= ONENAND_SYS_CFG1_IOBE;
-		omap2_onenand_writew(syscfg, info->onenand.base + ONENAND_REG_SYS_CFG1);
+		write_reg(c, syscfg, ONENAND_REG_SYS_CFG1);
 
-		INIT_COMPLETION(info->irq_done);
-		if (info->gpio_irq) {
-			result = omap_get_gpio_datain(info->gpio_irq);
+		INIT_COMPLETION(c->irq_done);
+		if (c->gpio_irq) {
+			result = omap_get_gpio_datain(c->gpio_irq);
 			if (result == -1) {
-				ctrl = omap2_onenand_readw(info->onenand.base + ONENAND_REG_CTRL_STATUS);
-				printk(KERN_ERR "onenand_wait: gpio error, state = %d, ctrl = 0x%04x\n", state, ctrl);
+				ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
+				intr = read_reg(c, ONENAND_REG_INTERRUPT);
+				wait_err("gpio error", state, ctrl, intr);
 				return -EIO;
 			}
-		} else {
+		} else
 			result = 0;
-		}
 		if (result == 0) {
 			int retry_cnt = 0;
 retry:
-			result = wait_for_completion_timeout(&info->irq_done,
+			result = wait_for_completion_timeout(&c->irq_done,
 						    msecs_to_jiffies(20));
 			if (result == 0) {
 				/* Timeout after 20ms */
-				ctrl = omap2_onenand_readw(info->onenand.base + ONENAND_REG_CTRL_STATUS);
+				ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
 				if (ctrl & ONENAND_CTRL_ONGO) {
-					/* The operation seems to be still going - so give it some more time */
+					/*
+					 * The operation seems to be still going
+					 * so give it some more time.
+					 */
 					retry_cnt += 1;
 					if (retry_cnt < 3)
 						goto retry;
-					interrupt = omap2_onenand_readw(info->onenand.base + ONENAND_REG_INTERRUPT);
-					printk(KERN_ERR "onenand_wait: timeout state=%d ctrl=0x%04x intr=0x%04x\n", state, ctrl, interrupt);
+					intr = read_reg(c,
+							ONENAND_REG_INTERRUPT);
+					wait_err("timeout", state, ctrl, intr);
 					return -EIO;
 				}
-				interrupt = omap2_onenand_readw(info->onenand.base + ONENAND_REG_INTERRUPT);
-				if ((interrupt & ONENAND_INT_MASTER) == 0)
-					printk(KERN_WARNING "onenand_wait: timeout state=%d ctrl=0x%04x intr=0x%04x\n", state, ctrl, interrupt);
+				intr = read_reg(c, ONENAND_REG_INTERRUPT);
+				if ((intr & ONENAND_INT_MASTER) == 0)
+					wait_warn("timeout", state, ctrl, intr);
 			}
 		}
 	} else {
 		/* Turn interrupts off */
-		syscfg = omap2_onenand_readw(info->onenand.base + ONENAND_REG_SYS_CFG1);
+		syscfg = read_reg(c, ONENAND_REG_SYS_CFG1);
 		syscfg &= ~ONENAND_SYS_CFG1_IOBE;
-		omap2_onenand_writew(syscfg, info->onenand.base + ONENAND_REG_SYS_CFG1);
+		write_reg(c, syscfg, ONENAND_REG_SYS_CFG1);
 
 		timeout = jiffies + msecs_to_jiffies(20);
 		while (time_before(jiffies, timeout)) {
-			if (omap2_onenand_readw(info->onenand.base + ONENAND_REG_INTERRUPT) &
-			    ONENAND_INT_MASTER)
+			intr = read_reg(c, ONENAND_REG_INTERRUPT);
+			if (intr & ONENAND_INT_MASTER)
 				break;
 		}
 	}
 
-	/* To get correct interrupt status in timeout case */
-	interrupt = omap2_onenand_readw(info->onenand.base + ONENAND_REG_INTERRUPT);
-	ctrl = omap2_onenand_readw(info->onenand.base + ONENAND_REG_CTRL_STATUS);
+	intr = read_reg(c, ONENAND_REG_INTERRUPT);
+	ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
 
-	if (ctrl & ONENAND_CTRL_ERROR) {
-		printk(KERN_ERR "onenand_wait: controller error = 0x%04x\n", ctrl);
-		if (ctrl & ONENAND_CTRL_LOCK)
-			printk(KERN_ERR "onenand_erase: Device is write protected!!!\n");
-		return -EIO;
-	}
+	if (intr & ONENAND_INT_READ) {
+		int ecc = read_reg(c, ONENAND_REG_ECC_STATUS);
 
-	if (ctrl & 0xFE9F)
-		printk(KERN_WARNING "onenand_wait: unexpected controller status = 0x%04x  state = %d  interrupt = 0x%04x\n", ctrl, state, interrupt);
-
-	if (interrupt & ONENAND_INT_READ) {
-		int ecc = omap2_onenand_readw(info->onenand.base + ONENAND_REG_ECC_STATUS);
 		if (ecc) {
+			unsigned int addr1, addr8;
+
+			addr1 = read_reg(c, ONENAND_REG_START_ADDRESS1);
+			addr8 = read_reg(c, ONENAND_REG_START_ADDRESS8);
 			if (ecc & ONENAND_ECC_2BIT_ALL) {
-				printk(KERN_ERR "onenand_wait: ECC error = 0x%04x\n", ecc);
+				printk(KERN_ERR "onenand_wait: ECC error = "
+				       "0x%04x, addr1 %#x, addr8 %#x\n",
+				       ecc, addr1, addr8);
 				mtd->ecc_stats.failed++;
 				return -EBADMSG;
-			} else if (ecc & ONENAND_ECC_1BIT_ALL)
-				printk(KERN_NOTICE "onenand_wait: correctable ECC error = 0x%04x\n", ecc);
+			} else if (ecc & ONENAND_ECC_1BIT_ALL) {
+				printk(KERN_NOTICE "onenand_wait: correctable "
+				       "ECC error = 0x%04x, addr1 %#x, "
+				       "addr8 %#x\n", ecc, addr1, addr8);
 				mtd->ecc_stats.corrected++;
+			}
 		}
 	} else if (state == FL_READING) {
-		printk(KERN_ERR "onenand_wait: read timeout! ctrl=0x%04x intr=0x%04x\n", ctrl, interrupt);
+		wait_err("timeout", state, ctrl, intr);
+		return -EIO;
+	}
+
+	if (ctrl & ONENAND_CTRL_ERROR) {
+		wait_err("controller error", state, ctrl, intr);
+		if (ctrl & ONENAND_CTRL_LOCK)
+			printk(KERN_ERR "onenand_wait: "
+					"Device is write protected!!!\n");
 		return -EIO;
 	}
 
+	if (ctrl & 0xFE9F)
+		wait_warn("unexpected controller status", state, ctrl, intr);
+
 	return 0;
 }
 
@@ -223,106 +252,283 @@ static inline int omap2_onenand_bufferram_offset(struct mtd_info *mtd, int area)
 	return 0;
 }
 
+#if defined(CONFIG_ARCH_OMAP3) || defined(MULTI_OMAP2)
+
+static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
+					unsigned char *buffer, int offset,
+					size_t count)
+{
+	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
+	struct onenand_chip *this = mtd->priv;
+	dma_addr_t dma_src, dma_dst;
+	int bram_offset;
+	unsigned long timeout;
+	void *buf = (void *)buffer;
+	size_t xtra;
+	volatile unsigned *done;
+
+	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
+	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
+		goto out_copy;
+
+	if (buf >= high_memory) {
+		struct page *p1;
+
+		if (((size_t)buf & PAGE_MASK) !=
+		    ((size_t)(buf + count - 1) & PAGE_MASK))
+			goto out_copy;
+		p1 = vmalloc_to_page(buf);
+		if (!p1)
+			goto out_copy;
+		buf = page_address(p1) + ((size_t)buf & ~PAGE_MASK);
+	}
+
+	xtra = count & 3;
+	if (xtra) {
+		count -= xtra;
+		memcpy(buf + count, this->base + bram_offset + count, xtra);
+	}
+
+	dma_src = c->phys_base + bram_offset;
+	dma_dst = dma_map_single(&c->pdev->dev, buf, count, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dma_dst)) {
+		dev_err(&c->pdev->dev,
+			"Couldn't DMA map a %d byte buffer\n",
+			count);
+		goto out_copy;
+	}
+
+	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
+				     count >> 2, 1, 0, 0, 0);
+	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				dma_src, 0, 0);
+	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				 dma_dst, 0, 0);
+
+	INIT_COMPLETION(c->dma_done);
+	omap_start_dma(c->dma_channel);
+
+	timeout = jiffies + msecs_to_jiffies(20);
+	done = &c->dma_done.done;
+	while (time_before(jiffies, timeout))
+		if (*done)
+			break;
+
+	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
+
+	if (!*done) {
+		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
+		goto out_copy;
+	}
+
+	return 0;
+
+out_copy:
+	memcpy(buf, this->base + bram_offset, count);
+	return 0;
+}
+
+static int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
+					 const unsigned char *buffer,
+					 int offset, size_t count)
+{
+	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
+	struct onenand_chip *this = mtd->priv;
+	dma_addr_t dma_src, dma_dst;
+	int bram_offset;
+	unsigned long timeout;
+	void *buf = (void *)buffer;
+	volatile unsigned *done;
+
+	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
+	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
+		goto out_copy;
+
+	/* panic_write() may be in an interrupt context */
+	if (in_interrupt())
+		goto out_copy;
+
+	if (buf >= high_memory) {
+		struct page *p1;
+
+		if (((size_t)buf & PAGE_MASK) !=
+		    ((size_t)(buf + count - 1) & PAGE_MASK))
+			goto out_copy;
+		p1 = vmalloc_to_page(buf);
+		if (!p1)
+			goto out_copy;
+		buf = page_address(p1) + ((size_t)buf & ~PAGE_MASK);
+	}
+
+	dma_src = dma_map_single(&c->pdev->dev, buf, count, DMA_TO_DEVICE);
+	dma_dst = c->phys_base + bram_offset;
+	if (dma_mapping_error(dma_dst)) {
+		dev_err(&c->pdev->dev,
+			"Couldn't DMA map a %d byte buffer\n",
+			count);
+		return -1;
+	}
+
+	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
+				     count >> 2, 1, 0, 0, 0);
+	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				dma_src, 0, 0);
+	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				 dma_dst, 0, 0);
+
+	INIT_COMPLETION(c->dma_done);
+	omap_start_dma(c->dma_channel);
+
+	timeout = jiffies + msecs_to_jiffies(20);
+	done = &c->dma_done.done;
+	while (time_before(jiffies, timeout))
+		if (*done)
+			break;
+
+	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_TO_DEVICE);
+
+	if (!*done) {
+		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
+		goto out_copy;
+	}
+
+	return 0;
+
+out_copy:
+	memcpy(this->base + bram_offset, buf, count);
+	return 0;
+}
+
+#else
+
+int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
+				 unsigned char *buffer, int offset,
+				 size_t count);
+
+int omap3_onenand_write_bufferram(struct mtd_info *mtd, int area,
+				  const unsigned char *buffer,
+				  int offset, size_t count);
+
+#endif
+
+#if defined(CONFIG_ARCH_OMAP2) || defined(MULTI_OMAP2)
+
 static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
 					unsigned char *buffer, int offset,
 					size_t count)
 {
-	struct omap2_onenand *info = container_of(mtd, struct omap2_onenand, mtd);
+	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
 	struct onenand_chip *this = mtd->priv;
 	dma_addr_t dma_src, dma_dst;
 	int bram_offset;
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
-	if (1 || (info->dma_channel < 0) || ((void *) buffer >= (void *) high_memory) ||
-	    (bram_offset & 3) || (((unsigned int) buffer) & 3) ||
-	    (count < 1024) || (count & 3)) {
-		memcpy(buffer, (void *)(this->base + bram_offset), count);
+	/* DMA is not used.  Revisit PM requirements before enabling it. */
+	if (1 || (c->dma_channel < 0) ||
+	    ((void *) buffer >= (void *) high_memory) || (bram_offset & 3) ||
+	    (((unsigned int) buffer) & 3) || (count < 1024) || (count & 3)) {
+		memcpy(buffer, (__force void *)(this->base + bram_offset),
+		       count);
 		return 0;
 	}
 
-	dma_src = info->phys_base + bram_offset;
-	dma_dst = dma_map_single(&info->pdev->dev, buffer, count, DMA_FROM_DEVICE);
+	dma_src = c->phys_base + bram_offset;
+	dma_dst = dma_map_single(&c->pdev->dev, buffer, count,
+				 DMA_FROM_DEVICE);
 	if (dma_mapping_error(dma_dst)) {
-		dev_err(&info->pdev->dev,
+		dev_err(&c->pdev->dev,
 			"Couldn't DMA map a %d byte buffer\n",
 			count);
 		return -1;
 	}
 
-	omap_set_dma_transfer_params(info->dma_channel, OMAP_DMA_DATA_TYPE_S32,
+	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S32,
 				     count / 4, 1, 0, 0, 0);
-	omap_set_dma_src_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
 				dma_src, 0, 0);
-	omap_set_dma_dest_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
 				 dma_dst, 0, 0);
 
-	INIT_COMPLETION(info->dma_done);
-	omap2_block_sleep();
-	omap_start_dma(info->dma_channel);
-	wait_for_completion(&info->dma_done);
-	omap2_allow_sleep();
+	INIT_COMPLETION(c->dma_done);
+	omap_start_dma(c->dma_channel);
+	wait_for_completion(&c->dma_done);
 
-	dma_unmap_single(&info->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
+	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
 
 	return 0;
 }
 
 static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
-					 const unsigned char *buffer, int offset,
-					 size_t count)
+					 const unsigned char *buffer,
+					 int offset, size_t count)
 {
-	struct omap2_onenand *info = container_of(mtd, struct omap2_onenand, mtd);
+	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
 	struct onenand_chip *this = mtd->priv;
 	dma_addr_t dma_src, dma_dst;
 	int bram_offset;
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
-	if (1 || (info->dma_channel < 0) || ((void *) buffer >= (void *) high_memory) ||
-	    (bram_offset & 3) || (((unsigned int) buffer) & 3) ||
-	    (count < 1024) || (count & 3)) {
-		memcpy((void *)(this->base + bram_offset), buffer, count);
+	/* DMA is not used.  Revisit PM requirements before enabling it. */
+	if (1 || (c->dma_channel < 0) ||
+	    ((void *) buffer >= (void *) high_memory) || (bram_offset & 3) ||
+	    (((unsigned int) buffer) & 3) || (count < 1024) || (count & 3)) {
+		memcpy((__force void *)(this->base + bram_offset), buffer,
+		       count);
 		return 0;
 	}
 
-	dma_src = dma_map_single(&info->pdev->dev, (void *) buffer, count,
+	dma_src = dma_map_single(&c->pdev->dev, (void *) buffer, count,
 				 DMA_TO_DEVICE);
-	dma_dst = info->phys_base + bram_offset;
+	dma_dst = c->phys_base + bram_offset;
 	if (dma_mapping_error(dma_dst)) {
-		dev_err(&info->pdev->dev,
+		dev_err(&c->pdev->dev,
 			"Couldn't DMA map a %d byte buffer\n",
 			count);
 		return -1;
 	}
 
-	omap_set_dma_transfer_params(info->dma_channel, OMAP_DMA_DATA_TYPE_S16,
+	omap_set_dma_transfer_params(c->dma_channel, OMAP_DMA_DATA_TYPE_S16,
 				     count / 2, 1, 0, 0, 0);
-	omap_set_dma_src_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+	omap_set_dma_src_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
 				dma_src, 0, 0);
-	omap_set_dma_dest_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+	omap_set_dma_dest_params(c->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
 				 dma_dst, 0, 0);
 
-	INIT_COMPLETION(info->dma_done);
-	omap_start_dma(info->dma_channel);
-	wait_for_completion(&info->dma_done);
+	INIT_COMPLETION(c->dma_done);
+	omap_start_dma(c->dma_channel);
+	wait_for_completion(&c->dma_done);
 
-	dma_unmap_single(&info->pdev->dev, dma_dst, count, DMA_TO_DEVICE);
+	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_TO_DEVICE);
 
 	return 0;
 }
 
+#else
+
+int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
+				 unsigned char *buffer, int offset,
+				 size_t count);
+
+int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
+				  const unsigned char *buffer,
+				  int offset, size_t count);
+
+#endif
+
 static struct platform_driver omap2_onenand_driver;
 
 static int __adjust_timing(struct device *dev, void *data)
 {
 	int ret = 0;
-	struct omap2_onenand *info;
+	struct omap2_onenand *c;
 
-	info = dev_get_drvdata(dev);
+	c = dev_get_drvdata(dev);
 
-	BUG_ON(info->setup == NULL);
+	BUG_ON(c->setup == NULL);
 
 	/* DMA is not in use so this is all that is needed */
-	ret = info->setup(info->onenand.base, info->freq);
+	/* Revisit for OMAP3! */
+	ret = c->setup(c->onenand.base, c->freq);
 
 	return ret;
 }
@@ -335,19 +541,19 @@ int omap2_onenand_rephase(void)
 
 static void __devexit omap2_onenand_shutdown(struct platform_device *pdev)
 {
-	struct omap2_onenand *info = dev_get_drvdata(&pdev->dev);
+	struct omap2_onenand *c = dev_get_drvdata(&pdev->dev);
 
 	/* With certain content in the buffer RAM, the OMAP boot ROM code
 	 * can recognize the flash chip incorrectly. Zero it out before
 	 * soft reset.
 	 */
-	memset(info->onenand.base, 0, ONENAND_BUFRAM_SIZE);
+	memset((__force void *)c->onenand.base, 0, ONENAND_BUFRAM_SIZE);
 }
 
 static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 {
 	struct omap_onenand_platform_data *pdata;
-	struct omap2_onenand *info;
+	struct omap2_onenand *c;
 	int r;
 
 	pdata = pdev->dev.platform_data;
@@ -356,173 +562,187 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	info = kzalloc(sizeof(struct omap2_onenand), GFP_KERNEL);
-	if (!info)
+	c = kzalloc(sizeof(struct omap2_onenand), GFP_KERNEL);
+	if (!c)
 		return -ENOMEM;
 
-	init_completion(&info->irq_done);
-	init_completion(&info->dma_done);
-	info->gpmc_cs = pdata->cs;
-	info->gpio_irq = pdata->gpio_irq;
-	info->dma_channel = pdata->dma_channel;
-	if (info->dma_channel < 0) {
+	init_completion(&c->irq_done);
+	init_completion(&c->dma_done);
+	c->gpmc_cs = pdata->cs;
+	c->gpio_irq = pdata->gpio_irq;
+	c->dma_channel = pdata->dma_channel;
+	if (c->dma_channel < 0) {
 		/* if -1, don't use DMA */
-		info->gpio_irq = 0;
+		c->gpio_irq = 0;
 	}
 
-	r = gpmc_cs_request(info->gpmc_cs, ONENAND_IO_SIZE, &info->phys_base);
+	r = gpmc_cs_request(c->gpmc_cs, ONENAND_IO_SIZE, &c->phys_base);
 	if (r < 0) {
 		dev_err(&pdev->dev, "Cannot request GPMC CS\n");
 		goto err_kfree;
 	}
 
-	if (request_mem_region(info->phys_base, ONENAND_IO_SIZE,
+	if (request_mem_region(c->phys_base, ONENAND_IO_SIZE,
 			       pdev->dev.driver->name) == NULL) {
-		dev_err(&pdev->dev, "Cannot reserve memory region at 0x%08lx, size: 0x%x\n",
-			info->phys_base, ONENAND_IO_SIZE);
+		dev_err(&pdev->dev, "Cannot reserve memory region at 0x%08lx, "
+			"size: 0x%x\n",	c->phys_base, ONENAND_IO_SIZE);
 		r = -EBUSY;
 		goto err_free_cs;
 	}
-	info->onenand.base = ioremap(info->phys_base, ONENAND_IO_SIZE);
-	if (info->onenand.base == NULL) {
+	c->onenand.base = ioremap(c->phys_base, ONENAND_IO_SIZE);
+	if (c->onenand.base == NULL) {
 		r = -ENOMEM;
 		goto err_release_mem_region;
 	}
 
 	if (pdata->onenand_setup != NULL) {
-		r = pdata->onenand_setup(info->onenand.base, info->freq);
+		r = pdata->onenand_setup(c->onenand.base, c->freq);
 		if (r < 0) {
-			dev_err(&pdev->dev, "Onenand platform setup failed: %d\n", r);
+			dev_err(&pdev->dev, "Onenand platform setup failed: "
+				"%d\n", r);
 			goto err_iounmap;
 		}
-		info->setup = pdata->onenand_setup;
+		c->setup = pdata->onenand_setup;
 	}
 
-	if (info->gpio_irq) {
-		if ((r = omap_request_gpio(info->gpio_irq)) < 0) {
-			dev_err(&pdev->dev,  "Failed to request GPIO%d for OneNAND\n",
-				info->gpio_irq);
+	if (c->gpio_irq) {
+		if ((r = omap_request_gpio(c->gpio_irq)) < 0) {
+			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
+				"OneNAND\n", c->gpio_irq);
 			goto err_iounmap;
 	}
-	omap_set_gpio_direction(info->gpio_irq, 1);
+	omap_set_gpio_direction(c->gpio_irq, 1);
 
-	if ((r = request_irq(OMAP_GPIO_IRQ(info->gpio_irq),
+	if ((r = request_irq(OMAP_GPIO_IRQ(c->gpio_irq),
 			     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
-			     pdev->dev.driver->name, info)) < 0)
+			     pdev->dev.driver->name, c)) < 0)
 		goto err_release_gpio;
 	}
 
-	if (info->dma_channel >= 0) {
+	if (c->dma_channel >= 0) {
 		r = omap_request_dma(0, pdev->dev.driver->name,
-				     omap2_onenand_dma_cb, (void *) info,
-				     &info->dma_channel);
+				     omap2_onenand_dma_cb, (void *) c,
+				     &c->dma_channel);
 		if (r == 0) {
-			omap_set_dma_write_mode(info->dma_channel, OMAP_DMA_WRITE_NON_POSTED);
-			omap_set_dma_src_data_pack(info->dma_channel, 1);
-			omap_set_dma_src_burst_mode(info->dma_channel, OMAP_DMA_DATA_BURST_8);
-			omap_set_dma_dest_data_pack(info->dma_channel, 1);
-			omap_set_dma_dest_burst_mode(info->dma_channel, OMAP_DMA_DATA_BURST_8);
+			omap_set_dma_write_mode(c->dma_channel,
+						OMAP_DMA_WRITE_NON_POSTED);
+			omap_set_dma_src_data_pack(c->dma_channel, 1);
+			omap_set_dma_src_burst_mode(c->dma_channel,
+						    OMAP_DMA_DATA_BURST_8);
+			omap_set_dma_dest_data_pack(c->dma_channel, 1);
+			omap_set_dma_dest_burst_mode(c->dma_channel,
+						     OMAP_DMA_DATA_BURST_8);
 		} else {
 			dev_info(&pdev->dev,
-				 "failed to allocate DMA for OneNAND, using PIO instead\n");
-			info->dma_channel = -1;
+				 "failed to allocate DMA for OneNAND, "
+				 "using PIO instead\n");
+			c->dma_channel = -1;
 		}
 	}
 
-	dev_info(&pdev->dev, "initializing on CS%d, phys base 0x%08lx, virtual base %p\n",
-		 info->gpmc_cs, info->phys_base, info->onenand.base);
+	dev_info(&pdev->dev, "initializing on CS%d, phys base 0x%08lx, virtual "
+		 "base %p\n", c->gpmc_cs, c->phys_base,
+		 c->onenand.base);
 
-	info->pdev = pdev;
-	info->mtd.name = pdev->dev.bus_id;
-	info->mtd.priv = &info->onenand;
-	info->mtd.owner = THIS_MODULE;
+	c->pdev = pdev;
+	c->mtd.name = pdev->dev.bus_id;
+	c->mtd.priv = &c->onenand;
+	c->mtd.owner = THIS_MODULE;
 
-	if (info->dma_channel >= 0) {
-		info->onenand.wait = omap2_onenand_wait;
-		info->onenand.read_bufferram = omap2_onenand_read_bufferram;
-		info->onenand.write_bufferram = omap2_onenand_write_bufferram;
+	if (c->dma_channel >= 0) {
+		struct onenand_chip *this = &c->onenand;
+
+		this->wait = omap2_onenand_wait;
+		if (cpu_is_omap34xx()) {
+			this->read_bufferram = omap3_onenand_read_bufferram;
+			this->write_bufferram = omap3_onenand_write_bufferram;
+		} else {
+			this->read_bufferram = omap2_onenand_read_bufferram;
+			this->write_bufferram = omap2_onenand_write_bufferram;
+		}
 	}
 
-	if ((r = onenand_scan(&info->mtd, 1)) < 0)
+	if ((r = onenand_scan(&c->mtd, 1)) < 0)
 		goto err_release_dma;
 
-	switch ((info->onenand.version_id >> 4) & 0xf) {
+	switch ((c->onenand.version_id >> 4) & 0xf) {
 	case 0:
-		info->freq = 40;
+		c->freq = 40;
 		break;
 	case 1:
-		info->freq = 54;
+		c->freq = 54;
 		break;
 	case 2:
-		info->freq = 66;
+		c->freq = 66;
 		break;
 	case 3:
-		info->freq = 83;
+		c->freq = 83;
 		break;
 	}
 
 #ifdef CONFIG_MTD_PARTITIONS
 	if (pdata->parts != NULL)
-		r = add_mtd_partitions(&info->mtd, pdata->parts, pdata->nr_parts);
+		r = add_mtd_partitions(&c->mtd, pdata->parts,
+				       pdata->nr_parts);
 	else
 #endif
-		r = add_mtd_device(&info->mtd);
+		r = add_mtd_device(&c->mtd);
 	if (r < 0)
 		goto err_release_onenand;
 
-	platform_set_drvdata(pdev, info);
+	platform_set_drvdata(pdev, c);
 
 	return 0;
 
 err_release_onenand:
-	onenand_release(&info->mtd);
+	onenand_release(&c->mtd);
 err_release_dma:
-	if (info->dma_channel != -1)
-		omap_free_dma(info->dma_channel);
-	if (info->gpio_irq)
-		free_irq(OMAP_GPIO_IRQ(info->gpio_irq), info);
+	if (c->dma_channel != -1)
+		omap_free_dma(c->dma_channel);
+	if (c->gpio_irq)
+		free_irq(OMAP_GPIO_IRQ(c->gpio_irq), c);
 err_release_gpio:
-	if (info->gpio_irq)
-		omap_free_gpio(info->gpio_irq);
+	if (c->gpio_irq)
+		omap_free_gpio(c->gpio_irq);
 err_iounmap:
-	iounmap(info->onenand.base);
+	iounmap(c->onenand.base);
 err_release_mem_region:
-	release_mem_region(info->phys_base, ONENAND_IO_SIZE);
+	release_mem_region(c->phys_base, ONENAND_IO_SIZE);
 err_free_cs:
-	gpmc_cs_free(info->gpmc_cs);
+	gpmc_cs_free(c->gpmc_cs);
 err_kfree:
-	kfree(info);
+	kfree(c);
 
 	return r;
 }
 
 static int __devexit omap2_onenand_remove(struct platform_device *pdev)
 {
-	struct omap2_onenand *info = dev_get_drvdata(&pdev->dev);
+	struct omap2_onenand *c = dev_get_drvdata(&pdev->dev);
 
-	BUG_ON(info == NULL);
+	BUG_ON(c == NULL);
 
 #ifdef CONFIG_MTD_PARTITIONS
-	if (info->parts)
-		del_mtd_partitions(&info->mtd);
+	if (c->parts)
+		del_mtd_partitions(&c->mtd);
 	else
-		del_mtd_device(&info->mtd);
+		del_mtd_device(&c->mtd);
 #else
-	del_mtd_device(&info->mtd);
+	del_mtd_device(&c->mtd);
 #endif
 
-	onenand_release(&info->mtd);
-	if (info->dma_channel != -1)
-		omap_free_dma(info->dma_channel);
+	onenand_release(&c->mtd);
+	if (c->dma_channel != -1)
+		omap_free_dma(c->dma_channel);
 	omap2_onenand_shutdown(pdev);
 	platform_set_drvdata(pdev, NULL);
-	if (info->gpio_irq) {
-		free_irq(OMAP_GPIO_IRQ(info->gpio_irq), info);
-		omap_free_gpio(info->gpio_irq);
+	if (c->gpio_irq) {
+		free_irq(OMAP_GPIO_IRQ(c->gpio_irq), c);
+		omap_free_gpio(c->gpio_irq);
 	}
-	iounmap(info->onenand.base);
-	release_mem_region(info->phys_base, ONENAND_IO_SIZE);
-	kfree(info);
+	iounmap(c->onenand.base);
+	release_mem_region(c->phys_base, ONENAND_IO_SIZE);
+	kfree(c);
 
 	return 0;
 }
@@ -539,7 +759,7 @@ static struct platform_driver omap2_onenand_driver = {
 
 static int __init omap2_onenand_init(void)
 {
-	printk(KERN_INFO "OMAP2 OneNAND driver initializing\n");
+	printk(KERN_INFO "OneNAND driver initializing\n");
 	return platform_driver_register(&omap2_onenand_driver);
 }
 
@@ -554,4 +774,4 @@ module_exit(omap2_onenand_exit);
 MODULE_ALIAS(DRIVER_NAME);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jarkko Lavinen <jarkko.lavinen@nokia.com>");
-MODULE_DESCRIPTION("Glue layer for OneNAND flash on OMAP2");
+MODULE_DESCRIPTION("Glue layer for OneNAND flash on OMAP2 / OMAP3");
-- 
1.5.4.3
