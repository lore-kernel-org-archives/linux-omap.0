From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH] OMAP3: PM: Prevent hang in prcm_interrupt handler
Date: Fri, 17 Jul 2009 17:44:47 -0500
Message-ID: <1247870687-27149-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44006 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757950AbZGQWrT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jul 2009 18:47:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, linux-omap@vger.kernel.org
Cc: jon-hunter@ti.com, Vikram Pandita <vikram.pandita@ti.com>

There are two scenarios where a race condition could result in a hang in the
prcm_interrupt handler:

1) Waiting for PRM_IRQSTATUS_MPU register to clear.
Bit 0 of the PRM_IRQSTATUS_MPU register indicates that a wake-up event is
pending for the MPU. This bit can only be cleared if the all the wake-up events
latched in the various PM_WKST_x registers have been cleared. If a wake-up event
occurred during the processing of the prcm interrupt handler, after the
corresponding PM_WKST_x register was checked but before the PRM_IRQSTATUS_MPU
was cleared, then the CPU would be stuck forever waiting for bit 0 in
PRM_IRQSTATUS_MPU to be cleared.

2) Waiting for the PM_WKST_x register to clear.
Some power domains have more than one wake-up source. The PM_WKST_x registers
indicate the source of a wake-up event and need to be cleared after a wake-up
event occurs. When the PM_WKST_x registers are read and before they are cleared,
it is possible that another wake-up event could occur causing another bit to be
set in one of the PM_WKST_x registers. If this did occur after reading a
PM_WKST_x register then the CPU would miss this event and get stuck forever in
a loop waiting for that PM_WKST_x register to clear.

This patch address the above race conditions that would result in a hang.

Adapted from a version posted by Jon Hunter:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg13786.html

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
cc: Hunter, Jon <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 4cbeff1..ce34ac1 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -200,6 +200,10 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 	u32 wkst, irqstatus_mpu;
 	u32 fclk, iclk;
 
+restart:
+	fclk = 0;
+	iclk = 0;
+
 	/* WKUP */
 	wkst = prm_read_mod_reg(WKUP_MOD, PM_WKST);
 	if (wkst) {
@@ -285,8 +289,11 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 	prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
 			  OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
-	while (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET))
-		cpu_relax();
+	/* In case another wakep happend while in this handler,
+	 * restart the clearing process
+	 */
+	if (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET))
+		goto restart;
 
 	return IRQ_HANDLED;
 }
-- 
1.6.3.3.334.g916e1

