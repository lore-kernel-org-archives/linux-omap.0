From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Basic N800 support
Date: Fri, 26 Jan 2007 13:31:27 -0800
Message-ID: <20070126213126.GH29286@atomide.com>
References: <20070119205723.GC16754@atomide.com>
	<45B1BEE7.2000603@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45B1BEE7.2000603@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Dirk Behme <dirk.behme@googlemail.com> [070119 23:04]:
> Tony Lindgren wrote:
> >Here's a quick patch of N800 support against the current git tree
> 
> The following patches fix some minor warnings for 
> n800_defconfig compilation. Apply them on top of 
> patch-n800-add-minimal and patch-n800-pm-changes.

Cool. I've split up and pushed the N800 core support.
Following two patches are still needed to compile and
mount root.

Regards,

Tony

--d6Gm4EdcadzBjdND
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="01-onenand.patch"

--- a/drivers/mtd/onenand/Kconfig
+++ b/drivers/mtd/onenand/Kconfig
@@ -29,6 +29,13 @@
 	help
 	  Support for OneNAND flash via platform device driver.
 
+config MTD_ONENAND_OMAP2
+	tristate "OneNAND on OMAP2 support"
+	depends on MTD_ONENAND && ARCH_OMAP2
+	help
+	  Support for a OneNAND flash device connected to an OMAP2 CPU
+	  via the GPMC memory controller.
+
 config MTD_ONENAND_OTP
 	bool "OneNAND OTP Support"
 	depends on MTD_ONENAND
--- a/drivers/mtd/onenand/Makefile
+++ b/drivers/mtd/onenand/Makefile
@@ -7,5 +7,6 @@
 
 # Board specific.
 obj-$(CONFIG_MTD_ONENAND_GENERIC)	+= generic.o
+obj-$(CONFIG_MTD_ONENAND_OMAP2)		+= omap2.o
 
 onenand-objs = onenand_base.o onenand_bbt.o
