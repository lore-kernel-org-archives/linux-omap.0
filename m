From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] ARM: omap1: Switch to use MULTI_IRQ
Date: Mon,  4 May 2015 12:52:21 -0700
Message-ID: <1430769142-3921-4-git-send-email-tony@atomide.com>
References: <1430769142-3921-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nov-007-i628.relay.mailchannels.net ([46.232.183.182]:24515
	"EHLO relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751830AbbEDTwj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2015 15:52:39 -0400
In-Reply-To: <1430769142-3921-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>

This allows us to get a bit further with SPARSE_IRQ and
MULTIARCH support.

Note that we now also rename omap_irq_flags to omap_l2_irq
as that's the omap_irq_flags naming is confusing. It just
contains the interrupt number for the l2 irq.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig                               |  1 +
 arch/arm/mach-omap1/board-ams-delta.c          |  1 +
 arch/arm/mach-omap1/board-fsample.c            |  1 +
 arch/arm/mach-omap1/board-generic.c            |  1 +
 arch/arm/mach-omap1/board-h2.c                 |  1 +
 arch/arm/mach-omap1/board-h3.c                 |  1 +
 arch/arm/mach-omap1/board-htcherald.c          |  1 +
 arch/arm/mach-omap1/board-innovator.c          |  1 +
 arch/arm/mach-omap1/board-nokia770.c           |  1 +
 arch/arm/mach-omap1/board-osk.c                |  1 +
 arch/arm/mach-omap1/board-palmte.c             |  1 +
 arch/arm/mach-omap1/board-palmtt.c             |  1 +
 arch/arm/mach-omap1/board-palmz71.c            |  1 +
 arch/arm/mach-omap1/board-perseus2.c           |  1 +
 arch/arm/mach-omap1/board-sx1.c                |  1 +
 arch/arm/mach-omap1/board-voiceblue.c          |  1 +
 arch/arm/mach-omap1/common.h                   |  5 ++--
 arch/arm/mach-omap1/include/mach/entry-macro.S | 39 -------------------------
 arch/arm/mach-omap1/irq.c                      | 40 ++++++++++++++++++++++----
 19 files changed, 53 insertions(+), 47 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/include/mach/entry-macro.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45df48b..881a76c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -752,6 +752,7 @@ config ARCH_OMAP1
 	select GENERIC_IRQ_CHIP
 	select HAVE_IDE
 	select IRQ_DOMAIN
+	select MULTI_IRQ_HANDLER
 	select NEED_MACH_IO_H if PCCARD
 	select NEED_MACH_MEMORY_H
 	help
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 2aab761..a95499e 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -626,6 +626,7 @@ MACHINE_START(AMS_DELTA, "Amstrad E3 (Delta)")
 	.map_io		= ams_delta_map_io,
 	.init_early	= omap1_init_early,
 	.init_irq	= omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine	= ams_delta_init,
 	.init_late	= ams_delta_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 702d580..0fb51d2 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -362,6 +362,7 @@ MACHINE_START(OMAP_FSAMPLE, "OMAP730 F-Sample")
 	.map_io		= omap_fsample_map_io,
 	.init_early	= omap1_init_early,
 	.init_irq	= omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine	= omap_fsample_init,
 	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index e1d9171..9708629 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -82,6 +82,7 @@ MACHINE_START(OMAP_GENERIC, "Generic OMAP1510/1610/1710")
 	.map_io		= omap16xx_map_io,
 	.init_early	= omap1_init_early,
 	.init_irq	= omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine	= omap_generic_init,
 	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 5b45d26..8340d68 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -426,6 +426,7 @@ MACHINE_START(OMAP_H2, "TI-H2")
 	.map_io		= omap16xx_map_io,
 	.init_early     = omap1_init_early,
 	.init_irq	= omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine	= h2_init,
 	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index bfed4f9..086ff34 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -452,6 +452,7 @@ MACHINE_START(OMAP_H3, "TI OMAP1710 H3 board")
 	.map_io		= omap16xx_map_io,
 	.init_early     = omap1_init_early,
 	.init_irq	= omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine	= h3_init,
 	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 35a2379..9525ef9 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -601,6 +601,7 @@ MACHINE_START(HERALD, "HTC Herald")
 	.map_io         = htcherald_map_io,
 	.init_early     = omap1_init_early,
 	.init_irq       = omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine   = htcherald_init,
 	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index c49ce83..ed4e045 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -456,6 +456,7 @@ MACHINE_START(OMAP_INNOVATOR, "TI-Innovator")
 	.map_io		= innovator_map_io,
 	.init_early     = omap1_init_early,
 	.init_irq	= omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine	= innovator_init,
 	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 85089d8..9f6c7af 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -294,6 +294,7 @@ MACHINE_START(NOKIA770, "Nokia 770")
 	.map_io		= omap16xx_map_io,
 	.init_early     = omap1_init_early,
 	.init_irq	= omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine	= omap_nokia770_init,
 	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 7436d4c..0efd165 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -610,6 +610,7 @@ MACHINE_START(OMAP_OSK, "TI-OSK")
 	.map_io		= omap16xx_map_io,
 	.init_early	= omap1_init_early,
 	.init_irq	= omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine	= osk_init,
 	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 3b8e98f..1142ae4 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -235,6 +235,7 @@ MACHINE_START(OMAP_PALMTE, "OMAP310 based Palm Tungsten E")
 	.map_io		= omap15xx_map_io,
 	.init_early     = omap1_init_early,
 	.init_irq	= omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine	= omap_palmte_init,
 	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index ca50120..54a547a 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -282,6 +282,7 @@ MACHINE_START(OMAP_PALMTT, "OMAP1510 based Palm Tungsten|T")
 	.map_io		= omap15xx_map_io,
 	.init_early     = omap1_init_early,
 	.init_irq	= omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine	= omap_palmtt_init,
 	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 470e12d..87ec04a 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -297,6 +297,7 @@ MACHINE_START(OMAP_PALMZ71, "OMAP310 based Palm Zire71")
 	.map_io		= omap15xx_map_io,
 	.init_early     = omap1_init_early,
 	.init_irq	= omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine	= omap_palmz71_init,
 	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 8b2f712..3d76f05 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -324,6 +324,7 @@ MACHINE_START(OMAP_PERSEUS2, "OMAP730 Perseus2")
 	.map_io		= omap_perseus2_map_io,
 	.init_early     = omap1_init_early,
 	.init_irq	= omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine	= omap_perseus2_init,
 	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 29e5262..939991e 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -343,6 +343,7 @@ MACHINE_START(SX1, "OMAP310 based Siemens SX1")
 	.map_io		= omap15xx_map_io,
 	.init_early     = omap1_init_early,
 	.init_irq	= omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine	= omap_sx1_init,
 	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 4677a9c..e960687 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -288,6 +288,7 @@ MACHINE_START(VOICEBLUE, "VoiceBlue OMAP5910")
 	.map_io		= omap15xx_map_io,
 	.init_early     = omap1_init_early,
 	.init_irq	= omap1_init_irq,
+	.handle_irq	= omap1_handle_irq,
 	.init_machine	= voiceblue_init,
 	.init_late	= omap1_init_late,
 	.init_time	= omap1_timer_init,
diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index 732f8ee..6363e0c 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -30,6 +30,8 @@
 #include <linux/i2c-omap.h>
 #include <linux/reboot.h>
 
+#include <asm/exception.h>
+
 #include <plat/i2c.h>
 
 #include <mach/irqs.h>
@@ -73,6 +75,7 @@ static inline int omap_serial_wakeup_init(void)
 
 void omap1_init_early(void);
 void omap1_init_irq(void);
+void __exception_irq_entry omap1_handle_irq(struct pt_regs *regs);
 void omap1_init_late(void);
 void omap1_restart(enum reboot_mode, const char *);
 
@@ -91,8 +94,6 @@ static inline int __init omap_32k_timer_init(void)
 }
 #endif
 
