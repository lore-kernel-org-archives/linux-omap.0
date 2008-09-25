From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: [PATCH 5/10] HDQ driver: Convert few declarations to static
Date: Thu, 25 Sep 2008 12:25:11 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC8EB7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57920 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbYIYGzz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 02:55:55 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "johnpol@2ka.mipt.ru" <johnpol@2ka.mipt.ru>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

From: Madhusudhan Chikkature <madhu.cr@ti.com>

Convert declaration to static.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 drivers/w1/masters/omap_hdq.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-omap-2.6/drivers/w1/masters/omap_hdq.c
===================================================================
--- linux-omap-2.6.orig/drivers/w1/masters/omap_hdq.c	2008-09-24 10:10:07.000000000 +0530
+++ linux-omap-2.6/drivers/w1/masters/omap_hdq.c	2008-09-24 10:19:28.000000000 +0530
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