+++ b/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -0,0 +1,545 @@
+/*
+ *  linux/drivers/mtd/onenand/omap2.c
+ *
+ *  OneNAND driver for OMAP2
+ *
+ *  Copyright (C) 2005-2006 Nokia Corporation
+ *
+ *  Author: Jarkko Lavinen <jarkko.lavinen@nokia.com> and Juha Yrjola
+ *  IRQ and DMA support written by Timo Teras
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; see the file COPYING. If not, write to the Free Software
+ * Foundation, 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/onenand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+
+#include <asm/io.h>
+#include <asm/mach/flash.h>
+#include <asm/arch/gpmc.h>
+#include <asm/arch/onenand.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/gpmc.h>
+#include <asm/arch/pm.h>
+
+#include <linux/dma-mapping.h>
+#include <asm/dma-mapping.h>
+#include <asm/arch/dma.h>
+
+#include <asm/arch/board.h>
+
+#define ONENAND_IO_SIZE		SZ_128K
+
+struct omap2_onenand {
+	struct platform_device *pdev;
+	int gpmc_cs;
+	unsigned long phys_base;
+	int gpio_irq;
+	struct mtd_info mtd;
+	struct mtd_partition *parts;
+	struct onenand_chip onenand;
+	struct completion irq_done;
+	struct completion dma_done;
+	int dma_channel;
+};
+
+static unsigned short omap2_onenand_readw(void __iomem *addr)
+{
+	return readw(addr);
+}
+
+static void omap2_onenand_writew(unsigned short value, void __iomem *addr)
+{
+	writew(value, addr);
+}
+
+static void omap2_onenand_dma_cb(int lch, u16 ch_status, void *data)
+{
+	struct omap2_onenand *info = data;
+
+	complete(&info->dma_done);
+}
+
+static irqreturn_t omap2_onenand_interrupt(int irq, void *dev_id)
+{
+	struct omap2_onenand *info = dev_id;
+
+	complete(&info->irq_done);
+
+	return IRQ_HANDLED;
+}
+
+static int omap2_onenand_wait(struct mtd_info *mtd, int state)
+{
+	struct omap2_onenand *info = container_of(mtd, struct omap2_onenand, mtd);
+	struct onenand_chip *this = mtd->priv;
+	unsigned int interrupt = 0;
+	unsigned int ctrl, ecc;
+	unsigned long timeout;
+	u32 syscfg;
+
+	if (state == FL_RESETING) {
+		udelay(1);
+		return 0;
+	}
+
+	if (state != FL_READING) {
+		/* Turn interrupts on */
+		syscfg = omap2_onenand_readw(info->onenand.base + ONENAND_REG_SYS_CFG1);
+		syscfg |= ONENAND_SYS_CFG1_IOBE;
+		omap2_onenand_writew(syscfg, info->onenand.base + ONENAND_REG_SYS_CFG1);
+
+		INIT_COMPLETION(info->irq_done);
+		if (!omap_get_gpio_datain(info->gpio_irq)) {
+			wait_for_completion_timeout(&info->irq_done,
+						    msecs_to_jiffies(20));
+		}
+	} else {
+		/* Turn interrupts off */
+		syscfg = omap2_onenand_readw(info->onenand.base + ONENAND_REG_SYS_CFG1);
+		syscfg &= ~ONENAND_SYS_CFG1_IOBE;
+		omap2_onenand_writew(syscfg, info->onenand.base + ONENAND_REG_SYS_CFG1);
+
+		timeout = jiffies + msecs_to_jiffies(20);
+		while (time_before(jiffies, timeout)) {
+			if (omap2_onenand_readw(info->onenand.base + ONENAND_REG_INTERRUPT) &
+			    ONENAND_INT_MASTER)
+				break;
+		}
+	}
+
+	/* To get correct interrupt status in timeout case */
+	interrupt = this->read_word(this->base + ONENAND_REG_INTERRUPT);
+	ctrl = this->read_word(this->base + ONENAND_REG_CTRL_STATUS);
+
+	if (ctrl & ONENAND_CTRL_ERROR) {
+		/* It maybe occur at initial bad block */
+		DEBUG(MTD_DEBUG_LEVEL0, "onenand_wait: controller error = 0x%04x\n", ctrl);
+		/* Clear other interrupt bits for preventing ECC error */
+		interrupt &= ONENAND_INT_MASTER;
+	}
+
+	if (ctrl & ONENAND_CTRL_LOCK) {
+		DEBUG(MTD_DEBUG_LEVEL0, "onenand_wait: it's locked error = 0x%04x\n", ctrl);
+		return -EACCES;
+	}
+
+	if (interrupt & ONENAND_INT_READ) {
+		ecc = this->read_word(this->base + ONENAND_REG_ECC_STATUS);
+		if (ecc & ONENAND_ECC_2BIT_ALL) {
+			DEBUG(MTD_DEBUG_LEVEL0, "onenand_wait: ECC error = 0x%04x\n", ecc);
+			return -EBADMSG;
+		}
+	}
+
+	return 0;
+}
+
+static inline int omap2_onenand_bufferram_offset(struct mtd_info *mtd, int area)
+{
+	struct onenand_chip *this = mtd->priv;
+
+	if (ONENAND_CURRENT_BUFFERRAM(this)) {
+		if (area == ONENAND_DATARAM)
+			return mtd->writesize;
+		if (area == ONENAND_SPARERAM)
+			return mtd->oobsize;
+	}
+
+	return 0;
+}
+
+static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
+					unsigned char *buffer, int offset,
+					size_t count)
+{
+	struct omap2_onenand *info = container_of(mtd, struct omap2_onenand, mtd);
+	struct onenand_chip *this = mtd->priv;
+	dma_addr_t dma_src, dma_dst;
+	int bram_offset;
+
+	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
+	if ((info->dma_channel < 0) || ((void *) buffer >= (void *) high_memory) ||
+	    (bram_offset & 3) || (((unsigned int) buffer) & 3) ||
+	    (count < 1024) || (count & 3)) {
+		memcpy(buffer, (void *)(this->base + bram_offset), count);
+		return 0;
+	}
+
+	dma_src = info->phys_base + bram_offset;
+	dma_dst = dma_map_single(&info->pdev->dev, buffer, count, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dma_dst)) {
+		dev_err(&info->pdev->dev,
+			"Couldn't DMA map a %d byte buffer\n",
+			count);
+		return -1;
+	}
+
+	omap_set_dma_transfer_params(info->dma_channel, OMAP_DMA_DATA_TYPE_S32,
+				     count / 4, 1, 0, 0, 0);
+	omap_set_dma_src_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				dma_src, 0, 0);
+	omap_set_dma_dest_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				 dma_dst, 0, 0);
+
+	INIT_COMPLETION(info->dma_done);
+	omap2_block_sleep();
+	omap_start_dma(info->dma_channel);
+	wait_for_completion(&info->dma_done);
+	omap2_allow_sleep();
+
+	dma_unmap_single(&info->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
+
+	return 0;
+}
+
+static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
+					 const unsigned char *buffer, int offset,
+					 size_t count)
+{
+	struct omap2_onenand *info = container_of(mtd, struct omap2_onenand, mtd);
+	struct onenand_chip *this = mtd->priv;
+	dma_addr_t dma_src, dma_dst;
+	int bram_offset;
+
+	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
+	if ((info->dma_channel < 0) || ((void *) buffer >= (void *) high_memory) ||
+	    (bram_offset & 3) || (((unsigned int) buffer) & 3) ||
+	    (count < 1024) || (count & 3)) {
+		memcpy((void *)(this->base + bram_offset), buffer, count);
+		return 0;
+	}
+
+	dma_src = dma_map_single(&info->pdev->dev, (void *) buffer, count,
+				 DMA_TO_DEVICE);
+	dma_dst = info->phys_base + bram_offset;
+	if (dma_mapping_error(dma_dst)) {
+		dev_err(&info->pdev->dev,
+			"Couldn't DMA map a %d byte buffer\n",
+			count);
+		return -1;
+	}
+
+	omap_set_dma_transfer_params(info->dma_channel, OMAP_DMA_DATA_TYPE_S16,
+				     count / 2, 1, 0, 0, 0);
+	omap_set_dma_src_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				dma_src, 0, 0);
+	omap_set_dma_dest_params(info->dma_channel, 0, OMAP_DMA_AMODE_POST_INC,
+				 dma_dst, 0, 0);
+
+	INIT_COMPLETION(info->dma_done);
+	omap_start_dma(info->dma_channel);
+	wait_for_completion(&info->dma_done);
+
+	dma_unmap_single(&info->pdev->dev, dma_dst, count, DMA_TO_DEVICE);
+
+	return 0;
+}
+
+static int omap2_onenand_set_async_mode(struct omap2_onenand *info)
+{
+	struct gpmc_timings t;
+
+	memset(&t, 0, sizeof(t));
+	t.sync_clk = 0;
+	t.cs_on = 0;
+	t.adv_on = gpmc_round_ns_to_ticks(1);
+
+	/* FIXME: Get timings from platform data */
+	/* Read */
+	t.adv_rd_off = t.adv_on + gpmc_round_ns_to_ticks(12);
+	t.oe_on = t.adv_rd_off + gpmc_round_ns_to_ticks(1);
+	t.access = t.oe_on + gpmc_round_ns_to_ticks(35);
+	t.oe_off = t.access + gpmc_round_ns_to_ticks(1);
+	t.cs_rd_off = t.oe_off;
+	t.rd_cycle = t.cs_rd_off + gpmc_round_ns_to_ticks(15);
+
+	/* Write */
+	t.adv_wr_off = t.adv_on + gpmc_round_ns_to_ticks(12);
+	t.we_on = t.adv_wr_off + gpmc_round_ns_to_ticks(1);
+	t.we_off = t.we_on + gpmc_round_ns_to_ticks(30);
+	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(1);
+	t.wr_cycle = t.cs_wr_off + gpmc_round_ns_to_ticks(15);
+
+	/* Configure GPMC for asynchronous read */
+	gpmc_cs_write_reg(info->gpmc_cs, GPMC_CS_CONFIG1,
+			  GPMC_CONFIG1_READTYPE_ASYNC |
+			  GPMC_CONFIG1_DEVICESIZE_16 |
+			  GPMC_CONFIG1_DEVICETYPE_NOR |
+			  GPMC_CONFIG1_MUXADDDATA);
+
+	return gpmc_cs_set_timings(info->gpmc_cs, &t);
+}
+
+static int omap2_onenand_set_sync_mode(struct omap2_onenand *info)
+{
+	const int min_gpmc_clk_period = 18;
+	struct gpmc_timings t;
+	int tick_ns, div, fclk_offset_ns, fclk_offset, gpmc_clk_ns, latency, cs;
+	u32 reg;
+
+	cs = info->gpmc_cs;
+	tick_ns = gpmc_round_ns_to_ticks(1);
+	div = gpmc_cs_calc_divider(cs, min_gpmc_clk_period);
+	gpmc_clk_ns = div * tick_ns;
+	if (gpmc_clk_ns >= 24)
+		latency = 3;
+	else
+		latency = 4;
+
+	/* Configure OneNAND for sync read */
+	reg = omap2_onenand_readw(info->onenand.base + ONENAND_REG_SYS_CFG1);
+	reg &= ~((0x7 << ONENAND_SYS_CFG1_BRL_SHIFT) | (0x7 << 9));
+	reg |=	(latency << ONENAND_SYS_CFG1_BRL_SHIFT) |
+		ONENAND_SYS_CFG1_SYNC_READ |
+		ONENAND_SYS_CFG1_BL_16;
+	omap2_onenand_writew(reg, info->onenand.base + ONENAND_REG_SYS_CFG1);
+
+	/* FIXME: Get timings from platform data */
+	/* Set syncronous read timings */
+	memset(&t, 0, sizeof(t));
+	t.sync_clk = min_gpmc_clk_period;
+	t.cs_on = 0;
+	t.adv_on = gpmc_round_ns_to_ticks(7);
+	fclk_offset_ns = t.adv_on + gpmc_round_ns_to_ticks(7);
+	fclk_offset = fclk_offset_ns / gpmc_round_ns_to_ticks(1);
+	t.page_burst_access = gpmc_clk_ns;
+
+	/* Read */
+	t.adv_rd_off = fclk_offset_ns + gpmc_round_ns_to_ticks(7);
+	t.oe_on = t.adv_rd_off;
+	t.access = fclk_offset_ns + (latency + 1) * gpmc_clk_ns;
+	t.oe_off = t.access + gpmc_round_ns_to_ticks(1);
+	t.cs_rd_off = t.oe_off;
+	t.rd_cycle = t.cs_rd_off + gpmc_round_ns_to_ticks(17);
+
+	/* Write */
+	t.adv_wr_off = t.adv_on + gpmc_round_ns_to_ticks(12);
+	t.we_on = t.adv_wr_off + gpmc_round_ns_to_ticks(1);
+	t.we_off = t.we_on + gpmc_round_ns_to_ticks(40);
+	t.cs_wr_off = t.we_off + gpmc_round_ns_to_ticks(1);
+	t.wr_cycle = t.cs_wr_off + gpmc_round_ns_to_ticks(1);
+
+	/* Configure GPMC for synchronous read */
+	fclk_offset %= div;
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1,
+			  GPMC_CONFIG1_WRAPBURST_SUPP |
+			  GPMC_CONFIG1_READMULTIPLE_SUPP |
+			  GPMC_CONFIG1_READTYPE_SYNC |
+			  GPMC_CONFIG1_CLKACTIVATIONTIME(fclk_offset) |
+			  GPMC_CONFIG1_PAGE_LEN(2) |
+			  GPMC_CONFIG1_WAIT_READ_MON |
+			  GPMC_CONFIG1_WAIT_PIN_SEL(0) |
+			  GPMC_CONFIG1_DEVICESIZE_16 |
+			  GPMC_CONFIG1_DEVICETYPE_NOR |
+			  GPMC_CONFIG1_MUXADDDATA);
+
+	return gpmc_cs_set_timings(cs, &t);
+}
+
+static int __devinit omap2_onenand_probe(struct platform_device *pdev)
+{
+	struct omap_onenand_platform_data *pdata;
+	struct omap2_onenand *info;
+	int r;
+
+	pdata = pdev->dev.platform_data;
+	if (pdata == NULL) {
+		dev_err(&pdev->dev, "platform data missing\n");
+		return -ENODEV;
+	}
+
+	info = kzalloc(sizeof(struct omap2_onenand), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	init_completion(&info->irq_done);
+	init_completion(&info->dma_done);
+	info->gpmc_cs = pdata->cs;
+	info->gpio_irq = pdata->gpio_irq;
+
+	r = gpmc_cs_request(info->gpmc_cs, ONENAND_IO_SIZE, &info->phys_base);
+	if (r < 0) {
+		dev_err(&pdev->dev, "Cannot request GPMC CS\n");
+		goto err_kfree;
+	}
+
+	if (request_mem_region(info->phys_base, ONENAND_IO_SIZE,
+			       pdev->dev.driver->name) == NULL) {
+		dev_err(&pdev->dev, "Cannot reserve memory region at 0x%08lx, size: 0x%x\n",
+			info->phys_base, ONENAND_IO_SIZE);
+		r = -EBUSY;
+		goto err_free_cs;
+	}
+	info->onenand.base = ioremap(info->phys_base, ONENAND_IO_SIZE);
+	if (info->onenand.base == NULL) {
+		r = -ENOMEM;
+		goto err_release_mem_region;
+	}
+
+	/* Force OneNAND to async mode */
+	omap2_onenand_writew(ONENAND_SYS_CFG1_BRL_4 | ONENAND_SYS_CFG1_RDY |
+			     ONENAND_SYS_CFG1_INT, info->onenand.base + ONENAND_REG_SYS_CFG1);
+
+	/* Set async timings in GPMC */
+	if (omap2_onenand_set_async_mode(info) < 0) {
+		dev_err(&pdev->dev, "Unable to set async mode\n");
+		r = -EINVAL;
+		goto err_iounmap;
+	}
+
+	if ((r = omap_request_gpio(info->gpio_irq)) < 0) {
+		dev_err(&pdev->dev,  "Failed to request GPIO%d for OneNAND\n",
+		        info->gpio_irq);
+		goto err_iounmap;
+	}
+	omap_set_gpio_direction(info->gpio_irq, 1);
+
+	if ((r = request_irq(OMAP_GPIO_IRQ(info->gpio_irq),
+			     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
+			     pdev->dev.driver->name, info)) < 0)
+		goto err_release_gpio;
+
+	r = omap_request_dma(0, pdev->dev.driver->name,
+			     omap2_onenand_dma_cb, (void *) info,
+			     &info->dma_channel);
+	if (r == 0) {
+		omap_set_dma_write_mode(info->dma_channel, OMAP_DMA_WRITE_NON_POSTED);
+		omap_set_dma_src_data_pack(info->dma_channel, 1);
+		omap_set_dma_src_burst_mode(info->dma_channel, OMAP_DMA_DATA_BURST_8);
+		omap_set_dma_dest_data_pack(info->dma_channel, 1);
+		omap_set_dma_dest_burst_mode(info->dma_channel, OMAP_DMA_DATA_BURST_8);
+	} else {
+		dev_info(&pdev->dev,
+			 "failed to allocate DMA for OneNAND, using PIO instead\n");
+		info->dma_channel = -1;
+	}
+
+	dev_info(&pdev->dev, "initializing on CS%d, phys base 0x%08lx, virtual base %p\n",
+		 info->gpmc_cs, info->phys_base, info->onenand.base);
+
+	info->pdev = pdev;
+	info->mtd.name = pdev->dev.bus_id;
+	info->mtd.priv = &info->onenand;
+	info->mtd.owner = THIS_MODULE;
+	info->onenand.wait = omap2_onenand_wait;
+	info->onenand.read_bufferram = omap2_onenand_read_bufferram;
+	info->onenand.write_bufferram = omap2_onenand_write_bufferram;
+
+	if ((r = onenand_scan(&info->mtd, 1)) < 0)
+		goto err_release_dma;
+
+	if (omap2_onenand_set_sync_mode(info) < 0) {
+		dev_err(&pdev->dev, "Unable to set sync mode\n");
+		r = -EINVAL;
+		goto err_release_onenand;
+	}
+
+#ifdef CONFIG_MTD_PARTITIONS
+	if (pdata->parts != NULL)
+		r = add_mtd_partitions(&info->mtd, pdata->parts, pdata->nr_parts);
+	else
+#endif
+		r = add_mtd_device(&info->mtd);
+	if (r < 0)
+		goto err_release_onenand;
+
+	platform_set_drvdata(pdev, info);
+
+	return 0;
+
+err_release_onenand:
+	onenand_release(&info->mtd);
+err_release_dma:
+	if (info->dma_channel != -1)
+		omap_free_dma(info->dma_channel);
+	free_irq(OMAP_GPIO_IRQ(info->gpio_irq), info);
+err_release_gpio:
+	omap_free_gpio(info->gpio_irq);
+err_iounmap:
+	iounmap(info->onenand.base);
+err_release_mem_region:
+	release_mem_region(info->phys_base, ONENAND_IO_SIZE);
+err_free_cs:
+	gpmc_cs_free(info->gpmc_cs);
+err_kfree:
+	kfree(info);
+
+	return r;
+}
+
+static int __devexit omap2_onenand_remove(struct platform_device *pdev)
+{
+	struct omap2_onenand *info = dev_get_drvdata(&pdev->dev);
+
+	BUG_ON(info == NULL);
+
+#ifdef CONFIG_MTD_PARTITIONS
+	if (info->parts)
+		del_mtd_partitions(&info->mtd);
+	else
+		del_mtd_device(&info->mtd);
+#else
+	del_mtd_device(&info->mtd);
+#endif
+
+	onenand_release(&info->mtd);
+	if (info->dma_channel != -1)
+		omap_free_dma(info->dma_channel);
+	platform_set_drvdata(pdev, NULL);
+	free_irq(OMAP_GPIO_IRQ(info->gpio_irq), info);
+	omap_free_gpio(info->gpio_irq);
+	iounmap(info->onenand.base);
+	release_mem_region(info->phys_base, ONENAND_IO_SIZE);
+	kfree(info);
+
+	return 0;
+}
+
+static struct platform_driver omap2_onenand_driver = {
+	.probe		= omap2_onenand_probe,
+	.remove		= omap2_onenand_remove,
+	.driver		= {
+		.name	= "omap2-onenand",
+		.owner  = THIS_MODULE,
+	},
+};
+
+MODULE_ALIAS(DRIVER_NAME);
+
+static int __init omap2_onenand_init(void)
+{
+	printk(KERN_INFO "OMAP2 OneNAND driver initializing\n");
+	return platform_driver_register(&omap2_onenand_driver);
+}
+
+static void __exit omap2_onenand_exit(void)
+{
+	platform_driver_unregister(&omap2_onenand_driver);
+}
+
+module_init(omap2_onenand_init);
+module_exit(omap2_onenand_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jarkko Lavinen <jarkko.lavinen@nokia.com>");
+MODULE_DESCRIPTION("Glue layer for OneNAND flash on OMAP2");

--d6Gm4EdcadzBjdND
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="02-mach-types-hack.patch"

--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -767,6 +767,7 @@
 e330			MACH_E330		E330			753
 rt3000			MACH_RT3000		RT3000			754
 nokia770		MACH_NOKIA770		NOKIA770		755
+nokia_n800		MACH_NOKIA_N800		NOKIA_N800		5555
 pnx0106			MACH_PNX0106		PNX0106			756
 hx21xx			MACH_HX21XX		HX21XX			757
 faraday			MACH_FARADAY		FARADAY			758

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--d6Gm4EdcadzBjdND--
