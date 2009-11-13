From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 9/10] omap: mailbox: OMAP4 Mailbox Patch to change the IRQ
Date: Fri, 13 Nov 2009 18:04:07 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE4C499B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53567 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509AbZKMMds convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 07:33:48 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>

>From 8a1b63918459dfbb5152dd31988714f91f4fd51b Mon Sep 17 00:00:00 2001
From: C A Subramaniam <subramaniam.ca@ti.com>
Date: Thu, 12 Nov 2009 16:18:06 -0800
Subject: [PATCH 9/10] omap: mailbox: OMAP4 Mailbox Patch to change the IRQ flag from IRQF_DISABLED to IRQF_SHARED

Currently, this facilitates both the tesla and ducati
sides to request for the same irq through an
omap_mbox_get() call.

Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/mailbox.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 99ecf80..eb76df2 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -283,7 +283,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
 			return ret;
 	}
 
-	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_DISABLED,
+	ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
 				mbox->name, mbox);
 	if (unlikely(ret)) {
 		printk(KERN_ERR
-- 
1.5.3.2
