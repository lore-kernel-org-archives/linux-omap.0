From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 9/10] omap mailbox: OMAP4 Mailbox Patch to change the IRQ
 flag from IRQF_DISABLED to IRQF_SHARED
Date: Tue, 22 Sep 2009 20:05:09 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD9921E7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55915 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753559AbZIVOfF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 10:35:05 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>, "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

>From 96827a1faf75893646b459bd3c0b7e9453376bb2 Mon Sep 17 00:00:00 2001
From: C A Subramaniam <subramaniam.ca@ti.com>
Date: Tue, 8 Sep 2009 22:40:16 +0530
Subject: [PATCH 9/10] omap mailbox: OMAP4 Mailbox Patch to change the IRQ flag from IRQF_DISABLED to IRQF_SHARED

Currently, this facilitates both the tesla and ducati
sides to request for the same irq through an
omap_mbox_get() call.

Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 72ea119..3ab3f0d 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -284,7 +284,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 		write_unlock(&mboxes_lock);
 	}
 
-	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_DISABLED,
+	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
 				mbox->name, mbox);
 	if (unlikely(ret)) {
 		printk(KERN_ERR
-- 
1.5.3.2
