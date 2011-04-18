From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH v2] Consolidate SRAM support
Date: Mon, 18 Apr 2011 09:52:59 +0100
Message-ID: <20110418085259.GA26044@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45866 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab1DRIxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 04:53:30 -0400
Content-Disposition: inline
In-Reply-To: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This is the second revision of this patch.  I've not moved it out of
ARM yet as I haven't had a positive response from SH yet.

It's now called pv_pool (for phys/virt pool) rather than sram_pool,
and I've included MXC's iram support in this.  Hopefully, if OMAP can
remove the FB stuff from SRAM we can clean the OMAP bits up a little
more.  Neither have I sorted out the last reference to omap_sram_ceil.
Some comments from OMAP people on what's going on there would be good.

On Fri, Apr 15, 2011 at 02:06:07PM +0100, Russell King - ARM Linux wrote:
> This is work in progress.
> 
> We have two SoCs using SRAM, both with their own allocation systems,
> and both with their own ways of copying functions into the SRAM.
> 
> Let's unify this before we have additional SoCs re-implementing this
> obviously common functionality themselves.
> 
> Unfortunately, we end up with code growth through doing this, but that
> will become a win when we have another SoC using this (which I know
> there's at least one in the pipeline).
> 
> One of the considerations here is that we can easily convert sram-pool.c
> to hook into device tree stuff, which can tell the sram allocator:
> 	- physical address of sram
> 	- size of sram
> 	- allocation granularity
> and then we just need to ensure that it is appropriately mapped.
> 
> This uses the physical address, and unlike Davinci's dma address usage,
> it always wants to have the physical address, and will always return
> the corresponding physical address when passed that pointer.
> 
> OMAP could probably do with some more work to make the omapfb and other
> allocations use the sram allocator, rather than hooking in before the
> sram allocator is initialized - and then further cleanups so that we
> have an initialization function which just does
> 
> sram_create(phys, size)
> 	virt = map sram(phys, size)
> 	create sram pool(virt, phys, size, min_alloc_order)
> 
> Another question is whether we should allow multiple SRAM pools or not -
> this code does allow multiple pools, but so far we only have one pool
> per SoC.  Overdesign?  Maybe, but it prevents SoCs wanting to duplicate
> it if they want to partition the SRAM, or have peripheral-local SRAMs.
> 
> Lastly, uio_pruss should probably take the SRAM pool pointer via
> platform data so that it doesn't have to include Davinci specific
> includes.

 arch/arm/Kconfig                            |    2 +
 arch/arm/common/Kconfig                     |    4 ++
 arch/arm/common/Makefile                    |    1 +
 arch/arm/common/pv-pool.c                   |   69 +++++++++++++++++++++++++++
 arch/arm/include/asm/pv-pool.h              |   20 ++++++++
 arch/arm/mach-davinci/da850.c               |    2 +-
 arch/arm/mach-davinci/dm355.c               |    2 +-
 arch/arm/mach-davinci/dm365.c               |    2 +-
 arch/arm/mach-davinci/dm644x.c              |    2 +-
 arch/arm/mach-davinci/dm646x.c              |    2 +-
 arch/arm/mach-davinci/include/mach/common.h |    2 +-
 arch/arm/mach-davinci/include/mach/sram.h   |   13 +----
 arch/arm/mach-davinci/pm.c                  |   12 +----
 arch/arm/mach-davinci/sram.c                |   42 +++--------------
 arch/arm/plat-mxc/Kconfig                   |    2 +-
 arch/arm/plat-mxc/include/mach/iram.h       |   24 +++++++--
 arch/arm/plat-mxc/iram_alloc.c              |   50 +++++---------------
 arch/arm/plat-omap/include/plat/sram.h      |   17 ++++---
 arch/arm/plat-omap/sram.c                   |   34 +++++---------
 drivers/uio/uio_pruss.c                     |    7 ++-
 20 files changed, 171 insertions(+), 138 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b9f78b..5c3401c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -850,6 +850,7 @@ config ARCH_DAVINCI
 	bool "TI DaVinci"
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
+	select PV_POOL
 	select ZONE_DMA
 	select HAVE_IDE
 	select CLKDEV_LOOKUP
@@ -863,6 +864,7 @@ config ARCH_OMAP
 	select HAVE_CLK
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_CPUFREQ
+	select PV_POOL
 	select GENERIC_CLOCKEVENTS
 	select HAVE_SCHED_CLOCK
 	select ARCH_HAS_HOLES_MEMORYMODEL
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index ea5ee4d..ddbd20b 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -39,3 +39,7 @@ config SHARP_PARAM
 
 config SHARP_SCOOP
 	bool
+
+config PV_POOL
+	bool
+	select GENERIC_ALLOCATOR
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index e7521bca..b79ad68 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_ARCH_IXP23XX)	+= uengine.o
 obj-$(CONFIG_ARCH_IXP23XX)	+= uengine.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
