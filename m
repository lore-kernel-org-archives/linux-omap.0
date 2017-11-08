From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v2 6/6] mtd: onenand: omap2: Configure driver from DT
Date: Wed, 8 Nov 2017 08:45:26 +0100
Message-ID: <20171108074526.wopdidg7yrsjxlwb@lenoch>
References: <20171108074024.vwcfnqizvd7jajnh@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171108074024.vwcfnqizvd7jajnh@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Kyungmin Park <kyungmin.park@samsung.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Move away from platform data configuration and use pure DT approach.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 -v2: move cleanups into separate patches
      simplify dma setup
      fix checkpatch error
      print info about otimized timings in sync mode only

 drivers/mtd/onenand/omap2.c | 335 +++++++++++++++++++++++++++-----------------
 1 file changed, 209 insertions(+), 126 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 883993bbe40b..ef955f90cac5 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -28,16 +28,17 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/of_device.h>
+#include <linux/omap-gpmc.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include <asm/mach/flash.h>
-#include <linux/platform_data/mtd-onenand-omap2.h>
 
 #include <linux/omap-dma.h>
 
@@ -49,16 +50,21 @@ struct omap2_onenand {
 	struct platform_device *pdev;
 	int gpmc_cs;
 	unsigned long phys_base;
-	unsigned int mem_size;
-	int gpio_irq;
+	struct gpio_desc *gpiod;
 	struct mtd_info mtd;
 	struct onenand_chip onenand;
 	struct completion irq_done;
 	struct completion dma_done;
 	int dma_channel;
-	int freq;
-	int (*setup)(void __iomem *base, int *freq_ptr);
-	u8 flags;
+	bool gpio_quirk;
+};
+
+struct omap2_onenand_devdata {
+	bool gpio_quirk;
+	int (*read_bufferram)(struct mtd_info *mtd, int area,
+			unsigned char *buffer, int offset, size_t count);
+	int (*write_bufferram)(struct mtd_info *mtd, int area,
+			const unsigned char *buffer, int offset, size_t count);
 };
 
 static void omap2_onenand_dma_cb(int lch, u16 ch_status, void *data)
@@ -88,6 +94,65 @@ static inline void write_reg(struct omap2_onenand *c, unsigned short value,
 	writew(value, c->onenand.base + reg);
 }
 
