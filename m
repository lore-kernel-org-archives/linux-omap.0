From: felipe.balbi@nokia.com
Subject: [RFC PATCH 14/37] cbus: retu-wdt: fix compile breakage
Date: Wed,  7 Apr 2010 19:04:05 +0300
Message-ID: <1270656268-7034-15-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42745 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932851Ab0DGQFU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:20 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G5990030675
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:17 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

fix compile breakage on retu-wdt driver.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu-wdt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 35932dd..380fae6 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -243,7 +243,6 @@ static int __init retu_wdt_ping(void)
 
 	return 0;
 }
-late_initcall(retu_wdt_ping);
 
 static const struct file_operations retu_wdt_fops = {
 	.owner = THIS_MODULE,
@@ -369,7 +368,8 @@ static int __init retu_wdt_init(void)
 	}
 
 	printk(KERN_INFO "Retu watchdog driver initialized\n");
-	return ret;
+
+	return retu_wdt_ping();
 
 exit1:
 	driver_unregister(&retu_wdt_driver);
-- 
1.7.0.rc0.33.g7c3932

