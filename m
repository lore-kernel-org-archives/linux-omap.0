From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] CBUS: Make retu watchdog behave like a standard Linux watchdog
Date: Mon, 12 May 2008 17:35:18 -0700
Message-ID: <1210638918-26644-4-git-send-email-tony@atomide.com>
References: retu-2008-05-12-173514
 <1210638918-26644-1-git-send-email-tony@atomide.com>
 <1210638918-26644-2-git-send-email-tony@atomide.com>
 <1210638918-26644-3-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:54606 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342AbYEMAfW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2008 20:35:22 -0400
In-Reply-To: <1210638918-26644-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Make retu watchdog behave like a standard Linux watchdog.

Let the kernel do the kicking until the watchdog device is opened.

Note: We should remove the old non-standard interface, please
change to use standard /dev/watchdog instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/cbus/Kconfig    |    2 +-
 drivers/cbus/retu-wdt.c |  184 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 183 insertions(+), 3 deletions(-)

diff --git a/drivers/cbus/Kconfig b/drivers/cbus/Kconfig
index 25f8039..c344a99 100644
--- a/drivers/cbus/Kconfig
+++ b/drivers/cbus/Kconfig
@@ -72,7 +72,7 @@ config CBUS_RETU_RTC
 	  RTC in Retu. This will expose a sysfs interface for it.
 
 config CBUS_RETU_WDT
-	depends on CBUS_RETU && SYSFS
+	depends on CBUS_RETU && SYSFS && WATCHDOG
 	tristate "Support for Retu watchdog timer"
 	---help---
 	  Say Y here if you want support for the watchdog in Retu. This will
diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index b7b20b7..8ca5c72 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -25,11 +25,19 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/platform_device.h>
 
 #include <linux/completion.h>
 #include <linux/errno.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+
+#include <asm/uaccess.h>
+
+#include <asm/arch/prcm.h>
 
 #include "cbus.h"
 #include "retu.h"
@@ -46,6 +54,17 @@ static DEFINE_MUTEX(retu_wdt_mutex);
 static unsigned int period_val = RETU_WDT_DEFAULT_TIMER;
 static int counter_param = RETU_WDT_MAX_TIMER;
 
