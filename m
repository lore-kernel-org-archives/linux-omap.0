From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc7-omap1-git] rtc-twl4030 portability updates
Date: Sun, 28 Sep 2008 14:35:47 -0700
Message-ID: <200809281435.47824.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:42639 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752250AbYI1Vfu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 28 Sep 2008 17:35:50 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

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
 
