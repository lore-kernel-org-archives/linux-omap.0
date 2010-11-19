From: Madhusudhan Gowda <ext-madhusudhan.1.gowda@nokia.com>
Subject: [PATCH] OMAP3: PM: PRCM interrupt: Fix warning "MPU wakeup but no wakeup sources"
Date: Fri, 19 Nov 2010 13:26:33 +0200
Message-ID: <1290165993-23847-1-git-send-email-ext-madhusudhan.1.gowda@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:23466 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091Ab0KSLhb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 06:37:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, Madhusudhan Gowda <ext-madhusudhan.1.gowda@nokia.com>

A corner case where prcm_interrupt handler is handling the WKST_WKUP and
before acknowledging the wakeup sources if an IO Pad wakeup ST_IO is
indicated then hits the below warning since the wakeup sources are already
cleared.
	WARN(c == 0, "prcm: WARNING: PRCM indicated "
		"MPU wakeup but no wakeup sources "
		"are marked\n");

Since the above warning condition is only valid if the prcm_interrupt
handler is called but no wakeup sources are marked in first iteration.

The patch fixes this corner case.

Updated after Paul Walmsley's "only handle selected PRCM interrupts" patch.

Signed-off-by: Madhusudhan Gowda <ext-madhusudhan.1.gowda@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 75c0cd1..d9a35d7 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -266,6 +266,7 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 {
 	u32 irqenable_mpu, irqstatus_mpu;
 	int c = 0;
+	int ct = 0;
 
 	irqenable_mpu = prm_read_mod_reg(OCP_MOD,
 					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
@@ -277,13 +278,16 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 		if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
 				     OMAP3430_IO_ST_MASK)) {
 			c = _prcm_int_handle_wakeup();
+			ct++;
 
 			/*
 			 * Is the MPU PRCM interrupt handler racing with the
 			 * IVA2 PRCM interrupt handler ?
 			 */
-			WARN(c == 0, "prcm: WARNING: PRCM indicated MPU wakeup "
-			     "but no wakeup sources are marked\n");
+			if (ct == 1)
+				WARN(c == 0, "prcm: WARNING: PRCM indicated "
+					"MPU wakeup but no wakeup sources "
+					"are marked\n");
 		} else {
 			/* XXX we need to expand our PRCM interrupt handler */
 			WARN(1, "prcm: WARNING: PRCM interrupt received, but "
-- 
1.6.3.3

