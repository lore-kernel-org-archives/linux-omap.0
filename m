From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 21/31] arm: omap: irq: drop ti,intc-size support
Date: Wed, 20 Nov 2013 12:09:08 -0600
Message-ID: <1384970958-4118-22-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52600 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab3KTSKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 13:10:40 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

we don't need that anymore since specific
devices are passing correct compatible flags.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index fd89488..e87e8be 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -316,9 +316,6 @@ static int __init intc_of_init(struct device_node *node,
 	if (of_device_is_compatible(node, "ti,am33xx-intc"))
 		nr_irq = 128;
 
-	if (of_property_read_u32(node, "ti,intc-size", &nr_irq))
-		pr_warn("unable to get intc-size, default to %d\n", nr_irq);
-
 	omap_init_irq(res.start, nr_irq, of_node_get(node));
 
 	set_handle_irq(omap2_intc_handle_irq);
-- 
1.8.4.GIT

