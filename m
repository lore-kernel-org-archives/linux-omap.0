From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH 05/11] OMAP4: DMA: HWMOD: update OMAP4 data base
Date: Thu, 29 Jul 2010 15:28:59 +0530
Message-ID: <1280397545-27323-6-git-send-email-manjugk@ti.com>
References: <1280397545-27323-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53202 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756405Ab0G2KBC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Jul 2010 06:01:02 -0400
In-Reply-To: <1280397545-27323-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Anand Sawant <sawant@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, Basak Partha <p-basak2@ti.com>, Charulatha V <charu@ti.com>

The OMAP4 hwmod data base is updated with DMA controller attributes.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 20f5f8c..ee589c5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,6 +22,7 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
+#include <plat/dma.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -750,12 +751,19 @@ static struct omap_hwmod_class omap44xx_dma_hwmod_class = {
 	.sysc = &omap44xx_dma_sysc,
 };
 
+/* dma attributes */
+static struct omap_dma_dev_attr dma_dev_attr = {
+	.dma_dev_attr = DMA_LINKED_LCH | GLOBAL_PRIORITY |
+				IS_CSSA_32 | IS_CDSA_32 | IS_RW_PRIORIY,
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
@@ -801,6 +809,7 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dma_system_slaves),
 	.masters	= omap44xx_dma_system_masters,
 	.masters_cnt	= ARRAY_SIZE(omap44xx_dma_system_masters),
+	.dev_attr	= &dma_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -4789,7 +4798,7 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
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

