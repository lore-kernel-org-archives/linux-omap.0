From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH v5 3/4] OMAP: mailbox: send message in process context
Date: Mon, 29 Nov 2010 14:24:13 -0600
Message-ID: <1291062254-9057-4-git-send-email-h-kanigeri2@ti.com>
References: <1291062254-9057-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40547 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684Ab0K2UWT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 15:22:19 -0500
In-Reply-To: <1291062254-9057-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Charulatha Varadarajan <charu@ti.com>, Omar Ramirez <omar.ramirez@ti.com>, Fernando Guzman <fernando.lugo@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

Schedule the Tasklet to send only when mailbox fifo is full and there are
pending messages in kfifo, else send the message directly in the Process
context. This would avoid needless scheduling of Tasklet for every message
transfer

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index d9aa87c..cc58b44 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -92,20 +92,25 @@ int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 	struct omap_mbox_queue *mq = mbox->txq;
 	int ret = 0, len;
 
-	spin_lock(&mq->lock);
+	spin_lock_bh(&mq->lock);
 
 	if (kfifo_avail(&mq->fifo) < sizeof(msg)) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
+	if (kfifo_is_empty(&mq->fifo) && !__mbox_poll_for_space(mbox)) {
+		mbox_fifo_write(mbox, msg);
+		goto out;
+	}
+
 	len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
 	WARN_ON(len != sizeof(msg));
 
 	tasklet_schedule(&mbox->txq->tasklet);
 
 out:
-	spin_unlock(&mq->lock);
+	spin_unlock_bh(&mq->lock);
 	return ret;
 }
 EXPORT_SYMBOL(omap_mbox_msg_send);
-- 
1.7.0

