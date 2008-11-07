From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 1/3] OMAP: Update the search() interface of omap_hdq.
Date: Fri,  7 Nov 2008 21:41:25 +0800
Message-ID: <1226065287-3066-2-git-send-email-stanley.miao@windriver.com>
References: <1226065287-3066-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:50862 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703AbYKGNfv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Nov 2008 08:35:51 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id mA7DZorT021551
	for <linux-omap@vger.kernel.org>; Fri, 7 Nov 2008 05:35:50 -0800 (PST)
In-Reply-To: <1226065287-3066-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

OMAP LDP boot crash. This is because w1 subsystem changed the search interface,
so update omap_hdq's search interface to follow the change.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 drivers/w1/masters/omap_hdq.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index e7fa6ab..b8d0f8b 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -89,8 +89,8 @@ static struct platform_driver omap_hdq_driver = {
 static u8 omap_w1_read_byte(void *_hdq);
 static void omap_w1_write_byte(void *_hdq, u8 byte);
 static u8 omap_w1_reset_bus(void *_hdq);
-static void omap_w1_search_bus(void *_hdq, u8 search_type,
-	w1_slave_found_callback slave_found);
+static void omap_w1_search_bus(void *_hdq, struct w1_master *master_dev,
+		u8 search_type,	w1_slave_found_callback slave_found);
 
 
 static struct w1_bus_master omap_w1_master = {
@@ -237,8 +237,8 @@ static u8 omap_w1_reset_bus(void *_hdq)
 }
 
 /* W1 search callback function */
-static void omap_w1_search_bus(void *_hdq, u8 search_type,
-	w1_slave_found_callback slave_found)
+static void omap_w1_search_bus(void *_hdq, struct w1_master *master_dev,
+		u8 search_type,w1_slave_found_callback slave_found)
 {
 	u64 module_id, rn_le, cs, id;
 
@@ -255,7 +255,7 @@ static void omap_w1_search_bus(void *_hdq, u8 search_type,
 	cs = w1_calc_crc8((u8 *)&rn_le, 7);
 	id = (cs << 56) | module_id;
 
-	slave_found(_hdq, id);
+	slave_found(master_dev, id);
 }
 
 static int _omap_hdq_reset(struct hdq_data *hdq_data)
-- 
1.5.6.3

