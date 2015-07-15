From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v3 11/46] usb: gadget: bdc: add ep capabilities support
Date: Wed, 15 Jul 2015 08:31:58 +0200
Message-ID: <1436941953-1327-12-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/bdc/bdc_ep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.c b/drivers/usb/gadget/udc/bdc/bdc_ep.c
index b04980c..f9a8f57 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
@@ -1952,12 +1952,18 @@ static int init_ep(struct bdc *bdc, u32 epnum, u32 dir)
 	ep->bdc = bdc;
 	ep->dir = dir;
 
+	if (dir)
+		ep->usb_ep.caps.dir_in = true;
+	else
+		ep->usb_ep.caps.dir_out = true;
+
 	/* ep->ep_num is the index inside bdc_ep */
 	if (epnum == 1) {
 		ep->ep_num = 1;
 		bdc->bdc_ep_array[ep->ep_num] = ep;
 		snprintf(ep->name, sizeof(ep->name), "ep%d", epnum - 1);
 		usb_ep_set_maxpacket_limit(&ep->usb_ep, EP0_MAX_PKT_SIZE);
+		ep->usb_ep.caps.type_control = true;
 		ep->comp_desc = NULL;
 		bdc->gadget.ep0 = &ep->usb_ep;
 	} else {
@@ -1971,6 +1977,9 @@ static int init_ep(struct bdc *bdc, u32 epnum, u32 dir)
 			 dir & 1 ? "in" : "out");
 
 		usb_ep_set_maxpacket_limit(&ep->usb_ep, 1024);
+		ep->usb_ep.caps.type_iso = true;
+		ep->usb_ep.caps.type_bulk = true;
+		ep->usb_ep.caps.type_int = true;
 		ep->usb_ep.max_streams = 0;
 		list_add_tail(&ep->usb_ep.ep_list, &bdc->gadget.ep_list);
 	}
-- 
1.9.1
