From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH] ARM: OMAP: OneNAND for OMAP3
Date: Fri, 01 Aug 2008 11:11:31 +0300
Message-ID: <4892C533.50904@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61222 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbYHAIKe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Aug 2008 04:10:34 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m718A7vD007476
	for <linux-omap@vger.kernel.org>; Fri, 1 Aug 2008 11:10:30 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Update OneNAND support for OMAP3.

Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/board-n800-flash.c |  240 ++++++++++++++++++++++++--------
 arch/arm/mach-omap2/gpmc.c             |    5 +
 drivers/mtd/onenand/omap2.c            |  186 +++++++++++++++++++++++--
 include/asm-arm/arch-omap/gpmc.h       |    4 +
 include/asm-arm/arch-omap/onenand.h    |    3 +
 include/linux/mtd/onenand_regs.h       |    2 +
 6 files changed, 367 insertions(+), 73 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-flash.c b/arch/arm/mach-omap2/board-n800-flash.c
index f7403b9..cd98be5 100644
--- a/arch/arm/mach-omap2/board-n800-flash.c
+++ b/arch/arm/mach-omap2/board-n800-flash.c
@@ -19,13 +19,17 @@
 #include <asm/arch/board.h>
 #include <asm/arch/gpmc.h>
 
-static struct mtd_partition n800_partitions[8];
+struct mtd_partition n800_partitions[ONENAND_MAX_PARTITIONS];
 
 static int n800_onenand_setup(void __iomem *, int freq);
 
 static struct omap_onenand_platform_data n800_onenand_data = {
 	.cs = 0,
+#ifdef CONFIG_ARCH_OMAP3430
+	.gpio_irq = 65,
+#else
 	.gpio_irq = 26,
+#endif
 	.parts = n800_partitions,
 	.nr_parts = 0, /* filled later */
 	.onenand_setup = n800_onenand_setup,
@@ -39,6 +43,55 @@ static struct platform_device n800_onenand_device = {
 	},
 };
 
+static int omap2_onenand_set_async_mode(int cs, void __iomem *onenand_base)
+{
+	struct gpmc_timings t;
+
+	const int t_cer = 15;
+	const int t_avdp = 12;
+	const int t_aavdh = 7;
+	const int t_ce = 76;
+	const int t_aa = 76;
+	const int t_oe = 20;
+	const int t_cez = 20; /* max of t_cez, t_oez */
+	const int t_ds = 30;
+	const int t_wpl = 40;
+	const int t_wph = 30;
+
+	memset(&t, 0, sizeof(t));
+	t.sync_clk = 0;
+	t.cs_on = 0;
+	t.adv_on = 0;
+
+	/* Read */
+	t.adv_rd_off = gpmc_round_ns_to_ticks(max_t(int, t_avdp, t_cer));
+	t.oe_on  = t.adv_rd_off + gpmc_round_ns_to_ticks(t_aavdh);
+	t.access = t.adv_on + gpmc_round_ns_to_ticks(t_aa);
+	t.access = max_t(int, t.access, t.cs_on + gpmc_round_ns_to_ticks(t_ce));
+	t.access = max_t(int, t.access, t.oe_on + gpmc_round_ns_to_ticks(t_oe));
+	t.oe_off = t.access + gpmc_round_ns_to_ticks(1);
+	t.cs_rd_off = t.oe_off;
+	t.rd_cycle  = t.cs_rd_off + gpmc_round_ns_to_ticks(t_cez);
+
+	/* Write */
+	t.adv_wr_off = t.adv_rd_off;
+	t.we_on  = t.oe_on;
+#ifdef CONFIG_ARCH_OMAP3430
+	t.wr_data_mux_bus = t.we_on;
+	t.wr_access = t.we_on + gpmc_round_ns_to_ticks(t_ds);
+#endif
+	t.we_off = t.we_on + gpmc_round_ns_to_ticks(t_wpl);
+	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(t_wph);
+	t.wr_cycle  = t.cs_wr_off + gpmc_round_ns_to_ticks(t_cez);
+
+	/* Configure GPMC for asynchronous read */
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
+			  GPMC_CONFIG1_DEVICESIZE_16 |
+			  GPMC_CONFIG1_MUXADDDATA);
+
+	return gpmc_cs_set_timings(cs, &t);
+}
+
 static unsigned short omap2_onenand_readw(void __iomem *addr)
 {
 	return readw(addr);
@@ -49,54 +102,124 @@ static void omap2_onenand_writew(unsigned short value, void __iomem *addr)
 	writew(value, addr);
 }
 
