From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 6/8] cbus: tahvo: remove device_release
Date: Tue, 14 Sep 2010 11:30:14 +0300
Message-ID: <1284453016-8295-7-git-send-email-balbi@ti.com>
References: <1284453016-8295-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42778 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304Ab0INIag (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Sep 2010 04:30:36 -0400
In-Reply-To: <1284453016-8295-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

it's useless as we don't do anything besides
wait_for_completion(). Remove it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 7d49252..7c57ca4 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -56,8 +56,6 @@ static int tahvo_is_betty;
 static struct tasklet_struct tahvo_tasklet;
 spinlock_t tahvo_lock = SPIN_LOCK_UNLOCKED;
 
-static struct completion device_release;
-
 struct tahvo_irq_handler_desc {
 	int (*func)(unsigned long);
 	unsigned long arg;
@@ -388,11 +386,6 @@ static int __devexit tahvo_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void tahvo_device_release(struct device *dev)
-{
-	complete(&device_release);
-}
-
 static struct platform_driver tahvo_driver = {
 	.probe		= tahvo_probe,
 	.remove		= __devexit_p(tahvo_remove),
@@ -404,9 +397,6 @@ static struct platform_driver tahvo_driver = {
 static struct platform_device tahvo_device = {
 	.name		= "tahvo",
 	.id		= -1,
-	.dev = {
-		.release = tahvo_device_release,
-	}
 };
 
 /**
@@ -422,8 +412,6 @@ static int __init tahvo_init(void)
 		machine_is_nokia_n810() || machine_is_nokia_n810_wimax()))
 			return -ENODEV;
 
-	init_completion(&device_release);
-
 	ret = platform_driver_register(&tahvo_driver);
 	if (ret)
 		return ret;
@@ -443,7 +431,6 @@ static void __exit tahvo_exit(void)
 {
 	platform_device_unregister(&tahvo_device);
 	platform_driver_unregister(&tahvo_driver);
-	wait_for_completion(&device_release);
 }
 
 subsys_initcall(tahvo_init);
-- 
1.7.3.rc0.35.g8ac8c

