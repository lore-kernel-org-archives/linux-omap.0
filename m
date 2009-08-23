From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/5] ARM: OMAP2/3/4: Split OMAP2_IO_ADDRESS to L3 and L4
Date: Sun, 23 Aug 2009 19:04:51 +0530
Message-ID: <1251034495-10107-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53628 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933788AbZHWNfH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Aug 2009 09:35:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch splits OMAP2_IO_ADDRESS to OMAP2_L3_IO_ADDRESS and
OMAP2_L4_IO_ADDRESS to reclaim more IO space.

The omap_read*() and omap_write*() functions will work only over 
L4 address space. Current omap kernel stack uses these functions 
only to access registers over L4 io address space 

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c           |    4 +-
 arch/arm/mach-omap2/cm.h                      |    6 ++--
 arch/arm/mach-omap2/irq.c                     |    4 +-
 arch/arm/mach-omap2/omap-smp.c                |    2 +-
 arch/arm/mach-omap2/pm-debug.c                |    3 +-
 arch/arm/mach-omap2/prm.h                     |    6 ++--
 arch/arm/mach-omap2/sdrc.h                    |    9 +++--
 arch/arm/mach-omap2/serial.c                  |    6 ++--
 arch/arm/mach-omap2/sram242x.S                |    4 +-
 arch/arm/mach-omap2/sram243x.S                |    4 +-
 arch/arm/mach-omap2/timer-gp.c                |    2 +-
 arch/arm/plat-omap/common.c                   |   44 ++++++++++++------------
 arch/arm/plat-omap/dma.c                      |    6 ++--
 arch/arm/plat-omap/dmtimer.c                  |    2 +-
 arch/arm/plat-omap/gpio.c                     |   42 ++++++++++++------------
 arch/arm/plat-omap/include/mach/control.h     |   15 +++++---
 arch/arm/plat-omap/include/mach/entry-macro.S |    4 +-
 arch/arm/plat-omap/include/mach/io.h          |    6 ++-
 arch/arm/plat-omap/include/mach/omap44xx.h    |   11 ++++--
 arch/arm/plat-omap/include/mach/sdrc.h        |    6 ++--
 arch/arm/plat-omap/io.c                       |   12 +++---
 arch/arm/plat-omap/sram.c                     |   18 +++++-----
 drivers/video/omap/dispc.c                    |    6 ++--
 23 files changed, 117 insertions(+), 105 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index bdfda36..2ecd9af 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -53,8 +53,8 @@ static struct omap_board_config_kernel sdp4430_config[] __initdata = {
 
 static void __init gic_init_irq(void)
 {
-	gic_dist_init(0, OMAP2_IO_ADDRESS(OMAP44XX_GIC_DIST_BASE), 29);
-	gic_cpu_init(0, OMAP2_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE));
+	gic_dist_init(0, OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_DIST_BASE), 29);
+	gic_cpu_init(0, OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE));
 }
 
 static void __init omap_4430sdp_init_irq(void)
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 18d9a12..891a3f2 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -17,11 +17,11 @@
 #include "prcm-common.h"
 
 #define OMAP2420_CM_REGADDR(module, reg)				\
-			OMAP2_IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
+			OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
 #define OMAP2430_CM_REGADDR(module, reg)				\
-			OMAP2_IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
+			OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
 #define OMAP34XX_CM_REGADDR(module, reg)				\
-			OMAP2_IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
+			OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
 
 /*
  * Architecture-specific global CM registers
diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index b828638..8db0e3a 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -181,9 +181,9 @@ void __init omap_init_irq(void)
 		struct omap_irq_bank *bank = irq_banks + i;
 
 		if (cpu_is_omap24xx())
-			bank->base_reg = OMAP2_IO_ADDRESS(OMAP24XX_IC_BASE);
+			bank->base_reg = OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE);
 		else if (cpu_is_omap34xx())
-			bank->base_reg = OMAP2_IO_ADDRESS(OMAP34XX_IC_BASE);
+			bank->base_reg = OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE);
 
 		omap_irq_bank_init_one(bank);
 
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 48ee295..2de024f 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -54,7 +54,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * for us: do so
 	 */
 
