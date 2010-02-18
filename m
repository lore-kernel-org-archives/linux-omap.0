From: "Anna, Suman" <s-anna@ti.com>
Subject: [PATCH 5/5] omap2/3/4: mailbox: retries in case of FIFO full
Date: Thu, 18 Feb 2010 15:07:30 -0600
Message-ID: <2C1563023E232C49B9F505633D57C2DA2640D02360@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45705 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616Ab0BRVHf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 16:07:35 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "Clark, Rob" <rob@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>

>From f2e895f74544876572adbe3328aa27d20aa1aec4 Mon Sep 17 00:00:00 2001
From: Hari Kanigeri <h-kanigeri2@ti.com>
Date: Fri, 4 Dec 2009 15:52:42 -0600
Subject: [PATCH 5/5] omap2/3/4: mailbox: retries in case of FIFO full

This patch enables check for the mailbox fifo full
Without this check in some extreme stress test cases
the FIFO seems to be still full when trying to send
the message

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 4229cec..8795f18 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -71,10 +71,10 @@ static int __mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
 	int ret = 0, i = 1000;
 
 	while (mbox_fifo_full(mbox)) {
-		if (mbox->ops->type == OMAP_MBOX_TYPE2)
-			return -1;
-		if (--i == 0)
+		if (--i == 0) {
+			printk(KERN_ERR "Mailbox send failure\n");
 			return -1;
+		}
 		udelay(1);
 	}
 	mbox_fifo_write(mbox, msg);
-- 
1.6.6.2

