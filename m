From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH v5 2/4] OMAP: mailbox: fix checkpatch warnings
Date: Mon, 29 Nov 2010 14:24:12 -0600
Message-ID: <1291062254-9057-3-git-send-email-h-kanigeri2@ti.com>
References: <1291062254-9057-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40546 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab0K2UWT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 15:22:19 -0500
In-Reply-To: <1291062254-9057-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>, Charulatha Varadarajan <charu@ti.com>, Omar Ramirez <omar.ramirez@ti.com>, Fernando Guzman <fernando.lugo@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

Fix the following checkpatch warnings observed in mailbox module.

WARNING: please, no space for starting a line,
                                excluding comments
+ fail_alloc_rxq:$

WARNING: please, no space for starting a line,
                                excluding comments
+ fail_alloc_txq:$

WARNING: please, no space for starting a line,
                                excluding comments
+ fail_request_irq:$

WARNING: line over 80 characters
+       mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size, sizeof(mbox_msg_t));

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 48e161c..d9aa87c 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -281,11 +281,11 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 
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
 
@@ -396,7 +396,8 @@ static int __init omap_mbox_init(void)
 
 	/* kfifo size sanity check: alignment and minimal size */
 	mbox_kfifo_size = ALIGN(mbox_kfifo_size, sizeof(mbox_msg_t));
-	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size, sizeof(mbox_msg_t));
+	mbox_kfifo_size = max_t(unsigned int, mbox_kfifo_size,
+							sizeof(mbox_msg_t));
 
 	return 0;
 }
-- 
1.7.0