-	gic_cpu_init(0, OMAP2_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE));
+	gic_cpu_init(0, OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE));
 
 	/*
 	 * Synchronise with the boot thread.
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index da3a53f..e9cbd75 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -48,7 +48,8 @@ int omap2_pm_debug;
 	regs[reg_count++].val = __raw_readl(reg)
 #define DUMP_INTC_REG(reg, off) \
 	regs[reg_count].name = #reg; \
-	regs[reg_count++].val = __raw_readl(OMAP2_IO_ADDRESS(0x480fe000 + (off)))
+	regs[reg_count++].val = \
+			 __raw_readl(OMAP2_L4_IO_ADDRESS(0x480fe000 + (off)))
 
 void omap2_pm_dump(int mode, int resume, unsigned int us)
 {
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 03c467c..a117f85 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -17,11 +17,11 @@
 #include "prcm-common.h"
 
 #define OMAP2420_PRM_REGADDR(module, reg)				\
-			OMAP2_IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
+		OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
 #define OMAP2430_PRM_REGADDR(module, reg)				\
-			OMAP2_IO_ADDRESS(OMAP2430_PRM_BASE + (module) + (reg))
+		OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE + (module) + (reg))
 #define OMAP34XX_PRM_REGADDR(module, reg)				\
-			OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
+		OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
 
 /*
  * Architecture-specific global PRM registers
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index 0837eda..345183d 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -48,9 +48,12 @@ static inline u32 sms_read_reg(u16 reg)
 	return __raw_readl(OMAP_SMS_REGADDR(reg));
 }
 #else
-#define OMAP242X_SDRC_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP2420_SDRC_BASE + (reg))
-#define OMAP243X_SDRC_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP243X_SDRC_BASE + (reg))
-#define OMAP34XX_SDRC_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE + (reg))
+#define OMAP242X_SDRC_REGADDR(reg)					\
+			OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE + (reg))
+#define OMAP243X_SDRC_REGADDR(reg)					\
+			OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE + (reg))
+#define OMAP34XX_SDRC_REGADDR(reg)					\
+			OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE + (reg))
 #endif	/* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 4244900..63b16f4 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -73,7 +73,7 @@ static LIST_HEAD(uart_list);
 
 static struct plat_serial8250_port serial_platform_data0[] = {
 	{
-		.membase	= OMAP2_IO_ADDRESS(OMAP_UART1_BASE),
+		.membase	= OMAP2_L4_IO_ADDRESS(OMAP_UART1_BASE),
 		.mapbase	= OMAP_UART1_BASE,
 		.irq		= 72,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -87,7 +87,7 @@ static struct plat_serial8250_port serial_platform_data0[] = {
 
 static struct plat_serial8250_port serial_platform_data1[] = {
 	{
-		.membase	= OMAP2_IO_ADDRESS(OMAP_UART2_BASE),
+		.membase	= OMAP2_L4_IO_ADDRESS(OMAP_UART2_BASE),
 		.mapbase	= OMAP_UART2_BASE,
 		.irq		= 73,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -101,7 +101,7 @@ static struct plat_serial8250_port serial_platform_data1[] = {
 
 static struct plat_serial8250_port serial_platform_data2[] = {
 	{
-		.membase	= OMAP2_IO_ADDRESS(OMAP_UART3_BASE),
+		.membase	= OMAP2_L4_IO_ADDRESS(OMAP_UART3_BASE),
 		.mapbase	= OMAP_UART3_BASE,
 		.irq		= 74,
 		.flags		= UPF_BOOT_AUTOCONF,
diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
index 9b62208..92e6e1a 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -128,7 +128,7 @@ omap242x_sdi_prcm_voltctrl:
 prcm_mask_val:
 	.word 0xFFFF3FFC
 omap242x_sdi_timer_32ksynct_cr:
-	.word OMAP2_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
+	.word OMAP2_L4_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
 ENTRY(omap242x_sram_ddr_init_sz)
 	.word	. - omap242x_sram_ddr_init
 
@@ -224,7 +224,7 @@ omap242x_srs_prcm_voltctrl:
 ddr_prcm_mask_val:
 	.word 0xFFFF3FFC
 omap242x_srs_timer_32ksynct:
-	.word OMAP2_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
+	.word OMAP2_L4_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
 
 ENTRY(omap242x_sram_reprogram_sdrc_sz)
 	.word	. - omap242x_sram_reprogram_sdrc
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
index df2cd92..ab49736 100644
--- a/arch/arm/mach-omap2/sram243x.S
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -128,7 +128,7 @@ omap243x_sdi_prcm_voltctrl:
 prcm_mask_val:
 	.word 0xFFFF3FFC
 omap243x_sdi_timer_32ksynct_cr:
-	.word OMAP2_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
+	.word OMAP2_L4_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
 ENTRY(omap243x_sram_ddr_init_sz)
 	.word	. - omap243x_sram_ddr_init
 
@@ -224,7 +224,7 @@ omap243x_srs_prcm_voltctrl:
 ddr_prcm_mask_val:
 	.word 0xFFFF3FFC
 omap243x_srs_timer_32ksynct:
-	.word OMAP2_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
+	.word OMAP2_L4_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
 
 ENTRY(omap243x_sram_reprogram_sdrc_sz)
 	.word	. - omap243x_sram_reprogram_sdrc
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index e2338c0..95a2176 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -231,7 +231,7 @@ static void __init omap2_gp_clocksource_init(void)
 static void __init omap2_gp_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
-	twd_base = OMAP2_IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE);
+	twd_base = OMAP2_L4_IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE);
 #endif
 	omap_dm_timer_init();
 
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index ebcf006..dfabe2a 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -315,12 +315,12 @@ static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 
 static struct omap_globals omap242x_globals = {
 	.class	= OMAP242X_CLASS,
-	.tap	= OMAP2_IO_ADDRESS(0x48014000),
-	.sdrc	= OMAP2_IO_ADDRESS(OMAP2420_SDRC_BASE),
-	.sms	= OMAP2_IO_ADDRESS(OMAP2420_SMS_BASE),
-	.ctrl	= OMAP2_IO_ADDRESS(OMAP2420_CTRL_BASE),
-	.prm	= OMAP2_IO_ADDRESS(OMAP2420_PRM_BASE),
-	.cm	= OMAP2_IO_ADDRESS(OMAP2420_CM_BASE),
+	.tap	= OMAP2_L4_IO_ADDRESS(0x48014000),
+	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE),
+	.sms	= OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE),
+	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP2420_CTRL_BASE),
+	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE),
+	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE),
 };
 
 void __init omap2_set_globals_242x(void)
@@ -333,12 +333,12 @@ void __init omap2_set_globals_242x(void)
 
 static struct omap_globals omap243x_globals = {
 	.class	= OMAP243X_CLASS,
-	.tap	= OMAP2_IO_ADDRESS(0x4900a000),
-	.sdrc	= OMAP2_IO_ADDRESS(OMAP243X_SDRC_BASE),
-	.sms	= OMAP2_IO_ADDRESS(OMAP243X_SMS_BASE),
-	.ctrl	= OMAP2_IO_ADDRESS(OMAP243X_CTRL_BASE),
-	.prm	= OMAP2_IO_ADDRESS(OMAP2430_PRM_BASE),
-	.cm	= OMAP2_IO_ADDRESS(OMAP2430_CM_BASE),
+	.tap	= OMAP2_L4_IO_ADDRESS(0x4900a000),
+	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE),
+	.sms	= OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE),
+	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
+	.prm	= OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE),
+	.cm	= OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE),
 };
 
 void __init omap2_set_globals_243x(void)
@@ -351,12 +351,12 @@ void __init omap2_set_globals_243x(void)
 
 static struct omap_globals omap343x_globals = {
 	.class	= OMAP343X_CLASS,
-	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
-	.sdrc	= OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE),
-	.sms	= OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE),
-	.ctrl	= OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE),
-	.prm	= OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE),
-	.cm	= OMAP2_IO_ADDRESS(OMAP3430_CM_BASE),
+	.tap	= OMAP2_L4_IO_ADDRESS(0x4830A000),
+	.sdrc	= OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
+	.sms	= OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE),
+	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
+	.prm	= OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE),
+	.cm	= OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE),
 };
 
 void __init omap2_set_globals_343x(void)
@@ -368,10 +368,10 @@ void __init omap2_set_globals_343x(void)
 #if defined(CONFIG_ARCH_OMAP4)
 static struct omap_globals omap4_globals = {
 	.class	= OMAP443X_CLASS,
-	.tap	= OMAP2_IO_ADDRESS(0x4830a000),
-	.ctrl	= OMAP2_IO_ADDRESS(OMAP443X_CTRL_BASE),
-	.prm	= OMAP2_IO_ADDRESS(OMAP4430_PRM_BASE),
-	.cm	= OMAP2_IO_ADDRESS(OMAP4430_CM_BASE),
+	.tap	= OMAP2_L4_IO_ADDRESS(0x4830a000),
+	.ctrl	= OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE),
+	.prm	= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
+	.cm	= OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
 };
 
 void __init omap2_set_globals_443x(void)
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index bf08634..2e542a8 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2340,13 +2340,13 @@ static int __init omap_init_dma(void)
 		omap_dma_base = OMAP1_IO_ADDRESS(OMAP1_DMA_BASE);
 		dma_lch_count = OMAP1_LOGICAL_DMA_CH_COUNT;
 	} else if (cpu_is_omap24xx()) {
-		omap_dma_base = OMAP2_IO_ADDRESS(OMAP24XX_DMA4_BASE);
+		omap_dma_base = OMAP2_L4_IO_ADDRESS(OMAP24XX_DMA4_BASE);
 		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else if (cpu_is_omap34xx()) {
-		omap_dma_base = OMAP2_IO_ADDRESS(OMAP34XX_DMA4_BASE);
+		omap_dma_base = OMAP2_L4_IO_ADDRESS(OMAP34XX_DMA4_BASE);
 		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else if (cpu_is_omap44xx()) {
-		omap_dma_base = OMAP2_IO_ADDRESS(OMAP44XX_DMA4_BASE);
+		omap_dma_base = OMAP2_L4_IO_ADDRESS(OMAP44XX_DMA4_BASE);
 		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else {
 		pr_err("DMA init failed for unsupported omap\n");
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index d325b54..830b072 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -777,7 +777,7 @@ int __init omap_dm_timer_init(void)
 		if (cpu_class_is_omap1())
 			timer->io_base = OMAP1_IO_ADDRESS(timer->phys_base);
 		else
-			timer->io_base = OMAP2_IO_ADDRESS(timer->phys_base);
+			timer->io_base = OMAP2_L4_IO_ADDRESS(timer->phys_base);
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 					defined(CONFIG_ARCH_OMAP4)
 		if (cpu_class_is_omap2()) {
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index b55b4ad..6d099d0 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -104,16 +104,16 @@
 /*
  * omap24xx specific GPIO registers
  */
