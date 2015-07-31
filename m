From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 27/46] usb: gadget: pxa25x_udc: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:39 +0200
Message-ID: <1438351258-31578-28-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/pxa25x_udc.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index 27f9442..b4d25dc 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -1822,6 +1822,8 @@ static struct pxa25x_udc memory = {
 			.name		= ep0name,
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= EP0_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL,
+						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
 		.reg_udccs	= &UDCCS0,
@@ -1834,6 +1836,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep1in-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1847,6 +1851,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep2out-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1862,6 +1868,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep3in-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1875,6 +1883,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep4out-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1889,6 +1899,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep5in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
@@ -1904,6 +1916,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep6in-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1917,6 +1931,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep7out-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1931,6 +1947,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep8in-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1944,6 +1962,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep9out-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -1958,6 +1978,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep10in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
@@ -1973,6 +1995,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep11in-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -1986,6 +2010,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep12out-bulk",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= BULK_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= BULK_FIFO_SIZE,
@@ -2000,6 +2026,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep13in-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_IN),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -2013,6 +2041,8 @@ static struct pxa25x_udc memory = {
 			.name		= "ep14out-iso",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= ISO_FIFO_SIZE,
+			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_ISO,
+						USB_EP_CAPS_DIR_OUT),
 		},
 		.dev		= &memory,
 		.fifo_size	= ISO_FIFO_SIZE,
@@ -2027,6 +2057,8 @@ static struct pxa25x_udc memory = {
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
