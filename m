From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 20/28] OMAP3: PM: Fix secure SRAM context save/restore
Date: Thu,  1 Oct 2009 16:58:50 -0700
Message-ID: <1254441538-9257-21-git-send-email-khilman@deeprootsystems.com>
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
 <1254441538-9257-14-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-15-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-16-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-17-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-18-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-19-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-20-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:51872 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbZJAX7a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:59:30 -0400
Received: by mail-px0-f179.google.com with SMTP id 9so694314pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:34 -0700 (PDT)
In-Reply-To: <1254441538-9257-20-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Jouni Hogander <jouni.hogander@nokia.com>

From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

The secure sram context save uses dma channels 0 and 1.
In order to avoid collision between kernel DMA transfers and
ROM code dma transfers, we need to reserve DMA channels 0
1 on high security devices.

A bug in ROM code leaves dma irq status bits uncleared.
Hence those irq status bits need to be cleared when restoring
DMA context after off mode.

There was also a faulty parameter given to PPA in the secure
ram context save assembly code, which caused interrupts to
be enabled during secure ram context save. This caused the
save to fail sometimes, which resulted the saved context
to be corrupted, but also left DMA channels in secure mode.
The secure mode DMA channels caused "DMA secure error with
device 0" errors to be displayed.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c    |    3 ---
 arch/arm/mach-omap2/sleep34xx.S |    2 +-
 arch/arm/plat-omap/dma.c        |   21 +++++++++++++++++----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e58eebb..43225d7 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -131,9 +131,6 @@ static void omap3_save_secure_ram_context(u32 target_mpu_state)
 	u32 ret;
 
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
-		/* Disable dma irq before calling secure rom code API */
-		omap_dma_disable_irq(0);
-		omap_dma_disable_irq(1);
 		/*
 		 * MPU next state must be set to POWER_ON temporarily,
 		 * otherwise the WFI executed inside the ROM code
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index a099816..34a55f1 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -68,7 +68,7 @@ save_secure_ram_debug:
 	mov	r0, #25			@ set service ID for PPA
 	mov	r12, r0			@ copy secure service ID in r12
 	mov	r1, #0			@ set task id for ROM code in r1
-	mov	r2, #7			@ set some flags in r2, r6
+	mov	r2, #4			@ set some flags in r2, r6
 	mov	r6, #0xff
 	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
 	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 77e4ce2..b3e1f77 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2358,14 +2358,20 @@ EXPORT_SYMBOL(omap_dma_global_context_save);
 
 void omap_dma_global_context_restore(void)
 {
-	dma_write(0x2, OCP_SYSCONFIG);
-	while (!__raw_readl(omap_dma_base + OMAP_DMA4_SYSSTATUS))
-		;
 	dma_write(omap_dma_global_context.dma_gcr, GCR);
 	dma_write(omap_dma_global_context.dma_ocp_sysconfig,
 		OCP_SYSCONFIG);
 	dma_write(omap_dma_global_context.dma_irqenable_l0,
 		IRQENABLE_L0);
+
+	/*
+	 * A bug in ROM code leaves IRQ status for channels 0 and 1 uncleared
+	 * after secure sram context save and restore. Hence we need to
+	 * manually clear those IRQs to avoid spurious interrupts. This
+	 * affects only secure devices.
+	 */
+	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
+		dma_write(0x3 , IRQSTATUS_L0);
 }
 EXPORT_SYMBOL(omap_dma_global_context_restore);
 
@@ -2510,8 +2516,8 @@ static int __init omap_init_dma(void)
 		setup_irq(irq, &omap24xx_dma_irq);
 	}
 
-	/* Enable smartidle idlemodes and autoidle */
 	if (cpu_is_omap34xx()) {
+		/* Enable smartidle idlemodes and autoidle */
 		u32 v = dma_read(OCP_SYSCONFIG);
 		v &= ~(DMA_SYSCONFIG_MIDLEMODE_MASK |
 				DMA_SYSCONFIG_SIDLEMODE_MASK |
@@ -2520,6 +2526,13 @@ static int __init omap_init_dma(void)
 			DMA_SYSCONFIG_SIDLEMODE(DMA_IDLEMODE_SMARTIDLE) |
 			DMA_SYSCONFIG_AUTOIDLE);
 		dma_write(v , OCP_SYSCONFIG);
+		/* reserve dma channels 0 and 1 in high security devices */
+		if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
+			printk(KERN_INFO "Reserving DMA channels 0 and 1 for "
+					"HS ROM code\n");
+			dma_chan[0].dev_id = 0;
+			dma_chan[1].dev_id = 1;
+		}
 	}
 
 
-- 
1.6.4.3

