From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 30/37] usb: gadget: s3c-hsudc: add ep capabilities support
Date: Wed, 08 Jul 2015 13:09:14 +0200
Message-ID: <1436353761-7107-31-git-send-email-r.baldyga@samsung.com>
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
 drivers/usb/gadget/udc/s3c-hsudc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
index 85a712a..e9def42 100644
--- a/drivers/usb/gadget/udc/s3c-hsudc.c
+++ b/drivers/usb/gadget/udc/s3c-hsudc.c
@@ -1005,6 +1005,21 @@ static void s3c_hsudc_initep(struct s3c_hsudc *hsudc,
 	hsep->stopped = 0;
 	hsep->wedge = 0;
 
+	if (epnum == 0) {
+		hsep->ep.caps.type_control = true;
+		hsep->ep.caps.dir_in = true;
+		hsep->ep.caps.dir_out = true;
+	} else {
+		hsep->ep.caps.type_iso = true;
+		hsep->ep.caps.type_bulk = true;
+		hsep->ep.caps.type_int = true;
+	}
+
+	if (epnum & 1)
+		hsep->ep.caps.dir_in = true;
+	else
+		hsep->ep.caps.dir_out = true;
+
 	set_index(hsudc, epnum);
 	writel(hsep->ep.maxpacket, hsudc->regs + S3C_MPR);
 }
-- 
1.9.1