+static void set_onenand_cfg(void __iomem *onenand_base, int latency,
+			    int sync_write, int hf)
+{
+	u32 reg;
+
+	reg = omap2_onenand_readw(onenand_base + ONENAND_REG_SYS_CFG1);
+	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
+	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
+		ONENAND_SYS_CFG1_SYNC_READ |
+		ONENAND_SYS_CFG1_BL_16;
+	if (sync_write)
+		reg |= ONENAND_SYS_CFG1_SYNC_WRITE;
+	else
+		reg &= ~ONENAND_SYS_CFG1_SYNC_WRITE;
+	if (hf)
+		reg |= ONENAND_SYS_CFG1_HF;
+	else
+		reg &= ~ONENAND_SYS_CFG1_HF;
+	omap2_onenand_writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
+}
+
 static int omap2_onenand_set_sync_mode(int cs, void __iomem *onenand_base,
 				       int freq)
 {
 	struct gpmc_timings t;
-	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_avdp, t_wpl, t_wea;
+	const int t_cer  = 15;
+	const int t_avdp = 12;
+	const int t_cez  = 20; /* max of t_cez, t_oez */
+#ifdef CONFIG_ARCH_OMAP3430
+	const int t_ds   = 30;
+#endif
+	const int t_wpl  = 40;
+	const int t_wph  = 30;
+	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
 	int tick_ns, div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency;
-	int err;
+	int err, ticks_cez, sync_write = 0, first_time = 0, hf = 0;
 	u32 reg;
 
-again:
+	if (!freq) {
+		/* Very first call freq is not known */
+		err = omap2_onenand_set_async_mode(cs, onenand_base);
+		if (err)
+			return err;
+		reg = omap2_onenand_readw(onenand_base+ONENAND_REG_VERSION_ID);
+		switch ((reg >> 4) & 0xf) {
+		case 0:
+			freq = 40;
+			break;
+		case 1:
+			freq = 54;
+			break;
+		case 2:
+			freq = 66;
+			break;
+		case 3:
+			freq = 83;
+			break;
+		case 4:
+			freq = 104;
+			break;
+		default:
+			freq = 54;
+			break;
+		}
+		first_time = 1;
+	}
+
 	switch (freq) {
 	case 83:
 		min_gpmc_clk_period = 12; /* 83 MHz */
-		t_ces  = 5;
-		t_avds = 5;
-		t_avdh = 6;
-		t_avdp = 12;
-		t_wpl  = 40;
-		t_wea  = 15;
+		t_ces   = 5;
+		t_avds  = 4;
+		t_avdh  = 2;
+		t_ach   = 6;
+		t_aavdh = 6;
+		t_rdyo  = 9;
+#ifdef CONFIG_ARCH_OMAP3430
+		sync_write = 1;
+#endif
 		break;
 	case 66:
 		min_gpmc_clk_period = 15; /* 66 MHz */
-		t_ces  = 6;
-		t_avds = 5;
-		t_avdh = 6;
-		t_avdp = 12;
-		t_wpl  = 40;
-		t_wea  = 15;
+		t_ces   = 6;
+		t_avds  = 5;
+		t_avdh  = 2;
+		t_ach   = 6;
+		t_aavdh = 6;
+		t_rdyo  = 11;
+#ifdef CONFIG_ARCH_OMAP3430
+		sync_write = 1;
+#endif
 		break;
 	default:
 		min_gpmc_clk_period = 18; /* 54 MHz */
-		t_ces  = 7;
-		t_avds = 7;
-		t_avdh = 7;
-		t_avdp = 12;
-		t_wpl  = 40;
-		t_wea  = 15;
+		t_ces   = 7;
+		t_avds  = 7;
+		t_avdh  = 7;
+		t_ach   = 9;
+		t_aavdh = 7;
+		t_rdyo  = 15;
 		break;
 	}
 
 	tick_ns = gpmc_ticks_to_ns(1);
 	div = gpmc_cs_calc_divider(cs, min_gpmc_clk_period);
 	gpmc_clk_ns = gpmc_ticks_to_ns(div);
-	if (gpmc_clk_ns >= 25) /* 40 MHz*/
+	if (gpmc_clk_ns < 15) /* >66Mhz */
+		hf = 1;
+	if (hf)
+		latency = 6;
+	else if (gpmc_clk_ns >= 25) /* 40 MHz*/
 		latency = 3;
 	else
 		latency = 4;
 
+	if (first_time)
+		set_onenand_cfg(onenand_base, latency, sync_write, hf);
+
 	if (div == 1) {
 		reg = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG2);
 		reg |= (1 << 7);
@@ -121,7 +244,7 @@ again:
 		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG4, reg);
 	}
 
