From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v3 34/46] usb: musb: gadget: add ep capabilities support
Date: Wed, 15 Jul 2015 08:32:21 +0200
Message-ID: <1436941953-1327-35-git-send-email-r.baldyga@samsung.com>
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

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/musb/musb_gadget.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 625d482f..043248a 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1729,6 +1729,7 @@ init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
 	INIT_LIST_HEAD(&ep->end_point.ep_list);
 	if (!epnum) {
 		usb_ep_set_maxpacket_limit(&ep->end_point, 64);
+		ep->end_point.caps.type_control = true;
 		ep->end_point.ops = &musb_g_ep0_ops;
 		musb->g.ep0 = &ep->end_point;
 	} else {
@@ -1736,9 +1737,20 @@ init_peripheral_ep(struct musb *musb, struct musb_ep *ep, u8 epnum, int is_in)
 			usb_ep_set_maxpacket_limit(&ep->end_point, hw_ep->max_packet_sz_tx);
 		else
 			usb_ep_set_maxpacket_limit(&ep->end_point, hw_ep->max_packet_sz_rx);
+		ep->end_point.caps.type_iso = true;
+		ep->end_point.caps.type_bulk = true;
+		ep->end_point.caps.type_int = true;
 		ep->end_point.ops = &musb_ep_ops;
 		list_add_tail(&ep->end_point.ep_list, &musb->g.ep_list);
 	}
+
+	if (!epnum || hw_ep->is_shared_fifo) {
+		ep->end_point.caps.dir_in = true;
+		ep->end_point.caps.dir_out = true;
+	} else if (is_in)
+		ep->end_point.caps.dir_in = true;
+	else
+		ep->end_point.caps.dir_out = true;
 }
 
 /*
-- 
1.9.1
