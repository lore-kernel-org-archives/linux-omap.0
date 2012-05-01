From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 01/39] ARM: OMAP2+: gpmc: driver conversion
Date: Tue, 1 May 2012 17:36:06 +0530
Message-ID: <363273a9ef82d6836197929157aa9a8eb8f5171a.1335873032.git.afzal@ti.com>
References: <cover.1335873032.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33015 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754006Ab2EAMXY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:23:24 -0400
In-Reply-To: <cover.1335873032.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Jon Hunter <jon-hunter@ti.com>

Convert GPMC code to driver. Boards using GPMC should provide driver
with type of configuration, timing, CS. Platform devices would then be
created for each connected peripheral (details also to be passed by
board so that it reaches respective driver). And GPMC driver would
populate memory resource details for the connected peripheral driver.
Boards should inform gpmc driver with platform data destined for
peripheral driver. gpmc driver will provide the same information to
peripheral driver.

A peripheral connected to GPMC can have multiple address spaces using
different chip select. Hence GPMC driver has been provided capability
to create platform device for peripheral using mutiple CS. The
peripheral that made it necessary was tusb6010.

Interrupts of GPMC are presented to drivers of connected peripherals
as resource. A fictitious interrupt controller chip handles these
interrupts at GPMC hardware level. Clients can use normal interrupt
APIs. Platform information of peripheral passed to GPMC driver should
indicate interrupts to be used via flags.

Driver is capable of configuring waitpin, waitpin details has to be
provided per CS. Wait pin has been considered as exclusive resource
as multiple peripherals should not using the same pin, at the same
it is valid for mutiple CS to use same waitpin provided they are
a part of single peripheral (eg. tusb6010)

An exported symbol for reconfiguring GPMC settings has been provided.
OneNAND is the one that neccessitated this.

Acquiring CS# for NAND is done on a few boards. It means, depending
on bootloader to embed this information. Probably CS# being used can
be set in the Kernel, and acquiring it can be removed. If ever this
capbility is needed, GPMC driver has to be made aware of handling it.

Modifications has been made keeping in mind that the driver would
have to move to driver folder. This explains requirement of clk_prd
field; even though clk_prd variable is not necessary as
gpmc_get_fclk_period is present in the same file as of now, this will
help in moving the driver easily to drivers folder.

Code related to GPMC clock may have to continue live in platform
folders as input clock is beyond the control of GPMC and calculating
timing for the peripheral may need other helpers. This explains
presence of 'gpmc_cs_calc_divider' along with 'gpmc_calc_divider',
both doing same work, latter meant to go with driver, former for
calculation in platform code.

Thanks to Vaibhav Hiremath & Jonathan Hunter on their various good
suggestions which resulted in improving the code.

Cc: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |  877 ++++++++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/gpmc.h |   93 +++-
 2 files changed, 872 insertions(+), 98 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 580e684..12916f3 100644
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
@@ -53,6 +56,45 @@
 #define GPMC_CS0_OFFSET		0x60
 #define GPMC_CS_SIZE		0x30
 
+/* GPMC register bits */
+#define	GPMC_CONFIG1_TIMEPARAGRANULARITY	BIT(4)
+#define	GPMC_CONFIG1_DEVICETYPE_NAND		GPMC_CONFIG1_DEVICETYPE(0x2)
+#define	GPMC_CONFIG1_WAIT_PIN_SEL_MASK		GPMC_CONFIG1_WAIT_PIN_SEL(0x3)
+#define	GPMC_CONFIG1_WAIT_MON_TIME(val)		((val & 0x3) << 18)
+#define	GPMC_CONFIG1_WRITEMULTIPLE		BIT(28)
+#define	GPMC_CONFIG1_READMULTIPLE		BIT(30)
+#define	GPMC_CONFIG1_WRAPBURST			BIT(31)
+#define	GPMC_CONFIG_WAITPIN_POLARITY_SHIFT	0x8
+#define	GPMC_CONFIG1_WAITPIN_MONITOR_TIME(val)	((val & 0x3) << 18)
+#define	GPMC_CONFIG1_WAITPIN_MONITOR_TIME_1	\
+				GPMC_CONFIG1_WAITPIN_MONITOR_TIME(0x1)
+#define	GPMC_CONFIG1_WAITPIN_MONITOR_TIME_2	\
+				GPMC_CONFIG1_WAITPIN_MONITOR_TIME(0x2)
+#define	GPMC_CONFIG1_CLOCKACTIVATION_TIME(val)	((val & 0x3) << 25)
+#define	GPMC_CONFIG1_CLOCKACTIVATION_TIME_1	\
+				GPMC_CONFIG1_CLOCKACTIVATION_TIME(0x1)
+#define	GPMC_CONFIG1_CLOCKACTIVATION_TIME_2	\
+				GPMC_CONFIG1_CLOCKACTIVATION_TIME(0x2)
+
+#define	GPMC_CONFIG2_CSEXTRADELAY		BIT(7)
+
+#define	GPMC_CONFIG3_ADVEXTRADELAY		BIT(7)
+
+#define	GPMC_CONFIG4_OEEXTRADELAY		BIT(7)
+#define	GPMC_CONFIG4_WEEXTRADELAY		BIT(23)
+
+#define	GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN	BIT(6)
+#define	GPMC_CONFIG6_CYCLE2CYCLESAMECSEN	BIT(7)
+
+#define	GPMC_IRQ_BIT_FIFOEVENT		BIT(0)
+#define	GPMC_IRQ_BIT_TERMINALCOUNT	BIT(1)
+
+#define	GPMC_WAITPIN_IDX0			0x0
+#define	GPMC_WAITPIN_IDX1			0x1
+#define	GPMC_WAITPIN_IDX2			0x2
+#define	GPMC_WAITPIN_IDX3			0x3
+#define	GPMC_NR_WAITPIN				0x4
+
 #define GPMC_MEM_START		0x00000000
 #define GPMC_MEM_END		0x3FFFFFFF
 #define BOOT_ROM_SPACE		0x100000	/* 1MB */
@@ -64,6 +106,55 @@
 #define ENABLE_PREFETCH		(0x1 << 7)
 #define DMA_MPU_MODE		2
 
