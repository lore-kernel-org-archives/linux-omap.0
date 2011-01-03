From: Hemant Pedanekar <hemantp@ti.com>
Subject: [PATCH v3 1/4] TI816X: Update common omap platform files
Date: Mon,  3 Jan 2011 22:58:57 +0530
Message-ID: <1294075737-22320-1-git-send-email-hemantp@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54341 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754565Ab1ACR3V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jan 2011 12:29:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Hemant Pedanekar <hemantp@ti.com>

This patch updates the common platform files with TI816X support. Also adds new
files for TI816X modules base addresseses and irq definitions.

The approach taken in this patch is to add TI816X as part of OMAP3 variant where
the cpu class is considered as OMAP34XX and the type is TI816X. This means, both
cpu_is_omap34xx() and cpu_is_ti816x() checks return success on TI816X.

Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
---
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
 arch/arm/plat-omap/include/plat/clock.h       |    1 +
 arch/arm/plat-omap/include/plat/common.h      |    1 +
 arch/arm/plat-omap/include/plat/cpu.h         |   18 ++++
 arch/arm/plat-omap/include/plat/hardware.h    |    1 +
 arch/arm/plat-omap/include/plat/irqs-ti816x.h |  131 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/irqs.h        |    3 +
 arch/arm/plat-omap/include/plat/serial.h      |    5 +
 arch/arm/plat-omap/include/plat/ti816x.h      |   31 ++++++
 9 files changed, 192 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/irqs-ti816x.h
 create mode 100644 arch/arm/plat-omap/include/plat/ti816x.h

diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index b19774c..f1e880c 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -38,6 +38,7 @@ struct omap_clk {
 #define CK_3517		(1 << 9)
 #define CK_36XX		(1 << 10)	/* 36xx/37xx-specific clocks */
 #define CK_443X		(1 << 11)
+#define CK_TI816X	(1 << 12)
 
 
 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 8eb0ada..d43e623 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -53,6 +53,7 @@ struct clkops {
 #define RATE_IN_3430ES2PLUS	(1 << 3)	/* 3430 ES >= 2 rates only */
 #define RATE_IN_36XX		(1 << 4)
 #define RATE_IN_4430		(1 << 5)
+#define RATE_IN_TI816X		(1 << 6)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 #define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 6b8088e..be5c5e8 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -63,6 +63,7 @@ void omap2_set_globals_242x(void);
 void omap2_set_globals_243x(void);
 void omap2_set_globals_3xxx(void);
 void omap2_set_globals_443x(void);
+void omap2_set_globals_ti816x(void);
 
 /* These get called from omap2_set_globals_xxxx(), do not call these */
 void omap2_set_globals_tap(struct omap_globals *);
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 3fd8b40..539cd57 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -105,6 +105,12 @@ static inline int is_omap ##subclass (void)		\
 	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
 }
 
+#define IS_TI_SUBCLASS(subclass, id)			\
+static inline int is_ti ##subclass (void)		\
+{							\
+	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
+}
+
 IS_OMAP_CLASS(7xx, 0x07)
 IS_OMAP_CLASS(15xx, 0x15)
 IS_OMAP_CLASS(16xx, 0x16)
@@ -118,6 +124,8 @@ IS_OMAP_SUBCLASS(343x, 0x343)
 IS_OMAP_SUBCLASS(363x, 0x363)
 IS_OMAP_SUBCLASS(443x, 0x443)
 
+IS_TI_SUBCLASS(816x, 0x816)
+
 #define cpu_is_omap7xx()		0
 #define cpu_is_omap15xx()		0
 #define cpu_is_omap16xx()		0
@@ -275,6 +283,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define cpu_is_omap3430()		0
 #define cpu_is_omap4430()		0
 #define cpu_is_omap3630()		0
+#define cpu_is_ti816x()			0
 
 /*
  * Whether we have MULTI_OMAP1 or not, we still need to distinguish
@@ -330,6 +339,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_omap3530
 # undef cpu_is_omap3505
 # undef cpu_is_omap3517
+# undef cpu_is_ti816x
 # define cpu_is_omap3430()		is_omap3430()
 # define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
 						(!omap3_has_iva()) &&	\
@@ -343,6 +353,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_omap3530()		(cpu_is_omap3430())
 # define cpu_is_omap3505()		is_omap3505()
 # define cpu_is_omap3517()		is_omap3517()
+# define cpu_is_ti816x()		is_ti816x()
 # undef cpu_is_omap3630
 # define cpu_is_omap3630()		is_omap363x()
 #endif
@@ -389,6 +400,10 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP3505_REV(v)		(OMAP35XX_CLASS | (0x3505 << 16) | (v << 8))
 #define OMAP3517_REV(v)		(OMAP35XX_CLASS | (0x3517 << 16) | (v << 8))
 
+#define TI816X_CLASS		0x81600034
+#define TI8168_REV_ES1_0	TI816X_CLASS
+#define TI8168_REV_ES1_1	(TI816X_CLASS | (OMAP_REVBITS_01 << 8))
+
 #define OMAP443X_CLASS		0x44300044
 #define OMAP4430_REV_ES1_0	OMAP443X_CLASS
 #define OMAP4430_REV_ES2_0	0x44301044
@@ -419,6 +434,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define CHIP_IS_OMAP3630ES1_1           (1 << 9)
 #define CHIP_IS_OMAP3630ES1_2           (1 << 10)
 #define CHIP_IS_OMAP4430ES2		(1 << 11)
+#define CHIP_IS_TI816X			(1 << 12)
 
 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
@@ -455,6 +471,7 @@ extern u32 omap3_features;
 #define OMAP3_HAS_ISP			BIT(4)
 #define OMAP3_HAS_192MHZ_CLK		BIT(5)
 #define OMAP3_HAS_IO_WAKEUP		BIT(6)
+#define OMAP3_HAS_SDRC			BIT(7)
 
 #define OMAP3_HAS_FEATURE(feat,flag)			\
 static inline unsigned int omap3_has_ ##feat(void)	\
@@ -469,5 +486,6 @@ OMAP3_HAS_FEATURE(neon, NEON)
 OMAP3_HAS_FEATURE(isp, ISP)
 OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
 OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
+OMAP3_HAS_FEATURE(sdrc, SDRC)
 
 #endif
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
diff --git a/arch/arm/plat-omap/include/plat/irqs-ti816x.h b/arch/arm/plat-omap/include/plat/irqs-ti816x.h
new file mode 100644
index 0000000..3ec5d1b
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/irqs-ti816x.h
@@ -0,0 +1,131 @@
+/*
+ * arch/arm/plat-omap/include/plat/irqs-ti816x.h
+ *
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
+
+#endif
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 2910de9..21a5b87 100644
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
index cec5d56..3c3c319 100644
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
index 0000000..f1729f7
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/ti816x.h
@@ -0,0 +1,31 @@
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
+#endif /* __ASM_ARCH_TI816X_H */
-- 
1.6.2.4

