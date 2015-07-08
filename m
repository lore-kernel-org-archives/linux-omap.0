From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 31/37] usb: gadget: s3c2410_udc: add ep capabilities support
Date: Wed, 08 Jul 2015 13:09:15 +0200
Message-ID: <1436353761-7107-32-git-send-email-r.baldyga@samsung.com>
References: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-reply-to: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, johnyoun@synopsys.com, linuxppc-dev@lists.ozlabs.org, cernekee@gmail.com, nicolas.ferre@atmel.com, michal.simek@xilinx.com, balbi@ti.com, linux-kernel@vger.kernel.org, haojian.zhuang@gmail.com, linux-omap@vger.kernel.org, Robert Baldyga <r.baldyga@samsung.com>, Peter.Chen@freescale.com, dahlmann.thomas@arcor.de, andrzej.p@samsung.com, leoli@freescale.com, robert.jarzmik@free.fr, daniel@zonque.org, linux-geode@lists.infradead.org
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
