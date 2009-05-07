From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [RESUBMIT][PATCH 3/7] OMAP4: Update common omap platform headers.
Date: Thu,  7 May 2009 11:59:12 +0530
Message-ID: <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45514 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752232AbZEGG3i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 May 2009 02:29:38 -0400
In-Reply-To: <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch updates the common platform headers files for OMAP4430.
On OMAP4, GIC is used instead of INTC, hence all the private peripheral
interrupts are shifted by an offset of 32. So if the hardcoding is not
done for IRQ lines in drivers, then this change won't impact any driver.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/include/mach/clock.h       |    8 ++-
 arch/arm/plat-omap/include/mach/common.h      |    1 +
 arch/arm/plat-omap/include/mach/control.h     |    7 +-
 arch/arm/plat-omap/include/mach/debug-macro.S |    2 +-
 arch/arm/plat-omap/include/mach/dma.h         |    1 +
 arch/arm/plat-omap/include/mach/entry-macro.S |   46 ++++++++++++-
 arch/arm/plat-omap/include/mach/io.h          |   37 ++++++++++
 arch/arm/plat-omap/include/mach/irqs.h        |   89 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/memory.h      |    3 +-
 arch/arm/plat-omap/include/mach/serial.h      |   16 ++++-
 10 files changed, 198 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 073a2c5..058a808 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -22,7 +22,8 @@ struct clkops {
 	void			(*disable)(struct clk *);
 };
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+		defined(CONFIG_ARCH_OMAP4)
 
 struct clksel_rate {
 	u32			val;
@@ -51,7 +52,7 @@ struct dpll_data {
 	u8			max_divider;
 	u32			max_tolerance;
 	u16			max_multiplier;
-#  if defined(CONFIG_ARCH_OMAP3)
+#  if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	u8			modes;
 	void __iomem		*autoidle_reg;
 	void __iomem		*idlest_reg;
@@ -83,7 +84,8 @@ struct clk {
 	void			(*init)(struct clk *);
 	__u8			enable_bit;
 	__s8			usecount;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+		defined(CONFIG_ARCH_OMAP4)
 	u8			fixed_div;
 	void __iomem		*clksel_reg;
 	u32			clksel_mask;
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index 0ecf36d..4b18833 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -62,6 +62,7 @@ struct omap_globals {
 void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
 void omap2_set_globals_343x(void);
+void omap2_set_globals_443x(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 269147f..f45ec62 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -1,9 +1,9 @@
 /*
  * arch/arm/plat-omap/include/mach/control.h
  *
- * OMAP2/3 System Control Module definitions
+ * OMAP2/3/4 System Control Module definitions
  *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009 Texas Instruments, Inc.
  * Copyright (C) 2007-2008 Nokia Corporation
  *
  * Written by Paul Walmsley
@@ -190,7 +190,8 @@
 #define OMAP2_PBIASLITEVMODE0		(1 << 0)
 
 #ifndef __ASSEMBLY__
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+		defined(CONFIG_ARCH_OMAP4)
 extern void __iomem *omap_ctrl_base_get(void);
 extern u8 omap_ctrl_readb(u16 offset);
 extern u16 omap_ctrl_readw(u16 offset);
diff --git a/arch/arm/plat-omap/include/mach/debug-macro.S b/arch/arm/plat-omap/include/mach/debug-macro.S
index 1b11f5c..ac24050 100644
--- a/arch/arm/plat-omap/include/mach/debug-macro.S
+++ b/arch/arm/plat-omap/include/mach/debug-macro.S
@@ -36,7 +36,7 @@
 		add	\rx, \rx, #0x00004000	@ UART 3
 #endif
 
-#elif	CONFIG_ARCH_OMAP3
+#elif defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 		moveq	\rx, #0x48000000	@ physical base address
 		movne	\rx, #0xd8000000	@ virtual base
 		orr	\rx, \rx, #0x0006a000
diff --git a/arch/arm/plat-omap/include/mach/dma.h b/arch/arm/plat-omap/include/mach/dma.h
index 54fe966..8e05b6a 100644
--- a/arch/arm/plat-omap/include/mach/dma.h
+++ b/arch/arm/plat-omap/include/mach/dma.h
@@ -48,6 +48,7 @@
 /* Hardware registers for omap2 and omap3 */
 #define OMAP24XX_DMA4_BASE		(L4_24XX_BASE + 0x56000)
 #define OMAP34XX_DMA4_BASE		(L4_34XX_BASE + 0x56000)
+#define OMAP44XX_DMA4_BASE		(L4_44XX_BASE + 0x56000)
 
 #define OMAP_DMA4_REVISION		0x00
 #define OMAP_DMA4_GCR			0x78
diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
index 2276f89..62bcb1b 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -3,6 +3,9 @@
  *
  * Low-level IRQ helper macros for OMAP-based platforms
  *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>*
+ *
  * This file is licensed under  the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
@@ -10,6 +13,7 @@
 #include <mach/hardware.h>
 #include <mach/io.h>
 #include <mach/irqs.h>
+#include <asm/hardware/gic.h>
 
 #if defined(CONFIG_ARCH_OMAP1)
 
@@ -56,7 +60,8 @@
 		.endm
 
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP4)
 
 #if defined(CONFIG_ARCH_OMAP24XX)
 #include <mach/omap24xx.h>
@@ -64,7 +69,9 @@
 #if defined(CONFIG_ARCH_OMAP34XX)
 #include <mach/omap34xx.h>
 #endif
-
+#if defined(CONFIG_ARCH_OMAP4)
+#include <mach/omap44xx.h>
+#endif
 #define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
 #define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
 
@@ -77,6 +84,7 @@
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
 
+#ifndef CONFIG_ARCH_OMAP4
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\base, =OMAP2_VA_IC_BASE
 		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
@@ -92,6 +100,40 @@
 		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
 
 		.endm
+#else
+		/*
+		 * The interrupt numbering scheme is defined in the
+		 * interrupt controller spec.  To wit:
+		 *
+		 * Interrupts 0-15 are IPI
+		 * 16-28 are reserved
+		 * 29-31 are local.  We allow 30 to be used for the watchdog.
+		 * 32-1020 are global
+		 * 1021-1022 are reserved
+		 * 1023 is "spurious" (no interrupt)
+		 *
+		 * For now, we ignore all local interrupts so only return an
+		 * interrupt if it's between 30 and 1020.  The test_for_ipi
+		 * routine below will pick up on IPIs.
+		 * A simple read from the controller will tell us the number
+		 * of the highest priority enabled interrupt.
+		 * We then just need to check whether it is in the
+		 * valid range for an IRQ (30-1020 inclusive).
+		 */
+		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
+		ldr     \base, =OMAP44XX_VA_GIC_CPU_BASE
+		ldr     \irqstat, [\base, #GIC_CPU_INTACK]
+
+		ldr     \tmp, =1021
+
+		bic     \irqnr, \irqstat, #0x1c00
+
+		cmp     \irqnr, #29
+		cmpcc   \irqnr, \irqnr
+		cmpne   \irqnr, \tmp
+		cmpcs   \irqnr, \irqnr
+		.endm
+#endif
 
 		.macro	irq_prio_table
 		.endm
diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index 0610d7e..3b28147 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -6,6 +6,9 @@
  * Copied from arch/arm/mach-sa1100/include/mach/io.h
  * Copyright (C) 1997-1999 Russell King
  *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2 of the License, or (at your
@@ -157,6 +160,40 @@
 #define DSP_MMU_34XX_VIRT	0xe2000000
 #define DSP_MMU_34XX_SIZE	SZ_4K
 
+
+#elif defined(CONFIG_ARCH_OMAP4)
+/* We map both L3 and L4 on OMAP4 */
+#define L3_44XX_PHYS		L3_44XX_BASE
+#define L3_44XX_VIRT		0xd4000000
+#define L3_44XX_SIZE		SZ_1M
+
+#define L4_44XX_PHYS		L4_44XX_BASE
+#define L4_44XX_VIRT		0xda000000
+#define L4_44XX_SIZE		SZ_4M
+
+
+#define L4_WK_44XX_PHYS		L4_WK_44XX_BASE
+#define L4_WK_44XX_VIRT		0xda300000
+#define L4_WK_44XX_SIZE		SZ_1M
+
+#define L4_PER_44XX_PHYS	L4_PER_44XX_BASE
+#define L4_PER_44XX_VIRT	0xd8000000
+#define L4_PER_44XX_SIZE	SZ_4M
+
+#define L4_EMU_44XX_PHYS	L4_EMU_44XX_BASE
+#define L4_EMU_44XX_VIRT	0xe4000000
+#define L4_EMU_44XX_SIZE	SZ_64M
+
+#define OMAP44XX_GPMC_PHYS	OMAP44XX_GPMC_BASE
+#define OMAP44XX_GPMC_VIRT	0xe0000000
+#define OMAP44XX_GPMC_SIZE	SZ_1M
+
+
+#define IO_OFFSET		0x90000000
+#define __IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L3 and L4 */
+#define __OMAP2_IO_ADDRESS(pa)	((pa) + IO_OFFSET)/* Works for L3 and L4 */
+#define io_v2p(va)		((va) - IO_OFFSET)/* Works for L3 and L4 */
+
 #endif
 
 #define IO_ADDRESS(pa)		IOMEM(__IO_ADDRESS(pa))
diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
index 7f57ee6..5bc331e 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -4,6 +4,9 @@
  *  Copyright (C) Greg Lonnon 2001
  *  Updated for OMAP-1610 by Tony Lindgren <tony@atomide.com>
  *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -422,6 +425,92 @@
 
 #define	INT_34XX_BENCH_MPU_EMUL	3
 
+
+#define IRQ_GIC_START		32
+
+#define INT_44XX_BENCH_MPU_EMUL	(3 + IRQ_GIC_START)
+#define INT_44XX_SSM_ABORT_IRQ	(6 + IRQ_GIC_START)
+#define INT_44XX_SYS_NIRQ	(7 + IRQ_GIC_START)
+#define INT_44XX_D2D_FW_IRQ	(8 + IRQ_GIC_START)
+#define INT_44XX_PRCM_MPU_IRQ	(11 + IRQ_GIC_START)
+#define INT_44XX_SDMA_IRQ0	(12 + IRQ_GIC_START)
+#define INT_44XX_SDMA_IRQ1	(13 + IRQ_GIC_START)
+#define INT_44XX_SDMA_IRQ2	(14 + IRQ_GIC_START)
+#define INT_44XX_SDMA_IRQ3	(15 + IRQ_GIC_START)
+#define INT_44XX_ISS_IRQ	(24 + IRQ_GIC_START)
+#define INT_44XX_DSS_IRQ	(25 + IRQ_GIC_START)
+#define INT_44XX_MAIL_U0_MPU	(26 + IRQ_GIC_START)
+#define INT_44XX_DSP_MMU	(28 + IRQ_GIC_START)
+#define INT_44XX_GPTIMER1	(37 + IRQ_GIC_START)
+#define INT_44XX_GPTIMER2	(38 + IRQ_GIC_START)
+#define INT_44XX_GPTIMER3	(39 + IRQ_GIC_START)
+#define INT_44XX_GPTIMER4	(40 + IRQ_GIC_START)
+#define INT_44XX_GPTIMER5	(41 + IRQ_GIC_START)
+#define INT_44XX_GPTIMER6	(42 + IRQ_GIC_START)
+#define INT_44XX_GPTIMER7	(43 + IRQ_GIC_START)
+#define INT_44XX_GPTIMER8	(44 + IRQ_GIC_START)
+#define INT_44XX_GPTIMER9	(45 + IRQ_GIC_START)
+#define INT_44XX_GPTIMER10	(46 + IRQ_GIC_START)
+#define INT_44XX_GPTIMER11	(47 + IRQ_GIC_START)
+#define INT_44XX_GPTIMER12	(95 + IRQ_GIC_START)
+#define INT_44XX_SHA1MD5	(51 + IRQ_GIC_START)
+#define INT_44XX_I2C1_IRQ	(56 + IRQ_GIC_START)
+#define INT_44XX_I2C2_IRQ	(57 + IRQ_GIC_START)
+#define INT_44XX_HDQ_IRQ	(58 + IRQ_GIC_START)
+#define INT_44XX_SPI1_IRQ	(65 + IRQ_GIC_START)
+#define INT_44XX_SPI2_IRQ	(66 + IRQ_GIC_START)
+#define INT_44XX_HSI_1_IRQ0	(67 + IRQ_GIC_START)
+#define INT_44XX_HSI_2_IRQ1	(68 + IRQ_GIC_START)
+#define INT_44XX_HSI_1_DMAIRQ	(71 + IRQ_GIC_START)
+#define INT_44XX_UART1_IRQ	(72 + IRQ_GIC_START)
+#define INT_44XX_UART2_IRQ	(73 + IRQ_GIC_START)
+#define INT_44XX_UART3_IRQ	(74 + IRQ_GIC_START)
+#define INT_44XX_UART4_IRQ	(70 + IRQ_GIC_START)
+#define INT_44XX_USB_IRQ_NISO	(76 + IRQ_GIC_START)
+#define INT_44XX_USB_IRQ_ISO	(77 + IRQ_GIC_START)
+#define INT_44XX_USB_IRQ_HGEN	(78 + IRQ_GIC_START)
+#define INT_44XX_USB_IRQ_HSOF	(79 + IRQ_GIC_START)
+#define INT_44XX_USB_IRQ_OTG	(80 + IRQ_GIC_START)
+#define INT_44XX_MCBSP4_IRQ_TX	(81 + IRQ_GIC_START)
+#define INT_44XX_MCBSP4_IRQ_RX	(82 + IRQ_GIC_START)
+#define INT_44XX_MMC_IRQ	(83 + IRQ_GIC_START)
+#define INT_44XX_MMC2_IRQ	(86 + IRQ_GIC_START)
+#define INT_44XX_MCBSP2_IRQ_TX	(89 + IRQ_GIC_START)
+#define INT_44XX_MCBSP2_IRQ_RX	(90 + IRQ_GIC_START)
+#define INT_44XX_SPI3_IRQ	(91 + IRQ_GIC_START)
+#define INT_44XX_SPI5_IRQ	(69 + IRQ_GIC_START)
+
+#define INT_44XX_MCBSP5_IRQ	(16 + IRQ_GIC_START)
+#define INT_44xX_MCBSP1_IRQ	(17 + IRQ_GIC_START)
+#define INT_44XX_MCBSP2_IRQ	(22 + IRQ_GIC_START)
+#define INT_44XX_MCBSP3_IRQ	(23 + IRQ_GIC_START)
+#define INT_44XX_MCBSP4_IRQ	(27 + IRQ_GIC_START)
+#define INT_44XX_HS_USB_MC	(92 + IRQ_GIC_START)
+#define INT_44XX_HS_USB_DMA	(93 + IRQ_GIC_START)
+
+#define INT_44XX_GPIO_BANK1	(29 + IRQ_GIC_START)
+#define INT_44XX_GPIO_BANK2	(30 + IRQ_GIC_START)
+#define INT_44XX_GPIO_BANK3	(31 + IRQ_GIC_START)
+#define INT_44XX_GPIO_BANK4	(32 + IRQ_GIC_START)
+#define INT_44XX_GPIO_BANK5	(33 + IRQ_GIC_START)
+#define INT_44XX_GPIO_BANK6	(34 + IRQ_GIC_START)
+#define INT_44XX_USIM_IRQ	(35 + IRQ_GIC_START)
+#define INT_44XX_WDT3_IRQ	(36 + IRQ_GIC_START)
+#define INT_44XX_SPI4_IRQ	(48 + IRQ_GIC_START)
+#define INT_44XX_SHA1MD52_IRQ	(49 + IRQ_GIC_START)
+#define INT_44XX_FPKA_READY_IRQ	(50 + IRQ_GIC_START)
+#define INT_44XX_SHA1MD51_IRQ	(51 + IRQ_GIC_START)
+#define INT_44XX_RNG_IRQ	(52 + IRQ_GIC_START)
+#define INT_44XX_I2C3_IRQ	(61 + IRQ_GIC_START)
+#define INT_44XX_FPKA_ERROR_IRQ	(64 + IRQ_GIC_START)
+#define INT_44XX_PBIAS_IRQ	(75 + IRQ_GIC_START)
+#define INT_44XX_OHCI_IRQ	(76 + IRQ_GIC_START)
+#define INT_44XX_EHCI_IRQ	(77 + IRQ_GIC_START)
+#define INT_44XX_TLL_IRQ	(78 + IRQ_GIC_START)
+#define INT_44XX_PARTHASH_IRQ	(79 + IRQ_GIC_START)
+#define INT_44XX_MMC3_IRQ	(94 + IRQ_GIC_START)
+
+
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730/850) and
  * 16 MPUIO lines */
 #define OMAP_MAX_GPIO_LINES	192
diff --git a/arch/arm/plat-omap/include/mach/memory.h b/arch/arm/plat-omap/include/mach/memory.h
index 99ed564..9ad41dc 100644
--- a/arch/arm/plat-omap/include/mach/memory.h
+++ b/arch/arm/plat-omap/include/mach/memory.h
@@ -38,7 +38,8 @@
  */
 #if defined(CONFIG_ARCH_OMAP1)
 #define PHYS_OFFSET		UL(0x10000000)
-#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#elif defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+			defined(CONFIG_ARCH_OMAP4)
 #define PHYS_OFFSET		UL(0x80000000)
 #endif
 
diff --git a/arch/arm/plat-omap/include/mach/serial.h b/arch/arm/plat-omap/include/mach/serial.h
index 8a676a0..e37894e 100644
--- a/arch/arm/plat-omap/include/mach/serial.h
+++ b/arch/arm/plat-omap/include/mach/serial.h
@@ -1,5 +1,8 @@
 /*
- *  arch/arm/plat-omap/include/mach/serial.h
+ * arch/arm/plat-omap/include/mach/serial.h
+ *
+ * Copyright (C) 2009 Texas Instruments
+ * Addded OMAP4 support- Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -15,19 +18,28 @@
 #define OMAP_UART1_BASE		0xfffb0000
 #define OMAP_UART2_BASE		0xfffb0800
 #define OMAP_UART3_BASE		0xfffb9800
+#define OMAP_MAX_NR_PORTS	3
 #elif defined(CONFIG_ARCH_OMAP2)
 /* OMAP2 serial ports */
 #define OMAP_UART1_BASE		0x4806a000
 #define OMAP_UART2_BASE		0x4806c000
 #define OMAP_UART3_BASE		0x4806e000
+#define OMAP_MAX_NR_PORTS	3
 #elif defined(CONFIG_ARCH_OMAP3)
 /* OMAP3 serial ports */
 #define OMAP_UART1_BASE		0x4806a000
 #define OMAP_UART2_BASE		0x4806c000
 #define OMAP_UART3_BASE		0x49020000
+#define OMAP_MAX_NR_PORTS	3
+#elif defined(CONFIG_ARCH_OMAP4)
+/* OMAP4 serial ports */
+#define OMAP_UART1_BASE		0x4806a000
+#define OMAP_UART2_BASE		0x4806c000
+#define OMAP_UART3_BASE		0x48020000
+#define OMAP_UART4_BASE		0x4806e000
+#define OMAP_MAX_NR_PORTS	4
 #endif
 
-#define OMAP_MAX_NR_PORTS	3
 #define OMAP1510_BASE_BAUD	(12000000/16)
 #define OMAP16XX_BASE_BAUD	(48000000/16)
 #define OMAP24XX_BASE_BAUD	(48000000/16)
-- 
1.5.4.7

