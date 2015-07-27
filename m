From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v4 46/46] usb: musb: gadget: add musb_match_ep() function
Date: Mon, 27 Jul 2015 11:16:56 +0200
Message-ID: <1437988616-6962-47-git-send-email-r.baldyga@samsung.com>
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

Add 'match_ep' callback to utilize chip-specific knowledge in endpoint matching
process. Function does the same that was done by chip-specific code inside
of epautoconf. Now this code can be removed from there to separate generic code
from platform specific logic.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 23 -----------------------
 drivers/usb/musb/musb_gadget.c  | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index da45371..254ece7 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -83,29 +83,6 @@ struct usb_ep *usb_ep_autoconfig_ss(
 			goto found_ep;
 	}
 
-	/* First, apply chip-specific "best usage" knowledge.
-	 * This might make a good usb_gadget_ops hook ...
-	 */
-#ifdef CONFIG_BLACKFIN
-	if (gadget_is_musbhdrc(gadget)) {
-		if ((USB_ENDPOINT_XFER_BULK == type) ||
-		    (USB_ENDPOINT_XFER_ISOC == type)) {
-			if (USB_DIR_IN & desc->bEndpointAddress)
-				ep = gadget_find_ep_by_name(gadget, "ep5in");
-			else
-				ep = gadget_find_ep_by_name(gadget, "ep6out");
-		} else if (USB_ENDPOINT_XFER_INT == type) {
-			if (USB_DIR_IN & desc->bEndpointAddress)
-				ep = gadget_find_ep_by_name(gadget, "ep1in");
-			else
-				ep = gadget_find_ep_by_name(gadget, "ep2out");
-		} else
-			ep = NULL;
-		if (ep && usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
-			goto found_ep;
-	}
-#endif
-
 	/* Second, look at endpoints until an unclaimed one looks usable */
 	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
 		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 043248a..3a64cf2 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1684,6 +1684,39 @@ static int musb_gadget_pullup(struct usb_gadget *gadget, int is_on)
 	return 0;
 }
 
+#ifdef CONFIG_BLACKFIN
+static struct usb_ep *musb_match_ep(struct usb_gadget *g,
+		struct usb_endpoint_descriptor *desc,
+		struct usb_ss_ep_comp_descriptor *ep_comp)
+{
+	struct usb_ep *ep = NULL;
+	u8 type = usb_endpoint_type(desc);
+
+	switch(type) {
+	case USB_ENDPOINT_XFER_ISOC:
+	case USB_ENDPOINT_XFER_BULK:
+		if (usb_endpoint_dir_in(desc))
+			ep = gadget_find_ep_by_name(g, "ep5in");
+		else
+			ep = gadget_find_ep_by_name(g, "ep6out");
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		if (usb_endpoint_dir_in(desc))
+			ep = gadget_find_ep_by_name(g, "ep1in");
+		else
+			ep = gadget_find_ep_by_name(g, "ep2out");
+	default:
+	}
+
+	if (ep && usb_gadget_ep_match_desc(g, ep, desc, ep_comp))
+		return ep;
+
+	return NULL;
+}
+#else
+#define musb_match_ep NULL
+#endif
+
 static int musb_gadget_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver);
 static int musb_gadget_stop(struct usb_gadget *g);
@@ -1697,6 +1730,7 @@ static const struct usb_gadget_ops musb_gadget_operations = {
 	.pullup			= musb_gadget_pullup,
 	.udc_start		= musb_gadget_start,
 	.udc_stop		= musb_gadget_stop,
+	.match_ep		= musb_match_ep,
 };
 
 /* ----------------------------------------------------------------------- */
-- 
1.9.1
