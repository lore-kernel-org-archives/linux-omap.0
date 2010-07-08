From: Manjunatha GK <manjugk@ti.com>
Subject: [RFC PATCH 04/10] OMAP4: DMA: HWMOD: update OMAP4 data base
Date: Fri,  9 Jul 2010 04:21:16 +0530
Message-ID: <1278629482-32501-5-git-send-email-manjugk@ti.com>
References: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59498 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758730Ab0GHWyQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jul 2010 18:54:16 -0400
In-Reply-To: <1278629482-32501-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

The OMAP4 hwmod data base is updated with DMA controller attributes.

Also, irq name are changed from 0 to dma_0, 1->dma_1 ... in order provide
meaningful name to irq names.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 20f5f8c..46d83f5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,6 +22,9 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
+#include <plat/dma.h>
+
+#include <mach/dma.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -750,12 +753,19 @@ static struct omap_hwmod_class omap44xx_dma_hwmod_class = {
 	.sysc = &omap44xx_dma_sysc,
 };
 
+/* dma attributes */
+static struct omap_dma_dev_attr dma_dev_attr = {
+	.dma_dev_attr = DMA_LINKED_LCH | GLOBAL_PRIORITY |
+				IS_CSSA_32 | IS_CDSA_32,
+	.dma_lch_count = OMAP_DMA4_LOGICAL_DMA_CH_COUNT,
+};
+
 /* dma_system */
 static struct omap_hwmod_irq_info omap44xx_dma_system_irqs[] = {
-	{ .name = "0", .irq = 12 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "1", .irq = 13 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "2", .irq = 14 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "3", .irq = 15 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "dma_0", .irq = 12 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "dma_1", .irq = 13 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "dma_2", .irq = 14 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "dma_3", .irq = 15 + OMAP44XX_IRQ_GIC_START },
 };
 
 static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] = {
@@ -801,6 +811,7 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dma_system_slaves),
 	.masters	= omap44xx_dma_system_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_dma_system_masters),
+	.dev_attr	= &dma_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -4789,7 +4800,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	/* counter class */
 	&omap44xx_counter_32k_hwmod,
 	/* dma class */
-/*	&omap44xx_dma_system_hwmod, */
+	&omap44xx_dma_system_hwmod,
 	/* dmic class */
 /*	&omap44xx_dmic_hwmod, */
 	/* dsp class */
-- 
1.7.0.4

