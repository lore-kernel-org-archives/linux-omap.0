From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 15/22] cbus: tahvo drop the legacy interfaces
Date: Mon, 11 Jul 2011 14:17:28 +0300
Message-ID: <1310383055-20211-16-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:42311 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754511Ab1GKLTA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:19:00 -0400
Received: by mail-yi0-f47.google.com with SMTP id 18so1533417yib.6
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:18:59 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

those tahvo-specific IRQ handling routines
aren't needed anymore. Drop'em.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |   64 --------------------------------------------------
 drivers/cbus/tahvo.h |    5 ----
 2 files changed, 0 insertions(+), 69 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index f01defc..d92a05d 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -59,14 +59,6 @@ struct tahvo {
 
 static struct tahvo *the_tahvo;
 
-struct tahvo_irq_handler_desc {
-	int (*func)(unsigned long);
-	unsigned long arg;
-	char name[8];
-};
-
-static struct tahvo_irq_handler_desc tahvo_irq_handlers[MAX_TAHVO_IRQ_HANDLERS];
-
 int tahvo_get_status(void)
 {
 	return the_tahvo != NULL;
@@ -240,62 +232,6 @@ static irqreturn_t tahvo_irq_handler(int irq, void *_tahvo)
 	return IRQ_HANDLED;
 }
 
-/*
- * Register the handler for a given TAHVO interrupt source.
- */
-int tahvo_request_irq(int id, void *irq_handler, unsigned long arg, char *name)
-{
-	struct tahvo_irq_handler_desc *hnd;
-	struct tahvo		*tahvo = the_tahvo;
-
-	if (irq_handler == NULL || id >= MAX_TAHVO_IRQ_HANDLERS ||
-	    name == NULL) {
-		dev_err(tahvo->dev, "Invalid arguments to %s\n",
-		       __FUNCTION__);
-		return -EINVAL;
-	}
-	hnd = &tahvo_irq_handlers[id];
-	if (hnd->func != NULL) {
-		dev_err(tahvo->dev, "IRQ %d already reserved\n", id);
-		return -EBUSY;
-	}
-	dev_dbg(tahvo->dev, "Registering interrupt %d for device %s\n",
-	       id, name);
-	hnd->func = irq_handler;
-	hnd->arg = arg;
-	strlcpy(hnd->name, name, sizeof(hnd->name));
-
-	tahvo_ack_irq(id);
-	tahvo_enable_irq(id);
-
-	return 0;
-}
-EXPORT_SYMBOL(tahvo_request_irq);
-
-/*
- * Unregister the handler for a given TAHVO interrupt source.
- */
-void tahvo_free_irq(int id)
-{
-	struct tahvo_irq_handler_desc *hnd;
-	struct tahvo		*tahvo = the_tahvo;
-
-	if (id >= MAX_TAHVO_IRQ_HANDLERS) {
-		dev_err(tahvo->dev, "Invalid argument to %s\n",
-		       __FUNCTION__);
-		return;
-	}
-	hnd = &tahvo_irq_handlers[id];
-	if (hnd->func == NULL) {
-		dev_err(tahvo->dev, "IRQ %d already freed\n", id);
-		return;
-	}
-
-	tahvo_disable_irq(id);
-	hnd->func = NULL;
-}
-EXPORT_SYMBOL(tahvo_free_irq);
-
 /* -------------------------------------------------------------------------- */
 
 static void tahvo_irq_bus_lock(struct irq_data *data)
diff --git a/drivers/cbus/tahvo.h b/drivers/cbus/tahvo.h
index e5ed990..b2f195f 100644
--- a/drivers/cbus/tahvo.h
+++ b/drivers/cbus/tahvo.h
@@ -54,11 +54,6 @@ int tahvo_get_status(void);
 int tahvo_read_reg(unsigned reg);
 void tahvo_write_reg(unsigned reg, u16 val);
 void tahvo_set_clear_reg_bits(unsigned reg, u16 set, u16 clear);
-int tahvo_request_irq(int id, void *irq_handler, unsigned long arg, char *name);
-void tahvo_free_irq(int id);
-void tahvo_enable_irq(int id);
-void tahvo_disable_irq(int id);
-void tahvo_ack_irq(int id);
 int tahvo_get_backlight_level(void);
 int tahvo_get_max_backlight_level(void);
 void tahvo_set_backlight_level(int level);
-- 
1.7.6

