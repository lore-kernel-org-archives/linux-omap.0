From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 12/28] OMAP: PM: DMA context save / restore
Date: Thu,  1 Oct 2009 16:58:42 -0700
Message-ID: <1254441538-9257-13-git-send-email-khilman@deeprootsystems.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:51872 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbZJAX7Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:59:16 -0400
Received: by mail-px0-f179.google.com with SMTP id 9so694314pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:21 -0700 (PDT)
In-Reply-To: <1254441538-9257-12-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c          |    3 +++
 arch/arm/plat-omap/dma.c              |   26 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/dma.h |    3 +++
 3 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1f238c3..4a6e264 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -34,6 +34,7 @@
 #include <mach/serial.h>
 #include <mach/sdrc.h>
 #include <mach/gpmc.h>
+#include <mach/dma.h>
 
 #include <asm/tlbflush.h>
 
@@ -95,6 +96,7 @@ static void omap3_core_save_context(void)
 	omap3_gpmc_save_context();
 	/* Save the system control module context, padconf already save above*/
 	omap3_control_save_context();
+	omap_dma_global_context_save();
 }
 
 static void omap3_core_restore_context(void)
@@ -105,6 +107,7 @@ static void omap3_core_restore_context(void)
 	omap3_gpmc_restore_context();
 	/* Restore the interrupt controller context */
 	omap3_intc_restore_context();
+	omap_dma_global_context_restore();
 }
 
 /*
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index fd3154a..160dff0 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -54,6 +54,12 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 
 static int enable_1510_mode;
 
+static struct omap_dma_global_context_registers {
+	u32 dma_irqenable_l0;
+	u32 dma_ocp_sysconfig;
+	u32 dma_gcr;
+} omap_dma_global_context;
+
 struct omap_dma_lch {
 	int next_lch;
 	int dev_id;
@@ -2340,6 +2346,26 @@ void omap_stop_lcd_dma(void)
 }
 EXPORT_SYMBOL(omap_stop_lcd_dma);
 
+void omap_dma_global_context_save(void)
+{
+	omap_dma_global_context.dma_irqenable_l0 =
+		dma_read(IRQENABLE_L0);
+	omap_dma_global_context.dma_ocp_sysconfig =
+		dma_read(OCP_SYSCONFIG);
+	omap_dma_global_context.dma_gcr = dma_read(GCR);
+}
+EXPORT_SYMBOL(omap_dma_global_context_save);
+
+void omap_dma_global_context_restore(void)
+{
+	dma_write(omap_dma_global_context.dma_gcr, GCR);
+	dma_write(omap_dma_global_context.dma_ocp_sysconfig,
+		OCP_SYSCONFIG);
+	dma_write(omap_dma_global_context.dma_irqenable_l0,
+		IRQENABLE_L0);
+}
+EXPORT_SYMBOL(omap_dma_global_context_restore);
+
 /*----------------------------------------------------------------------------*/
 
 static int __init omap_init_dma(void)
diff --git a/arch/arm/plat-omap/include/mach/dma.h b/arch/arm/plat-omap/include/mach/dma.h
index 72f680b..3f13331 100644
--- a/arch/arm/plat-omap/include/mach/dma.h
+++ b/arch/arm/plat-omap/include/mach/dma.h
@@ -633,6 +633,9 @@ extern void omap_set_dma_dst_endian_type(int lch, enum end_type etype);
 extern void omap_set_dma_src_endian_type(int lch, enum end_type etype);
 extern int omap_get_dma_index(int lch, int *ei, int *fi);
 
+void omap_dma_global_context_save(void);
+void omap_dma_global_context_restore(void);
+
 /* Chaining APIs */
 #ifndef CONFIG_ARCH_OMAP1
 extern int omap_request_dma_chain(int dev_id, const char *dev_name,
-- 
1.6.4.3

