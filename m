From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] IRQ: simplify OMAP2 mask_irq/unmask_irq code
Date: Tue, 20 May 2008 19:19:21 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0805201915320.9463@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40485 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756891AbYEUBTX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 21:19:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Kyungmin Park <kmpark@infradead.org>


Modify mach-omap2/irq.c to simplify the IRQ number-to-IRQ register and IRQ 
number-to-register bit calculations.

Signed-off-by: Kyungmin Park <kmpark@infradead.org>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>

size:
   text    data     bss     dec     hex filename
3341347  170992  109008 3621347  3741e3 vmlinux.3430sdp
3341315  170992  109008 3621315  3741c3 vmlinux.3430sdp.patched
---

 arch/arm/mach-omap2/irq.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)


diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index ac062ee..9300712 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -27,6 +27,9 @@
 #define INTC_MIR_CLEAR0	0x0088
 #define INTC_MIR_SET0	0x008c
 
+/* Number of IRQ state bits in each MIR register */
+#define IRQ_BITS_PER_REG	32
+
 /*
  * OMAP2 has a number of different interrupt controllers, each interrupt
  * controller is identified as its own "bank". Register definitions are
@@ -67,24 +70,18 @@ static void omap_ack_irq(unsigned int irq)
 
 static void omap_mask_irq(unsigned int irq)
 {
-	int offset = (irq >> 5) << 5;
+	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
 
-	if (irq >= 64)
-		irq %= 64;
-	else if (irq >= 32)
-		irq %= 32;
+	irq &= (IRQ_BITS_PER_REG - 1);
 
 	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);
 }
 
 static void omap_unmask_irq(unsigned int irq)
 {
-	int offset = (irq >> 5) << 5;
+	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
 
-	if (irq >= 64)
-		irq %= 64;
-	else if (irq >= 32)
-		irq %= 32;
+	irq &= (IRQ_BITS_PER_REG - 1);
 
 	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_CLEAR0 + offset);
 }
