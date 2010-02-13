From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 2/6] Mailbox: flush pending deferred works before freeing
 blk queue
Date: Fri, 12 Feb 2010 19:40:03 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA7C18D7@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48951 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358Ab0BMBkI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 20:40:08 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

>From 0c844957e17257f19f7ef3f51ac860275ce89440 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 12 Feb 2010 19:07:14 -0600
Subject: [PATCH] Mailbox: flush pending deferred works before freeing blk queue

flush pending deferred works before freeing blk_queue to prevent
any attempt of access to blk_queue after it was freed

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index e6cc4b0..3e2f961 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -297,6 +297,8 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 static void omap_mbox_fini(struct omap_mbox *mbox)
 {
 	free_irq(mbox->irq, mbox);
+	tasklet_kill(&mbox->txq->tasklet);
+	flush_work(&mbox->rxq->work);
 	mbox_queue_free(mbox->txq);
 	mbox_queue_free(mbox->rxq);
 
-- 
1.6.0.4

