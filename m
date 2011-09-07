From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Subject: [v2 1/2] usb: musb: omap2+: fix context api's
Date: Wed, 7 Sep 2011 09:19:23 -0700
Message-ID: <1315412364-21384-2-git-send-email-vikram.pandita@ti.com>
References: <1315412364-21384-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1315412364-21384-1-git-send-email-vikram.pandita-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>

RxFifoSz, TxFifoSz, RxFifoAddr, TxFifoAddr
are all indexed registers.

So before doing a context save or restore, INDEX register
should be set, then only one gets to the right register offset.

Signed-off-by: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 20a2873..6328aaf 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2159,6 +2159,7 @@ static void musb_save_context(struct musb *musb)
 		if (!epio)
 			continue;
 
+		musb_writeb(musb_base, MUSB_INDEX, i);
 		musb->context.index_regs[i].txmaxp =
 			musb_readw(epio, MUSB_TXMAXP);
 		musb->context.index_regs[i].txcsr =
@@ -2234,6 +2235,7 @@ static void musb_restore_context(struct musb *musb)
 		if (!epio)
 			continue;
 
+		musb_writeb(musb_base, MUSB_INDEX, i);
 		musb_writew(epio, MUSB_TXMAXP,
 			musb->context.index_regs[i].txmaxp);
 		musb_writew(epio, MUSB_TXCSR,
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