+#define	DRIVER_NAME	"omap-gpmc"
+
+#define	GPMC_NR_IRQ		2
+
+#define	HIGH			1
+#define	LOW			-1
+
+struct gpmc_device {
+	char			*name;
+	int			id;
+	void			*pdata;
+	unsigned		pdata_size;
+	struct resource		*per_res;
+	unsigned		per_res_cnt;
+	struct resource		*gpmc_res;
+	unsigned		gpmc_res_cnt;
+	bool			have_waitpin;
+	unsigned		waitpin;
+	int			waitpin_polarity;
+};
+
+struct gpmc_irq	{
+	unsigned		irq;
+	u32			bitmask;
+};
+
+struct gpmc {
+	struct device		*dev;
+	unsigned long		clk_prd;
+	void __iomem		*io_base;
+	unsigned long		phys_base;
+	u32			memsize;
+	unsigned		cs_map;
+	int			ecc_used;
+	spinlock_t		mem_lock;
+	struct resource		mem_root;
+	struct resource		cs_mem[GPMC_CS_NUM];
+	/* XXX: Or allocate dynamically ? */
+	struct gpmc_device	device[GPMC_CS_NUM];
+	unsigned		num_device;
+	unsigned		master_irq;
+	unsigned		irq_start;
+	struct gpmc_irq		irq[GPMC_NR_IRQ];
+	struct irq_chip		irq_chip;
+	bool			wp;
+	unsigned		waitpin_map;
+	unsigned		revision;
+};
+
 /* Structure to save gpmc cs context */
 struct gpmc_cs_config {
 	u32 config1;
@@ -91,58 +182,50 @@ struct omap3_gpmc_regs {
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
@@ -207,7 +290,8 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 	if (time == 0)
 		ticks = 0;
 	else
-		ticks = gpmc_ns_to_ticks(time);
+		ticks = (time * 1000 + gpmc->clk_prd - 1) / gpmc->clk_prd;
+
 	nr_bits = end_bit - st_bit + 1;
 	if (ticks >= 1 << nr_bits) {
 #ifdef DEBUG
@@ -222,7 +306,7 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 #ifdef DEBUG
 	printk(KERN_INFO
 		"GPMC CS%d: %-10s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
-	       cs, name, ticks, gpmc_get_fclk_period() * ticks / 1000,
+	       cs, name, ticks, gpmc->clk_prd * ticks / 1000,
 			(l >> st_bit) & mask, time);
 #endif
 	l &= ~(mask << st_bit);
@@ -243,6 +327,21 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit,
 		return -1
 #endif
 
+int gpmc_calc_divider(unsigned int sync_clk)
+{
+	int div;
+	u32 l;
+
+	l = sync_clk + (gpmc->clk_prd - 1);
+	div = l / gpmc->clk_prd;
+	if (div > 4)
+		return -1;
+	if (div <= 0)
+		div = 1;
+
+	return div;
+}
+
 int gpmc_cs_calc_divider(int cs, unsigned int sync_clk)
 {
 	int div;
@@ -258,12 +357,53 @@ int gpmc_cs_calc_divider(int cs, unsigned int sync_clk)
 	return div;
 }
 
+static void gpmc_cs_onoff_timings(int cs, const struct gpmc_onoff_timings *p)
+{
+	u32 l;
+
+	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG2);
+	if (p->cs_extra_delay)
+		l |= GPMC_CONFIG2_CSEXTRADELAY;
+	else
+		l &= ~GPMC_CONFIG2_CSEXTRADELAY;
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG2, l);
+
+	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG3);
+	if (p->adv_extra_delay)
+		l |= GPMC_CONFIG3_ADVEXTRADELAY;
+	else
+		l &= ~GPMC_CONFIG3_ADVEXTRADELAY;
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG3, l);
+
+	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG4);
+	if (p->oe_extra_delay)
+		l |= GPMC_CONFIG4_OEEXTRADELAY;
+	else
+		l &= ~GPMC_CONFIG4_OEEXTRADELAY;
+	if (p->we_extra_delay)
+		l |= GPMC_CONFIG4_WEEXTRADELAY;
+	else
+		l &= ~GPMC_CONFIG4_WEEXTRADELAY;
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG4, l);
+
+	l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG6);
+	if (p->cycle2cyclesamecsen)
+		l |= GPMC_CONFIG6_CYCLE2CYCLESAMECSEN;
+	else
+		l &= ~GPMC_CONFIG6_CYCLE2CYCLESAMECSEN;
+	if (p->cycle2cyclediffcsen)
+		l |= GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN;
+	else
+		l &= ~GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN;
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG6, l);
+}
+
 int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 {
 	int div;
 	u32 l;
 
-	div = gpmc_cs_calc_divider(cs, t->sync_clk);
+	div = gpmc_calc_divider(t->sync_clk);
 	if (div < 0)
 		return -1;
 
@@ -286,7 +426,10 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 
 	GPMC_SET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
 
-	if (cpu_is_omap34xx()) {
+	GPMC_SET_ONE(GPMC_CS_CONFIG6, 8, 11, cycle2cycle_delay);
+	GPMC_SET_ONE(GPMC_CS_CONFIG6, 0, 3, busturnaround);
+
+	if (gpmc->revision >= 5) {
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
 	}
@@ -298,13 +441,15 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 	if (l & (GPMC_CONFIG1_READTYPE_SYNC | GPMC_CONFIG1_WRITETYPE_SYNC)) {
 #ifdef DEBUG
 		printk(KERN_INFO "GPMC CS%d CLK period is %lu ns (div %d)\n",
-				cs, (div * gpmc_get_fclk_period()) / 1000, div);
+				cs, (div * gpmc->clk_prd) / 1000, div);
 #endif
 		l &= ~0x03;
 		l |= (div - 1);
 		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
 	}
 
+	gpmc_cs_onoff_timings(cs, &t->control);
+
 	return 0;
 }
 
@@ -332,7 +477,7 @@ static void gpmc_cs_disable_mem(int cs)
 	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG7, l);
 }
 