-#define OMAP242X_GPIO1_BASE		OMAP2_IO_ADDRESS(0x48018000)
-#define OMAP242X_GPIO2_BASE		OMAP2_IO_ADDRESS(0x4801a000)
-#define OMAP242X_GPIO3_BASE		OMAP2_IO_ADDRESS(0x4801c000)
-#define OMAP242X_GPIO4_BASE		OMAP2_IO_ADDRESS(0x4801e000)
+#define OMAP242X_GPIO1_BASE		OMAP2_L4_IO_ADDRESS(0x48018000)
+#define OMAP242X_GPIO2_BASE		OMAP2_L4_IO_ADDRESS(0x4801a000)
+#define OMAP242X_GPIO3_BASE		OMAP2_L4_IO_ADDRESS(0x4801c000)
+#define OMAP242X_GPIO4_BASE		OMAP2_L4_IO_ADDRESS(0x4801e000)
 
-#define OMAP243X_GPIO1_BASE		OMAP2_IO_ADDRESS(0x4900C000)
-#define OMAP243X_GPIO2_BASE		OMAP2_IO_ADDRESS(0x4900E000)
-#define OMAP243X_GPIO3_BASE		OMAP2_IO_ADDRESS(0x49010000)
-#define OMAP243X_GPIO4_BASE		OMAP2_IO_ADDRESS(0x49012000)
-#define OMAP243X_GPIO5_BASE		OMAP2_IO_ADDRESS(0x480B6000)
+#define OMAP243X_GPIO1_BASE		OMAP2_L4_IO_ADDRESS(0x4900C000)
+#define OMAP243X_GPIO2_BASE		OMAP2_L4_IO_ADDRESS(0x4900E000)
+#define OMAP243X_GPIO3_BASE		OMAP2_L4_IO_ADDRESS(0x49010000)
+#define OMAP243X_GPIO4_BASE		OMAP2_L4_IO_ADDRESS(0x49012000)
+#define OMAP243X_GPIO5_BASE		OMAP2_L4_IO_ADDRESS(0x480B6000)
 
 #define OMAP24XX_GPIO_REVISION		0x0000
 #define OMAP24XX_GPIO_SYSCONFIG		0x0010
