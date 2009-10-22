From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 03/32] OMAP3: PM: INTC context save/restore
Date: Thu, 22 Oct 2009 16:09:24 -0700
Message-ID: <1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:3282 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbZJVXKD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 19:10:03 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1260502qwb.37
        for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:10:08 -0700 (PDT)
In-Reply-To: <1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Add context save and restore for the INTC module to support off-mode.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/irq.c              |   66 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/irqs.h |    5 ++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 1db121f..ebd3538 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -25,6 +25,10 @@
 #define INTC_SYSSTATUS		0x0014
 #define INTC_SIR		0x0040
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
@@ -209,3 +225,53 @@ void __init omap_init_irq(void)
 	}
 }
 
+#ifdef CONFIG_ARCH_OMAP3
+void omap_intc_save_context(void)
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
+}
+
+void omap_intc_restore_context(void)
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
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 6a6d028..ce5dd2d 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -477,9 +477,14 @@
 
 #define OMAP_IRQ_BIT(irq)	(1 << ((irq) % 32))
 
+#define INTCPS_NR_MIR_REGS	3
+#define INTCPS_NR_IRQS		96
+
 #ifndef __ASSEMBLY__
 extern void omap_init_irq(void);
 extern int omap_irq_pending(void);
+void omap_intc_save_context(void);
+void omap_intc_restore_context(void);
 #endif
 
 #include <mach/hardware.h>
-- 
1.6.4.3

