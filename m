From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 6/10] omap: mailbox: remove unnecessary arg for
Date: Fri, 13 Nov 2009 18:03:27 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE4C4997@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53533 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbZKMMdH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 07:33:07 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>

>From 27c97972080ba1fea6296ee59105aebd5ea4442a Mon Sep 17 00:00:00 2001
From: C A Subramaniam <subramaniam.ca@ti.com>
Date: Thu, 12 Nov 2009 16:18:05 -0800
Subject: [PATCH 6/10] omap: mailbox: remove unnecessary arg for omap_mbox_msg_send

Also removed from tx_data

Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |    2 +-
 arch/arm/plat-omap/mailbox.c              |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 319306a..8260a3f 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -63,7 +63,7 @@ struct omap_mbox {
 	void			(*err_notify)(void);
 };
 
-int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg, void *);
+int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
 void omap_mbox_init_seq(struct omap_mbox *);
 
 struct omap_mbox *omap_mbox_get(const char *);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index b49bb29..99ecf80 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -88,7 +88,6 @@ static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 
 struct omap_msg_tx_data {
 	mbox_msg_t	msg;
-	void		*arg;
 };
 
 static void omap_msg_tx_end_io(struct request *rq, int error)
@@ -97,7 +96,7 @@ static void omap_msg_tx_end_io(struct request *rq, int error)
 	__blk_put_request(rq->q, rq);
 }
 
-int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg, void* arg)
+int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 {
 	struct omap_msg_tx_data *tx_data;
 	struct request *rq;
@@ -114,7 +113,6 @@ int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg, void* arg)
 	}
 
 	tx_data->msg = msg;
-	tx_data->arg = arg;
 	rq->end_io = omap_msg_tx_end_io;
 	blk_insert_request(q, rq, 0, tx_data);
 
-- 
1.5.3.2