@@ -144,22 +144,22 @@
  * omap34xx specific GPIO registers
  */
 
-#define OMAP34XX_GPIO1_BASE		OMAP2_IO_ADDRESS(0x48310000)
-#define OMAP34XX_GPIO2_BASE		OMAP2_IO_ADDRESS(0x49050000)
-#define OMAP34XX_GPIO3_BASE		OMAP2_IO_ADDRESS(0x49052000)
-#define OMAP34XX_GPIO4_BASE		OMAP2_IO_ADDRESS(0x49054000)
-#define OMAP34XX_GPIO5_BASE		OMAP2_IO_ADDRESS(0x49056000)
-#define OMAP34XX_GPIO6_BASE		OMAP2_IO_ADDRESS(0x49058000)
+#define OMAP34XX_GPIO1_BASE		OMAP2_L4_IO_ADDRESS(0x48310000)
+#define OMAP34XX_GPIO2_BASE		OMAP2_L4_IO_ADDRESS(0x49050000)
+#define OMAP34XX_GPIO3_BASE		OMAP2_L4_IO_ADDRESS(0x49052000)
+#define OMAP34XX_GPIO4_BASE		OMAP2_L4_IO_ADDRESS(0x49054000)
+#define OMAP34XX_GPIO5_BASE		OMAP2_L4_IO_ADDRESS(0x49056000)
+#define OMAP34XX_GPIO6_BASE		OMAP2_L4_IO_ADDRESS(0x49058000)
 
 /*
  * OMAP44XX  specific GPIO registers
  */
