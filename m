From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/7][RFC] OMAP4: Update common omap platform headers.
Date: Tue, 21 Apr 2009 18:38:09 +0530
Message-ID: <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com>
References: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55087 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754232AbZDUNIW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Apr 2009 09:08:22 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3LD8FmD029872
	for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 08:08:21 -0500
In-Reply-To: <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch updates the common platform headers files for OMAP4430.
On OMAP4, GIC is used instead of INTC, hence all the private peripheral
interrupts are shifted by an offset of 32. So if the hardcoding is not
done for IRQ lines in drivers, then this change won't impact any driver.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/include/mach/common.h      |    1 +
 arch/arm/plat-omap/include/mach/control.h     |    3 +-
 arch/arm/plat-omap/include/mach/debug-macro.S |    2 +-
 arch/arm/plat-omap/include/mach/dma.h         |    1 +
 arch/arm/plat-omap/include/mach/entry-macro.S |   45 +++++-
 arch/arm/plat-omap/include/mach/io.h          |   34 ++++
 arch/arm/plat-omap/include/mach/irqs.h        |  205 +++++++++++++------------
 arch/arm/plat-omap/include/mach/memory.h      |    3 +-
 arch/arm/plat-omap/include/mach/serial.h      |   11 ++-
 arch/arm/plat-omap/include/mach/system.h      |    7 +
 10 files changed, 206 insertions(+), 106 deletions(-)

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
index 269147f..c5f47cd 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
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
index 1b11f5c..662f08f 100644
--- a/arch/arm/plat-omap/include/mach/debug-macro.S
+++ b/arch/arm/plat-omap/include/mach/debug-macro.S
@@ -36,7 +36,7 @@
 		add	\rx, \rx, #0x00004000	@ UART 3
 #endif
 
-#elif	CONFIG_ARCH_OMAP3
+#elif	(CONFIG_ARCH_OMAP3 || CONFIG_ARCH_OMAP4)
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
index 2276f89..7a9d40e 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -10,6 +10,9 @@
 #include <mach/hardware.h>
 #include <mach/io.h>
 #include <mach/irqs.h>
+#ifdef	CONFIG_ARCH_OMAP44XX
+#include <asm/hardware/gic.h>
+#endif
 
 #if defined(CONFIG_ARCH_OMAP1)
 
@@ -56,7 +59,8 @@
 		.endm
 
 #endif
-#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+			defined(CONFIG_ARCH_OMAP44XX)
 
 #if defined(CONFIG_ARCH_OMAP24XX)
 #include <mach/omap24xx.h>
@@ -64,7 +68,9 @@
 #if defined(CONFIG_ARCH_OMAP34XX)
 #include <mach/omap34xx.h>
 #endif
-
+#if defined(CONFIG_ARCH_OMAP44XX)
+#include <mach/omap44xx.h>
+#endif
 #define INTCPS_SIR_IRQ_OFFSET	0x0040		/* Active interrupt offset */
 #define	ACTIVEIRQ_MASK		0x7f		/* Active interrupt bits */
 
@@ -77,6 +83,7 @@
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
 
+#ifndef CONFIG_ARCH_OMAP44XX
 		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 		ldr	\base, =OMAP2_VA_IC_BASE
 		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
@@ -92,6 +99,40 @@
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
index 0610d7e..f786471 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -157,6 +157,40 @@
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
index 7f57ee6..81d5ab7 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -318,109 +318,114 @@
 #define INT_850_DMA_CH15	(62 + IH2_BASE)
 #define INT_850_NAND		(63 + IH2_BASE)
 