+obj-$(CONFIG_PV_POOL)		+= pv-pool.o
diff --git a/arch/arm/common/pv-pool.c b/arch/arm/common/pv-pool.c
new file mode 100644
index 0000000..9ff1466
--- /dev/null
+++ b/arch/arm/common/pv-pool.c
@@ -0,0 +1,69 @@
+/*
+ * Unified Phys/Virt allocator, based on mach-davinci/sram.c, which was
+ * Copyright (C) 2009 David Brownell.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/dma-mapping.h>
+#include <linux/genalloc.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include <asm/pv-pool.h>
+
+struct pv_pool {
+	struct gen_pool *genpool;
+	void *cpu_base;
+	phys_addr_t phys_base;
+};
+
+void *pv_pool_alloc(struct pv_pool *pool, size_t len, phys_addr_t *phys)
+{
+	void *addr = (void *)gen_pool_alloc(pool->genpool, len);
+
+	if (phys)
+		*phys = addr ? (pool->phys_base + (addr - pool->cpu_base)) :
+			 (phys_addr_t)-1ULL;
+
+	return addr;
+}
+EXPORT_SYMBOL_GPL(pv_pool_alloc);
+
+void pv_pool_free(struct pv_pool *pool, void *addr, size_t len)
+{
+	gen_pool_free(pool->genpool, (unsigned long)addr, len);
+}
+EXPORT_SYMBOL_GPL(pv_pool_free);
+
+struct pv_pool *pv_pool_create(void *addr, phys_addr_t phys, size_t len,
+	int min_alloc_order)
+{
+	struct pv_pool *pool = kzalloc(sizeof(struct pv_pool), GFP_KERNEL);
+
+	if (pool) {
+		pool->cpu_base = addr;
+		pool->phys_base = phys;
+		pool->genpool = gen_pool_create(min_alloc_order, -1);
+		if (!pool->genpool) {
+			kfree(pool);
+			pool = NULL;
+		} else {
+			WARN_ON(gen_pool_add(pool->genpool, (unsigned long)addr,
+						len, -1) < 0);
+		}
+	}
+
+	return pool;
+}
+EXPORT_SYMBOL_GPL(pv_pool_create);
+
+void pv_pool_destroy(struct pv_pool *pool)
+{
+	gen_pool_destroy(pool->genpool);
+	kfree(pool);
+}
+EXPORT_SYMBOL_GPL(pv_pool_destroy);
diff --git a/arch/arm/include/asm/pv-pool.h b/arch/arm/include/asm/pv-pool.h
new file mode 100644
index 0000000..b7ae871
--- /dev/null
+++ b/arch/arm/include/asm/pv-pool.h
@@ -0,0 +1,20 @@
+#ifndef __ASMARM_PV_POOL_H
+#define __ASMARM_PV_POOL_H
+
+#include <asm/fncpy.h>
+
+struct pv_pool;
+
+void *pv_pool_alloc(struct pv_pool *, size_t, phys_addr_t *);
+void pv_pool_free(struct pv_pool *, void *, size_t);
+struct pv_pool *pv_pool_create(void *, phys_addr_t, size_t, int);
+void pv_pool_destroy(struct pv_pool *);
+
+/* Macro to copy a function into SRAM, using the fncpy API */
+#define pv_pool_fncpy(pool, funcp, size) ({			\
+	size_t _sz = size;					\
+	void *_sram = pv_pool_alloc(pool, _sz, NULL);		\
+	(_sram ? fncpy(_sram, &(funcp), _sz) : NULL);		\
+})
+
+#endif
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 68fe4c2..5eca128 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1099,7 +1099,7 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.gpio_irq		= IRQ_DA8XX_GPIO0,
 	.serial_dev		= &da8xx_serial_device,
 	.emac_pdata		= &da8xx_emac_pdata,