-extern u32 omap_irq_flags;
-
 #ifdef CONFIG_ARCH_OMAP16XX
 extern int ocpi_enable(void);
 #else
diff --git a/arch/arm/mach-omap1/include/mach/entry-macro.S b/arch/arm/mach-omap1/include/mach/entry-macro.S
deleted file mode 100644
index 78a8c6c..0000000
--- a/arch/arm/mach-omap1/include/mach/entry-macro.S
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * arch/arm/mach-omap1/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for OMAP-based platforms
- *
- * Copyright (C) 2009 Texas Instruments
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <mach/hardware.h>
-#include <mach/irqs.h>
-
-		.macro  get_irqnr_preamble, base, tmp
-		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\base, =OMAP1_IO_ADDRESS(OMAP_IH1_BASE)
-		ldr	\irqnr, [\base, #IRQ_ITR_REG_OFFSET]
-		ldr	\tmp, [\base, #IRQ_MIR_REG_OFFSET]
-		mov	\irqstat, #0xffffffff
-		bic	\tmp, \irqstat, \tmp
-		tst	\irqnr, \tmp
-		beq	1510f
-
-		ldr	\irqnr, [\base, #IRQ_SIR_FIQ_REG_OFFSET]
-		ldr	\tmp, =omap_irq_flags	@ irq flags address
-		ldr	\tmp, [\tmp, #0]	@ irq flags value
-		cmp	\irqnr, #0
-		ldreq	\irqnr, [\base, #IRQ_SIR_IRQ_REG_OFFSET]
-		cmpeq	\irqnr, \tmp
-		ldreq	\base, =OMAP1_IO_ADDRESS(OMAP_IH2_BASE)
-		ldreq	\irqnr, [\base, #IRQ_SIR_IRQ_REG_OFFSET]
-		addeqs	\irqnr, \irqnr, #32
-1510:
-		.endm
-
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index 3651b17..567fba3 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -43,6 +43,7 @@
 #include <linux/io.h>
 
 #include <asm/irq.h>
+#include <asm/exception.h>
 #include <asm/mach/irq.h>
 
 #include "soc.h"
@@ -61,7 +62,7 @@ struct omap_irq_bank {
 	unsigned long wake_enable;
 };
 
-u32 omap_irq_flags;
+static u32 omap_l2_irq;
 static unsigned int irq_bank_count;
 static struct omap_irq_bank *irq_banks;
 static struct irq_domain *domain;
@@ -140,6 +141,36 @@ static struct omap_irq_bank omap1610_irq_banks[] = {
 };
 #endif
 
+asmlinkage void __exception_irq_entry omap1_handle_irq(struct pt_regs *regs)
+{
+	void __iomem *l1 = irq_banks[0].va;
+	void __iomem *l2 = irq_banks[1].va;
+	u32 irqnr;
+
+	do {
+		irqnr = readl_relaxed(l1 + IRQ_ITR_REG_OFFSET);
+		irqnr &= ~(readl_relaxed(l1 + IRQ_MIR_REG_OFFSET) & 0xffffffff);
+		if (!irqnr)
+			break;
+
+		irqnr = readl_relaxed(l1 + IRQ_SIR_FIQ_REG_OFFSET);
+		if (irqnr)
+			goto irq;
+
+		irqnr = readl_relaxed(l1 + IRQ_SIR_IRQ_REG_OFFSET);
+		if (irqnr == omap_l2_irq) {
+			irqnr = readl_relaxed(l2 + IRQ_SIR_IRQ_REG_OFFSET);
+			if (irqnr)
+				irqnr += 32;
+		}
+irq:
+		if (irqnr)
+			handle_domain_irq(domain, irqnr, regs);
+		else
+			break;
+	} while (irqnr);
+}
+
 static __init void
 omap_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 {
@@ -167,26 +198,22 @@ void __init omap1_init_irq(void)
 
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 	if (cpu_is_omap7xx()) {
-		omap_irq_flags = INT_7XX_IH2_IRQ;
 		irq_banks = omap7xx_irq_banks;
 		irq_bank_count = ARRAY_SIZE(omap7xx_irq_banks);
 	}
 #endif
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (cpu_is_omap1510()) {
-		omap_irq_flags = INT_1510_IH2_IRQ;
 		irq_banks = omap1510_irq_banks;
 		irq_bank_count = ARRAY_SIZE(omap1510_irq_banks);
 	}
 	if (cpu_is_omap310()) {
-		omap_irq_flags = INT_1510_IH2_IRQ;
 		irq_banks = omap310_irq_banks;
 		irq_bank_count = ARRAY_SIZE(omap310_irq_banks);
 	}
 #endif
 #if defined(CONFIG_ARCH_OMAP16XX)
 	if (cpu_is_omap16xx()) {
-		omap_irq_flags = INT_1510_IH2_IRQ;
 		irq_banks = omap1610_irq_banks;
 		irq_bank_count = ARRAY_SIZE(omap1610_irq_banks);
 	}
@@ -205,6 +232,7 @@ void __init omap1_init_irq(void)
 		pr_warn("Couldn't allocate IRQ numbers\n");
 		irq_base = 0;
 	}
+	omap_l2_irq = cpu_is_omap7xx() ? irq_base + 1 : irq_base;
 
 	domain = irq_domain_add_legacy(NULL, nr_irqs, irq_base, 0,
 				       &irq_domain_simple_ops, NULL);
@@ -239,7 +267,7 @@ void __init omap1_init_irq(void)
 	}
 
 	/* Unmask level 2 handler */
-	d = irq_get_irq_data(omap_irq_flags);
+	d = irq_get_irq_data(irq_find_mapping(domain, omap_l2_irq));
 	if (d) {
 		ct = irq_data_get_chip_type(d);
 		ct->chip.irq_unmask(d);
-- 
2.1.4

