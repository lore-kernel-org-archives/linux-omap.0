From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 06/46] usb: dwc2: gadget: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:18 +0200
Message-ID: <1438351258-31578-7-git-send-email-r.baldyga@samsung.com>
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
