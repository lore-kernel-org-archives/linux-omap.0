From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] cbus-retu-wdt: Fix bitfield access
Date: Wed, 02 Mar 2011 17:11:53 +0100
Message-ID: <1299082313.13604.13.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:45230 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603Ab1CBQLz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 11:11:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

An unsigned int pointer must not be casted to an unsigned
long pointer before use. Convert the bitfield to unsigned long
to fix this.
Also use clear_bit() in the release path.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

Index: linux-2.6.38-rc6/drivers/cbus/retu-wdt.c
===================================================================
--- linux-2.6.38-rc6.orig/drivers/cbus/retu-wdt.c	2011-03-02 16:46:24.574676092 +0100
+++ linux-2.6.38-rc6/drivers/cbus/retu-wdt.c	2011-03-02 16:48:17.469807413 +0100
@@ -56,7 +56,7 @@ static int counter_param = RETU_WDT_MAX_
 
 struct retu_wdt_dev {
 	struct device		*dev;
-	int			users;
+	unsigned long		users;
 	struct miscdevice	retu_wdt_miscdev;
 	struct delayed_work	ping_work;
 };
@@ -161,7 +161,7 @@ static DEVICE_ATTR(counter, S_IRUGO, ret
 
 static int retu_wdt_open(struct inode *inode, struct file *file)
 {
-	if (test_and_set_bit(1, (unsigned long *)&(retu_wdt->users)))
+	if (test_and_set_bit(0, &retu_wdt->users))
 		return -EBUSY;
 
 	file->private_data = (void *)retu_wdt;
@@ -177,7 +177,7 @@ static int retu_wdt_release(struct inode
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
 	retu_wdt_ping_enable(retu_wdt);
 #endif
-	wdev->users = 0;
+	clear_bit(0, &retu_wdt->users);
 
 	return 0;
 }
@@ -264,7 +264,6 @@ static int __init retu_wdt_probe(struct
 		return -ENOMEM;
 
 	wdev->dev = &pdev->dev;
-	wdev->users = 0;
 
 	ret = device_create_file(&pdev->dev, &dev_attr_period);
 	if (ret) {

-- 
Greetings, Michael.


