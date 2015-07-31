From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 16/46] usb: gadget: fusb300_udc: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:28 +0200
Message-ID: <1438351258-31578-17-git-send-email-r.baldyga@samsung.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, Peter.Chen@freescale.com, johnyoun@synopsys.com, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, cernekee@gmail.com, leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, michal.simek@xilinx.com, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, andrzej.p@samsung.com, m.szyprowski@samsung.com, stern@rowland.harvard.edu, petr.cvek@tul.cz, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-omap@vger.kernel.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/fusb300_udc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/udc/fusb300_udc.c b/drivers/usb/gadget/udc/fusb300_udc.c
index 3970f45..948845c 100644
--- a/drivers/usb/gadget/udc/fusb300_udc.c
+++ b/drivers/usb/gadget/udc/fusb300_udc.c
@@ -1450,6 +1450,17 @@ static int fusb300_probe(struct platform_device *pdev)
 		ep->ep.name = fusb300_ep_name[i];
 		ep->ep.ops = &fusb300_ep_ops;
 		usb_ep_set_maxpacket_limit(&ep->ep, HS_BULK_MAX_PACKET_SIZE);
+
+		if (i == 0) {
+			ep->ep.caps.type_control = true;
+		} else {
+			ep->ep.caps.type_iso = true;
+			ep->ep.caps.type_bulk = true;
+			ep->ep.caps.type_int = true;
+		}
+
+		ep->ep.caps.dir_in = true;
+		ep->ep.caps.dir_out = true;
 	}
 	usb_ep_set_maxpacket_limit(&fusb300->ep[0]->ep, HS_CTL_MAX_PACKET_SIZE);
 	fusb300->ep[0]->epnum = 0;
-- 
1.9.1
