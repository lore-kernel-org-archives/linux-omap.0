From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 39/46] usb: gadget: epautoconf: remove ep and desc
 configuration from ep_matches()
Date: Fri, 31 Jul 2015 16:00:51 +0200
Message-ID: <1438351258-31578-40-git-send-email-r.baldyga@samsung.com>
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

As function ep_matches() is used to match endpoint with usb descriptor it's
highly unintuitive that it modifies endpoint and descriptor structures fields.
This patch moves code configuring ep and desc from ep_matches() to
usb_ep_autoconfig_ss(), so now function ep_matches() does nothing more than
its name suggests.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 66 +++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 4f66e9d73..7bb28f1 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -82,13 +82,6 @@ ep_matches (
 
 	}
 
-	/*
-	 * If the protocol driver hasn't yet decided on wMaxPacketSize
-	 * and wants to know the maximum possible, provide the info.
-	 */
-	if (desc->wMaxPacketSize == 0)
-		desc->wMaxPacketSize = cpu_to_le16(ep->maxpacket_limit);
-
 	/* endpoint maxpacket size is an input parameter, except for bulk
 	 * where it's an output parameter representing the full speed limit.
 	 * the usb spec fixes high speed bulk maxpacket at 512 bytes.
@@ -119,31 +112,6 @@ ep_matches (
 
 	/* MATCH!! */
 
-	/* report address */
-	desc->bEndpointAddress &= USB_DIR_IN;
-	if (isdigit (ep->name [2])) {
-		u8	num = simple_strtoul (&ep->name [2], NULL, 10);
-		desc->bEndpointAddress |= num;
-	} else if (desc->bEndpointAddress & USB_DIR_IN) {
-		if (++gadget->in_epnum > 15)
-			return 0;
-		desc->bEndpointAddress = USB_DIR_IN | gadget->in_epnum;
-	} else {
-		if (++gadget->out_epnum > 15)
-			return 0;
-		desc->bEndpointAddress |= gadget->out_epnum;
-	}
-
-	/* report (variable) full speed bulk maxpacket */
-	if ((USB_ENDPOINT_XFER_BULK == type) && !ep_comp) {
-		int size = ep->maxpacket_limit;
-
-		/* min() doesn't work on bitfields with gcc-3.5 */
-		if (size > 64)
-			size = 64;
-		desc->wMaxPacketSize = cpu_to_le16(size);
-	}
-	ep->address = desc->bEndpointAddress;
 	return 1;
 }
 
@@ -280,6 +248,40 @@ struct usb_ep *usb_ep_autoconfig_ss(
 	/* Fail */
 	return NULL;
 found_ep:
+
+	/*
+	 * If the protocol driver hasn't yet decided on wMaxPacketSize
+	 * and wants to know the maximum possible, provide the info.
+	 */
+	if (desc->wMaxPacketSize == 0)
+		desc->wMaxPacketSize = cpu_to_le16(ep->maxpacket_limit);
+
+	/* report address */
+	desc->bEndpointAddress &= USB_DIR_IN;
+	if (isdigit(ep->name[2])) {
+		u8 num = simple_strtoul(&ep->name[2], NULL, 10);
+		desc->bEndpointAddress |= num;
+	} else if (desc->bEndpointAddress & USB_DIR_IN) {
+		if (++gadget->in_epnum > 15)
+			return 0;
+		desc->bEndpointAddress = USB_DIR_IN | gadget->in_epnum;
+	} else {
+		if (++gadget->out_epnum > 15)
+			return 0;
+		desc->bEndpointAddress |= gadget->out_epnum;
+	}
+
+	/* report (variable) full speed bulk maxpacket */
+	if ((type == USB_ENDPOINT_XFER_BULK) && !ep_comp) {
+		int size = ep->maxpacket_limit;
+
+		/* min() doesn't work on bitfields with gcc-3.5 */
+		if (size > 64)
+			size = 64;
+		desc->wMaxPacketSize = cpu_to_le16(size);
+	}
+
+	ep->address = desc->bEndpointAddress;
 	ep->desc = NULL;
 	ep->comp_desc = NULL;
 	ep->claimed = true;
-- 
1.9.1
