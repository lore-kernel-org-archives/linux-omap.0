From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/9] irqchip: omap-intc: comment style cleanup
Date: Mon, 15 Sep 2014 16:15:04 -0500
Message-ID: <1410815709-462-5-git-send-email-balbi@ti.com>
References: <1410815709-462-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37396 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258AbaIOVQA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Sep 2014 17:16:00 -0400
In-Reply-To: <1410815709-462-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

no functional changes, just making sure comment
follows Coding Style.

Acked-by: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/irqchip/irq-omap-intc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index 2933760..f4d562e 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -326,9 +326,11 @@ out:
 		}
 	} while (irqnr);
 
-	/* If an irq is masked or deasserted while active, we will
+	/*
+	 * If an irq is masked or deasserted while active, we will
 	 * keep ending up here with no irq handled. So remove it from
-	 * the INTC with an ack.*/
+	 * the INTC with an ack.
+	 */
 	if (!handled_irq)
 		omap_ack_irq(NULL);
 }
-- 
2.0.1.563.g66f467c

