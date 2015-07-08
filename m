From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 14/37] usb: gadget: fsl_qe_udc: add ep capabilities support
Date: Wed, 08 Jul 2015 13:08:58 +0200
Message-ID: <1436353761-7107-15-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/fsl_qe_udc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index e0822f1..5fb6f8b 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -2417,6 +2417,17 @@ static int qe_ep_config(struct qe_udc *udc, unsigned char pipe_num)
 	strcpy(ep->name, ep_name[pipe_num]);
 	ep->ep.name = ep_name[pipe_num];
 
+	if (pipe_num == 0) {
+		ep->ep.caps.type_control = true;
+	} else {
+		ep->ep.caps.type_iso = true;
+		ep->ep.caps.type_bulk = true;
+		ep->ep.caps.type_int = true;
+	}
+
+	ep->ep.caps.dir_in = true;
+	ep->ep.caps.dir_out = true;
+
 	ep->ep.ops = &qe_ep_ops;
 	ep->stopped = 1;
 	usb_ep_set_maxpacket_limit(&ep->ep, (unsigned short) ~0);
-- 
1.9.1
