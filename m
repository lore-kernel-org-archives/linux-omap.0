From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 3/7] omap:mailbox-fix checkpatch warnings
Date: Thu, 14 Oct 2010 21:13:24 -0500
Message-ID: <1287108808-32119-4-git-send-email-h-kanigeri2@ti.com>
References: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47963 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755636Ab0JOCNV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Oct 2010 22:13:21 -0400
In-Reply-To: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Hari Kanigeri <h-kanigeri2@ti.com>

Fix the checkpatch warnings observed in mailbox module

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 9ce3570..ed960c1 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -279,11 +279,11 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 
 	return 0;
 
- fail_alloc_rxq:
+fail_alloc_rxq:
 	mbox_queue_free(mbox->txq);
- fail_alloc_txq:
+fail_alloc_txq:
 	free_irq(mbox->irq, mbox);
- fail_request_irq:
+fail_request_irq:
 	if (mbox->ops->shutdown)
 		mbox->ops->shutdown(mbox);
 
@@ -394,7 +394,8 @@ static int __init omap_mbox_init(void)
 
 	/* kfifo size sanity check: alignment and minimal size */
 	mbox_kfifo_size = ALIGN(mbox_kfifo_size, sizeof(mbox_msg_t));
-	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size, sizeof(mbox_msg_t));
+	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size,
+						sizeof(mbox_msg_t));
 
 	return 0;
 }
-- 
1.7.0

