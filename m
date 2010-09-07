From: tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [RESEND/PATCH 6/6] USB: musb-gadget: fix dma length in txstate
Date: Tue,  7 Sep 2010 23:23:34 +0800
Message-ID: <1283873014-32511-7-git-send-email-tom.leiming@gmail.com>
References: <1283873014-32511-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283873014-32511-1-git-send-email-tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

DMA length should not go beyond the availabe space of request buffer,
so fix it.

Signed-off-by: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Cc: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 drivers/usb/musb/musb_gadget.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index fa826f9..cacae96 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -300,6 +300,11 @@ static void txstate(struct musb *musb, struct musb_request *req)
 #ifndef	CONFIG_MUSB_PIO_ONLY
 	if (is_dma_capable() && musb_ep->dma) {
 		struct dma_controller	*c = musb->dma_controller;
+		size_t request_size;
+
+		/* setup DMA, then program endpoint CSR */
+		request_size = min_t(size_t, request->length - request->actual,
+					musb_ep->dma->max_len);
 
 		use_dma = (request->dma != DMA_ADDR_INVALID);
 
@@ -307,11 +312,6 @@ static void txstate(struct musb *musb, struct musb_request *req)
 
 #ifdef CONFIG_USB_INVENTRA_DMA
 		{
-			size_t request_size;
-
-			/* setup DMA, then program endpoint CSR */
-			request_size = min_t(size_t, request->length,
-						musb_ep->dma->max_len);
 			if (request_size < musb_ep->packet_sz)
 				musb_ep->dma->desired_mode = 0;
 			else
@@ -373,8 +373,8 @@ static void txstate(struct musb *musb, struct musb_request *req)
 		use_dma = use_dma && c->channel_program(
 				musb_ep->dma, musb_ep->packet_sz,
 				0,
-				request->dma,
-				request->length);
+				request->dma + request->actual,
+				request_size);
 		if (!use_dma) {
 			c->channel_release(musb_ep->dma);
 			musb_ep->dma = NULL;
@@ -386,8 +386,8 @@ static void txstate(struct musb *musb, struct musb_request *req)
 		use_dma = use_dma && c->channel_program(
 				musb_ep->dma, musb_ep->packet_sz,
 				request->zero,
-				request->dma,
-				request->length);
+				request->dma + request->actual,
+				request_size);
 #endif
 	}
 #endif
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
