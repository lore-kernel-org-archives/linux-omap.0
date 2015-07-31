From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 35/46] usb: renesas: gadget: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:47 +0200
Message-ID: <1438351258-31578-36-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/renesas_usbhs/mod_gadget.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 494dfe0..de4f97d 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -1103,12 +1103,18 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 		if (usbhsg_is_dcp(uep)) {
 			gpriv->gadget.ep0 = &uep->ep;
 			usb_ep_set_maxpacket_limit(&uep->ep, 64);
+			uep->ep.caps.type_control = true;
 		}
 		/* init normal pipe */
 		else {
 			usb_ep_set_maxpacket_limit(&uep->ep, 512);
+			uep->ep.caps.type_iso = true;
+			uep->ep.caps.type_bulk = true;
+			uep->ep.caps.type_int = true;
 			list_add_tail(&uep->ep.ep_list, &gpriv->gadget.ep_list);
 		}
+		uep->ep.caps.dir_in = true;
+		uep->ep.caps.dir_out = true;
 	}
 
 	ret = usb_add_gadget_udc(dev, &gpriv->gadget);
-- 
1.9.1
