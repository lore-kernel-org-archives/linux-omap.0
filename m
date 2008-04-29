From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: [PATCH]Correction to BQ27000 battery device name
Date: Tue, 29 Apr 2008 14:26:58 +0530
Message-ID: <006001c8a9d6$fb592cc0$b28818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39458 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759233AbYD2I5J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Apr 2008 04:57:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

This patch changes the device name as the bq27000 chip is not omap specific.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>

---
 drivers/w1/slaves/w1_bq27000.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap-2.6/drivers/w1/slaves/w1_bq27000.c
===================================================================
--- linux-omap-2.6.orig/drivers/w1/slaves/w1_bq27000.c	2008-04-29 11:22:42.000000000 +0530
+++ linux-omap-2.6/drivers/w1/slaves/w1_bq27000.c	2008-04-29 11:25:17.963079042 +0530
@@ -59,7 +59,7 @@
 	int id = 1;
 	struct platform_device *pdev;
 
-	pdev = platform_device_alloc("omap-bq2700-battery", id);
+	pdev = platform_device_alloc("bq27000-battery", id);
 	if (!pdev) {
 		ret = -ENOMEM;
 		return ret;

