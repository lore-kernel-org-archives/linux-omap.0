From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH v2 1/5] Mailbox: free mailbox interrupt before freeing blk
 queue
Date: Thu, 18 Feb 2010 01:07:25 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B9B2A@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56783 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab0BRHHg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 02:07:36 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

>From b4da7188339b7c03a0215239a5ec0d22599ae626 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 12 Feb 2010 19:02:32 -0600
Subject: [PATCH] Mailbox: free mailbox interrupt before freeing blk queue

Free interrupt before freeing blk_queue to avoid
any attempt of access to blk_queue after it was freed.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 8e90633..e6cc4b0 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -296,11 +296,10 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 
 static void omap_mbox_fini(struct omap_mbox *mbox)
 {
+	free_irq(mbox->irq, mbox);
 	mbox_queue_free(mbox->txq);
 	mbox_queue_free(mbox->rxq);
 
-	free_irq(mbox->irq, mbox);
-
 	if (unlikely(mbox->ops->shutdown)) {
 		write_lock(&mboxes_lock);
 		if (mbox_configured > 0)
-- 
1.6.0.4
