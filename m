From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v3 41/46] usb: gadget: add 'ep_match' callback to
 usb_gadget_ops
Date: Wed, 15 Jul 2015 08:32:28 +0200
Message-ID: <1436941953-1327-42-git-send-email-r.baldyga@samsung.com>
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

Add callback that is called by epautoconf to allow UDC driver match the
best endpoint for specific descriptor. It's intended to supply mechanism
which allows to get rid of chip-specific endpoint matching code from
epautoconf.

If gadget has set 'ep_match' callback we prefer to call it first, and
if it fails to find matching endpoint, then we try to use default matching
algorithm.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 6 ++++++
 include/linux/usb/gadget.h      | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 4fa6f5d..1b1fee0 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -165,6 +165,12 @@ struct usb_ep *usb_ep_autoconfig_ss(
 
 	type = desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;
 
+	if (gadget->ops->match_ep) {
+		ep = gadget->ops->match_ep(gadget, desc, ep_comp);
+		if (ep)
+			goto found_ep;
+	}
+
 	/* First, apply chip-specific "best usage" knowledge.
 	 * This might make a good usb_gadget_ops hook ...
 	 */
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index e6cbc25..0041bb9 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -534,6 +534,9 @@ struct usb_gadget_ops {
 	int	(*udc_start)(struct usb_gadget *,
 			struct usb_gadget_driver *);
 	int	(*udc_stop)(struct usb_gadget *);
+	struct usb_ep *(*match_ep)(struct usb_gadget *,
+			struct usb_endpoint_descriptor *,
+			struct usb_ss_ep_comp_descriptor *);
 };
 
 /**
-- 
1.9.1
