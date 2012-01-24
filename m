From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: [PATCH] omap: mailbox: trivial whitespace fix
Date: Tue, 24 Jan 2012 19:02:15 +0200
Message-ID: <1327424535-19862-1-git-send-email-felipe.contreras@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:52332 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755962Ab2AXREF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 12:04:05 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Jiri Kosina <trivial@kernel.org>, Felipe Contreras <felipe.contreras@nokia.com>

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 arch/arm/plat-omap/mailbox.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index ad80112..ad32621 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -307,7 +307,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	if (!--mbox->use_count) {
 		free_irq(mbox->irq, mbox);
 		tasklet_kill(&mbox->txq->tasklet);
-	flush_work_sync(&mbox->rxq->work);
+		flush_work_sync(&mbox->rxq->work);
 		mbox_queue_free(mbox->txq);
 		mbox_queue_free(mbox->rxq);
 	}
-- 
1.7.8

