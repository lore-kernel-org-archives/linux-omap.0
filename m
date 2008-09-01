From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 06/12] Interrupt Controller context save/restore
Date: Mon, 1 Sep 2008 19:10:30 +0530 (IST)
Message-ID: <61325.192.168.10.89.1220276430.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49324 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYIANkh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 09:40:37 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m81DeVi3005863
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:40:36 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id m81DeSJn021718
	for <linux-omap@vger.kernel.org>; Mon, 1 Sep 2008 08:40:29 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds the Intrpt controller context save/restore

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 +0000                                  |binary
 arch/arm/mach-omap2/.irq.c.swp         |    0
 arch/arm/mach-omap2/irq.c              |   48 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/irqs.h |   14 +++++++++
 2 files changed, 62 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/irq.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/irq.c	2008-09-01 18:11:28.000000000
+0530
+++ linux-omap-2.6/arch/arm/mach-omap2/irq.c	2008-09-01 18:11:54.000000000 +0530
@@ -24,6 +24,9 @@
 #define INTC_SYSCONFIG		0x0010
 #define INTC_SYSSTATUS		0x0014
 #define INTC_CONTROL		0x0048
+#define INTC_PROTECTION		0x004C
+#define INTC_IDLE		0x0050
+#define INTC_THRESHOLD		0x0068
 #define INTC_MIR_CLEAR0		0x0088
 #define INTC_MIR_SET0		0x008c
 #define INTC_PENDING_IRQ0	0x0098
@@ -167,3 +170,48 @@ void __init omap_init_irq(void)
 	}
 }

+#ifdef CONFIG_ARCH_OMAP3
+static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
+void omap3_save_intc_ctx(void)
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
+		for (i = 0; i < 96; i++)
+			intc_context[ind].ilr[i] =
+				intc_bank_read_reg(bank, (0x100 + 0x4*ind));
+	}
+	/* MIRs are saved and restore with other PRCM registers */
+}
+
+void omap3_restore_intc_ctx(void)
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
+		for (i = 0; i < 96; i++)
+			intc_bank_write_reg(intc_context[ind].ilr[i],
+				bank, (0x100 + 0x4*ind));
+	}
+	/* MIRs are saved and restore with other PRCM registers */
+}
+#endif /* CONFIG_ARCH_OMAP3 */
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/irqs.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/irqs.h	2008-09-01
18:11:28.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/irqs.h	2008-09-01
18:11:54.000000000 +0530
@@ -368,8 +368,22 @@
 #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))

 #ifndef __ASSEMBLY__
+/* Structure to save interrupt controller context */
+struct omap3_intc_regs {
+	u32 sysconfig;
+	u32 protection;
+	u32 idle;
+	u32 threshold;
+	u32 ilr[96];
+	u32 mir_0;
+	u32 mir_1;
+	u32 mir_2;
+};
+
 extern void omap_init_irq(void);
 extern int omap_irq_pending(void);
+void omap3_save_intc_ctx(void);
+void omap3_restore_intc_ctx(void);
 #endif

 #include <mach/hardware.h>


