From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/10] omap: mailbox: remove unnecessary arg for
	omap_mbox_msg_send
Date: Wed, 18 Nov 2009 11:21:04 -0800
Message-ID: <20091118192104.31148.12162.stgit@localhost>
References: <20091118191852.31148.93980.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50759 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627AbZKRTU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 14:20:59 -0500
In-Reply-To: <20091118191852.31148.93980.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, C A Subramaniam <subramaniam.ca@ti.com>

From: C A Subramaniam <subramaniam.ca@ti.com>

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
 

