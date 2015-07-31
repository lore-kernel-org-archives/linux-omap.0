From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 28/46] usb: gadget: pxa27x_udc: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:40 +0200
Message-ID: <1438351258-31578-29-git-send-email-r.baldyga@samsung.com>
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

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/pxa27x_udc.h | 40 +++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.h b/drivers/usb/gadget/udc/pxa27x_udc.h
index 11e1423..cea2cb7 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.h
+++ b/drivers/usb/gadget/udc/pxa27x_udc.h
@@ -234,25 +234,35 @@
 /*
  * Endpoint definition helpers
  */
-#define USB_EP_DEF(addr, bname, dir, type, maxpkt) \
-{ .usb_ep = { .name = bname, .ops = &pxa_ep_ops, .maxpacket = maxpkt, }, \
+#define USB_EP_DEF(addr, bname, dir, type, maxpkt, ctype, cdir) \
+{ .usb_ep = {	.name = bname, .ops = &pxa_ep_ops, .maxpacket = maxpkt, \
+		.caps = USB_EP_CAPS(ctype, cdir), }, \
   .desc = {	.bEndpointAddress = addr | (dir ? USB_DIR_IN : 0), \
-		.bmAttributes = type, \
+		.bmAttributes = USB_ENDPOINT_XFER_ ## type, \
 		.wMaxPacketSize = maxpkt, }, \
   .dev = &memory \
 }
-#define USB_EP_BULK(addr, bname, dir) \
-  USB_EP_DEF(addr, bname, dir, USB_ENDPOINT_XFER_BULK, BULK_FIFO_SIZE)
-#define USB_EP_ISO(addr, bname, dir) \
-  USB_EP_DEF(addr, bname, dir, USB_ENDPOINT_XFER_ISOC, ISO_FIFO_SIZE)
-#define USB_EP_INT(addr, bname, dir) \
-  USB_EP_DEF(addr, bname, dir, USB_ENDPOINT_XFER_INT, INT_FIFO_SIZE)
-#define USB_EP_IN_BULK(n)	USB_EP_BULK(n, "ep" #n "in-bulk", 1)
-#define USB_EP_OUT_BULK(n)	USB_EP_BULK(n, "ep" #n "out-bulk", 0)
-#define USB_EP_IN_ISO(n)	USB_EP_ISO(n,  "ep" #n "in-iso", 1)
-#define USB_EP_OUT_ISO(n)	USB_EP_ISO(n,  "ep" #n "out-iso", 0)
-#define USB_EP_IN_INT(n)	USB_EP_INT(n,  "ep" #n "in-int", 1)
-#define USB_EP_CTRL		USB_EP_DEF(0,  "ep0", 0, 0, EP0_FIFO_SIZE)
+#define USB_EP_BULK(addr, bname, dir, cdir) \
+	USB_EP_DEF(addr, bname, dir, BULK, BULK_FIFO_SIZE, \
+		USB_EP_CAPS_TYPE_BULK, cdir)
+#define USB_EP_ISO(addr, bname, dir, cdir) \
+	USB_EP_DEF(addr, bname, dir, ISOC, ISO_FIFO_SIZE, \
+		USB_EP_CAPS_TYPE_ISO, cdir)
+#define USB_EP_INT(addr, bname, dir, cdir) \
+	USB_EP_DEF(addr, bname, dir, INT, INT_FIFO_SIZE, \
+		USB_EP_CAPS_TYPE_INT, cdir)
+#define USB_EP_IN_BULK(n)	USB_EP_BULK(n, "ep" #n "in-bulk", 1, \
+					USB_EP_CAPS_DIR_IN)
+#define USB_EP_OUT_BULK(n)	USB_EP_BULK(n, "ep" #n "out-bulk", 0, \
+					USB_EP_CAPS_DIR_OUT)
+#define USB_EP_IN_ISO(n)	USB_EP_ISO(n,  "ep" #n "in-iso", 1, \
+					USB_EP_CAPS_DIR_IN)
+#define USB_EP_OUT_ISO(n)	USB_EP_ISO(n,  "ep" #n "out-iso", 0, \
+					USB_EP_CAPS_DIR_OUT)
+#define USB_EP_IN_INT(n)	USB_EP_INT(n,  "ep" #n "in-int", 1, \
+					USB_EP_CAPS_DIR_IN)
+#define USB_EP_CTRL	USB_EP_DEF(0,  "ep0", 0, CONTROL, EP0_FIFO_SIZE, \
+				USB_EP_CAPS_TYPE_CONTROL, USB_EP_CAPS_DIR_ALL)
 
 #define PXA_EP_DEF(_idx, _addr, dir, _type, maxpkt, _config, iface, altset) \
 { \
-- 
1.9.1
