From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 9/9] omap4: Use irq line defines from irq-44xx.h
Date: Thu, 18 Feb 2010 14:29:14 +0530
Message-ID: <1266483554-15044-9-git-send-email-santosh.shilimkar@ti.com>
References: <1266483554-15044-1-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-2-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-3-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-4-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-5-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-6-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-7-git-send-email-santosh.shilimkar@ti.com>
 <1266483554-15044-8-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60070 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776Ab0BRI7g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 03:59:36 -0500
In-Reply-To: <1266483554-15044-8-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch removes all the omap4 specific irq line
defines from plat/irqs.h and includes auto-generated
irqs-44xx.h
All the legacy naming style defines are replaced with the one
from irqs-44xx.h

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/devices.c           |    8 ++--
 arch/arm/mach-omap2/include/mach/irqs.h |    1 +
 arch/arm/mach-omap2/timer-mpu.c         |    2 +-
 arch/arm/plat-omap/devices.c            |    4 +-
 arch/arm/plat-omap/dma.c                |    2 +-
 arch/arm/plat-omap/dmtimer.c            |   24 ++++----
 arch/arm/plat-omap/gpio.c               |   12 ++--
 arch/arm/plat-omap/include/plat/irqs.h  |   89 -------------------------------
 8 files changed, 27 insertions(+), 115 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c104d5c..23e4d77 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -191,7 +191,7 @@ static struct resource omap4_mbox_resources[] = {
 		.flags          = IORESOURCE_MEM,
 	},
 	{
-		.start          = INT_44XX_MAIL_U0_MPU,
+		.start          = OMAP44XX_IRQ_MAIL_U0,
 		.flags          = IORESOURCE_IRQ,
 	},
 };
@@ -720,13 +720,13 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 			if (!cpu_is_omap44xx())
 				return;
 			base = OMAP4_MMC4_BASE + OMAP4_MMC_REG_OFFSET;
-			irq = INT_44XX_MMC4_IRQ;
+			irq = OMAP44XX_IRQ_MMC4;
 			break;
 		case 4:
 			if (!cpu_is_omap44xx())
 				return;
 			base = OMAP4_MMC5_BASE + OMAP4_MMC_REG_OFFSET;
-			irq = INT_44XX_MMC5_IRQ;
+			irq = OMAP44XX_IRQ_MMC4;
 			break;
 		default:
 			continue;
