From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] arm: omap1: fix ams-delta FIQ handler to work with sparse IRQ
Date: Thu, 16 Jun 2016 21:56:30 +0200
Message-ID: <1466106990-9556-1-git-send-email-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

After OMAP1 IRQ definitions have been changed by commit 685e2d08c54b
("ARM: OMAP1: Change interrupt numbering for sparse IRQ") introduced
in v4.2, ams-delta FIQ handler which depends on them no longer works
as expected. Fix it.

Created and tested on Amstrad Delta against Linux-4.7-rc3

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/ams-delta-fiq-handler.S      | 6 +++---
 arch/arm/mach-omap1/ams-delta-fiq.c              | 5 +++--
 arch/arm/mach-omap1/include/mach/ams-delta-fiq.h | 2 ++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index 5d7fb59..bf60844 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -43,8 +43,8 @@
 #define OTHERS_MASK			(MODEM_IRQ_MASK | HOOK_SWITCH_MASK)
 
 /* IRQ handler register bitmasks */
-#define DEFERRED_FIQ_MASK		(0x1 << (INT_DEFERRED_FIQ % IH2_BASE))
-#define GPIO_BANK1_MASK  		(0x1 << INT_GPIO_BANK1)
+#define DEFERRED_FIQ_MASK		OMAP_IRQ_BIT(INT_DEFERRED_FIQ)
+#define GPIO_BANK1_MASK  		OMAP_IRQ_BIT(INT_GPIO_BANK1)
 
 /* Driver buffer byte offsets */
 #define BUF_MASK			(FIQ_MASK * 4)
@@ -110,7 +110,7 @@ ENTRY(qwerty_fiqin_start)
 	mov r8, #2				@ reset FIQ agreement
 	str r8, [r12, #IRQ_CONTROL_REG_OFFSET]
 
-	cmp r10, #INT_GPIO_BANK1		@ is it GPIO bank interrupt?
+	cmp r10, #(INT_GPIO_BANK1 - NR_IRQS_LEGACY)	@ is it GPIO interrupt?
 	beq gpio				@ yes - process it
 
 	mov r8, #1
diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index d1f1209..ec760ae 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -109,7 +109,8 @@ void __init ams_delta_init_fiq(void)
 	 * Since no set_type() method is provided by OMAP irq chip,
 	 * switch to edge triggered interrupt type manually.
 	 */
-	offset = IRQ_ILR0_REG_OFFSET + INT_DEFERRED_FIQ * 0x4;
+	offset = IRQ_ILR0_REG_OFFSET +
+			((INT_DEFERRED_FIQ - NR_IRQS_LEGACY) & 0x1f) * 0x4;
 	val = omap_readl(DEFERRED_FIQ_IH_BASE + offset) & ~(1 << 1);
 	omap_writel(val, DEFERRED_FIQ_IH_BASE + offset);
 
@@ -149,7 +150,7 @@ void __init ams_delta_init_fiq(void)
 	/*
 	 * Redirect GPIO interrupts to FIQ
 	 */
-	offset = IRQ_ILR0_REG_OFFSET + INT_GPIO_BANK1 * 0x4;
+	offset = IRQ_ILR0_REG_OFFSET + (INT_GPIO_BANK1 - NR_IRQS_LEGACY) * 0x4;
 	val = omap_readl(OMAP_IH1_BASE + offset) | 1;
 	omap_writel(val, OMAP_IH1_BASE + offset);
 }
diff --git a/arch/arm/mach-omap1/include/mach/ams-delta-fiq.h b/arch/arm/mach-omap1/include/mach/ams-delta-fiq.h
index adb5e76..6dfc3e1 100644
--- a/arch/arm/mach-omap1/include/mach/ams-delta-fiq.h
+++ b/arch/arm/mach-omap1/include/mach/ams-delta-fiq.h
@@ -14,6 +14,8 @@
 #ifndef __AMS_DELTA_FIQ_H
 #define __AMS_DELTA_FIQ_H
 
+#include <mach/irqs.h>
+
 /*
  * Interrupt number used for passing control from FIQ to IRQ.
  * IRQ12, described as reserved, has been selected.
-- 
2.7.3
