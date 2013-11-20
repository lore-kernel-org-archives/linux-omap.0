From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 19/31] arm: omap: irq: use compatible flag to figure out number of IRQ lines
Date: Wed, 20 Nov 2013 12:09:06 -0600
Message-ID: <1384970958-4118-20-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52598 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685Ab3KTSKi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Nov 2013 13:10:38 -0500
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

so far, only am33xx has 128 lines, all other devices
have only 96.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 1e1015c..fd89488 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -313,6 +313,9 @@ static int __init intc_of_init(struct device_node *node,
 		return -EINVAL;
 	}
 
+	if (of_device_is_compatible(node, "ti,am33xx-intc"))
+		nr_irq = 128;
+
 	if (of_property_read_u32(node, "ti,intc-size", &nr_irq))
 		pr_warn("unable to get intc-size, default to %d\n", nr_irq);
 
-- 
1.8.4.GIT

