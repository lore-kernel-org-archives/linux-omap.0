From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v3 25/46] usb: gadget: omap_udc: add ep capabilities support
Date: Wed, 15 Jul 2015 08:32:12 +0200
Message-ID: <1436941953-1327-26-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-reply-to: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: gregkh@linuxfoundation.org, balbi@ti.com
Cc: devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, johnyoun@synopsys.com, linuxppc-dev@lists.ozlabs.org, cernekee@gmail.com, nicolas.ferre@atmel.com, michal.simek@xilinx.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Robert Baldyga <r.baldyga@samsung.com>, Peter.Chen@freescale.com, dahlmann.thomas@arcor.de, andrzej.p@samsung.com, leoli@freescale.com, robert.jarzmik@free.fr, daniel@zonque.org, linux-geode@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/omap_udc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index e2fcdb8..9b7d394 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2579,6 +2579,28 @@ omap_ep_setup(char *name, u8 addr, u8 type,
 	ep->double_buf = dbuf;
 	ep->udc = udc;
 
+	switch (type) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		ep->ep.caps.type_control = true;
+		ep->ep.caps.dir_in = true;
+		ep->ep.caps.dir_out = true;
+		break;
+	case USB_ENDPOINT_XFER_ISOC:
+		ep->ep.caps.type_iso = true;
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		ep->ep.caps.type_bulk = true;
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		ep->ep.caps.type_int = true;
+		break;
+	};
+
+	if (addr & USB_DIR_IN)
+		ep->ep.caps.dir_in = true;
+	else
+		ep->ep.caps.dir_out = true;
+
 	ep->ep.name = ep->name;
 	ep->ep.ops = &omap_ep_ops;
 	ep->maxpacket = maxp;
-- 
1.9.1
