From: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Subject: [PATCH] OMAP3: ack spurious IRQs in get_irqnr_and_base
Date: Wed, 15 Oct 2008 14:51:51 +0300
Message-ID: <1224071511-4670-1-git-send-email-lauri.leukkunen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58226 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbYJOLvj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 07:51:39 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9FBpI94010079
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 06:51:36 -0500
Received: from localhost.localdomain (pure.research.nokia.com [172.21.42.21])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m9FBpKPO000330
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 14:51:21 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This prevents spurious interrupts from repeating unacked and
thus locking the system, while still allowing the spurious
bad irq error message to be show on console.

Signed-off-by: Lauri Leukkunen <lauri.leukkunen@nokia.com>
---
 arch/arm/plat-omap/include/mach/entry-macro.S |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
index a8fca9d..c88a4cb 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -87,7 +87,26 @@
 		ldr	\irqnr, [\base, #0xd8] /* IRQ pending reg 3 */
 		cmp	\irqnr, #0x0
 2222:
-		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
+#if defined(CONFIG_ARCH_OMAP34XX)
+		mov	\tmp, \irqnr
+#endif
+ 		ldrne	\irqnr, [\base, #INTCPS_SIR_IRQ_OFFSET]
+#if defined(CONFIG_ARCH_OMAP34XX)
+		mov	\irqstat, \irqnr
+		bic	\irqstat, \irqstat, #0x7f /* check for spurious flag */
+		cmp	\irqstat, #0x0
+		beq	2223f
+		mov	\irqstat, #0x1 /* Ack the spurious irq, this lets it
+					* generate a bad irq error message,
+					* but prevents infinitely repeating
+					* irq.
+					*/
+		str	\irqstat, [\base, #0x48] /* INTC_CONTROL register */
+2223:
+		cmp	\tmp, #0x0 /* set conditional back to what it was
+				    * before spurious test
+				    */
+#endif
 
 		.endm
 
-- 
1.5.6.5

