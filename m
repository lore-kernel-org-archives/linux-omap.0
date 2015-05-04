From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: OMAP1: Change interrupt numbering for sparse IRQ
Date: Mon,  4 May 2015 12:52:22 -0700
Message-ID: <1430769142-3921-5-git-send-email-tony@atomide.com>
References: <1430769142-3921-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tkt-001-i372.relay.mailchannels.net ([174.136.5.173]:62192 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751564AbbEDTwg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2015 15:52:36 -0400
In-Reply-To: <1430769142-3921-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>

Change interrupt numbering for sparse IRQ. We do this using
a fixed offset until we can drop irqs.h once all it's users
have been updated.

Note that this depends on the GPIO fix for the MPUIO IRQs
"gpio: omap: Fix regression for MPUIO interrupts".

Also note that this patch adds some extra irq alloc warnings
that will go away when we stop calling irq_alloc_descs
in gpio-omap.c with a follow-up patch.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig                            |   1 +
 arch/arm/mach-omap1/ams-delta-fiq-handler.S |   3 +-
 arch/arm/mach-omap1/dma.c                   |   2 +-
 arch/arm/mach-omap1/i2c.c                   |   3 +-
 arch/arm/mach-omap1/include/mach/irqs.h     | 124 ++++++++++++++--------------
 arch/arm/mach-omap1/include/mach/soc.h      |   4 +
 arch/arm/mach-omap1/irq.c                   |   1 +
 arch/arm/mach-omap1/timer.c                 |   4 +-
 arch/arm/plat-omap/dma.c                    |   4 +
 9 files changed, 75 insertions(+), 71 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 881a76c..6a23dac 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -755,6 +755,7 @@ config ARCH_OMAP1
 	select MULTI_IRQ_HANDLER
 	select NEED_MACH_IO_H if PCCARD
 	select NEED_MACH_MEMORY_H
+	select SPARSE_IRQ
 	help
 	  Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
 
diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index 3d1e1c2..5d7fb59 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -17,11 +17,10 @@
 #include <asm/assembler.h>
 
 #include <mach/board-ams-delta.h>
-
-#include <mach/irqs.h>
 #include <mach/ams-delta-fiq.h>
 
 #include "iomap.h"
+#include "soc.h"
 
 /*
  * GPIO related definitions, copied from arch/arm/plat-omap/gpio.c.
diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 4be601b6..7b02ed2 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -28,7 +28,7 @@
 #include <linux/omap-dma.h>
 #include <mach/tc.h>
 
-#include <mach/irqs.h>
+#include "soc.h"
 
 #define OMAP1_DMA_BASE			(0xfffed800)
 #define OMAP1_LOGICAL_DMA_CH_COUNT	17
diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index 7f5761c..82887d6 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -27,7 +27,6 @@
 
 #define OMAP_I2C_SIZE		0x3f
 #define OMAP1_I2C_BASE		0xfffb3800
-#define OMAP1_INT_I2C		(32 + 4)
 
 static const char name[] = "omap_i2c";
 
@@ -67,7 +66,7 @@ int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *pdata,
 	res[0].start = OMAP1_I2C_BASE;
 	res[0].end = res[0].start + OMAP_I2C_SIZE;
 	res[0].flags = IORESOURCE_MEM;
-	res[1].start = OMAP1_INT_I2C;
+	res[1].start = INT_I2C;
 	res[1].flags = IORESOURCE_IRQ;
 	pdev->resource = res;
 
diff --git a/arch/arm/mach-omap1/include/mach/irqs.h b/arch/arm/mach-omap1/include/mach/irqs.h
index 729992d..9050085 100644
--- a/arch/arm/mach-omap1/include/mach/irqs.h
+++ b/arch/arm/mach-omap1/include/mach/irqs.h
@@ -34,84 +34,84 @@
  * NOTE: See also the OMAP-1510 and 1610 specific IRQ numbers below
  *
  */
-#define INT_CAMERA		1
-#define INT_FIQ			3
-#define INT_RTDX		6
-#define INT_DSP_MMU_ABORT	7
-#define INT_HOST		8
-#define INT_ABORT		9
-#define INT_BRIDGE_PRIV		13
-#define INT_GPIO_BANK1		14
-#define INT_UART3		15
-#define INT_TIMER3		16
-#define INT_DMA_CH0_6		19
-#define INT_DMA_CH1_7		20
-#define INT_DMA_CH2_8		21
-#define INT_DMA_CH3		22
-#define INT_DMA_CH4		23
-#define INT_DMA_CH5		24
-#define INT_TIMER1		26
-#define INT_WD_TIMER		27
-#define INT_BRIDGE_PUB		28
-#define INT_TIMER2		30
-#define INT_LCD_CTRL		31
+#define INT_CAMERA		(NR_IRQS_LEGACY + 1)
+#define INT_FIQ			(NR_IRQS_LEGACY + 3)
+#define INT_RTDX		(NR_IRQS_LEGACY + 6)
+#define INT_DSP_MMU_ABORT	(NR_IRQS_LEGACY + 7)
+#define INT_HOST		(NR_IRQS_LEGACY + 8)
+#define INT_ABORT		(NR_IRQS_LEGACY + 9)
+#define INT_BRIDGE_PRIV		(NR_IRQS_LEGACY + 13)
+#define INT_GPIO_BANK1		(NR_IRQS_LEGACY + 14)
+#define INT_UART3		(NR_IRQS_LEGACY + 15)
+#define INT_TIMER3		(NR_IRQS_LEGACY + 16)
+#define INT_DMA_CH0_6		(NR_IRQS_LEGACY + 19)
+#define INT_DMA_CH1_7		(NR_IRQS_LEGACY + 20)
+#define INT_DMA_CH2_8		(NR_IRQS_LEGACY + 21)
+#define INT_DMA_CH3		(NR_IRQS_LEGACY + 22)
+#define INT_DMA_CH4		(NR_IRQS_LEGACY + 23)
+#define INT_DMA_CH5		(NR_IRQS_LEGACY + 24)
+#define INT_TIMER1		(NR_IRQS_LEGACY + 26)
+#define INT_WD_TIMER		(NR_IRQS_LEGACY + 27)
+#define INT_BRIDGE_PUB		(NR_IRQS_LEGACY + 28)
+#define INT_TIMER2		(NR_IRQS_LEGACY + 30)
+#define INT_LCD_CTRL		(NR_IRQS_LEGACY + 31)
 
 /*
  * OMAP-1510 specific IRQ numbers for interrupt handler 1
  */
-#define INT_1510_IH2_IRQ	0
-#define INT_1510_RES2		2
-#define INT_1510_SPI_TX		4
-#define INT_1510_SPI_RX		5
-#define INT_1510_DSP_MAILBOX1	10
-#define INT_1510_DSP_MAILBOX2	11
-#define INT_1510_RES12		12
-#define INT_1510_LB_MMU		17
-#define INT_1510_RES18		18
-#define INT_1510_LOCAL_BUS	29
+#define INT_1510_IH2_IRQ	(NR_IRQS_LEGACY + 0)
+#define INT_1510_RES2		(NR_IRQS_LEGACY + 2)
+#define INT_1510_SPI_TX		(NR_IRQS_LEGACY + 4)
+#define INT_1510_SPI_RX		(NR_IRQS_LEGACY + 5)
+#define INT_1510_DSP_MAILBOX1	(NR_IRQS_LEGACY + 10)
+#define INT_1510_DSP_MAILBOX2	(NR_IRQS_LEGACY + 11)
+#define INT_1510_RES12		(NR_IRQS_LEGACY + 12)
+#define INT_1510_LB_MMU		(NR_IRQS_LEGACY + 17)
+#define INT_1510_RES18		(NR_IRQS_LEGACY + 18)
+#define INT_1510_LOCAL_BUS	(NR_IRQS_LEGACY + 29)
 
 /*
  * OMAP-1610 specific IRQ numbers for interrupt handler 1
  */
 #define INT_1610_IH2_IRQ	INT_1510_IH2_IRQ
-#define INT_1610_IH2_FIQ	2
-#define INT_1610_McBSP2_TX	4
-#define INT_1610_McBSP2_RX	5
-#define INT_1610_DSP_MAILBOX1	10
-#define INT_1610_DSP_MAILBOX2	11
-#define INT_1610_LCD_LINE	12
-#define INT_1610_GPTIMER1	17
-#define INT_1610_GPTIMER2	18
-#define INT_1610_SSR_FIFO_0	29
+#define INT_1610_IH2_FIQ	(NR_IRQS_LEGACY + 2)
+#define INT_1610_McBSP2_TX	(NR_IRQS_LEGACY + 4)
+#define INT_1610_McBSP2_RX	(NR_IRQS_LEGACY + 5)
+#define INT_1610_DSP_MAILBOX1	(NR_IRQS_LEGACY + 10)
+#define INT_1610_DSP_MAILBOX2	(NR_IRQS_LEGACY + 11)
+#define INT_1610_LCD_LINE	(NR_IRQS_LEGACY + 12)
+#define INT_1610_GPTIMER1	(NR_IRQS_LEGACY + 17)
+#define INT_1610_GPTIMER2	(NR_IRQS_LEGACY + 18)
+#define INT_1610_SSR_FIFO_0	(NR_IRQS_LEGACY + 29)
 
 /*
  * OMAP-7xx specific IRQ numbers for interrupt handler 1
  */
-#define INT_7XX_IH2_FIQ		0
-#define INT_7XX_IH2_IRQ		1
-#define INT_7XX_USB_NON_ISO	2
-#define INT_7XX_USB_ISO		3
-#define INT_7XX_ICR		4
-#define INT_7XX_EAC		5
-#define INT_7XX_GPIO_BANK1	6
-#define INT_7XX_GPIO_BANK2	7
-#define INT_7XX_GPIO_BANK3	8
-#define INT_7XX_McBSP2TX	10
-#define INT_7XX_McBSP2RX	11
-#define INT_7XX_McBSP2RX_OVF	12
-#define INT_7XX_LCD_LINE	14
-#define INT_7XX_GSM_PROTECT	15
-#define INT_7XX_TIMER3		16
-#define INT_7XX_GPIO_BANK5	17
-#define INT_7XX_GPIO_BANK6	18
-#define INT_7XX_SPGIO_WR	29
+#define INT_7XX_IH2_FIQ		(NR_IRQS_LEGACY + 0)
+#define INT_7XX_IH2_IRQ		(NR_IRQS_LEGACY + 1)
+#define INT_7XX_USB_NON_ISO	(NR_IRQS_LEGACY + 2)
+#define INT_7XX_USB_ISO		(NR_IRQS_LEGACY + 3)
+#define INT_7XX_ICR		(NR_IRQS_LEGACY + 4)
+#define INT_7XX_EAC		(NR_IRQS_LEGACY + 5)
+#define INT_7XX_GPIO_BANK1	(NR_IRQS_LEGACY + 6)
+#define INT_7XX_GPIO_BANK2	(NR_IRQS_LEGACY + 7)
+#define INT_7XX_GPIO_BANK3	(NR_IRQS_LEGACY + 8)
+#define INT_7XX_McBSP2TX	(NR_IRQS_LEGACY + 10)
+#define INT_7XX_McBSP2RX	(NR_IRQS_LEGACY + 11)
+#define INT_7XX_McBSP2RX_OVF	(NR_IRQS_LEGACY + 12)
+#define INT_7XX_LCD_LINE	(NR_IRQS_LEGACY + 14)
+#define INT_7XX_GSM_PROTECT	(NR_IRQS_LEGACY + 15)
+#define INT_7XX_TIMER3		(NR_IRQS_LEGACY + 16)
+#define INT_7XX_GPIO_BANK5	(NR_IRQS_LEGACY + 17)
+#define INT_7XX_GPIO_BANK6	(NR_IRQS_LEGACY + 18)
+#define INT_7XX_SPGIO_WR	(NR_IRQS_LEGACY + 29)
 
 /*
  * IRQ numbers for interrupt handler 2
  *
  * NOTE: See also the OMAP-1510 and 1610 specific IRQ numbers below
  */
-#define IH2_BASE		32
+#define IH2_BASE		(NR_IRQS_LEGACY + 32)
 
 #define INT_KEYBOARD		(1 + IH2_BASE)
 #define INT_uWireTX		(2 + IH2_BASE)
@@ -255,11 +255,7 @@
 #endif
 #define OMAP_FPGA_IRQ_END	(OMAP_FPGA_IRQ_BASE + OMAP_FPGA_NR_IRQS)
 
-#define NR_IRQS			OMAP_FPGA_IRQ_END
-
-#define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
-
-#include <mach/hardware.h>
+#define OMAP_IRQ_BIT(irq)	(1 << ((irq - NR_IRQS_LEGACY) % 32))
 
 #ifdef CONFIG_FIQ
 #define FIQ_START		1024
diff --git a/arch/arm/mach-omap1/include/mach/soc.h b/arch/arm/mach-omap1/include/mach/soc.h
index 612bd1cc..3d93557 100644
--- a/arch/arm/mach-omap1/include/mach/soc.h
+++ b/arch/arm/mach-omap1/include/mach/soc.h
@@ -28,6 +28,10 @@
 #ifndef __ASM_ARCH_OMAP_CPU_H
 #define __ASM_ARCH_OMAP_CPU_H
 
+#include <asm/irq.h>
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index 567fba3..f4d346f 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -233,6 +233,7 @@ void __init omap1_init_irq(void)
 		irq_base = 0;
 	}
 	omap_l2_irq = cpu_is_omap7xx() ? irq_base + 1 : irq_base;
+	omap_l2_irq -= NR_IRQS_LEGACY;
 
 	domain = irq_domain_add_legacy(NULL, nr_irqs, irq_base, 0,
 				       &irq_domain_simple_ops, NULL);
diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
index bde7a35..06c5ba7 100644
--- a/arch/arm/mach-omap1/timer.c
+++ b/arch/arm/mach-omap1/timer.c
@@ -27,10 +27,10 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/dmtimer-omap.h>
 
-#include <mach/irqs.h>
-
 #include <plat/dmtimer.h>
 
+#include "soc.h"
+
 #define OMAP1610_GPTIMER1_BASE		0xfffb1400
 #define OMAP1610_GPTIMER2_BASE		0xfffb1c00
 #define OMAP1610_GPTIMER3_BASE		0xfffb2400
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 6416e03..1e460b4 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -38,6 +38,10 @@
 
 #include <linux/omap-dma.h>
 
+#ifdef CONFIG_ARCH_OMAP1
+#include <mach/soc.h>
+#endif
+
 /*
  * MAX_LOGICAL_DMA_CH_COUNT: the maximum number of logical DMA
  * channels that an instance of the SDMA IP block can support.  Used
-- 
2.1.4