-#define INT_24XX_SYS_NIRQ	7
-#define INT_24XX_SDMA_IRQ0	12
-#define INT_24XX_SDMA_IRQ1	13
-#define INT_24XX_SDMA_IRQ2	14
-#define INT_24XX_SDMA_IRQ3	15
-#define INT_24XX_CAM_IRQ	24
-#define INT_24XX_DSS_IRQ	25
-#define INT_24XX_MAIL_U0_MPU	26
-#define INT_24XX_DSP_UMA	27
-#define INT_24XX_DSP_MMU	28
-#define INT_24XX_GPIO_BANK1	29
-#define INT_24XX_GPIO_BANK2	30
-#define INT_24XX_GPIO_BANK3	31
-#define INT_24XX_GPIO_BANK4	32
-#define INT_24XX_GPIO_BANK5	33
-#define INT_24XX_MAIL_U3_MPU	34
-#define INT_24XX_GPTIMER1	37
-#define INT_24XX_GPTIMER2	38
-#define INT_24XX_GPTIMER3	39
-#define INT_24XX_GPTIMER4	40
-#define INT_24XX_GPTIMER5	41
-#define INT_24XX_GPTIMER6	42
-#define INT_24XX_GPTIMER7	43
-#define INT_24XX_GPTIMER8	44
-#define INT_24XX_GPTIMER9	45
-#define INT_24XX_GPTIMER10	46
-#define INT_24XX_GPTIMER11	47
-#define INT_24XX_GPTIMER12	48
-#define INT_24XX_SHA1MD5	51
-#define INT_24XX_MCBSP4_IRQ_TX	54
-#define INT_24XX_MCBSP4_IRQ_RX	55
-#define INT_24XX_I2C1_IRQ	56
-#define INT_24XX_I2C2_IRQ	57
-#define INT_24XX_HDQ_IRQ	58
-#define INT_24XX_MCBSP1_IRQ_TX	59
-#define INT_24XX_MCBSP1_IRQ_RX	60
-#define INT_24XX_MCBSP2_IRQ_TX	62
-#define INT_24XX_MCBSP2_IRQ_RX	63
-#define INT_24XX_SPI1_IRQ	65
-#define INT_24XX_SPI2_IRQ	66
-#define INT_24XX_UART1_IRQ	72
-#define INT_24XX_UART2_IRQ	73
-#define INT_24XX_UART3_IRQ	74
-#define INT_24XX_USB_IRQ_GEN	75
-#define INT_24XX_USB_IRQ_NISO	76
-#define INT_24XX_USB_IRQ_ISO	77
-#define INT_24XX_USB_IRQ_HGEN	78
-#define INT_24XX_USB_IRQ_HSOF	79
-#define INT_24XX_USB_IRQ_OTG	80
-#define INT_24XX_MCBSP5_IRQ_TX	81
-#define INT_24XX_MCBSP5_IRQ_RX	82
-#define INT_24XX_MMC_IRQ	83
-#define INT_24XX_MMC2_IRQ	86
-#define INT_24XX_MCBSP3_IRQ_TX	89
-#define INT_24XX_MCBSP3_IRQ_RX	90
-#define INT_24XX_SPI3_IRQ	91
+#ifdef	CONFIG_ARCH_OMAP4
+#define IRQ_GIC_START		32
+#else
+#define	IRQ_GIC_START		0
+#endif
 
