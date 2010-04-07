From: felipe.balbi@nokia.com
Subject: [RFC PATCH 27/37] cbus: retu-headset: simplify module_init
Date: Wed,  7 Apr 2010 19:04:18 +0300
Message-ID: <1270656268-7034-28-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62336 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932728Ab0DGQFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:22 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G56B6007315
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 11:05:21 -0500
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

it's enough to have it as:

return platform_driver_register();

in case of failure, platform code should print
any necessary info.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu-headset.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index e798bc2..1def743 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -331,15 +331,7 @@ static struct platform_driver retu_headset_driver = {
 
 static int __init retu_headset_init(void)
 {
-	int r;
-
-	printk(KERN_INFO "Retu/Vilma headset driver initializing\n");
-
-	r = platform_driver_register(&retu_headset_driver);
-	if (r < 0)
-		return r;
-
-	return 0;
+	return platform_driver_register(&retu_headset_driver);
 }
 
 static void __exit retu_headset_exit(void)
-- 
1.7.0.rc0.33.g7c3932