+struct retu_wdt_dev {
+	struct device		*dev;
+	int			users;
+	struct miscdevice	retu_wdt_miscdev;
+	struct timer_list	ping_timer;
+};
+
+static struct retu_wdt_dev *retu_wdt;
+
+static void retu_wdt_set_ping_timer(unsigned long enable);
+
 static int retu_modify_counter(unsigned int new)
 {
 	int ret = 0;
@@ -69,6 +88,10 @@ static ssize_t retu_wdt_period_show(struct device *dev,
 	return sprintf(buf, "%u\n", (u16)period_val);
 }
 
+/*
+ * Note: This inteface is non-standard and likely to disappear!
+ * Use /dev/watchdog instead, that's the standard.
+ */
 static ssize_t retu_wdt_period_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
@@ -76,6 +99,10 @@ static ssize_t retu_wdt_period_store(struct device *dev,
 	unsigned int new_period;
 	int ret;
 
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+	retu_wdt_set_ping_timer(0);
+#endif
+
 	if (sscanf(buf, "%u", &new_period) != 1) {
 		printk(KERN_ALERT "retu_wdt_period_store: Invalid input\n");
 		return -EINVAL;
@@ -104,31 +131,184 @@ static DEVICE_ATTR(period, S_IRUGO | S_IWUSR, retu_wdt_period_show, \
 			retu_wdt_period_store);
 static DEVICE_ATTR(counter, S_IRUGO, retu_wdt_counter_show, NULL);
 
+/*----------------------------------------------------------------------------*/
+
+/*
+ * Since retu watchdog cannot be disabled in hardware, we must kick it
+ * with a timer until userspace watchdog software takes over. Do this
+ * unless /dev/watchdog is open or CONFIG_WATCHDOG_NOWAYOUT is set.
+ */
+static void retu_wdt_set_ping_timer(unsigned long enable)
+{
+	retu_modify_counter(RETU_WDT_MAX_TIMER);
+	if (enable)
+		mod_timer(&retu_wdt->ping_timer,
+				jiffies + RETU_WDT_DEFAULT_TIMER * HZ);
+	else
+		del_timer_sync(&retu_wdt->ping_timer);
+}
+
+static int retu_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(1, (unsigned long *)&(retu_wdt->users)))
+		return -EBUSY;
+
+	file->private_data = (void *)retu_wdt;
+	retu_wdt_set_ping_timer(0);
+
+	return nonseekable_open(inode, file);
+}
+
+static int retu_wdt_release(struct inode *inode, struct file *file)
+{
+	struct retu_wdt_dev *wdev = file->private_data;
+
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+	retu_wdt_set_ping_timer(1);
+#endif
+	wdev->users = 0;
+
+	return 0;
+}
+
+static ssize_t retu_wdt_write(struct file *file, const char __user *data,
+						size_t len, loff_t *ppos)
+{
+	if (len)
+		retu_modify_counter(RETU_WDT_MAX_TIMER);
+
+	return len;
+}
+
+static int retu_wdt_ioctl(struct inode *inode, struct file *file,
+					unsigned int cmd, unsigned long arg)
+{
+	int new_margin;
+
+	static struct watchdog_info ident = {
+		.identity = "Retu Watchdog",
+		.options = WDIOF_SETTIMEOUT,
+		.firmware_version = 0,
+	};
+
+	switch (cmd) {
+	default:
+		return -ENOTTY;
+	case WDIOC_GETSUPPORT:
+		return copy_to_user((struct watchdog_info __user *)arg, &ident,
+							sizeof(ident));
+	case WDIOC_GETSTATUS:
+		return put_user(0, (int __user *)arg);
+	case WDIOC_GETBOOTSTATUS:
+		if (cpu_is_omap16xx())
+			return put_user(omap_readw(ARM_SYSST),
+					(int __user *)arg);
+		if (cpu_is_omap24xx())
+			return put_user(omap_prcm_get_reset_sources(),
+					(int __user *)arg);
+	case WDIOC_KEEPALIVE:
+		retu_modify_counter(RETU_WDT_MAX_TIMER);
+		break;
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_margin, (int __user *)arg))
+			return -EFAULT;
+		retu_modify_counter(new_margin);
+		/* Fall through */
+	case WDIOC_GETTIMEOUT:
+		return put_user(period_val, (int __user *)arg);
+	}
+
+	return 0;
+}
+
+/* Start kicking retu watchdog until user space starts doing the kicking */
+static int __init retu_wdt_ping(void)
+{
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+	retu_modify_counter(RETU_WDT_MAX_TIMER);
+#else
+	retu_wdt_set_ping_timer(1);
+#endif
+
+	return 0;
+}
+late_initcall(retu_wdt_ping);
+
+static const struct file_operations retu_wdt_fops = {
+	.owner = THIS_MODULE,
+	.write = retu_wdt_write,
+	.ioctl = retu_wdt_ioctl,
+	.open = retu_wdt_open,
+	.release = retu_wdt_release,
+};
+
+/*----------------------------------------------------------------------------*/
+
 static int __devinit retu_wdt_probe(struct device *dev)
 {
+	struct retu_wdt_dev *wdev;
 	int ret;
 
+	wdev = kzalloc(sizeof(struct retu_wdt_dev), GFP_KERNEL);
+	if (!wdev)
+		return -ENOMEM;
+
+	wdev->users = 0;
+
 	ret = device_create_file(dev, &dev_attr_period);
 	if (ret) {
 		printk(KERN_ERR "retu_wdt_probe: Error creating "
 					"sys device file: period\n");
-		return ret;
+		goto free1;
 	}
 
 	ret = device_create_file(dev, &dev_attr_counter);
 	if (ret) {
-		device_remove_file(dev, &dev_attr_period);
 		printk(KERN_ERR "retu_wdt_probe: Error creating "
 					"sys device file: counter\n");
+		goto free2;
 	}
 
+	dev_set_drvdata(dev, wdev);
+	retu_wdt = wdev;
+	wdev->retu_wdt_miscdev.parent = dev;
+	wdev->retu_wdt_miscdev.minor = WATCHDOG_MINOR;
+	wdev->retu_wdt_miscdev.name = "watchdog";
+	wdev->retu_wdt_miscdev.fops = &retu_wdt_fops;
+
+	ret = misc_register(&(wdev->retu_wdt_miscdev));
+	if (ret)
+		goto free3;
+
+	setup_timer(&wdev->ping_timer, retu_wdt_set_ping_timer, 1);
+
+	/* Kick the watchdog for kernel booting to finish */
+	retu_modify_counter(RETU_WDT_MAX_TIMER);
+
+	return 0;
+
+free3:
+	device_remove_file(dev, &dev_attr_counter);
+
+free2:
+	device_remove_file(dev, &dev_attr_period);
+free1:
+	kfree(wdev);
+
 	return ret;
 }
 
 static int __devexit retu_wdt_remove(struct device *dev)
 {
+	struct retu_wdt_dev *wdev;
+
+	wdev = dev_get_drvdata(dev);
+	misc_deregister(&(wdev->retu_wdt_miscdev));
 	device_remove_file(dev, &dev_attr_period);
 	device_remove_file(dev, &dev_attr_counter);
+	kfree(wdev);
+
 	return 0;
 }
 
-- 
1.5.3.6

