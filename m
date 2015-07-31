From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 17/46] usb: gadget: goku_udc: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:29 +0200
Message-ID: <1438351258-31578-18-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/goku_udc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
index 9e8d842..46b8d14 100644
--- a/drivers/usb/gadget/udc/goku_udc.c
+++ b/drivers/usb/gadget/udc/goku_udc.c
@@ -1257,6 +1257,14 @@ static void udc_reinit (struct goku_udc *dev)
 		INIT_LIST_HEAD (&ep->queue);
 
 		ep_reset(NULL, ep);
+
+		if (i == 0)
+			ep->ep.caps.type_control = true;
+		else
+			ep->ep.caps.type_bulk = true;
+
+		ep->ep.caps.dir_in = true;
+		ep->ep.caps.dir_out = true;
 	}
 
 	dev->ep[0].reg_mode = NULL;
-- 
1.9.1
