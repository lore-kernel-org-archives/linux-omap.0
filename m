From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH 2/6] TI816X: Update common omap platform files
Date: Sat, 31 Jul 2010 02:21:36 +0530
Message-ID: <1280523096-25041-1-git-send-email-hemantp@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34996 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597Ab0G3Uvm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Jul 2010 16:51:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Hemant Pedanekar <hemantp@ti.com>

This patch updates the common platform files with TI816X specific additions.

Also adds new files for TI816X modules base addresseses and irq definitions.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/mach-omap2/include/mach/entry-macro.S |   44 ++++++++-
 arch/arm/plat-omap/common.c                    |   20 ++++
 arch/arm/plat-omap/include/plat/clkdev_omap.h  |    1 +
 arch/arm/plat-omap/include/plat/clock.h        |    1 +
 arch/arm/plat-omap/include/plat/common.h       |    1 +
 arch/arm/plat-omap/include/plat/control.h      |   23 ++++
 arch/arm/plat-omap/include/plat/hardware.h     |    1 +
 arch/arm/plat-omap/include/plat/io.h           |   20 ++++
 arch/arm/plat-omap/include/plat/irqs-ti816x.h  |  128 ++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/irqs.h         |    3 +
 arch/arm/plat-omap/include/plat/serial.h       |    5 +
 arch/arm/plat-omap/include/plat/ti816x.h       |   40 ++++++++
 arch/arm/plat-omap/io.c                        |    7 ++
 13 files changed, 291 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/irqs-ti816x.h
 create mode 100644 arch/arm/plat-omap/include/plat/ti816x.h

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index 50fd749..6516cbd 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -34,7 +34,7 @@
 		.endm
 
 /*
- * Unoptimized irq functions for multi-omap2, 3 and 4
+ * Unoptimized irq functions for multi-omap2, 3, 4 and ti816x
  */
 
 #ifdef MULTI_OMAP2
@@ -57,7 +57,8 @@ omap_irq_base:	.word	0
 		mrc	p15, 0, \tmp, c0, c0, 0	@ get processor revision
 		and	\tmp, \tmp, #0x000000f0	@ check cortex 8 or 9
 		cmp	\tmp, #0x00000080	@ cortex A-8?
-		beq	3400f			@ found A-8 so it's omap34xx
+		beq	3400f			@ found A-8 so it's omap34xx or
+						@ ti816x
 		cmp	\tmp, #0x00000090	@ cortex A-9?
 		beq	4400f			@ found A-9 so it's omap44xx
 2400:		ldr	\base, =OMAP2_IRQ_BASE
@@ -80,7 +81,7 @@ omap_irq_base:	.word	0
 		tst	\base, #0x100		@ gic address?
 		bne	4401f			@ found gic
 
-		/* Handle omap2 and omap3 */
+		/* Handle omap2, omap3 and ti816x */
 		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
 		cmp	\irqnr, #0x0
 		bne	9998f
@@ -89,6 +90,14 @@ omap_irq_base:	.word	0
 		bne	9998f
 		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
 		cmp	\irqnr, #0x0
