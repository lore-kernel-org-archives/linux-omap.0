From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 17/27] OMAP3: PM: Fix secure SRAM context save/restore
Date: Wed, 14 Oct 2009 14:58:00 -0700
Message-ID: <1255557490-16787-18-git-send-email-khilman@deeprootsystems.com>
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
	<1255557490-16787-13-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-14-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-15-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-16-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-17-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1255557490-16787-17-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Jouni Hogander <jouni.hogander@nokia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

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
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c    |    3 ---
 arch/arm/mach-omap2/sleep34xx.S |    2 +-
 arch/arm/plat-omap/dma.c        |   21 +++++++++++++++++----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9247639..93f5988 100644
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
index 4cb2aab..f911bfd 100644
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
