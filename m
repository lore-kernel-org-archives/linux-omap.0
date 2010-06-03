From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 02/10] Mailbox: flush pending deferred works before freeing blk queue
Date: Thu,  3 Jun 2010 09:34:10 +0300
Message-ID: <1275546858-29507-3-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35373 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932855Ab0FCGew (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 02:34:52 -0400
In-Reply-To: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

flush pending deferred works before freeing blk_queue to prevent
any attempt of access to blk_queue after it was freed

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/mailbox.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 252a586..77c23f5 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -299,6 +299,8 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 static void omap_mbox_fini(struct omap_mbox *mbox)
 {
 	free_irq(mbox->irq, mbox);
+	tasklet_kill(&mbox->txq->tasklet);
+	flush_work(&mbox->rxq->work);
 	mbox_queue_free(mbox->txq);
 	mbox_queue_free(mbox->rxq);
 
-- 
1.7.1.rc1

