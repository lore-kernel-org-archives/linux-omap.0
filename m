From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 08/10] OMAP2+: McBSP: hwmod adaptation for McBSP
Date: Tue, 21 Dec 2010 13:10:28 +0530
Message-ID: <1292917231-13800-8-git-send-email-kishon@ti.com>
References: <1292917231-13800-1-git-send-email-kishon@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43661 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757649Ab0LUHmD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Dec 2010 02:42:03 -0500
In-Reply-To: <1292917231-13800-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, p-basak2@ti.com, b-cousson@ti.com, kishon@ti.com, Charulatha V <charu@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>

Modify OMAP2+ McBSP to use omap hwmod framework APIs

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c |  703 ++++---------------------------------------
 1 files changed, 62 insertions(+), 641 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index ebc0db1..40d8f93 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -22,9 +22,12 @@
 #include <plat/dma.h>
 #include <plat/cpu.h>
 #include <plat/mcbsp.h>
+#include <plat/omap_device.h>
 
 #include "control.h"
 
+static struct omap_hwmod *oh_st_device[] = {NULL, NULL};
+static int no_of_st;
 
 /* McBSP internal signal muxing functions */
 
@@ -101,666 +104,84 @@ int omap2_mcbsp_set_clks_src(u8 id, u8 fck_src_id)
 }
 EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);
 
