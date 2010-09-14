From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 2/8] cbus: remove device_release completion
Date: Tue, 14 Sep 2010 11:30:10 +0300
Message-ID: <1284453016-8295-3-git-send-email-balbi@ti.com>
References: <1284453016-8295-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46584 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062Ab0INIa1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Sep 2010 04:30:27 -0400
In-Reply-To: <1284453016-8295-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

We don't do anything before releasing the device
so we might as well return as soon as possible.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index bc81a9b..15368dc 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -56,8 +56,6 @@ static int retu_is_vilma;
 static struct tasklet_struct retu_tasklet;
 spinlock_t retu_lock = SPIN_LOCK_UNLOCKED;
 
-static struct completion device_release;
-
 struct retu_irq_handler_desc {
 	int (*func)(unsigned long);
 	unsigned long arg;
@@ -491,11 +489,6 @@ static int __devexit retu_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void retu_device_release(struct device *dev)
-{
-	complete(&device_release);
-}
-
 static struct platform_driver retu_driver = {
 	.probe		= retu_probe,
 	.remove		= __devexit_p(retu_remove),
@@ -507,9 +500,6 @@ static struct platform_driver retu_driver = {
 static struct platform_device retu_device = {
 	.name		= "retu",
 	.id		= -1,
-	.dev = {
-		.release = retu_device_release,
-	}
 };
 
 /**
@@ -525,8 +515,6 @@ static int __init retu_init(void)
 		machine_is_nokia_n810() || machine_is_nokia_n810_wimax()))
 			return -ENODEV;
 
-	init_completion(&device_release);
-
 	ret = platform_driver_register(&retu_driver);
 	if (ret < 0)
 		return ret;
@@ -547,7 +535,6 @@ static void __exit retu_exit(void)
 {
 	platform_device_unregister(&retu_device);
 	platform_driver_unregister(&retu_driver);
-	wait_for_completion(&device_release);
 }
 
 subsys_initcall(retu_init);
-- 
1.7.3.rc0.35.g8ac8c

