From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 2/6] omap: mailbox: call request_irq after mbox queues are allocated
Date: Tue, 11 Jun 2013 12:03:40 -0500
Message-ID: <1370970220-6704-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48153 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755417Ab3FKRJW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 13:09:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>, Fernando Guzman Lugo <lugo.fernando@gmail.com>

The OMAP mailbox startup code is enabling the interrupt before any
of the associated mailbox queues are allocated. Move this code so
that the interrupt configuration for a mailbox is together.

Signed-off-by: Fernando Guzman Lugo <lugo.fernando@gmail.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/plat-omap/mailbox.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 42377ef..f65eaf0 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -261,13 +261,6 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	}
 
 	if (!mbox->use_count++) {
-		ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
-							mbox->name, mbox);
-		if (unlikely(ret)) {
-			pr_err("failed to register mailbox interrupt:%d\n",
-									ret);
-			goto fail_request_irq;
-		}
 		mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
 		if (!mq) {
 			ret = -ENOMEM;
@@ -282,17 +275,24 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 		}
 		mbox->rxq = mq;
 		mq->mbox = mbox;
+		ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
+							mbox->name, mbox);
+		if (unlikely(ret)) {
+			pr_err("failed to register mailbox interrupt:%d\n",
+									ret);
+			goto fail_request_irq;
+		}
 
 		omap_mbox_enable_irq(mbox, IRQ_RX);
 	}
 	mutex_unlock(&mbox_configured_lock);
 	return 0;
 
+fail_request_irq:
+	mbox_queue_free(mbox->rxq);
 fail_alloc_rxq:
 	mbox_queue_free(mbox->txq);
 fail_alloc_txq:
-	free_irq(mbox->irq, mbox);
-fail_request_irq:
 	if (mbox->ops->shutdown)
 		mbox->ops->shutdown(mbox);
 	mbox->use_count--;
-- 
1.8.2

