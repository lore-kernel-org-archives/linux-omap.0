From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/07] ARM: OMAP2: Fix sparse, checkpatch warnings in OMAP2/3 IRQ code
Date: Fri,  3 Oct 2008 14:56:49 +0300
Message-ID: <1223035009-23866-8-git-send-email-tony@atomide.com>
References: <1223035009-23866-1-git-send-email-tony@atomide.com>
 <1223035009-23866-2-git-send-email-tony@atomide.com>
 <1223035009-23866-3-git-send-email-tony@atomide.com>
 <1223035009-23866-4-git-send-email-tony@atomide.com>
 <1223035009-23866-5-git-send-email-tony@atomide.com>
 <1223035009-23866-6-git-send-email-tony@atomide.com>
 <1223035009-23866-7-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63043 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbYJCLyV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 07:54:21 -0400
In-Reply-To: <1223035009-23866-7-git-send-email-tony@atomide.com>
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
index a0bdf06..4759658 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -13,17 +13,22 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/io.h>
 #include <mach/hardware.h>
 #include <asm/mach/irq.h>
-#include <asm/irq.h>
+#include <linux/io.h>
+
+/* selected INTC register offsets */
+
+#define INTC_REVISION		0x0000
+#define INTC_SYSCONFIG		0x0010
+#define INTC_SYSSTATUS		0x0014
+#define INTC_CONTROL		0x0048
+#define INTC_MIR_CLEAR0		0x0088
+#define INTC_MIR_SET0		0x008c
+#define INTC_PENDING_IRQ0	0x0098
 
-#define INTC_REVISION	0x0000
-#define INTC_SYSCONFIG	0x0010
-#define INTC_SYSSTATUS	0x0014
-#define INTC_CONTROL	0x0048
-#define INTC_MIR_CLEAR0	0x0088
-#define INTC_MIR_SET0	0x008c
+/* Number of IRQ state bits in each MIR register */
+#define IRQ_BITS_PER_REG	32
 
 /*
  * OMAP2 has a number of different interrupt controllers, each interrupt
@@ -42,36 +47,40 @@ static struct omap_irq_bank {
 	},
 };
 
+/* INTC bank register get/set */
+
+static void intc_bank_write_reg(u32 val, struct omap_irq_bank *bank, u16 reg)
+{
+	__raw_writel(val, (__force void __iomem *)(bank->base_reg + reg));
+}
+
+static u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16 reg)
+{
+	return __raw_readl((__force void __iomem *)(bank->base_reg + reg));
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
 	printk(KERN_INFO "IRQ: Found an INTC at 0x%p "
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
@@ -117,7 +126,8 @@ void __init omap_init_irq(void)
 		struct omap_irq_bank *bank = irq_banks + i;
 
 		if (cpu_is_omap24xx())
-			bank->base_reg = IO_ADDRESS(OMAP24XX_IC_BASE);
+			bank->base_reg = OMAP2_IO_ADDRESS(OMAP24XX_IC_BASE);
+
 		omap_irq_bank_init_one(bank);
 
 		nr_irqs += bank->nr_irqs;
