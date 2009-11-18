From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/10] omap: mailbox: OMAP4 Mailbox Patch to change the IRQ
	flag from IRQF_DISABLED to IRQF_SHARED
Date: Wed, 18 Nov 2009 11:21:41 -0800
Message-ID: <20091118192141.31148.59964.stgit@localhost>
References: <20091118191852.31148.93980.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51823 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932642AbZKRTVg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 14:21:36 -0500
In-Reply-To: <20091118191852.31148.93980.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ramesh Gupta G <grgupta@ti.com>, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, C A Subramaniam <subramaniam.ca@ti.com>

From: C A Subramaniam <subramaniam.ca@ti.com>

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
index 2210c45..4d7947e 100644
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

