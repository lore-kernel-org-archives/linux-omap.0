From: Afzal Mohammed <afzal@ti.com>
Subject: [RFC][PATCH v2 1/5] ARM: OMAP2+: gpmc: driver conversion
Date: Tue, 27 Mar 2012 09:55:52 +0530
Message-ID: <c3b3832c04676a44c690854ef57728638f58173a.1332771189.git.afzal@ti.com>
References: <cover.1332771189.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50703 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092Ab2C0Eno (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 00:43:44 -0400
In-Reply-To: <cover.1332771189.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Convert GPMC code to driver. Boards using GPMC should provide driver
with type of configuration, timing, CS, GPMC address space details
(if already configured, driver will retrieve, as is existing).
Platform devices would the be created for each connected peripheral
(details also to be passed by board so that it reaches respective
driver). And GPMC driver would populate memory resource details for
the driver of connected peripheral.

A peripheral connected to GPMC can have multiple address spaces using
different chip select. Hence GPMC driver has been provided capability
to distinguish this scenario, i.e. create platform devices only once
for each connected peripheral, and not for each configured chip
select. The peripheral that made it necessary was tusb6010.

Final destination for this driver is being investigated. Before moving
to the new location, all existing GPMC users has to be converted to
work with this driver.

NAND driver for NAND used via GPMC is tightly coupled with GPMC
driver (GPMC has few blocks exclusively for NAND), while that is not
the case for most of the other users (they need GPMCs help only for
initial configuration). Currently NAND driver manage using exported
GPMC symbols. This is being planned to remove later & would need
informing NAND driver about GPMC NAND registers. This would help to
have export symbol free GPMC driver, and probably
"mv omap2.c gpmc-nand.c" for OMAP NAND driver.
Thanks to Vaibhav Hiremath for his ideas on this.

Acquiring CS# for NAND is done on a few boards. It means, depending
on bootloader to embed this information. Probably CS# being used can
be set in the Kernel, and acquiring it can be removed. If ever this
capbility is needed, GPMC driver has to be made aware of handling it.

OneNAND - as it may involve reconfiguring GPMC for synchronous may
need a quirk to handle or driver has to be made more intelligent to
handle it.

Code related to GPMC clock may have to continue live in platform
folders (even if the driver is moved to MFD) as input clock is beyond
the control of GPMC and calculating timing for the peripheral may
need other helpers.

TODO
1. Let NAND driver deal with GPMC NAND block
2. Remove struct gpmc * stored as static
3. Convert all peripherals to use GPMC driver
4. Devise method to handle OneNAND cleanly
5. Handle acquiring CS# cases
6. Decide on where GPMC driver should live
7. Adapt to HWMOD, use RPM
8. GPMC driver cleanup

Cc: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
v2: Avoid code movement that kept similar code together

 arch/arm/mach-omap2/gpmc.c             |  366 ++++++++++++++++++++++++--------
 arch/arm/plat-omap/include/plat/gpmc.h |   34 ++-
 2 files changed, 305 insertions(+), 95 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 00d5108..8556153 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -14,8 +14,11 @@
  */
 #undef DEBUG
 
+#include <linux/platform_device.h>
+
 #include <linux/irq.h>
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -64,6 +67,35 @@
 #define ENABLE_PREFETCH		(0x1 << 7)
 #define DMA_MPU_MODE		2
 
+#define	DRIVER_NAME	"omap-gpmc"
+
+struct gpmc_child {
+	char			*name;
+	int			id;
+	struct resource		*res;
+	unsigned		num_res;
+	struct resource		gpmc_res[GPMC_CS_NUM];
+	unsigned		gpmc_num_res;
+	void			*pdata;
+	unsigned		pdata_size;
+};
+
+struct gpmc {
+	struct device		*dev;
+	unsigned long		fclk_period;
+	void __iomem		*io_base;
+	unsigned long		phys_base;
+	u32			memsize;
+	unsigned		cs_map;
+	int			ecc_used;
+	spinlock_t		mem_lock;
+	struct resource		mem_root;
+	struct resource		cs_mem[GPMC_CS_NUM];
+	struct gpmc_child	child_device[GPMC_CS_NUM];
+	unsigned		num_child;
+	unsigned		num_device;
+};
+
 /* Structure to save gpmc cs context */
 struct gpmc_cs_config {
 	u32 config1;
@@ -91,58 +123,50 @@ struct omap3_gpmc_regs {
 	struct gpmc_cs_config cs_context[GPMC_CS_NUM];
 };
 
-static struct resource	gpmc_mem_root;
-static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
-static DEFINE_SPINLOCK(gpmc_mem_lock);
-static unsigned int gpmc_cs_map;	/* flag for cs which are initialized */
-static int gpmc_ecc_used = -EINVAL;	/* cs using ecc engine */
-
-static void __iomem *gpmc_base;
-
 static struct clk *gpmc_l3_clk;
 
-static irqreturn_t gpmc_handle_irq(int irq, void *dev);
+static struct gpmc *gpmc;
 
 static void gpmc_write_reg(int idx, u32 val)
 {
-	__raw_writel(val, gpmc_base + idx);
+	writel(val, gpmc->io_base + idx);
 }
 
 static u32 gpmc_read_reg(int idx)
 {
-	return __raw_readl(gpmc_base + idx);
+	return readl(gpmc->io_base + idx);
 }
 
 static void gpmc_cs_write_byte(int cs, int idx, u8 val)
 {
 	void __iomem *reg_addr;
 
-	reg_addr = gpmc_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
-	__raw_writeb(val, reg_addr);
+	reg_addr = gpmc->io_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
+	writeb(val, reg_addr);
 }
 
 static u8 gpmc_cs_read_byte(int cs, int idx)
 {
 	void __iomem *reg_addr;
 
-	reg_addr = gpmc_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
-	return __raw_readb(reg_addr);
+	reg_addr = gpmc->io_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
+	return readb(reg_addr);
 }
 
 void gpmc_cs_write_reg(int cs, int idx, u32 val)
 {
 	void __iomem *reg_addr;
 
-	reg_addr = gpmc_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
-	__raw_writel(val, reg_addr);
+	reg_addr = gpmc->io_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
+	writel(val, reg_addr);
 }
 
 u32 gpmc_cs_read_reg(int cs, int idx)
 {
 	void __iomem *reg_addr;
 
-	reg_addr = gpmc_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
-	return __raw_readl(reg_addr);
+	reg_addr = gpmc->io_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
+	return readl(reg_addr);
 }
 
 /* TODO: Add support for gpmc_fck to clock framework and use it */
@@ -332,7 +356,7 @@ static void gpmc_cs_disable_mem(int cs)
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG7, l);
 }
 
