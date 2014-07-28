From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 14/35] arm: omap: irq: use IRQCHIP_DECLARE macro
Date: Mon, 28 Jul 2014 16:16:02 -0500
Message-ID: <1406582183-696-15-git-send-email-balbi@ti.com>
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

IRQCHIP_DECLARE macro is used to declare the same
of_device_id structure for irqchips, it's just
a helper. No functional changes.

Note that we're temporarily including irqchip.h
with its full path, until we move this driver
to drivers/irqchip/.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index e452411..2801243 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -26,6 +26,7 @@
 #include "soc.h"
 #include "iomap.h"
 #include "common.h"
+#include "../../drivers/irqchip/irqchip.h"
 
 /* selected INTC register offsets */
 
@@ -319,14 +320,11 @@ static int __init intc_of_init(struct device_node *node,
 	return 0;
 }
 
-static struct of_device_id irq_match[] __initdata = {
-	{ .compatible = "ti,omap2-intc", .data = intc_of_init, },
-	{ }
-};
+IRQCHIP_DECLARE(omap_intc, "ti,omap2-intc", intc_of_init);
 
 void __init omap_intc_of_init(void)
 {
-	of_irq_init(irq_match);
+	of_irq_init(&irqchip_of_match_omap_intc);
 }
 
 asmlinkage void __exception_irq_entry omap3_intc_handle_irq(struct pt_regs *regs)
-- 
2.0.1.563.g66f467c
