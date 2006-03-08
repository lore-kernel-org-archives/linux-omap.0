From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [patch 4/5] MMC HOTSWAP SUPPORT
Date: Wed, 8 Mar 2006 10:27:33 +0200
Message-ID: <20060308102733.359085de.Hiroshi.DOYU@nokia.com>
References: <20060307171122.002855000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060307171122.002855000@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This modification can handle MMC/SD cards hotplug.

"Cover switch interrupt" and "polling slots" mechanism can 
be used in order to manage MMC/SD cards hotplug.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

 drivers/mmc/omap.c |  118 +++++++++++++++++++++++++++++------------------------
 1 files changed, 65 insertions(+), 53 deletions(-)

Index: linux-omap/drivers/mmc/omap.c
===================================================================
--- linux-omap.orig/drivers/mmc/omap.c	2006-03-07 18:19:58.000000000 +0200
+++ linux-omap/drivers/mmc/omap.c	2006-03-07 18:20:20.000000000 +0200
@@ -61,8 +61,6 @@
  * when the cover switch is open */
 #define OMAP_MMC_SWITCH_POLL_DELAY	500
 
-static int mmc_omap_enable_poll = 1;
-
 struct mmc_omap_host {
 	int			initialized;
 	int			suspended;
@@ -106,6 +104,8 @@
 	struct work_struct	switch_work;
 	struct timer_list	switch_timer;
 	int			switch_last_state;
+
+	int                     enable_poll;
 };
 
 static inline void mmc_omap_enable_slot(struct mmc_omap_host *host)
@@ -142,9 +142,10 @@
 static inline int
 mmc_omap_cover_is_open(struct mmc_omap_host *host)
 {
-	if (host->switch_pin < 0)
-		return 0;
-	return omap_get_gpio_datain(host->switch_pin);
+	if (host->switch_pin >= 0)
+		return omap_get_gpio_datain(host->switch_pin);
+
+	return host->switch_last_state;
 }
 
 static ssize_t
@@ -162,7 +163,8 @@
 mmc_omap_show_enable_poll(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", mmc_omap_enable_poll);
+	struct mmc_omap_host *host = dev_get_drvdata(dev);
+	return snprintf(buf, PAGE_SIZE, "%d\n", host->enable_poll);
 }
 
 static ssize_t
