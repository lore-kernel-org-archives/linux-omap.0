From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v4 42/46] usb: gadget: move ep_matches() from epautoconf to
 udc-core
Date: Mon, 27 Jul 2015 11:16:52 +0200
Message-ID: <1437988616-6962-43-git-send-email-r.baldyga@samsung.com>
References: <1437988616-6962-1-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-reply-to: <1437988616-6962-1-git-send-email-r.baldyga@samsung.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: balbi@ti.com
Cc: nicolas.ferre@atmel.com, robert.jarzmik@free.fr, m.szyprowski@samsung.com, devel@driverdev.osuosl.org, cernekee@gmail.com, michal.simek@xilinx.com, stern@rowland.harvard.edu, Peter.Chen@freescale.com, dahlmann.thomas@arcor.de, leoli@freescale.com, johnyoun@synopsys.com, Robert Baldyga <r.baldyga@samsung.com>, linux-geode@lists.infradead.org, haojian.zhuang@gmail.com, andrzej.p@samsung.com, linux-omap@vger.kernel.org, petr.cvek@tul.cz, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, daniel@zonque.org
List-Id: linux-omap@vger.kernel.org

Move ep_matches() function to udc-core and rename it to
usb_gadget_ep_match_desc(). This function can be used by UDC drivers
in 'match_ep' callback to avoid writing lots of repetitive code.

Replace all calls of ep_matches() with usb_gadget_ep_match_desc().

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c   | 95 +++++----------------------------------
 drivers/usb/gadget/udc/udc-core.c | 69 ++++++++++++++++++++++++++++
 include/linux/usb/gadget.h        |  8 ++++
 3 files changed, 88 insertions(+), 84 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 1b1fee0..3f0a380 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -22,82 +22,6 @@
 
 #include "gadget_chips.h"
 
