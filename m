From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 35/54] ARM: omap1: irq_data conversion.
Date: Tue, 30 Nov 2010 14:41:07 +0100
Message-ID: <20101130134107.GJ15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-omap1/ams-delta-fiq.c |    8 ++++--
 arch/arm/mach-omap1/fpga.c          |   28 +++++++++++-----------
 arch/arm/mach-omap1/irq.c           |   44 +++++++++++++++++-----------------
 3 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index 6c994e2..152b32c 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -49,7 +49,7 @@ static irqreturn_t deferred_fiq(int irq, void *dev_id)
 
 	irq_desc = irq_to_desc(IH_GPIO_BASE);
 	if (irq_desc)
-		irq_chip = irq_desc->chip;
+		irq_chip = irq_desc->irq_data.chip;
 
 	/*
 	 * For each handled GPIO interrupt, keep calling its interrupt handler
@@ -62,13 +62,15 @@ static irqreturn_t deferred_fiq(int irq, void *dev_id)
 
 		while (irq_counter[gpio] < fiq_count) {
 			if (gpio != AMS_DELTA_GPIO_PIN_KEYBRD_CLK) {
+				struct irq_data *d = irq_get_irq_data(irq_num);
+
 				/*
 				 * It looks like handle_edge_irq() that
 				 * OMAP GPIO edge interrupts default to,
 				 * expects interrupt already unmasked.
 				 */
-				if (irq_chip && irq_chip->unmask)
-					irq_chip->unmask(irq_num);
+				if (irq_chip && irq_chip->irq_unmask)
+					irq_chip->irq_unmask(d);
 			}
 			generic_handle_irq(irq_num);
 
diff --git a/arch/arm/mach-omap1/fpga.c b/arch/arm/mach-omap1/fpga.c
index 5cfce16..0de09fa 100644
--- a/arch/arm/mach-omap1/fpga.c
+++ b/arch/arm/mach-omap1/fpga.c
@@ -30,9 +30,9 @@
 #include <plat/fpga.h>
 #include <mach/gpio.h>
 