-	.sram_dma		= DA8XX_ARM_RAM_BASE,
+	.sram_phys		= DA8XX_ARM_RAM_BASE,
 	.sram_len		= SZ_8K,
 	.reset_device		= &da8xx_wdt_device,
 };
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 76364d1..3df8730 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -850,7 +850,7 @@ static struct davinci_soc_info davinci_soc_info_dm355 = {
 	.gpio_num		= 104,
 	.gpio_irq		= IRQ_DM355_GPIOBNK0,
 	.serial_dev		= &dm355_serial_device,
-	.sram_dma		= 0x00010000,
+	.sram_phys		= 0x00010000,
 	.sram_len		= SZ_32K,
 	.reset_device		= &davinci_wdt_device,
 };
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 4604e72..d306034 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1082,7 +1082,7 @@ static struct davinci_soc_info davinci_soc_info_dm365 = {
 	.gpio_unbanked		= 8,	/* really 16 ... skip muxed GPIOs */
 	.serial_dev		= &dm365_serial_device,
 	.emac_pdata		= &dm365_emac_pdata,
-	.sram_dma		= 0x00010000,
+	.sram_phys		= 0x00010000,
 	.sram_len		= SZ_32K,
 	.reset_device		= &davinci_wdt_device,
 };
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 9a2376b..4ca7295 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -764,7 +764,7 @@ static struct davinci_soc_info davinci_soc_info_dm644x = {
 	.gpio_irq		= IRQ_GPIOBNK0,
 	.serial_dev		= &dm644x_serial_device,
 	.emac_pdata		= &dm644x_emac_pdata,
-	.sram_dma		= 0x00008000,
+	.sram_phys		= 0x00008000,
 	.sram_len		= SZ_16K,
 	.reset_device		= &davinci_wdt_device,
 };
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 1e0f809..a4365f7 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -848,7 +848,7 @@ static struct davinci_soc_info davinci_soc_info_dm646x = {
 	.gpio_irq		= IRQ_DM646X_GPIOBNK0,
 	.serial_dev		= &dm646x_serial_device,
 	.emac_pdata		= &dm646x_emac_pdata,
-	.sram_dma		= 0x10010000,
+	.sram_phys		= 0x10010000,
 	.sram_len		= SZ_32K,
 	.reset_device		= &davinci_wdt_device,
 };
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index a57cba2..665d049 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -75,7 +75,7 @@ struct davinci_soc_info {
 	int				gpio_ctlrs_num;
 	struct platform_device		*serial_dev;
 	struct emac_platform_data	*emac_pdata;
-	dma_addr_t			sram_dma;
+	phys_addr_t			sram_phys;
 	unsigned			sram_len;
 	struct platform_device		*reset_device;
 	void				(*reset)(struct platform_device *);
diff --git a/arch/arm/mach-davinci/include/mach/sram.h b/arch/arm/mach-davinci/include/mach/sram.h
index 111f7cc..7d77e85 100644
--- a/arch/arm/mach-davinci/include/mach/sram.h
+++ b/arch/arm/mach-davinci/include/mach/sram.h
@@ -10,18 +10,11 @@
 #ifndef __MACH_SRAM_H
 #define __MACH_SRAM_H
 
+#include <asm/pv-pool.h>
+
 /* ARBITRARY:  SRAM allocations are multiples of this 2^N size */
 #define SRAM_GRANULARITY	512
 
-/*
- * SRAM allocations return a CPU virtual address, or NULL on error.
- * If a DMA address is requested and the SRAM supports DMA, its
- * mapped address is also returned.
- *
- * Errors include SRAM memory not being available, and requesting
- * DMA mapped SRAM on systems which don't allow that.
- */
-extern void *sram_alloc(size_t len, dma_addr_t *dma);
-extern void sram_free(void *addr, size_t len);
+extern struct pv_pool *davinci_pv_pool;
 
 #endif /* __MACH_SRAM_H */
diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
index 1bd73a0..f69cd7b 100644
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -29,12 +29,6 @@
 static void (*davinci_sram_suspend) (struct davinci_pm_config *);
 static struct davinci_pm_config *pdata;
 
-static void davinci_sram_push(void *dest, void *src, unsigned int size)
-{
-	memcpy(dest, src, size);
-	flush_icache_range((unsigned long)dest, (unsigned long)(dest + size));
-}
-
 static void davinci_pm_suspend(void)
 {
 	unsigned val;
@@ -123,15 +117,13 @@ static int __init davinci_pm_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	davinci_sram_suspend = sram_alloc(davinci_cpu_suspend_sz, NULL);
+	davinci_sram_suspend = pv_pool_fncpy(davinci_pv_pool,
+				davinci_cpu_suspend, davinci_cpu_suspend_sz);
 	if (!davinci_sram_suspend) {
 		dev_err(&pdev->dev, "cannot allocate SRAM memory\n");
 		return -ENOMEM;
 	}
 
-	davinci_sram_push(davinci_sram_suspend, davinci_cpu_suspend,
-						davinci_cpu_suspend_sz);
-
 	suspend_set_ops(&davinci_pm_ops);
 
 	return 0;
diff --git a/arch/arm/mach-davinci/sram.c b/arch/arm/mach-davinci/sram.c
index db0f778..ebd4d67 100644
--- a/arch/arm/mach-davinci/sram.c
+++ b/arch/arm/mach-davinci/sram.c
@@ -10,40 +10,13 @@
  */
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/genalloc.h>
+#include <asm/pv-pool.h>
 
 #include <mach/common.h>
 #include <mach/sram.h>
 
-static struct gen_pool *sram_pool;
-
-void *sram_alloc(size_t len, dma_addr_t *dma)
-{
-	unsigned long vaddr;
-	dma_addr_t dma_base = davinci_soc_info.sram_dma;
-
-	if (dma)
-		*dma = 0;
-	if (!sram_pool || (dma && !dma_base))
-		return NULL;
-
-	vaddr = gen_pool_alloc(sram_pool, len);
-	if (!vaddr)
-		return NULL;
-
-	if (dma)
-		*dma = dma_base + (vaddr - SRAM_VIRT);
-	return (void *)vaddr;
-
-}
-EXPORT_SYMBOL(sram_alloc);
-
-void sram_free(void *addr, size_t len)
-{
-	gen_pool_free(sram_pool, (unsigned long) addr, len);
-}
-EXPORT_SYMBOL(sram_free);
-
+struct pv_pool *davinci_pv_pool;
+EXPORT_SYMBOL_GPL(davinci_pv_pool);
 
 /*
  * REVISIT This supports CPU and DMA access to/from SRAM, but it
@@ -58,13 +31,12 @@ static int __init sram_init(void)
 
 	if (len) {
 		len = min_t(unsigned, len, SRAM_SIZE);
-		sram_pool = gen_pool_create(ilog2(SRAM_GRANULARITY), -1);
-		if (!sram_pool)
+		davinci_pv_pool = pv_pool_create((void *)SRAM_VIRT,
+					davinci_soc_info.sram_phys, len,
+					ilog2(SRAM_GRANULARITY));
+		if (!davinci_pv_pool)
 			status = -ENOMEM;
 	}
-	if (sram_pool)
-		status = gen_pool_add(sram_pool, SRAM_VIRT, len, -1);
-	WARN_ON(status < 0);
 	return status;
 }
 core_initcall(sram_init);
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index b0cb425..f60d5ea 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -118,6 +118,6 @@ config ARCH_MXC_AUDMUX_V2
 
 config IRAM_ALLOC
 	bool
-	select GENERIC_ALLOCATOR
+	select PV_POOL
 
 endif
diff --git a/arch/arm/plat-mxc/include/mach/iram.h b/arch/arm/plat-mxc/include/mach/iram.h
index 022690c..543c6df 100644
--- a/arch/arm/plat-mxc/include/mach/iram.h
+++ b/arch/arm/plat-mxc/include/mach/iram.h
@@ -17,25 +17,37 @@
  * MA 02110-1301, USA.
  */
 #include <linux/errno.h>
+#include <asm/pv-pool.h>
 
 #ifdef CONFIG_IRAM_ALLOC
 
-int __init iram_init(unsigned long base, unsigned long size);
-void __iomem *iram_alloc(unsigned int size, unsigned long *dma_addr);
-void iram_free(unsigned long dma_addr, unsigned int size);
+int __init iram_init(phys_addr_t base, size_t size);
+
+extern struct pv_pool *mxc_iram_pool;
+
+static inline void *iram_alloc(size_t size, phys_addr_t *phys)
+{
+	return pv_pool_alloc(iram_pool, size, phys);
+}
+
+static inline void iram_free(void *addr, size_t size)
+{
+	pv_pool_free(iram_pool, addr, size);
+}
 
 #else
 
-static inline int __init iram_init(unsigned long base, unsigned long size)
+static inline int __init iram_init(phys_addr_t base, size_t size)
 {
 	return -ENOMEM;
 }
 
-static inline void __iomem *iram_alloc(unsigned int size, unsigned long *dma_addr)
+static inline void *iram_alloc(size_t size, phys_addr_t *phys)
 {
+	*phys = (phys_addr_t)-1ULL;
 	return NULL;
 }
 
-static inline void iram_free(unsigned long base, unsigned long size) {}
+static inline void iram_free(void *addr, size_t size) {}
 
 #endif
diff --git a/arch/arm/plat-mxc/iram_alloc.c b/arch/arm/plat-mxc/iram_alloc.c
index 074c386..1e3d437 100644
--- a/arch/arm/plat-mxc/iram_alloc.c
+++ b/arch/arm/plat-mxc/iram_alloc.c
@@ -24,50 +24,24 @@
 #include <linux/genalloc.h>
 #include <mach/iram.h>
 
-static unsigned long iram_phys_base;
-static void __iomem *iram_virt_base;
-static struct gen_pool *iram_pool;
+struct pv_pool *mxc_iram_pool;
+EXPORT_SYMBOL(mxc_iram_pool);
 
-static inline void __iomem *iram_phys_to_virt(unsigned long p)
+int __init iram_init(phys_addr_t base, size_t size)
 {
-	return iram_virt_base + (p - iram_phys_base);
-}
-
-void __iomem *iram_alloc(unsigned int size, unsigned long *dma_addr)
-{
-	if (!iram_pool)
-		return NULL;
-
-	*dma_addr = gen_pool_alloc(iram_pool, size);
-	pr_debug("iram alloc - %dB@0x%lX\n", size, *dma_addr);
-	if (!*dma_addr)
-		return NULL;
-	return iram_phys_to_virt(*dma_addr);
-}
-EXPORT_SYMBOL(iram_alloc);
-
-void iram_free(unsigned long addr, unsigned int size)
-{
-	if (!iram_pool)
-		return;
-
-	gen_pool_free(iram_pool, addr, size);
-}
-EXPORT_SYMBOL(iram_free);
+	void *addr = /*FIXME*/ ioremap(base, size);
 
-int __init iram_init(unsigned long base, unsigned long size)
-{
-	iram_phys_base = base;
+	if (!addr)
+		return -EIO;
 
-	iram_pool = gen_pool_create(PAGE_SHIFT, -1);
-	if (!iram_pool)
+	mxc_iram_pool = pv_pool_create(addr, base, size, PAGE_SHIFT);
+	if (!mxc_iram_pool) {
+		iounmap(addr);
 		return -ENOMEM;
+	}
 
-	gen_pool_add(iram_pool, base, size, -1);
-	iram_virt_base = ioremap(iram_phys_base, size);
-	if (!iram_virt_base)
-		return -EIO;
+	pr_debug("i.MX IRAM pool: %lu KB@0x%08llx\n", size / 1024,
+		 (unsigned long long)base);
 
-	pr_debug("i.MX IRAM pool: %ld KB@0x%p\n", size / 1024, iram_virt_base);
 	return 0;
 }
diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
index f500fc3..9fc27d0 100644
--- a/arch/arm/plat-omap/include/plat/sram.h
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -12,16 +12,19 @@
 #define __ARCH_ARM_OMAP_SRAM_H
 
 #ifndef __ASSEMBLY__
-#include <asm/fncpy.h>
+#include <asm/pv-pool.h>
 
-extern void *omap_sram_push_address(unsigned long size);
+extern struct pv_pool *omap_pv_pool;
 
-/* Macro to push a function to the internal SRAM, using the fncpy API */
+/*
+ * Note that fncpy requires the SRAM address to be aligned to an 8-byte
+ * boundary, so the min_alloc_order for the pool is set appropriately.
+ */
 #define omap_sram_push(funcp, size) ({				\
-	typeof(&(funcp)) _res = NULL;				\
-	void *_sram_address = omap_sram_push_address(size);	\
-	if (_sram_address)					\
-		_res = fncpy(_sram_address, &(funcp), size);	\
+	typeof(&(funcp)) _res;					\
+	_res = pv_pool_fncpy(omap_pv_pool, funcp, size);	\
+	if (!_res)						\
+		pr_err("Not enough space in SRAM\n");		\
 	_res;							\
 })
 
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index a3f50b3..3588749 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -75,7 +75,6 @@
 static unsigned long omap_sram_start;
 static unsigned long omap_sram_base;
 static unsigned long omap_sram_size;