-	/* Set syncronous read timings */
+	/* Set synchronous read timings */
 	memset(&t, 0, sizeof(t));
 	t.sync_clk = min_gpmc_clk_period;
 	t.cs_on = 0;
@@ -132,28 +255,52 @@ again:
 
 	/* Read */
 	t.adv_rd_off = gpmc_ticks_to_ns(fclk_offset + gpmc_ns_to_ticks(t_avdh));
-	t.oe_on = t.adv_rd_off;
+	t.oe_on = gpmc_ticks_to_ns(fclk_offset + gpmc_ns_to_ticks(t_ach));
 	t.access = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div);
 	t.oe_off = t.access + gpmc_round_ns_to_ticks(1);
 	t.cs_rd_off = t.oe_off;
-	t.rd_cycle = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div + div);
+	ticks_cez = ((gpmc_ns_to_ticks(t_cez) + div - 1) / div) * div;
+	t.rd_cycle = gpmc_ticks_to_ns(fclk_offset + (latency + 1) * div +
+		     ticks_cez);
 
 	/* Write */
-	t.adv_wr_off = t.adv_on + gpmc_round_ns_to_ticks(t_avdp);
-	t.we_on = t.adv_wr_off + gpmc_round_ns_to_ticks(t_avdh);
-	t.we_off = t.we_on + gpmc_round_ns_to_ticks(t_wpl);
-	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(1);
-	t.wr_cycle = t.we_off + gpmc_round_ns_to_ticks(t_wea);
+	if (sync_write) {
+		t.adv_wr_off = t.adv_rd_off;
+		t.we_on  = 0;
+		t.we_off = t.cs_rd_off;
+		t.cs_wr_off = t.cs_rd_off;
+		t.wr_cycle  = t.rd_cycle;
+#ifdef CONFIG_ARCH_OMAP3430
+		t.wr_data_mux_bus = gpmc_ticks_to_ns(fclk_offset +
+				    gpmc_ns_to_ticks(min_gpmc_clk_period +
+						     t_rdyo));
+		t.wr_access = t.access;
+#endif
+	} else {
+		t.adv_wr_off = gpmc_round_ns_to_ticks(max_t(int, t_avdp, t_cer));
+		t.we_on  = t.adv_wr_off + gpmc_round_ns_to_ticks(t_aavdh);
+		t.we_off = t.we_on + gpmc_round_ns_to_ticks(t_wpl);
+		t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(t_wph);
+		t.wr_cycle  = t.cs_wr_off + gpmc_round_ns_to_ticks(t_cez);
+#ifdef CONFIG_ARCH_OMAP3430
+		t.wr_data_mux_bus = t.we_on;
+		t.wr_access = t.we_on + gpmc_round_ns_to_ticks(t_ds);
+#endif
+	}
 
 	/* Configure GPMC for synchronous read */
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
 			  GPMC_CONFIG1_WRAPBURST_SUPP |
 			  GPMC_CONFIG1_READMULTIPLE_SUPP |
 			  GPMC_CONFIG1_READTYPE_SYNC |
