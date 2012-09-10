From: Jarkko Nikula <jarkko.nikula@jollamobile.com>
Subject: [PATCH] watchdog: Convert twl4030_wdt to watchdog core
Date: Mon, 10 Sep 2012 18:44:46 +0300
Message-ID: <1347291886-15218-1-git-send-email-jarkko.nikula@jollamobile.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp170.iad.emailsrvr.com ([207.97.245.170]:39989 "EHLO
	smtp170.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757539Ab2IJP4i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 11:56:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@jollamobile.com>

Convert the twl4030_wdt watchdog driver to watchdog core.

While at there use devm_kzalloc and set the default timeout in order to be
able test this driver with a simple shell script.

Signed-off-by: Jarkko Nikula <jarkko.nikula@jollamobile.com>
---
 drivers/watchdog/Kconfig       |    1 +
 drivers/watchdog/twl4030_wdt.c |  183 ++++++++--------------------------------
 2 files changed, 35 insertions(+), 149 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 53d7571..21f6205 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -232,6 +232,7 @@ config EP93XX_WATCHDOG
 config OMAP_WATCHDOG
 	tristate "OMAP Watchdog"
 	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
+	select WATCHDOG_CORE
 	help
 	  Support for TI OMAP1610/OMAP1710/OMAP2420/OMAP3430/OMAP4430 watchdog.  Say 'Y'
 	  here to enable the OMAP1610/OMAP1710/OMAP2420/OMAP3430/OMAP4430 watchdog timer.
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 249f113..71c283a 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -22,26 +22,12 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
-#include <linux/fs.h>
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
-#include <linux/miscdevice.h>
-#include <linux/uaccess.h>
 #include <linux/i2c/twl.h>
 
 #define TWL4030_WATCHDOG_CFG_REG_OFFS	0x3
 
-#define TWL4030_WDT_STATE_OPEN		0x1
-#define TWL4030_WDT_STATE_ACTIVE	0x8
-
-static struct platform_device *twl4030_wdt_dev;
-
-struct twl4030_wdt {
-	struct miscdevice	miscdev;
-	int			timer_margin;
-	unsigned long		state;
-};
-
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
@@ -53,171 +39,71 @@ static int twl4030_wdt_write(unsigned char val)
 					TWL4030_WATCHDOG_CFG_REG_OFFS);
 }
 
-static int twl4030_wdt_enable(struct twl4030_wdt *wdt)
+static int twl4030_wdt_start(struct watchdog_device *wdt)
 {
-	return twl4030_wdt_write(wdt->timer_margin + 1);
+	return twl4030_wdt_write(wdt->timeout + 1);
 }
 
-static int twl4030_wdt_disable(struct twl4030_wdt *wdt)
+static int twl4030_wdt_stop(struct watchdog_device *wdt)
 {
 	return twl4030_wdt_write(0);
 }
 
-static int twl4030_wdt_set_timeout(struct twl4030_wdt *wdt, int timeout)
-{
-	if (timeout < 0 || timeout > 30) {
-		dev_warn(wdt->miscdev.parent,
-			"Timeout can only be in the range [0-30] seconds");
-		return -EINVAL;
-	}
-	wdt->timer_margin = timeout;
-	return twl4030_wdt_enable(wdt);
-}
-
-static ssize_t twl4030_wdt_write_fop(struct file *file,
-		const char __user *data, size_t len, loff_t *ppos)
+static int twl4030_wdt_set_timeout(struct watchdog_device *wdt,
+				   unsigned int timeout)
 {
-	struct twl4030_wdt *wdt = file->private_data;
-
-	if (len)
-		twl4030_wdt_enable(wdt);
-
-	return len;
-}
-
-static long twl4030_wdt_ioctl(struct file *file,
-		unsigned int cmd, unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	int __user *p = argp;
-	int new_margin;
-	struct twl4030_wdt *wdt = file->private_data;
-
-	static const struct watchdog_info twl4030_wd_ident = {
-		.identity = "TWL4030 Watchdog",
-		.options = WDIOF_SETTIMEOUT,
-		.firmware_version = 0,
-	};
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		return copy_to_user(argp, &twl4030_wd_ident,
-				sizeof(twl4030_wd_ident)) ? -EFAULT : 0;
-
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, p);
-
-	case WDIOC_KEEPALIVE:
-		twl4030_wdt_enable(wdt);
-		break;
-
-	case WDIOC_SETTIMEOUT:
-		if (get_user(new_margin, p))
-			return -EFAULT;
-		if (twl4030_wdt_set_timeout(wdt, new_margin))
-			return -EINVAL;
-		return put_user(wdt->timer_margin, p);
-
-	case WDIOC_GETTIMEOUT:
-		return put_user(wdt->timer_margin, p);
-
-	default:
-		return -ENOTTY;
-	}
-
+	wdt->timeout = timeout;
 	return 0;
 }
 
