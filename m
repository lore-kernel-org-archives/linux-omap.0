From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2] mfd: omap-usb-tll: Don't hold lock during pm_runtime_get/put_sync()
Date: Wed, 8 Jan 2014 12:45:33 +0530
Message-ID: <1389165333-7573-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

pm_runtime_get/put_sync() can sleep so don't hold spinlock while
calling them.

This patch prevents a BUG() during system suspend when
CONFIG_DEBUG_ATOMIC_SLEEP is enabled.

Bug is present in Kernel versions v3.9 onwards.

Reported-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Tested-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 3.9+
---
 drivers/mfd/omap-usb-tll.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 0d946ae1..c409be9 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -333,21 +333,17 @@ int omap_tll_init(struct usbhs_omap_platform_data *pdata)
 	unsigned reg;
 	struct usbtll_omap *tll;
 
-	spin_lock(&tll_lock);
-
-	if (!tll_dev) {
-		spin_unlock(&tll_lock);
+	if (!tll_dev)
 		return -ENODEV;
-	}
 
-	tll = dev_get_drvdata(tll_dev);
+	pm_runtime_get_sync(tll_dev);
 
+	spin_lock(&tll_lock);
+	tll = dev_get_drvdata(tll_dev);
 	needs_tll = false;
 	for (i = 0; i < tll->nch; i++)
 		needs_tll |= omap_usb_mode_needs_tll(pdata->port_mode[i]);
 
-	pm_runtime_get_sync(tll_dev);
-
 	if (needs_tll) {
 		void __iomem *base = tll->base;
 
@@ -398,9 +394,8 @@ int omap_tll_init(struct usbhs_omap_platform_data *pdata)
 		}
 	}
 
-	pm_runtime_put_sync(tll_dev);
-
 	spin_unlock(&tll_lock);
+	pm_runtime_put_sync(tll_dev);
 
 	return 0;
 }
@@ -411,17 +406,14 @@ int omap_tll_enable(struct usbhs_omap_platform_data *pdata)
 	int i;
 	struct usbtll_omap *tll;
 
-	spin_lock(&tll_lock);
-
-	if (!tll_dev) {
-		spin_unlock(&tll_lock);
+	if (!tll_dev)
 		return -ENODEV;
-	}
-
-	tll = dev_get_drvdata(tll_dev);
 
 	pm_runtime_get_sync(tll_dev);
 
+	spin_lock(&tll_lock);
+	tll = dev_get_drvdata(tll_dev);
+
 	for (i = 0; i < tll->nch; i++) {
 		if (omap_usb_mode_needs_tll(pdata->port_mode[i])) {
 			int r;
@@ -448,13 +440,10 @@ int omap_tll_disable(struct usbhs_omap_platform_data *pdata)
 	int i;
 	struct usbtll_omap *tll;
 
-	spin_lock(&tll_lock);
-
-	if (!tll_dev) {
-		spin_unlock(&tll_lock);
+	if (!tll_dev)
 		return -ENODEV;
-	}
 
+	spin_lock(&tll_lock);
 	tll = dev_get_drvdata(tll_dev);
 
 	for (i = 0; i < tll->nch; i++) {
@@ -464,9 +453,8 @@ int omap_tll_disable(struct usbhs_omap_platform_data *pdata)
 		}
 	}
 
-	pm_runtime_put_sync(tll_dev);
