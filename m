From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 13/13] mailbox: call request_irq after mbox queues are allocated
Date: Mon, 11 Feb 2013 22:57:12 -0600
Message-ID: <1360645032-9668-14-git-send-email-s-anna@ti.com>
References: <1360645032-9668-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360645032-9668-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <greg@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Loic Pallardy <loic.pallardy@st.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Dom Cobley <popcornmix@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Felipe Contreras <felipe.contreras@nokia.com>, Tejun Heo <tj@kernel.org>, Omar Ramirez Luna <omar.luna@linaro.org>, Suman Anna <s-anna@ti.com>, Fernando Guzman Lugo <lugo.fernando@gmail.com>
List-Id: linux-omap@vger.kernel.org

The mailbox startup code is enabling the interrupt even before
any of the associated mailbox queues are allocated. Any pending
received mailbox message could cause a kernel panic as soon as
the interrupt is enabled due to the dereferencing of non-existing
mailbox queues within the ISR.

Signed-off-by: Fernando Guzman Lugo <lugo.fernando@gmail.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/mailbox.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index c38241a..5fea5c2 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -377,14 +377,6 @@ static int mailbox_startup(struct mailbox *mbox)
 	}
 
 	if (!mbox->use_count++) {
-		ret = request_irq(mbox->irq, mbox_interrupt,
-				IRQF_SHARED | IRQF_NO_SUSPEND,
-				mbox->name, mbox);
-		if (unlikely(ret)) {
-			pr_err("failed to register mailbox interrupt:%d\n",
-					ret);
-			goto fail_request_irq;
-		}
 		mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
 		if (!mq) {
 			ret = -ENOMEM;
@@ -399,17 +391,25 @@ static int mailbox_startup(struct mailbox *mbox)
 		}
 		mbox->rxq = mq;
 		mq->mbox = mbox;
+		ret = request_irq(mbox->irq, mbox_interrupt,
+				IRQF_SHARED | IRQF_NO_SUSPEND,
+				mbox->name, mbox);
+		if (unlikely(ret)) {
+			pr_err("failed to register mailbox interrupt:%d\n",
+					ret);
+			goto fail_request_irq;
+		}
 
 		mailbox_enable_irq(mbox, IRQ_RX);
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
1.8.1.2
