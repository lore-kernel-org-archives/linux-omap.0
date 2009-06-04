From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 1/2] omap: twl4030_wdt: twl4030 watchdog driver
Date: Thu, 4 Jun 2009 20:32:46 +0200
Message-ID: <20090604183246.GA23371@infomag.iguana.be>
References: <1238164938-11932-1-git-send-email-ext-atal.shargorodsky@nokia.com> <b207c8283f0172e6b64c06fe6ac2e4bf9eedf875.1238163923.git.ext-atal.shargorodsky@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:51420 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750785AbZFDScq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 14:32:46 -0400
Content-Disposition: inline
In-Reply-To: <b207c8283f0172e6b64c06fe6ac2e4bf9eedf875.1238163923.git.ext-atal.shargorodsky@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, David Brownell <dbrownell@users.sourceforge.net>
Cc: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>, linux-omap@vger.kernel.org, Timo Kokkonen <timo.t.kokkonen@nokia.com>

Hi Russell, Samuel, David,

I reviewed the twl watchdog driver written by Timo and Atal (reviewed version - see below).
could you review them also (arm driver and touches drivers/mfd/twl4030-core).

Thanks in advance,
Wim.

---
commit ca1a9726d1e0655c39d07f8b77659c5d017748cb
Author: Timo Kokkonen <timo.t.kokkonen@nokia.com>
Date:   Fri Mar 27 16:42:17 2009 +0200

    [WATCHDOG] twl4030 watchdog driver
    
    Implementation of twl4030 watchdog driver.
    
    Signed-off-by: Timo Kokkonen <timo.t.kokkonen@nokia.com>
    Signed-off-by: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
index ec90e95..b8df518 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -101,6 +101,12 @@
 #define twl_has_usb()	false
 #endif
 
+#if defined(CONFIG_TWL4030_WATCHDOG) || \
+	defined(CONFIG_TWL4030_WATCHDOG_MODULE)
+#define twl_has_watchdog()        true
+#else
+#define twl_has_watchdog()        false
+#endif
 
 /* Triton Core internal information (BEGIN) */
 
@@ -526,6 +532,12 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 		usb_transceiver = child;
 	}
 
