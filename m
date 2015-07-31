From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v5 05/46] usb: chipidea: udc: add ep capabilities support
Date: Fri, 31 Jul 2015 16:00:17 +0200
Message-ID: <1438351258-31578-6-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/chipidea/udc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index b7cca3e..4aaa476 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1624,6 +1624,20 @@ static int init_eps(struct ci_hdrc *ci)
 
 			hwep->ep.name      = hwep->name;
 			hwep->ep.ops       = &usb_ep_ops;
+
+			if (i == 0) {
+				hwep->ep.caps.type_control = true;
+			} else {
+				hwep->ep.caps.type_iso = true;
+				hwep->ep.caps.type_bulk = true;
+				hwep->ep.caps.type_int = true;
+			}
+
+			if (j == TX)
+				hwep->ep.caps.dir_in = true;
+			else
+				hwep->ep.caps.dir_out = true;
+
 			/*
 			 * for ep0: maxP defined in desc, for other
 			 * eps, maxP is set by epautoconfig() called
-- 
1.9.1
