From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH v2 3/5] Mailbox: Check valid registered callback before
 calling
Date: Thu, 18 Feb 2010 01:08:54 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B9B2C@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39161 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972Ab0BRHJF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 02:09:05 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

>From 148b8adc207e8726895b1b0d84311a3e5ece3dc0 Mon Sep 17 00:00:00 2001
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

