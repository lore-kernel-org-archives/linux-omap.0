From: Ravi Babu <ravibabu@ti.com>
Subject: [PATCH v9 06/13] usb: otg: nop: add support for multiple tranceiver
Date: Fri, 31 Aug 2012 16:39:52 +0530
Message-ID: <1346411399-23964-7-git-send-email-ravibabu@ti.com>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49426 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab2HaLKL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 07:10:11 -0400
In-Reply-To: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com

From: Santhapuri, Damodar <damodar.santhapuri@ti.com>

Currently we have one single nop transceiver support as same is
defined as a global variable in drivers/usb/otg/nop-usb-xceiv.c.
This need to be changed to support multiple otg controller each
using nop transceiver on a platform such as am335x.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
---
 drivers/usb/musb/am35x.c          |    2 +-
 drivers/usb/musb/blackfin.c       |    2 +-
 drivers/usb/musb/da8xx.c          |    2 +-
 drivers/usb/musb/davinci.c        |    4 +-
 drivers/usb/musb/musb_dsps.c      |    8 +++---
 drivers/usb/musb/tusb6010.c       |    4 +-
 drivers/usb/otg/nop-usb-xceiv.c   |   54 ++++++++++++++++++++++++++++++++-----
 include/linux/usb/nop-usb-xceiv.h |    4 +-
 8 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 457f25e..e3099fc 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -399,7 +399,7 @@ static int am35x_musb_exit(struct musb *musb)
 		data->set_phy_power(0);
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 
 	return 0;
 }
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index e8cff9b..32b4fe4 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -427,7 +427,7 @@ static int bfin_musb_exit(struct musb *musb)
 	gpio_free(musb->config->gpio_vrsel);
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 	return 0;
 }
 
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index ce11d20..f86a1c7 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -451,7 +451,7 @@ static int da8xx_musb_exit(struct musb *musb)
 	phy_off();
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 
 	return 0;
 }
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 606bfd0..e12d20a 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -437,7 +437,7 @@ static int davinci_musb_init(struct musb *musb)
 fail:
 	usb_put_phy(musb->xceiv);
 unregister:
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 	return -ENODEV;
 }
 
@@ -485,7 +485,7 @@ static int davinci_musb_exit(struct musb *musb)
 	phy_off();
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 
 	return 0;
 }
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index f883c25..25e395b 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -413,7 +413,7 @@ static int dsps_musb_init(struct musb *musb)
 	/* mentor core register starts at offset of 0x400 from musb base */
 	musb->mregs += wrp->musb_core_offset;
 
-	/* NOP driver needs change if supporting dual instance */
+	/* Register NOP driver */
 	usb_nop_xceiv_register();
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv))
@@ -447,7 +447,7 @@ static int dsps_musb_init(struct musb *musb)
 	return 0;
 err0:
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 	return status;
 }
 
@@ -462,9 +462,9 @@ static int dsps_musb_exit(struct musb *musb)
 	/* Shutdown the on-chip PHY and its PLL. */
 	musb_dsps_phy_control(glue, pdev->id, 0);
 
-	/* NOP driver needs change if supporting dual instance */
+	/* Unregister NOP driver */
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 
 	return 0;
 }
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index dc4d75e..71c4778 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1117,7 +1117,7 @@ done:
 			iounmap(sync);
 
 		usb_put_phy(musb->xceiv);
-		usb_nop_xceiv_unregister();
+		usb_nop_xceiv_unregister(musb->xceiv);
 	}
 	return ret;
 }
@@ -1133,7 +1133,7 @@ static int tusb_musb_exit(struct musb *musb)
 	iounmap(musb->sync_va);
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 	return 0;
 }
 
diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index e52e35e..7e0dba3 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -32,30 +32,69 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/nop-usb-xceiv.h>
 #include <linux/slab.h>
+#include <linux/idr.h>
 
 struct nop_usb_xceiv {
 	struct usb_phy		phy;
 	struct device		*dev;
+	struct platform_device	*pd;
 };
 
-static struct platform_device *pd;
+static DEFINE_IDA(nop_ida);
 
-void usb_nop_xceiv_register(void)
+static int nop_get_id(gfp_t gfp_mask)
 {
-	if (pd)
+	int ret, id;
+
+	ret = ida_pre_get(&nop_ida, gfp_mask);
+	if (!ret) {
+		pr_err("failed to reserve resource for id\n");
+		return -ENOMEM;
+	}
+
+	ret = ida_get_new(&nop_ida, &id);
+	if (ret < 0) {
+		pr_err("failed to allocate a new id\n");
+		return ret;
+	}
+
+	return id;
+}
+
+static void nop_put_id(int id)
+{
+
+	pr_debug("removing id %d\n", id);
+	ida_remove(&nop_ida, id);
+}
+
+void usb_nop_xceiv_register()
+{
+	struct platform_device *pd;
+	int id;
+
+	id = nop_get_id(GFP_KERNEL);
+	if (id < 0) {
+		pr_err("failed to allocate a new id\n");
 		return;
-	pd = platform_device_register_simple("nop_usb_xceiv", -1, NULL, 0);
+	}
+
+	pd = platform_device_register_simple("nop_usb_xceiv", id, NULL, 0);
 	if (!pd) {
-		printk(KERN_ERR "Unable to register usb nop transceiver\n");
+		pr_err("Unable to register usb nop transceiver\n");
 		return;
 	}
 }
 EXPORT_SYMBOL(usb_nop_xceiv_register);
 
-void usb_nop_xceiv_unregister(void)
+void usb_nop_xceiv_unregister(struct usb_phy *phy)
 {
+	struct nop_usb_xceiv *nop = container_of(phy,
+			struct nop_usb_xceiv, phy);
+	struct platform_device *pd = nop->pd;
+
 	platform_device_unregister(pd);
-	pd = NULL;
+	nop_put_id(pd->id);
 }
 EXPORT_SYMBOL(usb_nop_xceiv_unregister);
 
@@ -113,6 +152,7 @@ static int __devinit nop_usb_xceiv_probe(struct platform_device *pdev)
 	if (pdata)
 		type = pdata->type;
 
+	nop->pd			= pdev;
 	nop->dev		= &pdev->dev;
 	nop->phy.dev		= nop->dev;
 	nop->phy.label		= "nop-xceiv";
diff --git a/include/linux/usb/nop-usb-xceiv.h b/include/linux/usb/nop-usb-xceiv.h
index 28884c7..c12fc10 100644
--- a/include/linux/usb/nop-usb-xceiv.h
+++ b/include/linux/usb/nop-usb-xceiv.h
@@ -10,13 +10,13 @@ struct nop_usb_xceiv_platform_data {
 #if defined(CONFIG_NOP_USB_XCEIV) || (defined(CONFIG_NOP_USB_XCEIV_MODULE) && defined(MODULE))
 /* sometimes transceivers are accessed only through e.g. ULPI */
 extern void usb_nop_xceiv_register(void);
-extern void usb_nop_xceiv_unregister(void);
+extern void usb_nop_xceiv_unregister(struct usb_phy *);
 #else
 static inline void usb_nop_xceiv_register(void)
 {
 }
 
-static inline void usb_nop_xceiv_unregister(void)
+static inline void usb_nop_xceiv_unregister(struct usb_phy *phy)
 {
 }
 #endif
-- 
1.7.0.4

