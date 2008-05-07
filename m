From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/5] fix sparse, checkpatch warnings in OMAP2/3 IRQ code
Date: Wed, 07 May 2008 11:52:02 -0600
Message-ID: <20080507175201.17732.94211.stgit@localhost.localdomain>
References: <20080507171204.17732.97601.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59091 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933333AbYEGTuj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2008 15:50:39 -0400
In-Reply-To: <20080507171204.17732.97601.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Fix sparse warnings in mach-omap2/irq.c. Fix by defining
intc_bank_write_reg() and intc_bank_read_reg(), and convert INTC module
register access to use them rather than __raw_{read,write}l.

Also clear up some checkpatch warnings involving includes from asm/
rather than linux/.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/irq.c |   58 ++++++++++++++++++++++++++++-----------------
 1 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 8237529..ac062ee 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -15,8 +15,10 @@
 #include <linux/interrupt.h>
 #include <asm/hardware.h>
 #include <asm/mach/irq.h>
-#include <asm/irq.h>
-#include <asm/io.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+/* selected INTC register offsets */
 
 #define INTC_REVISION	0x0000
 #define INTC_SYSCONFIG	0x0010
@@ -42,36 +44,49 @@ static struct omap_irq_bank {
 	},
 };
 
+/* INTC bank register get/set */
+
+static void intc_bank_write_reg(u32 val, struct omap_irq_bank *bank, u16 reg)
+{
+	pr_debug("intc_write_reg: writing 0x%0x to 0x%0x\n", val,
+		 (__force u32)(bank->base_reg + reg));
+
+	omap_writel(val, bank->base_reg + reg);
+}
+
+static u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16 reg)
+{
+	return omap_readl(bank->base_reg + reg);
+}
+
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
 static void omap_ack_irq(unsigned int irq)
 {
-	__raw_writel(0x1, irq_banks[0].base_reg + INTC_CONTROL);
+	intc_bank_write_reg(0x1, &irq_banks[0], INTC_CONTROL);
 }
 
 static void omap_mask_irq(unsigned int irq)
 {
 	int offset = (irq >> 5) << 5;
 
-	if (irq >= 64) {
+	if (irq >= 64)
 		irq %= 64;
-	} else if (irq >= 32) {
+	else if (irq >= 32)
 		irq %= 32;
-	}
 
-	__raw_writel(1 << irq, irq_banks[0].base_reg + INTC_MIR_SET0 + offset);
+	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);
 }
 
 static void omap_unmask_irq(unsigned int irq)
 {
 	int offset = (irq >> 5) << 5;
 
-	if (irq >= 64) {
+	if (irq >= 64)
 		irq %= 64;
-	} else if (irq >= 32) {
+	else if (irq >= 32)
 		irq %= 32;
-	}
 
-	__raw_writel(1 << irq, irq_banks[0].base_reg + INTC_MIR_CLEAR0 + offset);
+	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_CLEAR0 + offset);
 }
 
 static void omap_mask_ack_irq(unsigned int irq)
@@ -91,20 +106,20 @@ static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
 {
 	unsigned long tmp;
 
-	tmp = __raw_readl(bank->base_reg + INTC_REVISION) & 0xff;
+	tmp = intc_bank_read_reg(bank, INTC_REVISION) & 0xff;
 	printk(KERN_INFO "IRQ: Found an INTC at 0x%08lx "
 			 "(revision %ld.%ld) with %d interrupts\n",
 			 bank->base_reg, tmp >> 4, tmp & 0xf, bank->nr_irqs);
 
-	tmp = __raw_readl(bank->base_reg + INTC_SYSCONFIG);
+	tmp = intc_bank_read_reg(bank, INTC_SYSCONFIG);
 	tmp |= 1 << 1;	/* soft reset */
-	__raw_writel(tmp, bank->base_reg + INTC_SYSCONFIG);
+	intc_bank_write_reg(tmp, bank, INTC_SYSCONFIG);
 
-	while (!(__raw_readl(bank->base_reg + INTC_SYSSTATUS) & 0x1))
+	while (!(intc_bank_read_reg(bank, INTC_SYSSTATUS) & 0x1))
 		/* Wait for reset to complete */;
 
 	/* Enable autoidle */
-	__raw_writel(1 << 0, bank->base_reg + INTC_SYSCONFIG);
+	intc_bank_write_reg(1 << 0, bank, INTC_SYSCONFIG);
 }
 
 void __init omap_init_irq(void)
@@ -116,12 +131,11 @@ void __init omap_init_irq(void)
 	for (i = 0; i < ARRAY_SIZE(irq_banks); i++) {
 		struct omap_irq_bank *bank = irq_banks + i;
 
-		if (cpu_is_omap24xx()) {
-			bank->base_reg = IO_ADDRESS(OMAP24XX_IC_BASE);
-		}
-		if (cpu_is_omap34xx()) {
-			bank->base_reg = IO_ADDRESS(OMAP34XX_IC_BASE);
-		}
+		if (cpu_is_omap24xx())
+			bank->base_reg = OMAP24XX_IC_BASE;
+		else if (cpu_is_omap34xx())
+			bank->base_reg = OMAP34XX_IC_BASE;
+
 		omap_irq_bank_init_one(bank);
 
 		nr_irqs += bank->nr_irqs;


