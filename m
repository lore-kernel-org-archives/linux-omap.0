From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] OMAP: Remove OMAP_IO_ADDRESS,
	use OMAP1_IO_ADDRESS and OMAP2_IO_ADDRESS instead
Date: Thu, 06 Aug 2009 13:10:20 +0300
Message-ID: <20090806101019.2569.75005.stgit@localhost>
References: <20090806100614.2569.8531.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59681 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbZHFKK3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 06:10:29 -0400
In-Reply-To: <20090806100614.2569.8531.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Search and replace OMAP_IO_ADDRESS with OMAP1_IO_ADDRESS and OMAP2_IO_ADDRESS,
and convert omap_read/write into a functions instead of a macros.

Also rename OMAP_MPUIO_VBASE to OMAP1_MPUIO_VBASE.

In the long run, most code should use ioremap + __raw_read/write instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/devices.c                 |    2 -
 arch/arm/mach-omap1/pm.h                      |    4 +
 arch/arm/mach-omap1/serial.c                  |    6 +-
 arch/arm/mach-omap1/sram.S                    |   12 ++-
 arch/arm/mach-omap1/time.c                    |    4 +
 arch/arm/mach-omap2/board-4430sdp.c           |    4 +
 arch/arm/mach-omap2/cm.h                      |    6 +-
 arch/arm/mach-omap2/omap-smp.c                |    2 -
 arch/arm/mach-omap2/pm-debug.c                |    2 -
 arch/arm/mach-omap2/prm.h                     |    6 +-
 arch/arm/mach-omap2/sdrc.h                    |    6 +-
 arch/arm/mach-omap2/serial.c                  |    6 +-
 arch/arm/mach-omap2/sram242x.S                |    4 +
 arch/arm/mach-omap2/sram243x.S                |    4 +
 arch/arm/mach-omap2/timer-gp.c                |    2 -
 arch/arm/plat-omap/dma.c                      |    8 +-
 arch/arm/plat-omap/dmtimer.c                  |    5 +
 arch/arm/plat-omap/gpio.c                     |   86 +++++++++++++------------
 arch/arm/plat-omap/include/mach/control.h     |   12 ++-
 arch/arm/plat-omap/include/mach/entry-macro.S |    8 +-
 arch/arm/plat-omap/include/mach/io.h          |   64 ++++++-------------
 arch/arm/plat-omap/include/mach/mtd-xip.h     |    2 -
 arch/arm/plat-omap/include/mach/omap44xx.h    |    8 +-
 arch/arm/plat-omap/include/mach/sdrc.h        |    6 +-
 arch/arm/plat-omap/io.c                       |   58 +++++++++++++++++
 arch/arm/plat-omap/sram.c                     |   20 +++---
 drivers/video/omap/dispc.c                    |    6 +-
 27 files changed, 196 insertions(+), 157 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index bbbaeb0..0680843 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -71,7 +71,7 @@ static inline void omap_init_rtc(void) {}
 #  define INT_DSP_MAILBOX1	INT_1610_DSP_MAILBOX1
 #endif
 
