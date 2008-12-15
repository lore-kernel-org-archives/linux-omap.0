From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP: Add support for dynamic GPIO switch update
Date: Mon, 15 Dec 2008 14:08:16 +0200
Message-ID: <1229342896-7363-1-git-send-email-ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63266 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYLOMIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 07:08:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: juha.yrjola@solidboot.com, ext-jani.1.nikula@nokia.com

Add new function omap_update_gpio_switch() to support dynamically
changing the GPIO switch notify callback functions and debounce
timeouts.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 arch/arm/plat-omap/gpio-switch.c              |   39 +++++++++++++++++++++++-
 arch/arm/plat-omap/include/mach/gpio-switch.h |    7 ++++-
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/gpio-switch.c b/arch/arm/plat-omap/gpio-switch.c
index 2b5665d..955cd29 100644
--- a/arch/arm/plat-omap/gpio-switch.c
+++ b/arch/arm/plat-omap/gpio-switch.c
@@ -40,6 +40,7 @@ struct gpio_switch {
 	void (* notify)(void *data, int state);
 	void *notify_data;
 
+	spinlock_t		lock;
 	struct work_struct	work;
 	struct timer_list	timer;
 	struct platform_device	pdev;
@@ -188,6 +189,7 @@ static irqreturn_t gpio_sw_irq_handler(int irq, void *arg)
 	struct gpio_switch *sw = arg;
 	unsigned long timeout;
 	int state;
+	unsigned long flags;
 
 	if (!sw->both_edges) {
 		if (gpio_get_value(sw->gpio))
@@ -200,10 +202,13 @@ static irqreturn_t gpio_sw_irq_handler(int irq, void *arg)
 	if (sw->state == state)
 		return IRQ_HANDLED;
 
+	spin_lock_irqsave(&sw->lock, flags);
 	if (state)
 		timeout = sw->debounce_rising;
 	else
 		timeout = sw->debounce_falling;
+	spin_unlock_irqrestore(&sw->lock, flags);
+
 	if (!timeout)
 		schedule_work(&sw->work);
 	else
@@ -223,14 +228,24 @@ static void gpio_sw_handler(struct work_struct *work)
 {
 	struct gpio_switch *sw = container_of(work, struct gpio_switch, work);
 	int state;
+	unsigned long flags;
+	void (*notify)(void *data, int state);
+	void *notify_data;
 
 	state = gpio_sw_get_state(sw);
 	if (sw->state == state)
 		return;
 
 	sw->state = state;
-	if (sw->notify != NULL)
-		sw->notify(sw->notify_data, state);
+
+	spin_lock_irqsave(&sw->lock, flags);
+	notify = sw->notify;
+	notify_data = sw->notify_data;
+	spin_unlock_irqrestore(&sw->lock, flags);
+
+	if (notify != NULL)
+		notify(notify_data, state);
+
 	sysfs_notify(&sw->pdev.dev.kobj, NULL, "state");
 	print_sw_state(sw, state);
 }
@@ -323,6 +338,7 @@ static int __init new_switch(struct gpio_switch *sw)
 		return r;
 	}
 
+	spin_lock_init(&sw->lock);
 	INIT_WORK(&sw->work, gpio_sw_handler);
 	init_timer(&sw->timer);
 
@@ -388,6 +404,25 @@ no_check:
 	return NULL;
 }
 
+int omap_update_gpio_switch(const struct omap_gpio_switch *cfg)
+{
+	unsigned long flags;
+	struct gpio_switch *sw = find_switch(cfg->gpio, cfg->name);
+
+	if (!sw)
+		return -EINVAL;
+
+	spin_lock_irqsave(&sw->lock, flags);
+	sw->debounce_rising = cfg->debounce_rising;
+	sw->debounce_falling = cfg->debounce_falling;
+	sw->notify = cfg->notify;
+	sw->notify_data = cfg->notify_data;
+	spin_unlock_irqrestore(&sw->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_update_gpio_switch);
+
 static int __init add_board_switches(void)
 {
 	int i;
diff --git a/arch/arm/plat-omap/include/mach/gpio-switch.h b/arch/arm/plat-omap/include/mach/gpio-switch.h
index a143253..53c1fd5 100644
--- a/arch/arm/plat-omap/include/mach/gpio-switch.h
+++ b/arch/arm/plat-omap/include/mach/gpio-switch.h
@@ -47,12 +47,17 @@ struct omap_gpio_switch {
 	void *notify_data;
 };
 
-/* Call at init time only */
 #ifdef CONFIG_OMAP_GPIO_SWITCH
+/* Call at init time only */
 extern void omap_register_gpio_switches(const struct omap_gpio_switch *tbl,
 					int count);
+extern int omap_update_gpio_switch(const struct omap_gpio_switch *cfg);
 #else
 #define omap_register_gpio_switches(tbl, count)	do { } while (0)
+static inline int omap_update_gpio_switch(const struct omap_gpio_switch *cfg)
+{
+	return 0;
+}
 #endif
 
 #endif
-- 
1.6.0.4