-#define OMAP44XX_GPIO1_BASE             OMAP2_IO_ADDRESS(0x4a310000)
-#define OMAP44XX_GPIO2_BASE             OMAP2_IO_ADDRESS(0x48055000)
-#define OMAP44XX_GPIO3_BASE             OMAP2_IO_ADDRESS(0x48057000)
-#define OMAP44XX_GPIO4_BASE             OMAP2_IO_ADDRESS(0x48059000)
-#define OMAP44XX_GPIO5_BASE             OMAP2_IO_ADDRESS(0x4805B000)
-#define OMAP44XX_GPIO6_BASE             OMAP2_IO_ADDRESS(0x4805D000)
+#define OMAP44XX_GPIO1_BASE             OMAP2_L4_IO_ADDRESS(0x4a310000)
+#define OMAP44XX_GPIO2_BASE             OMAP2_L4_IO_ADDRESS(0x48055000)
+#define OMAP44XX_GPIO3_BASE             OMAP2_L4_IO_ADDRESS(0x48057000)
+#define OMAP44XX_GPIO4_BASE             OMAP2_L4_IO_ADDRESS(0x48059000)
+#define OMAP44XX_GPIO5_BASE             OMAP2_L4_IO_ADDRESS(0x4805B000)
+#define OMAP44XX_GPIO6_BASE             OMAP2_L4_IO_ADDRESS(0x4805D000)
 
 struct gpio_bank {
 	void __iomem *base;
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 826d317..805819f 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -20,15 +20,18 @@
 
 #ifndef __ASSEMBLY__
 #define OMAP242X_CTRL_REGADDR(reg)					\
-	OMAP2_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
+		OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
 #define OMAP243X_CTRL_REGADDR(reg)					\
-	OMAP2_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
+		OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
 #define OMAP343X_CTRL_REGADDR(reg)					\
-	OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+		OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
 #else
-#define OMAP242X_CTRL_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
-#define OMAP243X_CTRL_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
-#define OMAP343X_CTRL_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+#define OMAP242X_CTRL_REGADDR(reg)					\
+		OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
+#define OMAP243X_CTRL_REGADDR(reg)					\
+		OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
+#define OMAP343X_CTRL_REGADDR(reg)					\
+		OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
 #endif /* __ASSEMBLY__ */
 
 /*
diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
index a559299..9b84cb8 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -68,9 +68,9 @@
 
 /* REVISIT: This should be set dynamically if CONFIG_MULTI_OMAP2 is selected */
 #if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430)
-#define OMAP2_VA_IC_BASE		OMAP2_IO_ADDRESS(OMAP24XX_IC_BASE)
+#define OMAP2_VA_IC_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
 #elif defined(CONFIG_ARCH_OMAP34XX)
-#define OMAP2_VA_IC_BASE		OMAP2_IO_ADDRESS(OMAP34XX_IC_BASE)
+#define OMAP2_VA_IC_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
 #endif
 #if defined(CONFIG_ARCH_OMAP4)
 #include <mach/omap44xx.h>
diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index 8d32df3..c475be7 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -63,9 +63,11 @@
 #define OMAP1_IO_OFFSET		0x01000000	/* Virtual IO = 0xfefb0000 */
 #define OMAP1_IO_ADDRESS(pa)	IOMEM((pa) - OMAP1_IO_OFFSET)
 
-#define OMAP2_IO_OFFSET		0x90000000
-#define OMAP2_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_IO_OFFSET) /* L3 and L4 */
+#define OMAP2_L3_IO_OFFSET	0x90000000
+#define OMAP2_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L3_IO_OFFSET) /* L3 */
 
+#define OMAP2_L4_IO_OFFSET	0x90000000
+#define OMAP2_L4_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L4_IO_OFFSET) /* L4 */
 /*
  * ----------------------------------------------------------------------------
  * Omap1 specific IO mapping
diff --git a/arch/arm/plat-omap/include/mach/omap44xx.h b/arch/arm/plat-omap/include/mach/omap44xx.h
index b3ba5ac..151d8bb 100644
--- a/arch/arm/plat-omap/include/mach/omap44xx.h
+++ b/arch/arm/plat-omap/include/mach/omap44xx.h
@@ -33,14 +33,17 @@
 #define IRQ_SIR_IRQ			0x0040
 #define OMAP44XX_GIC_DIST_BASE		0x48241000
 #define OMAP44XX_GIC_CPU_BASE		0x48240100
-#define OMAP44XX_VA_GIC_CPU_BASE	OMAP2_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
+#define OMAP44XX_VA_GIC_CPU_BASE					\
+				OMAP2_L4_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
 #define OMAP44XX_SCU_BASE		0x48240000
-#define OMAP44XX_VA_SCU_BASE		OMAP2_IO_ADDRESS(OMAP44XX_SCU_BASE)
+#define OMAP44XX_VA_SCU_BASE		OMAP2_L4_IO_ADDRESS(OMAP44XX_SCU_BASE)
 #define OMAP44XX_LOCAL_TWD_BASE		0x48240600
-#define OMAP44XX_VA_LOCAL_TWD_BASE	OMAP2_IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE)
+#define OMAP44XX_VA_LOCAL_TWD_BASE					\
+				OMAP2_L4_IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE)
 #define OMAP44XX_LOCAL_TWD_SIZE		0x00000100
 #define OMAP44XX_WKUPGEN_BASE		0x48281000
-#define OMAP44XX_VA_WKUPGEN_BASE	OMAP2_IO_ADDRESS(OMAP44XX_WKUPGEN_BASE)
+#define OMAP44XX_VA_WKUPGEN_BASE					\
+				OMAP2_L4_IO_ADDRESS(OMAP44XX_WKUPGEN_BASE)
 
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index 93f70d2..69e0a21 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -71,11 +71,11 @@
  */
 
 #define OMAP242X_SMS_REGADDR(reg)					\
-			(void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_SMS_BASE + reg)
+		(void __iomem *)OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE + reg)
 #define OMAP243X_SMS_REGADDR(reg)					\
