From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH v2 03/12] cbus: retu: move module_* close to the matching symbol
Date: Fri,  7 Jan 2011 11:08:01 +0200
Message-ID: <1294391290-7285-4-git-send-email-balbi@ti.com>
References: <1294391290-7285-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:41097 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753737Ab1AGJI0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 04:08:26 -0500
Received: by eye27 with SMTP id 27so7564760eye.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 01:08:24 -0800 (PST)
In-Reply-To: <1294391290-7285-1-git-send-email-balbi@ti.com>
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
1.7.3.4.598.g85356

