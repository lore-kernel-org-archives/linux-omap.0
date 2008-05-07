From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/5] fix sparse, checkpatch warnings in OMAP2/3 SMS/GPMC/SRAM code
Date: Wed, 07 May 2008 11:52:01 -0600
Message-ID: <20080507175201.17732.26332.stgit@localhost.localdomain>
References: <20080507171204.17732.97601.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59088 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933250AbYEGTui (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2008 15:50:38 -0400
In-Reply-To: <20080507171204.17732.97601.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Fix sparse warnings in SMS, GPMC, SRAM code involving arch/arm/mach-omap2/.
These fixes mostly consist of:

- tagging appropriate integer<->pointer casts with __force

- marking private structures and functions as static; adding function
  prototypes in .h files for public functions

- assigning NULL to pointers in structure initializers, not 0

- adding prototypes for *_init() functions in the appropriate header
  files, and getting rid of the corresponding open-coded extern
  prototypes in other C files


Also clean up some checkpatch issues by converting some asm/ includes
to linux/ includes.


Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/gpmc.c           |   42 +++++++++++++++++-----------------
 arch/arm/mach-omap2/io.c             |   12 +++++-----
 arch/arm/mach-omap2/memory.h         |    7 ++++++
 arch/arm/mach-omap2/sdrc.h           |    4 ++-
 include/asm-arm/arch-omap/omap24xx.h |    1 +
 include/asm-arm/arch-omap/sram.h     |    1 +
 6 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index b2455a9..8d9b50a 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -9,6 +9,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#undef DEBUG
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/err.h>
@@ -16,19 +18,14 @@
 #include <linux/ioport.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/arch/gpmc.h>
 
-#undef DEBUG
-
-#if defined(CONFIG_ARCH_OMAP2420)
-#define GPMC_BASE		0x6800a000
-#elif defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
-#define GPMC_BASE		0x6e000000
-#endif
+#include "memory.h"
 
+/* GPMC register offsets */
 #define GPMC_REVISION		0x00
 #define GPMC_SYSCONFIG		0x10
 #define GPMC_SYSSTATUS		0x14
@@ -62,34 +59,31 @@ static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
 static DEFINE_SPINLOCK(gpmc_mem_lock);
 static unsigned		gpmc_cs_map;
 
-static void __iomem *gpmc_base =
-	(void __iomem *) IO_ADDRESS(GPMC_BASE);
-static void __iomem *gpmc_cs_base =
-	(void __iomem *) IO_ADDRESS(GPMC_BASE) + GPMC_CS0;
+static u32 gpmc_base;
 
 static struct clk *gpmc_l3_clk;
 
 static void gpmc_write_reg(int idx, u32 val)
 {
-	__raw_writel(val, gpmc_base + idx);
+	omap_writel(val, gpmc_base + idx);
 }
 
 static u32 gpmc_read_reg(int idx)
 {
-	return __raw_readl(gpmc_base + idx);
+	return omap_readl(gpmc_base + idx);
 }
 
 void gpmc_cs_write_reg(int cs, int idx, u32 val)
 {
-	void __iomem *reg_addr;
+	u32 reg_addr;
 
-	reg_addr = gpmc_cs_base + (cs * GPMC_CS_SIZE) + idx;
-	__raw_writel(val, reg_addr);
+	reg_addr = gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx;
+	omap_writel(val, reg_addr);
 }
 
 u32 gpmc_cs_read_reg(int cs, int idx)
 {
-	return __raw_readl(gpmc_cs_base + (cs * GPMC_CS_SIZE) + idx);
+	return omap_readl(gpmc_base + GPMC_CS0 + (cs * GPMC_CS_SIZE) + idx);
 }
 
 /* TODO: Add support for gpmc_fck to clock framework and use it */
@@ -381,7 +375,7 @@ void gpmc_cs_free(int cs)
 }
 EXPORT_SYMBOL(gpmc_cs_free);
 
