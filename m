From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 03/10] Mailbox: Check valid registered callback before calling
Date: Thu,  3 Jun 2010 09:34:11 +0300
Message-ID: <1275546858-29507-4-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35380 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279Ab0FCGex (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 02:34:53 -0400
In-Reply-To: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Fernando Guzman Lugo <x0095840@ti.com>

This patch checks if the mailbox user has assinged a valid
callback fuction before calling it.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/mailbox.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index 77c23f5..72efbe5 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -146,7 +146,8 @@ static void mbox_rx_work(struct work_struct *work)
 
 		msg = (mbox_msg_t)rq->special;
 		blk_end_request_all(rq, 0);
-		mbox->rxq->callback((void *)msg);
+		if (mbox->rxq->callback)
+			mbox->rxq->callback((void *)msg);
 	}
 }
 
-- 
1.7.1.rc1

