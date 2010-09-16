From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 5/5] omap3: cm-t3517: add support for TI HECC
Date: Thu, 16 Sep 2010 10:54:41 +0200
Message-ID: <1284627281-26059-6-git-send-email-grinberg@compulab.co.il>
References: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:52557 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789Ab0IPIyx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 04:54:53 -0400
In-Reply-To: <1284627281-26059-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t3517.c |   45 ++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index d4399e7..ff927db 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -32,6 +32,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/can/platform/ti_hecc.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -44,6 +45,8 @@
 #include <plat/nand.h>
 #include <plat/gpmc.h>
 
+#include <mach/am35xx.h>
+
 #include "mux.h"
 
 #if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
@@ -77,6 +80,47 @@ static void __init cm_t3517_init_leds(void)
 static inline void cm_t3517_init_leds(void) {}
 #endif
 
+#if defined(CONFIG_CAN_TI_HECC) || defined(CONFIG_CAN_TI_HECC_MODULE)
+static struct resource cm_t3517_hecc_resources[] = {
+	{
+		.start	= AM35XX_IPSS_HECC_BASE,
+		.end	= AM35XX_IPSS_HECC_BASE + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_35XX_HECC0_IRQ,
+		.end	= INT_35XX_HECC0_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct ti_hecc_platform_data cm_t3517_hecc_pdata = {
+	.scc_hecc_offset	= AM35XX_HECC_SCC_HECC_OFFSET,
+	.scc_ram_offset		= AM35XX_HECC_SCC_RAM_OFFSET,
+	.hecc_ram_offset	= AM35XX_HECC_RAM_OFFSET,
+	.mbx_offset		= AM35XX_HECC_MBOX_OFFSET,
+	.int_line		= AM35XX_HECC_INT_LINE,
+	.version		= AM35XX_HECC_VERSION,
+};
+
+static struct platform_device cm_t3517_hecc_device = {
+	.name		= "ti_hecc",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(cm_t3517_hecc_resources),
+	.resource	= cm_t3517_hecc_resources,
+	.dev		= {
+		.platform_data	= &cm_t3517_hecc_pdata,
+	},
+};
+
+static void cm_t3517_init_hecc(void)
+{
+	platform_device_register(&cm_t3517_hecc_device);
+}
+#else
+static inline void cm_t3517_init_hecc(void) {}
+#endif
+
 #if defined(CONFIG_RTC_DRV_V3020) || defined(CONFIG_RTC_DRV_V3020_MODULE)
 #define RTC_IO_GPIO		(153)
 #define RTC_WR_GPIO		(154)
@@ -236,6 +280,7 @@ static void __init cm_t3517_init(void)
 	cm_t3517_init_nand();
 	cm_t3517_init_rtc();
 	cm_t3517_init_usbh();
+	cm_t3517_init_hecc();
 }
 
 MACHINE_START(CM_T3517, "Compulab CM-T3517")
-- 
1.7.1

