From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] omap:usb: add regulator support for EHCI
Date: Thu, 21 Apr 2011 19:52:43 +0530
Message-ID: <1303395763-8702-3-git-send-email-keshava_mgowda@ti.com>
References: <1303395763-8702-1-git-send-email-keshava_mgowda@ti.com>
 <1303395763-8702-2-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1303395763-8702-2-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org, axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, mpfj-list-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>

in case of ehci phy mode; regulator of phy
should be enabled before initializing the
usbhs core driver.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 drivers/mfd/omap-usb-host.c  |    1 -
 drivers/usb/host/ehci-omap.c |   20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index a12202e..3ab9ffa 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -25,7 +25,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
 #include <linux/gpio.h>
-#include <linux/regulator/consumer.h>
 #include <plat/usb.h>
 
 #define USBHS_DRIVER_NAME	"usbhs-omap"
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 7e41a95..627f3a6 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/usb/ulpi.h>
 #include <plat/usb.h>
+#include <linux/regulator/consumer.h>
 
 /* EHCI Register Set */
 #define EHCI_INSNREG04					(0xA0)
@@ -118,6 +119,8 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	struct ehci_hcd				*omap_ehci;
 	int					ret = -ENODEV;
 	int					irq;
+	int					i;
+	char					supply[7];
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -158,6 +161,23 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	hcd->rsrc_len = resource_size(res);
 	hcd->regs = regs;
 
+	/* get ehci regulator and enable */
+	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
+		if (pdata->port_mode[i] != OMAP_EHCI_PORT_MODE_PHY) {
+			pdata->regulator[i] = NULL;
+			continue;
+		}
+		snprintf(supply, sizeof(supply), "hsusb%d", i);
+		pdata->regulator[i] = regulator_get(dev, supply);
+		if (IS_ERR(pdata->regulator[i])) {
+			pdata->regulator[i] = NULL;
+			dev_dbg(dev,
+			"failed to get ehci port%d regulator\n", i);
+		} else {
+			regulator_enable(pdata->regulator[i]);
+		}
+	}
+
 	ret = omap_usbhs_enable(dev);
 	if (ret) {
 		dev_err(dev, "failed to start usbhs with err %d\n", ret);
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
