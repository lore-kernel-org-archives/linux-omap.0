From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 27/37] usb: gadget: pxa25x_udc: add ep capabilities support
Date: Wed, 08 Jul 2015 13:09:11 +0200
Message-ID: <1436353761-7107-28-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/pxa25x_udc.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index f6cbe66..1301e29 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -1821,6 +1821,8 @@ static struct pxa25x_udc memory = {
 			.name		= ep0name,
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= EP0_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.reg_udccs	= &UDCCS0,
@@ -1833,6 +1835,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep1in-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1846,6 +1850,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep2out-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1861,6 +1867,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep3in-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1874,6 +1882,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep4out-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1888,6 +1898,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep5in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
@@ -1903,6 +1915,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep6in-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1916,6 +1930,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep7out-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1930,6 +1946,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep8in-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1943,6 +1961,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep9out-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1957,6 +1977,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep10in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
@@ -1972,6 +1994,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep11in-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1985,6 +2009,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep12out-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1999,6 +2025,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep13in-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -2012,6 +2040,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep14out-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -2026,6 +2056,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep15in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
-- 
1.9.1
