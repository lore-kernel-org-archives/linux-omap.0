From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 1/2] usb: musb: omap2+: fix context api's
Date: Tue, 6 Sep 2011 17:49:32 -0700
Message-ID: <1315356573-1057-2-git-send-email-vikram.pandita@ti.com>
References: <1315356573-1057-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42623 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab1IGAtv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 20:49:51 -0400
In-Reply-To: <1315356573-1057-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>, Anand Gadiyar <gadiyar@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

RxFifoSz, TxFifoSz, RxFifoAddr, TxFifoAddr
are all indexed registers.

So before doing a context save or restore, INDEX register
should be set, then only one gets to the right register offset.

Change-Id: I33ab09f8c214457914ee848e097880c8800de9e6
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 drivers/usb/musb/musb_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 20a2873..83facaf 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2158,7 +2158,7 @@ static void musb_save_context(struct musb *musb)
 		epio = hw_ep->regs;
 		if (!epio)
 			continue;
-
+		musb_writeb(musb_base, MUSB_INDEX, i);
 		musb->context.index_regs[i].txmaxp =
 			musb_readw(epio, MUSB_TXMAXP);
 		musb->context.index_regs[i].txcsr =
@@ -2233,7 +2233,7 @@ static void musb_restore_context(struct musb *musb)
 		epio = hw_ep->regs;
 		if (!epio)
 			continue;
-
+		musb_writeb(musb_base, MUSB_INDEX, i);
 		musb_writew(epio, MUSB_TXMAXP,
 			musb->context.index_regs[i].txmaxp);
 		musb_writew(epio, MUSB_TXCSR,
-- 
1.7.4.1