+		bne	9998f
+
+		/*
+		 * ti816x has additional IRQ pending register. Checking this
+		 * register on omap2 & omap3 has no effect (read as 0).
+		 */
+		ldr	\irqnr, [\base, #0xf8] /* IRQ pending reg 4 */
+		cmp	\irqnr, #0x0
 9998:
 		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
 		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK /* Clear spurious bits */
@@ -139,6 +148,35 @@ omap_irq_base:	.word	0
 		.endm
 #endif
 
+/*
+ * Optimized irq functions for ti816x
+ */
+
+#ifdef CONFiG_ARCH_TI816X
+		.macro  get_irqnr_preamble, base, tmp
+		ldr	\base, =OMAP3_IRQ_BASE
+		.endm
+
+		/* Check the pending interrupts. Note that base already set */
+		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
+		ldr	\irqnr, [\base, #0x98] /* IRQ pending reg 1 */
+		cmp	\irqnr, #0x0
+		bne	9999f
+		ldr	\irqnr, [\base, #0xb8] /* IRQ pending reg 2 */
+		cmp	\irqnr, #0x0
+		bne	9999f
+		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
+		cmp	\irqnr, #0x0
+		bne	9999f
+		ldr	\irqnr, [\base, #0xf8] /* IRQ pending reg 4 */
+		cmp	\irqnr, #0x0
+9999:
+		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
+		and	\irqnr, \irqnr, #ACTIVEIRQ_MASK
+
+		.endm
+#endif
+
 
 #ifdef CONFIG_ARCH_OMAP4
 
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 893a53a..053bddb 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -355,3 +355,23 @@ void __init omap2_set_globals_443x(void)
 }
 #endif
 
+#if defined(CONFIG_ARCH_TI816X)
+static struct omap_globals ti816x_globals = {
+	.class	= TI816X_CLASS,
+	.tap	= TI816X_L4_SLOW_IO_ADDRESS(TI816X_SCM_BASE),
+	.ctrl	= TI816X_CTRL_BASE,
+	.prm	= TI816X_PRCM_BASE,
+	.cm	= TI816X_PRCM_BASE,
+	.uart1_phys	= TI816X_UART1_BASE,
+	.uart2_phys	= TI816X_UART2_BASE,
+	.uart3_phys	= TI816X_UART3_BASE,
+};
+
+void __init omap2_set_globals_ti816x(void)
+{
+	omap2_set_globals_tap(&ti816x_globals);
+	omap2_set_globals_control(&ti816x_globals);
+	omap2_set_globals_prcm(&ti816x_globals);
+	omap2_set_globals_uart(&ti816x_globals);
+}
+#endif
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index bb937f3..9ac1997 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -40,6 +40,7 @@ struct omap_clk {
 #define CK_3517		(1 << 11)
 #define CK_36XX		(1 << 12)	/* OMAP36xx/37xx-specific clocks */
 #define CK_443X		(1 << 13)
+#define CK_TI816X	(1 << 14)
 
 #define CK_AM35XX	(CK_3505 | CK_3517)	/* all Sitara AM35xx */
 
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index fef4696..8c508b5 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -53,6 +53,7 @@ struct clkops {
 #define RATE_IN_3430ES2		(1 << 3)	/* 3430ES2 rates only */
 #define RATE_IN_36XX		(1 << 4)
 #define RATE_IN_4430		(1 << 5)
+#define RATE_IN_TI816X		(1 << 6)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 #define RATE_IN_3430ES2PLUS	(RATE_IN_3430ES2 | RATE_IN_36XX)
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 9776b41..2c4881c 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -60,6 +60,7 @@ void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
 void omap2_set_globals_3xxx(void);
 void omap2_set_globals_443x(void);
+void omap2_set_globals_ti816x(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index 131bf40..9070385 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -215,6 +215,24 @@
  * that should be added.
  */
 
+/* TI816X spefic control submodules */
+#define TI816X_CONTROL_OCPCONF		0x000
+#define TI816X_CONTROL_DEVBOOT		0x040
+#define TI816X_CONTROL_DEVCONF		0x600
+
+/* TI816X CONTROL_DEVBOOT register offsets */
+#define TI816X_CONTROL_STATUS		(TI816X_CONTROL_DEVBOOT + 0x000)
+#define TI816X_CONTROL_BOOTSTAT		(TI816X_CONTROL_DEVBOOT + 0x004)
+
+/* TI816X CONTROL_DEVCONF register offsets */
+#define TI816X_CONTROL_DEVICE_ID	(TI816X_CONTROL_DEVCONF + 0x000)
+#define TI816X_CONTROL_MAC_ID0_LO	(TI816X_CONTROL_DEVCONF + 0x030)
+#define TI816X_CONTROL_MAC_ID0_HI	(TI816X_CONTROL_DEVCONF + 0x034)
+#define TI816X_CONTROL_MAC_ID1_LO	(TI816X_CONTROL_DEVCONF + 0x038)
+#define TI816X_CONTROL_MAC_ID1_HI	(TI816X_CONTROL_DEVCONF + 0x03c)
+#define TI816X_CONTROL_PCIE_CFG		(TI816X_CONTROL_DEVCONF + 0x040)
+/* TODO: Add other ti816x registers... */
+
 /*
  * Control module register bit defines - these should eventually go into
  * their own regbits file.  Some of these will be complicated, depending
@@ -314,6 +332,11 @@
 #define AM35XX_HECC_SW_RST		BIT(3)
 #define AM35XX_VPFE_PCLK_SW_RST		BIT(4)
 
+/* TI816X CONTROL_PCIE_CFG bits */
+#define TI816X_PCIE_DEVTYPE_SHIFT	0
+#define TI816X_PCIE_DEVTYPE_MASK	(0x3 << 0)
+#define TI816X_PCIE_DEVTYPE_RC		(0x2 << 0)
+
 /*
  * CONTROL OMAP STATUS register to identify OMAP3 features
  */
diff --git a/arch/arm/plat-omap/include/plat/hardware.h b/arch/arm/plat-omap/include/plat/hardware.h
index d5b26ad..e87efe1 100644
--- a/arch/arm/plat-omap/include/plat/hardware.h
+++ b/arch/arm/plat-omap/include/plat/hardware.h
@@ -286,5 +286,6 @@
 #include <plat/omap24xx.h>
 #include <plat/omap34xx.h>
 #include <plat/omap44xx.h>
+#include <plat/ti816x.h>
 
 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 128b549..587a7b8 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -82,6 +82,9 @@
 #define OMAP2_EMU_IO_OFFSET		0xaa800000	/* Emulation */
 #define OMAP2_EMU_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_EMU_IO_OFFSET)
 
+#define TI816X_L4_SLOW_IO_OFFSET	0xb2000000
+#define TI816X_L4_SLOW_IO_ADDRESS(pa)	IOMEM((pa) + TI816X_L4_SLOW_IO_OFFSET)
+
 /*
  * ----------------------------------------------------------------------------
  * Omap1 specific IO mapping
@@ -235,6 +238,15 @@
 						/* 0x4e000000 --> 0xfd300000 */
 #define OMAP44XX_DMM_VIRT	(OMAP44XX_DMM_PHYS + OMAP4_L3_PER_IO_OFFSET)
 #define OMAP44XX_DMM_SIZE	SZ_1M
+
+/*
+ * TI816X Specific I/O Mapping
+ */
+#define L4_SLOW_TI816X_PHYS	L4_SLOW_TI816X_BASE
+						/* 0x48000000 --> 0xd8000000 */
+#define L4_SLOW_TI816X_VIRT	(L4_SLOW_TI816X_PHYS + TI816X_L4_SLOW_IO_OFFSET)
+#define L4_SLOW_TI816X_SIZE	SZ_4M
+
 /*
  * ----------------------------------------------------------------------------
  * Omap specific register access
@@ -291,6 +303,14 @@ static inline void omap44xx_map_common_io(void)
 }
 #endif
 
+#ifdef CONFIG_ARCH_TI816X
+extern void ti816x_map_common_io(void);
+#else
+static inline void ti816x_map_common_io(void)
+{
+}
+#endif
+
 extern void omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 				 struct omap_sdrc_params *sdrc_cs1);
 
diff --git a/arch/arm/plat-omap/include/plat/irqs-ti816x.h b/arch/arm/plat-omap/include/plat/irqs-ti816x.h
new file mode 100644
index 0000000..31337bc
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/irqs-ti816x.h
@@ -0,0 +1,128 @@
+/*
+ * ti816x family interrupts.
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_TI816X_IRQS_H
+#define __ARCH_ARM_MACH_OMAP2_TI816X_IRQS_H
+
+/*
+ * TI816X Interrupts
+ */
+#define TI816X_IRQ_EMU		0
+#define TI816X_IRQ_COMMTX	1
+#define TI816X_IRQ_COMMRX	2
+#define TI816X_IRQ_BENCH	3
+#define TI816X_IRQ_ELM		4
+#define TI816X_IRQ_SSM_WFI	5
+#define TI816X_IRQ_SSM		6
+#define TI816X_IRQ_NMI		7
+#define TI816X_IRQ_SEC_EVNT	8
+#define TI816X_IRQ_L3_DEBUG	9
+#define TI816X_IRQ_L3_APP	10
+#define TI816X_IRQ_EDMA_COMP	12
+#define TI816X_IRQ_EDMA_MPERR	13
+#define TI816X_IRQ_EDMA_ERR	14
+#define TI816X_IRQ_SATA		16
+#define TI816X_IRQ_USBSS	17
+#define TI816X_IRQ_USB0		18
+#define TI816X_IRQ_USB1		19
+#define TI816X_IRQ_TPPSS_ERR	20
+#define TI816X_IRQ_TPPSS_MBOX	21
+#define TI816X_IRQ_TPPSS_STC0	22
+#define TI816X_IRQ_TPPSS_STC1	23
+#define TI816X_IRQ_TPPSS_DMAPC0	24
+#define TI816X_IRQ_TPPSS_DMABS0	25
+#define TI816X_IRQ_TPPSS_ERR0	26
+#define TI816X_IRQ_TPPSS_ERR1	27
+#define TI816X_IRQ_TPPSS_ERR2	28
+#define TI816X_IRQ_TPPSS_ERR3	29
+#define TI816X_IRQ_MCARD_TX	30
+#define TI816X_IRQ_MCARD_RX	31
+#define TI816X_IRQ_USB_WKUP	34
+#define TI816X_IRQ_PCIE_WKUP	35
+#define TI816X_IRQ_DSSINT	36
+#define TI816X_IRQ_GFXINT	37
+#define TI816X_IRQ_HDMIINT	38
+#define TI816X_IRQ_VLYNQ	39
+#define TI816X_IRQ_MACRXTHR0	40
+#define TI816X_IRQ_MACRXINT0	41
+#define TI816X_IRQ_MACTXINT0	42
+#define TI816X_IRQ_MACMISC0	43
+#define TI816X_IRQ_MACRXTHR1	44
+#define TI816X_IRQ_MACRXINT1	45
+#define TI816X_IRQ_MACTXINT1	46
+#define TI816X_IRQ_MACMISC1	47
+#define TI816X_IRQ_PCIINT0	48
+#define TI816X_IRQ_PCIINT1	49
+#define TI816X_IRQ_PCIINT2	50
+#define TI816X_IRQ_PCIINT3	51
+#define TI816X_IRQ_SD		64
+#define TI816X_IRQ_SPI		65
+#define TI816X_IRQ_GPT1		66
+#define TI816X_IRQ_GPT2		67
+#define TI816X_IRQ_GPT3		68
+#define TI816X_IRQ_GPT4		69
+#define TI816X_IRQ_I2C0		70
+#define TI816X_IRQ_I2C1		71
+#define TI816X_IRQ_UART0	72
+#define TI816X_IRQ_UART1	73
+#define TI816X_IRQ_UART2	74
+#define TI816X_IRQ_RTC		75
+#define TI816X_IRQ_RTC_ALARM	76
+#define TI816X_IRQ_MBOX		77
+#define TI816X_IRQ_MCASP0_TX	80
+#define TI816X_IRQ_MCASP0_RX	81
+#define TI816X_IRQ_MCASP1_TX	82
+#define TI816X_IRQ_MCASP1_RX	83
+#define TI816X_IRQ_MCASP2_TX	84
+#define TI816X_IRQ_MCASP2_RX	85
+#define TI816X_IRQ_MCBSP	86
+#define TI816X_IRQ_SMCD0	87
+#define TI816X_IRQ_SMCD1	88
+#define TI816X_IRQ_WDT1		91
+#define TI816X_IRQ_GPT5		92
+#define TI816X_IRQ_GPT6		93
+#define TI816X_IRQ_GPT7		94
+#define TI816X_IRQ_GPT8		95
+#define TI816X_IRQ_GPIO_0A	96
+#define TI816X_IRQ_GPIO_0B	97
+#define TI816X_IRQ_GPIO_1A	98
+#define TI816X_IRQ_GPIO_1B	99
+#define TI816X_IRQ_GPMC		100
+#define TI816X_IRQ_DDR_ERR0	101
+#define TI816X_IRQ_DDR_ERR1	102
+#define TI816X_IRQ_IVA0CONT1SYNC	103
+#define TI816X_IRQ_IVA0CONT2SYNC	104
+#define TI816X_IRQ_IVA1CONT1SYNC	105
+#define TI816X_IRQ_IVA1CONT2SYNC	106
+#define TI816X_IRQ_IVA0MBOX	107
+#define TI816X_IRQ_IVA1MBOX	108
+#define TI816X_IRQ_IVA2MBOX	109
+#define TI816X_IRQ_IVA2CONT1SYNC	110
+#define TI816X_IRQ_IVA2CONT2SYNC	111
+#define TI816X_IRQ_TPTC0	112
+#define TI816X_IRQ_TPTC1	113
+#define TI816X_IRQ_TPTC2	114
+#define TI816X_IRQ_TPTC3	115
+#define TI816X_IRQ_SECPUBINT	116
+#define TI816X_IRQ_SECSECINT	117
+#define TI816X_IRQ_SECPUBSWINT	118
+#define TI816X_IRQ_SECSECSWINT	119
+#define TI816X_IRQ_SMRFLX0	120
+#define TI816X_IRQ_SMRFLX1	121
+#define TI816X_IRQ_SYS_MMU	122
+#define TI816X_IRQ_MC_MMU	123
+#define TI816X_IRQ_DMM		124
+
+#endif
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index c01d9f0..0cda749 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -31,6 +31,9 @@
 /* All OMAP4 specific defines are moved to irqs-44xx.h */
 #include "irqs-44xx.h"
 
+/* All TI816X specific defines are in irqs-ti816x.h */
+#include "irqs-ti816x.h"
+
 /*
  * IRQ numbers for interrupt handler 1
  *
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 19145f5..ad8d0d8 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -51,6 +51,11 @@
 #define OMAP4_UART3_BASE	0x48020000
 #define OMAP4_UART4_BASE	0x4806e000
 
+/* TI816X serial ports */
+#define TI816X_UART1_BASE	0x48020000
+#define TI816X_UART2_BASE	0x48022000
+#define TI816X_UART3_BASE	0x48024000
+
 /* External port on Zoom2/3 */
 #define ZOOM_UART_BASE		0x10000000
 #define ZOOM_UART_VIRT		0xfa400000
diff --git a/arch/arm/plat-omap/include/plat/ti816x.h b/arch/arm/plat-omap/include/plat/ti816x.h
new file mode 100644
index 0000000..43335c3
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/ti816x.h
@@ -0,0 +1,40 @@
+/*
+ * This file contains the address data for various ti816x modules.
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ASM_ARCH_TI816X_H
+#define __ASM_ARCH_TI816X_H
+
+#define L3_TI816X_BASE		0x44000000
+#define L4_FAST_TI816X_BASE	0x4a000000
+#define L4_SLOW_TI816X_BASE	0x48000000
+
+#define TI816X_SCM_BASE		0x48140000
+#define TI816X_CTRL_BASE	TI816X_SCM_BASE
+#define TI816X_PRCM_BASE	0x48180000
+
+#define TI816X_ARM_INTC_BASE	0x48200000
+
+#define TI816X_GPMC_BASE	0x50000000
+
+#define TI816X_USBSS_BASE	0x47400000
+#define TI816X_USBSS_LEN	0xFFF
+#define TI816X_USB0_BASE	0x47401000
+#define TI816X_USB1_BASE	0x47401800
+#define TI816X_USB_CPPIDMA_BASE	0x47402000
+#define TI816X_USB_CPPIDMA_LEN	0x5FFF
+
+#define TI816X_SATA_BASE	0x4A140000
+
+#endif /* __ASM_ARCH_TI816X_H */
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index b0078cf..4119130 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -124,6 +124,13 @@ void __iomem *omap_ioremap(unsigned long p, size_t size, unsigned int type)
 			return XLATE(p, L4_EMU_44XX_PHYS, L4_EMU_44XX_VIRT);
 	}
 #endif
+#ifdef CONFIG_ARCH_TI816X
+	if (cpu_is_ti816x()) {
+		if (BETWEEN(p, L4_SLOW_TI816X_PHYS, L4_SLOW_TI816X_SIZE))
+			return XLATE(p, L4_SLOW_TI816X_PHYS,
+					L4_SLOW_TI816X_VIRT);
+	}
+#endif
 	return __arm_ioremap_caller(p, size, type, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(omap_ioremap);
-- 
1.6.2.4