-void __init gpmc_mem_init(void)
+static void __init gpmc_mem_init(void)
 {
 	int cs;
 	unsigned long boot_rom_space = 0;
@@ -412,10 +406,16 @@ void __init gpmc_init(void)
 {
 	u32 l;
 
-	if (cpu_is_omap24xx())
+	if (cpu_is_omap24xx()) {
 		gpmc_l3_clk = clk_get(NULL, "core_l3_ck");
-	else if (cpu_is_omap34xx())
+		if (cpu_is_omap2420())
+			gpmc_base = OMAP2420_GPMC_BASE;
+		else if (cpu_is_omap2430())
+			gpmc_base = OMAP243X_GPMC_BASE;
+	} else if (cpu_is_omap34xx()) {
 		gpmc_l3_clk = clk_get(NULL, "gpmc_fck");
+		gpmc_base = OMAP34XX_GPMC_BASE;
+	}
 
 	BUG_ON(IS_ERR(gpmc_l3_clk));
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index aa319a5..2bb808e 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -18,14 +18,18 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
 
 #include <asm/tlb.h>
-#include <asm/io.h>
 
 #include <asm/mach/map.h>
-
 #include <asm/arch/mux.h>
 #include <asm/arch/omapfb.h>
+#include <asm/arch/sram.h>
+
+#include "memory.h"
+
+#include "clock.h"
 
 #include <asm/arch/powerdomain.h>
 
@@ -34,11 +38,7 @@
 #include <asm/arch/clockdomain.h>
 #include "clockdomains.h"
 
-extern void omap_sram_init(void);
-extern int omap2_clk_init(void);
 extern void omap2_check_revision(void);
-extern void omap2_init_memory(void);
-extern void gpmc_init(void);
 extern void omapfb_reserve_sdram(void);
 
 /*
diff --git a/arch/arm/mach-omap2/memory.h b/arch/arm/mach-omap2/memory.h
index 9a280b5..bb3db80 100644
--- a/arch/arm/mach-omap2/memory.h
+++ b/arch/arm/mach-omap2/memory.h
@@ -14,6 +14,9 @@
  * published by the Free Software Foundation.
  */
 
+#ifndef ARCH_ARM_MACH_OMAP2_MEMORY_H
+#define ARCH_ARM_MACH_OMAP2_MEMORY_H
+
 /* Memory timings */
 #define M_DDR		1
 #define M_LOCK_CTRL	(1 << 2)
@@ -34,3 +37,7 @@ extern u32 omap2_memory_get_fast_dll_ctrl(void);
 extern u32 omap2_memory_get_type(void);
 u32 omap2_dll_force_needed(void);
 u32 omap2_reprogram_sdrc(u32 level, u32 force);
+void __init omap2_init_memory(void);
+void __init gpmc_init(void);
+
+#endif
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index 928e1c4..ce3be73 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -31,7 +31,7 @@ extern unsigned long omap2_sms_base;
 static void __attribute__((unused)) sdrc_write_reg(u32 val, u16 reg)
 {
 	pr_debug("sdrc_write_reg: writing 0x%0x to 0x%0x\n", val,
-		 (u32)OMAP_SDRC_REGADDR(reg));
+		 (__force u32)OMAP_SDRC_REGADDR(reg));
 
 	__raw_writel(val, OMAP_SDRC_REGADDR(reg));
 }
@@ -46,7 +46,7 @@ static u32 __attribute__((unused)) sdrc_read_reg(u16 reg)
 static void __attribute__((unused)) sms_write_reg(u32 val, u16 reg)
 {
 	pr_debug("sms_write_reg: writing 0x%0x to 0x%0x\n", val,
-		 (u32)OMAP_SMS_REGADDR(reg));
+		 (__force u32)OMAP_SMS_REGADDR(reg));
 
 	__raw_writel(val, OMAP_SMS_REGADDR(reg));
 }
diff --git a/include/asm-arm/arch-omap/omap24xx.h b/include/asm-arm/arch-omap/omap24xx.h
index b9fcaae..affe39b 100644
--- a/include/asm-arm/arch-omap/omap24xx.h
+++ b/include/asm-arm/arch-omap/omap24xx.h
@@ -48,6 +48,7 @@
 #define OMAP2420_PRM_BASE	OMAP2420_CM_BASE
 #define OMAP2420_SDRC_BASE	(L3_24XX_BASE + 0x9000)
 #define OMAP2420_SMS_BASE	0x68008000
+#define OMAP2420_GPMC_BASE	0x6800a000
 
 #define OMAP2430_32KSYNCT_BASE	(L4_WK_243X_BASE + 0x20000)
 #define OMAP2430_PRCM_BASE	(L4_WK_243X_BASE + 0x6000)
diff --git a/include/asm-arm/arch-omap/sram.h b/include/asm-arm/arch-omap/sram.h
index c55df46..cc57dab 100644
--- a/include/asm-arm/arch-omap/sram.h
+++ b/include/asm-arm/arch-omap/sram.h
@@ -13,6 +13,7 @@
 
 #include <linux/poison.h>    /* for SRAM_VA_MAGIC */
 
+extern int __init omap_sram_init(void);
 extern void * omap_sram_push(void * start, unsigned long size);
 extern int omap_sram_patch_va(void *srcfn, void *srcd, void *sramfn, void __iomem *d);
 extern void omap_sram_reprogram_clock(u32 dpllctl, u32 ckctl);


