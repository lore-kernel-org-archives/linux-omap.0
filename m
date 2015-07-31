From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 10/46] usb: gadget: bcm63xx_udc: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:22 +0200
Message-ID: <1438351258-31578-11-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/bcm63xx_udc.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
index 9db968b..8cbb003 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -44,9 +44,29 @@
 #define DRV_MODULE_NAME		"bcm63xx_udc"
 
 static const char bcm63xx_ep0name[] = "ep0";
-static const char *const bcm63xx_ep_name[] = {
-	bcm63xx_ep0name,
-	"ep1in-bulk", "ep2out-bulk", "ep3in-int", "ep4out-int",
+
+static const struct {
+	const char *name;
+	const struct usb_ep_caps caps;
+} bcm63xx_ep_info[] = {
+#define EP_INFO(_name, _caps) \
+	{ \
+		.name = _name, \
+		.caps = _caps, \
+	}
+
+	EP_INFO(bcm63xx_ep0name,
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL, USB_EP_CAPS_DIR_ALL)),
+	EP_INFO("ep1in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep2out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep3in-int",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_INT, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep4out-int",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_INT, USB_EP_CAPS_DIR_OUT)),
+
+#undef EP_INFO
 };
 
 static bool use_fullspeed;
@@ -943,7 +963,8 @@ static int bcm63xx_init_udc_hw(struct bcm63xx_udc *udc)
 	for (i = 0; i < BCM63XX_NUM_EP; i++) {
 		struct bcm63xx_ep *bep = &udc->bep[i];
 
-		bep->ep.name = bcm63xx_ep_name[i];
+		bep->ep.name = bcm63xx_ep_info[i].name;
+		bep->ep.caps = bcm63xx_ep_info[i].caps;
 		bep->ep_num = i;
 		bep->ep.ops = &bcm63xx_udc_ep_ops;
 		list_add_tail(&bep->ep.ep_list, &udc->gadget.ep_list);
-- 
1.9.1
