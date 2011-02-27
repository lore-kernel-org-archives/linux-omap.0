From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] cbus-retu: Fix nested IRQ handling
Date: Sun, 27 Feb 2011 18:17:01 +0100
Message-ID: <1298827021.30857.16.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:54133 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038Ab1B0RRH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Feb 2011 12:17:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

handle_nested_irq() expects a global IRQ number, so
the irq_base has to be added to the RETU irq number.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

Index: linux-omap-2.6/drivers/cbus/retu.c
===================================================================
--- linux-omap-2.6.orig/drivers/cbus/retu.c	2011-02-27 18:12:41.147193710 +0100
+++ linux-omap-2.6/drivers/cbus/retu.c	2011-02-27 18:13:23.383428594 +0100
@@ -205,7 +205,7 @@ static irqreturn_t retu_irq_handler(int
 		return IRQ_NONE;
 	}
 
-	for (i = 0; idr != 0; i++, idr >>= 1) {
+	for (i = retu->irq_base; idr != 0; i++, idr >>= 1) {
 		if (!(idr & 1))
 			continue;
 


