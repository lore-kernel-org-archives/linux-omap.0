From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 24/26] dmaengine: omap-dma: move register read/writes
 into omap-dma.c
Date: Thu, 02 Jan 2014 15:12:52 +0000
Message-ID: <E1Vyjx6-0005FY-96@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54158 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751949AbaABPNU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 10:13:20 -0500
In-Reply-To: <20140102150836.GA3826@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

Export the DMA register information from the SoC specific data, such
that we can access the registers directly in omap-dma.c, mapping the
register region ourselves as well.

Rather than calculating the DMA channel register in its entirety for
each access, we pre-calculate an offset base address for the allocated
DMA channel and then just use the appropriate register offset.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/dma.c |    2 +
 arch/arm/mach-omap2/dma.c |    2 +
 drivers/dma/omap-dma.c    |   96 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/omap-dma.h  |    2 +
 4 files changed, 93 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 8b1b914d0a6f..3afde9628839 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -264,6 +264,8 @@ static const struct platform_device_info omap_dma_dev_info = {
 };
 
 static struct omap_system_dma_plat_info dma_plat_info __initdata = {
+	.reg_map	= reg_map,
+	.channel_stride	= 0x40,
 	.show_dma_caps	= omap1_show_dma_caps,
 	.clear_lch_regs	= omap1_clear_lch_regs,
 	.clear_dma	= omap1_clear_dma,
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 6331fc4b4054..e08e55a173b6 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -205,6 +205,8 @@ static unsigned configure_dma_errata(void)
 }
 
 static struct omap_system_dma_plat_info dma_plat_info __initdata = {
+	.reg_map	= reg_map,
+	.channel_stride	= 0x60,
 	.show_dma_caps	= omap2_show_dma_caps,
 	.clear_dma	= omap2_clear_dma,
 	.dma_write	= dma_write,
diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 04631e6732c4..611963e82623 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -27,13 +27,16 @@ struct omap_dmadev {
 	spinlock_t lock;
 	struct tasklet_struct task;
 	struct list_head pending;
+	void __iomem *base;
+	const struct omap_dma_reg *reg_map;
 	struct omap_system_dma_plat_info *plat;
 };
 
 struct omap_chan {
 	struct virt_dma_chan vc;
 	struct list_head node;
-	struct omap_system_dma_plat_info *plat;
+	void __iomem *channel_base;
+	const struct omap_dma_reg *reg_map;
 
 	struct dma_slave_config	cfg;
 	unsigned dma_sig;
@@ -169,24 +172,77 @@ static void omap_dma_desc_free(struct virt_dma_desc *vd)
 	kfree(container_of(vd, struct omap_desc, vd));
 }
 
+static void omap_dma_write(uint32_t val, unsigned type, void __iomem *addr)
+{
+	switch (type) {
+	case OMAP_DMA_REG_16BIT:
+		writew_relaxed(val, addr);
+		break;
+	case OMAP_DMA_REG_2X16BIT:
+		writew_relaxed(val, addr);
+		writew_relaxed(val >> 16, addr + 2);
+		break;
+	case OMAP_DMA_REG_32BIT:
+		writel_relaxed(val, addr);
+		break;
+	default:
+		WARN_ON(1);
+	}
+}
+
+static unsigned omap_dma_read(unsigned type, void __iomem *addr)
+{
+	unsigned val;
+
+	switch (type) {
+	case OMAP_DMA_REG_16BIT:
+		val = readw_relaxed(addr);
+		break;
+	case OMAP_DMA_REG_2X16BIT:
+		val = readw_relaxed(addr);
+		val |= readw_relaxed(addr + 2) << 16;
+		break;
+	case OMAP_DMA_REG_32BIT:
+		val = readl_relaxed(addr);
+		break;
+	default:
+		WARN_ON(1);
+		val = 0;
+	}
+
+	return val;
+}
+
 static void omap_dma_glbl_write(struct omap_dmadev *od, unsigned reg, unsigned val)
 {
-	od->plat->dma_write(val, reg, 0);
+	const struct omap_dma_reg *r = od->reg_map + reg;
+
+	WARN_ON(r->stride);
+
+	omap_dma_write(val, r->type, od->base + r->offset);
 }
 
 static unsigned omap_dma_glbl_read(struct omap_dmadev *od, unsigned reg)
 {
-	return od->plat->dma_read(reg, 0);
+	const struct omap_dma_reg *r = od->reg_map + reg;
+
+	WARN_ON(r->stride);
+
+	return omap_dma_read(r->type, od->base + r->offset);
 }
 
 static void omap_dma_chan_write(struct omap_chan *c, unsigned reg, unsigned val)
 {
-	c->plat->dma_write(val, reg, c->dma_ch);
+	const struct omap_dma_reg *r = c->reg_map + reg;
+
+	omap_dma_write(val, r->type, c->channel_base + r->offset);
 }
 
 static unsigned omap_dma_chan_read(struct omap_chan *c, unsigned reg)
 {
-	return c->plat->dma_read(reg, c->dma_ch);
+	const struct omap_dma_reg *r = c->reg_map + reg;
+
+	return omap_dma_read(r->type, c->channel_base + r->offset);
 }
 
 static void omap_dma_clear_csr(struct omap_chan *c)
@@ -197,6 +253,12 @@ static void omap_dma_clear_csr(struct omap_chan *c)
 		omap_dma_chan_write(c, CSR, ~0);
 }
 