-#define INT_243X_MCBSP2_IRQ	16
-#define INT_243X_MCBSP3_IRQ	17
-#define INT_243X_MCBSP4_IRQ	18
-#define INT_243X_MCBSP5_IRQ	19
-#define INT_243X_MCBSP1_IRQ	64
-#define INT_243X_HS_USB_MC	92
-#define INT_243X_HS_USB_DMA	93
-#define INT_243X_CARKIT_IRQ	94
+#define INT_24XX_SYS_NIRQ	(7 + IRQ_GIC_START)
+#define INT_24XX_SDMA_IRQ0	(12 + IRQ_GIC_START)
+#define INT_24XX_SDMA_IRQ1	(13 + IRQ_GIC_START)
+#define INT_24XX_SDMA_IRQ2	(14 + IRQ_GIC_START)
+#define INT_24XX_SDMA_IRQ3	(15 + IRQ_GIC_START)
+#define INT_24XX_CAM_IRQ	(24 + IRQ_GIC_START)
+#define INT_24XX_DSS_IRQ	(25 + IRQ_GIC_START)
+#define INT_24XX_MAIL_U0_MPU	(26 + IRQ_GIC_START)
+#define INT_24XX_DSP_UMA	(27 + IRQ_GIC_START)
+#define INT_24XX_DSP_MMU	(28 + IRQ_GIC_START)
+#define INT_24XX_GPIO_BANK1	(29 + IRQ_GIC_START)
+#define INT_24XX_GPIO_BANK2	(30 + IRQ_GIC_START)
+#define INT_24XX_GPIO_BANK3	(31 + IRQ_GIC_START)
+#define INT_24XX_GPIO_BANK4	(32 + IRQ_GIC_START)
+#define INT_24XX_GPIO_BANK5	(33 + IRQ_GIC_START)
+#define INT_24XX_MAIL_U3_MPU	(34 + IRQ_GIC_START)
+#define INT_24XX_GPTIMER1	(37 + IRQ_GIC_START)
+#define INT_24XX_GPTIMER2	(38 + IRQ_GIC_START)
+#define INT_24XX_GPTIMER3	(39 + IRQ_GIC_START)
+#define INT_24XX_GPTIMER4	(40 + IRQ_GIC_START)
+#define INT_24XX_GPTIMER5	(41 + IRQ_GIC_START)
+#define INT_24XX_GPTIMER6	(42 + IRQ_GIC_START)
+#define INT_24XX_GPTIMER7	(43 + IRQ_GIC_START)
+#define INT_24XX_GPTIMER8	(44 + IRQ_GIC_START)
+#define INT_24XX_GPTIMER9	(45 + IRQ_GIC_START)
+#define INT_24XX_GPTIMER10	(46 + IRQ_GIC_START)
+#define INT_24XX_GPTIMER11	(47 + IRQ_GIC_START)
+#define INT_24XX_GPTIMER12	(48 + IRQ_GIC_START)
+#define INT_24XX_SHA1MD5	(51 + IRQ_GIC_START)
+#define INT_24XX_MCBSP4_IRQ_TX	(54 + IRQ_GIC_START)
+#define INT_24XX_MCBSP4_IRQ_RX	(55 + IRQ_GIC_START)
+#define INT_24XX_I2C1_IRQ	(56 + IRQ_GIC_START)
+#define INT_24XX_I2C2_IRQ	(57 + IRQ_GIC_START)
+#define INT_24XX_HDQ_IRQ	(58 + IRQ_GIC_START)
+#define INT_24XX_MCBSP1_IRQ_TX	(59 + IRQ_GIC_START)
+#define INT_24XX_MCBSP1_IRQ_RX	(60 + IRQ_GIC_START)
+#define INT_24XX_MCBSP2_IRQ_TX	(62 + IRQ_GIC_START)
+#define INT_24XX_MCBSP2_IRQ_RX	(63 + IRQ_GIC_START)
+#define INT_24XX_SPI1_IRQ	(65 + IRQ_GIC_START)
+#define INT_24XX_SPI2_IRQ	(66 + IRQ_GIC_START)
+#define INT_24XX_UART1_IRQ	(72 + IRQ_GIC_START)
+#define INT_24XX_UART2_IRQ	(73 + IRQ_GIC_START)
+#define INT_24XX_UART3_IRQ	(74 + IRQ_GIC_START)
+#define INT_24XX_USB_IRQ_GEN	(75 + IRQ_GIC_START)
+#define INT_24XX_USB_IRQ_NISO	(76 + IRQ_GIC_START)
+#define INT_24XX_USB_IRQ_ISO	(77 + IRQ_GIC_START)
+#define INT_24XX_USB_IRQ_HGEN	(78 + IRQ_GIC_START)
+#define INT_24XX_USB_IRQ_HSOF	(79 + IRQ_GIC_START)
+#define INT_24XX_USB_IRQ_OTG	(80 + IRQ_GIC_START)
+#define INT_24XX_MCBSP5_IRQ_TX	(81 + IRQ_GIC_START)
+#define INT_24XX_MCBSP5_IRQ_RX	(82 + IRQ_GIC_START)
+#define INT_24XX_MMC_IRQ	(83 + IRQ_GIC_START)
+#define INT_24XX_MMC2_IRQ	(86 + IRQ_GIC_START)
+#define INT_24XX_MCBSP3_IRQ_TX	(89 + IRQ_GIC_START)
+#define INT_24XX_MCBSP3_IRQ_RX	(90 + IRQ_GIC_START)
+#define INT_24XX_SPI3_IRQ	(91 + IRQ_GIC_START)
 