-static int
-ep_matches (
-	struct usb_gadget		*gadget,
-	struct usb_ep			*ep,
-	struct usb_endpoint_descriptor	*desc,
-	struct usb_ss_ep_comp_descriptor *ep_comp
-)
-{
-	u8              type;
-	u16             max;
-	int             num_req_streams = 0;
-
-	/* endpoint already claimed? */
-	if (ep->claimed)
-		return 0;
-
-	type = usb_endpoint_type(desc);
-	max = 0x7ff & usb_endpoint_maxp(desc);
-
-	if (usb_endpoint_dir_in(desc) && !ep->caps.dir_in)
-		return 0;
-	else if (!ep->caps.dir_out)
-		return 0;
-
-	if (max > ep->maxpacket_limit)
-		return 0;
-
-	/* "high bandwidth" works only at high speed */
-	if (!gadget_is_dualspeed(gadget) && usb_endpoint_maxp(desc) & (3<<11))
-		return 0;
-
-	switch (type) {
-	case USB_ENDPOINT_XFER_CONTROL:
-		/* only support ep0 for portable CONTROL traffic */
-		return 0;
-	case USB_ENDPOINT_XFER_ISOC:
-		if (!ep->caps.type_iso)
-			return 0;
-		/* ISO:  limit 1023 bytes full speed,
-		 * 1024 high/super speed
-		 */
-		if (!gadget_is_dualspeed(gadget) && max > 1023)
-			return 0;
-		break;
-	case USB_ENDPOINT_XFER_BULK:
-		if (!ep->caps.type_bulk)
-			return 0;
-		if (ep_comp && gadget_is_superspeed(gadget)) {
-			/* Get the number of required streams from the
-			 * EP companion descriptor and see if the EP
-			 * matches it
-			 */
-			num_req_streams = ep_comp->bmAttributes & 0x1f;
-			if (num_req_streams > ep->max_streams)
-				return 0;
-		}
-		break;
-	case USB_ENDPOINT_XFER_INT:
-		/* Bulk endpoints handle interrupt transfers,
-		 * except the toggle-quirky iso-synch kind
-		 */
-		if (!ep->caps.type_int && !ep->caps.type_bulk)
-			return 0;
-		/* INT:  limit 64 bytes full speed,
-		 * 1024 high/super speed
-		 */
-		if (!gadget_is_dualspeed(gadget) && max > 64)
-			return 0;
-		break;
-	}
-
-	/* MATCH!! */
-
-	return 1;
-}
-
 static struct usb_ep *
 find_ep (struct usb_gadget *gadget, const char *name)
 {
@@ -180,10 +104,12 @@ struct usb_ep *usb_ep_autoconfig_ss(
 		if (type == USB_ENDPOINT_XFER_INT) {
 			/* ep-e, ep-f are PIO with only 64 byte fifos */
 			ep = find_ep(gadget, "ep-e");
-			if (ep && ep_matches(gadget, ep, desc, ep_comp))
+			if (ep && usb_gadget_ep_match_desc(gadget,
+					ep, desc, ep_comp))
 				goto found_ep;
 			ep = find_ep(gadget, "ep-f");
-			if (ep && ep_matches(gadget, ep, desc, ep_comp))
+			if (ep && usb_gadget_ep_match_desc(gadget,
+					ep, desc, ep_comp))
 				goto found_ep;
 		}
 
@@ -191,20 +117,21 @@ struct usb_ep *usb_ep_autoconfig_ss(
 		snprintf(name, sizeof(name), "ep%d%s", usb_endpoint_num(desc),
 				usb_endpoint_dir_in(desc) ? "in" : "out");
 		ep = find_ep(gadget, name);
-		if (ep && ep_matches(gadget, ep, desc, ep_comp))
+		if (ep && usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
 			goto found_ep;
 	} else if (gadget_is_goku (gadget)) {
 		if (USB_ENDPOINT_XFER_INT == type) {
 			/* single buffering is enough */
 			ep = find_ep(gadget, "ep3-bulk");
-			if (ep && ep_matches(gadget, ep, desc, ep_comp))
+			if (ep && usb_gadget_ep_match_desc(gadget,
+					ep, desc, ep_comp))
 				goto found_ep;
 		} else if (USB_ENDPOINT_XFER_BULK == type
 				&& (USB_DIR_IN & desc->bEndpointAddress)) {
 			/* DMA may be available */
 			ep = find_ep(gadget, "ep2-bulk");
-			if (ep && ep_matches(gadget, ep, desc,
-					      ep_comp))
+			if (ep && usb_gadget_ep_match_desc(gadget,
+					ep, desc, ep_comp))
 				goto found_ep;
 		}
 
@@ -223,14 +150,14 @@ struct usb_ep *usb_ep_autoconfig_ss(
 				ep = find_ep(gadget, "ep2out");
 		} else
 			ep = NULL;
-		if (ep && ep_matches(gadget, ep, desc, ep_comp))
+		if (ep && usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
 			goto found_ep;
 #endif
 	}
 
 	/* Second, look at endpoints until an unclaimed one looks usable */
 	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
-		if (ep_matches(gadget, ep, desc, ep_comp))
+		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
 			goto found_ep;
 	}
 
diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index d69c355..2dff8df 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -129,6 +129,75 @@ EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
 
 /* ------------------------------------------------------------------------- */
 
+int usb_gadget_ep_match_desc(struct usb_gadget *gadget,
+		struct usb_ep *ep, struct usb_endpoint_descriptor *desc,
+		struct usb_ss_ep_comp_descriptor *ep_comp)
+{
+	u8              type;
+	u16             max;
+	int             num_req_streams = 0;
+
+	/* endpoint already claimed? */
+	if (ep->claimed)
+		return 0;
+
+	type = usb_endpoint_type(desc);
+	max = 0x7ff & usb_endpoint_maxp(desc);
+
+	if (usb_endpoint_dir_in(desc) && !ep->caps.dir_in)
+		return 0;
+	else if (!ep->caps.dir_out)
+		return 0;
+
+	if (max > ep->maxpacket_limit)
+		return 0;
+
+	/* "high bandwidth" works only at high speed */
+	if (!gadget_is_dualspeed(gadget) && usb_endpoint_maxp(desc) & (3<<11))
+		return 0;
+
+	switch (type) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		/* only support ep0 for portable CONTROL traffic */
+		return 0;
+	case USB_ENDPOINT_XFER_ISOC:
+		if (!ep->caps.type_iso)
+			return 0;
+		/* ISO:  limit 1023 bytes full speed, 1024 high/super speed */
+		if (!gadget_is_dualspeed(gadget) && max > 1023)
+			return 0;
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		if (!ep->caps.type_bulk)
+			return 0;
+		if (ep_comp && gadget_is_superspeed(gadget)) {
+			/* Get the number of required streams from the
+			 * EP companion descriptor and see if the EP
+			 * matches it
+			 */
+			num_req_streams = ep_comp->bmAttributes & 0x1f;
+			if (num_req_streams > ep->max_streams)
+				return 0;
+		}
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		/* Bulk endpoints handle interrupt transfers,
+		 * except the toggle-quirky iso-synch kind
+		 */
+		if (!ep->caps.type_int && !ep->caps.type_bulk)
+			return 0;
+		/* INT:  limit 64 bytes full speed, 1024 high/super speed */
+		if (!gadget_is_dualspeed(gadget) && max > 64)
+			return 0;
+		break;
+	}
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_ep_match_desc);
+
+/* ------------------------------------------------------------------------- */
+
 static void usb_gadget_state_work(struct work_struct *work)
 {
 	struct usb_gadget *gadget = work_to_gadget(work);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 6de3688..c65cd77 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -1173,6 +1173,14 @@ extern void usb_gadget_giveback_request(struct usb_ep *ep,
 
 /*-------------------------------------------------------------------------*/
 
+/* utility to check if endpoint caps match descriptor needs */
+
+extern int usb_gadget_ep_match_desc(struct usb_gadget *gadget,
+		struct usb_ep *ep, struct usb_endpoint_descriptor *desc,
+		struct usb_ss_ep_comp_descriptor *ep_comp);
+
+/*-------------------------------------------------------------------------*/
+
 /* utility to update vbus status for udc core, it may be scheduled */
 extern void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status);
 
-- 
1.9.1