-static unsigned long omap_sram_ceil;
 
 /*
  * Depending on the target RAMFS firewall setup, the public usable amount of
@@ -104,6 +103,8 @@ static int is_sram_locked(void)
 		return 1; /* assume locked with no PPA or security driver */
 }
 
+struct pv_pool *omap_pv_pool;
+
 /*
  * The amount of SRAM depends on the core type.
  * Note that we cannot try to test for SRAM here because writes
@@ -182,7 +183,16 @@ static void __init omap_detect_sram(void)
 			omap_sram_size - SRAM_BOOTLOADER_SZ);
 	omap_sram_size -= reserved;
 
-	omap_sram_ceil = omap_sram_base + omap_sram_size;
+	{
+		/* The first SRAM_BOOTLOADER_SZ of SRAM are reserved */
+		void *base = (void *)omap_sram_base + SRAM_BOOTLOADER_SZ;
+		phys_addr_t phys = omap_sram_start + SRAM_BOOTLOADER_SZ;
+		size_t len = omap_sram_size - SRAM_BOOTLOADER_SZ;
+
+		omap_pv_pool = pv_pool_create(base, phys, len,
+						ilog2(FNCPY_ALIGN));
+		WARN_ON(!omap_pv_pool);
+	}
 }
 
 static struct map_desc omap_sram_io_desc[] __initdata = {
@@ -242,26 +252,6 @@ static void __init omap_map_sram(void)
 	       omap_sram_size - SRAM_BOOTLOADER_SZ);
 }
 
