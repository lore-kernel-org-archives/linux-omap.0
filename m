From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 07/35] arm: omap: irq: switch over to intc_readl on
 omap_intc_handle_irq
Date: Mon, 28 Jul 2014 16:15:55 -0500
Message-ID: <1406582183-696-8-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux@arm.linux.org.uk, jason@lakedaemon.net, khilman@deeprootsystems.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, bcousson@baylibre.com, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

an almost blind conversion from readl_relaxed
to our newly introduced intc_readl().

While at that, also remove some hardcoded
register addresses.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 8905ebb..88bba9e 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -41,11 +41,13 @@
 #define INTC_MIR_CLEAR0		0x0088
 #define INTC_MIR_SET0		0x008c
 #define INTC_PENDING_IRQ0	0x0098
+#define INTC_PENDING_IRQ1	0x00b8
+#define INTC_PENDING_IRQ2	0x00d8
+#define INTC_PENDING_IRQ3	0x00f8
 #define INTC_ILR0		0x0100
 
 #define OMAP2_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
 #define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
-#define INTCPS_SIR_IRQ_OFFSET	0x0040	/* omap2/3 active interrupt offset */
 #define ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
 #define INTCPS_NR_ILR_REGS	128
 #define INTCPS_NR_MIR_REGS	3
@@ -192,26 +194,26 @@ static inline void omap_intc_handle_irq(void __iomem *base_addr, struct pt_regs
 	int handled_irq = 0;
 
 	do {
-		irqnr = readl_relaxed(base_addr + 0x98);
+		irqnr = intc_readl(INTC_PENDING_IRQ0);
 		if (irqnr)
 			goto out;
 
-		irqnr = readl_relaxed(base_addr + 0xb8);
+		irqnr = intc_readl(INTC_PENDING_IRQ1);
 		if (irqnr)
 			goto out;
 
-		irqnr = readl_relaxed(base_addr + 0xd8);
+		irqnr = intc_readl(INTC_PENDING_IRQ2);
 #if IS_ENABLED(CONFIG_SOC_TI81XX) || IS_ENABLED(CONFIG_SOC_AM33XX)
 		if (irqnr)
 			goto out;
-		irqnr = readl_relaxed(base_addr + 0xf8);
+		irqnr = intc_readl(INTC_PENDING_IRQ3);
 #endif
 
 out:
 		if (!irqnr)
 			break;
 
-		irqnr = readl_relaxed(base_addr + INTCPS_SIR_IRQ_OFFSET);
+		irqnr = intc_readl(INTC_SIR);
 		irqnr &= ACTIVEIRQ_MASK;
 
 		if (irqnr) {
-- 
2.0.1.563.g66f467c
