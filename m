From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 3/5] watchdog: move omap_wdt.h to include/linux/watchdog
Date: Fri, 19 Sep 2008 01:23:40 +0300
Message-ID: <1221776622-22906-4-git-send-email-me@felipebalbi.com>
References: <1221776622-22906-1-git-send-email-me@felipebalbi.com>
 <1221776622-22906-2-git-send-email-me@felipebalbi.com>
 <1221776622-22906-3-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:41039 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbYIRWYK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 18:24:10 -0400
In-Reply-To: <1221776622-22906-3-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "George G. Davis" <gdavis@mvista.com>, Russell King <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Create a new include/linux/watchdog directory
for holding watchdog chips headers, move omap_wdt.h
to the new location and update the include patch in
the driver source.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/watchdog/omap_wdt.c                    |    3 +--
 {drivers => include/linux}/watchdog/omap_wdt.h |    4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)
 rename {drivers => include/linux}/watchdog/omap_wdt.h (95%)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index e395743..f21fd94 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -33,6 +33,7 @@
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
+#include <linux/watchdog/omap_wdt.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/err.h>
@@ -47,8 +48,6 @@
 
 #include <mach/prcm.h>
 
-#include "omap_wdt.h"
-
 static struct platform_device *omap_wdt_dev;
 
 static unsigned timer_margin;
diff --git a/drivers/watchdog/omap_wdt.h b/include/linux/watchdog/omap_wdt.h
similarity index 95%
rename from drivers/watchdog/omap_wdt.h
rename to include/linux/watchdog/omap_wdt.h
index fc02ec6..62e6a74 100644
--- a/drivers/watchdog/omap_wdt.h
+++ b/include/linux/watchdog/omap_wdt.h
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/char/watchdog/omap_wdt.h
+ *  include/linux/watchdog/omap_wdt.h
  *
  *  BRIEF MODULE DESCRIPTION
  *      OMAP Watchdog timer register definitions
@@ -44,7 +44,7 @@
  * months before firing.  These limits work without scaling,
  * with the 60 second default assumed by most tools and docs.
  */
-#define TIMER_MARGIN_MAX    	(24 * 60 * 60)	/* 1 day */
+#define TIMER_MARGIN_MAX	(24 * 60 * 60)	/* 1 day */
 #define TIMER_MARGIN_DEFAULT	60	/* 60 secs */
 #define TIMER_MARGIN_MIN	1
 
-- 
1.6.0.1.196.g01914