+			  (sync_write?GPMC_CONFIG1_WRITEMULTIPLE_SUPP:0) |
+			  (sync_write?GPMC_CONFIG1_WRITETYPE_SYNC:0) |
 			  GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
 			  GPMC_CONFIG1_PAGE_LEN(2) |
+#ifndef CONFIG_ARCH_OMAP3430
 			  GPMC_CONFIG1_WAIT_READ_MON |
 			  GPMC_CONFIG1_WAIT_PIN_SEL(0) |
+#endif
 			  GPMC_CONFIG1_DEVICESIZE_16 |
 			  GPMC_CONFIG1_DEVICETYPE_NOR |
 			  GPMC_CONFIG1_MUXADDDATA);
@@ -162,39 +309,12 @@ again:
 	if (err)
 		return err;
 
-	if (!freq) {
-		/* Very first call freq is not known */
-		reg = omap2_onenand_readw(onenand_base + ONENAND_REG_VERSION_ID);
-		switch ((reg >> 4) & 0xf) {
-		case 0:
-			freq = 40;
-			break;
-		case 1:
-			freq = 54;
-			break;
-		case 2:
-			freq = 66;
-			break;
-		case 3:
-			freq = 83;
-			break;
-		}
-		if (freq && freq != 54)
-			goto again;
-	}
-
-	/* Configure OneNAND for sync read */
-	reg = omap2_onenand_readw(onenand_base + ONENAND_REG_SYS_CFG1);
-	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
-	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
-		ONENAND_SYS_CFG1_SYNC_READ |
-		ONENAND_SYS_CFG1_BL_16;
-	omap2_onenand_writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
+	set_onenand_cfg(onenand_base, latency, sync_write, hf);
 
 	return 0;
 }
 
-static int n800_onenand_setup(void __iomem *onenand_base, int freq)
+int n800_onenand_setup(void __iomem *onenand_base, int freq)
 {
 	struct omap_onenand_platform_data *datap = &n800_onenand_data;
 	struct device *dev = &n800_onenand_device.dev;
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 87368a8..b46c6be 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -232,6 +232,11 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 
 	GPMC_SET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
 
+#ifdef CONFIG_ARCH_OMAP3430
+	GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
+	GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
+#endif
+
 	/* caller is expected to have initialized CONFIG1 to cover
 	 * at least sync vs async
 	 */
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index ba83900..378ee17 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -180,32 +180,36 @@ retry:
 	interrupt = omap2_onenand_readw(info->onenand.base + ONENAND_REG_INTERRUPT);
 	ctrl = omap2_onenand_readw(info->onenand.base + ONENAND_REG_CTRL_STATUS);
 
-	if (ctrl & ONENAND_CTRL_ERROR) {
-		printk(KERN_ERR "onenand_wait: controller error = 0x%04x\n", ctrl);
-		if (ctrl & ONENAND_CTRL_LOCK)
-			printk(KERN_ERR "onenand_erase: Device is write protected!!!\n");
-		return -EIO;
-	}
-
-	if (ctrl & 0xFE9F)
-		printk(KERN_WARNING "onenand_wait: unexpected controller status = 0x%04x  state = %d  interrupt = 0x%04x\n", ctrl, state, interrupt);
-
 	if (interrupt & ONENAND_INT_READ) {
 		int ecc = omap2_onenand_readw(info->onenand.base + ONENAND_REG_ECC_STATUS);
 		if (ecc) {
+			unsigned addr1 = omap2_onenand_readw(info->onenand.base + ONENAND_REG_START_ADDRESS1);
+			unsigned addr8 = omap2_onenand_readw(info->onenand.base + ONENAND_REG_START_ADDRESS8);
+
 			if (ecc & ONENAND_ECC_2BIT_ALL) {
-				printk(KERN_ERR "onenand_wait: ECC error = 0x%04x\n", ecc);
+				printk(KERN_ERR "onenand_wait: ECC error = 0x%04x, addr1 %#x, addr8 %#x\n", ecc, addr1, addr8);
 				mtd->ecc_stats.failed++;
 				return -EBADMSG;
-			} else if (ecc & ONENAND_ECC_1BIT_ALL)
-				printk(KERN_NOTICE "onenand_wait: correctable ECC error = 0x%04x\n", ecc);
+			} else if (ecc & ONENAND_ECC_1BIT_ALL) {
+				printk(KERN_NOTICE "onenand_wait: correctable ECC error = 0x%04x, addr1 %#x, addr8 %#x\n", ecc, addr1, addr8);
 				mtd->ecc_stats.corrected++;
+			}
 		}
 	} else if (state == FL_READING) {
 		printk(KERN_ERR "onenand_wait: read timeout! ctrl=0x%04x intr=0x%04x\n", ctrl, interrupt);
 		return -EIO;
 	}
 
