From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Subject: [PATCH v2] cbus: Fix initialization of cached IRQ masks
Date: Fri, 18 Nov 2011 11:31:32 +0100
Message-ID: <20111118113132.5baeb268@milhouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bues.ch ([80.190.117.144]:59995 "EHLO bues.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536Ab1KRKbk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Nov 2011 05:31:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

This fixes the initialization of retu/tahvo cached IRQ masks.

Signed-off-by: Michael Buesch <m@bues.ch>

---

v2: lowercase

Index: linux-3.1.1/drivers/cbus/retu.c
===================================================================
--- linux-3.1.1.orig/drivers/cbus/retu.c	2011-11-17 23:09:26.498214061 +0100
+++ linux-3.1.1/drivers/cbus/retu.c	2011-11-17 23:15:50.280659655 +0100
@@ -451,7 +451,8 @@ static int __devinit retu_probe(struct p
 			(rev >> 4) & 0x07, rev & 0x0f);
 
 	/* Mask all RETU interrupts */
-	__retu_write_reg(retu, RETU_REG_IMR, 0xffff);
+	retu->mask = 0xffff;
+	__retu_write_reg(retu, RETU_REG_IMR, retu->mask);
 
 	ret = request_threaded_irq(retu->irq, NULL, retu_irq_handler,
 			IRQF_ONESHOT, "retu", retu);
Index: linux-3.1.1/drivers/cbus/tahvo.c
===================================================================
--- linux-3.1.1.orig/drivers/cbus/tahvo.c	2011-11-17 23:15:46.684674232 +0100
+++ linux-3.1.1/drivers/cbus/tahvo.c	2011-11-17 23:15:50.280659655 +0100
@@ -346,7 +346,8 @@ static int __devinit tahvo_probe(struct
 			(rev >> 4) & 0x0f, rev & 0x0f);
 
 	/* Mask all TAHVO interrupts */
-	__tahvo_write_reg(tahvo, TAHVO_REG_IMR, 0xffff);
+	tahvo->mask = 0xffff;
+	__tahvo_write_reg(tahvo, TAHVO_REG_IMR, tahvo->mask);
 
 	ret = request_threaded_irq(irq, NULL, tahvo_irq_handler,
 			IRQF_TRIGGER_RISING | IRQF_ONESHOT,

-- 
Greetings, Michael.
