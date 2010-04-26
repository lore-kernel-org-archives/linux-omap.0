From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP3: PRCM interrupt: only check for enabled PRCM IRQs
Date: Mon, 26 Apr 2010 15:23:04 -0700
Message-ID: <1272320584-14244-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36549 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab0DZWXJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 18:23:09 -0400
Received: by vws13 with SMTP id 13so285013vws.19
        for <linux-omap@vger.kernel.org>; Mon, 26 Apr 2010 15:23:08 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

While handling PRCM IRQs, mask out interrupts that are not enabled in
PRM_IRQENABLE_MPU.  If these are not masked out,  non-enabled
interrupts are caught and a WARN() is dumped.

This was noticed using SmartReflex transitions which cause the VPx_*
interrupts to be handled since they are set in PRM_IRQSTATUS_MPU even
but not enabled in PRM_IRQENABLE_MPU.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
For review here, will be queued with other PM updates for 2.6.35.

 arch/arm/mach-omap2/pm34xx.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fee2efb..63d1843 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -266,13 +266,15 @@ static int _prcm_int_handle_wakeup(void)
  */
 static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 {
-	u32 irqstatus_mpu;
+	u32 irqenable_mpu, irqstatus_mpu;
 	int c = 0;
 
-	do {
-		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
-					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+	irqenable_mpu = prm_read_mod_reg(OCP_MOD,
+					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
+	irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
+					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
+	do {
 		if (irqstatus_mpu & (OMAP3430_WKUP_ST | OMAP3430_IO_ST)) {
 			c = _prcm_int_handle_wakeup();
 
@@ -291,7 +293,10 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 		prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
 					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
-	} while (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET));
+		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
+					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+		
+	} while (irqstatus_mpu & irqenable_mpu);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.0.2