-#define INT_34XX_BENCH_MPU_EMUL	3
-#define INT_34XX_ST_MCBSP2_IRQ	4
-#define INT_34XX_ST_MCBSP3_IRQ	5
-#define INT_34XX_SSM_ABORT_IRQ	6
-#define INT_34XX_SYS_NIRQ	7
-#define INT_34XX_D2D_FW_IRQ	8
-#define INT_34XX_PRCM_MPU_IRQ	11
-#define INT_34XX_MCBSP1_IRQ	16
-#define INT_34XX_MCBSP2_IRQ	17
-#define INT_34XX_MCBSP3_IRQ	22
-#define INT_34XX_MCBSP4_IRQ	23
-#define INT_34XX_CAM_IRQ	24
-#define INT_34XX_MCBSP5_IRQ	27
-#define INT_34XX_GPIO_BANK1	29
-#define INT_34XX_GPIO_BANK2	30
-#define INT_34XX_GPIO_BANK3	31
-#define INT_34XX_GPIO_BANK4	32
-#define INT_34XX_GPIO_BANK5	33
-#define INT_34XX_GPIO_BANK6	34
-#define INT_34XX_USIM_IRQ	35
-#define INT_34XX_WDT3_IRQ	36
-#define INT_34XX_SPI4_IRQ	48
-#define INT_34XX_SHA1MD52_IRQ	49
-#define INT_34XX_FPKA_READY_IRQ	50
-#define INT_34XX_SHA1MD51_IRQ	51
-#define INT_34XX_RNG_IRQ	52
-#define INT_34XX_I2C3_IRQ	61
-#define INT_34XX_FPKA_ERROR_IRQ	64
-#define INT_34XX_PBIAS_IRQ	75
-#define INT_34XX_OHCI_IRQ	76
-#define INT_34XX_EHCI_IRQ	77
-#define INT_34XX_TLL_IRQ	78
-#define INT_34XX_PARTHASH_IRQ	79
-#define INT_34XX_MMC3_IRQ	94
-#define INT_34XX_GPT12_IRQ	95
+#define INT_243X_MCBSP2_IRQ	(16 + IRQ_GIC_START)
+#define INT_243X_MCBSP3_IRQ	(17 + IRQ_GIC_START)
+#define INT_243X_MCBSP4_IRQ	(18 + IRQ_GIC_START)
+#define INT_243X_MCBSP5_IRQ	(19 + IRQ_GIC_START)
+#define INT_243X_MCBSP1_IRQ	(64 + IRQ_GIC_START)
+#define INT_243X_HS_USB_MC	(92 + IRQ_GIC_START)
+#define INT_243X_HS_USB_DMA	(93 + IRQ_GIC_START)
+#define INT_243X_CARKIT_IRQ	(94 + IRQ_GIC_START)
 