-			(void __iomem *)OMAP2_IO_ADDRESS(OMAP243X_SMS_BASE + reg)
+		(void __iomem *)OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE + reg)
 #define OMAP343X_SMS_REGADDR(reg)					\
-			(void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE + reg)
+		(void __iomem *)OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE + reg)
 
 /* SMS register offsets - read/write with sms_{read,write}_reg() */
 
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index b6defa2..35adca8 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -142,7 +142,7 @@ u8 omap_readb(u32 pa)
 	if (cpu_class_is_omap1())
 		return __raw_readb(OMAP1_IO_ADDRESS(pa));
 	else
-		return __raw_readb(OMAP2_IO_ADDRESS(pa));
+		return __raw_readb(OMAP2_L4_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_readb);
 
@@ -151,7 +151,7 @@ u16 omap_readw(u32 pa)
 	if (cpu_class_is_omap1())
 		return __raw_readw(OMAP1_IO_ADDRESS(pa));
 	else
-		return __raw_readw(OMAP2_IO_ADDRESS(pa));
+		return __raw_readw(OMAP2_L4_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_readw);
 
@@ -160,7 +160,7 @@ u32 omap_readl(u32 pa)
 	if (cpu_class_is_omap1())
 		return __raw_readl(OMAP1_IO_ADDRESS(pa));
 	else