-static void gpmc_cs_get_memconf(int cs, u32 *base, u32 *size)
+static __devinit void gpmc_cs_get_memconf(int cs, u32 *base, u32 *size)
 {
 	u32 l;
 	u32 mask;
@@ -351,23 +496,23 @@ static int gpmc_cs_mem_enabled(int cs)
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
@@ -384,24 +529,25 @@ static unsigned long gpmc_mem_align(unsigned long size)
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
@@ -411,7 +557,7 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 	if (size > (1 << GPMC_SECTION_SHIFT))
 		return -ENOMEM;
 
-	spin_lock(&gpmc_mem_lock);
+	spin_lock(&gpmc->mem_lock);
 	if (gpmc_cs_reserved(cs)) {
 		r = -EBUSY;
 		goto out;
@@ -419,7 +565,7 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
 	if (gpmc_cs_mem_enabled(cs))
 		r = adjust_resource(res, res->start & ~(size - 1), size);
 	if (r < 0)
-		r = allocate_resource(&gpmc_mem_root, res, size, 0, ~0,
+		r = allocate_resource(&gpmc->mem_root, res, size, 0, ~0,
 				      size, NULL, NULL);
 	if (r < 0)
 		goto out;
@@ -428,24 +574,24 @@ int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
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
 
@@ -668,7 +814,7 @@ int gpmc_prefetch_reset(int cs)
 }
 EXPORT_SYMBOL(gpmc_prefetch_reset);
 
-static void __init gpmc_mem_init(void)
+static __devinit void gpmc_mem_init(void)
 {
 	int cs;
 	unsigned long boot_rom_space = 0;
@@ -680,8 +826,8 @@ static void __init gpmc_mem_init(void)
 	/* In apollon the CS0 is mapped as 0x0000 0000 */
 	if (machine_is_omap_apollon())
 		boot_rom_space = 0;
-	gpmc_mem_root.start = GPMC_MEM_START + boot_rom_space;
-	gpmc_mem_root.end = GPMC_MEM_END;
+	gpmc->mem_root.start = GPMC_MEM_START + boot_rom_space;
+	gpmc->mem_root.end = GPMC_MEM_END;
 
 	/* Reserve all regions that has been set up by bootloader */
 	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
@@ -697,26 +843,15 @@ static void __init gpmc_mem_init(void)
 
 static int __init gpmc_init(void)
 {
-	u32 l, irq;
-	int cs, ret = -EINVAL;
-	int gpmc_irq;
+	int ret = -EINVAL;
 	char *ck = NULL;
 
 	if (cpu_is_omap24xx()) {
 		ck = "core_l3_ck";
-		if (cpu_is_omap2420())
-			l = OMAP2420_GPMC_BASE;
-		else
-			l = OMAP34XX_GPMC_BASE;
-		gpmc_irq = INT_34XX_GPMC_IRQ;
 	} else if (cpu_is_omap34xx()) {
 		ck = "gpmc_fck";
-		l = OMAP34XX_GPMC_BASE;
-		gpmc_irq = INT_34XX_GPMC_IRQ;
 	} else if (cpu_is_omap44xx()) {
 		ck = "gpmc_ck";
-		l = OMAP44XX_GPMC_BASE;
-		gpmc_irq = OMAP44XX_IRQ_GPMC;
 	}
 
 	if (WARN_ON(!ck))
@@ -728,53 +863,607 @@ static int __init gpmc_init(void)
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
+static inline int gpmc_waitpin_is_reserved(struct gpmc *gpmc, unsigned waitpin)
+{
+	return gpmc->waitpin_map & (0x1 << waitpin);
+}
+
+static inline void gpmc_reserve_waitpin(struct gpmc *gpmc, unsigned waitpin)
+{
+	gpmc->waitpin_map &= ~(0x1 << waitpin);
+	gpmc->waitpin_map |= (0x1 << waitpin);
+}
+
+static int gpmc_waitpin_request(struct gpmc *gpmc, unsigned waitpin)
+{
+	if (!(waitpin < GPMC_NR_WAITPIN))
+		return -ENODEV;
+
+	if (gpmc_waitpin_is_reserved(gpmc, waitpin))
+		return -EBUSY;
+	else
+		gpmc_reserve_waitpin(gpmc, waitpin);
+
+	return 0;
+}
+
+static int gpmc_setup_waitpin(struct gpmc *gpmc, struct gpmc_device *gd)
+{
+	int ret;
+
+	if (!gd->have_waitpin)
+		return 0;
+
+	ret = gpmc_waitpin_request(gpmc, gd->waitpin);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(gpmc->dev, "waitpin %u reserved\n", gd->waitpin);
+		return ret;
+	} else if (gd->waitpin_polarity) {
+		u32 l = gpmc_read_reg(GPMC_CONFIG);
+		u32 shift = gd->waitpin + GPMC_CONFIG_WAITPIN_POLARITY_SHIFT;
+
+		if (gd->waitpin_polarity == HIGH)
+			l |= 1 << shift;
+		else
+			l &= ~(1 << shift);
+
+		gpmc_write_reg(GPMC_CONFIG, l);
 	}
+	return 0;
+}
 
-	clk_enable(gpmc_l3_clk);
+static int gpmc_setup_cs_waitpin(struct gpmc *gpmc, struct gpmc_device *gd,
+						unsigned cs, unsigned conf)
+{
+	u32 l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+	unsigned idx = ~0x0;
+	int polarity = 0;
 
-	l = gpmc_read_reg(GPMC_REVISION);
-	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
-	/* Set smart idle mode and automatic L3 clock gating */
-	l = gpmc_read_reg(GPMC_SYSCONFIG);
-	l &= 0x03 << 3;
-	l |= (0x02 << 3) | (1 << 0);
-	gpmc_write_reg(GPMC_SYSCONFIG, l);
-	gpmc_mem_init();
+	switch (conf & GPMC_WAITPIN_MASK) {
+	case GPMC_WAITPIN_0:
+		idx =  GPMC_WAITPIN_IDX0;
+		break;
+	case GPMC_WAITPIN_1:
+		idx =  GPMC_WAITPIN_IDX1;
+		break;
+	case GPMC_WAITPIN_2:
+		idx =  GPMC_WAITPIN_IDX2;
+		break;
+	case GPMC_WAITPIN_3:
+		idx =  GPMC_WAITPIN_IDX3;
+		break;
+	/* no waitpin */
+	case 0:
+		break;
+	default:
+		dev_err(gpmc->dev, "multiple waitpins selected on CS:%u\n", cs);
+		return -EINVAL;
+		break;
+	}
 
-	/* initalize the irq_chained */
-	irq = OMAP_GPMC_IRQ_BASE;
-	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
-		irq_set_chip_and_handler(irq, &dummy_irq_chip,
-						handle_simple_irq);
-		set_irq_flags(irq, IRQF_VALID);
-		irq++;
+	switch (conf & GPMC_WAITPIN_POLARITY_MASK) {
+	case GPMC_WAITPIN_ACTIVE_LOW:
+		polarity = LOW;
+		break;
+	case GPMC_WAITPIN_ACTIVE_HIGH:
+		polarity = HIGH;
+		break;
+	/* no waitpin */
+	case 0:
+		break;
+	default:
+		dev_err(gpmc->dev, "waitpin polarity set to low & high\n");
+		return -EINVAL;
+		break;
 	}
 
-	ret = request_irq(gpmc_irq, gpmc_handle_irq, IRQF_SHARED, "gpmc", NULL);
-	if (ret)
-		pr_err("gpmc: irq-%d could not claim: err %d\n",
-						gpmc_irq, ret);
-	return ret;
+	if (idx != ~0x0) {
+		if (gd->have_waitpin) {
+			if (gd->waitpin != idx ||
+					gd->waitpin_polarity != polarity) {
+				dev_err(gpmc->dev, "error: conflict: waitpin %u with polarity %d on device %s.%d\n",
+					gd->waitpin, gd->waitpin_polarity,
+					gd->name, gd->id);
+				return -EBUSY;
+			}
+		} else {
+			gd->have_waitpin = true;
+			gd->waitpin = idx;
+			gd->waitpin_polarity = polarity;
+		}
+
+		l &= ~GPMC_CONFIG1_WAIT_PIN_SEL_MASK;
+		l |= GPMC_CONFIG1_WAIT_PIN_SEL(idx);
+		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
+	} else if (polarity) {
+		dev_err(gpmc->dev, "error: waitpin polarity specified with out wait pin number on device %s.%d\n",
+							gd->name, gd->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void gpmc_setup_cs_config(struct gpmc *gpmc, unsigned cs, unsigned conf)
+{
+	u32 l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+
+	l &= ~(GPMC_CONFIG1_TIMEPARAGRANULARITY |
+		GPMC_CONFIG1_MUXADDDATA |
+		GPMC_CONFIG1_DEVICETYPE(~0) |
+		GPMC_CONFIG1_DEVICESIZE(~0) |
+		GPMC_CONFIG1_WAIT_WRITE_MON |
+		GPMC_CONFIG1_WAIT_READ_MON |
+		GPMC_CONFIG1_PAGE_LEN(~0) |
+		GPMC_CONFIG1_WRITETYPE_SYNC |
+		GPMC_CONFIG1_WRITEMULTIPLE |
+		GPMC_CONFIG1_READTYPE_SYNC |
+		GPMC_CONFIG1_READMULTIPLE |
+		GPMC_CONFIG1_WRAPBURST |
+		GPMC_CONFIG1_WAITPIN_MONITOR_TIME(~0) |
+		GPMC_CONFIG1_CLOCKACTIVATION_TIME(~0));
+
+	if (conf & GPMC_TIMEPARAGRANULARITY)
+		l |= GPMC_CONFIG1_TIMEPARAGRANULARITY;
+	if (conf & GPMC_MUXADDDATA)
+		l |= GPMC_CONFIG1_MUXADDDATA;
+	if (conf & GPMC_DEVICETYPE_NAND)
+		l |= GPMC_CONFIG1_DEVICETYPE_NAND;
+	if (conf & GPMC_DEVICESIZE_16)
+		l |= GPMC_CONFIG1_DEVICESIZE_16;
+	if (conf & GPMC_WAIT_WRITE_MON)
+		l |= GPMC_CONFIG1_WAIT_WRITE_MON;
+	if (conf & GPMC_WAIT_READ_MON)
+		l |= GPMC_CONFIG1_WAIT_READ_MON;
+	if (conf & GPMC_PAGE_LEN_16)
+		l |= GPMC_CONFIG1_PAGE_LEN_16;
+	else if (conf & GPMC_PAGE_LEN_8)
+		l |= GPMC_CONFIG1_PAGE_LEN_8;
+	if (conf & GPMC_WRITETYPE_SYNC)
+		l |= GPMC_CONFIG1_WRITETYPE_SYNC;
+	if (conf & GPMC_WRITEMULTIPLE)
+		l |= GPMC_CONFIG1_WRITEMULTIPLE;
+	if (conf & GPMC_READTYPE_SYNC)
+		l |= GPMC_CONFIG1_READTYPE_SYNC;
+	if (conf & GPMC_READMULTIPLE)
+		l |= GPMC_CONFIG1_READMULTIPLE;
+	if (conf & GPMC_WRAPBURST)
+		l |= GPMC_CONFIG1_WRAPBURST;
+	if (conf & GPMC_WAITPIN_MONITOR_TIME_1)
+		l |= GPMC_CONFIG1_WAITPIN_MONITOR_TIME_1;
+	else if (conf & GPMC_WAITPIN_MONITOR_TIME_2)
+		l |= GPMC_CONFIG1_WAITPIN_MONITOR_TIME_2;
+	if (conf & GPMC_CLOCKACTIVATION_TIME_1)
+		l |= GPMC_CONFIG1_CLOCKACTIVATION_TIME_1;
+	else if (conf & GPMC_CLOCKACTIVATION_TIME_2)
+		l |= GPMC_CONFIG1_CLOCKACTIVATION_TIME_2;
+
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
+
+	if (conf & GPMC_WRITEPROTECT)
+		gpmc->wp = true;
+}
+
+static int gpmc_setup_cs_nonres(struct gpmc *gpmc,
+			struct gpmc_device *gd, struct gpmc_cs_data *cs)
+{
+	int ret;
+
+	/* some boards rely on bootloader for configuration */
+	if (cs->have_config) {
+		gpmc_setup_cs_config(gpmc, cs->cs, cs->config);
+		ret = gpmc_setup_cs_waitpin(gpmc, gd, cs->cs, cs->config);
+		if (IS_ERR_VALUE(ret)) {
+			dev_err(gpmc->dev, "error: waitpin on CS %d\n", cs->cs);
+			return ret;
+		}
+	} else
+		dev_warn(gpmc->dev, "config not present for CS: %d\n", cs->cs);
+
+	if (cs->timing) {
+		ret = gpmc_cs_set_timings(cs->cs, cs->timing);
+		if (IS_ERR_VALUE(ret)) {
+			dev_err(gpmc->dev, "error: timing on CS: %d\n", cs->cs);
+			return ret;
+		}
+	} else
+		dev_warn(gpmc->dev, "timing not present for CS: %u\n", cs->cs);
+
+	return 0;
+}
+
+static int gpmc_match_device(struct gpmc *gpmc, char *name, int id)
+{
+	int i;
+	struct gpmc_device *gd;
+
+	for (i = 0, gd = gpmc->device; i < gpmc->num_device; i++, gd++)
+		if (!strcmp(gd->name, name) && gd->id == id)
+			return i;
+
+	return -ENOENT;
+}
+
+int gpmc_cs_reconfigure(char *name, int id, struct gpmc_cs_data *cs)
+{
+	int i;
+
+	i = gpmc_match_device(gpmc, name, id);
+	if (IS_ERR_VALUE(i)) {
+		dev_err(gpmc->dev, "no device %s.%d to configure\n", name, id);
+		return i;
+	}
+
+	i = gpmc_setup_cs_nonres(gpmc, gpmc->device + i, cs);
+	if (IS_ERR_VALUE(i)) {
+		dev_err(gpmc->dev, "error: configure device %s.%d\n", name, id);
+		return i;
+	}
+
+	return gpmc_setup_waitpin(gpmc, gpmc->device + i);
+
+}
+EXPORT_SYMBOL_GPL(gpmc_cs_reconfigure);
+
+static inline unsigned int gpmc_bit_to_irq(unsigned bitmask)
+{
+	if (bitmask & GPMC_IRQ_BIT_FIFOEVENT)
+		return GPMC_IRQ_FIFOEVENTENABLE;
+	else if (bitmask & GPMC_IRQ_BIT_TERMINALCOUNT)
+		return GPMC_IRQ_COUNT_EVENT;
+	else
+		return 0;
+}
+
+static __devinit int gpmc_setup_cs_irq(struct gpmc *gpmc,
+			struct gpmc_cs_data *cs, struct resource *res)
+{
+	int i, n;
+
+	for (i = 0, n = 0; i < GPMC_NR_IRQ; i++)
+		if (gpmc_bit_to_irq(gpmc->irq[i].bitmask) & cs->irq_config) {
+			res[n].start = res[n].end = gpmc->irq[i].irq;
+			res[n].flags = IORESOURCE_IRQ;
+			dev_info(gpmc->dev, "irq %u on CS %d\n",
+						res[n].start, cs->cs);
+			n++;
+		}
+
+	return n;
+}
+
+static __devinit int gpmc_setup_cs_mem(struct gpmc *gpmc,
+			struct gpmc_cs_data *cs, struct resource *res)
+{
+	unsigned long start;
+	int ret;
+
+	ret = gpmc_cs_request(cs->cs, cs->mem_size, &start);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(gpmc->dev, "error: gpmc request on CS: %d\n", cs->cs);
+		return ret;
+	}
+
+	res->start = start + cs->mem_offset;
+	res->end = res->start + cs->mem_size - 1;
+	res->flags = IORESOURCE_MEM;
+
+	dev_info(gpmc->dev, "memory 0x%x-0x%x on CS %d\n", res->start,
+							res->end, cs->cs);
+
+	return 1;
+}
+
+static __devinit int gpmc_setup_cs(struct gpmc *gpmc, struct gpmc_device *gd,
+			struct gpmc_cs_data *cs, struct resource *res)
+{
+	int num, ret;
+
+	num = gpmc_setup_cs_mem(gpmc, cs, res);
+	if (IS_ERR_VALUE(num))
+		return num;
+
+	ret = gpmc_setup_cs_nonres(gpmc, gd, cs);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+
+	num += gpmc_setup_cs_irq(gpmc, cs, res + num);
+
+	return num;
+}
+
+static __devinit int gpmc_setup_device(struct gpmc *gpmc,
+		struct gpmc_device *gd, struct gpmc_device_pdata *gdp)
+{
+	int i, n, ret;
+	struct gpmc_cs_data *cs;
+
+	for (i = 0, n = gdp->num_cs, cs = gdp->cs_data;
+				i < gdp->num_cs; i++, cs++)
+		n += hweight32(cs->irq_config);
+
+	gd->gpmc_res = devm_kzalloc(gpmc->dev, sizeof(*gd->gpmc_res) * n,
+								GFP_KERNEL);
+	if (gd->gpmc_res == NULL) {
+		dev_err(gpmc->dev, "error: memory allocation\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0, cs = gdp->cs_data, gd->gpmc_res_cnt = 0;
+			i < gdp->num_cs; cs++, i++) {
+		ret = gpmc_setup_cs(gpmc, gd, cs,
+					gd->gpmc_res + gd->gpmc_res_cnt);
+		if (IS_ERR_VALUE(ret) ||
+				IS_ERR_VALUE(gpmc_setup_waitpin(gpmc, gd))) {
+			dev_err(gpmc->dev, "error: setup for %s\n", gdp->name);
+			devm_kfree(gpmc->dev, gd->gpmc_res);
+			gd->gpmc_res = NULL;
+			gd->gpmc_res_cnt = 0;
+			return -EINVAL;
+		} else
+			gd->gpmc_res_cnt += ret;
+	}
+
+	gd->name = gdp->name;
+	gd->id = gdp->id;
+	gd->pdata = gdp->pdata;
+	gd->pdata_size = gdp->pdata_size;
+	gd->per_res = gdp->per_res;
+	gd->per_res_cnt = gdp->per_res_cnt;
+
+	return 0;
+}
+
+static __devinit
+struct platform_device *gpmc_create_device(struct gpmc *gpmc,
+					struct gpmc_device *p)
+{
+	int num = p->per_res_cnt + p->gpmc_res_cnt;
+	struct resource *res;
+	struct platform_device *pdev;
+
+	res = devm_kzalloc(gpmc->dev, sizeof(struct resource) * num,
+								GFP_KERNEL);
+	if (!res) {
+		dev_err(gpmc->dev, "error: allocating memory\n");
+		return NULL;
+	}
+
+	memcpy((char *)res, (const char *) p->gpmc_res,
+				sizeof(struct resource) * p->gpmc_res_cnt);
+	memcpy((char *)(res + p->gpmc_res_cnt), (const char *)p->per_res,
+				sizeof(struct resource) * p->per_res_cnt);
+
+	pdev = platform_device_register_resndata(gpmc->dev, p->name, p->id,
+					res, num, p->pdata, p->pdata_size);
+
+	devm_kfree(gpmc->dev, res);
+
+	return pdev;
 }
-postcore_initcall(gpmc_init);
 
 static irqreturn_t gpmc_handle_irq(int irq, void *dev)
 {
-	u8 cs;
+	int i;
+	u32 regval;
+	struct gpmc *gpmc = dev;
+
+	regval = gpmc_read_reg(GPMC_IRQSTATUS);
 
-	/* check cs to invoke the irq */
-	cs = ((gpmc_read_reg(GPMC_PREFETCH_CONFIG1)) >> CS_NUM_SHIFT) & 0x7;
-	if (OMAP_GPMC_IRQ_BASE+cs <= OMAP_GPMC_IRQ_END)
-		generic_handle_irq(OMAP_GPMC_IRQ_BASE+cs);
+	for (i = 0; i < GPMC_NR_IRQ; i++)
+		if (regval & gpmc->irq[i].bitmask)
+			generic_handle_irq(gpmc->irq[i].irq);
+
+	gpmc_write_reg(GPMC_IRQSTATUS, regval);
 
 	return IRQ_HANDLED;
 }
 
+static int gpmc_irq_endis(struct gpmc *gpmc, unsigned irq, bool endis)
+{
+	int i;
+	u32 regval;
+
+	for (i = 0; i < GPMC_NR_IRQ; i++)
+		if (irq == gpmc->irq[i].irq) {
+			regval = gpmc_read_reg(GPMC_IRQENABLE);
+			if (endis)
+				regval |= gpmc->irq[i].bitmask;
+			else
+				regval &= ~gpmc->irq[i].bitmask;
+			gpmc_write_reg(GPMC_IRQENABLE, regval);
+			break;
+		}
+
+	return 0;
+}
+
+static void gpmc_irq_disable(struct irq_data *p)
+{
+	gpmc_irq_endis(irq_data_get_irq_chip_data(p), p->irq, false);
+}
+
+static void gpmc_irq_enable(struct irq_data *p)
+{
+	gpmc_irq_endis(irq_data_get_irq_chip_data(p), p->irq, true);
+}
+
+static void gpmc_irq_noop(struct irq_data *data) { }
+
+static unsigned int gpmc_irq_noop_ret(struct irq_data *data) { return 0; }
+
+static __devinit int gpmc_setup_irq(struct gpmc *gpmc)
+{
+	int i;
+	u32 regval;
+
+	if (!gpmc->master_irq)
+		return -EINVAL;
+
+	gpmc->irq_start = irq_alloc_descs(-1, 0, GPMC_NR_IRQ, 0);
+	if (IS_ERR_VALUE(gpmc->irq_start)) {
+		dev_err(gpmc->dev, "irq_alloc_descs failed\n");
+		return gpmc->irq_start;
+	}
+
+	gpmc->irq_chip.name = "gpmc";
+	gpmc->irq_chip.irq_startup = gpmc_irq_noop_ret;
+	gpmc->irq_chip.irq_enable = gpmc_irq_enable;
+	gpmc->irq_chip.irq_disable = gpmc_irq_disable;
+	gpmc->irq_chip.irq_shutdown = gpmc_irq_noop;
+	gpmc->irq_chip.irq_ack = gpmc_irq_noop;
+	gpmc->irq_chip.irq_mask = gpmc_irq_noop;
+	gpmc->irq_chip.irq_unmask = gpmc_irq_noop;
+
+	gpmc->irq[0].bitmask = GPMC_IRQ_BIT_FIFOEVENT;
+	gpmc->irq[1].bitmask = GPMC_IRQ_BIT_TERMINALCOUNT;
+
+	for (i = 0; i < GPMC_NR_IRQ; i++) {
+		gpmc->irq[i].irq = gpmc->irq_start + i;
+		irq_set_chip_and_handler(gpmc->irq[i].irq,
+					&gpmc->irq_chip, handle_simple_irq);
+		irq_set_chip_data(gpmc->irq[i].irq, gpmc);
+		set_irq_flags(gpmc->irq[i].irq, IRQF_VALID | IRQF_NOAUTOEN);
+	}
+
+	/* Disable interrupts */
+	gpmc_write_reg(GPMC_IRQENABLE, 0);
+
+	/* clear interrupts */
+	regval = gpmc_read_reg(GPMC_IRQSTATUS);
+	gpmc_write_reg(GPMC_IRQSTATUS, regval);
+
+	return request_irq(gpmc->master_irq, gpmc_handle_irq, IRQF_SHARED,
+							"gpmc", gpmc);
+}
+
+static __devinit void gpmc_setup_writeprotect(struct gpmc *gpmc)
+{
+	u32 l;
+
+	l = gpmc_read_reg(GPMC_CONFIG);
+	if (gpmc->wp == true) {
+		l &= ~GPMC_CONFIG_WRITEPROTECT;
+		dev_info(gpmc->dev, "write protect enabled\n");
+	} else
+		l |= GPMC_CONFIG_WRITEPROTECT;
+	gpmc_write_reg(GPMC_CONFIG, l);
+}
+
+static __devinit int gpmc_probe(struct platform_device *pdev)
+{
+	u32 l;
+	int i;
+	int ret = 0;
+	struct resource *res = NULL;
+	struct gpmc_pdata *gp = dev_get_platdata(&pdev->dev);
+	struct gpmc_device_pdata **gdq = NULL;
+	struct gpmc_device *gd = NULL;
+
+	gpmc = devm_kzalloc(&pdev->dev, sizeof(struct gpmc), GFP_KERNEL);
+	if (gpmc == NULL)
+		return -ENOMEM;
+
+	gpmc->dev = &pdev->dev;
+	gpmc->clk_prd = gp->clk_prd;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL)
+		return -ENOENT;
+
+	gpmc->phys_base = res->start;
+	gpmc->memsize = resource_size(res);
+
+	gpmc->io_base = devm_request_and_ioremap(gpmc->dev, res);
+	if (!gpmc->io_base)
+		return -EADDRNOTAVAIL;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (res == NULL)
+		dev_warn(gpmc->dev, "Failed to get resource: irq\n");
+	else
+		gpmc->master_irq = res->start;
+
+	if (IS_ERR_VALUE(gpmc_setup_irq(gpmc)))
+		dev_warn(gpmc->dev, "gpmc_setup_irq failed\n");
+
+	gpmc->ecc_used = -EINVAL;
+	spin_lock_init(&gpmc->mem_lock);
+	platform_set_drvdata(pdev, gpmc);
+
+	l = gpmc_read_reg(GPMC_REVISION);
+	gpmc->revision = (l >> 4) & 0xf;
+	dev_info(gpmc->dev, "GPMC revision %u.%u\n", gpmc->revision, l & 0x0f);
+
+	gpmc_mem_init();
+
+	for (i = 0, gdq = gp->device_pdata, gd = gpmc->device;
+			(i < gp->num_device) && (*gdq); i++, gdq++) {
+		ret = gpmc_setup_device(gpmc, gd, *gdq);
+		if (IS_ERR_VALUE(ret))
+			dev_err(gpmc->dev, "gpmc setup on %s failed\n",
+								(*gdq)->name);
+		else
+			gd++;
+	}
+	gpmc->num_device = gd - gpmc->device;
+
+	gpmc_setup_writeprotect(gpmc);
+
+	for (i = 0, gd = gpmc->device; i < gpmc->num_device; i++, gd++)
+		if (IS_ERR(gpmc_create_device(gpmc, gd)))
+			dev_err(gpmc->dev, "device creation on %s failed\n",
+								gd->name);
+
+	return 0;
+}
+
+static __devexit int gpmc_free_irq(struct gpmc *gpmc)
+{
+	int i;
+
+	if (gpmc->master_irq)
+		free_irq(gpmc->master_irq, gpmc);
+
+	for (i = 0; i < GPMC_NR_IRQ; i++) {
+		irq_set_handler(gpmc->irq[i].irq, NULL);
+		irq_set_chip(gpmc->irq[i].irq, &no_irq_chip);
+		irq_set_chip_data(gpmc->irq[i].irq, NULL);
+		irq_modify_status(gpmc->irq[i].irq, 0, 0);
+	}
+
+	irq_free_descs(gpmc->irq_start, GPMC_NR_IRQ);
+
+	return 0;
+}
+
+static __devexit int gpmc_remove(struct platform_device *pdev)
+{
+	struct gpmc *gpmc = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+	gpmc_free_irq(gpmc);
+
+	return 0;
+}
+
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
 
@@ -854,10 +1543,10 @@ int gpmc_enable_hwecc(int cs, int mode, int dev_width, int ecc_size)
 	unsigned int val;
 
 	/* check if ecc module is in used */
-	if (gpmc_ecc_used != -EINVAL)
+	if (gpmc->ecc_used != -EINVAL)
 		return -EINVAL;
 
-	gpmc_ecc_used = cs;
+	gpmc->ecc_used = cs;
 
 	/* clear ecc and enable bits */
 	val = ((0x00000001<<8) | 0x00000001);
@@ -905,7 +1594,7 @@ int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
 {
 	unsigned int val = 0x0;
 
-	if (gpmc_ecc_used != cs)
+	if (gpmc->ecc_used != cs)
 		return -EINVAL;
 
 	/* read ecc result */
@@ -915,7 +1604,7 @@ int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
 	/* P2048o, P1024o, P512o, P256o, P2048e, P1024e, P512e, P256e */
 	*ecc_code++ = ((val >> 8) & 0x0f) | ((val >> 20) & 0xf0);
 
-	gpmc_ecc_used = -EINVAL;
+	gpmc->ecc_used = -EINVAL;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gpmc_calculate_ecc);
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 1527929..2eedd99 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -11,6 +11,44 @@
 #ifndef __OMAP2_GPMC_H
 #define __OMAP2_GPMC_H
 
+/* configuration flags */
+#define	GPMC_WRITEPROTECT		BIT(0)
+#define	GPMC_TIMEPARAGRANULARITY	BIT(1)
+#define	GPMC_MUXADDDATA			BIT(2)
+#define	GPMC_DEVICETYPE_NOR		BIT(3)
+#define	GPMC_DEVICETYPE_NAND		BIT(4)
+#define	GPMC_DEVICESIZE_8		BIT(5)
+#define	GPMC_DEVICESIZE_16		BIT(6)
+#define	GPMC_WAIT_WRITE_MON		BIT(7)
+#define	GPMC_WAIT_READ_MON		BIT(8)
+#define	GPMC_PAGE_LEN_4			BIT(9)
+#define	GPMC_PAGE_LEN_8			BIT(10)
+#define	GPMC_PAGE_LEN_16		BIT(11)
+#define	GPMC_CLOCKACTIVATIONTIME_0	BIT(12)
+#define	GPMC_CLOCKACTIVATIONTIME_1	BIT(13)
+#define	GPMC_CLOCKACTIVATIONTIME_2	BIT(14)
+#define	GPMC_WRITETYPE_SYNC		BIT(15)
+#define	GPMC_WRITEMULTIPLE		BIT(16)
+#define	GPMC_READTYPE_SYNC		BIT(17)
+#define	GPMC_READMULTIPLE		BIT(18)
+#define	GPMC_WRAPBURST			BIT(19)
+#define	GPMC_WAITPIN_0			BIT(20)
+#define	GPMC_WAITPIN_1			BIT(21)
+#define	GPMC_WAITPIN_2			BIT(22)
+#define	GPMC_WAITPIN_3			BIT(23)
+#define	GPMC_WAITPIN_MASK		(GPMC_WAITPIN_0 | GPMC_WAITPIN_1 | \
+					GPMC_WAITPIN_2 | GPMC_WAITPIN_3)
+#define	GPMC_WAITPIN_ACTIVE_LOW		BIT(24)
+#define	GPMC_WAITPIN_ACTIVE_HIGH	BIT(25)
+#define	GPMC_WAITPIN_POLARITY_MASK	(GPMC_WAITPIN_ACTIVE_LOW | \
+					GPMC_WAITPIN_ACTIVE_HIGH)
+#define	GPMC_WAITPIN_MONITOR_TIME_1	BIT(26)
+#define	GPMC_WAITPIN_MONITOR_TIME_2	BIT(27)
+#define	GPMC_CLOCKACTIVATION_TIME_1	BIT(28)
+#define	GPMC_CLOCKACTIVATION_TIME_2	BIT(29)
+#define	GPMC_READTYPE_ASYNC		BIT(30)
+#define	GPMC_WRITETYPE_ASYNC		BIT(31)
+
 /* Maximum Number of Chip Selects */
 #define GPMC_CS_NUM		8
 
@@ -56,7 +94,11 @@
 #define GPMC_CONFIG1_WRITETYPE_ASYNC    (0 << 27)
 #define GPMC_CONFIG1_WRITETYPE_SYNC     (1 << 27)
 #define GPMC_CONFIG1_CLKACTIVATIONTIME(val) ((val & 3) << 25)
+#define GPMC_CONFIG1_CLKACTIVATIONTIME_1	(1 << 25)
+#define GPMC_CONFIG1_CLKACTIVATIONTIME_2	(1 << 26)
 #define GPMC_CONFIG1_PAGE_LEN(val)      ((val & 3) << 23)
+#define GPMC_CONFIG1_PAGE_LEN_16	(0x1 << 24)
+#define GPMC_CONFIG1_PAGE_LEN_8		(0x1 << 23)
 #define GPMC_CONFIG1_WAIT_READ_MON      (1 << 22)
 #define GPMC_CONFIG1_WAIT_WRITE_MON     (1 << 21)
 #define GPMC_CONFIG1_WAIT_MON_IIME(val) ((val & 3) << 18)
@@ -73,8 +115,6 @@
 #define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
 #define GPMC_CONFIG7_CSVALID		(1 << 6)
 
-#define GPMC_DEVICETYPE_NOR		0
-#define GPMC_DEVICETYPE_NAND		2
 #define GPMC_CONFIG_WRITEPROTECT	0x00000010
 #define GPMC_STATUS_BUFF_EMPTY		0x00000001
 #define WR_RD_PIN_MONITORING		0x00600000
@@ -94,6 +134,16 @@ enum omap_ecc {
 	OMAP_ECC_HAMMING_CODE_HW_ROMCODE, /* gpmc method & romcode layout */
 };
 
+/* turn on/off type timings */
+struct gpmc_onoff_timings {
+	bool cycle2cyclediffcsen;
+	bool cycle2cyclesamecsen;
+	bool we_extra_delay;
+	bool oe_extra_delay;
+	bool adv_extra_delay;
+	bool cs_extra_delay;
+};
+
 /*
  * Note that all values in this struct are in nanoseconds except sync_clk
  * (which is in picoseconds), while the register values are in gpmc_fck cycles.
@@ -126,11 +176,48 @@ struct gpmc_timings {
 	u16 rd_cycle;		/* Total read cycle time */
 	u16 wr_cycle;		/* Total write cycle time */
 
+	u16 cycle2cycle_delay;
+	u16 busturnaround;
+
 	/* The following are only on OMAP3430 */
 	u16 wr_access;		/* WRACCESSTIME */
 	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
+
+	struct gpmc_onoff_timings control;
+};
+
+struct gpmc_cs_data {
+	unsigned		cs;
+	unsigned long		mem_size;
+	unsigned long		mem_offset;
+	/* some boards rely on bootloader for configuration */
+	bool			have_config;
+	unsigned		config;
+	struct gpmc_timings	*timing;
+	unsigned		irq_config;
+};
+
+struct gpmc_device_pdata {
+	char			*name;
+	int			id;
+	void			*pdata;
+	unsigned		pdata_size;
+	/* resources configured via GPMC will be created by GPMC driver */
+	struct resource		*per_res;
+	unsigned		per_res_cnt;
+	struct gpmc_cs_data	*cs_data;
+	unsigned		num_cs;
 };
 
+struct gpmc_pdata {
+	/* GPMC_FCLK period in picoseconds */
+	unsigned long			clk_prd;
+	unsigned			num_device;
+	struct gpmc_device_pdata	**device_pdata;
+};
+
+extern int gpmc_cs_reconfigure(char *name, int id, struct gpmc_cs_data *cs);
+
 extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
 extern unsigned int gpmc_ps_to_ticks(unsigned int time_ps);
 extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
@@ -143,8 +230,6 @@ extern int gpmc_cs_calc_divider(int cs, unsigned int sync_clk);
 extern int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t);
 extern int gpmc_cs_request(int cs, unsigned long size, unsigned long *base);
 extern void gpmc_cs_free(int cs);
-extern int gpmc_cs_set_reserved(int cs, int reserved);
-extern int gpmc_cs_reserved(int cs);
 extern int gpmc_prefetch_enable(int cs, int fifo_th, int dma_mode,
 					unsigned int u32_count, int is_write);
 extern int gpmc_prefetch_reset(int cs);
-- 
1.7.10

