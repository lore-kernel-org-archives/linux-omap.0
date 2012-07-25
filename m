From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/6] w1: omap-hdq: convert to module_platform_driver
Date: Wed, 25 Jul 2012 15:05:29 +0300
Message-ID: <1343217932-25372-3-git-send-email-balbi@ti.com>
References: <1343217932-25372-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:53369 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932721Ab2GYMIx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jul 2012 08:08:53 -0400
Received: by lahi5 with SMTP id i5so458922lah.28
        for <linux-omap@vger.kernel.org>; Wed, 25 Jul 2012 05:08:50 -0700 (PDT)
In-Reply-To: <1343217932-25372-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: zbr@ioremap.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

trivial patch, no functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/w1/masters/omap_hdq.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 404a4de..1ebddcf 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -654,19 +654,7 @@ static int __devexit omap_hdq_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __init
-omap_hdq_init(void)
-{
-	return platform_driver_register(&omap_hdq_driver);
-}
-module_init(omap_hdq_init);
-
-static void __exit
-omap_hdq_exit(void)
-{
-	platform_driver_unregister(&omap_hdq_driver);
-}
-module_exit(omap_hdq_exit);
+module_platform_driver(omap_hdq_driver);
 
 module_param(w1_id, int, S_IRUSR);
 MODULE_PARM_DESC(w1_id, "1-wire id for the slave detection");
-- 
1.7.11

