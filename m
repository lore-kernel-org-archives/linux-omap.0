From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc8-omap 1/7] rtc-twl4030 header cleanup
Date: Fri, 3 Oct 2008 08:58:26 -0700
Message-ID: <200810030858.26531.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:32604 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752687AbYJCQbf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 12:31:35 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Portability fixes (simplifications) for rtc-twl4030:  don't include
so many needless headers, especially platform-specific ones.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/rtc/rtc-twl4030.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -21,23 +21,15 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/ioport.h>
-#include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/platform_device.h>
-#include <linux/spinlock.h>
 #include <linux/interrupt.h>
-#include <linux/device.h>
+
 #include <linux/i2c/twl4030.h>
 #include <linux/i2c/twl4030-rtc.h>
-#include <linux/io.h>
-#include <linux/irq.h>
 
-#include <asm/mach/time.h>
-#include <asm/system.h>
-#include <mach/hardware.h>
 
 #define ALL_TIME_REGS		6
 
