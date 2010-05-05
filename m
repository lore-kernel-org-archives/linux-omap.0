From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v3 3/4] omap: mailbox: remove (un)likely macros from cold paths
Date: Wed,  5 May 2010 18:33:08 +0300
Message-ID: <1273073589-2485-4-git-send-email-ohad@wizery.com>
References: <1273073589-2485-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:5037 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760455Ab0EEPdv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 11:33:51 -0400
Received: by fg-out-1718.google.com with SMTP id d23so23396fga.1
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 08:33:51 -0700 (PDT)
In-Reply-To: <1273073589-2485-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
If you want, you can also reach me at < ohadb at ti dot com >.

 arch/arm/plat-omap/mailbox.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 5140efc..7c60550 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -248,12 +248,12 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	int ret = 0;
 	struct omap_mbox_queue *mq;
 
-	if (likely(mbox->ops->startup)) {
+	if (mbox->ops->startup) {
 		spin_lock(&mboxes_lock);
 		if (!mbox_configured)
 			ret = mbox->ops->startup(mbox);
 
-		if (unlikely(ret)) {
+		if (ret) {
 			spin_unlock(&mboxes_lock);
 			return ret;
 		}
@@ -263,7 +263,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 
 	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
 				mbox->name, mbox);
-	if (unlikely(ret)) {
+	if (ret) {
 		printk(KERN_ERR
 			"failed to register mailbox interrupt:%d\n", ret);
 		goto fail_request_irq;
@@ -290,7 +290,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
  fail_alloc_txq:
 	free_irq(mbox->irq, mbox);
  fail_request_irq:
-	if (unlikely(mbox->ops->shutdown))
+	if (mbox->ops->shutdown)
 		mbox->ops->shutdown(mbox);
 
 	return ret;
@@ -303,7 +303,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 
 	free_irq(mbox->irq, mbox);
 
-	if (unlikely(mbox->ops->shutdown)) {
+	if (mbox->ops->shutdown) {
 		spin_lock(&mboxes_lock);
 		if (mbox_configured > 0)
 			mbox_configured--;
-- 
1.6.3.3

