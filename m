From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.26-mmotm] rtc: rtc-omap footprint shrinkage
Date: Tue, 1 Jul 2008 23:42:42 -0700
Message-ID: <200807012342.42829.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:39117 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754227AbYGBGmo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2008 02:42:44 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: rtc-linux@googlegroups.com, linux-omap@vger.kernel.org

Shrink the runtime footprint of the OMAP1 RTC driver a bunch by
removing some old hacks and switching to platform_driver_probe().

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/rtc/rtc-omap.c |   21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

--- a/drivers/rtc/rtc-omap.c	2008-06-30 16:44:28.000000000 -0700
+++ b/drivers/rtc/rtc-omap.c	2008-06-30 21:37:19.000000000 -0700
@@ -93,18 +93,6 @@
 #define rtc_write(val, addr)	omap_writeb(val, OMAP_RTC_BASE + (addr))
 
 
-/* platform_bus isn't hotpluggable, so for static linkage it'd be safe
- * to get rid of probe() and remove() code ... too bad the driver struct
- * remembers probe(), that's about 25% of the runtime footprint!!
- */
-#ifndef	MODULE
-#undef	__devexit
-#undef	__devexit_p
-#define	__devexit	__exit
-#define	__devexit_p	__exit_p
-#endif
-
-
 /* we rely on the rtc framework to handle locking (rtc->ops_lock),
  * so the only other requirement is that register accesses which
  * require BUSY to be clear are made with IRQs locally disabled
@@ -325,7 +313,7 @@ static struct rtc_class_ops omap_rtc_ops
 static int omap_rtc_alarm;
 static int omap_rtc_timer;
 
-static int __devinit omap_rtc_probe(struct platform_device *pdev)
+static int __init omap_rtc_probe(struct platform_device *pdev)
 {
 	struct resource		*res, *mem;
 	struct rtc_device	*rtc;
@@ -441,7 +429,7 @@ fail:
 	return -EIO;
 }
 
-static int __devexit omap_rtc_remove(struct platform_device *pdev)
+static int __exit omap_rtc_remove(struct platform_device *pdev)
 {
 	struct rtc_device	*rtc = platform_get_drvdata(pdev);;
 
@@ -499,8 +487,7 @@ static void omap_rtc_shutdown(struct pla
 
 MODULE_ALIAS("platform:omap_rtc");
 static struct platform_driver omap_rtc_driver = {
-	.probe		= omap_rtc_probe,
-	.remove		= __devexit_p(omap_rtc_remove),
+	.remove		= __exit_p(omap_rtc_remove),
 	.suspend	= omap_rtc_suspend,
 	.resume		= omap_rtc_resume,
 	.shutdown	= omap_rtc_shutdown,
@@ -512,7 +499,7 @@ static struct platform_driver omap_rtc_d
 
 static int __init rtc_init(void)
 {
-	return platform_driver_register(&omap_rtc_driver);
+	return platform_driver_probe(&omap_rtc_driver, omap_rtc_probe);
 }
 module_init(rtc_init);
 