+	if (ctrl & ONENAND_CTRL_ERROR) {
+		printk(KERN_ERR "onenand_wait: controller error = 0x%04x\n", ctrl);
+		if (ctrl & ONENAND_CTRL_LOCK)
+			printk(KERN_ERR "onenand_erase: Device is write protected!!!\n");
+		return -EIO;
+	}
+
+	if (ctrl & 0xFE9F)
+		printk(KERN_WARNING "onenand_wait: unexpected controller status = 0x%04x  state = %d  interrupt = 0x%04x\n", ctrl, state, interrupt);
+
 	return 0;
 }
 
@@ -223,6 +227,155 @@ static inline int omap2_onenand_bufferram_offset(struct mtd_info *mtd, int area)
 	return 0;
 }
 
+#if defined(CONFIG_ARCH_OMAP3)
+
+static int omap3_onenand_read_bufferram(struct mtd_info *mtd, int area,
+					unsigned char *buffer, int offset,
+					size_t count)
+{
+	struct omap2_onenand *info = container_of(mtd, struct omap2_onenand, mtd);
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
+	dma_src = info->phys_base + bram_offset;
+	dma_dst = dma_map_single(&info->pdev->dev, buf, count, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dma_dst)) {
+		dev_err(&info->pdev->dev,
+			"Couldn't DMA map a %d byte buffer\n",
+			count);
+		goto out_copy;
+	}
+
+	omap_set_dma_transfer_params(info->dma_channel, OMAP_DMA_DATA_TYPE_S32,
+				     count >> 2, 1, 0, 0, 0);
+	omap_set_dma_src_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				dma_src, 0, 0);
+	omap_set_dma_dest_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				 dma_dst, 0, 0);
+
+	INIT_COMPLETION(info->dma_done);
+	omap_start_dma(info->dma_channel);
+
+	timeout = jiffies + msecs_to_jiffies(20);
+	done = &info->dma_done.done;
+	while (time_before(jiffies, timeout))
+		if (*done)
+			break;
+
+	dma_unmap_single(&info->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
+
+	if (!*done) {
+		dev_err(&info->pdev->dev, "timeout waiting for DMA\n");
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
+					 const unsigned char *buffer, int offset,
+					 size_t count)
+{
+	struct omap2_onenand *info = container_of(mtd, struct omap2_onenand, mtd);
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
+	dma_src = dma_map_single(&info->pdev->dev, buf, count, DMA_TO_DEVICE);
+	dma_dst = info->phys_base + bram_offset;
+	if (dma_mapping_error(dma_dst)) {
+		dev_err(&info->pdev->dev,
+			"Couldn't DMA map a %d byte buffer\n",
+			count);
+		return -1;
+	}
+
+	omap_set_dma_transfer_params(info->dma_channel, OMAP_DMA_DATA_TYPE_S32,
+				     count >> 2, 1, 0, 0, 0);
+	omap_set_dma_src_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				dma_src, 0, 0);
+	omap_set_dma_dest_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				 dma_dst, 0, 0);
+
+	INIT_COMPLETION(info->dma_done);
+	omap_start_dma(info->dma_channel);
+
+	timeout = jiffies + msecs_to_jiffies(20);
+	done = &info->dma_done.done;
+	while (time_before(jiffies, timeout))
+		if (*done)
+			break;
+
+	dma_unmap_single(&info->pdev->dev, dma_dst, count, DMA_TO_DEVICE);
+
+	if (!*done) {
+		dev_err(&info->pdev->dev, "timeout waiting for DMA\n");
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
 static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
 					unsigned char *buffer, int offset,
 					size_t count)
