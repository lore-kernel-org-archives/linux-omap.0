From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] omap1: Use asm_irq_flags for entry-macro.S
Date: Fri, 03 Dec 2010 16:20:42 -0800
Message-ID: <20101204002042.28853.68092.stgit@baageli.muru.com>
References: <20101204001435.28853.29616.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40989 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448Ab0LDAUq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 19:20:46 -0500
In-Reply-To: <20101204001435.28853.29616.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Initialize asm_irq_flags in omap_init_irq and use it in
get_irqnr_and_base to detect between omap7xx and omap15xx/16xx.

Note that both INT_1510_IH2_IRQ and INT_1510_IH2_IRQ are defined
as 0, so use INT_1510_IH2_IRQ for both of them.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/entry-macro.S |   18 +++---------------
 arch/arm/mach-omap1/irq.c                      |    4 ++++
 arch/arm/plat-omap/include/plat/irqs.h         |    2 +-
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/entry-macro.S b/arch/arm/mach-omap1/include/mach/entry-macro.S
index df9060e..25b74f9 100644
--- a/arch/arm/mach-omap1/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap1/include/mach/entry-macro.S
@@ -14,20 +14,6 @@
 #include <mach/irqs.h>
 #include <asm/hardware/gic.h>
 
-#if (defined(CONFIG_ARCH_OMAP730)||defined(CONFIG_ARCH_OMAP850)) && \
-	(defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX))
-#error "FIXME: OMAP7XX doesn't support multiple-OMAP"
-#elif defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-#define INT_IH2_IRQ		INT_7XX_IH2_IRQ
-#elif defined(CONFIG_ARCH_OMAP15XX)
-#define INT_IH2_IRQ		INT_1510_IH2_IRQ
-#elif defined(CONFIG_ARCH_OMAP16XX)
-#define INT_IH2_IRQ		INT_1610_IH2_IRQ
-#else
-#warning "IH2 IRQ defaulted"
-#define INT_IH2_IRQ		INT_1510_IH2_IRQ
-#endif
-
  		.macro	disable_fiq
 		.endm
 
@@ -47,9 +33,11 @@
 		beq	1510f
 
 		ldr	\irqnr, [\base, #IRQ_SIR_FIQ_REG_OFFSET]
+		ldr	\tmp, =asm_irq_flags	@ irq flags address
+		ldr	\tmp, [\tmp, #0]	@ irq flags value
 		cmp	\irqnr, #0
 		ldreq	\irqnr, [\base, #IRQ_SIR_IRQ_REG_OFFSET]
-		cmpeq	\irqnr, #INT_IH2_IRQ
+		cmpeq	\irqnr, \tmp
 		ldreq	\base, =OMAP1_IO_ADDRESS(OMAP_IH2_BASE)
 		ldreq	\irqnr, [\base, #IRQ_SIR_IRQ_REG_OFFSET]
 		addeqs	\irqnr, \irqnr, #32
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index db913c3..e7f2166 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -180,22 +180,26 @@ void __init omap_init_irq(void)
 
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	if (cpu_is_omap7xx()) {
+		asm_irq_flags = INT_7XX_IH2_IRQ;
 		irq_banks = omap7xx_irq_banks;
 		irq_bank_count = ARRAY_SIZE(omap7xx_irq_banks);
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap1510()) {
+		asm_irq_flags = INT_1510_IH2_IRQ;
 		irq_banks = omap1510_irq_banks;
 		irq_bank_count = ARRAY_SIZE(omap1510_irq_banks);
 	}
 	if (cpu_is_omap310()) {
+		asm_irq_flags = INT_1510_IH2_IRQ;
 		irq_banks = omap310_irq_banks;
 		irq_bank_count = ARRAY_SIZE(omap310_irq_banks);
 	}
 #endif
 #if defined(CONFIG_ARCH_OMAP16XX)
 	if (cpu_is_omap16xx()) {
+		asm_irq_flags = INT_1510_IH2_IRQ;
 		irq_banks = omap1610_irq_banks;
 		irq_bank_count = ARRAY_SIZE(omap1610_irq_banks);
 	}
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 65e20a6..2910de9 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -77,7 +77,7 @@
 /*
  * OMAP-1610 specific IRQ numbers for interrupt handler 1
  */
-#define INT_1610_IH2_IRQ	0
+#define INT_1610_IH2_IRQ	INT_1510_IH2_IRQ
 #define INT_1610_IH2_FIQ	2
 #define INT_1610_McBSP2_TX	4
 #define INT_1610_McBSP2_RX	5