+static void omap_dma_assign(struct omap_dmadev *od, struct omap_chan *c,
+	unsigned lch)
+{
+	c->channel_base = od->base + od->plat->channel_stride * lch;
+}
+
 static void omap_dma_start(struct omap_chan *c, struct omap_desc *d)
 {
 	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
@@ -400,18 +462,26 @@ static void omap_dma_sched(unsigned long data)
 
 static int omap_dma_alloc_chan_resources(struct dma_chan *chan)
 {
+	struct omap_dmadev *od = to_omap_dma_dev(chan->device);
 	struct omap_chan *c = to_omap_dma_chan(chan);
+	int ret;
+
+	dev_info(od->ddev.dev, "allocating channel for %u\n", c->dma_sig);
 
-	dev_info(c->vc.chan.device->dev, "allocating channel for %u\n", c->dma_sig);
+	ret = omap_request_dma(c->dma_sig, "DMA engine", omap_dma_callback,
+			       c, &c->dma_ch);
 
-	return omap_request_dma(c->dma_sig, "DMA engine",
-		omap_dma_callback, c, &c->dma_ch);
+	if (ret >= 0)
+		omap_dma_assign(od, c, c->dma_ch);
+
+	return ret;
 }
 
 static void omap_dma_free_chan_resources(struct dma_chan *chan)
 {
 	struct omap_chan *c = to_omap_dma_chan(chan);
 
+	c->channel_base = NULL;
 	vchan_free_chan_resources(&c->vc);
 	omap_free_dma(c->dma_ch);
 
@@ -901,7 +971,7 @@ static int omap_dma_chan_init(struct omap_dmadev *od, int dma_sig)
 	if (!c)
 		return -ENOMEM;
 
-	c->plat = od->plat;
+	c->reg_map = od->reg_map;
 	c->dma_sig = dma_sig;
 	c->vc.desc_free = omap_dma_desc_free;
 	vchan_init(&c->vc, &od->ddev);
@@ -928,16 +998,24 @@ static void omap_dma_free(struct omap_dmadev *od)
 static int omap_dma_probe(struct platform_device *pdev)
 {
 	struct omap_dmadev *od;
+	struct resource *res;
 	int rc, i;
 
 	od = devm_kzalloc(&pdev->dev, sizeof(*od), GFP_KERNEL);
 	if (!od)
 		return -ENOMEM;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	od->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(od->base))
+		return PTR_ERR(od->base);
+
 	od->plat = omap_get_plat_info();
 	if (!od->plat)
 		return -EPROBE_DEFER;
 
+	od->reg_map = od->plat->reg_map;
+
 	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
 	dma_cap_set(DMA_CYCLIC, od->ddev.cap_mask);
 	od->ddev.device_alloc_chan_resources = omap_dma_alloc_chan_resources;
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
index 7813636a193d..41a13e70f41f 100644
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -285,6 +285,8 @@ struct omap_dma_reg {
 
 /* System DMA platform data structure */
 struct omap_system_dma_plat_info {
+	const struct omap_dma_reg *reg_map;
+	unsigned channel_stride;
 	struct omap_dma_dev_attr *dma_attr;
 	u32 errata;
 	void (*show_dma_caps)(void);
-- 
1.7.4.4

