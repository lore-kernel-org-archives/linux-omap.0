From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v4 06/46] usb: dwc2: gadget: add ep capabilities support
Date: Mon, 27 Jul 2015 11:16:16 +0200
Message-ID: <1437988616-6962-7-git-send-email-r.baldyga@samsung.com>
References: <1437988616-6962-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1437988616-6962-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: gregkh@linuxfoundation.org, Peter.Chen@freescale.com, johnyoun@synopsys.com, dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, cernekee@gmail.com, leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, michal.simek@xilinx.com, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, andrzej.p@samsung.com, m.szyprowski@samsung.com, stern@rowland.harvard.edu, petr.cvek@tul.cz, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-omap@vger.kernel.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/dwc2/gadget.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 731b13d..3ee5b4c 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3289,6 +3289,19 @@ static void s3c_hsotg_initep(struct dwc2_hsotg *hsotg,
 	usb_ep_set_maxpacket_limit(&hs_ep->ep, epnum ? 1024 : EP0_MPS_LIMIT);
 	hs_ep->ep.ops = &s3c_hsotg_ep_ops;
 
+	if (epnum == 0) {
+		hs_ep->ep.caps.type_control = true;
+	} else {
+		hs_ep->ep.caps.type_iso = true;
+		hs_ep->ep.caps.type_bulk = true;
+		hs_ep->ep.caps.type_int = true;
+	}
+
+	if (dir_in)
+		hs_ep->ep.caps.dir_in = true;
+	else
+		hs_ep->ep.caps.dir_out = true;
+
 	/*
 	 * if we're using dma, we need to set the next-endpoint pointer
 	 * to be something valid.
-- 
1.9.1
