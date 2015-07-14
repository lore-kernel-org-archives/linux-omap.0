From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v2 36/48] usb: gadget: atmel_usba_udc: add ep capabilities
 support
Date: Tue, 14 Jul 2015 11:39:24 +0200
Message-ID: <1436866776-5004-37-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com
Cc: Peter.Chen@freescale.com, johnyoun@synopsys.com, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, cernekee@gmail.com, leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, michal.simek@xilinx.com, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, andrzej.p@samsung.com, m.szyprowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-omap@vger.kernel.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 37d414e..267d84f 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2067,6 +2067,17 @@ static struct usba_ep * usba_udc_pdata(struct platform_device *pdev,
 		ep->can_dma = pdata->ep[i].can_dma;
 		ep->can_isoc = pdata->ep[i].can_isoc;
 
+		if (i == 0) {
+			ep->ep.caps.type_control = true;
+		} else {
+			ep->ep.caps.type_iso = ep->can_isoc;
+			ep->ep.caps.type_bulk = true;
+			ep->ep.caps.type_int = true;
+		}
+
+		ep->ep.caps.dir_in = true;
+		ep->ep.caps.dir_out = true;
+
 		if (i)
 			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
 	}
-- 
1.9.1
