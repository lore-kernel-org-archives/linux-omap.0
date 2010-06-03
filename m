From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 04/10] Mailbox: new mutext lock for h/w mailbox configuration
Date: Thu,  3 Jun 2010 09:34:12 +0300
Message-ID: <1275546858-29507-5-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35383 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932855Ab0FCGey (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 02:34:54 -0400
In-Reply-To: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>

mailbox startup and shutdown are being executed against
a single H/W module, and a mailbox H/W module is totally
__independent__ of the registration of logical mailboxes.
So, an independent mutext should be used for startup and
shutdown.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/mailbox.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 72efbe5..986002b 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -34,6 +34,7 @@ static struct omap_mbox *mboxes;
 static DEFINE_RWLOCK(mboxes_lock);
 
 static int mbox_configured;
+static DEFINE_MUTEX(mbox_configured_lock);
 
 /* Mailbox FIFO handle functions */
 static inline mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
@@ -250,16 +251,16 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	struct omap_mbox_queue *mq;
 
 	if (likely(mbox->ops->startup)) {
-		write_lock(&mboxes_lock);
+		mutex_lock(&mbox_configured_lock);
 		if (!mbox_configured)
 			ret = mbox->ops->startup(mbox);
 
 		if (unlikely(ret)) {
-			write_unlock(&mboxes_lock);
+			mutex_unlock(&mbox_configured_lock);
 			return ret;
 		}
 		mbox_configured++;
-		write_unlock(&mboxes_lock);
+		mutex_unlock(&mbox_configured_lock);
 	}
 
 	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
@@ -306,12 +307,12 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	mbox_queue_free(mbox->rxq);
 
 	if (unlikely(mbox->ops->shutdown)) {
-		write_lock(&mboxes_lock);
+		mutex_lock(&mbox_configured_lock);
 		if (mbox_configured > 0)
 			mbox_configured--;
 		if (!mbox_configured)
 			mbox->ops->shutdown(mbox);
-		write_unlock(&mboxes_lock);
+		mutex_unlock(&mbox_configured_lock);
 	}
 }
 
-- 
1.7.1.rc1

