From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2.6.29] MUSB: Use Mode 1 for TX if transfer size equals
 maxpacket
Date: Wed, 1 Apr 2009 17:43:59 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FB0861EF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

MUSB: Use Mode 1 for TX if transfer size equals maxpacket

Without this change, musb will not correctly send out a ZLP if the
last transfer is exactly equal to the maxpacket size and request->zero
is set. 

CC: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
(Resending with [PATCH] tag, and linux-omap CC'ed)

Currently we use Mode 0 if transfer size is less-than-or-equal-to maxpacket.
This requires that we explicitly set TxPktRdy for that transfer.

However the musb_g_rx code will not set TxPktRdy twice if the last transfer
is exactly equal to maxpacket, even if request->zero is set. Using Mode 1
will solve this, but maybe a better fix might be in musb_g_rx()

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index c7ebd08..2807988 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -304,7 +304,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
 			/* setup DMA, then program endpoint CSR */
 			request_size = min(request->length,
 						musb_ep->dma->max_len);
-			if (request_size <= musb_ep->packet_sz)
+			if (request_size < musb_ep->packet_sz)
 				musb_ep->dma->desired_mode = 0;
 			else
 				musb_ep->dma->desired_mode = 1;
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
