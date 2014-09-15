From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 8/9] irqchip: omap-intc: correct maximum number or MIR registers
Date: Mon, 15 Sep 2014 16:15:08 -0500
Message-ID: <1410815709-462-9-git-send-email-balbi@ti.com>
References: <1410815709-462-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49968 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553AbaIOVQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Sep 2014 17:16:09 -0400
In-Reply-To: <1410815709-462-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

maximum number of MIR register is 4, rather than 3.
Fix that.

Acked-by: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/irqchip/irq-omap-intc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index dfa2d9d..976d4c1 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -49,7 +49,7 @@
 
 #define ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
 #define INTCPS_NR_ILR_REGS	128
-#define INTCPS_NR_MIR_REGS	3
+#define INTCPS_NR_MIR_REGS	4
 
 #define INTC_IDLE_FUNCIDLE	(1 << 0)
 #define INTC_IDLE_TURBO		(1 << 1)
-- 
2.0.1.563.g66f467c

