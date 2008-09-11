From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 22/29] DMA context save / restore
Date: Thu, 11 Sep 2008 15:34:06 +0300
Message-ID: <1221136453-16697-22-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-10-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-11-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-12-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-13-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-14-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-15-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-16-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-17-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-18-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-19-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-20-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-21-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18980 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbYIKMez (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:55 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BCYQwI018071
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 15:34:52 +0300
In-Reply-To: <1221136453-16697-21-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c     |    3 +++
 arch/arm/plat-omap/dma.c              |   26 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/dma.h |    3 +++
 3 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 11ff573..c970a06 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -30,6 +30,7 @@
 #include <mach/gpio.h>
 #include <mach/gpmc.h>
 #include <mach/control.h>
+#include <mach/dma.h>
 #include <linux/sched.h>
 #include "cpuidle34xx.h"
 #include "cm.h"
@@ -392,6 +393,7 @@ void omap3_save_core_ctx(void)
 	omap_save_gpmc_ctx();
 	/* Save the system control module context, padconf already save above*/
 	omap_save_control_ctx();
+	omap_dma_global_context_save();
 }
 
 void omap3_restore_core_ctx(void)
@@ -402,6 +404,7 @@ void omap3_restore_core_ctx(void)
 	omap_restore_gpmc_ctx();
 	/* Restore the interrupt controller context */
 	omap_restore_intc_ctx();
+	omap_dma_global_context_restore();
 	padconf_saved = 0;
 }
 
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index eaea12a..38c57ce 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -51,6 +51,12 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 
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
@@ -2291,6 +2297,26 @@ void omap_stop_lcd_dma(void)
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
index 54fe966..f1f588a 100644
--- a/arch/arm/plat-omap/include/mach/dma.h
+++ b/arch/arm/plat-omap/include/mach/dma.h
@@ -528,6 +528,9 @@ extern void omap_set_dma_dst_endian_type(int lch, enum end_type etype);
 extern void omap_set_dma_src_endian_type(int lch, enum end_type etype);
 extern int omap_get_dma_index(int lch, int *ei, int *fi);
 
+void omap_dma_global_context_save(void);
+void omap_dma_global_context_restore(void);
+
 /* Chaining APIs */
 #ifndef CONFIG_ARCH_OMAP1
 extern int omap_request_dma_chain(int dev_id, const char *dev_name,
-- 
1.6.0

