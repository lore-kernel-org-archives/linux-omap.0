From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 08/35] arm: omap: irq: remove unnecessary base_addr argument
Date: Mon, 28 Jul 2014 16:15:56 -0500
Message-ID: <1406582183-696-9-git-send-email-balbi@ti.com>
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

omap_intc_handle_irq now had an unnecessary
base_addr argument. Let's remove it and fix
all callers.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 88bba9e..38007b3 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -46,8 +46,6 @@
 #define INTC_PENDING_IRQ3	0x00f8
 #define INTC_ILR0		0x0100
 
-#define OMAP2_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP24XX_IC_BASE)
-#define OMAP3_IRQ_BASE		OMAP2_L4_IO_ADDRESS(OMAP34XX_IC_BASE)
 #define ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
 #define INTCPS_NR_ILR_REGS	128
 #define INTCPS_NR_MIR_REGS	3
@@ -188,7 +186,7 @@ void __init ti81xx_init_irq(void)
 	omap_init_irq(OMAP34XX_IC_BASE, 128, NULL);
 }
 
-static inline void omap_intc_handle_irq(void __iomem *base_addr, struct pt_regs *regs)
+static inline void omap_intc_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
 	int handled_irq = 0;
@@ -232,8 +230,7 @@ out:
 
 asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs *regs)
 {
-	void __iomem *base_addr = OMAP2_IRQ_BASE;
-	omap_intc_handle_irq(base_addr, regs);
+	omap_intc_handle_irq(regs);
 }
 
 int __init intc_of_init(struct device_node *node,
@@ -334,7 +331,6 @@ void omap3_intc_resume_idle(void)
 
 asmlinkage void __exception_irq_entry omap3_intc_handle_irq(struct pt_regs *regs)
 {
-	void __iomem *base_addr = OMAP3_IRQ_BASE;
-	omap_intc_handle_irq(base_addr, regs);
+	omap_intc_handle_irq(regs);
 }
 #endif /* CONFIG_ARCH_OMAP3 */
-- 
2.0.1.563.g66f467c
