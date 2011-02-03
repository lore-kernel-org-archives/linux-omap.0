From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/RFC/PATCH 03/13] cbus: retu: move module_* close to the matching symbol
Date: Thu,  3 Feb 2011 12:20:18 +0200
Message-ID: <1296728428-26399-4-git-send-email-balbi@ti.com>
References: <1296728428-26399-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:51016 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756132Ab1BCKUm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 05:20:42 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so1057084fxm.33
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 02:20:41 -0800 (PST)
In-Reply-To: <1296728428-26399-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Just to make checkpatch.pl a bit happier, move
subsys_initcall() and module_exit() closer to
the init and exit functions of the driver.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 39d4fa4..0053d43 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -498,25 +498,16 @@ static struct platform_driver retu_driver = {
 	},
 };
 
-/**
- * retu_init - initialise Retu driver
- *
- * Initialise the Retu driver and return 0 if everything worked ok
- */
 static int __init retu_init(void)
 {
 	return platform_driver_probe(&retu_driver, retu_probe);
 }
+subsys_initcall(retu_init);
 
-/*
- * Cleanup
- */
 static void __exit retu_exit(void)
 {
 	platform_driver_unregister(&retu_driver);
 }
-
-subsys_initcall(retu_init);
 module_exit(retu_exit);
 
 MODULE_DESCRIPTION("Retu ASIC control");
-- 
1.7.4.rc2

