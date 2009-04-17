From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] OMAP: Make sure all resources used by the gpio-switch IRQ handler are initialized before use.
Date: Fri, 17 Apr 2009 12:39:41 +0300
Message-ID: <1239961181-5777-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61988 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757998AbZDQJkW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 05:40:22 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n3H9eCG7006583
	for <linux-omap@vger.kernel.org>; Fri, 17 Apr 2009 12:40:17 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Initialize the workqueue and timer used by the gpio-switch IRQ handler before
we register the IRQ handler itself.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/plat-omap/gpio-switch.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/gpio-switch.c b/arch/arm/plat-omap/gpio-switch.c
index e9041af..d88b6de 100644
--- a/arch/arm/plat-omap/gpio-switch.c
+++ b/arch/arm/plat-omap/gpio-switch.c
@@ -318,6 +318,13 @@ static int __init new_switch(struct gpio_switch *sw)
 		else
 			trigger = IRQF_TRIGGER_RISING;
 	}
+
+	INIT_WORK(&sw->work, gpio_sw_handler);
+	init_timer(&sw->timer);
+
+	sw->timer.function = gpio_sw_timer;
+	sw->timer.data = (unsigned long)sw;
+
 	r = request_irq(gpio_to_irq(sw->gpio), gpio_sw_irq_handler,
 			IRQF_SHARED | trigger, sw->name, sw);
 	if (r < 0) {
@@ -328,12 +335,6 @@ static int __init new_switch(struct gpio_switch *sw)
 		return r;
 	}
 
-	INIT_WORK(&sw->work, gpio_sw_handler);
-	init_timer(&sw->timer);
-
-	sw->timer.function = gpio_sw_timer;
-	sw->timer.data = (unsigned long)sw;
-
 	list_add(&sw->node, &gpio_switches);
 
 	return 0;
-- 
1.5.6.3

