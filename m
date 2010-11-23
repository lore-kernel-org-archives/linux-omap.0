From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH v4 4/5] OMAP: mailbox: send message in process context
Date: Tue, 23 Nov 2010 15:26:56 -0600
Message-ID: <1290547617-16640-5-git-send-email-h-kanigeri2@ti.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38273 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943Ab0KWV0M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Nov 2010 16:26:12 -0500
In-Reply-To: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

Schedule the Tasklet to send only when mailbox fifo is full and there are
pending messages in kifo, else send the message directly in the Process
context. This would avoid needless scheduling of Tasklet for every message
transfer

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 13698ab..f4177df 100644
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

