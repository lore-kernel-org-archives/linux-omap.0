From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] IRQ: simplify OMAP2 mask_irq/unmask_irq code
Date: Wed, 21 May 2008 13:15:42 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0805211312580.15667@utopia.booyaka.com>
References: <alpine.DEB.1.00.0805201915320.9463@utopia.booyaka.com> <20080521150554.GX23002@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54519 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426AbYEUTPn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 15:15:43 -0400
In-Reply-To: <20080521150554.GX23002@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Kyungmin Park <kmpark@infradead.org>

Hi Tony,

On Wed, 21 May 2008, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [080520 18:20]:
> > 
> > Modify mach-omap2/irq.c to simplify the IRQ number-to-IRQ register and IRQ 
> > number-to-register bit calculations.
> 
> How about patching Jouni's new omap_irq_pending() for this too?

done - updated patch below.

- Paul


[PATCH] IRQ: simplify OMAP2 mask_irq/unmask_irq code

Modify mach-omap2/irq.c to simplify the IRQ number-to-IRQ register and
IRQ number-to-register bit calculations.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kyungmin Park <kmpark@infradead.org>
Acked-by: Paul Mundt <lethal@linux-sh.org>

size:
   text    data     bss     dec     hex filename
3272871  155128   98792 3526791  35d087 vmlinux.3430sdp
3272839  155128   98792 3526759  35d067 vmlinux.3430sdp.patched
---

 arch/arm/mach-omap2/irq.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)


diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index f1e1e2e..94d2f93 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -28,6 +28,9 @@
 #define INTC_MIR_SET0		0x008c
 #define INTC_PENDING_IRQ0	0x0098
 
+/* Number of IRQ state bits in each MIR register */
+#define IRQ_BITS_PER_REG	32
+
 /*
  * OMAP2 has a number of different interrupt controllers, each interrupt
  * controller is identified as its own "bank". Register definitions are
@@ -68,24 +71,18 @@ static void omap_ack_irq(unsigned int irq)
 
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
@@ -131,11 +128,15 @@ int omap_irq_pending(void)
 		struct omap_irq_bank *bank = irq_banks + i;
 		int irq;
 
-		for (irq = 0; irq < bank->nr_irqs; irq += 32)
-			if (intc_bank_read_reg(bank, INTC_PENDING_IRQ0 +
-					       ((irq >> 5) << 5)))
+		for (irq = 0; irq < bank->nr_irqs; irq += IRQ_BITS_PER_REG) {
+			int offset = irq & (~(IRQ_BITS_PER_REG - 1));
+
+			if (intc_bank_read_reg(bank, (INTC_PENDING_IRQ0 +
+						      offset)))
 				return 1;
+		}
 	}
+
 	return 0;
 }
 
