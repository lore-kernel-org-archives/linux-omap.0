From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 4/9] OMAP: Add new function to check wether there is irq pending
Date: Fri, 16 May 2008 13:57:15 +0300
Message-ID: <1210935435-27617-1-git-send-email-jouni.hogander@nokia.com>
References: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46170 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbYEPK5U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 06:57:20 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GAv9Y4010512
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 13:57:18 +0300
In-Reply-To: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

Add common omap2/3 function to check wether there is irq pending.
Switch to use it in omap2 pm code instead of its own.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/irq.c        |   29 +++++++++++++++++++++++------
 arch/arm/mach-omap2/pm24xx.c     |   19 +++----------------
 include/asm-arm/arch-omap/irqs.h |    1 +
 3 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index ac062ee..f1e1e2e 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -20,12 +20,13 @@
 
 /* selected INTC register offsets */
 
-#define INTC_REVISION	0x0000
-#define INTC_SYSCONFIG	0x0010
-#define INTC_SYSSTATUS	0x0014
-#define INTC_CONTROL	0x0048
-#define INTC_MIR_CLEAR0	0x0088
-#define INTC_MIR_SET0	0x008c
+#define INTC_REVISION		0x0000
+#define INTC_SYSCONFIG		0x0010
+#define INTC_SYSSTATUS		0x0014
+#define INTC_CONTROL		0x0048
+#define INTC_MIR_CLEAR0		0x0088
+#define INTC_MIR_SET0		0x008c
+#define INTC_PENDING_IRQ0	0x0098
 
 /*
  * OMAP2 has a number of different interrupt controllers, each interrupt
@@ -122,6 +123,22 @@ static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
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
 	unsigned long nr_irqs = 0;
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 7bb654f..8636f1c 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -74,19 +74,6 @@ static int omap2_fclks_active(void)
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
 	u32 l, sleep_time = 0;
@@ -121,7 +108,7 @@ static void omap2_enter_full_retention(void)
 
 	/* One last check for pending IRQs to avoid extra latency due
 	 * to sleeping unnecessarily. */
-	if (omap2_irq_pending())
+	if (omap_irq_pending())
 		goto no_sleep;
 
 	serial_console_sleep(1);
@@ -272,7 +259,7 @@ static void omap2_pm_idle(void)
 		 */
 		if (atomic_read(&sleep_block) == 0) {
 			timer_dyn_reprogram();
-			if (omap2_irq_pending())
+			if (omap_irq_pending())
 				goto out;
 		}
 		omap2_enter_mpu_retention();
@@ -286,7 +273,7 @@ static void omap2_pm_idle(void)
 	 */
 	timer_dyn_reprogram();
 
-	if (omap2_irq_pending())
+	if (omap_irq_pending())
 		goto out;
 
 	omap2_enter_full_retention();
diff --git a/include/asm-arm/arch-omap/irqs.h b/include/asm-arm/arch-omap/irqs.h
index c80e160..343e93e 100644
--- a/include/asm-arm/arch-omap/irqs.h
+++ b/include/asm-arm/arch-omap/irqs.h
@@ -368,6 +368,7 @@
 
 #ifndef __ASSEMBLY__
 extern void omap_init_irq(void);
+extern int omap_irq_pending(void);
 #endif
 
 #include <asm/hardware.h>
-- 
1.5.5

