From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v6 13/14] mtd: onenand: omap2: Configure driver from DT
Date: Fri, 12 Jan 2018 14:17:25 +0100
Message-ID: <20180112131725.GN13810@lenoch>
References: <20180112131105.GA13810@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180112131105.GA13810@lenoch>
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Move away from platform data configuration and use pure DT approach.

Use generic probe function to deal with OneNAND node and remove now useless
gpmc_probe_onenand_child function. Import sync mode timing calculation
function from mach-omap2/gpmc-onenand.c

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---

Changes in v6:
- squashed with previous patch

Changes in v5:
- rename ready_gpiod to int_gpiod
- use int-gpios as property name
- use devm_ioremap_resource
- "onenand" is now requested irq name
- add Kconfig dependencies
- make gpmc_omap_onenand_set_timings decsription more descriptive

Changes in v4: None
Changes in v3:
- remove 'ti,omap3-onenand' compatible as it is not needed anymore

Changes in v2:
- move cleanups into separate patches
- simplify dma setup
- fix checkpatch error
- print info about otimized timings in sync mode only
- add gpmc_omap_onenand_set_timings description

 drivers/memory/omap-gpmc.c  | 158 ++++++++++++++++++++--------
 drivers/mtd/onenand/Kconfig |   4 +-
 drivers/mtd/onenand/omap2.c | 250 +++++++++++++++++++++++++++-----------------
 include/linux/omap-gpmc.h   |  28 +++++
 4 files changed, 301 insertions(+), 139 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 0e30ee1c8677..90a66b3f7ae1 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -32,7 +32,6 @@
 #include <linux/pm_runtime.h>
 
 #include <linux/platform_data/mtd-nand-omap2.h>
-#include <linux/platform_data/mtd-onenand-omap2.h>
 
 #include <asm/mach-types.h>
 
@@ -1138,6 +1137,112 @@ struct gpmc_nand_ops *gpmc_omap_get_nand_ops(struct gpmc_nand_regs *reg, int cs)
 }
 EXPORT_SYMBOL_GPL(gpmc_omap_get_nand_ops);
 
