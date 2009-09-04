From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 6/10] omap mailbox: remove unnecessary arg for
 omap_mbox_msg_send
Date: Fri, 4 Sep 2009 17:18:04 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108F0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32950 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755837AbZIDLrX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 07:47:23 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

>From 4e4fbfa64b2b77ec6f1140178770a70ff6f8caed Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Wed, 2 Sep 2009 20:14:24 +0530
Subject: [PATCH 6/10] omap mailbox: remove unnecessary arg for omap_mbox_msg_send

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/mach/mailbox.h |    2 +-
 arch/arm/plat-omap/mailbox.c              |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mailbox.h b/arch/arm/plat-omap/include/mach/mailbox.h
index 319306a..8260a3f 100644
--- a/arch/arm/plat-omap/include/mach/mailbox.h
+++ b/arch/arm/plat-omap/include/mach/mailbox.h
@@ -63,7 +63,7 @@ struct omap_mbox {
 	void			(*err_notify)(void);
 };
 
-int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg, void *);
+int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
 void omap_mbox_init_seq(struct omap_mbox *);
 
 struct omap_mbox *omap_mbox_get(const char *);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 8a6d087..b7c0d5f 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -97,7 +97,7 @@ static void omap_msg_tx_end_io(struct request *rq, int error)
 	__blk_put_request(rq->q, rq);
 }
 
-int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg, void* arg)
+int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 {
 	struct omap_msg_tx_data *tx_data;
 	struct request *rq;
@@ -114,7 +114,6 @@ int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg, void* arg)
 	}
 
 	tx_data->msg = msg;
-	tx_data->arg = arg;
 	rq->end_io = omap_msg_tx_end_io;
 	blk_insert_request(q, rq, 0, tx_data);
 
-- 
1.5.3.2
