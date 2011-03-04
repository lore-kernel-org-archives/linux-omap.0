From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] cbus-retu-wdt: Constify watchdog_info structure
Date: Fri, 04 Mar 2011 16:33:27 +0100
Message-ID: <1299252807.21644.12.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:45706 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800Ab1CDPda (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 10:33:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Nobody modifies the watchdog_info structure, so make it const.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

---

Index: linux-2.6.38-rc6/drivers/cbus/retu-wdt.c
===================================================================
--- linux-2.6.38-rc6.orig/drivers/cbus/retu-wdt.c	2011-03-04 16:21:39.106113985 +0100
+++ linux-2.6.38-rc6/drivers/cbus/retu-wdt.c	2011-03-04 16:21:48.503540758 +0100
@@ -149,7 +149,7 @@ static long retu_wdt_ioctl(struct file *
 	struct retu_wdt_dev *wdev = container_of(mdev, struct retu_wdt_dev, miscdev);
 	int new_margin;
 
-	static struct watchdog_info ident = {
+	static const struct watchdog_info ident = {
 		.identity = "Retu Watchdog",
 		.options = WDIOF_SETTIMEOUT,
 		.firmware_version = 0,

-- 
Greetings, Michael.


