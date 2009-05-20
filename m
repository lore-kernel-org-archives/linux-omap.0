From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 03/13] OMAP: Add new function to check wether there is irq pending
Date: Wed, 20 May 2009 16:19:26 -0700
Message-ID: <1242861576-13008-4-git-send-email-khilman@deeprootsystems.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-3-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:58170 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757425AbZETXTr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:19:47 -0400
Received: by pzk7 with SMTP id 7so340439pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 16:19:49 -0700 (PDT)
In-Reply-To: <1242861576-13008-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

From: Jouni Hogander <jouni.hogander@nokia.com>

Add common omap2/3 function to check wether there is irq pending.
Switch to use it in omap2 pm code instead of its own.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/irq.c              |   17 ++++++++++++++++-
 arch/arm/mach-omap2/pm24xx.c           |   19 +++----------------
 arch/arm/plat-omap/include/mach/irqs.h |    1 +
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 08a3b99..b828638 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -28,7 +28,6 @@
 #define INTC_MIR_CLEAR0		0x0088
 #define INTC_MIR_SET0		0x008c
 #define INTC_PENDING_IRQ0	0x0098
-
 /* Number of IRQ state bits in each MIR register */
 #define IRQ_BITS_PER_REG	32
 
@@ -156,6 +155,22 @@ static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
 	intc_bank_write_reg(1 << 0, bank, INTC_SYSCONFIG);
 }
 
+int omap_irq_pending(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
+		struct omap_irq_bank *bank = irq_banks + i;
+		int irq;
+
+		for (irq = 0; irq < bank->nr_irqs; irq += 32)
+			if (intc_bank_read_reg(bank, INTC_PENDING_IRQ0 +
+					       ((irq >> 5) << 5)))
+				return 1;
+	}
+	return 0;
+}
+
 void __init omap_init_irq(void)
 {
 	unsigned long nr_of_irqs = 0;
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 384a5b5..3fa9c7c 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -77,19 +77,6 @@ static int omap2_fclks_active(void)
 	return 0;
 }
 
-static int omap2_irq_pending(void)
-{
-	u32 pending_reg = 0x480fe098;
-	int i;
-
-	for (i = 0; i < 4; i++) {
-		if (omap_readl(pending_reg))
-			return 1;
-		pending_reg += 0x20;
-	}
-	return 0;
-}
-
 static void omap2_enter_full_retention(void)
 {
 	u32 l;
@@ -128,7 +115,7 @@ static void omap2_enter_full_retention(void)
 
 	/* One last check for pending IRQs to avoid extra latency due
 	 * to sleeping unnecessarily. */
-	if (omap2_irq_pending())
+	if (omap_irq_pending())
 		goto no_sleep;
 
 	/* Jump to SRAM suspend code */
@@ -265,13 +252,13 @@ static void omap2_pm_idle(void)
 	local_fiq_disable();
 
 	if (!omap2_can_sleep()) {
-		if (omap2_irq_pending())
+		if (omap_irq_pending())
 			goto out;
 		omap2_enter_mpu_retention();
 		goto out;
 	}
 
-	if (omap2_irq_pending())
+	if (omap_irq_pending())
 		goto out;
 
 	omap2_enter_full_retention();
diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
index 7f57ee6..f5f7c92 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -467,6 +467,7 @@
 
 #ifndef __ASSEMBLY__
 extern void omap_init_irq(void);
+extern int omap_irq_pending(void);
 #endif
 
 #include <mach/hardware.h>
-- 
1.6.2.2

