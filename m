From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] cbus-retu-wdt: Fix unused-variable-warning
Date: Fri, 04 Mar 2011 15:53:01 +0100
Message-ID: <1299250381.21644.5.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:58049 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759427Ab1CDOxE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 09:53:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

This fixes an "unused variable" warning. No change
in functionality.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

Index: linux-2.6.38-rc6/drivers/cbus/retu-wdt.c
===================================================================
--- linux-2.6.38-rc6.orig/drivers/cbus/retu-wdt.c	2011-03-04 15:46:21.312816961 +0100
+++ linux-2.6.38-rc6/drivers/cbus/retu-wdt.c	2011-03-04 15:46:54.658384947 +0100
@@ -124,9 +124,9 @@ static int retu_wdt_release(struct inode
 	struct retu_wdt_dev *wdev = file->private_data;
 
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
-	retu_wdt_ping_enable(retu_wdt);
+	retu_wdt_ping_enable(wdev);
 #endif
-	clear_bit(0, &retu_wdt->users);
+	clear_bit(0, &wdev->users);
 
 	return 0;
 }


-- 
Greetings, Michael.


