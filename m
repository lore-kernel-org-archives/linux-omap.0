From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v4 32/46] usb: gadget: udc-xilinx: add ep capabilities support
Date: Mon, 27 Jul 2015 11:16:42 +0200
Message-ID: <1437988616-6962-33-git-send-email-r.baldyga@samsung.com>
References: <1437988616-6962-1-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-reply-to: <1437988616-6962-1-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/udc-xilinx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 1f24274..1cbb0ac 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -1317,12 +1317,21 @@ static void xudc_eps_init(struct xusb_udc *udc)
 			snprintf(ep->name, EPNAME_SIZE, "ep%d", ep_number);
 			ep->ep_usb.name = ep->name;
 			ep->ep_usb.ops = &xusb_ep_ops;
+
+			ep->ep_usb.caps.type_iso = true;
+			ep->ep_usb.caps.type_bulk = true;
+			ep->ep_usb.caps.type_int = true;
 		} else {
 			ep->ep_usb.name = ep0name;
 			usb_ep_set_maxpacket_limit(&ep->ep_usb, EP0_MAX_PACKET);
 			ep->ep_usb.ops = &xusb_ep0_ops;
+
+			ep->ep_usb.caps.type_control = true;
 		}
 
+		ep->ep_usb.caps.dir_in = true;
+		ep->ep_usb.caps.dir_out = true;
+
 		ep->udc = udc;
 		ep->epnumber = ep_number;
 		ep->desc = NULL;
-- 
1.9.1