@@ -738,7 +738,7 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 		} else if (cpu_is_omap44xx()) {
 			if (i < 3) {
 				base += OMAP4_MMC_REG_OFFSET;
-				irq += IRQ_GIC_START;
+				irq += OMAP44XX_IRQ_GIC_START;
 			}
 			size = OMAP4_HSMMC_SIZE;
 			name = "mmci-omap-hs";
diff --git a/arch/arm/mach-omap2/include/mach/irqs.h b/arch/arm/mach-omap2/include/mach/irqs.h
index 44dab77..573d03e 100644
--- a/arch/arm/mach-omap2/include/mach/irqs.h
+++ b/arch/arm/mach-omap2/include/mach/irqs.h
@@ -3,3 +3,4 @@
  */
 
 #include <plat/irqs.h>
+#include "irqs-44xx.h"
diff --git a/arch/arm/mach-omap2/timer-mpu.c b/arch/arm/mach-omap2/timer-mpu.c
index c1a650a..954682e 100644
--- a/arch/arm/mach-omap2/timer-mpu.c
+++ b/arch/arm/mach-omap2/timer-mpu.c
@@ -28,7 +28,7 @@
  */
 void __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
-	evt->irq = INT_44XX_LOCALTIMER_IRQ;
+	evt->irq = OMAP44XX_IRQ_LOCALTIMER;
 	twd_timer_setup(evt);
 }
 
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 3a3e357..4a4cd87 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -205,8 +205,8 @@ static struct resource mcpdm_resources[] = {
 	},
 	{
 		.name		= "mcpdm_irq",
-		.start		= INT_44XX_MCPDM_IRQ,
-		.end		= INT_44XX_MCPDM_IRQ,
+		.start		= OMAP44XX_IRQ_MCPDM,
+		.end		= OMAP44XX_IRQ_MCPDM,
 		.flags		= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 049165c..2ab224c 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2132,7 +2132,7 @@ static int __init omap_init_dma(void)
 	if (cpu_class_is_omap2()) {
 		int irq;
 		if (cpu_is_omap44xx())
-			irq = INT_44XX_SDMA_IRQ0;
+			irq = OMAP44XX_IRQ_SDMA_0;
 		else
 			irq = INT_24XX_SDMA_IRQ0;
 		setup_irq(irq, &omap24xx_dma_irq);
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 24bf692..4d99dfb 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -250,18 +250,18 @@ static const int omap3_dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
 
 #ifdef CONFIG_ARCH_OMAP4
 static struct omap_dm_timer omap4_dm_timers[] = {
-	{ .phys_base = 0x4a318000, .irq = INT_44XX_GPTIMER1 },
-	{ .phys_base = 0x48032000, .irq = INT_44XX_GPTIMER2 },
-	{ .phys_base = 0x48034000, .irq = INT_44XX_GPTIMER3 },
-	{ .phys_base = 0x48036000, .irq = INT_44XX_GPTIMER4 },
-	{ .phys_base = 0x40138000, .irq = INT_44XX_GPTIMER5 },
-	{ .phys_base = 0x4013a000, .irq = INT_44XX_GPTIMER6 },
-	{ .phys_base = 0x4013a000, .irq = INT_44XX_GPTIMER7 },
-	{ .phys_base = 0x4013e000, .irq = INT_44XX_GPTIMER8 },
-	{ .phys_base = 0x4803e000, .irq = INT_44XX_GPTIMER9 },
-	{ .phys_base = 0x48086000, .irq = INT_44XX_GPTIMER10 },
-	{ .phys_base = 0x48088000, .irq = INT_44XX_GPTIMER11 },
-	{ .phys_base = 0x4a320000, .irq = INT_44XX_GPTIMER12 },
+	{ .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1 },
+	{ .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2 },
+	{ .phys_base = 0x48034000, .irq = OMAP44XX_IRQ_GPT3 },
+	{ .phys_base = 0x48036000, .irq = OMAP44XX_IRQ_GPT4 },
+	{ .phys_base = 0x40138000, .irq = OMAP44XX_IRQ_GPT5 },
+	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT6 },
+	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT7 },
+	{ .phys_base = 0x4013e000, .irq = OMAP44XX_IRQ_GPT8 },
+	{ .phys_base = 0x4803e000, .irq = OMAP44XX_IRQ_GPT9 },
+	{ .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10 },
+	{ .phys_base = 0x48088000, .irq = OMAP44XX_IRQ_GPT11 },
+	{ .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12 },
 };
 static const char *omap4_dm_source_names[] __initdata = {
 	"sys_ck",
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 6055028..337199e 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -312,17 +312,17 @@ static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
 
 #ifdef CONFIG_ARCH_OMAP4
 static struct gpio_bank gpio_bank_44xx[6] = {
-	{ OMAP44XX_GPIO1_BASE, NULL, INT_44XX_GPIO_BANK1, IH_GPIO_BASE,
+	{ OMAP44XX_GPIO1_BASE, NULL, OMAP44XX_IRQ_GPIO1, IH_GPIO_BASE,
 		METHOD_GPIO_44XX },
-	{ OMAP44XX_GPIO2_BASE, NULL, INT_44XX_GPIO_BANK2, IH_GPIO_BASE + 32,
+	{ OMAP44XX_GPIO2_BASE, NULL, OMAP44XX_IRQ_GPIO2, IH_GPIO_BASE + 32,
 		METHOD_GPIO_44XX },
-	{ OMAP44XX_GPIO3_BASE, NULL, INT_44XX_GPIO_BANK3, IH_GPIO_BASE + 64,
+	{ OMAP44XX_GPIO3_BASE, NULL, OMAP44XX_IRQ_GPIO3, IH_GPIO_BASE + 64,
 		METHOD_GPIO_44XX },
-	{ OMAP44XX_GPIO4_BASE, NULL, INT_44XX_GPIO_BANK4, IH_GPIO_BASE + 96,
+	{ OMAP44XX_GPIO4_BASE, NULL, OMAP44XX_IRQ_GPIO4, IH_GPIO_BASE + 96,
 		METHOD_GPIO_44XX },
-	{ OMAP44XX_GPIO5_BASE, NULL, INT_44XX_GPIO_BANK5, IH_GPIO_BASE + 128,
+	{ OMAP44XX_GPIO5_BASE, NULL, OMAP44XX_IRQ_GPIO5, IH_GPIO_BASE + 128,
 		METHOD_GPIO_44XX },
-	{ OMAP44XX_GPIO6_BASE, NULL, INT_44XX_GPIO_BANK6, IH_GPIO_BASE + 160,
+	{ OMAP44XX_GPIO6_BASE, NULL, OMAP44XX_IRQ_GPIO6, IH_GPIO_BASE + 160,
 		METHOD_GPIO_44XX },
 };
 
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index e8205c1..be470bd 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -355,95 +355,6 @@
 #define INT_35XX_CCDC_VD1_IRQ		92
 #define INT_35XX_CCDC_VD2_IRQ		93
 
-#define IRQ_GIC_START		32
-#define INT_44XX_LOCALTIMER_IRQ	29
-#define INT_44XX_LOCALWDT_IRQ	30
-
-#define INT_44XX_BENCH_MPU_EMUL	(3 + IRQ_GIC_START)
-#define INT_44XX_SSM_ABORT_IRQ	(6 + IRQ_GIC_START)
-#define INT_44XX_SYS_NIRQ	(7 + IRQ_GIC_START)
-#define INT_44XX_D2D_FW_IRQ	(8 + IRQ_GIC_START)
-#define INT_44XX_PRCM_MPU_IRQ	(11 + IRQ_GIC_START)
-#define INT_44XX_SDMA_IRQ0	(12 + IRQ_GIC_START)
-#define INT_44XX_SDMA_IRQ1	(13 + IRQ_GIC_START)
-#define INT_44XX_SDMA_IRQ2	(14 + IRQ_GIC_START)
-#define INT_44XX_SDMA_IRQ3	(15 + IRQ_GIC_START)
-#define INT_44XX_ISS_IRQ	(24 + IRQ_GIC_START)
-#define INT_44XX_DSS_IRQ	(25 + IRQ_GIC_START)
-#define INT_44XX_MAIL_U0_MPU	(26 + IRQ_GIC_START)
-#define INT_44XX_DSP_MMU	(28 + IRQ_GIC_START)
-#define INT_44XX_GPTIMER1	(37 + IRQ_GIC_START)
-#define INT_44XX_GPTIMER2	(38 + IRQ_GIC_START)
-#define INT_44XX_GPTIMER3	(39 + IRQ_GIC_START)
-#define INT_44XX_GPTIMER4	(40 + IRQ_GIC_START)
-#define INT_44XX_GPTIMER5	(41 + IRQ_GIC_START)
-#define INT_44XX_GPTIMER6	(42 + IRQ_GIC_START)
-#define INT_44XX_GPTIMER7	(43 + IRQ_GIC_START)
-#define INT_44XX_GPTIMER8	(44 + IRQ_GIC_START)
-#define INT_44XX_GPTIMER9	(45 + IRQ_GIC_START)
-#define INT_44XX_GPTIMER10	(46 + IRQ_GIC_START)
-#define INT_44XX_GPTIMER11	(47 + IRQ_GIC_START)
-#define INT_44XX_GPTIMER12	(95 + IRQ_GIC_START)
-#define INT_44XX_SHA1MD5	(51 + IRQ_GIC_START)
-#define INT_44XX_I2C1_IRQ	(56 + IRQ_GIC_START)
-#define INT_44XX_I2C2_IRQ	(57 + IRQ_GIC_START)
-#define INT_44XX_HDQ_IRQ	(58 + IRQ_GIC_START)
-#define INT_44XX_SPI1_IRQ	(65 + IRQ_GIC_START)
-#define INT_44XX_SPI2_IRQ	(66 + IRQ_GIC_START)
-#define INT_44XX_HSI_1_IRQ0	(67 + IRQ_GIC_START)
-#define INT_44XX_HSI_2_IRQ1	(68 + IRQ_GIC_START)
-#define INT_44XX_HSI_1_DMAIRQ	(71 + IRQ_GIC_START)
-#define INT_44XX_UART1_IRQ	(72 + IRQ_GIC_START)
-#define INT_44XX_UART2_IRQ	(73 + IRQ_GIC_START)
-#define INT_44XX_UART3_IRQ	(74 + IRQ_GIC_START)
-#define INT_44XX_UART4_IRQ	(70 + IRQ_GIC_START)
-#define INT_44XX_USB_IRQ_NISO	(76 + IRQ_GIC_START)
-#define INT_44XX_USB_IRQ_ISO	(77 + IRQ_GIC_START)
-#define INT_44XX_USB_IRQ_HGEN	(78 + IRQ_GIC_START)
-#define INT_44XX_USB_IRQ_HSOF	(79 + IRQ_GIC_START)
-#define INT_44XX_USB_IRQ_OTG	(80 + IRQ_GIC_START)
-#define INT_44XX_MCBSP4_IRQ_TX	(81 + IRQ_GIC_START)
-#define INT_44XX_MCBSP4_IRQ_RX	(82 + IRQ_GIC_START)
-#define INT_44XX_MMC_IRQ	(83 + IRQ_GIC_START)
-#define INT_44XX_MMC2_IRQ	(86 + IRQ_GIC_START)
-#define INT_44XX_MCBSP2_IRQ_TX	(89 + IRQ_GIC_START)
-#define INT_44XX_MCBSP2_IRQ_RX	(90 + IRQ_GIC_START)
-#define INT_44XX_SPI3_IRQ	(91 + IRQ_GIC_START)
-#define INT_44XX_SPI5_IRQ	(69 + IRQ_GIC_START)
-
-#define INT_44XX_MCBSP5_IRQ	(16 + IRQ_GIC_START)
-#define INT_44xX_MCBSP1_IRQ	(17 + IRQ_GIC_START)
-#define INT_44XX_MCBSP2_IRQ	(22 + IRQ_GIC_START)
-#define INT_44XX_MCBSP3_IRQ	(23 + IRQ_GIC_START)
-#define INT_44XX_MCBSP4_IRQ	(27 + IRQ_GIC_START)
-#define INT_44XX_HS_USB_MC	(92 + IRQ_GIC_START)
-#define INT_44XX_HS_USB_DMA	(93 + IRQ_GIC_START)
-
-#define INT_44XX_GPIO_BANK1	(29 + IRQ_GIC_START)
-#define INT_44XX_GPIO_BANK2	(30 + IRQ_GIC_START)
-#define INT_44XX_GPIO_BANK3	(31 + IRQ_GIC_START)
-#define INT_44XX_GPIO_BANK4	(32 + IRQ_GIC_START)
-#define INT_44XX_GPIO_BANK5	(33 + IRQ_GIC_START)
-#define INT_44XX_GPIO_BANK6	(34 + IRQ_GIC_START)
-#define INT_44XX_USIM_IRQ	(35 + IRQ_GIC_START)
-#define INT_44XX_WDT3_IRQ	(36 + IRQ_GIC_START)
-#define INT_44XX_SPI4_IRQ	(48 + IRQ_GIC_START)
-#define INT_44XX_SHA1MD52_IRQ	(49 + IRQ_GIC_START)
-#define INT_44XX_FPKA_READY_IRQ	(50 + IRQ_GIC_START)
-#define INT_44XX_SHA1MD51_IRQ	(51 + IRQ_GIC_START)
-#define INT_44XX_RNG_IRQ	(52 + IRQ_GIC_START)
-#define INT_44XX_MMC5_IRQ	(59 + IRQ_GIC_START)
-#define INT_44XX_I2C3_IRQ	(61 + IRQ_GIC_START)
-#define INT_44XX_FPKA_ERROR_IRQ	(64 + IRQ_GIC_START)
-#define INT_44XX_PBIAS_IRQ	(75 + IRQ_GIC_START)
-#define INT_44XX_OHCI_IRQ	(76 + IRQ_GIC_START)
-#define INT_44XX_EHCI_IRQ	(77 + IRQ_GIC_START)
-#define INT_44XX_TLL_IRQ	(78 + IRQ_GIC_START)
-#define INT_44XX_PARTHASH_IRQ	(79 + IRQ_GIC_START)
-#define INT_44XX_MMC3_IRQ	(94 + IRQ_GIC_START)
-#define INT_44XX_MMC4_IRQ	(96 + IRQ_GIC_START)
-#define INT_44XX_MCPDM_IRQ	(112 + IRQ_GIC_START)
-
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730/850) and
  * 16 MPUIO lines */
 #define OMAP_MAX_GPIO_LINES	192
-- 
1.6.0.4

