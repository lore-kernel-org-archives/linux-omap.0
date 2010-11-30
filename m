From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 36/54] ARM: omap2: irq_data conversion.
Date: Tue, 30 Nov 2010 14:41:08 +0100
Message-ID: <20101130134108.GK15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fw.wantstofly.org ([80.101.37.227]:33894 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab0K3OJd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 09:09:33 -0500
Content-Disposition: inline
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-omap2/irq.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 32eeabe..3d17ef6 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -100,13 +100,14 @@ static int omap_check_spurious(unsigned int irq)
 }
 
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
-static void omap_ack_irq(unsigned int irq)
+static void omap_ack_irq(struct irq_data *d)
 {
 	intc_bank_write_reg(0x1, &irq_banks[0], INTC_CONTROL);
 }
 
-static void omap_mask_irq(unsigned int irq)
+static void omap_mask_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
 	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
 
 	if (cpu_is_omap34xx()) {
@@ -128,8 +129,9 @@ static void omap_mask_irq(unsigned int irq)
 	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);
 }
 
-static void omap_unmask_irq(unsigned int irq)
+static void omap_unmask_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
 	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
 
 	irq &= (IRQ_BITS_PER_REG - 1);
@@ -137,17 +139,17 @@ static void omap_unmask_irq(unsigned int irq)
 	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_CLEAR0 + offset);
 }
 
-static void omap_mask_ack_irq(unsigned int irq)
+static void omap_mask_ack_irq(struct irq_data *d)
 {
-	omap_mask_irq(irq);
-	omap_ack_irq(irq);
+	omap_mask_irq(d);
+	omap_ack_irq(d);
 }
 
 static struct irq_chip omap_irq_chip = {
-	.name	= "INTC",
-	.ack	= omap_mask_ack_irq,
-	.mask	= omap_mask_irq,
-	.unmask	= omap_unmask_irq,
+	.name		= "INTC",
+	.irq_ack	= omap_mask_ack_irq,
+	.irq_mask	= omap_mask_irq,
+	.irq_unmask	= omap_unmask_irq,
 };
 
 static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
-- 
1.7.1

