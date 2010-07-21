From: <ext-phil.2.carmody@nokia.com>
Subject: RE: [PATCH 2/2] omap:mailbox-provide multiple reader support
Date: Wed, 21 Jul 2010 11:45:30 +0200
Message-ID: <702744BC498BAE41B3AA631D95EC463058B3CFD799@NOK-EUMSG-01.mgdnok.nokia.com>
References: <1279662096-3121-1-git-send-email-h-kanigeri2@ti.com>,<1279662096-3121-3-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26659 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab0GUJpo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jul 2010 05:45:44 -0400
In-Reply-To: <1279662096-3121-3-git-send-email-h-kanigeri2@ti.com>
Content-Language: en-GB
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, hiroshi.doyu@nokia.com
Cc: ohad@wizery.com

Apologies - top posting and not quoting properly due to having to use MS's braindead OWA.

It appears that most of the "changes" are simply indentation changes caused by the inclusion of a new inner block here:
+       if (atomic_inc_return(&mbox->use_count) == 1) {
rather than just using a goto to skip past the unneeded parts. (Hmmm, is it not simply an immediate return now?)
The goto/return is both more idiomatic in linux, and I'm sure a simpler patch.

Phil
________________________________________
From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of ext Hari Kanigeri [h-kanigeri2@ti.com]
Sent: 21 July 2010 01:41
To: Linux Omap; Tony Lindgren; Doyu Hiroshi (Nokia-MS/Helsinki)
Cc: Ohad Ben-Cohen; Hari Kanigeri
Subject: [PATCH 2/2] omap:mailbox-provide multiple reader support

This patch provides mutiple readers support for a mailbox
instance.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |    6 ++-
 arch/arm/plat-omap/mailbox.c              |   63 ++++++++++++++++------------
 2 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 0486d64..c8e47d8 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -68,13 +68,15 @@ struct omap_mbox {
        void                    *priv;

        void                    (*err_notify)(void);
+       atomic_t                use_count;
+       struct blocking_notifier_head   notifier;
 };

 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
 void omap_mbox_init_seq(struct omap_mbox *);

-struct omap_mbox *omap_mbox_get(const char *);
-void omap_mbox_put(struct omap_mbox *);
+struct omap_mbox *omap_mbox_get(const char *, struct notifier_block *nb);
+void omap_mbox_put(struct omap_mbox *, struct notifier_block *nb);

 int omap_mbox_register(struct device *parent, struct omap_mbox *);
 int omap_mbox_unregister(struct omap_mbox *);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index baac315..f9f2af4 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -149,8 +149,8 @@ static void mbox_rx_work(struct work_struct *work)
                if (unlikely(len != sizeof(msg)))
                        pr_err("%s: kfifo_out anomaly detected\n", __func__);

-               if (mq->callback)
-                       mq->callback((void *)msg);
+               blocking_notifier_call_chain(&mq->mbox->notifier, len,
+                                                       (void *)msg);
        }
 }

@@ -252,28 +252,30 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
                }
        }

-       ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
-                               mbox->name, mbox);
-       if (unlikely(ret)) {
-               printk(KERN_ERR
-                       "failed to register mailbox interrupt:%d\n", ret);
-               goto fail_request_irq;
-       }
+       if (atomic_inc_return(&mbox->use_count) == 1) {
+               ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
+                                       mbox->name, mbox);
+               if (unlikely(ret)) {
+                       printk(KERN_ERR "failed to register mailbox interrupt:"
+                                                               "%d\n", ret);
+                       goto fail_request_irq;
+               }

-       mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
-       if (!mq) {
-               ret = -ENOMEM;
-               goto fail_alloc_txq;
-       }
-       mbox->txq = mq;
+               mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
+               if (!mq) {
+                       ret = -ENOMEM;
+                       goto fail_alloc_txq;
+               }
+               mbox->txq = mq;

-       mq = mbox_queue_alloc(mbox, mbox_rx_work, NULL);
-       if (!mq) {
-               ret = -ENOMEM;
-               goto fail_alloc_rxq;
+               mq = mbox_queue_alloc(mbox, mbox_rx_work, NULL);
+               if (!mq) {
+                       ret = -ENOMEM;
+                       goto fail_alloc_rxq;
+               }
+               mbox->rxq = mq;
+               mq->mbox = mbox;
        }
-       mbox->rxq = mq;
-
        return 0;

  fail_alloc_rxq:
@@ -281,6 +283,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
  fail_alloc_txq:
        free_irq(mbox->irq, mbox);
  fail_request_irq:
+       atomic_dec(&mbox->use_count);
        if (likely(mbox->ops->shutdown)) {
                if (atomic_dec_return(&mbox_refcount) == 0)
                        mbox->ops->shutdown(mbox);
@@ -291,10 +294,12 @@ static int omap_mbox_startup(struct omap_mbox *mbox)

 static void omap_mbox_fini(struct omap_mbox *mbox)
 {
-       mbox_queue_free(mbox->txq);
-       mbox_queue_free(mbox->rxq);

-       free_irq(mbox->irq, mbox);
+       if (atomic_dec_return(&mbox->use_count) == 0) {
+               mbox_queue_free(mbox->txq);
+               mbox_queue_free(mbox->rxq);
+               free_irq(mbox->irq, mbox);
+       }

        if (likely(mbox->ops->shutdown)) {
                if (atomic_dec_return(&mbox_refcount) == 0)
@@ -314,7 +319,7 @@ static struct omap_mbox **find_mboxes(const char *name)
        return p;
 }

-struct omap_mbox *omap_mbox_get(const char *name)
+struct omap_mbox *omap_mbox_get(const char *name, struct notifier_block *nb)
 {
        struct omap_mbox *mbox;
        int ret;
@@ -325,19 +330,21 @@ struct omap_mbox *omap_mbox_get(const char *name)
                spin_unlock(&mboxes_lock);
                return ERR_PTR(-ENOENT);
        }
-
        spin_unlock(&mboxes_lock);

        ret = omap_mbox_startup(mbox);
        if (ret)
                return ERR_PTR(-ENODEV);
+       if (nb)
+               blocking_notifier_chain_register(&mbox->notifier, nb);

        return mbox;
 }
 EXPORT_SYMBOL(omap_mbox_get);

-void omap_mbox_put(struct omap_mbox *mbox)
+void omap_mbox_put(struct omap_mbox *mbox, struct notifier_block *nb)
 {
+       blocking_notifier_chain_unregister(&mbox->notifier, nb);
        omap_mbox_fini(mbox);
 }
 EXPORT_SYMBOL(omap_mbox_put);
@@ -361,6 +368,8 @@ int omap_mbox_register(struct device *parent, struct omap_mbox *mbox)
        }
        *tmp = mbox;
        spin_unlock(&mboxes_lock);
+       BLOCKING_INIT_NOTIFIER_HEAD(&mbox->notifier);
+       atomic_set(&mbox->use_count, 0);

        return 0;

--
1.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