-		return __raw_readl(OMAP2_IO_ADDRESS(pa));
+		return __raw_readl(OMAP2_L4_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_readl);
 
@@ -169,7 +169,7 @@ void omap_writeb(u8 v, u32 pa)
 	if (cpu_class_is_omap1())
 		__raw_writeb(v, OMAP1_IO_ADDRESS(pa));
 	else
-		__raw_writeb(v, OMAP2_IO_ADDRESS(pa));
+		__raw_writeb(v, OMAP2_L4_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_writeb);
 
@@ -178,7 +178,7 @@ void omap_writew(u16 v, u32 pa)
 	if (cpu_class_is_omap1())
 		__raw_writew(v, OMAP1_IO_ADDRESS(pa));
 	else
-		__raw_writew(v, OMAP2_IO_ADDRESS(pa));
+		__raw_writew(v, OMAP2_L4_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_writew);
 
@@ -187,6 +187,6 @@ void omap_writel(u32 v, u32 pa)
 	if (cpu_class_is_omap1())
 		__raw_writel(v, OMAP1_IO_ADDRESS(pa));
 	else
-		__raw_writel(v, OMAP2_IO_ADDRESS(pa));
+		__raw_writel(v, OMAP2_L4_IO_ADDRESS(pa));
 }
 EXPORT_SYMBOL(omap_writel);
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 925f647..ea350a0 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -56,16 +56,16 @@
 #define SRAM_BOOTLOADER_SZ	0x80
 #endif
 