-static void fpga_mask_irq(unsigned int irq)
+static void fpga_mask_irq(struct irq_data *d)
 {
-	irq -= OMAP_FPGA_IRQ_BASE;
+	unsigned int irq = d->irq - OMAP_FPGA_IRQ_BASE;
 
 	if (irq < 8)
 		__raw_writeb((__raw_readb(OMAP1510_FPGA_IMR_LO)
@@ -58,14 +58,14 @@ static inline u32 get_fpga_unmasked_irqs(void)
 }
 
 
-static void fpga_ack_irq(unsigned int irq)
+static void fpga_ack_irq(struct irq_data *d)
 {
 	/* Don't need to explicitly ACK FPGA interrupts */
 }
 
-static void fpga_unmask_irq(unsigned int irq)
+static void fpga_unmask_irq(struct irq_data *d)
 {
-	irq -= OMAP_FPGA_IRQ_BASE;
+	unsigned int irq = d->irq - OMAP_FPGA_IRQ_BASE;
 
 	if (irq < 8)
 		__raw_writeb((__raw_readb(OMAP1510_FPGA_IMR_LO) | (1 << irq)),
@@ -78,10 +78,10 @@ static void fpga_unmask_irq(unsigned int irq)
 			      | (1 << (irq - 16))), INNOVATOR_FPGA_IMR2);
 }
 
-static void fpga_mask_ack_irq(unsigned int irq)
+static void fpga_mask_ack_irq(struct irq_data *d)
 {
-	fpga_mask_irq(irq);
-	fpga_ack_irq(irq);
+	fpga_mask_irq(d);
+	fpga_ack_irq(d);
 }
 
 void innovator_fpga_IRQ_demux(unsigned int irq, struct irq_desc *desc)
@@ -105,17 +105,17 @@ void innovator_fpga_IRQ_demux(unsigned int irq, struct irq_desc *desc)
 
 static struct irq_chip omap_fpga_irq_ack = {
 	.name		= "FPGA-ack",
-	.ack		= fpga_mask_ack_irq,
-	.mask		= fpga_mask_irq,
-	.unmask		= fpga_unmask_irq,
+	.irq_ack	= fpga_mask_ack_irq,
+	.irq_mask	= fpga_mask_irq,
+	.irq_unmask	= fpga_unmask_irq,
 };
 
 
 static struct irq_chip omap_fpga_irq = {
 	.name		= "FPGA",
-	.ack		= fpga_ack_irq,
-	.mask		= fpga_mask_irq,
-	.unmask		= fpga_unmask_irq,
+	.irq_ack	= fpga_ack_irq,
+	.irq_mask	= fpga_mask_irq,
+	.irq_unmask	= fpga_unmask_irq,
 };
 
 /*
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index db913c3..c2cfb27 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -70,48 +70,48 @@ static inline void irq_bank_writel(unsigned long value, int bank, int offset)
 	omap_writel(value, irq_banks[bank].base_reg + offset);
 }
 
-static void omap_ack_irq(unsigned int irq)
+static void omap_ack_irq(struct irq_data *d)
 {
-	if (irq > 31)
+	if (d->irq > 31)
 		omap_writel(0x1, OMAP_IH2_BASE + IRQ_CONTROL_REG_OFFSET);
 
 	omap_writel(0x1, OMAP_IH1_BASE + IRQ_CONTROL_REG_OFFSET);
 }
 
-static void omap_mask_irq(unsigned int irq)
+static void omap_mask_irq(struct irq_data *d)
 {
-	int bank = IRQ_BANK(irq);
+	int bank = IRQ_BANK(d->irq);
 	u32 l;
 
 	l = omap_readl(irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
-	l |= 1 << IRQ_BIT(irq);
+	l |= 1 << IRQ_BIT(d->irq);
 	omap_writel(l, irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
 }
 
-static void omap_unmask_irq(unsigned int irq)
+static void omap_unmask_irq(struct irq_data *d)
 {
-	int bank = IRQ_BANK(irq);
+	int bank = IRQ_BANK(d->irq);
 	u32 l;
 
 	l = omap_readl(irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
-	l &= ~(1 << IRQ_BIT(irq));
+	l &= ~(1 << IRQ_BIT(d->irq));
 	omap_writel(l, irq_banks[bank].base_reg + IRQ_MIR_REG_OFFSET);
 }
 
-static void omap_mask_ack_irq(unsigned int irq)
+static void omap_mask_ack_irq(struct irq_data *d)
 {
-	omap_mask_irq(irq);
-	omap_ack_irq(irq);
+	omap_mask_irq(d);
+	omap_ack_irq(d);
 }
 
-static int omap_wake_irq(unsigned int irq, unsigned int enable)
+static int omap_wake_irq(struct irq_data *d, unsigned int enable)
 {
-	int bank = IRQ_BANK(irq);
+	int bank = IRQ_BANK(d->irq);
 
 	if (enable)
-		irq_banks[bank].wake_enable |= IRQ_BIT(irq);
+		irq_banks[bank].wake_enable |= IRQ_BIT(d->irq);
 	else
-		irq_banks[bank].wake_enable &= ~IRQ_BIT(irq);
+		irq_banks[bank].wake_enable &= ~IRQ_BIT(d->irq);
 
 	return 0;
 }
@@ -168,10 +168,10 @@ static struct omap_irq_bank omap1610_irq_banks[] = {
 
 static struct irq_chip omap_irq_chip = {
 	.name		= "MPU",
-	.ack		= omap_mask_ack_irq,
-	.mask		= omap_mask_irq,
-	.unmask		= omap_unmask_irq,
-	.set_wake	= omap_wake_irq,
+	.irq_ack	= omap_mask_ack_irq,
+	.irq_mask	= omap_mask_irq,
+	.irq_unmask	= omap_unmask_irq,
+	.irq_set_wake	= omap_wake_irq,
 };
 
 void __init omap_init_irq(void)
@@ -234,9 +234,9 @@ void __init omap_init_irq(void)
 	/* Unmask level 2 handler */
 
 	if (cpu_is_omap7xx())
-		omap_unmask_irq(INT_7XX_IH2_IRQ);
+		omap_unmask_irq(irq_get_irq_data(INT_7XX_IH2_IRQ));
 	else if (cpu_is_omap15xx())
-		omap_unmask_irq(INT_1510_IH2_IRQ);
+		omap_unmask_irq(irq_get_irq_data(INT_1510_IH2_IRQ));
 	else if (cpu_is_omap16xx())
-		omap_unmask_irq(INT_1610_IH2_IRQ);
+		omap_unmask_irq(irq_get_irq_data(INT_1610_IH2_IRQ));
 }
-- 
1.7.1
