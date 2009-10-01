From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 13/28] OMAP: PM: off-mode support for DMA on EMU/HS devices
Date: Thu,  1 Oct 2009 16:58:43 -0700
Message-ID: <1254441538-9257-14-git-send-email-khilman@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-4-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-5-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-6-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-7-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-8-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-9-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-10-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-11-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-12-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-13-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:58920 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbZJAX7S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:59:18 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so574597pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:22 -0700 (PDT)
In-Reply-To: <1254441538-9257-13-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

- DMA interrupt disable routine added
- Added DMA controller reset to DMA context restore

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/plat-omap/dma.c              |   15 +++++++++++++++
 arch/arm/plat-omap/include/mach/dma.h |    2 ++
 2 files changed, 17 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 arch/arm/plat-omap/include/mach/dma.h

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 160dff0..77e4ce2 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2358,6 +2358,9 @@ EXPORT_SYMBOL(omap_dma_global_context_save);
 
 void omap_dma_global_context_restore(void)
 {
+	dma_write(0x2, OCP_SYSCONFIG);
+	while (!__raw_readl(omap_dma_base + OMAP_DMA4_SYSSTATUS))
+		;
 	dma_write(omap_dma_global_context.dma_gcr, GCR);
 	dma_write(omap_dma_global_context.dma_ocp_sysconfig,
 		OCP_SYSCONFIG);
@@ -2366,6 +2369,18 @@ void omap_dma_global_context_restore(void)
 }
 EXPORT_SYMBOL(omap_dma_global_context_restore);
 
+void omap_dma_disable_irq(int lch)
+{
+	u32 val;
+
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
index 3f13331..1c017b2
--- a/arch/arm/plat-omap/include/mach/dma.h
+++ b/arch/arm/plat-omap/include/mach/dma.h
@@ -636,6 +636,8 @@ extern int omap_get_dma_index(int lch, int *ei, int *fi);
 void omap_dma_global_context_save(void);
 void omap_dma_global_context_restore(void);
 
+extern void omap_dma_disable_irq(int lch);
+
 /* Chaining APIs */
 #ifndef CONFIG_ARCH_OMAP1
 extern int omap_request_dma_chain(int dev_id, const char *dev_name,
-- 
1.6.4.3

