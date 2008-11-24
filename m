From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc6-omap] sync isp1301_omap with mainlne
Date: Mon, 24 Nov 2008 10:32:49 -0800
Message-ID: <200811241032.50037.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:27062 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751745AbYKXScw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Nov 2008 13:32:52 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Sync OMAP git with mainline ... build tested.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
This will help with an upcoming patch to move this to drivers/usb/otg.

 drivers/i2c/chips/isp1301_omap.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -32,7 +32,6 @@
 #include <linux/usb/otg.h>
 #include <linux/i2c.h>
 #include <linux/workqueue.h>
-#include <linux/io.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