-/* Platform data */
-
-#ifdef CONFIG_ARCH_OMAP2420
-struct resource omap2420_mcbsp_res[][6] = {
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP24XX_MCBSP1_BASE,
-			.end   = OMAP24XX_MCBSP1_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP24XX_MCBSP1_BASE,
-			.end   = OMAP24XX_MCBSP1_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = INT_24XX_MCBSP1_IRQ_RX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = INT_24XX_MCBSP1_IRQ_TX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP24XX_DMA_MCBSP1_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP24XX_DMA_MCBSP1_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
+struct omap_device_pm_latency omap2_mcbsp_latency[] = {
 	{
-		{
-			.name  = "mpu",
-			.start = OMAP24XX_MCBSP2_BASE,
-			.end   = OMAP24XX_MCBSP2_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP24XX_MCBSP2_BASE,
-			.end   = OMAP24XX_MCBSP2_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = INT_24XX_MCBSP2_IRQ_RX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = INT_24XX_MCBSP2_IRQ_TX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP24XX_DMA_MCBSP2_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP24XX_DMA_MCBSP2_TX,
-			.flags = IORESOURCE_DMA,
-		},
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
 	},
 };
 
-#define OMAP2420_MCBSP_RES_SZ		ARRAY_SIZE(omap2420_mcbsp_res[1])
-#define OMAP2420_MCBSP_COUNT		ARRAY_SIZE(omap2420_mcbsp_res)
-#else
-#define omap2420_mcbsp_res		NULL
-#define OMAP2420_MCBSP_RES_SZ		0
-#define OMAP2420_MCBSP_COUNT		0
-#endif
-
-#define omap2420_mcbsp_pdata		NULL
-
-#ifdef CONFIG_ARCH_OMAP2430
-struct resource omap2430_mcbsp_res[][6] = {
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP24XX_MCBSP1_BASE,
-			.end   = OMAP24XX_MCBSP1_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP24XX_MCBSP1_BASE,
-			.end   = OMAP24XX_MCBSP1_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = INT_24XX_MCBSP1_IRQ_RX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = INT_24XX_MCBSP1_IRQ_TX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP24XX_DMA_MCBSP1_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP24XX_DMA_MCBSP1_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP24XX_MCBSP2_BASE,
-			.end   = OMAP24XX_MCBSP2_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP24XX_MCBSP2_BASE,
-			.end   = OMAP24XX_MCBSP2_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = INT_24XX_MCBSP2_IRQ_RX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = INT_24XX_MCBSP2_IRQ_TX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP24XX_DMA_MCBSP2_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP24XX_DMA_MCBSP2_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP2430_MCBSP3_BASE,
-			.end   = OMAP2430_MCBSP3_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP2430_MCBSP3_BASE,
-			.end   = OMAP2430_MCBSP3_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = INT_24XX_MCBSP3_IRQ_RX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = INT_24XX_MCBSP3_IRQ_TX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP24XX_DMA_MCBSP3_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP24XX_DMA_MCBSP3_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP2430_MCBSP4_BASE,
-			.end   = OMAP2430_MCBSP4_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP2430_MCBSP4_BASE,
-			.end   = OMAP2430_MCBSP4_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = INT_24XX_MCBSP4_IRQ_RX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = INT_24XX_MCBSP4_IRQ_TX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP24XX_DMA_MCBSP4_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP24XX_DMA_MCBSP4_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP2430_MCBSP5_BASE,
-			.end   = OMAP2430_MCBSP5_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP2430_MCBSP5_BASE,
-			.end   = OMAP2430_MCBSP5_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = INT_24XX_MCBSP5_IRQ_RX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = INT_24XX_MCBSP5_IRQ_TX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP24XX_DMA_MCBSP5_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP24XX_DMA_MCBSP5_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
-};
+static int omap_init_mcbsp(struct omap_hwmod *oh, void *unused)
+{
+	int id, count = 1, i;
+	char *name = "omap-mcbsp";
+	struct omap_hwmod *oh_device[2];
+	struct omap_mcbsp_platform_data *pdata = NULL;
+	struct omap_device *od;
 
-#define OMAP2430_MCBSP_RES_SZ		ARRAY_SIZE(omap2430_mcbsp_res[1])
-#define OMAP2430_MCBSP_COUNT		ARRAY_SIZE(omap2430_mcbsp_res)
-#else
-#define omap2430_mcbsp_res		NULL
-#define OMAP2430_MCBSP_RES_SZ		0
-#define OMAP2430_MCBSP_COUNT		0
-#endif
+	sscanf(oh->name, "mcbsp%d", &id);
 
-#define omap2430_mcbsp_pdata		NULL
+	pdata = kzalloc(sizeof(struct omap_mcbsp_platform_data), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s: No memory for mcbsp\n", __func__);
+		return -ENOMEM;
+	}
 
-#ifdef CONFIG_ARCH_OMAP3
-struct resource omap34xx_mcbsp_res[][7] = {
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP34XX_MCBSP1_BASE,
-			.end   = OMAP34XX_MCBSP1_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP34XX_MCBSP1_BASE,
-			.end   = OMAP34XX_MCBSP1_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = INT_24XX_MCBSP1_IRQ_RX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = INT_24XX_MCBSP1_IRQ_TX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP24XX_DMA_MCBSP1_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP24XX_DMA_MCBSP1_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP34XX_MCBSP2_BASE,
-			.end   = OMAP34XX_MCBSP2_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP34XX_MCBSP2_BASE,
-			.end   = OMAP34XX_MCBSP2_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "sidetone",
-			.start = OMAP34XX_MCBSP2_ST_BASE,
-			.end   = OMAP34XX_MCBSP2_ST_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = INT_24XX_MCBSP2_IRQ_RX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = INT_24XX_MCBSP2_IRQ_TX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP24XX_DMA_MCBSP2_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP24XX_DMA_MCBSP2_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP34XX_MCBSP3_BASE,
-			.end   = OMAP34XX_MCBSP3_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP34XX_MCBSP3_BASE,
-			.end   = OMAP34XX_MCBSP3_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "sidetone",
-			.start = OMAP34XX_MCBSP3_ST_BASE,
-			.end   = OMAP34XX_MCBSP3_ST_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = INT_24XX_MCBSP3_IRQ_RX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = INT_24XX_MCBSP3_IRQ_TX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP24XX_DMA_MCBSP3_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP24XX_DMA_MCBSP3_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP34XX_MCBSP4_BASE,
-			.end   = OMAP34XX_MCBSP4_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP34XX_MCBSP4_BASE,
-			.end   = OMAP34XX_MCBSP4_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = INT_24XX_MCBSP4_IRQ_RX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = INT_24XX_MCBSP4_IRQ_TX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP24XX_DMA_MCBSP4_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP24XX_DMA_MCBSP4_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP34XX_MCBSP5_BASE,
-			.end   = OMAP34XX_MCBSP5_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP34XX_MCBSP5_BASE,
-			.end   = OMAP34XX_MCBSP5_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = INT_24XX_MCBSP5_IRQ_RX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = INT_24XX_MCBSP5_IRQ_TX,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP24XX_DMA_MCBSP5_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP24XX_DMA_MCBSP5_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
-};
+	if (oh->class->rev == OMAP_MCBSP_CPU_3) {
+		if (id == 2)
+			pdata->buffer_size = 0x500; /*FIFO size is 1024 + 256*/
+		else
+			pdata->buffer_size = 0x80;  /*FIFO size is 128*/
+	}
 
-static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
-	{
-		.buffer_size	= 0x80, /* The FIFO has 128 locations */
-	},
-	{
-		.buffer_size	= 0x500, /* The FIFO has 1024 + 256 locations */
-	},
-	{
-		.buffer_size	= 0x80, /* The FIFO has 128 locations */
-	},
-	{
-		.buffer_size	= 0x80, /* The FIFO has 128 locations */
-	},
-	{
-		.buffer_size	= 0x80, /* The FIFO has 128 locations */
-	},
-};
-#define OMAP34XX_MCBSP_RES_SZ		ARRAY_SIZE(omap34xx_mcbsp_res[1])
-#define OMAP34XX_MCBSP_COUNT		ARRAY_SIZE(omap34xx_mcbsp_res)
-#else
-#define omap34xx_mcbsp_pdata		NULL
-#define omap34XX_mcbsp_res		NULL
-#define OMAP34XX_MCBSP_RES_SZ		0
-#define OMAP34XX_MCBSP_COUNT		0
-#endif
+	oh_device[0] = oh;
+
+	if (oh->dev_attr) {
+		for (i = 0; i < no_of_st ; i++) {
+			if (!strcmp(((struct omap_mcbsp_dev_attr *)
+						(oh->dev_attr))->sidetone,
+						oh_st_device[i]->name)) {
+				oh_device[1] = oh_st_device[i];
+				count++;
+			}
+		}
+	}
 
-struct resource omap44xx_mcbsp_res[][6] = {
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP44XX_MCBSP1_BASE,
-			.end   = OMAP44XX_MCBSP1_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP44XX_MCBSP1_DMA_BASE,
-			.end   = OMAP44XX_MCBSP1_DMA_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = 0,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP44XX_IRQ_MCBSP1,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP44XX_DMA_MCBSP1_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP44XX_DMA_MCBSP1_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP44XX_MCBSP2_BASE,
-			.end   = OMAP44XX_MCBSP2_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP44XX_MCBSP2_DMA_BASE,
-			.end   = OMAP44XX_MCBSP2_DMA_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = 0,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP44XX_IRQ_MCBSP2,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP44XX_DMA_MCBSP2_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP44XX_DMA_MCBSP2_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP44XX_MCBSP3_BASE,
-			.end   = OMAP44XX_MCBSP3_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP44XX_MCBSP3_DMA_BASE,
-			.end   = OMAP44XX_MCBSP3_DMA_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = 0,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP44XX_IRQ_MCBSP3,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP44XX_DMA_MCBSP3_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP44XX_DMA_MCBSP3_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
-	{
-		{
-			.name  = "mpu",
-			.start = OMAP44XX_MCBSP4_BASE,
-			.end   = OMAP44XX_MCBSP4_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "dma",
-			.start = OMAP44XX_MCBSP4_BASE,
-			.end   = OMAP44XX_MCBSP4_BASE + SZ_256,
-			.flags = IORESOURCE_MEM,
-		},
-		{
-			.name  = "rx",
-			.start = 0,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP44XX_IRQ_MCBSP4,
-			.flags = IORESOURCE_IRQ,
-		},
-		{
-			.name  = "rx",
-			.start = OMAP44XX_DMA_MCBSP4_RX,
-			.flags = IORESOURCE_DMA,
-		},
-		{
-			.name  = "tx",
-			.start = OMAP44XX_DMA_MCBSP4_TX,
-			.flags = IORESOURCE_DMA,
-		},
-	},
-};
+	od = omap_device_build_ss(name, id, oh_device, count, pdata,
+				sizeof(*pdata), omap2_mcbsp_latency,
+				ARRAY_SIZE(omap2_mcbsp_latency), false);
+	kfree(pdata);
+	if (IS_ERR(od))  {
+		pr_err("%s: Cant build omap_device for %s:%s.\n", __func__,
+					name, oh->name);
+		return PTR_ERR(od);
+	}
+	omap_mcbsp_count++;
+	return 0;
+}
 