-static void gpmc_cs_get_memconf(int cs, u32 *base, u32 *size)
+static __devinit void gpmc_cs_get_memconf(int cs, u32 *base, u32 *size)
 {
 	u32 l;
 	u32 mask;
@@ -351,23 +375,23 @@ static int gpmc_cs_mem_enabled(int cs)
 	return l & GPMC_CONFIG7_CSVALID;
 }
 
-int gpmc_cs_set_reserved(int cs, int reserved)
+static int gpmc_cs_set_reserved(int cs, int reserved)
 {
 	if (cs > GPMC_CS_NUM)
 		return -ENODEV;
 
-	gpmc_cs_map &= ~(1 << cs);
-	gpmc_cs_map |= (reserved ? 1 : 0) << cs;
+	gpmc->cs_map &= ~(1 << cs);
+	gpmc->cs_map |= (reserved ? 1 : 0) << cs;
 
 	return 0;
 }
 
-int gpmc_cs_reserved(int cs)
+static int gpmc_cs_reserved(int cs)
 {
 	if (cs > GPMC_CS_NUM)
 		return -ENODEV;
 
-	return gpmc_cs_map & (1 << cs);
+	return gpmc->cs_map & (1 << cs);
 }
 
 static unsigned long gpmc_mem_align(unsigned long size)
@@ -384,24 +408,25 @@ static unsigned long gpmc_mem_align(unsigned long size)
 	return size;
 }
 
