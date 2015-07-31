From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 31/46] usb: gadget: s3c2410_udc: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:43 +0200
Message-ID: <1438351258-31578-32-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/s3c2410_udc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
index 5d9aa81..eb3571e 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.c
+++ b/drivers/usb/gadget/udc/s3c2410_udc.c
@@ -1691,6 +1691,8 @@ static struct s3c2410_udc memory = {
 			.name		= ep0name,
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP0_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 	},
@@ -1702,6 +1704,8 @@ static struct s3c2410_udc memory = {
 			.name		= "ep1-bulk",
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.fifo_size	= EP_FIFO_SIZE,
@@ -1714,6 +1718,8 @@ static struct s3c2410_udc memory = {
 			.name		= "ep2-bulk",
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.fifo_size	= EP_FIFO_SIZE,
@@ -1726,6 +1732,8 @@ static struct s3c2410_udc memory = {
 			.name		= "ep3-bulk",
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.fifo_size	= EP_FIFO_SIZE,
@@ -1738,6 +1746,8 @@ static struct s3c2410_udc memory = {
 			.name		= "ep4-bulk",
 			.ops		= &s3c2410_ep_ops,
 			.maxpacket	= EP_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.fifo_size	= EP_FIFO_SIZE,
-- 
1.9.1
