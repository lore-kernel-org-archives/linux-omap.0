From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 2/3] ARM: OMAP3: Fix secure sram saving
Date: Thu, 26 Mar 2009 15:59:00 +0200
Message-ID: <1238075941-24931-3-git-send-email-kalle.jokiniemi@digia.com>
References: <>
 <1238075941-24931-1-git-send-email-kalle.jokiniemi@digia.com>
 <1238075941-24931-2-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:7711 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755020AbZCZOQE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Mar 2009 10:16:04 -0400
In-Reply-To: <1238075941-24931-2-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Jouni Hogander <jouni.hogander@nokia.com>

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
 arch/arm/plat-omap/dma.c        |   22 ++++++++++++++++++----
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c21d4e9..7bbbcce 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -144,9 +144,6 @@ static void omap3_save_secure_ram_context(u32 target_mpu_state)
 	u32 ret;
 
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
-		/* Disable dma irq before calling secure rom code API */
-		omap_dma_disable_irq(0);
-		omap_dma_disable_irq(1);
 		/*
 		 * MPU next state must be set to POWER_ON temporarily,
 		 * otherwise the WFI executed inside the ROM code
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 33ee85b..0a58c30 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -138,7 +138,7 @@ save_secure_ram_debug:
 	mov	r0, #25			@ set service ID for PPA
 	mov	r12, r0			@ copy secure service ID in r12
 	mov	r1, #0			@ set task id for ROM code in r1
-	mov	r2, #7			@ set some flags in r2, r6
+	mov	r2, #4			@ set some flags in r2, r6
 	mov	r6, #0xff
 	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
 	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 94b3e4d..a040dbc 100755
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2322,14 +2322,21 @@ EXPORT_SYMBOL(omap_dma_global_context_save);
 
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
+	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP)) {
+		dma_write(0x3 , IRQSTATUS_L0);
+	}
 }
 EXPORT_SYMBOL(omap_dma_global_context_restore);
 
@@ -2465,8 +2472,8 @@ static int __init omap_init_dma(void)
 	if (cpu_class_is_omap2())
 		setup_irq(INT_24XX_SDMA_IRQ0, &omap24xx_dma_irq);
 
-	/* Enable smartidle idlemodes and autoidle */
 	if (cpu_is_omap34xx()) {
+		/* Enable smartidle idlemodes and autoidle */
 		u32 v = dma_read(OCP_SYSCONFIG);
 		v &= ~(DMA_SYSCONFIG_MIDLEMODE_MASK |
 				DMA_SYSCONFIG_SIDLEMODE_MASK |
@@ -2475,6 +2482,13 @@ static int __init omap_init_dma(void)
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
1.5.4.3

