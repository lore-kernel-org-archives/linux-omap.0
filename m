From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 1/6] Support for EMU/HS off-mode for DMA
Date: Tue, 14 Oct 2008 15:23:26 +0300
Message-ID: <1223987011-25667-2-git-send-email-tero.kristo@nokia.com>
References: <>
 <1223987011-25667-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33568 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616AbYJNKiJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 06:38:09 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9EAc6aH006407
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 13:38:07 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m9EAbjLt000373
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 13:37:47 +0300
In-Reply-To: <1223987011-25667-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

- DMA interrupt disable routine added
- Added DMA controller reset to DMA context restore

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/plat-omap/dma.c              |   14 ++++++++++++++
 arch/arm/plat-omap/include/mach/dma.h |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 arch/arm/plat-omap/dma.c
 mode change 100644 => 100755 arch/arm/plat-omap/include/mach/dma.h

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
old mode 100644
new mode 100755
index 38c57ce..4d4016f
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2309,6 +2309,9 @@ EXPORT_SYMBOL(omap_dma_global_context_save);
 
 void omap_dma_global_context_restore(void)
 {
+	dma_write(0x2, OCP_SYSCONFIG);
+	while (!__raw_readl(omap_dma_base + OMAP_DMA4_SYSSTATUS))
+		;
 	dma_write(omap_dma_global_context.dma_gcr, GCR);
 	dma_write(omap_dma_global_context.dma_ocp_sysconfig,
 		OCP_SYSCONFIG);
@@ -2317,6 +2320,17 @@ void omap_dma_global_context_restore(void)
 }
 EXPORT_SYMBOL(omap_dma_global_context_restore);
 
+void omap_dma_disable_irq(int lch)
+{
+	u32 val;
+	if (cpu_class_is_omap2()) {
+		/* Disable interrupts */
+		val = dma_read(IRQENABLE_L0);
+		val &= ~(1 << lch);
+		dma_write(val, IRQENABLE_L0);
+	}
+}
+
 /*----------------------------------------------------------------------------*/
 
 static int __init omap_init_dma(void)
diff --git a/arch/arm/plat-omap/include/mach/dma.h b/arch/arm/plat-omap/include/mach/dma.h
old mode 100644
new mode 100755
index f1f588a..1cd390d
--- a/arch/arm/plat-omap/include/mach/dma.h
+++ b/arch/arm/plat-omap/include/mach/dma.h
@@ -531,6 +531,8 @@ extern int omap_get_dma_index(int lch, int *ei, int *fi);
 void omap_dma_global_context_save(void);
 void omap_dma_global_context_restore(void);
 
+extern void omap_dma_disable_irq(int lch);
+
 /* Chaining APIs */
 #ifndef CONFIG_ARCH_OMAP1
 extern int omap_request_dma_chain(int dev_id, const char *dev_name,
-- 
1.5.4.3

