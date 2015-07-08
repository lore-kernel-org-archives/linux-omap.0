From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 26/37] usb: gadget: pch_ud: add ep capabilities support
Date: Wed, 08 Jul 2015 13:09:10 +0200
Message-ID: <1436353761-7107-27-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/pch_udc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 613547f..cc8fb3c 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -2895,11 +2895,21 @@ static void pch_udc_pcd_reinit(struct pch_udc_dev *dev)
 		ep->in = ~i & 1;
 		ep->ep.name = ep_string[i];
 		ep->ep.ops = &pch_udc_ep_ops;
-		if (ep->in)
+		if (ep->in) {
 			ep->offset_addr = ep->num * UDC_EP_REG_SHIFT;
-		else
+			ep->ep.caps.dir_in = true;
+		} else {
 			ep->offset_addr = (UDC_EPINT_OUT_SHIFT + ep->num) *
 					  UDC_EP_REG_SHIFT;
+			ep->ep.caps.dir_out = true;
+		}
+		if (i == UDC_EP0IN_IDX || i == UDC_EP0OUT_IDX) {
+			ep->ep.caps.type_control = true;
+		} else {
+			ep->ep.caps.type_iso = true;
+			ep->ep.caps.type_bulk = true;
+			ep->ep.caps.type_int = true;
+		}
 		/* need to set ep->ep.maxpacket and set Default Configuration?*/
 		usb_ep_set_maxpacket_limit(&ep->ep, UDC_BULK_MAX_PKT_SIZE);
 		list_add_tail(&ep->ep.ep_list, &dev->gadget.ep_list);
-- 
1.9.1