-#define OMAP1_MBOX_BASE		IO_ADDRESS(OMAP16XX_MAILBOX_BASE)
+#define OMAP1_MBOX_BASE		OMAP1_IO_ADDRESS(OMAP16XX_MAILBOX_BASE)
 
 static struct resource mbox_resources[] = {
 	{
diff --git a/arch/arm/mach-omap1/pm.h b/arch/arm/mach-omap1/pm.h
index 9ed5e2c..c4f05bd 100644
--- a/arch/arm/mach-omap1/pm.h
+++ b/arch/arm/mach-omap1/pm.h
@@ -39,11 +39,11 @@
  * Register and offset definitions to be used in PM assembler code
  * ----------------------------------------------------------------------------
  */
-#define CLKGEN_REG_ASM_BASE		IO_ADDRESS(0xfffece00)
+#define CLKGEN_REG_ASM_BASE		OMAP1_IO_ADDRESS(0xfffece00)
 #define ARM_IDLECT1_ASM_OFFSET		0x04
 #define ARM_IDLECT2_ASM_OFFSET		0x08
 
-#define TCMIF_ASM_BASE			IO_ADDRESS(0xfffecc00)
+#define TCMIF_ASM_BASE			OMAP1_IO_ADDRESS(0xfffecc00)
 #define EMIFS_CONFIG_ASM_OFFSET		0x0c
 #define EMIFF_SDRAM_CONFIG_ASM_OFFSET	0x20
 
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index f754cee..6f54b2c 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -64,7 +64,7 @@ static void __init omap_serial_reset(struct plat_serial8250_port *p)
 
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
-		.membase	= IO_ADDRESS(OMAP_UART1_BASE),
+		.membase	= OMAP1_IO_ADDRESS(OMAP_UART1_BASE),
 		.mapbase	= OMAP_UART1_BASE,
 		.irq		= INT_UART1,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -73,7 +73,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.uartclk	= OMAP16XX_BASE_BAUD * 16,
 	},
 	{
-		.membase	= IO_ADDRESS(OMAP_UART2_BASE),
+		.membase	= OMAP1_IO_ADDRESS(OMAP_UART2_BASE),
 		.mapbase	= OMAP_UART2_BASE,
 		.irq		= INT_UART2,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -82,7 +82,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.uartclk	= OMAP16XX_BASE_BAUD * 16,
 	},
 	{
-		.membase	= IO_ADDRESS(OMAP_UART3_BASE),
+		.membase	= OMAP1_IO_ADDRESS(OMAP_UART3_BASE),
 		.mapbase	= OMAP_UART3_BASE,
 		.irq		= INT_UART3,
 		.flags		= UPF_BOOT_AUTOCONF,
diff --git a/arch/arm/mach-omap1/sram.S b/arch/arm/mach-omap1/sram.S
index 261cdc4..7724e52 100644
--- a/arch/arm/mach-omap1/sram.S
+++ b/arch/arm/mach-omap1/sram.S
@@ -21,13 +21,13 @@
 ENTRY(omap1_sram_reprogram_clock)
 	stmfd	sp!, {r0 - r12, lr}		@ save registers on stack
 
-	mov	r2, #IO_ADDRESS(DPLL_CTL) & 0xff000000
-	orr	r2, r2, #IO_ADDRESS(DPLL_CTL) & 0x00ff0000
-	orr	r2, r2, #IO_ADDRESS(DPLL_CTL) & 0x0000ff00
+	mov	r2, #OMAP1_IO_ADDRESS(DPLL_CTL) & 0xff000000
+	orr	r2, r2, #OMAP1_IO_ADDRESS(DPLL_CTL) & 0x00ff0000
+	orr	r2, r2, #OMAP1_IO_ADDRESS(DPLL_CTL) & 0x0000ff00
 
-	mov	r3, #IO_ADDRESS(ARM_CKCTL) & 0xff000000
-	orr	r3, r3, #IO_ADDRESS(ARM_CKCTL) & 0x00ff0000
-	orr	r3, r3, #IO_ADDRESS(ARM_CKCTL) & 0x0000ff00
+	mov	r3, #OMAP1_IO_ADDRESS(ARM_CKCTL) & 0xff000000
+	orr	r3, r3, #OMAP1_IO_ADDRESS(ARM_CKCTL) & 0x00ff0000
+	orr	r3, r3, #OMAP1_IO_ADDRESS(ARM_CKCTL) & 0x0000ff00
 
 	tst	r0, #1 << 4			@ want lock mode?
 	beq	newck				@ nope
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 4d56408..1be6a21 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -62,8 +62,8 @@ typedef struct {
 	u32 read_tim;			/* READ_TIM,   R */
 } omap_mpu_timer_regs_t;
 
-#define omap_mpu_timer_base(n)						\
-((volatile omap_mpu_timer_regs_t*)IO_ADDRESS(OMAP_MPU_TIMER_BASE +	\
+#define omap_mpu_timer_base(n)							\
+((volatile omap_mpu_timer_regs_t*)OMAP1_IO_ADDRESS(OMAP_MPU_TIMER_BASE +	\
 				 (n)*OMAP_MPU_TIMER_OFFSET))
 
 static inline unsigned long omap_mpu_timer_read(int nr)
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 57e477b..543c0a4 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -53,8 +53,8 @@ static struct omap_board_config_kernel sdp4430_config[] __initdata = {
 
 static void __init gic_init_irq(void)
 {
-	gic_dist_init(0, IO_ADDRESS(OMAP44XX_GIC_DIST_BASE), 29);
-	gic_cpu_init(0, IO_ADDRESS(OMAP44XX_GIC_CPU_BASE));
+	gic_dist_init(0, OMAP2_IO_ADDRESS(OMAP44XX_GIC_DIST_BASE), 29);
+	gic_cpu_init(0, OMAP2_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE));
 }
 
 static void __init omap_4430sdp_init_irq(void)
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 1d3c93b..e10f1c8 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -17,11 +17,11 @@
 #include "prcm-common.h"
 
 #define OMAP2420_CM_REGADDR(module, reg)				\
-			IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
+			OMAP2_IO_ADDRESS(OMAP2420_CM_BASE + (module) + (reg))
 #define OMAP2430_CM_REGADDR(module, reg)				\
-			IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
+			OMAP2_IO_ADDRESS(OMAP2430_CM_BASE + (module) + (reg))
 #define OMAP34XX_CM_REGADDR(module, reg)				\
-			IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
+			OMAP2_IO_ADDRESS(OMAP3430_CM_BASE + (module) + (reg))
 
 /*
  * Architecture-specific global CM registers
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 8fe8d23..48ee295 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -54,7 +54,7 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 * for us: do so
 	 */
 
-	gic_cpu_init(0, IO_ADDRESS(OMAP44XX_GIC_CPU_BASE));
+	gic_cpu_init(0, OMAP2_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE));
 
 	/*
 	 * Synchronise with the boot thread.
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 6cc375a..da3a53f 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -48,7 +48,7 @@ int omap2_pm_debug;
 	regs[reg_count++].val = __raw_readl(reg)
 #define DUMP_INTC_REG(reg, off) \
 	regs[reg_count].name = #reg; \
-	regs[reg_count++].val = __raw_readl(IO_ADDRESS(0x480fe000 + (off)))
+	regs[reg_count++].val = __raw_readl(OMAP2_IO_ADDRESS(0x480fe000 + (off)))
 
 void omap2_pm_dump(int mode, int resume, unsigned int us)
 {
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 9937e28..03c467c 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -17,11 +17,11 @@
 #include "prcm-common.h"
 
 #define OMAP2420_PRM_REGADDR(module, reg)				\
-			IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
+			OMAP2_IO_ADDRESS(OMAP2420_PRM_BASE + (module) + (reg))
 #define OMAP2430_PRM_REGADDR(module, reg)				\
-			IO_ADDRESS(OMAP2430_PRM_BASE + (module) + (reg))
+			OMAP2_IO_ADDRESS(OMAP2430_PRM_BASE + (module) + (reg))
 #define OMAP34XX_PRM_REGADDR(module, reg)				\
-			IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
+			OMAP2_IO_ADDRESS(OMAP3430_PRM_BASE + (module) + (reg))
 
 /*
  * Architecture-specific global PRM registers
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index 1a8bbd0..0837eda 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -48,9 +48,9 @@ static inline u32 sms_read_reg(u16 reg)
 	return __raw_readl(OMAP_SMS_REGADDR(reg));
 }
 #else
-#define OMAP242X_SDRC_REGADDR(reg)	IO_ADDRESS(OMAP2420_SDRC_BASE + (reg))
-#define OMAP243X_SDRC_REGADDR(reg)	IO_ADDRESS(OMAP243X_SDRC_BASE + (reg))
-#define OMAP34XX_SDRC_REGADDR(reg)	IO_ADDRESS(OMAP343X_SDRC_BASE + (reg))
+#define OMAP242X_SDRC_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP2420_SDRC_BASE + (reg))
+#define OMAP243X_SDRC_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP243X_SDRC_BASE + (reg))
+#define OMAP34XX_SDRC_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP343X_SDRC_BASE + (reg))
 #endif	/* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b094c15..07fb275 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -73,7 +73,7 @@ static LIST_HEAD(uart_list);
 
 static struct plat_serial8250_port serial_platform_data[] = {
 	{
-		.membase	= IO_ADDRESS(OMAP_UART1_BASE),
+		.membase	= OMAP2_IO_ADDRESS(OMAP_UART1_BASE),
 		.mapbase	= OMAP_UART1_BASE,
 		.irq		= 72,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -81,7 +81,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.regshift	= 2,
 		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
-		.membase	= IO_ADDRESS(OMAP_UART2_BASE),
+		.membase	= OMAP2_IO_ADDRESS(OMAP_UART2_BASE),
 		.mapbase	= OMAP_UART2_BASE,
 		.irq		= 73,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -89,7 +89,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 		.regshift	= 2,
 		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
-		.membase	= IO_ADDRESS(OMAP_UART3_BASE),
+		.membase	= OMAP2_IO_ADDRESS(OMAP_UART3_BASE),
 		.mapbase	= OMAP_UART3_BASE,
 		.irq		= 74,
 		.flags		= UPF_BOOT_AUTOCONF,
diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
index bb29985..9b62208 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -128,7 +128,7 @@ omap242x_sdi_prcm_voltctrl:
 prcm_mask_val:
 	.word 0xFFFF3FFC
 omap242x_sdi_timer_32ksynct_cr:
-	.word IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
+	.word OMAP2_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
 ENTRY(omap242x_sram_ddr_init_sz)
 	.word	. - omap242x_sram_ddr_init
 
@@ -224,7 +224,7 @@ omap242x_srs_prcm_voltctrl:
 ddr_prcm_mask_val:
 	.word 0xFFFF3FFC
 omap242x_srs_timer_32ksynct:
-	.word IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
+	.word OMAP2_IO_ADDRESS(OMAP2420_32KSYNCT_BASE + 0x010)
 
 ENTRY(omap242x_sram_reprogram_sdrc_sz)
 	.word	. - omap242x_sram_reprogram_sdrc
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
index 9955abc..df2cd92 100644
--- a/arch/arm/mach-omap2/sram243x.S
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -128,7 +128,7 @@ omap243x_sdi_prcm_voltctrl:
 prcm_mask_val:
 	.word 0xFFFF3FFC
 omap243x_sdi_timer_32ksynct_cr:
-	.word IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
+	.word OMAP2_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
 ENTRY(omap243x_sram_ddr_init_sz)
 	.word	. - omap243x_sram_ddr_init
 
@@ -224,7 +224,7 @@ omap243x_srs_prcm_voltctrl:
 ddr_prcm_mask_val:
 	.word 0xFFFF3FFC
 omap243x_srs_timer_32ksynct:
-	.word IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
+	.word OMAP2_IO_ADDRESS(OMAP2430_32KSYNCT_BASE + 0x010)
 
 ENTRY(omap243x_sram_reprogram_sdrc_sz)
 	.word	. - omap243x_sram_reprogram_sdrc
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 97eeeeb..e2338c0 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -231,7 +231,7 @@ static void __init omap2_gp_clocksource_init(void)
 static void __init omap2_gp_timer_init(void)
 {
 #ifdef CONFIG_LOCAL_TIMERS
-	twd_base = IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE);
+	twd_base = OMAP2_IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE);
 #endif
 	omap_dm_timer_init();
 
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index e3ac94f..bf08634 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2337,16 +2337,16 @@ static int __init omap_init_dma(void)
 	int ch, r;
 
 	if (cpu_class_is_omap1()) {
-		omap_dma_base = IO_ADDRESS(OMAP1_DMA_BASE);
+		omap_dma_base = OMAP1_IO_ADDRESS(OMAP1_DMA_BASE);
 		dma_lch_count = OMAP1_LOGICAL_DMA_CH_COUNT;
 	} else if (cpu_is_omap24xx()) {
-		omap_dma_base = IO_ADDRESS(OMAP24XX_DMA4_BASE);
+		omap_dma_base = OMAP2_IO_ADDRESS(OMAP24XX_DMA4_BASE);
 		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else if (cpu_is_omap34xx()) {
-		omap_dma_base = IO_ADDRESS(OMAP34XX_DMA4_BASE);
+		omap_dma_base = OMAP2_IO_ADDRESS(OMAP34XX_DMA4_BASE);
 		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else if (cpu_is_omap44xx()) {
-		omap_dma_base = IO_ADDRESS(OMAP44XX_DMA4_BASE);
+		omap_dma_base = OMAP2_IO_ADDRESS(OMAP44XX_DMA4_BASE);
 		dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT;
 	} else {
 		pr_err("DMA init failed for unsupported omap\n");
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 7f50b61..d325b54 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -774,7 +774,10 @@ int __init omap_dm_timer_init(void)
 
 	for (i = 0; i < dm_timer_count; i++) {
 		timer = &dm_timers[i];
-		timer->io_base = IO_ADDRESS(timer->phys_base);
+		if (cpu_class_is_omap1())
+			timer->io_base = OMAP1_IO_ADDRESS(timer->phys_base);
+		else
+			timer->io_base = OMAP2_IO_ADDRESS(timer->phys_base);
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 					defined(CONFIG_ARCH_OMAP4)
 		if (cpu_class_is_omap2()) {
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index e702b88..59010e5 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -31,7 +31,7 @@
 /*
  * OMAP1510 GPIO registers
  */
-#define OMAP1510_GPIO_BASE		IO_ADDRESS(0xfffce000)
+#define OMAP1510_GPIO_BASE		OMAP1_IO_ADDRESS(0xfffce000)
 #define OMAP1510_GPIO_DATA_INPUT	0x00
 #define OMAP1510_GPIO_DATA_OUTPUT	0x04
 #define OMAP1510_GPIO_DIR_CONTROL	0x08
@@ -45,10 +45,10 @@
 /*
  * OMAP1610 specific GPIO registers
  */
-#define OMAP1610_GPIO1_BASE		IO_ADDRESS(0xfffbe400)
-#define OMAP1610_GPIO2_BASE		IO_ADDRESS(0xfffbec00)
-#define OMAP1610_GPIO3_BASE		IO_ADDRESS(0xfffbb400)
-#define OMAP1610_GPIO4_BASE		IO_ADDRESS(0xfffbbc00)
+#define OMAP1610_GPIO1_BASE		OMAP1_IO_ADDRESS(0xfffbe400)
+#define OMAP1610_GPIO2_BASE		OMAP1_IO_ADDRESS(0xfffbec00)
+#define OMAP1610_GPIO3_BASE		OMAP1_IO_ADDRESS(0xfffbb400)
+#define OMAP1610_GPIO4_BASE		OMAP1_IO_ADDRESS(0xfffbbc00)
 #define OMAP1610_GPIO_REVISION		0x0000
 #define OMAP1610_GPIO_SYSCONFIG		0x0010
 #define OMAP1610_GPIO_SYSSTATUS		0x0014
@@ -70,12 +70,12 @@
 /*
  * OMAP730 specific GPIO registers
  */
-#define OMAP730_GPIO1_BASE		IO_ADDRESS(0xfffbc000)
-#define OMAP730_GPIO2_BASE		IO_ADDRESS(0xfffbc800)
-#define OMAP730_GPIO3_BASE		IO_ADDRESS(0xfffbd000)
-#define OMAP730_GPIO4_BASE		IO_ADDRESS(0xfffbd800)
-#define OMAP730_GPIO5_BASE		IO_ADDRESS(0xfffbe000)
-#define OMAP730_GPIO6_BASE		IO_ADDRESS(0xfffbe800)
+#define OMAP730_GPIO1_BASE		OMAP1_IO_ADDRESS(0xfffbc000)
+#define OMAP730_GPIO2_BASE		OMAP1_IO_ADDRESS(0xfffbc800)
+#define OMAP730_GPIO3_BASE		OMAP1_IO_ADDRESS(0xfffbd000)
+#define OMAP730_GPIO4_BASE		OMAP1_IO_ADDRESS(0xfffbd800)
+#define OMAP730_GPIO5_BASE		OMAP1_IO_ADDRESS(0xfffbe000)
+#define OMAP730_GPIO6_BASE		OMAP1_IO_ADDRESS(0xfffbe800)
 #define OMAP730_GPIO_DATA_INPUT		0x00
 #define OMAP730_GPIO_DATA_OUTPUT	0x04
 #define OMAP730_GPIO_DIR_CONTROL	0x08
@@ -86,12 +86,12 @@
 /*
  * OMAP850 specific GPIO registers
  */
-#define OMAP850_GPIO1_BASE		IO_ADDRESS(0xfffbc000)
-#define OMAP850_GPIO2_BASE		IO_ADDRESS(0xfffbc800)
-#define OMAP850_GPIO3_BASE		IO_ADDRESS(0xfffbd000)
-#define OMAP850_GPIO4_BASE		IO_ADDRESS(0xfffbd800)
-#define OMAP850_GPIO5_BASE		IO_ADDRESS(0xfffbe000)
-#define OMAP850_GPIO6_BASE		IO_ADDRESS(0xfffbe800)
+#define OMAP850_GPIO1_BASE		OMAP1_IO_ADDRESS(0xfffbc000)
+#define OMAP850_GPIO2_BASE		OMAP1_IO_ADDRESS(0xfffbc800)
+#define OMAP850_GPIO3_BASE		OMAP1_IO_ADDRESS(0xfffbd000)
+#define OMAP850_GPIO4_BASE		OMAP1_IO_ADDRESS(0xfffbd800)
+#define OMAP850_GPIO5_BASE		OMAP1_IO_ADDRESS(0xfffbe000)
+#define OMAP850_GPIO6_BASE		OMAP1_IO_ADDRESS(0xfffbe800)
 #define OMAP850_GPIO_DATA_INPUT		0x00
 #define OMAP850_GPIO_DATA_OUTPUT	0x04
 #define OMAP850_GPIO_DIR_CONTROL	0x08
@@ -99,19 +99,21 @@
 #define OMAP850_GPIO_INT_MASK		0x10
 #define OMAP850_GPIO_INT_STATUS		0x14
 
+#define OMAP1_MPUIO_VBASE		OMAP1_IO_ADDRESS(OMAP_MPUIO_BASE)
+
 /*
  * omap24xx specific GPIO registers
  */
-#define OMAP242X_GPIO1_BASE		IO_ADDRESS(0x48018000)
-#define OMAP242X_GPIO2_BASE		IO_ADDRESS(0x4801a000)
-#define OMAP242X_GPIO3_BASE		IO_ADDRESS(0x4801c000)
-#define OMAP242X_GPIO4_BASE		IO_ADDRESS(0x4801e000)
+#define OMAP242X_GPIO1_BASE		OMAP2_IO_ADDRESS(0x48018000)
+#define OMAP242X_GPIO2_BASE		OMAP2_IO_ADDRESS(0x4801a000)
+#define OMAP242X_GPIO3_BASE		OMAP2_IO_ADDRESS(0x4801c000)
+#define OMAP242X_GPIO4_BASE		OMAP2_IO_ADDRESS(0x4801e000)
 
-#define OMAP243X_GPIO1_BASE		IO_ADDRESS(0x4900C000)
-#define OMAP243X_GPIO2_BASE		IO_ADDRESS(0x4900E000)
-#define OMAP243X_GPIO3_BASE		IO_ADDRESS(0x49010000)
-#define OMAP243X_GPIO4_BASE		IO_ADDRESS(0x49012000)
-#define OMAP243X_GPIO5_BASE		IO_ADDRESS(0x480B6000)
+#define OMAP243X_GPIO1_BASE		OMAP2_IO_ADDRESS(0x4900C000)
+#define OMAP243X_GPIO2_BASE		OMAP2_IO_ADDRESS(0x4900E000)
+#define OMAP243X_GPIO3_BASE		OMAP2_IO_ADDRESS(0x49010000)
+#define OMAP243X_GPIO4_BASE		OMAP2_IO_ADDRESS(0x49012000)
+#define OMAP243X_GPIO5_BASE		OMAP2_IO_ADDRESS(0x480B6000)
 
 #define OMAP24XX_GPIO_REVISION		0x0000
 #define OMAP24XX_GPIO_SYSCONFIG		0x0010
@@ -142,24 +144,22 @@
  * omap34xx specific GPIO registers
  */
 
-#define OMAP34XX_GPIO1_BASE		IO_ADDRESS(0x48310000)
-#define OMAP34XX_GPIO2_BASE		IO_ADDRESS(0x49050000)
-#define OMAP34XX_GPIO3_BASE		IO_ADDRESS(0x49052000)
-#define OMAP34XX_GPIO4_BASE		IO_ADDRESS(0x49054000)
-#define OMAP34XX_GPIO5_BASE		IO_ADDRESS(0x49056000)
-#define OMAP34XX_GPIO6_BASE		IO_ADDRESS(0x49058000)
+#define OMAP34XX_GPIO1_BASE		OMAP2_IO_ADDRESS(0x48310000)
+#define OMAP34XX_GPIO2_BASE		OMAP2_IO_ADDRESS(0x49050000)
+#define OMAP34XX_GPIO3_BASE		OMAP2_IO_ADDRESS(0x49052000)
+#define OMAP34XX_GPIO4_BASE		OMAP2_IO_ADDRESS(0x49054000)
+#define OMAP34XX_GPIO5_BASE		OMAP2_IO_ADDRESS(0x49056000)
+#define OMAP34XX_GPIO6_BASE		OMAP2_IO_ADDRESS(0x49058000)
 
 /*
  * OMAP44XX  specific GPIO registers
  */
-#define OMAP44XX_GPIO1_BASE             IO_ADDRESS(0x4a310000)
-#define OMAP44XX_GPIO2_BASE             IO_ADDRESS(0x48055000)
-#define OMAP44XX_GPIO3_BASE             IO_ADDRESS(0x48057000)
-#define OMAP44XX_GPIO4_BASE             IO_ADDRESS(0x48059000)
-#define OMAP44XX_GPIO5_BASE             IO_ADDRESS(0x4805B000)
-#define OMAP44XX_GPIO6_BASE             IO_ADDRESS(0x4805D000)
-
-#define OMAP_MPUIO_VBASE		IO_ADDRESS(OMAP_MPUIO_BASE)
+#define OMAP44XX_GPIO1_BASE             OMAP2_IO_ADDRESS(0x4a310000)
+#define OMAP44XX_GPIO2_BASE             OMAP2_IO_ADDRESS(0x48055000)
+#define OMAP44XX_GPIO3_BASE             OMAP2_IO_ADDRESS(0x48057000)
+#define OMAP44XX_GPIO4_BASE             OMAP2_IO_ADDRESS(0x48059000)
+#define OMAP44XX_GPIO5_BASE             OMAP2_IO_ADDRESS(0x4805B000)
+#define OMAP44XX_GPIO6_BASE             OMAP2_IO_ADDRESS(0x4805D000)
 
 struct gpio_bank {
 	void __iomem *base;
@@ -195,7 +195,7 @@ struct gpio_bank {
 
 #ifdef CONFIG_ARCH_OMAP16XX
 static struct gpio_bank gpio_bank_1610[5] = {
-	{ OMAP_MPUIO_VBASE,    INT_MPUIO,	    IH_MPUIO_BASE,     METHOD_MPUIO},
+	{ OMAP1_MPUIO_VBASE,    INT_MPUIO,	    IH_MPUIO_BASE,     METHOD_MPUIO},
 	{ OMAP1610_GPIO1_BASE, INT_GPIO_BANK1,	    IH_GPIO_BASE,      METHOD_GPIO_1610 },
 	{ OMAP1610_GPIO2_BASE, INT_1610_GPIO_BANK2, IH_GPIO_BASE + 16, METHOD_GPIO_1610 },
 	{ OMAP1610_GPIO3_BASE, INT_1610_GPIO_BANK3, IH_GPIO_BASE + 32, METHOD_GPIO_1610 },
@@ -205,14 +205,14 @@ static struct gpio_bank gpio_bank_1610[5] = {
 
 #ifdef CONFIG_ARCH_OMAP15XX
 static struct gpio_bank gpio_bank_1510[2] = {
-	{ OMAP_MPUIO_VBASE,   INT_MPUIO,      IH_MPUIO_BASE, METHOD_MPUIO },
+	{ OMAP1_MPUIO_VBASE,   INT_MPUIO,      IH_MPUIO_BASE, METHOD_MPUIO },
 	{ OMAP1510_GPIO_BASE, INT_GPIO_BANK1, IH_GPIO_BASE,  METHOD_GPIO_1510 }
 };
 #endif
 
 #ifdef CONFIG_ARCH_OMAP730
 static struct gpio_bank gpio_bank_730[7] = {
-	{ OMAP_MPUIO_VBASE,    INT_730_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
+	{ OMAP1_MPUIO_VBASE,    INT_730_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
 	{ OMAP730_GPIO1_BASE,  INT_730_GPIO_BANK1,  IH_GPIO_BASE,	METHOD_GPIO_730 },
 	{ OMAP730_GPIO2_BASE,  INT_730_GPIO_BANK2,  IH_GPIO_BASE + 32,	METHOD_GPIO_730 },
 	{ OMAP730_GPIO3_BASE,  INT_730_GPIO_BANK3,  IH_GPIO_BASE + 64,	METHOD_GPIO_730 },
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 8140dbc..826d317 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -20,15 +20,15 @@
 
 #ifndef __ASSEMBLY__
 #define OMAP242X_CTRL_REGADDR(reg)					\
-	IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
+	OMAP2_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
 #define OMAP243X_CTRL_REGADDR(reg)					\
-	IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
+	OMAP2_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
 #define OMAP343X_CTRL_REGADDR(reg)					\
-	IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+	OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
 #else
-#define OMAP242X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
-#define OMAP243X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
-#define OMAP343X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+#define OMAP242X_CTRL_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
+#define OMAP243X_CTRL_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
+#define OMAP343X_CTRL_REGADDR(reg)	OMAP2_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
 #endif /* __ASSEMBLY__ */
 
 /*
diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
index 56426ed..a559299 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -41,7 +41,7 @@
 		.endm
 
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\base, =IO_ADDRESS(OMAP_IH1_BASE)
+		ldr	\base, =OMAP1_IO_ADDRESS(OMAP_IH1_BASE)
 		ldr	\irqnr, [\base, #IRQ_ITR_REG_OFFSET]
 		ldr	\tmp, [\base, #IRQ_MIR_REG_OFFSET]
 		mov	\irqstat, #0xffffffff
@@ -53,7 +53,7 @@
 		cmp	\irqnr, #0
 		ldreq	\irqnr, [\base, #IRQ_SIR_IRQ_REG_OFFSET]
 		cmpeq	\irqnr, #INT_IH2_IRQ
-		ldreq	\base, =IO_ADDRESS(OMAP_IH2_BASE)
+		ldreq	\base, =OMAP1_IO_ADDRESS(OMAP_IH2_BASE)
 		ldreq	\irqnr, [\base, #IRQ_SIR_IRQ_REG_OFFSET]
 		addeqs	\irqnr, \irqnr, #32
 1510:
@@ -68,9 +68,9 @@
 
 /* REVISIT: This should be set dynamically if CONFIG_MULTI_OMAP2 is selected */
 #if defined(CONFIG_ARCH_OMAP2420) || defined(CONFIG_ARCH_OMAP2430)
-#define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP24XX_IC_BASE)
+#define OMAP2_VA_IC_BASE		OMAP2_IO_ADDRESS(OMAP24XX_IC_BASE)
 #elif defined(CONFIG_ARCH_OMAP34XX)
-#define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
+#define OMAP2_VA_IC_BASE		OMAP2_IO_ADDRESS(OMAP34XX_IC_BASE)
 #endif
 #if defined(CONFIG_ARCH_OMAP4)
 #include <mach/omap44xx.h>
diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index 73f483d..8541388 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -54,15 +54,23 @@
  * ----------------------------------------------------------------------------
  */
 
+#ifdef __ASSEMBLER__
+#define IOMEM(x)		(x)
+#else
+#define IOMEM(x)		((void __force __iomem *)(x))
+#endif
+
+#define OMAP1_IO_OFFSET		0x01000000	/* Virtual IO = 0xfefb0000 */
+#define OMAP1_IO_ADDRESS(pa)	IOMEM((pa) - OMAP1_IO_OFFSET)
+
+#define OMAP2_IO_OFFSET		0x90000000
+#define OMAP2_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_IO_OFFSET) /* L3 and L4 */
+
 #if defined(CONFIG_ARCH_OMAP1)
 
 #define IO_PHYS			0xFFFB0000
-#define IO_OFFSET		0x01000000	/* Virtual IO = 0xfefb0000 */
 #define IO_SIZE			0x40000
-#define IO_VIRT			(IO_PHYS - IO_OFFSET)
-#define __IO_ADDRESS(pa)	((pa) - IO_OFFSET)
-#define __OMAP1_IO_ADDRESS(pa)	((pa) - IO_OFFSET)
-#define io_v2p(va)		((va) + IO_OFFSET)
+#define IO_VIRT			(IO_PHYS - OMAP1_IO_OFFSET)
 
 #elif defined(CONFIG_ARCH_OMAP2)
 
@@ -87,11 +95,6 @@
 #define OMAP243X_SMS_VIRT	0xFC000000
 #define OMAP243X_SMS_SIZE	SZ_1M
 
-#define IO_OFFSET		0x90000000
-#define __IO_ADDRESS(pa)	((pa) + IO_OFFSET)	/* Works for L3 and L4 */
-#define __OMAP2_IO_ADDRESS(pa)	((pa) + IO_OFFSET)	/* Works for L3 and L4 */
-#define io_v2p(va)		((va) - IO_OFFSET)	/* Works for L3 and L4 */
-
 /* DSP */
 #define DSP_MEM_24XX_PHYS	OMAP2420_DSP_MEM_BASE	/* 0x58000000 */
 #define DSP_MEM_24XX_VIRT	0xe0000000
@@ -143,12 +146,6 @@
 #define OMAP343X_SDRC_VIRT	0xFD000000
 #define OMAP343X_SDRC_SIZE	SZ_1M
 
-
-#define IO_OFFSET		0x90000000
-#define __IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L3 and L4 */
-#define __OMAP2_IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L3 and L4 */
-#define io_v2p(va)		((va) - IO_OFFSET)/* Works for L3 and L4 */
-
 /* DSP */
 #define DSP_MEM_34XX_PHYS	OMAP34XX_DSP_MEM_BASE	/* 0x58000000 */
 #define DSP_MEM_34XX_VIRT	0xe0000000
@@ -188,39 +185,20 @@
 #define OMAP44XX_GPMC_VIRT	0xe0000000
 #define OMAP44XX_GPMC_SIZE	SZ_1M
 
-
-#define IO_OFFSET		0x90000000
-#define __IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L3 and L4 */
-#define __OMAP2_IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L3 and L4 */
-#define io_v2p(va)		((va) - IO_OFFSET)/* Works for L3 and L4 */
-
 #endif
 
-#define IO_ADDRESS(pa)		IOMEM(__IO_ADDRESS(pa))
-#define OMAP1_IO_ADDRESS(pa)	IOMEM(__OMAP1_IO_ADDRESS(pa))
-#define OMAP2_IO_ADDRESS(pa)	IOMEM(__OMAP2_IO_ADDRESS(pa))
-
-#ifdef __ASSEMBLER__
-#define IOMEM(x)		(x)
-#else
-#define IOMEM(x)		((void __force __iomem *)(x))
+#ifndef __ASSEMBLER__
 
 /*
- * Functions to access the OMAP IO region
- *
- * NOTE: - Use omap_read/write[bwl] for physical register addresses
- *	 - Use __raw_read/write[bwl]() for virtual register addresses
- *	 - Use IO_ADDRESS(phys_addr) to convert registers to virtual addresses
- *	 - DO NOT use hardcoded virtual addresses to allow changing the
- *	   IO address space again if needed
+ * NOTE: Please use ioremap + __raw_read/write where possible instead of these
  */
-#define omap_readb(a)		__raw_readb(IO_ADDRESS(a))
-#define omap_readw(a)		__raw_readw(IO_ADDRESS(a))
-#define omap_readl(a)		__raw_readl(IO_ADDRESS(a))
 
-#define omap_writeb(v,a)	__raw_writeb(v, IO_ADDRESS(a))
-#define omap_writew(v,a)	__raw_writew(v, IO_ADDRESS(a))
-#define omap_writel(v,a)	__raw_writel(v, IO_ADDRESS(a))
+extern u8 omap_readb(u32 pa);
+extern u16 omap_readw(u32 pa);
+extern u32 omap_readl(u32 pa);
+extern void omap_writeb(u8 v, u32 pa);
+extern void omap_writew(u16 v, u32 pa);
+extern void omap_writel(u32 v, u32 pa);
 
 struct omap_sdrc_params;
 
diff --git a/arch/arm/plat-omap/include/mach/mtd-xip.h b/arch/arm/plat-omap/include/mach/mtd-xip.h
index 39b591f..f82a8dc 100644
--- a/arch/arm/plat-omap/include/mach/mtd-xip.h
+++ b/arch/arm/plat-omap/include/mach/mtd-xip.h
@@ -25,7 +25,7 @@ typedef struct {
 } xip_omap_mpu_timer_regs_t;
 
 #define xip_omap_mpu_timer_base(n)					\
-((volatile xip_omap_mpu_timer_regs_t*)IO_ADDRESS(OMAP_MPU_TIMER_BASE +	\
+((volatile xip_omap_mpu_timer_regs_t*)OMAP1_IO_ADDRESS(OMAP_MPU_TIMER_BASE +	\
 	(n)*OMAP_MPU_TIMER_OFFSET))
 
 static inline unsigned long xip_omap_mpu_timer_read(int nr)
diff --git a/arch/arm/plat-omap/include/mach/omap44xx.h b/arch/arm/plat-omap/include/mach/omap44xx.h
index 15dec7f..b3ba5ac 100644
--- a/arch/arm/plat-omap/include/mach/omap44xx.h
+++ b/arch/arm/plat-omap/include/mach/omap44xx.h
@@ -33,14 +33,14 @@
 #define IRQ_SIR_IRQ			0x0040
 #define OMAP44XX_GIC_DIST_BASE		0x48241000
 #define OMAP44XX_GIC_CPU_BASE		0x48240100
-#define OMAP44XX_VA_GIC_CPU_BASE	IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
+#define OMAP44XX_VA_GIC_CPU_BASE	OMAP2_IO_ADDRESS(OMAP44XX_GIC_CPU_BASE)
 #define OMAP44XX_SCU_BASE		0x48240000
-#define OMAP44XX_VA_SCU_BASE		IO_ADDRESS(OMAP44XX_SCU_BASE)
+#define OMAP44XX_VA_SCU_BASE		OMAP2_IO_ADDRESS(OMAP44XX_SCU_BASE)
 #define OMAP44XX_LOCAL_TWD_BASE		0x48240600
-#define OMAP44XX_VA_LOCAL_TWD_BASE	IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE)
+#define OMAP44XX_VA_LOCAL_TWD_BASE	OMAP2_IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE)
 #define OMAP44XX_LOCAL_TWD_SIZE		0x00000100
 #define OMAP44XX_WKUPGEN_BASE		0x48281000
-#define OMAP44XX_VA_WKUPGEN_BASE	IO_ADDRESS(OMAP44XX_WKUPGEN_BASE)
+#define OMAP44XX_VA_WKUPGEN_BASE	OMAP2_IO_ADDRESS(OMAP44XX_WKUPGEN_BASE)
 
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index adc7352..1f44cd1 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -67,11 +67,11 @@
  */
 
 #define OMAP242X_SMS_REGADDR(reg)					\
-			(void __iomem *)IO_ADDRESS(OMAP2420_SMS_BASE + reg)
+			(void __iomem *)OMAP2_IO_ADDRESS(OMAP2420_SMS_BASE + reg)
 #define OMAP243X_SMS_REGADDR(reg)					\
-			(void __iomem *)IO_ADDRESS(OMAP243X_SMS_BASE + reg)
+			(void __iomem *)OMAP2_IO_ADDRESS(OMAP243X_SMS_BASE + reg)
 #define OMAP343X_SMS_REGADDR(reg)					\
-			(void __iomem *)IO_ADDRESS(OMAP343X_SMS_BASE + reg)
+			(void __iomem *)OMAP2_IO_ADDRESS(OMAP343X_SMS_BASE + reg)
 
 /* SMS register offsets - read/write with sms_{read,write}_reg() */
 
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index 9b42d72..d491ad1 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -132,3 +132,61 @@ void omap_iounmap(volatile void __iomem *addr)
 		__iounmap(addr);
 }
 EXPORT_SYMBOL(omap_iounmap);
+
+/*
+ * NOTE: Please use ioremap + __raw_read/write where possible instead of these
+ */
+
+u8 omap_readb(u32 pa)
+{
+	if (cpu_class_is_omap1())
+		return __raw_readb(OMAP1_IO_ADDRESS(pa));
+	else
+		return __raw_readb(OMAP2_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_readb);
+
+u16 omap_readw(u32 pa)
+{
+	if (cpu_class_is_omap1())
+		return __raw_readw(OMAP1_IO_ADDRESS(pa));
+	else
+		return __raw_readw(OMAP2_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_readw);
+
+u32 omap_readl(u32 pa)
+{
+	if (cpu_class_is_omap1())
+		return __raw_readl(OMAP1_IO_ADDRESS(pa));
+	else
+		return __raw_readl(OMAP2_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_readl);
+
+void omap_writeb(u8 v, u32 pa)
+{
+	if (cpu_class_is_omap1())
+		__raw_writeb(v, OMAP1_IO_ADDRESS(pa));
+	else
+		__raw_writeb(v, OMAP2_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_writeb);
+
+void omap_writew(u16 v, u32 pa)
+{
+	if (cpu_class_is_omap1())
+		__raw_writew(v, OMAP1_IO_ADDRESS(pa));
+	else
+		__raw_writew(v, OMAP2_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_writew);
+
+void omap_writel(u32 v, u32 pa)
+{
+	if (cpu_class_is_omap1())
+		__raw_writel(v, OMAP1_IO_ADDRESS(pa));
+	else
+		__raw_writel(v, OMAP2_IO_ADDRESS(pa));
+}
+EXPORT_SYMBOL(omap_writel);
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 2890b11..45b02f7 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -56,16 +56,16 @@
 #define SRAM_BOOTLOADER_SZ	0x80
 #endif
 
-#define OMAP24XX_VA_REQINFOPERM0	IO_ADDRESS(0x68005048)
-#define OMAP24XX_VA_READPERM0		IO_ADDRESS(0x68005050)
-#define OMAP24XX_VA_WRITEPERM0		IO_ADDRESS(0x68005058)
-
-#define OMAP34XX_VA_REQINFOPERM0	IO_ADDRESS(0x68012848)
-#define OMAP34XX_VA_READPERM0		IO_ADDRESS(0x68012850)
-#define OMAP34XX_VA_WRITEPERM0		IO_ADDRESS(0x68012858)
-#define OMAP34XX_VA_ADDR_MATCH2		IO_ADDRESS(0x68012880)
-#define OMAP34XX_VA_SMS_RG_ATT0		IO_ADDRESS(0x6C000048)
-#define OMAP34XX_VA_CONTROL_STAT	IO_ADDRESS(0x480022F0)
+#define OMAP24XX_VA_REQINFOPERM0	OMAP2_IO_ADDRESS(0x68005048)
+#define OMAP24XX_VA_READPERM0		OMAP2_IO_ADDRESS(0x68005050)
+#define OMAP24XX_VA_WRITEPERM0		OMAP2_IO_ADDRESS(0x68005058)
+
+#define OMAP34XX_VA_REQINFOPERM0	OMAP2_IO_ADDRESS(0x68012848)
+#define OMAP34XX_VA_READPERM0		OMAP2_IO_ADDRESS(0x68012850)
+#define OMAP34XX_VA_WRITEPERM0		OMAP2_IO_ADDRESS(0x68012858)
+#define OMAP34XX_VA_ADDR_MATCH2		OMAP2_IO_ADDRESS(0x68012880)
+#define OMAP34XX_VA_SMS_RG_ATT0		OMAP2_IO_ADDRESS(0x6C000048)
+#define OMAP34XX_VA_CONTROL_STAT	OMAP2_IO_ADDRESS(0x480022F0)
 
 #define GP_DEVICE		0x300
 
diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 148cbcc..915439d 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -212,9 +212,9 @@ static void enable_rfbi_mode(int enable)
 	dispc_write_reg(DISPC_CONTROL, l);
 
 	/* Set bypass mode in RFBI module */
-	l = __raw_readl(IO_ADDRESS(RFBI_CONTROL));
+	l = __raw_readl(OMAP2_IO_ADDRESS(RFBI_CONTROL));
 	l |= enable ? 0 : (1 << 1);
-	__raw_writel(l, IO_ADDRESS(RFBI_CONTROL));
+	__raw_writel(l, OMAP2_IO_ADDRESS(RFBI_CONTROL));
 }
 
 static void set_lcd_data_lines(int data_lines)
@@ -1421,7 +1421,7 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
 	}
 
 	/* L3 firewall setting: enable access to OCM RAM */
-	__raw_writel(0x402000b0, IO_ADDRESS(0x680050a0));
+	__raw_writel(0x402000b0, OMAP2_IO_ADDRESS(0x680050a0));
 
 	if ((r = alloc_palette_ram()) < 0)
 		goto fail2;

