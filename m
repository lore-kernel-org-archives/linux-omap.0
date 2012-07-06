From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] drivers/rtc/rtc-twl.c: fix threaded IRQ to use IRQF_ONESHOT
Date: Fri,  6 Jul 2012 09:33:54 -0700
Message-ID: <1341592434-4207-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:46478 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757868Ab2GFQd5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 12:33:57 -0400
Received: by pbbrr13 with SMTP id rr13so18258542pbb.26
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 09:33:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Requesting a threaded interrupt without a primary handler and without
IRQF_ONESHOT is dangerous, and after commit 1c6c6952 (genirq: Reject
bogus threaded irq requests), these requests are rejected.  This
causes ->probe() to fail, and the RTC driver not to be availble.

To fix, add IRQF_ONESHOT to the IRQ flags.

Tested on OMAP3730/OveroSTORM and OMAP4430/Panda board using rtcwake
to wake from system suspend multiple times.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Resending to broader audience and including Andrew.  Since, I understand
that drivers/rtc is somewhat orphaned, Andrew, can you queue this fix for
v3.5.  Thanks.

 drivers/rtc/rtc-twl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 258abea..c5d06fe 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -510,7 +510,7 @@ static int __devinit twl_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = request_threaded_irq(irq, NULL, twl_rtc_interrupt,
-				   IRQF_TRIGGER_RISING,
+				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 				   dev_name(&rtc->dev), rtc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "IRQ is not free.\n");
-- 
1.7.9.2

