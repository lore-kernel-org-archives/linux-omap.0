From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 12/27] OMAP: PM: DMA context save/restore for off-mode support
Date: Wed, 14 Oct 2009 14:57:55 -0700
Message-ID: <1255557490-16787-13-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-9-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-10-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-11-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-12-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:49375 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761248AbZJNV7K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 17:59:10 -0400
Received: by pxi10 with SMTP id 10so23127pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 14 Oct 2009 14:58:33 -0700 (PDT)
In-Reply-To: <1255557490-16787-12-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

For HS/EMU devices, these additional features are also used:

- DMA interrupt disable routine added
- Added DMA controller reset to DMA context restore

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c          |    3 ++
 arch/arm/plat-omap/dma.c              |   41 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/dma.h |    5 ++++
 3 files changed, 49 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 arch/arm/plat-omap/include/mach/dma.h

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b1d90e5..764bf2c 100644
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
index 8227312..4cb2aab 100644
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
@@ -2340,6 +2346,41 @@ void omap_stop_lcd_dma(void)
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
+	dma_write(0x2, OCP_SYSCONFIG);
+	while (!__raw_readl(omap_dma_base + OMAP_DMA4_SYSSTATUS))
+		;
+	dma_write(omap_dma_global_context.dma_gcr, GCR);
+	dma_write(omap_dma_global_context.dma_ocp_sysconfig,
+		OCP_SYSCONFIG);
+	dma_write(omap_dma_global_context.dma_irqenable_l0,
+		IRQENABLE_L0);
+}
+EXPORT_SYMBOL(omap_dma_global_context_restore);
+
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
index 72f680b..1c017b2
--- a/arch/arm/plat-omap/include/mach/dma.h
+++ b/arch/arm/plat-omap/include/mach/dma.h
@@ -633,6 +633,11 @@ extern void omap_set_dma_dst_endian_type(int lch, enum end_type etype);
 extern void omap_set_dma_src_endian_type(int lch, enum end_type etype);
 extern int omap_get_dma_index(int lch, int *ei, int *fi);
 
+void omap_dma_global_context_save(void);
+void omap_dma_global_context_restore(void);
+
+extern void omap_dma_disable_irq(int lch);
+
 /* Chaining APIs */
 #ifndef CONFIG_ARCH_OMAP1
 extern int omap_request_dma_chain(int dev_id, const char *dev_name,
-- 
1.6.4.3

