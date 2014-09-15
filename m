From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 6/9] irqchip: omap-intc: enable IP protection
Date: Mon, 15 Sep 2014 16:15:06 -0500
Message-ID: <1410815709-462-7-git-send-email-balbi@ti.com>
References: <1410815709-462-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37401 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754364AbaIOVQE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Sep 2014 17:16:04 -0400
In-Reply-To: <1410815709-462-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

When PROTECTION bit in enabled in PROTECTION
register, INTC's registers are only accessible
from privileged mode.

Acked-by: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/irqchip/irq-omap-intc.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index e97b535..7681b13 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -51,6 +51,8 @@
 #define INTCPS_NR_ILR_REGS	128
 #define INTCPS_NR_MIR_REGS	3
 
+#define INTC_PROTECTION_ENABLE	(1 << 0)
+
 /*
  * OMAP2 has a number of different interrupt controllers, each interrupt
  * controller is identified as its own "bank". Register definitions are
@@ -290,12 +292,28 @@ static int __init omap_init_irq_legacy(u32 base)
 	return 0;
 }
 
+static void __init omap_irq_enable_protection(void)
+{
+	u32 reg;
+
+	reg = intc_readl(INTC_PROTECTION);
+	reg |= INTC_PROTECTION_ENABLE;
+	intc_writel(INTC_PROTECTION, reg);
+}
+
 static int __init omap_init_irq(u32 base, struct device_node *node)
 {
+	int ret;
+
 	if (node)
-		return omap_init_irq_of(node);
+		ret = omap_init_irq_of(node);
 	else
-		return omap_init_irq_legacy(base);
+		ret = omap_init_irq_legacy(base);
+
+	if (ret == 0)
+		omap_irq_enable_protection();
+
+	return ret;
 }
 
 static asmlinkage void __exception_irq_entry
-- 
2.0.1.563.g66f467c

