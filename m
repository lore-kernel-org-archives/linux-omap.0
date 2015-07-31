From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 03/46] usb: gadget: add endpoint capabilities helper macros
Date: Fri, 31 Jul 2015 16:00:15 +0200
Message-ID: <1438351258-31578-4-git-send-email-r.baldyga@samsung.com>
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

Add macros useful while initializing array of endpoint capabilities
structures. These macros makes structure initialization more compact
to decrease number of code lines and increase readability of code.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 include/linux/usb/gadget.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index a9a4959..82b5bcb 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -158,6 +158,26 @@ struct usb_ep_caps {
 	unsigned dir_out:1;
 };
 
+#define USB_EP_CAPS_TYPE_CONTROL     0x01
+#define USB_EP_CAPS_TYPE_ISO         0x02
+#define USB_EP_CAPS_TYPE_BULK        0x04
+#define USB_EP_CAPS_TYPE_INT         0x08
+#define USB_EP_CAPS_TYPE_ALL \
+	(USB_EP_CAPS_TYPE_ISO | USB_EP_CAPS_TYPE_BULK | USB_EP_CAPS_TYPE_INT)
+#define USB_EP_CAPS_DIR_IN           0x01
+#define USB_EP_CAPS_DIR_OUT          0x02
+#define USB_EP_CAPS_DIR_ALL  (USB_EP_CAPS_DIR_IN | USB_EP_CAPS_DIR_OUT)
+
+#define USB_EP_CAPS(_type, _dir) \
+	{ \
+		.type_control = !!(_type & USB_EP_CAPS_TYPE_CONTROL), \
+		.type_iso = !!(_type & USB_EP_CAPS_TYPE_ISO), \
+		.type_bulk = !!(_type & USB_EP_CAPS_TYPE_BULK), \
+		.type_int = !!(_type & USB_EP_CAPS_TYPE_INT), \
+		.dir_in = !!(_dir & USB_EP_CAPS_DIR_IN), \
+		.dir_out = !!(_dir & USB_EP_CAPS_DIR_OUT), \
+	}
+
 /**
  * struct usb_ep - device side representation of USB endpoint
  * @name:identifier for the endpoint, such as "ep-a" or "ep9in-bulk"
-- 
1.9.1
