From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 06/16] OMAP3: INTC context save/restore
Date: Fri, 26 Sep 2008 17:48:20 +0530
Message-ID: <01f701c91fd1$f6ef8cd0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37872 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbYIZMS3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 08:18:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This patch adds the Interrupt controller context
save/restore routines

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/irq.c              |   67 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/irqs.h |    5 ++
 2 files changed, 72 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/irq.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/irq.c	2008-09-26 14:07:07.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/irq.c	2008-09-26 14:08:23.000000000 +0530
@@ -24,6 +24,10 @@
 #define INTC_SYSCONFIG		0x0010
 #define INTC_SYSSTATUS		0x0014
 #define INTC_CONTROL		0x0048
+#define INTC_PROTECTION		0x004C
+#define INTC_IDLE		0x0050
+#define INTC_THRESHOLD		0x0068
+#define INTC_MIR0		0x0084
 #define INTC_MIR_CLEAR0		0x0088
 #define INTC_MIR_SET0		0x008c
 #define INTC_PENDING_IRQ0	0x0098
@@ -48,6 +52,18 @@ static struct omap_irq_bank {
 	},
 };
 
+/* Structure to save interrupt controller context */
+struct omap3_intc_regs {
+	u32 sysconfig;
+	u32 protection;
+	u32 idle;
+	u32 threshold;
+	u32 ilr[INTCPS_NR_IRQS];
+	u32 mir[INTCPS_NR_MIR_REGS];
+};
+
+static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
+
 /* INTC bank register get/set */
 
 static void intc_bank_write_reg(u32 val, struct omap_irq_bank *bank, u16 reg)
@@ -167,3 +183,54 @@ void __init omap_init_irq(void)
 	}
 }
 
+#ifdef CONFIG_ARCH_OMAP3
+void omap3_intc_save_context(void)
+{
+	int ind = 0, i = 0;
+	for (ind = 0; ind < ARRAY_SIZE(irq_banks); ind++) {
+		struct omap_irq_bank *bank = irq_banks + ind;
+		intc_context[ind].sysconfig =
+			intc_bank_read_reg(bank, INTC_SYSCONFIG);
+		intc_context[ind].protection =
+			intc_bank_read_reg(bank, INTC_PROTECTION);
+		intc_context[ind].idle =
+			intc_bank_read_reg(bank, INTC_IDLE);
+		intc_context[ind].threshold =
+			intc_bank_read_reg(bank, INTC_THRESHOLD);
+		for (i = 0; i < INTCPS_NR_IRQS; i++)
+			intc_context[ind].ilr[i] =
+				intc_bank_read_reg(bank, (0x100 + 0x4*ind));
+		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
+			intc_context[ind].mir[i] =
+				intc_bank_read_reg(&irq_banks[0], INTC_MIR0 +
+				(0x20 * i));
+	}
+	/* MIRs are saved and restore with other PRCM registers */
+}
+
+void omap3_intc_restore_context(void)
+{
+	int ind = 0, i = 0;
+
+	for (ind = 0; ind < ARRAY_SIZE(irq_banks); ind++) {
+		struct omap_irq_bank *bank = irq_banks + ind;
+		intc_bank_write_reg(intc_context[ind].sysconfig,
+					bank, INTC_SYSCONFIG);
+		intc_bank_write_reg(intc_context[ind].sysconfig,
+					bank, INTC_SYSCONFIG);
+		intc_bank_write_reg(intc_context[ind].protection,
+					bank, INTC_PROTECTION);
+		intc_bank_write_reg(intc_context[ind].idle,
+					bank, INTC_IDLE);
+		intc_bank_write_reg(intc_context[ind].threshold,
+					bank, INTC_THRESHOLD);
+		for (i = 0; i < INTCPS_NR_IRQS; i++)
+			intc_bank_write_reg(intc_context[ind].ilr[i],
+				bank, (0x100 + 0x4*ind));
+		for (i = 0; i < INTCPS_NR_MIR_REGS; i++)
+			intc_bank_write_reg(intc_context[ind].mir[i],
+				 &irq_banks[0], INTC_MIR0 + (0x20 * i));
+	}
+	/* MIRs are saved and restore with other PRCM registers */
+}
+#endif /* CONFIG_ARCH_OMAP3 */
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/irqs.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/irqs.h	2008-09-26 14:07:07.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/irqs.h	2008-09-26 14:07:34.000000000 +0530
@@ -367,9 +367,14 @@
 
 #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
 
+#define INTCPS_NR_MIR_REGS	3
+#define INTCPS_NR_IRQS		96
+
 #ifndef __ASSEMBLY__
 extern void omap_init_irq(void);
 extern int omap_irq_pending(void);
+void omap3_intc_save_context(void);
+void omap3_intc_restore_context(void);
 #endif
 
 #include <mach/hardware.h>

