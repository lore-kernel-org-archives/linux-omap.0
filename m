From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH] watchdog: fix typo in omap_wdt.c
Date: Fri, 26 Sep 2008 21:20:14 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC959A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37180 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbYIZPuq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 11:50:46 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

From: Anand Gadiyar <gadiyar@ti.com>

Fix typo in omap_wdt.c introduced by a recent change

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 drivers/watchdog/omap_wdt.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: tony/drivers/watchdog/omap_wdt.c
===================================================================
--- tony.orig/drivers/watchdog/omap_wdt.c	2008-09-25 16:45:08.000000000 +0530
+++ tony/drivers/watchdog/omap_wdt.c	2008-09-26 21:14:48.059042569 +0530
@@ -283,7 +283,7 @@ static int __init omap_wdt_probe(struct 
 	}
 
 	if (omap_wdt_dev) {
-		ret - EBUSY;
+		ret = -EBUSY;
 		goto err_busy;
 	}
 