-static int twl4030_wdt_open(struct inode *inode, struct file *file)
-{
-	struct twl4030_wdt *wdt = platform_get_drvdata(twl4030_wdt_dev);
-
-	/* /dev/watchdog can only be opened once */
-	if (test_and_set_bit(0, &wdt->state))
-		return -EBUSY;
-
-	wdt->state |= TWL4030_WDT_STATE_ACTIVE;
-	file->private_data = (void *) wdt;
-
-	twl4030_wdt_enable(wdt);
-	return nonseekable_open(inode, file);
-}
-
-static int twl4030_wdt_release(struct inode *inode, struct file *file)
-{
-	struct twl4030_wdt *wdt = file->private_data;
-	if (nowayout) {
-		dev_alert(wdt->miscdev.parent,
-		       "Unexpected close, watchdog still running!\n");
-		twl4030_wdt_enable(wdt);
-	} else {
-		if (twl4030_wdt_disable(wdt))
-			return -EFAULT;
-		wdt->state &= ~TWL4030_WDT_STATE_ACTIVE;
-	}
-
-	clear_bit(0, &wdt->state);
-	return 0;
-}
+static const struct watchdog_info twl4030_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "TWL4030 Watchdog",
+};
 
-static const struct file_operations twl4030_wdt_fops = {
+static const struct watchdog_ops twl4030_wdt_ops = {
 	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.open		= twl4030_wdt_open,
-	.release	= twl4030_wdt_release,
-	.unlocked_ioctl	= twl4030_wdt_ioctl,
-	.write		= twl4030_wdt_write_fop,
+	.start		= twl4030_wdt_start,
+	.stop		= twl4030_wdt_stop,
+	.set_timeout	= twl4030_wdt_set_timeout,
 };
 
 static int __devinit twl4030_wdt_probe(struct platform_device *pdev)
 {
 	int ret = 0;
-	struct twl4030_wdt *wdt;
+	struct watchdog_device *wdt;
 
-	wdt = kzalloc(sizeof(struct twl4030_wdt), GFP_KERNEL);
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
-	wdt->state		= 0;
-	wdt->timer_margin	= 30;
-	wdt->miscdev.parent	= &pdev->dev;
-	wdt->miscdev.fops	= &twl4030_wdt_fops;
-	wdt->miscdev.minor	= WATCHDOG_MINOR;
-	wdt->miscdev.name	= "watchdog";
+	wdt->info		= &twl4030_wdt_info;
+	wdt->ops		= &twl4030_wdt_ops;
+	wdt->status		= 0;
+	wdt->timeout		= 30;
+	wdt->min_timeout	= 1;
+	wdt->max_timeout	= 30;
 
+	watchdog_set_nowayout(wdt, nowayout);
 	platform_set_drvdata(pdev, wdt);
 
-	twl4030_wdt_dev = pdev;
+	twl4030_wdt_stop(wdt);
 
-	twl4030_wdt_disable(wdt);
-
-	ret = misc_register(&wdt->miscdev);
+	ret = watchdog_register_device(wdt);
 	if (ret) {
-		dev_err(wdt->miscdev.parent,
-			"Failed to register misc device\n");
 		platform_set_drvdata(pdev, NULL);
-		kfree(wdt);
-		twl4030_wdt_dev = NULL;
 		return ret;
 	}
+
 	return 0;
 }
 
 static int __devexit twl4030_wdt_remove(struct platform_device *pdev)
 {
-	struct twl4030_wdt *wdt = platform_get_drvdata(pdev);
-
-	if (wdt->state & TWL4030_WDT_STATE_ACTIVE)
-		if (twl4030_wdt_disable(wdt))
-			return -EFAULT;
-
-	wdt->state &= ~TWL4030_WDT_STATE_ACTIVE;
-	misc_deregister(&wdt->miscdev);
+	struct watchdog_device *wdt = platform_get_drvdata(pdev);
 
+	watchdog_unregister_device(wdt);
 	platform_set_drvdata(pdev, NULL);
-	kfree(wdt);
-	twl4030_wdt_dev = NULL;
 
 	return 0;
 }
@@ -225,18 +111,18 @@ static int __devexit twl4030_wdt_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int twl4030_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct twl4030_wdt *wdt = platform_get_drvdata(pdev);
-	if (wdt->state & TWL4030_WDT_STATE_ACTIVE)
-		return twl4030_wdt_disable(wdt);
+	struct watchdog_device *wdt = platform_get_drvdata(pdev);
+	if (watchdog_active(wdt))
+		return twl4030_wdt_stop(wdt);
 
 	return 0;
 }
 
 static int twl4030_wdt_resume(struct platform_device *pdev)
 {
-	struct twl4030_wdt *wdt = platform_get_drvdata(pdev);
-	if (wdt->state & TWL4030_WDT_STATE_ACTIVE)
-		return twl4030_wdt_enable(wdt);
+	struct watchdog_device *wdt = platform_get_drvdata(pdev);
+	if (watchdog_active(wdt))
+		return twl4030_wdt_start(wdt);
 
 	return 0;
 }
@@ -260,6 +146,5 @@ module_platform_driver(twl4030_wdt_driver);
 
 MODULE_AUTHOR("Nokia Corporation");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
 MODULE_ALIAS("platform:twl4030_wdt");
 
-- 
1.7.10.4

