From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 2/2] bus: omap_l3_noc: Correct returning IRQ_HANDLED unconditionally in the irq handler
Date: Mon, 10 Nov 2014 23:49:48 +0530
Message-ID: <1415643588-14508-3-git-send-email-j-keerthy@ti.com>
References: <1415643588-14508-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45621 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbaKJSYH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Nov 2014 13:24:07 -0500
In-Reply-To: <1415643588-14508-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: j-keerthy@ti.com, nm@ti.com, afzal@ti.com, tony@atomide.com

Correct returning IRQ_HANDLED unconditionally in the irq handler.
Return IRQ_NONE for some interrupt which we do not expect to be
handled in this handler. This prevents kernel stalling with back
to back spurious interrupts.

Fixes: 2722e56de6 ("OMAP4: l3: Introduce l3-interconnect error handling driver") 
Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes from v1:

    * Added the Fixes tag to the commit log with the right commit ID of the
      patch that is fixed.

 drivers/bus/omap_l3_noc.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index b5eac29..17d8659 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -222,10 +222,14 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 			}
 
 			/* Error found so break the for loop */
-			break;
+			return IRQ_HANDLED;
 		}
 	}
-	return IRQ_HANDLED;
+
+	dev_err(l3->dev, "L3 %s IRQ not handled!!\n",
+		inttype ? "debug" : "application");
+
+	return IRQ_NONE;
 }
 
 static const struct of_device_id l3_noc_match[] = {
-- 
1.7.9.5

