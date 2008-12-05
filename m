From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] ARM: OMAP3: Warn about spurious interrupts
Date: Fri, 05 Dec 2008 12:01:19 -0800
Message-ID: <20081205200119.31125.73204.stgit@localhost>
References: <20081205195846.31125.21080.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49459 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbYLEUBV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 15:01:21 -0500
In-Reply-To: <20081205195846.31125.21080.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

In the case of spurious interrupt, the handler for previous interrupt
handler needs to flush posted writes with a read back of the interrupt
ack register. Warn about handlers that need to flush posted writes.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/irq.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index c40fc37..636e282 100644
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
@@ -60,6 +61,30 @@ static u32 intc_bank_read_reg(struct omap_irq_bank *bank, u16 reg)
 	return __raw_readl(bank->base_reg + reg);
 }
 
+static int previous_irq;
+
+/*
+ * On 34xx we can get occasional spurious interrupts if the ack from
+ * an interrupt handler does not get posted before we unmask. Warn about
+ * the interrupt handlers that need to flush posted writes.
+ */
+static int omap_check_spurious(unsigned int irq)
+{
+	u32 sir, spurious;
+
+	sir = intc_bank_read_reg(&irq_banks[0], INTC_SIR);
+	spurious = sir >> 6;
+
+	if (spurious > 1) {
+		printk(KERN_WARNING "Spurious irq %i: 0x%08x, please flush "
+					"posted write for irq %i\n",
+					irq, sir, previous_irq);
+		return spurious;
+	}
+
+	return 0;
+}
+
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
 static void omap_ack_irq(unsigned int irq)
 {
@@ -70,6 +95,20 @@ static void omap_mask_irq(unsigned int irq)
 {
 	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
 
+	if (cpu_is_omap34xx()) {
+		int spurious = 0;
+
+		/*
+		 * INT_34XX_GPT12_IRQ is also the spurious irq. Maybe because
+		 * it is the highest irq number?
+		 */
+		if (irq == INT_34XX_GPT12_IRQ)
+			spurious = omap_check_spurious(irq);
+
+		if (!spurious)
+			previous_irq = irq;
+	}
+
 	irq &= (IRQ_BITS_PER_REG - 1);
 
 	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);