-#define omap44xx_mcbsp_pdata		NULL
-#define OMAP44XX_MCBSP_RES_SZ		ARRAY_SIZE(omap44xx_mcbsp_res[1])
-#define OMAP44XX_MCBSP_COUNT		ARRAY_SIZE(omap44xx_mcbsp_res)
+static int omap_mcbsp_st(struct omap_hwmod *oh, void *user)
+{
+	if (!oh) {
+		pr_err("%s:NULL hwmod pointer (oh)\n", __func__);
+		return -EINVAL;
+	}
+	oh_st_device[no_of_st++] = oh;
+	return 0;
+}
 
 static int __init omap2_mcbsp_init(void)
 {
-	if (cpu_is_omap2420())
-		omap_mcbsp_count = OMAP2420_MCBSP_COUNT;
-	else if (cpu_is_omap2430())
-		omap_mcbsp_count = OMAP2430_MCBSP_COUNT;
-	else if (cpu_is_omap34xx())
-		omap_mcbsp_count = OMAP34XX_MCBSP_COUNT;
-	else if (cpu_is_omap44xx())
-		omap_mcbsp_count = OMAP44XX_MCBSP_COUNT;
+	omap_hwmod_for_each_by_class("mcbsp_sidetone", omap_mcbsp_st,
+					NULL);
+	omap_hwmod_for_each_by_class("mcbsp", omap_init_mcbsp, NULL);
 
 	mcbsp_ptr = kzalloc(omap_mcbsp_count * sizeof(struct omap_mcbsp *),
 								GFP_KERNEL);
 	if (!mcbsp_ptr)
 		return -ENOMEM;
 
-	if (cpu_is_omap2420())
-		omap_mcbsp_register_board_cfg(omap2420_mcbsp_res[0],
-					OMAP2420_MCBSP_RES_SZ,
-					omap2420_mcbsp_pdata,
-					OMAP2420_MCBSP_COUNT);
-	if (cpu_is_omap2430())
-		omap_mcbsp_register_board_cfg(omap2430_mcbsp_res[0],
-					OMAP2420_MCBSP_RES_SZ,
-					omap2430_mcbsp_pdata,
-					OMAP2430_MCBSP_COUNT);
-	if (cpu_is_omap34xx())
-		omap_mcbsp_register_board_cfg(omap34xx_mcbsp_res[0],
-					OMAP34XX_MCBSP_RES_SZ,
-					omap34xx_mcbsp_pdata,
-					OMAP34XX_MCBSP_COUNT);
-	if (cpu_is_omap44xx())
-		omap_mcbsp_register_board_cfg(omap44xx_mcbsp_res[0],
-					OMAP44XX_MCBSP_RES_SZ,
-					omap44xx_mcbsp_pdata,
-					OMAP44XX_MCBSP_COUNT);
-
 	return omap_mcbsp_init();
 }
 arch_initcall(omap2_mcbsp_init);
-- 
1.7.0.4

