From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 18/37] usb: gadget: gr_udc: add ep capabilities support
Date: Wed, 08 Jul 2015 13:09:02 +0200
Message-ID: <1436353761-7107-19-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/gr_udc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index c886887..8aa2593 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -2018,12 +2018,23 @@ static int gr_ep_init(struct gr_udc *dev, int num, int is_in, u32 maxplimit)
 
 		usb_ep_set_maxpacket_limit(&ep->ep, MAX_CTRL_PL_SIZE);
 		ep->bytes_per_buffer = MAX_CTRL_PL_SIZE;
+
+		ep->ep.caps.type_control = true;
 	} else {
 		usb_ep_set_maxpacket_limit(&ep->ep, (u16)maxplimit);
 		list_add_tail(&ep->ep.ep_list, &dev->gadget.ep_list);
+
+		ep->ep.caps.type_iso = true;
+		ep->ep.caps.type_bulk = true;
+		ep->ep.caps.type_int = true;
 	}
 	list_add_tail(&ep->ep_list, &dev->ep_list);
 
+	if (is_in)
+		ep->ep.caps.dir_in = true;
+	else
+		ep->ep.caps.dir_out = true;
+
 	ep->tailbuf = dma_alloc_coherent(dev->dev, ep->ep.maxpacket_limit,
 					 &ep->tailbuf_paddr, GFP_ATOMIC);
 	if (!ep->tailbuf)
-- 
1.9.1
