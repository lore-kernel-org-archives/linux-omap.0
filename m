From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 19/46] usb: gadget: lpc32xx_udc: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:31 +0200
Message-ID: <1438351258-31578-20-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/lpc32xx_udc.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 3b6a785..00b5006 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -2575,6 +2575,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep0",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 0,
@@ -2586,6 +2588,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep1-int",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 2,
@@ -2597,6 +2601,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep2-bulk",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 4,
@@ -2608,6 +2614,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep3-iso",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 1023,
 		.hwep_num_base	= 6,
@@ -2619,6 +2627,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep4-int",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 8,
@@ -2630,6 +2640,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep5-bulk",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 10,
@@ -2641,6 +2653,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep6-iso",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 1023,
 		.hwep_num_base	= 12,
@@ -2652,6 +2666,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep7-int",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 14,
@@ -2663,6 +2679,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep8-bulk",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 16,
@@ -2674,6 +2692,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep9-iso",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 1023,
 		.hwep_num_base	= 18,
@@ -2685,6 +2705,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep10-int",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 20,
@@ -2696,6 +2718,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep11-bulk",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 22,
@@ -2707,6 +2731,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep12-iso",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 1023,
 		.hwep_num_base	= 24,
@@ -2718,6 +2744,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep13-int",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 26,
@@ -2729,6 +2757,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep14-bulk",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 64,
 		.hwep_num_base	= 28,
@@ -2740,6 +2770,8 @@ static const struct lpc32xx_udc controller_template = {
 		.ep = {
 			.name	= "ep15-bulk",
 			.ops	= &lpc32xx_ep_ops,
+			.caps	= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+					USB_EP_CAPS_DIR_ALL),
 		},
 		.maxpacket	= 1023,
 		.hwep_num_base	= 30,
-- 
1.9.1
