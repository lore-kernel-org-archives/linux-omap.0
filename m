From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 4/6] Mailbox: Check valid registered callback before calling
Date: Fri, 12 Feb 2010 19:41:34 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA7C18DA@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59165 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756405Ab0BMBll convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 20:41:41 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

>From 6b31bcca42598217bd46dd5719c50d37fa9ffc3a Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Wed, 27 Jan 2010 20:04:02 -0600
Subject: [PATCH] Mailbox: Check valid registered callback before calling

This patch checks if the mailbox user has assinged a valid
callback fuction before calling it.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 arch/arm/plat-omap/mailbox.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 3e2f961..8136ee3 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -144,7 +144,8 @@ static void mbox_rx_work(struct work_struct *work)
 
 		msg = (mbox_msg_t)rq->special;
 		blk_end_request_all(rq, 0);
-		mbox->rxq->callback((void *)msg);
+		if (mbox->rxq->callback)
+			mbox->rxq->callback((void *)msg);
 	}
 }
 
-- 
1.6.0.4

