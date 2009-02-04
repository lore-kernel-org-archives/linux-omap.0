From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 2/3] OMAP: Add new function to check wether there is irq pending
Date: Tue,  3 Feb 2009 18:03:48 -0800
Message-ID: <1233713029-14904-3-git-send-email-khilman@deeprootsystems.com>
References: <1233713029-14904-1-git-send-email-khilman@deeprootsystems.com>
 <1233713029-14904-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:16978 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbZBDCEE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 21:04:04 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2311725rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 03 Feb 2009 18:04:03 -0800 (PST)
In-Reply-To: <1233713029-14904-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

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
index 636e282..6d5b8c1 100644
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
index b3268c5..3e9ed3f 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -78,19 +78,6 @@ static int omap2_fclks_active(void)
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
@@ -129,7 +116,7 @@ static void omap2_enter_full_retention(void)
 
 	/* One last check for pending IRQs to avoid extra latency due
 	 * to sleeping unnecessarily. */
-	if (omap2_irq_pending())
+	if (omap_irq_pending())
 		goto no_sleep;
 
 	/* Jump to SRAM suspend code */
@@ -275,13 +262,13 @@ static void omap2_pm_idle(void)
 	local_fiq_disable();
 
 	if (!omap2_can_sleep()) {
-		if (!atomic_read(&sleep_block) && omap2_irq_pending())
+		if (!atomic_read(&sleep_block) && omap_irq_pending())
 			goto out;
 		omap2_enter_mpu_retention();
 		goto out;
 	}
 
-	if (omap2_irq_pending())
+	if (omap_irq_pending())
 		goto out;
 
 	omap2_enter_full_retention();
diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
index bed5274..990573f 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -386,6 +386,7 @@
 
 #ifndef __ASSEMBLY__
 extern void omap_init_irq(void);
+extern int omap_irq_pending(void);
 #endif
 
 #include <mach/hardware.h>
-- 
1.6.1