@@ -310,6 +463,8 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
 	return 0;
 }
 
+#endif
+
 static struct platform_driver omap2_onenand_driver;
 
 static int __adjust_timing(struct device *dev, void *data)
@@ -439,8 +594,13 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 
 	if (info->dma_channel >= 0) {
 		info->onenand.wait = omap2_onenand_wait;
+#if defined(CONFIG_ARCH_OMAP3)
+		info->onenand.read_bufferram = omap3_onenand_read_bufferram;
+		info->onenand.write_bufferram = omap3_onenand_write_bufferram;
+#else
 		info->onenand.read_bufferram = omap2_onenand_read_bufferram;
 		info->onenand.write_bufferram = omap2_onenand_write_bufferram;
+#endif
 	}
 
 	if ((r = onenand_scan(&info->mtd, 1)) < 0)
diff --git a/include/asm-arm/arch-omap/gpmc.h b/include/asm-arm/arch-omap/gpmc.h
index 57fec44..ef6c4c8 100644
--- a/include/asm-arm/arch-omap/gpmc.h
+++ b/include/asm-arm/arch-omap/gpmc.h
@@ -84,6 +84,10 @@ struct gpmc_timings {
 	u16 access;		/* Start-cycle to first data valid delay */
 	u16 rd_cycle;		/* Total read cycle time */
 	u16 wr_cycle;		/* Total write cycle time */
+
+	/* The following are only on OMAP3430 */
+	u16 wr_access;		/* WRACCESSTIME */
+	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
 };
 
 /* Structure to save gpmc cs context */
diff --git a/include/asm-arm/arch-omap/onenand.h b/include/asm-arm/arch-omap/onenand.h
index f0f28d3..e302371 100644
--- a/include/asm-arm/arch-omap/onenand.h
+++ b/include/asm-arm/arch-omap/onenand.h
@@ -21,3 +21,6 @@ struct omap_onenand_platform_data {
 };
 
 int omap2_onenand_rephase(void);
+
+#define ONENAND_MAX_PARTITIONS 8
+
diff --git a/include/linux/mtd/onenand_regs.h b/include/linux/mtd/onenand_regs.h
index d1b310c..0c6bbe2 100644
--- a/include/linux/mtd/onenand_regs.h
+++ b/include/linux/mtd/onenand_regs.h
@@ -152,6 +152,8 @@
 #define ONENAND_SYS_CFG1_INT		(1 << 6)
 #define ONENAND_SYS_CFG1_IOBE		(1 << 5)
 #define ONENAND_SYS_CFG1_RDY_CONF	(1 << 4)
+#define ONENAND_SYS_CFG1_HF		(1 << 2)
+#define ONENAND_SYS_CFG1_SYNC_WRITE	(1 << 1)
 
 /*
  * Controller Status Register F240h (R)
-- 
1.5.4.3
