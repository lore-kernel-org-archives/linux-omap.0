From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 16/31] arm: omap: irq: use IRQCHIP_DECLARE macro
Date: Wed, 20 Nov 2013 12:09:03 -0600
Message-ID: <1384970958-4118-17-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48466 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754652Ab3KTSKb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:31 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

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
index 503d345..5c3ab05 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -26,6 +26,7 @@
 #include "soc.h"
 #include "iomap.h"
 #include "common.h"
+#include "../../drivers/irqchip/irqchip.h"
 
 /* selected INTC register offsets */
 
@@ -322,14 +323,11 @@ static int __init intc_of_init(struct device_node *node,
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
1.8.4.GIT

