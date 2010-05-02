From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v2 3/4] omap: mailbox: fix reverse likeliness
Date: Sun,  2 May 2010 18:44:30 +0300
Message-ID: <1272815071-2827-4-git-send-email-ohad@wizery.com>
References: <1272815071-2827-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:61422 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370Ab0EBPpR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 11:45:17 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so900064bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 08:45:17 -0700 (PDT)
In-Reply-To: <1272815071-2827-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Fix reverse likeliness

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
If you want, you can also reach me at < ohadb at ti dot com >.

 arch/arm/plat-omap/mailbox.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 5140efc..5309213 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -290,7 +290,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
  fail_alloc_txq:
 	free_irq(mbox->irq, mbox);
  fail_request_irq:
-	if (unlikely(mbox->ops->shutdown))
+	if (likely(mbox->ops->shutdown))
 		mbox->ops->shutdown(mbox);
 
 	return ret;
@@ -303,7 +303,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 
 	free_irq(mbox->irq, mbox);
 
-	if (unlikely(mbox->ops->shutdown)) {
+	if (likely(mbox->ops->shutdown)) {
 		spin_lock(&mboxes_lock);
 		if (mbox_configured > 0)
 			mbox_configured--;
-- 
1.6.3.3

