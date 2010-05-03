From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/3] OMAP3: PRCM interrupt: only check and clear enabled PRCM IRQs
Date: Mon,  3 May 2010 14:41:10 -0700
Message-ID: <1272922871-18847-3-git-send-email-khilman@deeprootsystems.com>
References: <1272922871-18847-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:45892 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756680Ab0ECVlT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 17:41:19 -0400
Received: by mail-px0-f174.google.com with SMTP id 5so454018pxi.19
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 14:41:18 -0700 (PDT)
In-Reply-To: <1272922871-18847-1-git-send-email-khilman@deeprootsystems.com>
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
index fee2efb..c38016b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -266,13 +266,16 @@ static int _prcm_int_handle_wakeup(void)
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
 
@@ -291,7 +294,11 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
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

