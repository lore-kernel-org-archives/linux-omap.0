From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 6/10] omap mailbox: remove unnecessary arg for
 omap_mbox_msg_send
Date: Tue, 22 Sep 2009 20:01:50 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD9921DF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60635 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbZIVObs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 10:31:48 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>, "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

>From 021907db683b2d7c7bf5f60bea3874fc6c2fa5a0 Mon Sep 17 00:00:00 2001
From: C A Subramaniam <subramaniam.ca@ti.com>
Date: Tue, 8 Sep 2009 21:35:58 +0530
Subject: [PATCH 6/10] omap mailbox: remove unnecessary arg for omap_mbox_msg_send

Also removed from tx_data

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/mach/mailbox.h |    2 +-
 arch/arm/plat-omap/mailbox.c              |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

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
index 8a6d087..2899255 100644
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