-#define	INT_34XX_BENCH_MPU_EMUL	3
+#define INT_34XX_BENCH_MPU_EMUL	(3 + IRQ_GIC_START)
+#define INT_34XX_ST_MCBSP2_IRQ	(4 + IRQ_GIC_START)
+#define INT_34XX_ST_MCBSP3_IRQ	(5 + IRQ_GIC_START)
+#define INT_34XX_SSM_ABORT_IRQ	(6 + IRQ_GIC_START)
+#define INT_34XX_SYS_NIRQ	(7 + IRQ_GIC_START)
+#define INT_34XX_D2D_FW_IRQ	(8 + IRQ_GIC_START)
+#define INT_34XX_PRCM_MPU_IRQ	(11 + IRQ_GIC_START)
+#define INT_34XX_MCBSP1_IRQ	(16 + IRQ_GIC_START)
+#define INT_34XX_MCBSP2_IRQ	(17 + IRQ_GIC_START)
+#define INT_34XX_MCBSP3_IRQ	(22 + IRQ_GIC_START)
+#define INT_34XX_MCBSP4_IRQ	(23 + IRQ_GIC_START)
+#define INT_34XX_CAM_IRQ	(24 + IRQ_GIC_START)
+#define INT_34XX_MCBSP5_IRQ	(27 + IRQ_GIC_START)
+#define INT_34XX_GPIO_BANK1	(29 + IRQ_GIC_START)
+#define INT_34XX_GPIO_BANK2	(30 + IRQ_GIC_START)
+#define INT_34XX_GPIO_BANK3	(31 + IRQ_GIC_START)
+#define INT_34XX_GPIO_BANK4	(32 + IRQ_GIC_START)
+#define INT_34XX_GPIO_BANK5	(33 + IRQ_GIC_START)
+#define INT_34XX_GPIO_BANK6	(34 + IRQ_GIC_START)
+#define INT_34XX_USIM_IRQ	(35 + IRQ_GIC_START)
+#define INT_34XX_WDT3_IRQ	(36 + IRQ_GIC_START)
+#define INT_34XX_SPI4_IRQ	(48 + IRQ_GIC_START)
+#define INT_34XX_SHA1MD52_IRQ	(49 + IRQ_GIC_START)
+#define INT_34XX_FPKA_READY_IRQ	(50 + IRQ_GIC_START)
+#define INT_34XX_SHA1MD51_IRQ	(51 + IRQ_GIC_START)
+#define INT_34XX_RNG_IRQ	(52 + IRQ_GIC_START)
+#define INT_34XX_I2C3_IRQ	(61 + IRQ_GIC_START)
+#define INT_34XX_FPKA_ERROR_IRQ	(64 + IRQ_GIC_START)
+#define INT_34XX_PBIAS_IRQ	(75 + IRQ_GIC_START)
+#define INT_34XX_OHCI_IRQ	(76 + IRQ_GIC_START)
+#define INT_34XX_EHCI_IRQ	(77 + IRQ_GIC_START)
+#define INT_34XX_TLL_IRQ	(78 + IRQ_GIC_START)
+#define INT_34XX_PARTHASH_IRQ	(79 + IRQ_GIC_START)
+#define INT_34XX_MMC3_IRQ	(94 + IRQ_GIC_START)
+#define INT_34XX_GPT12_IRQ	(95 + IRQ_GIC_START)
+#define INT_44XX_SPI5_IRQ	(69 + IRQ_GIC_START)
 
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730/850) and
  * 16 MPUIO lines */
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
index 8a676a0..ed4738b 100644
--- a/arch/arm/plat-omap/include/mach/serial.h
+++ b/arch/arm/plat-omap/include/mach/serial.h
@@ -15,19 +15,28 @@
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
diff --git a/arch/arm/plat-omap/include/mach/system.h b/arch/arm/plat-omap/include/mach/system.h
index 1060e34..371f98a 100644
--- a/arch/arm/plat-omap/include/mach/system.h
+++ b/arch/arm/plat-omap/include/mach/system.h
@@ -48,4 +48,11 @@ static inline void arch_reset(char mode, const char *cmd)
 		omap_prcm_arch_reset(mode);
 }
 
+#ifdef CONFIG_ARCH_OMAP4
+void omap_prcm_arch_reset(char mode)
+{
+	/* dummy hook for Linking */
+}
+#endif
+
 #endif
-- 
1.5.4.7