@@ -171,15 +173,14 @@
 	size_t size)
 {
 	int enable_poll;
+	struct mmc_omap_host *host = dev_get_drvdata(dev);
 
 	if (sscanf(buf, "%10d", &enable_poll) != 1)
 		return -EINVAL;
 
-	if (enable_poll != mmc_omap_enable_poll) {
-		struct mmc_omap_host *host = dev_get_drvdata(dev);
-
-		mmc_omap_enable_poll = enable_poll;
-		if (enable_poll && host->switch_pin >= 0)
+	if (enable_poll != host->enable_poll) {
+		host->enable_poll = enable_poll;
+		if (enable_poll)
 			schedule_work(&host->switch_work);
 	}
 	return size;
@@ -694,6 +695,8 @@
  * for MMC state? */
 static void mmc_omap_switch_callback(unsigned long data, u8 mmc_mask)
 {
+	struct mmc_omap_host *host = (struct mmc_omap_host *) data;
+
 	if (machine_is_omap_h4()) {
 		if (mmc_mask & 0x1)
 			printk("XXX card in slot 1\n");
@@ -701,11 +704,12 @@
 			printk("XXX card in slot 2\n");
 	} else {
 		/* Assume card detect connected to cover switch */
-		if (mmc_mask & 0x2)
-			printk("XXX cover open\n");
-		else
-			printk("XXX cover closed\n");
+		host->switch_last_state = (mmc_mask & 0x2) ? 1 : 0;
+		DBG("MMC%d cover is now %s\n", host->id,
+		    host->switch_last_state ? "open" : "closed");
 	}
+
+	schedule_work(&host->switch_work);
 }
 
 static void mmc_omap_switch_handler(void *data)
@@ -715,16 +719,21 @@
 	static int complained = 0;
 	int cards = 0, cover_open;
 
-	if (host->switch_pin == -1)
-		return;
-	set_irq_type(OMAP_GPIO_IRQ(host->switch_pin), IRQT_RISING | IRQT_FALLING);
+	if (host->switch_pin >= 0)
+		set_irq_type(OMAP_GPIO_IRQ(host->switch_pin), IRQT_RISING | IRQT_FALLING);
 	cover_open = mmc_omap_cover_is_open(host);
 	if (cover_open != host->switch_last_state) {
 		kobject_uevent(&host->dev->kobj, KOBJ_CHANGE);
 		host->switch_last_state = cover_open;
 	}
 	DBG("MMC cover switch handler started\n");
-	mmc_detect_change(host->mmc, 0);
+
+	host->slot = 0;
+	do {
+ 		mmc_detect_change(host->mmc, 0);
+ 		flush_scheduled_work();
+	} while (++host->slot < host->slots);
+
 	list_for_each_entry(card, &host->mmc->cards, node) {
 		if (mmc_card_present(card))
 			cards++;
@@ -735,7 +744,7 @@
 			printk(KERN_INFO "MMC%d: cover is open\n", host->id);
 			complained = 1;
 		}
-		if (cover_open && (cards || mmc_omap_enable_poll))
+		if (cover_open && (cards || host->enable_poll))
 			mod_timer(&host->switch_timer, jiffies +
 				  msecs_to_jiffies(OMAP_MMC_SWITCH_POLL_DELAY));
 	} else {
@@ -1356,16 +1365,21 @@
 		flush_scheduled_work();
 	} 
 
-	if (host->switch_pin >= 0) {
-		INIT_WORK(&host->switch_work, mmc_omap_switch_handler, host);
-		init_timer(&host->switch_timer);
-		host->switch_timer.function = mmc_omap_switch_timer;
-		host->switch_timer.data = (unsigned long) host;
+	INIT_WORK(&host->switch_work, mmc_omap_switch_handler, host);
+
+	init_timer(&host->switch_timer);
+	host->switch_timer.function = mmc_omap_switch_timer;
+	host->switch_timer.data = (unsigned long) host;
+
+	if (omap_has_menelaus())
+		menelaus_mmc_register(mmc_omap_switch_callback,
+				      (unsigned long)host);
+	else if (host->switch_pin >= 0) {
 		if (omap_request_gpio(host->switch_pin) != 0) {
 			printk(KERN_WARNING "MMC%d: Unable to get GPIO pin for MMC cover switch\n",
 			       host->id);
 			host->switch_pin = -1;
-			goto no_switch;
+			return 0;
 		}
 
 		omap_set_gpio_direction(host->switch_pin, 1);
@@ -1378,34 +1392,30 @@
 			       host->id);
 			omap_free_gpio(host->switch_pin);
 			host->switch_pin = -1;
-			goto no_switch;
-		}
-		ret = device_create_file(&pdev->dev, &dev_attr_cover_switch);
-		if (ret == 0) {
-			ret = device_create_file(&pdev->dev, &dev_attr_enable_poll);
-			if (ret != 0)
-				device_remove_file(&pdev->dev, &dev_attr_cover_switch);
-		}
-		if (ret) {
-			printk(KERN_WARNING "MMC%d: Unable to create sysfs attributes\n", 
-			       host->id);
-			free_irq(OMAP_GPIO_IRQ(host->switch_pin), host);
-			omap_free_gpio(host->switch_pin);
-			host->switch_pin = -1;
-			goto no_switch;
+			return 0;
 		}
-		host->switch_last_state = mmc_omap_cover_is_open(host);
-		if (mmc_omap_enable_poll && mmc_omap_cover_is_open(host))
-			schedule_work(&host->switch_work);
+	} else
+		host->enable_poll = host->switch_last_state = 1;
+
+	ret = device_create_file(&pdev->dev, &dev_attr_cover_switch);
+	if (ret == 0) {
+		ret = device_create_file(&pdev->dev, &dev_attr_enable_poll);
+		if (ret != 0)
+			device_remove_file(&pdev->dev, &dev_attr_cover_switch);
+	}
+	if (ret) {
+		printk(KERN_WARNING "MMC%d: Unable to create sysfs attributes\n",
+		       host->id);
+		free_irq(OMAP_GPIO_IRQ(host->switch_pin), host);
+		omap_free_gpio(host->switch_pin);
+		host->switch_pin = -1;
 	}
 
-	if (omap_has_menelaus())
-		menelaus_mmc_register(mmc_omap_switch_callback,
-				      (unsigned long)host);
+	host->switch_last_state = mmc_omap_cover_is_open(host);
+	if (host->enable_poll && mmc_omap_cover_is_open(host))
+		schedule_work(&host->switch_work);
 
-no_switch:
 	return 0;
-
 out:
 	/* FIXME: Free other resources too. */
 	if (host) {
@@ -1432,14 +1442,16 @@
 		if (host->power_pin >= 0)
 			omap_free_gpio(host->power_pin);
 		if (host->switch_pin >= 0) {
-			device_remove_file(&pdev->dev, &dev_attr_enable_poll);
-			device_remove_file(&pdev->dev, &dev_attr_cover_switch);
 			free_irq(OMAP_GPIO_IRQ(host->switch_pin), host);
 			omap_free_gpio(host->switch_pin);
 			host->switch_pin = -1;
-			del_timer_sync(&host->switch_timer);
-			flush_scheduled_work();
 		}
+
+		device_remove_file(&pdev->dev, &dev_attr_enable_poll);
+		device_remove_file(&pdev->dev, &dev_attr_cover_switch);
+		del_timer_sync(&host->switch_timer);
+		flush_scheduled_work();
+
 		if (host->iclk && !IS_ERR(host->iclk))
 			clk_put(host->iclk);
 		if (host->fclk && !IS_ERR(host->fclk))

--

		Hiroshi DOYU
