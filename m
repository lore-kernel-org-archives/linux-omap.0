From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 02/46] usb: gadget: add endpoint capabilities flags
Date: Fri, 31 Jul 2015 16:00:14 +0200
Message-ID: <1438351258-31578-3-git-send-email-r.baldyga@samsung.com>
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

Introduce struct usb_ep_caps which contains information about capabilities
of usb endpoints - supported transfer types and directions. This structure
should be filled by UDC driver for each of its endpoints, and will be
used in epautoconf in new ep matching mechanism which will replace ugly
guessing of endpoint capabilities basing on its name.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 include/linux/usb/gadget.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 68fb5e8..a9a4959 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -141,10 +141,29 @@ struct usb_ep_ops {
 };
 
 /**
+ * struct usb_ep_caps - endpoint capabilities description
+ * @type_control:Endpoint supports control type (reserved for ep0).
+ * @type_iso:Endpoint supports isochronous transfers.
+ * @type_bulk:Endpoint supports bulk transfers.
+ * @type_int:Endpoint supports interrupt transfers.
+ * @dir_in:Endpoint supports IN direction.
+ * @dir_out:Endpoint supports OUT direction.
+ */
+struct usb_ep_caps {
+	unsigned type_control:1;
+	unsigned type_iso:1;
+	unsigned type_bulk:1;
+	unsigned type_int:1;
+	unsigned dir_in:1;
+	unsigned dir_out:1;
+};
+
+/**
  * struct usb_ep - device side representation of USB endpoint
  * @name:identifier for the endpoint, such as "ep-a" or "ep9in-bulk"
  * @ops: Function pointers used to access hardware-specific operations.
  * @ep_list:the gadget's ep_list holds all of its endpoints
+ * @caps:The structure describing types and directions supported by endoint.
  * @maxpacket:The maximum packet size used on this endpoint.  The initial
  *	value can sometimes be reduced (hardware allowing), according to
  *      the endpoint descriptor used to configure the endpoint.
@@ -167,12 +186,14 @@ struct usb_ep_ops {
  * gadget->ep_list.  the control endpoint (gadget->ep0) is not in that list,
  * and is accessed only in response to a driver setup() callback.
  */
+
 struct usb_ep {
 	void			*driver_data;
 
 	const char		*name;
 	const struct usb_ep_ops	*ops;
 	struct list_head	ep_list;
+	struct usb_ep_caps	caps;
 	bool			claimed;
 	unsigned		maxpacket:16;
 	unsigned		maxpacket_limit:16;
-- 
1.9.1