+	if (twl_has_watchdog()) {
+		child = add_child(0, "twl4030_wdt", NULL, 0, false, 0, 0);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+	}
+
 	if (twl_has_regulator()) {
 		/*
 		child = add_regulator(TWL4030_REG_VPLL1, pdata->vpll1);
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9f6766b..d92bf63 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -250,6 +250,13 @@ config COH901327_WATCHDOG
 	  This watchdog is used to reset the system and thus cannot be
 	  compiled as a module.
 
+config TWL4030_WATCHDOG
+	tristate "TWL4030 Watchdog"
+	depends on TWL4030_CORE
+	help
+	  Support for TI TWL4030 watchdog.  Say 'Y' here to enable the
+	  watchdog timer support for TWL4030 chips.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 8d75e62..9eb74b7 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
 obj-$(CONFIG_AT91RM9200_WATCHDOG) += at91rm9200_wdt.o
 obj-$(CONFIG_AT91SAM9X_WATCHDOG) += at91sam9_wdt.o
 obj-$(CONFIG_OMAP_WATCHDOG) += omap_wdt.o
+obj-$(CONFIG_TWL4030_WATCHDOG) += twl4030_wdt.o
 obj-$(CONFIG_21285_WATCHDOG) += wdt285.o
 obj-$(CONFIG_977_WATCHDOG) += wdt977.o
 obj-$(CONFIG_IXP2000_WATCHDOG) += ixp2000_wdt.o
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
new file mode 100644
index 0000000..cb46556
--- /dev/null
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -0,0 +1,272 @@
+/*
+ * Copyright (C) Nokia Corporation
+ *
+ * Written by Timo Kokkonen <timo.t.kokkonen at nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/watchdog.h>
+#include <linux/platform_device.h>
+#include <linux/miscdevice.h>
+#include <linux/uaccess.h>
+#include <linux/i2c/twl4030.h>
+
+#define TWL4030_WATCHDOG_CFG_REG_OFFS	0x3
+
+#define TWL4030_WDT_STATE_OPEN		0x1
+#define TWL4030_WDT_STATE_ACTIVE	0x8
+
+static struct platform_device *twl4030_wdt_dev;
+
+struct twl4030_wdt {
+	struct miscdevice	miscdev;
+	int			timer_margin;
+	unsigned long		state;
+};
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
+	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static int twl4030_wdt_write(unsigned char val)
+{
+	return twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, val,
+					TWL4030_WATCHDOG_CFG_REG_OFFS);
+}
+
+static int twl4030_wdt_enable(struct twl4030_wdt *wdt)
+{
+	return twl4030_wdt_write(wdt->timer_margin + 1);
+}
+
+static int twl4030_wdt_disable(struct twl4030_wdt *wdt)
+{
+	return twl4030_wdt_write(0);
+}
+
+static int twl4030_wdt_set_timeout(struct twl4030_wdt *wdt, int timeout)
+{
+	if (timeout < 0 || timeout > 30) {
+		dev_warn(wdt->miscdev.parent,
+			"Timeout can only be in the range [0-30] seconds");
+		return -EINVAL;
+	}
+	wdt->timer_margin = timeout;
+	return twl4030_wdt_enable(wdt);
+}
+
+static ssize_t twl4030_wdt_write_fop(struct file *file,
+		const char __user *data, size_t len, loff_t *ppos)
+{
+	struct twl4030_wdt *wdt = file->private_data;
+
+	if (len)
+		twl4030_wdt_enable(wdt);
+
+	return len;
+}
+
+static long twl4030_wdt_ioctl(struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	int new_margin;
+	struct twl4030_wdt *wdt = file->private_data;
+
+	static const struct watchdog_info twl4030_wd_ident = {
+		.identity = "TWL4030 Watchdog",
+		.options = WDIOF_SETTIMEOUT,
+		.firmware_version = 0,
+	};
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		return copy_to_user(argp, &twl4030_wd_ident,
+				sizeof(twl4030_wd_ident)) ? -EFAULT : 0;
+
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		return put_user(0, p);
+
+	case WDIOC_KEEPALIVE:
+		twl4030_wdt_enable(wdt);
+		break;
+
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_margin, p))
+			return -EFAULT;
+		if (twl4030_wdt_set_timeout(wdt, new_margin))
+			return -EINVAL;
+		return put_user(wdt->timer_margin, p);
+
+	case WDIOC_GETTIMEOUT:
+		return put_user(wdt->timer_margin, p);
+
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+static int twl4030_wdt_open(struct inode *inode, struct file *file)
+{
+	struct twl4030_wdt *wdt = platform_get_drvdata(twl4030_wdt_dev);
+
+	/* /dev/watchdog can only be opened once */
+	if (test_and_set_bit(0, &wdt->state))
+		return -EBUSY;
+
+	wdt->state |= TWL4030_WDT_STATE_ACTIVE;
+	file->private_data = (void *) wdt;
+
+	twl4030_wdt_enable(wdt);
+	return nonseekable_open(inode, file);
+}
+
+static int twl4030_wdt_release(struct inode *inode, struct file *file)
+{
+	struct twl4030_wdt *wdt = file->private_data;
+	if (nowayout) {
+		dev_alert(wdt->miscdev.parent,
+		       "Unexpected close, watchdog still running!\n");
+		twl4030_wdt_enable(wdt);
+	} else {
+		if (twl4030_wdt_disable(wdt))
+			return -EFAULT;
+		wdt->state &= ~TWL4030_WDT_STATE_ACTIVE;
+	}
+
+	clear_bit(0, &wdt->state);
+	return 0;
+}
+
+static const struct file_operations twl4030_wdt_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.open		= twl4030_wdt_open,
+	.release	= twl4030_wdt_release,
+	.unlocked_ioctl	= twl4030_wdt_ioctl,
+	.write		= twl4030_wdt_write_fop,
+};
+
+static int __devinit twl4030_wdt_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct twl4030_wdt *wdt;
+
+	wdt = kzalloc(sizeof(struct twl4030_wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->state		= 0;
+	wdt->timer_margin	= 30;
+	wdt->miscdev.parent	= &pdev->dev;
+	wdt->miscdev.fops	= &twl4030_wdt_fops;
+	wdt->miscdev.minor	= WATCHDOG_MINOR;
+	wdt->miscdev.name	= "watchdog";
+
+	platform_set_drvdata(pdev, wdt);
+
+	twl4030_wdt_dev = pdev;
+
+	ret = misc_register(&wdt->miscdev);
+	if (ret) {
+		dev_err(wdt->miscdev.parent,
+			"Failed to register misc device\n");
+		platform_set_drvdata(pdev, NULL);
+		kfree(wdt);
+		twl4030_wdt_dev = NULL;
+		return ret;
+	}
+	return 0;
+}
+
+static int __devexit twl4030_wdt_remove(struct platform_device *pdev)
+{
+	struct twl4030_wdt *wdt = platform_get_drvdata(pdev);
+
+	if (wdt->state & TWL4030_WDT_STATE_ACTIVE)
+		if (twl4030_wdt_disable(wdt))
+			return -EFAULT;
+
+	wdt->state &= ~TWL4030_WDT_STATE_ACTIVE;
+	misc_deregister(&wdt->miscdev);
+
+	platform_set_drvdata(pdev, NULL);
+	kfree(wdt);
+	twl4030_wdt_dev = NULL;
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int twl4030_wdt_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct twl4030_wdt *wdt = platform_get_drvdata(pdev);
+	if (wdt->state & TWL4030_WDT_STATE_ACTIVE)
+		return twl4030_wdt_disable(wdt);
+
+	return 0;
+}
+
+static int twl4030_wdt_resume(struct platform_device *pdev)
+{
+	struct twl4030_wdt *wdt = platform_get_drvdata(pdev);
+	if (wdt->state & TWL4030_WDT_STATE_ACTIVE)
+		return twl4030_wdt_enable(wdt);
+
+	return 0;
+}
+#else
+#define twl4030_wdt_suspend        NULL
+#define twl4030_wdt_resume         NULL
+#endif
+
+static struct platform_driver twl4030_wdt_driver = {
+	.probe		= twl4030_wdt_probe,
+	.remove		= __devexit_p(twl4030_wdt_remove),
+	.suspend	= twl4030_wdt_suspend,
+	.resume		= twl4030_wdt_resume,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "twl4030_wdt",
+	},
+};
+
+static int __devinit twl4030_wdt_init(void)
+{
+	return platform_driver_register(&twl4030_wdt_driver);
+}
+module_init(twl4030_wdt_init);
+
+static void __devexit twl4030_wdt_exit(void)
+{
+	platform_driver_unregister(&twl4030_wdt_driver);
+}
+module_exit(twl4030_wdt_exit);
+
+MODULE_AUTHOR("Nokia Corporation");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+MODULE_ALIAS("platform:twl4030_wdt");
+