-#define OMAP24XX_VA_REQINFOPERM0	OMAP2_IO_ADDRESS(0x68005048)
-#define OMAP24XX_VA_READPERM0		OMAP2_IO_ADDRESS(0x68005050)
-#define OMAP24XX_VA_WRITEPERM0		OMAP2_IO_ADDRESS(0x68005058)
-
-#define OMAP34XX_VA_REQINFOPERM0	OMAP2_IO_ADDRESS(0x68012848)
-#define OMAP34XX_VA_READPERM0		OMAP2_IO_ADDRESS(0x68012850)
-#define OMAP34XX_VA_WRITEPERM0		OMAP2_IO_ADDRESS(0x68012858)
-#define OMAP34XX_VA_ADDR_MATCH2		OMAP2_IO_ADDRESS(0x68012880)
-#define OMAP34XX_VA_SMS_RG_ATT0		OMAP2_IO_ADDRESS(0x6C000048)
-#define OMAP34XX_VA_CONTROL_STAT	OMAP2_IO_ADDRESS(0x480022F0)
+#define OMAP24XX_VA_REQINFOPERM0	OMAP2_L3_IO_ADDRESS(0x68005048)
+#define OMAP24XX_VA_READPERM0		OMAP2_L3_IO_ADDRESS(0x68005050)
+#define OMAP24XX_VA_WRITEPERM0		OMAP2_L3_IO_ADDRESS(0x68005058)
+
+#define OMAP34XX_VA_REQINFOPERM0	OMAP2_L3_IO_ADDRESS(0x68012848)
+#define OMAP34XX_VA_READPERM0		OMAP2_L3_IO_ADDRESS(0x68012850)
+#define OMAP34XX_VA_WRITEPERM0		OMAP2_L3_IO_ADDRESS(0x68012858)
+#define OMAP34XX_VA_ADDR_MATCH2		OMAP2_L3_IO_ADDRESS(0x68012880)
+#define OMAP34XX_VA_SMS_RG_ATT0		OMAP2_L3_IO_ADDRESS(0x6C000048)
+#define OMAP34XX_VA_CONTROL_STAT	OMAP2_L4_IO_ADDRESS(0x480022F0)
 
 #define GP_DEVICE		0x300
 
diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 915439d..cbd3f8d 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -212,9 +212,9 @@ static void enable_rfbi_mode(int enable)
 	dispc_write_reg(DISPC_CONTROL, l);
 
 	/* Set bypass mode in RFBI module */
-	l = __raw_readl(OMAP2_IO_ADDRESS(RFBI_CONTROL));
+	l = __raw_readl(OMAP2_L4_IO_ADDRESS(RFBI_CONTROL));
 	l |= enable ? 0 : (1 << 1);
-	__raw_writel(l, OMAP2_IO_ADDRESS(RFBI_CONTROL));
+	__raw_writel(l, OMAP2_L4_IO_ADDRESS(RFBI_CONTROL));
 }
 
 static void set_lcd_data_lines(int data_lines)
@@ -1421,7 +1421,7 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 	}
 
 	/* L3 firewall setting: enable access to OCM RAM */
-	__raw_writel(0x402000b0, OMAP2_IO_ADDRESS(0x680050a0));
+	__raw_writel(0x402000b0, OMAP2_L3_IO_ADDRESS(0x680050a0));
 
 	if ((r = alloc_palette_ram()) < 0)
 		goto fail2;
-- 
1.5.4.7