+static int omap2_onenand_set_cfg(struct omap2_onenand *c,
+				 bool sr, bool sw,
+				 int latency, int burst_len)
+{
+	unsigned short reg = ONENAND_SYS_CFG1_RDY | ONENAND_SYS_CFG1_INT;
+
+	reg |= latency << ONENAND_SYS_CFG1_BRL_SHIFT;
+
+	switch (burst_len) {
+	case 0:		/* continuous */
+		break;
+	case 4:
+		reg |= ONENAND_SYS_CFG1_BL_4;
+		break;
+	case 8:
+		reg |= ONENAND_SYS_CFG1_BL_8;
+		break;
+	case 16:
+		reg |= ONENAND_SYS_CFG1_BL_16;
+		break;
+	case 32:
+		reg |= ONENAND_SYS_CFG1_BL_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (latency > 5)
+		reg |= ONENAND_SYS_CFG1_HF;
+	if (latency > 7)
+		reg |= ONENAND_SYS_CFG1_VHF;
+	if (sr)
+		reg |= ONENAND_SYS_CFG1_SYNC_READ;
+	if (sw)
+		reg |= ONENAND_SYS_CFG1_SYNC_WRITE;
+
+	write_reg(c, reg, ONENAND_REG_SYS_CFG1);
+
+	return 0;
+}
+
+static int omap2_onenand_get_freq(int ver)
+{
+	switch ((ver >> 4) & 0xf) {
+	case 0:
+		return 40;
+	case 1:
+		return 54;
+	case 2:
+		return 66;
+	case 3:
+		return 83;
+	case 4:
+		return 104;
+	}
+
+	return -EINVAL;
+}
+
 static void wait_err(char *msg, int state, unsigned int ctrl, unsigned int intr)
 {
 	printk(KERN_ERR "onenand_wait: %s! state %d ctrl 0x%04x intr 0x%04x\n",
@@ -151,23 +216,19 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
 		if (!(syscfg & ONENAND_SYS_CFG1_IOBE)) {
 			syscfg |= ONENAND_SYS_CFG1_IOBE;
 			write_reg(c, syscfg, ONENAND_REG_SYS_CFG1);
-			if (c->flags & ONENAND_IN_OMAP34XX)
+			if (c->gpio_quirk)
 				/* Add a delay to let GPIO settle */
 				syscfg = read_reg(c, ONENAND_REG_SYS_CFG1);
 		}
 
 		reinit_completion(&c->irq_done);
-		if (c->gpio_irq) {
-			result = gpio_get_value(c->gpio_irq);
-			if (result == -1) {
-				ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
-				intr = read_reg(c, ONENAND_REG_INTERRUPT);
-				wait_err("gpio error", state, ctrl, intr);
-				return -EIO;
-			}
-		} else
-			result = 0;
-		if (result == 0) {
+		result = c->gpiod ? gpiod_get_value(c->gpiod) : 0;
+		if (result < 0) {
+			ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
+			intr = read_reg(c, ONENAND_REG_INTERRUPT);
+			wait_err("gpio error", state, ctrl, intr);
+			return result;
+		} else if (result == 0) {
 			int retry_cnt = 0;
 retry:
 			result = wait_for_completion_timeout(&c->irq_done,
@@ -583,126 +644,142 @@ static void omap2_onenand_shutdown(struct platform_device *pdev)
 
 static int omap2_onenand_probe(struct platform_device *pdev)
 {
-	struct omap_onenand_platform_data *pdata;
+	u32 val;
+	int freq, latency, r;
+	unsigned int mem_size;
+	struct resource *res;
 	struct omap2_onenand *c;
 	struct onenand_chip *this;
-	int r;
-	struct resource *res;
+	struct gpmc_onenand_info info;
+	const struct omap2_onenand_devdata *devdata;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "error getting memory resource\n");
+		return -EINVAL;
+	}
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (pdata == NULL) {
-		dev_err(&pdev->dev, "platform data missing\n");
-		return -ENODEV;
+	r = of_property_read_u32(np, "reg", &val);
+	if (r) {
+		dev_err(dev, "reg not found in DT\n");
+		return r;
 	}
 
-	c = kzalloc(sizeof(struct omap2_onenand), GFP_KERNEL);
+	c = devm_kzalloc(dev, sizeof(struct omap2_onenand), GFP_KERNEL);
 	if (!c)
 		return -ENOMEM;
 
 	init_completion(&c->irq_done);
 	init_completion(&c->dma_done);
-	c->flags = pdata->flags;
-	c->gpmc_cs = pdata->cs;
-	c->gpio_irq = pdata->gpio_irq;
-	c->dma_channel = pdata->dma_channel;
-	if (c->dma_channel < 0) {
-		/* if -1, don't use DMA */
-		c->gpio_irq = 0;
-	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		r = -EINVAL;
-		dev_err(&pdev->dev, "error getting memory resource\n");
-		goto err_kfree;
-	}
+	devdata = of_device_get_match_data(dev);
+	this = &c->onenand;
 
+	c->gpmc_cs = val;
+	c->dma_channel = -1;
+	c->gpio_quirk = devdata->gpio_quirk;
 	c->phys_base = res->start;
-	c->mem_size = resource_size(res);
-
-	if (request_mem_region(c->phys_base, c->mem_size,
-			       pdev->dev.driver->name) == NULL) {
-		dev_err(&pdev->dev, "Cannot reserve memory region at 0x%08lx, size: 0x%x\n",
-						c->phys_base, c->mem_size);
-		r = -EBUSY;
-		goto err_kfree;
-	}
-	c->onenand.base = ioremap(c->phys_base, c->mem_size);
-	if (c->onenand.base == NULL) {
-		r = -ENOMEM;
-		goto err_release_mem_region;
-	}
 
-	if (pdata->onenand_setup != NULL) {
-		r = pdata->onenand_setup(c->onenand.base, &c->freq);
-		if (r < 0) {
-			dev_err(&pdev->dev, "Onenand platform setup failed: "
-				"%d\n", r);
-			goto err_iounmap;
-		}
-		c->setup = pdata->onenand_setup;
-	}
+	mem_size = resource_size(res);
+	if (!devm_request_mem_region(dev, c->phys_base, mem_size,
+				     dev->driver->name)) {
 
-	if (c->gpio_irq) {
-		if ((r = gpio_request(c->gpio_irq, "OneNAND irq")) < 0) {
-			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
-				"OneNAND\n", c->gpio_irq);
-			goto err_iounmap;
+		dev_err(dev, "Cannot reserve memory region at 0x%08lx, size: 0x%x\n",
+			c->phys_base, mem_size);
+		return -EBUSY;
 	}
-	gpio_direction_input(c->gpio_irq);
+	c->onenand.base = devm_ioremap(dev, c->phys_base, mem_size);
+	if (!c->onenand.base)
+		return -ENOMEM;
 
-	if ((r = request_irq(gpio_to_irq(c->gpio_irq),
-			     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
-			     pdev->dev.driver->name, c)) < 0)
-		goto err_release_gpio;
+	if (!of_property_read_u32(np, "dma-channel", &val)) {
+		c->dma_channel = val;
+		r = omap_request_dma(0, dev->driver->name,
+					omap2_onenand_dma_cb, (void *)c,
+					&c->dma_channel);
+		if (r) {
+			dev_info(dev, "failed to allocate DMA, using PIO\n");
+			c->dma_channel = -1;
+		}
 	}
 
 	if (c->dma_channel >= 0) {
-		r = omap_request_dma(0, pdev->dev.driver->name,
-				     omap2_onenand_dma_cb, (void *) c,
-				     &c->dma_channel);
-		if (r == 0) {
-			omap_set_dma_write_mode(c->dma_channel,
-						OMAP_DMA_WRITE_NON_POSTED);
-			omap_set_dma_src_data_pack(c->dma_channel, 1);
-			omap_set_dma_src_burst_mode(c->dma_channel,
-						    OMAP_DMA_DATA_BURST_8);
-			omap_set_dma_dest_data_pack(c->dma_channel, 1);
-			omap_set_dma_dest_burst_mode(c->dma_channel,
-						     OMAP_DMA_DATA_BURST_8);
-		} else {
-			dev_info(&pdev->dev,
-				 "failed to allocate DMA for OneNAND, "
-				 "using PIO instead\n");
-			c->dma_channel = -1;
+		this->wait = omap2_onenand_wait;
+		this->read_bufferram = devdata->read_bufferram;
+		this->write_bufferram = devdata->write_bufferram;
+
+		c->gpiod = devm_gpiod_get(dev, "OneNAND irq", GPIOD_IN);
+		if (IS_ERR(c->gpiod)) {
+			r = PTR_ERR(c->gpiod);
+			/* Just try again if this happens */
+			if (r != -EPROBE_DEFER)
+				dev_err(dev, "error getting gpio: %d\n", r);
+			goto err_release_dma;
 		}
+		r = devm_request_irq(dev, gpiod_to_irq(c->gpiod),
+				omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
+				"OneNAND irq", c);
+		if (r)
+			goto err_release_dma;
+
+		omap_set_dma_write_mode(c->dma_channel,
+					OMAP_DMA_WRITE_NON_POSTED);
+		omap_set_dma_src_data_pack(c->dma_channel, 1);
+		omap_set_dma_src_burst_mode(c->dma_channel,
+					    OMAP_DMA_DATA_BURST_8);
+		omap_set_dma_dest_data_pack(c->dma_channel, 1);
+		omap_set_dma_dest_burst_mode(c->dma_channel,
+					     OMAP_DMA_DATA_BURST_8);
 	}
 
-	dev_info(&pdev->dev, "initializing on CS%d, phys base 0x%08lx, virtual "
-		 "base %p, freq %d MHz\n", c->gpmc_cs, c->phys_base,
-		 c->onenand.base, c->freq);
+	dev_info(dev,
+		 "initializing on CS%d, phys base 0x%08lx, virtual base %p\n",
+		 c->gpmc_cs, c->phys_base, c->onenand.base);
 
 	c->pdev = pdev;
 	c->mtd.priv = &c->onenand;
-
 	c->mtd.dev.parent = &pdev->dev;
-	mtd_set_of_node(&c->mtd, pdata->of_node);
-
-	this = &c->onenand;
-	if (c->dma_channel >= 0) {
-		this->wait = omap2_onenand_wait;
-		if (c->flags & ONENAND_IN_OMAP34XX) {
-			this->read_bufferram = omap3_onenand_read_bufferram;
-			this->write_bufferram = omap3_onenand_write_bufferram;
-		} else {
-			this->read_bufferram = omap2_onenand_read_bufferram;
-			this->write_bufferram = omap2_onenand_write_bufferram;
-		}
-	}
+	mtd_set_of_node(&c->mtd, pdev->dev.of_node);
 
 	if ((r = onenand_scan(&c->mtd, 1)) < 0)
 		goto err_release_dma;
 
+	freq = omap2_onenand_get_freq(this->version_id);
+	if (freq > 0) {
+		switch (freq) {
+		case 104:
+			latency = 7;
+			break;
+		case 83:
+			latency = 6;
+			break;
+		case 66:
+			latency = 5;
+			break;
+		case 56:
+			latency = 4;
+			break;
+		default:	/* 40 MHz or lower */
+			latency = 3;
+			break;
+		}
+
+		r = gpmc_omap_onenand_set_timings(dev, c->gpmc_cs,
+						  freq, latency, &info);
+		if (r)
+			goto err_release_onenand;
+
+		r = omap2_onenand_set_cfg(c, info.sync_read, info.sync_write,
+					  latency, info.burst_len);
+		if (r)
+			goto err_release_onenand;
+
+		if (info.sync_read || info.sync_write)
+			dev_info(dev, "optimized timings for %d MHz\n", freq);
+	}
+
 	r = mtd_device_register(&c->mtd, NULL, 0);
 	if (r)
 		goto err_release_onenand;
@@ -716,17 +793,6 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 err_release_dma:
 	if (c->dma_channel != -1)
 		omap_free_dma(c->dma_channel);
-	if (c->gpio_irq)
-		free_irq(gpio_to_irq(c->gpio_irq), c);
-err_release_gpio:
-	if (c->gpio_irq)
-		gpio_free(c->gpio_irq);
-err_iounmap:
-	iounmap(c->onenand.base);
-err_release_mem_region:
-	release_mem_region(c->phys_base, c->mem_size);
-err_kfree:
-	kfree(c);
 
 	return r;
 }
@@ -739,23 +805,40 @@ static int omap2_onenand_remove(struct platform_device *pdev)
 	if (c->dma_channel != -1)
 		omap_free_dma(c->dma_channel);
 	omap2_onenand_shutdown(pdev);
-	if (c->gpio_irq) {
-		free_irq(gpio_to_irq(c->gpio_irq), c);
-		gpio_free(c->gpio_irq);
-	}
-	iounmap(c->onenand.base);
-	release_mem_region(c->phys_base, c->mem_size);
-	kfree(c);
 
 	return 0;
 }
 
+static const struct omap2_onenand_devdata omap2_devdata = {
+	.gpio_quirk = false,
+	.read_bufferram = omap2_onenand_read_bufferram,
+	.write_bufferram = omap2_onenand_write_bufferram,
+};
+
+static const struct omap2_onenand_devdata omap3_devdata = {
+	.gpio_quirk = true,
+	.read_bufferram = omap3_onenand_read_bufferram,
+	.write_bufferram = omap3_onenand_write_bufferram,
+};
+
+static const struct of_device_id omap2_onenand_ids[] = {
+	{
+		.compatible = "ti,omap2-onenand",
+		.data = &omap2_devdata,
+	}, {
+		.compatible = "ti,omap3-onenand",
+		.data = &omap3_devdata,
+	}, {},
+};
+MODULE_DEVICE_TABLE(of, omap2_onenand_ids);
+
 static struct platform_driver omap2_onenand_driver = {
 	.probe		= omap2_onenand_probe,
 	.remove		= omap2_onenand_remove,
 	.shutdown	= omap2_onenand_shutdown,
 	.driver		= {
 		.name	= DRIVER_NAME,
+		.of_match_table = of_match_ptr(omap2_onenand_ids),
 	},
 };
 
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
