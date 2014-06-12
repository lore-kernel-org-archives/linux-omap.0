From: Sricharan R <r.sricharan@ti.com>
Subject: [PATCH V2 11/19] irqchip: crossbar: fix memory leak incase of invalid entry
Date: Thu, 12 Jun 2014 17:23:19 +0530
Message-ID: <1402574007-13987-12-git-send-email-r.sricharan@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32801 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933586AbaFLL4m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jun 2014 07:56:42 -0400
In-Reply-To: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, santosh.shilimkar@ti.com, nm@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, r.sricharan@ti.com, tglx@linutronix.de, jason@lakedaemon.net

From: Nishanth Menon <nm@ti.com>

When the provided unused skip list entry is greater than max irqs
possible, we go to err3, but we fail to free register_offsets,
should have returned to err4 instead which ensures that allocated
register_offsets are freed as well.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/irqchip/irq-crossbar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 42a2e62..fea3e5d 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -225,7 +225,7 @@ static int __init crossbar_of_init(struct device_node *node,
 
 			if (entry > max) {
 				pr_err("Invalid skip entry\n");
-				goto err3;
+				goto err4;
 			}
 			cb->irq_map[entry] = IRQ_SKIP;
 		}
-- 
1.7.9.5

