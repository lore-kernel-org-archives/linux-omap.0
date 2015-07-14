From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 38/48] usb: gadget: epautoconf: remove pxa quirk from
 ep_matches()
Date: Tue, 14 Jul 2015 11:39:26 +0200
Message-ID: <1436866776-5004-39-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com
Cc: Peter.Chen@freescale.com, johnyoun@synopsys.com, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, cernekee@gmail.com, leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, michal.simek@xilinx.com, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, andrzej.p@samsung.com, m.szyprowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-omap@vger.kernel.org

The same effect can be achieved by using capabilities flags, so now we can
get rid of handing of hardware specific limitations in generic code.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c     | 5 -----
 drivers/usb/gadget/udc/pxa25x_udc.c | 9 +++------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index af4b10a..4f66e9d73 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -58,11 +58,6 @@ ep_matches (
 		 */
 		if (!ep->caps.type_int && !ep->caps.type_bulk)
 			return 0;
-		/* for now, avoid PXA "interrupt-in";
-		 * it's documented as never using DATA1.
-		 */
-		if (gadget_is_pxa(gadget) && ep->caps.type_int)
-			return 0;
 		break;
 	}
 
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index 1301e29..f53e526 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -1898,8 +1898,7 @@ static struct pxa25x_udc memory = {
 			.name		= "ep5in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
-			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
-						USB_EP_CAPS_DIR_IN),
+			.caps		= USB_EP_CAPS(0, 0),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
@@ -1977,8 +1976,7 @@ static struct pxa25x_udc memory = {
 			.name		= "ep10in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
-			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
-						USB_EP_CAPS_DIR_IN),
+			.caps		= USB_EP_CAPS(0, 0),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
@@ -2056,8 +2054,7 @@ static struct pxa25x_udc memory = {
 			.name		= "ep15in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
-			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
-						USB_EP_CAPS_DIR_IN),
+			.caps		= USB_EP_CAPS(0, 0),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
-- 
1.9.1