-/*
- * Memory allocator for SRAM: calculates the new ceiling address
- * for pushing a function using the fncpy API.
- *
- * Note that fncpy requires the returned address to be aligned
- * to an 8-byte boundary.
- */
-void *omap_sram_push_address(unsigned long size)
-{
-	if (size > (omap_sram_ceil - (omap_sram_base + SRAM_BOOTLOADER_SZ))) {
-		printk(KERN_ERR "Not enough space in SRAM\n");
-		return NULL;
-	}
-
-	omap_sram_ceil -= size;
-	omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, FNCPY_ALIGN);
-
-	return (void *)omap_sram_ceil;
-}
-
 #ifdef CONFIG_ARCH_OMAP1
 
 static void (*_omap_sram_reprogram_clock)(u32 dpllctl, u32 ckctl);
diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index daf6e77..2be3155 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -62,7 +62,7 @@ MODULE_PARM_DESC(extram_pool_sz, "external ram pool size to allocate");
 struct uio_pruss_dev {
 	struct uio_info *info;
 	struct clk *pruss_clk;
-	dma_addr_t sram_paddr;
+	phys_addr_t sram_paddr;
 	dma_addr_t ddr_paddr;
 	void __iomem *prussio_vaddr;
 	void *sram_vaddr;
@@ -106,7 +106,7 @@ static void pruss_cleanup(struct platform_device *dev,
 			gdev->ddr_paddr);
 	}
 	if (gdev->sram_vaddr)
-		sram_free(gdev->sram_vaddr, sram_pool_sz);
+		pv_pool_free(davinci_pv_pool, gdev->sram_vaddr, sram_pool_sz);
 	kfree(gdev->info);
 	clk_put(gdev->pruss_clk);
 	kfree(gdev);
@@ -152,7 +152,8 @@ static int __devinit pruss_probe(struct platform_device *dev)
 		goto out_free;
 	}
 
-	gdev->sram_vaddr = sram_alloc(sram_pool_sz, &(gdev->sram_paddr));
+	gdev->sram_vaddr = pv_pool_alloc(davinci_pv_pool, sram_pool_sz,
+					   &(gdev->sram_paddr));
 	if (!gdev->sram_vaddr) {
 		dev_err(&dev->dev, "Could not allocate SRAM pool\n");
 		goto out_free;
