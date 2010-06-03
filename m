From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 08/10] omap: mailbox: remove (un)likely macros from cold paths
Date: Thu,  3 Jun 2010 09:34:16 +0300
Message-ID: <1275546858-29507-9-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35392 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933289Ab0FCGe5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 02:34:57 -0400
In-Reply-To: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Ohad Ben-Cohen <ohad@wizery.com>

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/mailbox.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 66c6e87..81076b5 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -258,12 +258,12 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 	int ret = 0;
 	struct omap_mbox_queue *mq;
 
-	if (likely(mbox->ops->startup)) {
+	if (mbox->ops->startup) {
 		mutex_lock(&mbox_configured_lock);
 		if (!mbox_configured)
 			ret = mbox->ops->startup(mbox);
 
-		if (unlikely(ret)) {
+		if (ret) {
 			mutex_unlock(&mbox_configured_lock);
 			return ret;
 		}
@@ -273,7 +273,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 
 	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
 				mbox->name, mbox);
-	if (unlikely(ret)) {
+	if (ret) {
 		printk(KERN_ERR
 			"failed to register mailbox interrupt:%d\n", ret);
 		goto fail_request_irq;
@@ -300,7 +300,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
  fail_alloc_txq:
 	free_irq(mbox->irq, mbox);
  fail_request_irq:
-	if (unlikely(mbox->ops->shutdown))
+	if (mbox->ops->shutdown)
 		mbox->ops->shutdown(mbox);
 
 	return ret;
@@ -314,7 +314,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	mbox_queue_free(mbox->txq);
 	mbox_queue_free(mbox->rxq);
 
-	if (unlikely(mbox->ops->shutdown)) {
+	if (mbox->ops->shutdown) {
 		mutex_lock(&mbox_configured_lock);
 		if (mbox_configured > 0)
 			mbox_configured--;
-- 
1.7.1.rc1

