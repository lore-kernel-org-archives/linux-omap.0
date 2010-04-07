From: felipe.balbi@nokia.com
Subject: [RFC PATCH 32/37] cbus: retu-rtc: move retu_rtc_barrier up on source code
Date: Wed,  7 Apr 2010 19:04:23 +0300
Message-ID: <1270656268-7034-33-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58523 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932886Ab0DGQFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:33 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G58fA004996
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:31 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

... and drop the function prototype.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu-rtc.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index b99c227..90d199e 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -57,7 +57,15 @@ struct retu_rtc {
 
 #define work_to_rtc(r)	(container_of(r, struct retu_rtc, work))
 
-static void retu_rtc_barrier(struct retu_rtc *rtc);
+/* This function provides syncronization with the RTCS interrupt handler */
+static void retu_rtc_barrier(struct retu_rtc *rtc)
+{
+	INIT_COMPLETION(rtc->sync);
+	retu_ack_irq(RETU_INT_RTCS);
+	retu_enable_irq(RETU_INT_RTCS);
+	wait_for_completion(&rtc->sync);
+	retu_disable_irq(RETU_INT_RTCS);
+}
 
 static ssize_t retu_rtc_time_show(struct device *dev, struct device_attribute *attr,
 				  char *buf)
@@ -476,16 +484,6 @@ static struct platform_driver retu_rtc_driver = {
 	},
 };
 
-/* This function provides syncronization with the RTCS interrupt handler */
-static void retu_rtc_barrier(struct retu_rtc *rtc)
-{
-	INIT_COMPLETION(rtc->sync);
-	retu_ack_irq(RETU_INT_RTCS);
-	retu_enable_irq(RETU_INT_RTCS);
-	wait_for_completion(&rtc->sync);
-	retu_disable_irq(RETU_INT_RTCS);
-}
-
 static int __init retu_rtc_init(void)
 {
 	return platform_driver_register(&retu_rtc_driver);
-- 
1.7.0.rc0.33.g7c3932

