From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 3/4] omap: mailbox: fix reverse likeliness
Date: Tue, 27 Apr 2010 20:56:21 +0300
Message-ID: <1272390982-14882-4-git-send-email-ohad@wizery.com>
References: <1272390982-14882-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:4458 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756410Ab0D0R6n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 13:58:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2795216fgg.1
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 10:58:42 -0700 (PDT)
In-Reply-To: <1272390982-14882-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Fix reverse likeliness

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/plat-omap/mailbox.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 8abf0e8..72b17ad 100644
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
 		write_lock(&mboxes_lock);
 		if (mbox_configured > 0)
 			mbox_configured--;
-- 
1.6.3.3

