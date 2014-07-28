From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 21/35] arm: omap: irq: move some more code around
Date: Mon, 28 Jul 2014 16:16:09 -0500
Message-ID: <1406582183-696-22-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, bcousson@baylibre.com, linux@arm.linux.org.uk, khilman@deeprootsystems.com, tglx@linutronix.de, jason@lakedaemon.net, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

We want .init_irq to call set_irq_handle() for
legacy platforms. Note that this code will also
be dropped once omap2/3 devices are completely
moved to DT.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index e70c26e..587def4 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -234,21 +234,6 @@ static void __init omap_init_irq(u32 base, int nr_irqs,
 		omap_alloc_gc(omap_irq_base + j, j + irq_base, 32);
 }
 
-void __init omap2_init_irq(void)
-{
-	omap_init_irq(OMAP24XX_IC_BASE, 96, NULL);
-}
-
-void __init omap3_init_irq(void)
-{
-	omap_init_irq(OMAP34XX_IC_BASE, 96, NULL);
-}
-
-void __init ti81xx_init_irq(void)
-{
-	omap_init_irq(OMAP34XX_IC_BASE, 128, NULL);
-}
-
 static inline void omap_intc_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
@@ -296,6 +281,21 @@ asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_regs *regs
 	omap_intc_handle_irq(regs);
 }
 
+void __init omap2_init_irq(void)
+{
+	omap_init_irq(OMAP24XX_IC_BASE, 96, NULL);
+}
+
+void __init omap3_init_irq(void)
+{
+	omap_init_irq(OMAP34XX_IC_BASE, 96, NULL);
+}
+
+void __init ti81xx_init_irq(void)
+{
+	omap_init_irq(OMAP34XX_IC_BASE, 128, NULL);
+}
+
 static int __init intc_of_init(struct device_node *node,
 			     struct device_node *parent)
 {
-- 
2.0.1.563.g66f467c
