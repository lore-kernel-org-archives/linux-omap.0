From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v3 04/46] staging: emxx_udc: add ep capabilities support
Date: Wed, 15 Jul 2015 08:31:51 +0200
Message-ID: <1436941953-1327-5-git-send-email-r.baldyga@samsung.com>
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

Convert endpoint configuration to new capabilities model.

Fixed typo in "epc-nulk" to "epc-bulk".

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 60 ++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 3b7aa36..0d64bee 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -3153,36 +3153,33 @@ static const struct usb_gadget_ops nbu2ss_gadget_ops = {
 	.ioctl			= nbu2ss_gad_ioctl,
 };
 
-static const char g_ep0_name[] = "ep0";
-static const char g_ep1_name[] = "ep1-bulk";
-static const char g_ep2_name[] = "ep2-bulk";
-static const char g_ep3_name[] = "ep3in-int";
-static const char g_ep4_name[] = "ep4-iso";
-static const char g_ep5_name[] = "ep5-iso";
-static const char g_ep6_name[] = "ep6-bulk";
-static const char g_ep7_name[] = "ep7-bulk";
-static const char g_ep8_name[] = "ep8in-int";
-static const char g_ep9_name[] = "ep9-iso";
-static const char g_epa_name[] = "epa-iso";
-static const char g_epb_name[] = "epb-bulk";
-static const char g_epc_name[] = "epc-nulk";
-static const char g_epd_name[] = "epdin-int";
-
-static const char *gp_ep_name[NUM_ENDPOINTS] = {
-	g_ep0_name,
-	g_ep1_name,
-	g_ep2_name,
-	g_ep3_name,
-	g_ep4_name,
-	g_ep5_name,
-	g_ep6_name,
-	g_ep7_name,
-	g_ep8_name,
-	g_ep9_name,
-	g_epa_name,
-	g_epb_name,
-	g_epc_name,
-	g_epd_name,
+static const struct {
+	const char *name;
+	const struct usb_ep_caps caps;
+} ep_info[NUM_ENDPOINTS] = {
+#define EP_INFO(_name, _type, _dir) \
+	{ \
+		.name = _name, \
+		.caps = USB_EP_CAPS(USB_EP_CAPS_TYPE_ ## _type, \
+				USB_EP_CAPS_DIR_ ## _dir), \
+	}
+
+	EP_INFO("ep0",		CONTROL, ALL),
+	EP_INFO("ep1-bulk",	BULK,	ALL),
+	EP_INFO("ep2-bulk",	BULK,	ALL),
+	EP_INFO("ep3in-int",	INT,	IN),
+	EP_INFO("ep4-iso",	INT,	ALL),
+	EP_INFO("ep5-iso",	ISO,	ALL),
+	EP_INFO("ep6-bulk",	ISO,	ALL),
+	EP_INFO("ep7-bulk",	BULK,	ALL),
+	EP_INFO("ep8in-int",	INT,	IN),
+	EP_INFO("ep9-iso",	ISO,	ALL),
+	EP_INFO("epa-iso",	ISO,	ALL),
+	EP_INFO("epb-bulk",	BULK,	ALL),
+	EP_INFO("epc-bulk",	BULK,	ALL),
+	EP_INFO("epdin-int",	INT,	IN),
+
+#undef EP_INFO
 };
 
 /*-------------------------------------------------------------------------*/
@@ -3200,7 +3197,8 @@ static void __init nbu2ss_drv_ep_init(struct nbu2ss_udc *udc)
 		ep->desc = NULL;
 
 		ep->ep.driver_data = NULL;
-		ep->ep.name = gp_ep_name[i];
+		ep->ep.name = ep_info[i].name;
+		ep->ep.caps = ep_info[i].caps;
 		ep->ep.ops = &nbu2ss_ep_ops;
 
 		usb_ep_set_maxpacket_limit(&ep->ep,
-- 
1.9.1
