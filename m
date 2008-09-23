From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 3/3] watchdog: cleanup a bit omap_wdt.c
Date: Tue, 23 Sep 2008 14:33:51 +0300
Message-ID: <1222169631-24556-4-git-send-email-felipe.balbi@nokia.com>
References: <1222169631-24556-1-git-send-email-felipe.balbi@nokia.com>
 <1222169631-24556-2-git-send-email-felipe.balbi@nokia.com>
 <1222169631-24556-3-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35144 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbYIWLe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 07:34:28 -0400
In-Reply-To: <1222169631-24556-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <felipe.balbi@nokia.com>

Trivial cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/watchdog/omap_wdt.c |  136 +++++++++++++++++++++++++------------------
 1 files changed, 79 insertions(+), 57 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index cfb101e..8c02fb0 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/watchdog/omap_wdt.c
+ * omap_wdt.c
  *
  * Watchdog driver for the TI OMAP 16xx & 24xx/34xx 32KHz (non-secure) watchdog
  *
@@ -39,7 +39,6 @@
 #include <linux/platform_device.h>
 #include <linux/moduleparam.h>
 #include <linux/clk.h>
-
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
@@ -71,11 +70,14 @@ struct omap_wdt_dev {
 static void omap_wdt_ping(struct omap_wdt_dev *wdev)
 {
 	void __iomem    *base = wdev->base;
+
 	/* wait for posted write to complete */
 	while ((__raw_readl(base + OMAP_WATCHDOG_WPS)) & 0x08)
 		cpu_relax();
+
 	wdt_trgr_pattern = ~wdt_trgr_pattern;
 	__raw_writel(wdt_trgr_pattern, (base + OMAP_WATCHDOG_TGR));
+
 	/* wait for posted write to complete */
 	while ((__raw_readl(base + OMAP_WATCHDOG_WPS)) & 0x08)
 		cpu_relax();
@@ -84,12 +86,13 @@ static void omap_wdt_ping(struct omap_wdt_dev *wdev)
 
 static void omap_wdt_enable(struct omap_wdt_dev *wdev)
 {
-	void __iomem *base;
-	base = wdev->base;
+	void __iomem *base = wdev->base;
+
 	/* Sequence to enable the watchdog */
 	__raw_writel(0xBBBB, base + OMAP_WATCHDOG_SPR);
 	while ((__raw_readl(base + OMAP_WATCHDOG_WPS)) & 0x10)
 		cpu_relax();
+
 	__raw_writel(0x4444, base + OMAP_WATCHDOG_SPR);
 	while ((__raw_readl(base + OMAP_WATCHDOG_WPS)) & 0x10)
 		cpu_relax();
@@ -97,12 +100,13 @@ static void omap_wdt_enable(struct omap_wdt_dev *wdev)
 
 static void omap_wdt_disable(struct omap_wdt_dev *wdev)
 {
-	void __iomem *base;
-	base = wdev->base;
+	void __iomem *base = wdev->base;
+
 	/* sequence required to disable watchdog */
 	__raw_writel(0xAAAA, base + OMAP_WATCHDOG_SPR);	/* TIMER_MODE */
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x10)
 		cpu_relax();
+
 	__raw_writel(0x5555, base + OMAP_WATCHDOG_SPR);	/* TIMER_MODE */
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x10)
 		cpu_relax();
@@ -120,12 +124,12 @@ static void omap_wdt_adjust_timeout(unsigned new_timeout)
 static void omap_wdt_set_timeout(struct omap_wdt_dev *wdev)
 {
 	u32 pre_margin = GET_WLDR_VAL(timer_margin);
-	void __iomem *base;
-	base = wdev->base;
+	void __iomem *base = wdev->base;
 
 	/* just count up at 32 KHz */
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
 		cpu_relax();
+
 	__raw_writel(pre_margin, base + OMAP_WATCHDOG_LDR);
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
 		cpu_relax();
@@ -134,13 +138,11 @@ static void omap_wdt_set_timeout(struct omap_wdt_dev *wdev)
 /*
  *	Allow only one task to hold it open
  */
-
 static int omap_wdt_open(struct inode *inode, struct file *file)
 {
-	struct omap_wdt_dev *wdev;
-	void __iomem *base;
-	wdev = platform_get_drvdata(omap_wdt_dev);
-	base = wdev->base;
+	struct omap_wdt_dev *wdev = platform_get_drvdata(omap_wdt_dev);
+	void __iomem *base = wdev->base;
+
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
 
@@ -155,6 +157,7 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	/* initialize prescaler */
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
 		cpu_relax();
+
 	__raw_writel((1 << 5) | (PTV << 2), base + OMAP_WATCHDOG_CNTRL);
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
 		cpu_relax();
@@ -163,13 +166,14 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 
 	omap_wdt_set_timeout(wdev);
 	omap_wdt_enable(wdev);
+
 	return nonseekable_open(inode, file);
 }
 
 static int omap_wdt_release(struct inode *inode, struct file *file)
 {
-	struct omap_wdt_dev *wdev;
-	wdev = file->private_data;
+	struct omap_wdt_dev *wdev = file->private_data;
+
 	/*
 	 *      Shut off the timer unless NOWAYOUT is defined.
 	 */
@@ -188,14 +192,15 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
 	printk(KERN_CRIT "omap_wdt: Unexpected close, not stopping!\n");
 #endif
 	wdev->omap_wdt_users = 0;
+
 	return 0;
 }
 
 static ssize_t omap_wdt_write(struct file *file, const char __user *data,
 		size_t len, loff_t *ppos)
 {
-	struct omap_wdt_dev *wdev;
-	wdev = file->private_data;
+	struct omap_wdt_dev *wdev = file->private_data;
+
 	/* Refresh LOAD_TIME. */
 	if (len) {
 		spin_lock(&wdt_lock);
@@ -215,6 +220,7 @@ static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
 		.options = WDIOF_SETTIMEOUT,
 		.firmware_version = 0,
 	};
+
 	wdev = file->private_data;
 
 	switch (cmd) {
@@ -253,7 +259,6 @@ static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
 	default:
 		return -ENOTTY;
 	}
-	return 0;
 }
 
 static const struct file_operations omap_wdt_fops = {
@@ -264,31 +269,37 @@ static const struct file_operations omap_wdt_fops = {
 	.release = omap_wdt_release,
 };
 
-
 static int __init omap_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res, *mem;
-	int ret;
 	struct omap_wdt_dev *wdev;
+	int ret;
 
 	/* reserve static register mappings */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOENT;
+	if (!res) {
+		ret = -ENOENT;
+		goto err_get_resource;
+	}
 
-	if (omap_wdt_dev)
-		return -EBUSY;
+	if (omap_wdt_dev) {
+		ret - EBUSY;
+		goto err_busy;
+	}
 
 	mem = request_mem_region(res->start, res->end - res->start + 1,
 				 pdev->name);
-	if (mem == NULL)
-		return -EBUSY;
+	if (!mem) {
+		ret = -EBUSY;
+		goto err_busy;
+	}
 
 	wdev = kzalloc(sizeof(struct omap_wdt_dev), GFP_KERNEL);
 	if (!wdev) {
 		ret = -ENOMEM;
-		goto fail;
+		goto err_kzalloc;
 	}
+
 	wdev->omap_wdt_users = 0;
 	wdev->mem = mem;
 
@@ -297,7 +308,7 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 		if (IS_ERR(wdev->armwdt_ck)) {
 			ret = PTR_ERR(wdev->armwdt_ck);
 			wdev->armwdt_ck = NULL;
-			goto fail;
+			goto err_clk;
 		}
 	}
 
@@ -306,13 +317,13 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 		if (IS_ERR(wdev->mpu_wdt_ick)) {
 			ret = PTR_ERR(wdev->mpu_wdt_ick);
 			wdev->mpu_wdt_ick = NULL;
-			goto fail;
+			goto err_clk;
 		}
 		wdev->mpu_wdt_fck = clk_get(&pdev->dev, "mpu_wdt_fck");
 		if (IS_ERR(wdev->mpu_wdt_fck)) {
 			ret = PTR_ERR(wdev->mpu_wdt_fck);
 			wdev->mpu_wdt_fck = NULL;
-			goto fail;
+			goto err_clk;
 		}
 	}
 
@@ -321,19 +332,19 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 		if (IS_ERR(wdev->mpu_wdt_ick)) {
 			ret = PTR_ERR(wdev->mpu_wdt_ick);
 			wdev->mpu_wdt_ick = NULL;
-			goto fail;
+			goto err_clk;
 		}
 		wdev->mpu_wdt_fck = clk_get(&pdev->dev, "wdt2_fck");
 		if (IS_ERR(wdev->mpu_wdt_fck)) {
 			ret = PTR_ERR(wdev->mpu_wdt_fck);
 			wdev->mpu_wdt_fck = NULL;
-			goto fail;
+			goto err_clk;
 		}
 	}
 	wdev->base = ioremap(res->start, res->end - res->start + 1);
 	if (!wdev->base) {
 		ret = -ENOMEM;
-		goto fail;
+		goto err_ioremap;
 	}
 
 	platform_set_drvdata(pdev, wdev);
@@ -348,7 +359,7 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 
 	ret = misc_register(&(wdev->omap_wdt_miscdev));
 	if (ret)
-		goto fail;
+		goto err_misc;
 
 	pr_info("OMAP Watchdog Timer Rev 0x%02x: initial timeout %d sec\n",
 		__raw_readl(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
@@ -361,28 +372,34 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 
 	return 0;
 
-fail:
-	if (wdev) {
-		platform_set_drvdata(pdev, NULL);
-		if (wdev->armwdt_ck)
-			clk_put(wdev->armwdt_ck);
-		if (wdev->mpu_wdt_ick)
-			clk_put(wdev->mpu_wdt_ick);
-		if (wdev->mpu_wdt_fck)
-			clk_put(wdev->mpu_wdt_fck);
-		iounmap(wdev->base);
-		kfree(wdev);
-	}
-	if (mem) {
-		release_mem_region(res->start, res->end - res->start + 1);
-	}
+err_misc:
+	platform_set_drvdata(pdev, NULL);
+	iounmap(wdev->base);
+
+err_ioremap:
+	wdev->base = NULL;
+
+err_clk:
+	if (wdev->armwdt_ck)
+		clk_put(wdev->armwdt_ck);
+	if (wdev->mpu_wdt_ick)
+		clk_put(wdev->mpu_wdt_ick);
+	if (wdev->mpu_wdt_fck)
+		clk_put(wdev->mpu_wdt_fck);
+	kfree(wdev);
+
+err_kzalloc:
+	release_mem_region(res->start, res->end - res->start + 1);
+
+err_busy:
+err_get_resource:
+
 	return ret;
 }
 
 static void omap_wdt_shutdown(struct platform_device *pdev)
 {
-	struct omap_wdt_dev *wdev;
-	wdev = platform_get_drvdata(pdev);
+	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
 	if (wdev->omap_wdt_users)
 		omap_wdt_disable(wdev);
@@ -390,8 +407,7 @@ static void omap_wdt_shutdown(struct platform_device *pdev)
 
 static int omap_wdt_remove(struct platform_device *pdev)
 {
-	struct omap_wdt_dev *wdev;
-	wdev = platform_get_drvdata(pdev);
+	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	if (!res)
@@ -400,14 +416,17 @@ static int omap_wdt_remove(struct platform_device *pdev)
 	misc_deregister(&(wdev->omap_wdt_miscdev));
 	release_mem_region(res->start, res->end - res->start + 1);
 	platform_set_drvdata(pdev, NULL);
+
 	if (wdev->armwdt_ck) {
 		clk_put(wdev->armwdt_ck);
 		wdev->armwdt_ck = NULL;
 	}
+
 	if (wdev->mpu_wdt_ick) {
 		clk_put(wdev->mpu_wdt_ick);
 		wdev->mpu_wdt_ick = NULL;
 	}
+
 	if (wdev->mpu_wdt_fck) {
 		clk_put(wdev->mpu_wdt_fck);
 		wdev->mpu_wdt_fck = NULL;
@@ -416,6 +435,7 @@ static int omap_wdt_remove(struct platform_device *pdev)
 
 	kfree(wdev);
 	omap_wdt_dev = NULL;
+
 	return 0;
 }
 
@@ -429,21 +449,23 @@ static int omap_wdt_remove(struct platform_device *pdev)
 
 static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct omap_wdt_dev *wdev;
-	wdev = platform_get_drvdata(pdev);
+	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
+
 	if (wdev->omap_wdt_users)
 		omap_wdt_disable(wdev);
+
 	return 0;
 }
 
 static int omap_wdt_resume(struct platform_device *pdev)
 {
-	struct omap_wdt_dev *wdev;
-	wdev = platform_get_drvdata(pdev);
+	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
+
 	if (wdev->omap_wdt_users) {
 		omap_wdt_enable(wdev);
 		omap_wdt_ping(wdev);
 	}
+
 	return 0;
 }
 
-- 
1.6.0.1.308.gede4c

