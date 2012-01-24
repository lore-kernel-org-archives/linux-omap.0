From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/9] usb: gadget: add generic map/unmap request utilities
Date: Tue, 24 Jan 2012 13:45:22 +0200
Message-ID: <1327405543-27589-2-git-send-email-balbi@ti.com>
References: <1327405543-27589-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1327405543-27589-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Thomas Dahlmann <dahlmann.thomas-KvP5wT2u2U0@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "open list:DESIGNWARE USB3 D..." <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:AMD GEODE CS5536..." <linux-geode-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

such utilities are currently duplicated on all UDC
drivers basically with the same structure. Let's group
all implementations into one generic implementation
and get rid of that duplication.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/gadget/udc-core.c |   52 +++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/gadget.h    |   10 ++++++++
 2 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/gadget/udc-core.c b/drivers/usb/gadget/udc-core.c
index 0b0d12c..56da49f 100644
--- a/drivers/usb/gadget/udc-core.c
+++ b/drivers/usb/gadget/udc-core.c
@@ -22,6 +22,7 @@
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/err.h>
+#include <linux/dma-mapping.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -49,6 +50,57 @@ static DEFINE_MUTEX(udc_lock);
 
 /* ------------------------------------------------------------------------- */
 
+int usb_gadget_map_request(struct usb_gadget *gadget,
+		struct usb_request *req, int is_in)
+{
+	if (req->length == 0)
+		return 0;
+
+	if (req->num_sgs) {
+		int     mapped;
+
+		mapped = dma_map_sg(&gadget->dev, req->sg, req->num_sgs,
+				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+		if (mapped == 0) {
+			dev_err(&gadget->dev, "failed to map SGs\n");
+			return -EFAULT;
+		}
+
+		req->num_mapped_sgs = mapped;
+	} else {
+		req->dma = dma_map_single(&gadget->dev, req->buf, req->length,
+				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+		if (dma_mapping_error(&gadget->dev, req->dma)) {
+			dev_err(&gadget->dev, "failed to map buffer\n");
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_map_request);
+
+void usb_gadget_unmap_request(struct usb_gadget *gadget,
+		struct usb_request *req, int is_in)
+{
+	if (req->length == 0)
+		return;
+
+	if (req->num_mapped_sgs) {
+		dma_unmap_sg(&gadget->dev, req->sg, req->num_mapped_sgs,
+				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+		req->num_mapped_sgs = 0;
+	} else {
+		dma_unmap_single(&gadget->dev, req->dma, req->length,
+				is_in ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	}
+}
+EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
+
+/* ------------------------------------------------------------------------- */
+
 /**
  * usb_gadget_start - tells usb device controller to start up
  * @gadget: The gadget we want to get started
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index da653b5..9517466 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -950,6 +950,16 @@ static inline void usb_free_descriptors(struct usb_descriptor_header **v)
 
 /*-------------------------------------------------------------------------*/
 
+/* utility to simplify map/unmap of usb_requests to/from DMA */
+
+extern int usb_gadget_map_request(struct usb_gadget *gadget,
+		struct usb_request *req, int is_in);
+
+extern void usb_gadget_unmap_request(struct usb_gadget *gadget,
+		struct usb_request *req, int is_in);
+
+/*-------------------------------------------------------------------------*/
+
 /* utility wrapping a simple endpoint selection policy */
 
 extern struct usb_ep *usb_ep_autoconfig(struct usb_gadget *,
-- 
1.7.8.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