-static int gpmc_cs_insert_mem(int cs, unsigned long base, unsigned long size)
+static __devinit
+int gpmc_cs_insert_mem(int cs, unsigned long base, unsigned long size)
 {
-	struct resource	*res = &gpmc_cs_mem[cs];
+	struct resource	*res = &gpmc->cs_mem[cs];
 	int r;
 
 	size = gpmc_mem_align(size);
-	spin_lock(&gpmc_mem_lock);
+	spin_lock(&gpmc->mem_lock);
 	res->start = base;
 	res->end = base + size - 1;
-	r = request_resource(&gpmc_mem_root, res);
-	spin_unlock(&gpmc_mem_lock);
+	r = request_resource(&gpmc->mem_root, res);
+	spin_unlock(&gpmc->mem_lock);
 
 	return r;
 }
 
 int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 {
-	struct resource *res = &gpmc_cs_mem[cs];
+	struct resource *res = &gpmc->cs_mem[cs];
 	int r = -1;
 
 	if (cs > GPMC_CS_NUM)
@@ -411,7 +436,7 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 	if (size > (1 << GPMC_SECTION_SHIFT))
 		return -ENOMEM;
 
-	spin_lock(&gpmc_mem_lock);
+	spin_lock(&gpmc->mem_lock);
 	if (gpmc_cs_reserved(cs)) {
 		r = -EBUSY;
 		goto out;
@@ -419,7 +444,7 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 	if (gpmc_cs_mem_enabled(cs))
 		r = adjust_resource(res, res->start & ~(size - 1), size);
 	if (r < 0)
-		r = allocate_resource(&gpmc_mem_root, res, size, 0, ~0,
+		r = allocate_resource(&gpmc->mem_root, res, size, 0, ~0,
 				      size, NULL, NULL);
 	if (r < 0)
 		goto out;
@@ -428,24 +453,24 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 	*base = res->start;
 	gpmc_cs_set_reserved(cs, 1);
 out:
-	spin_unlock(&gpmc_mem_lock);
+	spin_unlock(&gpmc->mem_lock);
 	return r;
 }
 EXPORT_SYMBOL(gpmc_cs_request);
 
 void gpmc_cs_free(int cs)
 {
-	spin_lock(&gpmc_mem_lock);
+	spin_lock(&gpmc->mem_lock);
 	if (cs >= GPMC_CS_NUM || cs < 0 || !gpmc_cs_reserved(cs)) {
 		printk(KERN_ERR "Trying to free non-reserved GPMC CS%d\n", cs);
 		BUG();
-		spin_unlock(&gpmc_mem_lock);
+		spin_unlock(&gpmc->mem_lock);
 		return;
 	}
 	gpmc_cs_disable_mem(cs);
-	release_resource(&gpmc_cs_mem[cs]);
+	release_resource(&gpmc->cs_mem[cs]);
 	gpmc_cs_set_reserved(cs, 0);
-	spin_unlock(&gpmc_mem_lock);
+	spin_unlock(&gpmc->mem_lock);
 }
 EXPORT_SYMBOL(gpmc_cs_free);
 
@@ -668,7 +693,7 @@ int gpmc_prefetch_reset(int cs)
 }
 EXPORT_SYMBOL(gpmc_prefetch_reset);
 
-static void __init gpmc_mem_init(void)
+static __devinit void gpmc_mem_init(void)
 {
 	int cs;
 	unsigned long boot_rom_space = 0;
@@ -680,8 +705,8 @@ static void __init gpmc_mem_init(void)
 	/* In apollon the CS0 is mapped as 0x0000 0000 */
 	if (machine_is_omap_apollon())
 		boot_rom_space = 0;
-	gpmc_mem_root.start = GPMC_MEM_START + boot_rom_space;
-	gpmc_mem_root.end = GPMC_MEM_END;
+	gpmc->mem_root.start = GPMC_MEM_START + boot_rom_space;
+	gpmc->mem_root.end = GPMC_MEM_END;
 
 	/* Reserve all regions that has been set up by bootloader */
 	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
@@ -697,27 +722,15 @@ static void __init gpmc_mem_init(void)
 
 static int __init gpmc_init(void)
 {
-	u32 l, irq;
-	int cs, ret = -EINVAL;
-	int gpmc_irq;
+	int ret = -EINVAL;
 	char *ck = NULL;
 
-	if (cpu_is_omap24xx()) {
+	if (cpu_is_omap24xx())
 		ck = "core_l3_ck";
-		if (cpu_is_omap2420())
-			l = OMAP2420_GPMC_BASE;
-		else
-			l = OMAP34XX_GPMC_BASE;
-		gpmc_irq = INT_34XX_GPMC_IRQ;
-	} else if (cpu_is_omap34xx()) {
+	else if (cpu_is_omap34xx())
 		ck = "gpmc_fck";
-		l = OMAP34XX_GPMC_BASE;
-		gpmc_irq = INT_34XX_GPMC_IRQ;
-	} else if (cpu_is_omap44xx()) {
+	else if (cpu_is_omap44xx())
 		ck = "gpmc_ck";
-		l = OMAP44XX_GPMC_BASE;
-		gpmc_irq = OMAP44XX_IRQ_GPMC;
-	}
 
 	if (WARN_ON(!ck))
 		return ret;
@@ -728,54 +741,221 @@ static int __init gpmc_init(void)
 		BUG();
 	}
 
-	gpmc_base = ioremap(l, SZ_4K);
-	if (!gpmc_base) {
-		clk_put(gpmc_l3_clk);
-		printk(KERN_ERR "Could not get GPMC register memory\n");
-		BUG();
+	clk_enable(gpmc_l3_clk);
+
+	return 0;
+}
+postcore_initcall(gpmc_init);
+
+static inline int __devinit gpmc_find_next_child_slot(void)
+{
+	return gpmc->num_child;
+}
+
+static int __devinit gpmc_match_child(char *name, int id)
+{
+	int i;
+	struct gpmc_child *p;
+
+	for (i = 0, p = gpmc->child_device; i < gpmc->num_child; i++, p++)
+		if (!strcmp(p->name, name) && (p->id == id))
+			return i;
+
+	return -ENOENT;
+}
+
+static __devinit int gpmc_setup_child(struct gpmc_device_pdata *gdp)
+{
+	struct gpmc_config *c;
+	int i, ret = 0;
+	struct resource res;
+	unsigned long start;
+
+	start = gdp->mem_start;
+
+	ret = gpmc_cs_request(gdp->cs, gdp->mem_size, &start);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(gpmc->dev, "error: gpmc request on CS: %u\n", gdp->cs);
+		return ret;
 	}
 
-	clk_enable(gpmc_l3_clk);
+	c = gdp->config;
+	if (!c) {
+		dev_err(gpmc->dev, "config not present for CS: %u\n", gdp->cs);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < gdp->num_config; c++, i++) {
+		ret = gpmc_cs_configure(gdp->cs, c->cmd, c->val);
+		if (IS_ERR_VALUE(ret)) {
+			dev_err(gpmc->dev, "invalid cmd or value on CS:	\
+			 %u: cmd: %d value: %d\n", gdp->cs, c->cmd, c->val);
+			return ret;
+		}
+	}
+
+	if (gdp->timing) {
+		ret = gpmc_cs_set_timings(gdp->cs, gdp->timing);
+		if (IS_ERR_VALUE(ret)) {
+			dev_err(gpmc->dev, "error: setting timing on CS: %d\n",
+								gdp->cs);
+			return ret;
+		}
+	}
+
+	res.start = start + gdp->mem_offset;
+	res.end = res.start + gdp->mem_size - 1;
+	res.flags = IORESOURCE_MEM;
+
+	i = gpmc_match_child(gdp->name, gdp->id);
+	/* i >= GPMC_CS_NUM can never happen, this is for compiler to shutup */
+	if (i >= 0 && i < GPMC_CS_NUM) {
+		int j;
+
+		j = gpmc->child_device[i].gpmc_num_res;
+		gpmc->child_device[i].gpmc_res[j] = res;
+	} else if (i == -ENOENT) {
+		i = gpmc_find_next_child_slot();
+		if (IS_ERR_VALUE(i)) {
+			dev_err(gpmc->dev, "error: childs exceeded\n");
+			return -ENODEV;
+		}
+		gpmc->child_device[i].name = gdp->name;
+		gpmc->child_device[i].id = gdp->id;
+		gpmc->child_device[i].pdata = gdp->pdata;
+		gpmc->child_device[i].pdata_size = gdp->pdata_size;
+		gpmc->child_device[i].gpmc_res[0] = res;
+	} else {
+		/* should never come here */
+		dev_err(gpmc->dev, "error: childs exceeded\n");
+		return -ENODEV;
+	}
+
+	gpmc->child_device[i].gpmc_num_res++;
+
+	return ret;
+}
+
+static __devinit int gpmc_create_child(int cnt)
+{
+	struct gpmc_child *p = gpmc->child_device + cnt;
+	int num = p->num_res + p->gpmc_num_res;
+	struct resource *res;
+
+	res = kzalloc(sizeof(struct resource) * num, GFP_KERNEL);
+	if (!res) {
+		dev_err(gpmc->dev, "error: allocating memory\n");
+		return -ENOMEM;
+	}
+
+	memcpy((char *)res, (const char *) p->gpmc_res,
+				sizeof(struct resource) * p->gpmc_num_res);
+	memcpy((char *)(res + p->gpmc_num_res), (const char *)p->res,
+				sizeof(struct resource) * p->num_res);
+
+	platform_device_register_resndata(gpmc->dev, p->name, p->id, res,
+						num, p->pdata, p->pdata_size);
+
+	return 0;
+}
+
+static __devinit int gpmc_probe(struct platform_device *pdev)
+{
+	u32 l;
+	int i;
+	int ret = -EINVAL;
+	struct resource *res = NULL;
+	struct gpmc_pdata *gp = dev_get_platdata(&pdev->dev);
+	struct gpmc_device_pdata *gdp = NULL;
+
+	gpmc = devm_kzalloc(&pdev->dev, sizeof(struct gpmc), GFP_KERNEL);
+	if (!gpmc) {
+		dev_err(&pdev->dev, "Failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	gpmc->dev = &pdev->dev;
+	gpmc->fclk_period = gp->fclk_period;
+	gpmc->num_device = gp->num_device;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENOENT;
+		dev_err(gpmc->dev, "Failed to get resource: memory\n");
+		goto err_res;
+	}
+	gpmc->phys_base = res->start;
+	gpmc->memsize = resource_size(res);
+
+	if (request_mem_region(gpmc->phys_base,
+		gpmc->memsize, DRIVER_NAME) == NULL) {
+		ret = -ENOMEM;
+		dev_err(gpmc->dev, "Failed to request memory region\n");
+		goto err_mem;
+	}
+
+	gpmc->io_base = ioremap(gpmc->phys_base, gpmc->memsize);
+	if (!gpmc->io_base) {
+		ret = -ENOMEM;
+		dev_err(gpmc->dev, "Failed to ioremap memory\n");
+		goto err_remap;
+	}
+
+	gpmc->ecc_used = -EINVAL;
+	spin_lock_init(&gpmc->mem_lock);
+	platform_set_drvdata(pdev, gpmc);
 
 	l = gpmc_read_reg(GPMC_REVISION);
-	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
-	/* Set smart idle mode and automatic L3 clock gating */
-	l = gpmc_read_reg(GPMC_SYSCONFIG);
-	l &= 0x03 << 3;
-	l |= (0x02 << 3) | (1 << 0);
-	gpmc_write_reg(GPMC_SYSCONFIG, l);
+	dev_info(gpmc->dev, "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
+
 	gpmc_mem_init();
 
-	/* initalize the irq_chained */
-	irq = OMAP_GPMC_IRQ_BASE;
-	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
-		irq_set_chip_and_handler(irq, &dummy_irq_chip,
-						handle_simple_irq);
-		set_irq_flags(irq, IRQF_VALID);
-		irq++;
+	for (i = 0, gdp = gp->device_pdata; i < gp->num_device; gdp++, i++) {
+		ret = gpmc_setup_child(gdp);
+		if (IS_ERR_VALUE(ret))
+			dev_err(gpmc->dev, "gpmc setup on CS: %u failed\n",
+								gdp->cs);
+		else
+			gpmc->num_child++;
 	}
 
-	ret = request_irq(gpmc_irq,
-			gpmc_handle_irq, IRQF_SHARED, "gpmc", gpmc_base);
-	if (ret)
-		pr_err("gpmc: irq-%d could not claim: err %d\n",
-						gpmc_irq, ret);
+	/* XXX: This would get modified once MFD */
+	for (i = 0; i < gpmc->num_child; i++)
+		gpmc_create_child(i);
+
+	return ret;
+
+err_remap:
+	release_mem_region(gpmc->phys_base, gpmc->memsize);
+err_mem:
+err_res:
+	devm_kfree(&pdev->dev, gpmc);
 	return ret;
 }
-postcore_initcall(gpmc_init);
 
-static irqreturn_t gpmc_handle_irq(int irq, void *dev)
+static __devexit int gpmc_remove(struct platform_device *pdev)
 {
-	u8 cs;
+	struct gpmc *gpmc = platform_get_drvdata(pdev);
 
-	/* check cs to invoke the irq */
-	cs = ((gpmc_read_reg(GPMC_PREFETCH_CONFIG1)) >> CS_NUM_SHIFT) & 0x7;
-	if (OMAP_GPMC_IRQ_BASE+cs <= OMAP_GPMC_IRQ_END)
-		generic_handle_irq(OMAP_GPMC_IRQ_BASE+cs);
+	platform_set_drvdata(pdev, NULL);
+	iounmap(gpmc->io_base);
+	release_mem_region(gpmc->phys_base, gpmc->memsize);
+	devm_kfree(&pdev->dev, gpmc);
 
-	return IRQ_HANDLED;
+	return 0;
 }
 
+static struct platform_driver gpmc_driver = {
+	.probe		= gpmc_probe,
+	.remove		= __devexit_p(gpmc_remove),
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(gpmc_driver);
+
 #ifdef CONFIG_ARCH_OMAP3
 static struct omap3_gpmc_regs gpmc_context;
 
@@ -855,10 +1035,10 @@ int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size)
 	unsigned int val;
 
 	/* check if ecc module is in used */
-	if (gpmc_ecc_used != -EINVAL)
+	if (gpmc->ecc_used != -EINVAL)
 		return -EINVAL;
 
-	gpmc_ecc_used = cs;
+	gpmc->ecc_used = cs;
 
 	/* clear ecc and enable bits */
 	val = ((0x00000001<<8) | 0x00000001);
@@ -906,7 +1086,7 @@ int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
 {
 	unsigned int val = 0x0;
 
-	if (gpmc_ecc_used != cs)
+	if (gpmc->ecc_used != cs)
 		return -EINVAL;
 
 	/* read ecc result */
@@ -916,7 +1096,7 @@ int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
 	/* P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e, P256e */
 	*ecc_code++ = ((val >> 8) & 0x0f) | ((val >> 20) & 0xf0);
 
-	gpmc_ecc_used = -EINVAL;
+	gpmc->ecc_used = -EINVAL;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gpmc_calculate_ecc);
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 1527929..1e02d85 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -131,6 +131,38 @@ struct gpmc_timings {
 	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
 };
 
+struct gpmc_config {
+	int cmd;
+	int val;
+};
+
+struct gpmc_device_pdata {
+	/* connected peripheral specific */
+	char			*name;
+	int			id;
+	/* resources configured via GPMC will be created by GPMC driver */
+	struct resource		*res;
+	unsigned		num_res;
+	void			*pdata;
+	unsigned		pdata_size;
+
+	/* GPMC specific */
+	unsigned		cs;
+	unsigned long		mem_size;
+	unsigned long		mem_start;
+	unsigned long		mem_offset;
+	struct gpmc_config	*config;
+	unsigned		num_config;
+	struct gpmc_timings	*timing;
+};
+
+struct gpmc_pdata {
+	/* GPMC_FCLK rate in picoseconds */
+	unsigned long			fclk_period;
+	struct gpmc_device_pdata	*device_pdata;
+	unsigned			num_device;
+};
+
 extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
 extern unsigned int gpmc_ps_to_ticks(unsigned int time_ps);
 extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
@@ -143,8 +175,6 @@ extern int gpmc_cs_calc_divider(int cs, unsigned int sync_clk);
 extern int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t);
 extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
 extern void gpmc_cs_free(int cs);
-extern int gpmc_cs_set_reserved(int cs, int reserved);
-extern int gpmc_cs_reserved(int cs);
 extern int gpmc_prefetch_enable(int cs, int fifo_th, int dma_mode,
 					unsigned int u32_count, int is_write);
 extern int gpmc_prefetch_reset(int cs);
-- 
1.7.9.3

