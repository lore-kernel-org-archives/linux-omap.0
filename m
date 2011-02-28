From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] cbus-retu: Add locking around register access in irq
 handler
Date: Mon, 28 Feb 2011 17:06:08 +0100
Message-ID: <1298909168.16391.6.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:52983 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755073Ab1B1QGN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 11:06:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

This adds locking around the register access in the
interrupt service routine.

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Reported-by: Felipe Balbi <balbi@ti.com>

---

Index: linux-omap-2.6/drivers/cbus/retu.c
===================================================================
--- linux-omap-2.6.orig/drivers/cbus/retu.c	2011-02-28 16:59:10.767302605 +0100
+++ linux-omap-2.6/drivers/cbus/retu.c	2011-02-28 16:59:58.629389762 +0100
@@ -198,10 +198,12 @@ static irqreturn_t retu_irq_handler(int
 	u16			idr;
 	u16			imr;
 
+	mutex_lock(&retu->mutex);
 	idr = __retu_read_reg(retu, RETU_REG_IDR);
 	imr = __retu_read_reg(retu, RETU_REG_IMR);
-	idr &= ~imr;
+	mutex_unlock(&retu->mutex);
 
+	idr &= ~imr;
 	if (!idr) {
 		dev_vdbg(retu->dev, "No IRQ, spurious?\n");
 		return IRQ_NONE;


