From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 17/22] cbus: tahvo: no need to mask interrupts on exit
Date: Mon, 11 Jul 2011 14:17:30 +0300
Message-ID: <1310383055-20211-18-git-send-email-balbi@ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:60477 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754511Ab1GKLTK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:19:10 -0400
Received: by mail-gy0-f177.google.com with SMTP id 4so1700538gyh.8
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 04:19:09 -0700 (PDT)
In-Reply-To: <1310383055-20211-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <mb@bu3sch.de>, Felipe Balbi <balbi@ti.com>

the children will be unloaded first and they
will make sure to mask their own IRQ.

While at that, also move subsys_init_call()
close to tahvo_init().

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index d92a05d..ab6e7ea 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -470,8 +470,6 @@ static int __devexit tahvo_remove(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 
-	/* Mask all TAHVO interrupts */
-	__tahvo_write_reg(tahvo, TAHVO_REG_IMR, 0xffff);
 	free_irq(irq, 0);
 	irq_free_descs(tahvo->irq_base, MAX_TAHVO_IRQ_HANDLERS);
 	kfree(tahvo);
@@ -491,13 +489,12 @@ static int __init tahvo_init(void)
 {
 	return platform_driver_probe(&tahvo_driver, tahvo_probe);
 }
+subsys_initcall(tahvo_init);
 
 static void __exit tahvo_exit(void)
 {
 	platform_driver_unregister(&tahvo_driver);
 }
-
-subsys_initcall(tahvo_init);
 module_exit(tahvo_exit);
 
 MODULE_DESCRIPTION("Tahvo ASIC control");
-- 
1.7.6

