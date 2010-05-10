From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 3/4] omap: mailbox: remove (un)likely macros from cold paths
Date: Mon, 10 May 2010 12:16:52 +0300
Message-ID: <1273483013-5942-3-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273483013-5942-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48734 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880Ab0EJJR0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 05:17:26 -0400
In-Reply-To: <1273483013-5942-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Ohad Ben-Cohen <ohad@wizery.com>

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
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
1.7.1.rc1

