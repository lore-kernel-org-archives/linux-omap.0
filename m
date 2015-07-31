From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 40/46] usb: gadget: epautoconf: rework ep_matches() function
Date: Fri, 31 Jul 2015 16:00:52 +0200
Message-ID: <1438351258-31578-41-git-send-email-r.baldyga@samsung.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-reply-to: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
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

Rework ep_matches() function to make it shorter and more readable.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 87 +++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 52 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 7bb28f1..4fa6f5d 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -30,16 +30,29 @@ ep_matches (
 	struct usb_ss_ep_comp_descriptor *ep_comp
 )
 {
-	u8		type;
-	u16		max;
-
-	int		num_req_streams = 0;
+	u8              type;
+	u16             max;
+	int             num_req_streams = 0;
 
 	/* endpoint already claimed? */
 	if (ep->claimed)
 		return 0;
 
 	type = usb_endpoint_type(desc);
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
 	switch (type) {
 	case USB_ENDPOINT_XFER_CONTROL:
 		/* only support ep0 for portable CONTROL traffic */
@@ -47,66 +60,36 @@ ep_matches (
 	case USB_ENDPOINT_XFER_ISOC:
 		if (!ep->caps.type_iso)
 			return 0;
+		/* ISO:  limit 1023 bytes full speed,
+		 * 1024 high/super speed
+		 */
+		if (!gadget_is_dualspeed(gadget) && max > 1023)
+			return 0;
 		break;
 	case USB_ENDPOINT_XFER_BULK:
 		if (!ep->caps.type_bulk)
 			return 0;
+		if (ep_comp && gadget_is_superspeed(gadget)) {
+			/* Get the number of required streams from the
+			 * EP companion descriptor and see if the EP
+			 * matches it
+			 */
+			num_req_streams = ep_comp->bmAttributes & 0x1f;
+			if (num_req_streams > ep->max_streams)
+				return 0;
+		}
 		break;
 	case USB_ENDPOINT_XFER_INT:
-		/* bulk endpoints handle interrupt transfers,
+		/* Bulk endpoints handle interrupt transfers,
 		 * except the toggle-quirky iso-synch kind
 		 */
 		if (!ep->caps.type_int && !ep->caps.type_bulk)
 			return 0;
-		break;
-	}
-
-	if (usb_endpoint_dir_in(desc)) {
-		if (!ep->caps.dir_in)
-			return 0;
-	} else {
-		if (!ep->caps.dir_out)
-			return 0;
-	}
-
-	/*
-	 * Get the number of required streams from the EP companion
-	 * descriptor and see if the EP matches it
-	 */
-	if (usb_endpoint_xfer_bulk(desc)) {
-		if (ep_comp && gadget->max_speed >= USB_SPEED_SUPER) {
-			num_req_streams = ep_comp->bmAttributes & 0x1f;
-			if (num_req_streams > ep->max_streams)
-				return 0;
-		}
-
-	}
-
-	/* endpoint maxpacket size is an input parameter, except for bulk
-	 * where it's an output parameter representing the full speed limit.
-	 * the usb spec fixes high speed bulk maxpacket at 512 bytes.
-	 */
-	max = 0x7ff & usb_endpoint_maxp(desc);
-	switch (type) {
-	case USB_ENDPOINT_XFER_INT:
-		/* INT:  limit 64 bytes full speed, 1024 high/super speed */
+		/* INT:  limit 64 bytes full speed,
+		 * 1024 high/super speed
+		 */
 		if (!gadget_is_dualspeed(gadget) && max > 64)
 			return 0;
-		/* FALLTHROUGH */
-
-	case USB_ENDPOINT_XFER_ISOC:
-		/* ISO:  limit 1023 bytes full speed, 1024 high/super speed */
-		if (ep->maxpacket_limit < max)
-			return 0;
-		if (!gadget_is_dualspeed(gadget) && max > 1023)
-			return 0;
-
-		/* BOTH:  "high bandwidth" works only at high speed */
-		if ((desc->wMaxPacketSize & cpu_to_le16(3<<11))) {
-			if (!gadget_is_dualspeed(gadget))
-				return 0;
-			/* configure your hardware with enough buffering!! */
-		}
 		break;
 	}
 
-- 
1.9.1
