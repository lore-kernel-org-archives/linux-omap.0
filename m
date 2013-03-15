From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/4] usb: musb: gadget: do *unmap_dma_buffer* only for valid DMA addr
Date: Fri, 15 Mar 2013 18:58:50 +0530
Message-ID: <1363354132-27523-2-git-send-email-kishon@ti.com>
References: <1363354132-27523-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363354132-27523-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, notasas@gmail.com, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

musb does not use DMA buffer for ep0 but it uses the same giveback
function *musb_g_giveback* for all endpoints (*musb_g_ep0_giveback* calls
*musb_g_giveback*). So for ep0 case request.dma will be '0'
and will result in kernel OOPS if tried to *unmap_dma_buffer* for requests in
ep0. Fixed it by doing *unmap_dma_buffer* only for valid DMA addr.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/usb/musb/musb_gadget.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index c454375..ec3cf29 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -107,7 +107,10 @@ __acquires(ep->musb->lock)
 
 	ep->busy = 1;
 	spin_unlock(&musb->lock);
-	unmap_dma_buffer(req, musb);
+
+	if (request->dma)
+		unmap_dma_buffer(req, musb);
+
 	if (request->status == 0)
 		dev_dbg(musb->controller, "%s done request %p,  %d/%d\n",
 				ep->end_point.name, request,
-- 
1.7.10.4
