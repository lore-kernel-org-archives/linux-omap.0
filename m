From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 16/16] ARM: OMAP2: Fix sparse, checkpatch warnings in OMAP2/3 IRQ code
Date: Fri,  6 Jun 2008 19:12:42 -0700
Message-ID: <1212804762-18413-15-git-send-email-tony@atomide.com>
References: 1212803277-18007-1-git-send-email-tony@atomide.com
 <1212804762-18413-1-git-send-email-tony@atomide.com>
 <1212804762-18413-2-git-send-email-tony@atomide.com>
 <1212804762-18413-3-git-send-email-tony@atomide.com>
 <1212804762-18413-4-git-send-email-tony@atomide.com>
 <1212804762-18413-5-git-send-email-tony@atomide.com>
 <1212804762-18413-6-git-send-email-tony@atomide.com>
 <1212804762-18413-7-git-send-email-tony@atomide.com>
 <1212804762-18413-8-git-send-email-tony@atomide.com>
 <1212804762-18413-9-git-send-email-tony@atomide.com>
 <1212804762-18413-10-git-send-email-tony@atomide.com>
 <1212804762-18413-11-git-send-email-tony@atomide.com>
 <1212804762-18413-12-git-send-email-tony@atomide.com>
 <1212804762-18413-13-git-send-email-tony@atomide.com>
 <1212804762-18413-14-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49577 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094AbYFGCNR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jun 2008 22:13:17 -0400
In-Reply-To: <1212804762-18413-14-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

Fix sparse warnings in mach-omap2/irq.c. Fix by defining
intc_bank_write_reg() and intc_bank_read_reg(), and convert INTC module
register access to use them rather than __raw_{read,write}l.

Also clear up some checkpatch warnings involving includes from asm/
rather than linux/.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 8ff6fef..e5635dd 100644
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
@@ -25,6 +27,9 @@
 #define INTC_MIR_CLEAR0	0x0088
 #define INTC_MIR_SET0	0x008c
 
+/* Number of IRQ state bits in each MIR register */
+#define IRQ_BITS_PER_REG	32
+
 /*
  * OMAP2 has a number of different interrupt controllers, each interrupt
  * controller is identified as its own "bank". Register definitions are
@@ -42,36 +47,40 @@ static struct omap_irq_bank {
 	},
 };
 
+/* INTC bank register get/set */
+
+static void intc_bank_write_reg(u32 val, struct omap_irq_bank *bank, u16 reg)
+{
+	__raw_writel(val, bank->base_reg + reg);
+}
+
+static u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16 reg)
+{
+	return __raw_readl(bank->base_reg + reg);
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
-	int offset = (irq >> 5) << 5;
+	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
 
-	if (irq >= 64) {
-		irq %= 64;
-	} else if (irq >= 32) {
-		irq %= 32;
-	}
+	irq &= (IRQ_BITS_PER_REG - 1);
 
-	__raw_writel(1 << irq, irq_banks[0].base_reg + INTC_MIR_SET0 + offset);
+	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);
 }
 
 static void omap_unmask_irq(unsigned int irq)
 {
-	int offset = (irq >> 5) << 5;
+	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
 
-	if (irq >= 64) {
-		irq %= 64;
-	} else if (irq >= 32) {
-		irq %= 32;
-	}
+	irq &= (IRQ_BITS_PER_REG - 1);
 
-	__raw_writel(1 << irq, irq_banks[0].base_reg + INTC_MIR_CLEAR0 + offset);
+	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_CLEAR0 + offset);
 }
 
 static void omap_mask_ack_irq(unsigned int irq)
@@ -91,20 +100,20 @@ static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
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
@@ -117,9 +126,10 @@ void __init omap_init_irq(void)
 		struct omap_irq_bank *bank = irq_banks + i;
 
 		if (cpu_is_omap24xx())
-			bank->base_reg = IO_ADDRESS(OMAP24XX_IC_BASE);
-		if (cpu_is_omap34xx())
-			bank->base_reg = IO_ADDRESS(OMAP34XX_IC_BASE);
+			bank->base_reg = io_p2v(OMAP24XX_IC_BASE);
+		else if (cpu_is_omap34xx())
+			bank->base_reg = io_p2v(OMAP34XX_IC_BASE);
+
 		omap_irq_bank_init_one(bank);
 
 		nr_irqs += bank->nr_irqs;
