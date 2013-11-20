From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 18/31] arm: omap: irq: add specific compatibles for omap3 and am33xx devices
Date: Wed, 20 Nov 2013 12:09:05 -0600
Message-ID: <1384970958-4118-19-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51660 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754673Ab3KTSKh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Nov 2013 13:10:37 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

with this, we can use a compatible flag to figure
out how many irq lines are wired up, no need for
our TI-specific ti,intc-size binding.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 8104f85..1e1015c 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -323,7 +323,9 @@ static int __init intc_of_init(struct device_node *node,
 	return 0;
 }
 
-IRQCHIP_DECLARE(omap_intc, "ti,omap2-intc", intc_of_init);
+IRQCHIP_DECLARE(omap2_intc, "ti,omap2-intc", intc_of_init);
+IRQCHIP_DECLARE(omap3_intc, "ti,omap3-intc", intc_of_init);
+IRQCHIP_DECLARE(am33xx_intc, "ti,am33xx-intc", intc_of_init);
 
 asmlinkage void __exception_irq_entry omap3_intc_handle_irq(struct pt_regs *regs)
 {
-- 
1.8.4.GIT

