From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 21/48] usb: gadget: mv_u3d_core: add ep capabilities support
Date: Tue, 14 Jul 2015 11:39:09 +0200
Message-ID: <1436866776-5004-22-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-reply-to: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/mv_u3d_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
index ea35a24..4c48969 100644
--- a/drivers/usb/gadget/udc/mv_u3d_core.c
+++ b/drivers/usb/gadget/udc/mv_u3d_core.c
@@ -1324,6 +1324,9 @@ static int mv_u3d_eps_init(struct mv_u3d *u3d)
 	ep->ep.ops = &mv_u3d_ep_ops;
 	ep->wedge = 0;
 	usb_ep_set_maxpacket_limit(&ep->ep, MV_U3D_EP0_MAX_PKT_SIZE);
+	ep->ep.caps.type_control = true;
+	ep->ep.caps.dir_in = true;
+	ep->ep.caps.dir_out = true;
 	ep->ep_num = 0;
 	ep->ep.desc = &mv_u3d_ep0_desc;
 	INIT_LIST_HEAD(&ep->queue);
@@ -1339,14 +1342,20 @@ static int mv_u3d_eps_init(struct mv_u3d *u3d)
 		if (i & 1) {
 			snprintf(name, sizeof(name), "ep%din", i >> 1);
 			ep->direction = MV_U3D_EP_DIR_IN;
+			ep->ep.caps.dir_in = true;
 		} else {
 			snprintf(name, sizeof(name), "ep%dout", i >> 1);
 			ep->direction = MV_U3D_EP_DIR_OUT;
+			ep->ep.caps.dir_out = true;
 		}
 		ep->u3d = u3d;
 		strncpy(ep->name, name, sizeof(ep->name));
 		ep->ep.name = ep->name;
 
+		ep->ep.caps.type_iso = true;
+		ep->ep.caps.type_bulk = true;
+		ep->ep.caps.type_int = true;
+
 		ep->ep.ops = &mv_u3d_ep_ops;
 		usb_ep_set_maxpacket_limit(&ep->ep, (unsigned short) ~0);
 		ep->ep_num = i / 2;
-- 
1.9.1
