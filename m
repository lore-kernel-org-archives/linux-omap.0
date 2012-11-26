From: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [RFC PATCH 2/5] usb: omap ehci: remove all regulator control from
 ehci omap
Date: Mon, 26 Nov 2012 12:45:39 +0000
Message-ID: <20121126124539.18106.48741.stgit@build.warmcat.com>
References: <20121126123427.18106.4112.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121126123427.18106.4112.stgit-Ak/hGR4SqtBG2qbu2SEcwgC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This series migrates it to the hub driver as suggested by
Felipe Balbi.

Signed-off-by: Andy Green <andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |   33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 44e7d0f..2292544 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -40,7 +40,6 @@
 #include <linux/slab.h>
 #include <linux/usb/ulpi.h>
 #include <plat/usb.h>
-#include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
@@ -149,19 +148,6 @@ static int omap_ehci_init(struct usb_hcd *hcd)
 	return rc;
 }
 
-static void disable_put_regulator(
-		struct ehci_hcd_omap_platform_data *pdata)
-{
-	int i;
-
-	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
-		if (pdata->regulator[i]) {
-			regulator_disable(pdata->regulator[i]);
-			regulator_put(pdata->regulator[i]);
-		}
-	}
-}
-
 /* configure so an HC device and id are always provided */
 /* always called with process context; sleeping is OK */
 
@@ -223,23 +209,6 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	hcd->rsrc_len = resource_size(res);
 	hcd->regs = regs;
 
-	/* get ehci regulator and enable */
-	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
-		if (pdata->port_mode[i] != OMAP_EHCI_PORT_MODE_PHY) {
-			pdata->regulator[i] = NULL;
-			continue;
-		}
-		snprintf(supply, sizeof(supply), "hsusb%d", i);
-		pdata->regulator[i] = regulator_get(dev, supply);
-		if (IS_ERR(pdata->regulator[i])) {
-			pdata->regulator[i] = NULL;
-			dev_dbg(dev,
-			"failed to get ehci port%d regulator\n", i);
-		} else {
-			regulator_enable(pdata->regulator[i]);
-		}
-	}
