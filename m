From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/6] OMAP3: PRCM interrupt: only check and clear enabled PRCM IRQs
Date: Tue, 11 May 2010 16:47:06 -0700
Message-ID: <1273621631-9148-2-git-send-email-khilman@deeprootsystems.com>
References: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38417 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0EKXrS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:47:18 -0400
Received: by mail-vw0-f46.google.com with SMTP id 17so1655954vws.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 16:47:18 -0700 (PDT)
In-Reply-To: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

While handling PRCM IRQs, mask out interrupts that are not enabled in
PRM_IRQENABLE_MPU.  If these are not masked out, non-enabled
interrupts are caught, a WARN() is printed due to no 'handler' and the
events are cleared.  In addition to being noisy, this can also
interfere with independent polling of this register by SR/VP code.

This was noticed using SmartReflex transitions which cause the VPx_*
interrupts to be handled since they are set in PRM_IRQSTATUS_MPU even
but not enabled in PRM_IRQENABLE_MPU.

Acked-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ea0000b..a15aa92 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -267,13 +267,16 @@ static int _prcm_int_handle_wakeup(void)
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
+	irqstatus_mpu &= irqenable_mpu;
 
+	do {
 		if (irqstatus_mpu & (OMAP3430_WKUP_ST | OMAP3430_IO_ST)) {
 			c = _prcm_int_handle_wakeup();
 
@@ -292,7 +295,11 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 		prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
 					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
-	} while (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET));
+		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
+					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+		irqstatus_mpu &= irqenable_mpu;
+
+	} while (irqstatus_mpu);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.0.2

