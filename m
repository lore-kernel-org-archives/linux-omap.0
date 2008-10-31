From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP3: Print debug info on spurious interrupts
Date: Fri, 31 Oct 2008 12:21:11 -0700
Message-ID: <1225480873-30835-3-git-send-email-tony@atomide.com>
References: <1225480873-30835-1-git-send-email-tony@atomide.com>
 <1225480873-30835-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59131 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbYJaTVV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 15:21:21 -0400
In-Reply-To: <1225480873-30835-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

In the case of spurious interrupt, the handler for previous irq most likely
needs a read back of some register to ensure write posting.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/irq.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 68aff9a..5a3b1f1 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -23,6 +23,7 @@
 #define INTC_REVISION		0x0000
 #define INTC_SYSCONFIG		0x0010
 #define INTC_SYSSTATUS		0x0014
+#define INTC_SIR		0x0040
 #define INTC_CONTROL		0x0048
 #define INTC_MIR_CLEAR0		0x0088
 #define INTC_MIR_SET0		0x008c
@@ -60,6 +61,24 @@ static u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16 reg)
 	return __raw_readl(bank->base_reg + reg);
 }
 
+static int previous_irq;
+
+static int omap_check_spurious(unsigned int irq)
+{
+	u32 sir, spurious;
+
+	sir = intc_bank_read_reg(&irq_banks[0], INTC_SIR);
+	spurious = sir >> 6;
+
+	if (spurious > 1) {
+		printk("FIXME: spurious irq %i: 0x%08x previous irq %i\n",
+				irq, sir, previous_irq);
+		return spurious;
+	}
+
+	return 0;
+}
+
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
 static void omap_ack_irq(unsigned int irq)
 {
@@ -70,6 +89,9 @@ static void omap_mask_irq(unsigned int irq)
 {
 	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
 
+	if (cpu_is_omap34xx() && !omap_check_spurious(irq))
+		previous_irq = irq;
+
 	irq &= (IRQ_BITS_PER_REG - 1);
 
 	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);
-- 
1.5.6.rc3.21.g8c6b5