+static void gpmc_omap_onenand_calc_sync_timings(struct gpmc_timings *t,
+						struct gpmc_settings *s,
+						int freq, int latency)
+{
+	struct gpmc_device_timings dev_t;
+	const int t_cer  = 15;
+	const int t_avdp = 12;
+	const int t_cez  = 20; /* max of t_cez, t_oez */
+	const int t_wpl  = 40;
+	const int t_wph  = 30;
+	int min_gpmc_clk_period, t_ces, t_avds, t_avdh, t_ach, t_aavdh, t_rdyo;
+
+	switch (freq) {
+	case 104:
+		min_gpmc_clk_period = 9600; /* 104 MHz */
+		t_ces   = 3;
+		t_avds  = 4;
+		t_avdh  = 2;
+		t_ach   = 3;
+		t_aavdh = 6;
+		t_rdyo  = 6;
+		break;
+	case 83:
+		min_gpmc_clk_period = 12000; /* 83 MHz */
+		t_ces   = 5;
+		t_avds  = 4;
+		t_avdh  = 2;
+		t_ach   = 6;
+		t_aavdh = 6;
+		t_rdyo  = 9;
+		break;
+	case 66:
+		min_gpmc_clk_period = 15000; /* 66 MHz */
+		t_ces   = 6;
+		t_avds  = 5;
+		t_avdh  = 2;
+		t_ach   = 6;
+		t_aavdh = 6;
+		t_rdyo  = 11;
+		break;
+	default:
+		min_gpmc_clk_period = 18500; /* 54 MHz */
+		t_ces   = 7;
+		t_avds  = 7;
+		t_avdh  = 7;
+		t_ach   = 9;
+		t_aavdh = 7;
+		t_rdyo  = 15;
+		break;
+	}
+
+	/* Set synchronous read timings */
+	memset(&dev_t, 0, sizeof(dev_t));
+
+	if (!s->sync_write) {
+		dev_t.t_avdp_w = max(t_avdp, t_cer) * 1000;
+		dev_t.t_wpl = t_wpl * 1000;
+		dev_t.t_wph = t_wph * 1000;
+		dev_t.t_aavdh = t_aavdh * 1000;
+	}
+	dev_t.ce_xdelay = true;
+	dev_t.avd_xdelay = true;
+	dev_t.oe_xdelay = true;
+	dev_t.we_xdelay = true;
+	dev_t.clk = min_gpmc_clk_period;
+	dev_t.t_bacc = dev_t.clk;
+	dev_t.t_ces = t_ces * 1000;
+	dev_t.t_avds = t_avds * 1000;
+	dev_t.t_avdh = t_avdh * 1000;
+	dev_t.t_ach = t_ach * 1000;
+	dev_t.cyc_iaa = (latency + 1);
+	dev_t.t_cez_r = t_cez * 1000;
+	dev_t.t_cez_w = dev_t.t_cez_r;
+	dev_t.cyc_aavdh_oe = 1;
+	dev_t.t_rdyo = t_rdyo * 1000 + min_gpmc_clk_period;
+
+	gpmc_calc_timings(t, s, &dev_t);
+}
+
+int gpmc_omap_onenand_set_timings(struct device *dev, int cs, int freq,
+				  int latency,
+				  struct gpmc_onenand_info *info)
+{
+	int ret;
+	struct gpmc_timings gpmc_t;
+	struct gpmc_settings gpmc_s;
+
+	gpmc_read_settings_dt(dev->of_node, &gpmc_s);
+
+	info->sync_read = gpmc_s.sync_read;
+	info->sync_write = gpmc_s.sync_write;
+	info->burst_len = gpmc_s.burst_len;
+
+	if (!gpmc_s.sync_read && !gpmc_s.sync_write)
+		return 0;
+
+	gpmc_omap_onenand_calc_sync_timings(&gpmc_t, &gpmc_s, freq, latency);
+
+	ret = gpmc_cs_program_settings(cs, &gpmc_s);
+	if (ret < 0)
+		return ret;
+
+	return gpmc_cs_set_timings(cs, &gpmc_t, &gpmc_s);
+}
+EXPORT_SYMBOL_GPL(gpmc_omap_onenand_set_timings);
+
 int gpmc_get_client_irq(unsigned irq_config)
 {
 	if (!gpmc_irq_domain) {
@@ -1916,41 +2021,6 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 		of_property_read_bool(np, "gpmc,time-para-granularity");
 }
 
-#if IS_ENABLED(CONFIG_MTD_ONENAND)
-static int gpmc_probe_onenand_child(struct platform_device *pdev,
-				 struct device_node *child)
-{
-	u32 val;
-	struct omap_onenand_platform_data *gpmc_onenand_data;
-
-	if (of_property_read_u32(child, "reg", &val) < 0) {
-		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
-			child);
-		return -ENODEV;
-	}
-
-	gpmc_onenand_data = devm_kzalloc(&pdev->dev, sizeof(*gpmc_onenand_data),
-					 GFP_KERNEL);
-	if (!gpmc_onenand_data)
-		return -ENOMEM;
-
-	gpmc_onenand_data->cs = val;
-	gpmc_onenand_data->of_node = child;
-	gpmc_onenand_data->dma_channel = -1;
-
-	if (!of_property_read_u32(child, "dma-channel", &val))
-		gpmc_onenand_data->dma_channel = val;
-
-	return gpmc_onenand_init(gpmc_onenand_data);
-}
-#else
-static int gpmc_probe_onenand_child(struct platform_device *pdev,
-				    struct device_node *child)
-{
-	return 0;
-}
-#endif
-
 /**
  * gpmc_probe_generic_child - configures the gpmc for a child device
  * @pdev:	pointer to gpmc platform device
@@ -2053,6 +2123,16 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 		}
 	}
 
+	if (of_node_cmp(child->name, "onenand") == 0) {
+		/* Warn about older DT blobs with no compatible property */
+		if (!of_property_read_bool(child, "compatible")) {
+			dev_warn(&pdev->dev,
+				 "Incompatible OneNAND node: missing compatible");
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
 	if (of_device_is_compatible(child, "ti,omap2-nand")) {
 		/* NAND specific setup */
 		val = 8;
@@ -2189,11 +2269,7 @@ static void gpmc_probe_dt_children(struct platform_device *pdev)
 		if (!child->name)
 			continue;
 
-		if (of_node_cmp(child->name, "onenand") == 0)
-			ret = gpmc_probe_onenand_child(pdev, child);
-		else
-			ret = gpmc_probe_generic_child(pdev, child);
-
+		ret = gpmc_probe_generic_child(pdev, child);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to probe DT child '%s': %d\n",
 				child->name, ret);
diff --git a/drivers/mtd/onenand/Kconfig b/drivers/mtd/onenand/Kconfig
index aaeb30458139..9dc15748947b 100644
--- a/drivers/mtd/onenand/Kconfig
+++ b/drivers/mtd/onenand/Kconfig
@@ -25,9 +25,11 @@ config MTD_ONENAND_GENERIC
 config MTD_ONENAND_OMAP2
 	tristate "OneNAND on OMAP2/OMAP3 support"
 	depends on ARCH_OMAP2 || ARCH_OMAP3
+	depends on OF || COMPILE_TEST
 	help
-	  Support for a OneNAND flash device connected to an OMAP2/OMAP3 CPU
+	  Support for a OneNAND flash device connected to an OMAP2/OMAP3 SoC
 	  via the GPMC memory controller.
+	  Enable dmaengine and gpiolib for better performance.
 
 config MTD_ONENAND_SAMSUNG
         tristate "OneNAND on Samsung SOC controller support"
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 1cd78a076759..2ce73fb6da1c 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -28,6 +28,8 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/of_device.h>
+#include <linux/omap-gpmc.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -35,10 +37,9 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include <asm/mach/flash.h>
-#include <linux/platform_data/mtd-onenand-omap2.h>
 
 #define DRIVER_NAME "omap2-onenand"
 
@@ -48,15 +49,12 @@ struct omap2_onenand {
 	struct platform_device *pdev;
 	int gpmc_cs;
 	unsigned long phys_base;
-	unsigned int mem_size;
-	int gpio_irq;
+	struct gpio_desc *int_gpiod;
 	struct mtd_info mtd;
 	struct onenand_chip onenand;
 	struct completion irq_done;
 	struct completion dma_done;
 	struct dma_chan *dma_chan;
-	int freq;
-	int (*setup)(void __iomem *base, int *freq_ptr);
 };
 
 static void omap2_onenand_dma_complete_func(void *completion)
@@ -84,6 +82,65 @@ static inline void write_reg(struct omap2_onenand *c, unsigned short value,
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
@@ -152,12 +209,12 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
 		}
 
 		reinit_completion(&c->irq_done);
-		result = gpio_get_value(c->gpio_irq);
+		result = gpiod_get_value(c->int_gpiod);
 		if (result < 0) {
 			ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
 			intr = read_reg(c, ONENAND_REG_INTERRUPT);
 			wait_err("gpio error", state, ctrl, intr);
-			return -EIO;
+			return result;
 		} else if (result == 0) {
 			int retry_cnt = 0;
 retry:
@@ -431,8 +488,6 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
 	return 0;
 }
 
-static struct platform_driver omap2_onenand_driver;
-
 static void omap2_onenand_shutdown(struct platform_device *pdev)
 {
 	struct omap2_onenand *c = dev_get_drvdata(&pdev->dev);
@@ -446,105 +501,117 @@ static void omap2_onenand_shutdown(struct platform_device *pdev)
 
 static int omap2_onenand_probe(struct platform_device *pdev)
 {
+	u32 val;
 	dma_cap_mask_t mask;
-	struct omap_onenand_platform_data *pdata;
-	struct omap2_onenand *c;
-	struct onenand_chip *this;
-	int r;
+	int freq, latency, r;
 	struct resource *res;
+	struct omap2_onenand *c;
+	struct gpmc_onenand_info info;
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
-	c->gpmc_cs = pdata->cs;
-	c->gpio_irq = pdata->gpio_irq;
-	if (pdata->dma_channel < 0) {
-		/* if -1, don't use DMA */
-		c->gpio_irq = 0;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		r = -EINVAL;
-		dev_err(&pdev->dev, "error getting memory resource\n");
-		goto err_kfree;
-	}
-
+	c->gpmc_cs = val;
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
+	c->onenand.base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(c->onenand.base)) {
+		dev_err(dev, "Cannot reserve memory region at 0x%08x, size: 0x%x\n",
+			res->start, resource_size(res));
+		return PTR_ERR(c->onenand.base);
 	}
 
-	if (c->gpio_irq) {
-		if ((r = gpio_request(c->gpio_irq, "OneNAND irq")) < 0) {
-			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
-				"OneNAND\n", c->gpio_irq);
-			goto err_iounmap;
-		}
-		gpio_direction_input(c->gpio_irq);
+	c->int_gpiod = devm_gpiod_get_optional(dev, "int", GPIOD_IN);
+	if (IS_ERR(c->int_gpiod)) {
+		r = PTR_ERR(c->int_gpiod);
+		/* Just try again if this happens */
+		if (r != -EPROBE_DEFER)
+			dev_err(dev, "error getting gpio: %d\n", r);
+		return r;
+	}
 
-		if ((r = request_irq(gpio_to_irq(c->gpio_irq),
-				     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
-				     pdev->dev.driver->name, c)) < 0)
-			goto err_release_gpio;
+	if (c->int_gpiod) {
+		r = devm_request_irq(dev, gpiod_to_irq(c->int_gpiod),
+				     omap2_onenand_interrupt,
+				     IRQF_TRIGGER_RISING, "onenand", c);
+		if (r)
+			return r;
 
-		this->wait = omap2_onenand_wait;
+		c->onenand.wait = omap2_onenand_wait;
 	}
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_MEMCPY, mask);
 
 	c->dma_chan = dma_request_channel(mask, NULL, NULL);
-
-	dev_info(&pdev->dev, "initializing on CS%d, phys base 0x%08lx, virtual "
-		 "base %p, freq %d MHz, %s mode\n", c->gpmc_cs, c->phys_base,
-		 c->onenand.base, c->freq, c->dma_chan ? "DMA" : "PIO");
+	if (c->dma_chan) {
+		c->onenand.read_bufferram = omap2_onenand_read_bufferram;
+		c->onenand.write_bufferram = omap2_onenand_write_bufferram;
+	}
 
 	c->pdev = pdev;
 	c->mtd.priv = &c->onenand;
+	c->mtd.dev.parent = dev;
+	mtd_set_of_node(&c->mtd, dev->of_node);
 
-	c->mtd.dev.parent = &pdev->dev;
-	mtd_set_of_node(&c->mtd, pdata->of_node);
-
-	this = &c->onenand;
-	if (c->dma_chan) {
-		this->read_bufferram = omap2_onenand_read_bufferram;
-		this->write_bufferram = omap2_onenand_write_bufferram;
-	}
+	dev_info(dev, "initializing on CS%d (0x%08lx), va %p, %s mode\n",
+		 c->gpmc_cs, c->phys_base, c->onenand.base,
+		 c->dma_chan ? "DMA" : "PIO");
 
 	if ((r = onenand_scan(&c->mtd, 1)) < 0)
 		goto err_release_dma;
 
+	freq = omap2_onenand_get_freq(c->onenand.version_id);
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
@@ -558,17 +625,6 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 err_release_dma:
 	if (c->dma_chan)
 		dma_release_channel(c->dma_chan);
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
@@ -581,23 +637,23 @@ static int omap2_onenand_remove(struct platform_device *pdev)
 	if (c->dma_chan)
 		dma_release_channel(c->dma_chan);
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
 
+static const struct of_device_id omap2_onenand_id_table[] = {
+	{ .compatible = "ti,omap2-onenand", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, omap2_onenand_id_table);
+
 static struct platform_driver omap2_onenand_driver = {
 	.probe		= omap2_onenand_probe,
 	.remove		= omap2_onenand_remove,
 	.shutdown	= omap2_onenand_shutdown,
 	.driver		= {
 		.name	= DRIVER_NAME,
+		.of_match_table = omap2_onenand_id_table,
 	},
 };
 
diff --git a/include/linux/omap-gpmc.h b/include/linux/omap-gpmc.h
index edfa280c3d56..053feb41510a 100644
--- a/include/linux/omap-gpmc.h
+++ b/include/linux/omap-gpmc.h
@@ -25,15 +25,43 @@ struct gpmc_nand_ops {
 
 struct gpmc_nand_regs;
 
+struct gpmc_onenand_info {
+	bool sync_read;
+	bool sync_write;
+	int burst_len;
+};
+
 #if IS_ENABLED(CONFIG_OMAP_GPMC)
 struct gpmc_nand_ops *gpmc_omap_get_nand_ops(struct gpmc_nand_regs *regs,
 					     int cs);
+/**
+ * gpmc_omap_onenand_set_timings - set optimized sync timings.
+ * @cs:      Chip Select Region
+ * @freq:    Chip frequency
+ * @latency: Burst latency cycle count
+ * @info:    Structure describing parameters used
+ *
+ * Sets optimized timings for the @cs region based on @freq and @latency.
+ * Updates the @info structure based on the GPMC settings.
+ */
+int gpmc_omap_onenand_set_timings(struct device *dev, int cs, int freq,
+				  int latency,
+				  struct gpmc_onenand_info *info);
+
 #else
 static inline struct gpmc_nand_ops *gpmc_omap_get_nand_ops(struct gpmc_nand_regs *regs,
 							   int cs)
 {
 	return NULL;
 }
+
+static inline
+int gpmc_omap_onenand_set_timings(struct device *dev, int cs, int freq,
+				  int latency,
+				  struct gpmc_onenand_info *info)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_OMAP_GPMC */
 
 extern int gpmc_calc_timings(struct gpmc_timings *gpmc_t,
-- 
2.15.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
