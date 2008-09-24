From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH 5/9]HDQ driver: Convert few declarations to static
Date: Wed, 24 Sep 2008 16:57:32 +0530 (IST)
Message-ID: <51670.192.168.10.89.1222255652.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46319 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354AbYIXL2j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Sep 2008 07:28:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: johnpol@2ka.mipt.ru, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

From: Madhusudhan Chikkature<madhu.cr@ti.com>

Convert declaration to static.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
---
 drivers/w1/masters/omap_hdq.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
===================================================================
--- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-09-24
10:10:07.000000000 +0530
+++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-24 10:19:28.000000000
+0530
@@ -49,8 +49,8 @@

 #define OMAP_HDQ_MAX_USER			4

-DECLARE_WAIT_QUEUE_HEAD(hdq_wait_queue);
-int W1_ID;
+static DECLARE_WAIT_QUEUE_HEAD(hdq_wait_queue);
+static int w1_id;

 struct hdq_data {
 	struct device		*dev;
@@ -249,8 +249,8 @@ static void omap_w1_search_bus(void *_hd
 {
 	u64 module_id, rn_le, cs, id;

-	if (W1_ID)
-		module_id = W1_ID;
+	if (w1_id)
+		module_id = w1_id;
 	else
 		module_id = 0x1;

@@ -715,7 +715,7 @@ omap_hdq_exit(void)
 module_init(omap_hdq_init);
 module_exit(omap_hdq_exit);

-module_param(W1_ID, int, S_IRUSR);
+module_param(w1_id, int, S_IRUSR);

 MODULE_AUTHOR("Texas Instruments");
 MODULE_DESCRIPTION("HDQ driver Library");


