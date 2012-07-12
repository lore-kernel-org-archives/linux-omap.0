From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 04/11] usb: otg: nop: add support for multiple tranceiver
Date: Thu, 12 Jul 2012 15:23:27 +0530
Message-ID: <1342086814-32181-5-git-send-email-ajay.gupta@ti.com>
References: <1342086814-32181-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1342086814-32181-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently we have one single nop transceiver support as same is
defined as a global variable in drivers/usb/otg/nop-usb-xceiv.c.
This need to be changed to support multiple otg controller each
using nop transceiver on a platform such as am335x.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-omap3evm.c |    2 +-
 drivers/usb/musb/am35x.c             |    4 ++--
 drivers/usb/musb/blackfin.c          |    4 ++--
 drivers/usb/musb/da8xx.c             |    4 ++--
 drivers/usb/musb/davinci.c           |    6 +++---
 drivers/usb/musb/musb_dsps.c         |   10 +++++-----
 drivers/usb/musb/tusb6010.c          |    6 +++---
 drivers/usb/otg/nop-usb-xceiv.c      |   20 ++++++++++++--------
 include/linux/usb/otg.h              |    9 +++++----
 9 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index ef230a0..a3393bc 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -704,7 +704,7 @@ static void __init omap3_evm_init(void)
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params, NULL);
 
 	/* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
-	usb_nop_xceiv_register();
+	usb_nop_xceiv_register(0);
 
 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
 		/* enable EHCI VBUS using GPIO22 */
diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index cc0f06a..8762859 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -364,7 +364,7 @@ static int am35x_musb_init(struct musb *musb)
 	if (!rev)
 		return -ENODEV;
 
-	usb_nop_xceiv_register();
+	usb_nop_xceiv_register(musb->id);
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv))
 		return -ENODEV;
@@ -408,7 +408,7 @@ static int am35x_musb_exit(struct musb *musb)
 		data->set_phy_power(0);
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 
 	return 0;
 }
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index c217781..e33838e 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -415,7 +415,7 @@ static int bfin_musb_init(struct musb *musb)
 	}
 	gpio_direction_output(musb->config->gpio_vrsel, 0);
 
-	usb_nop_xceiv_register();
+	usb_nop_xceiv_register(musb->id);
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv)) {
 		gpio_free(musb->config->gpio_vrsel);
@@ -442,7 +442,7 @@ static int bfin_musb_exit(struct musb *musb)
 	gpio_free(musb->config->gpio_vrsel);
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 	return 0;
 }
 
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 3f072a0..93dee98 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -425,7 +425,7 @@ static int da8xx_musb_init(struct musb *musb)
 	if (!rev)
 		goto fail;
 
-	usb_nop_xceiv_register();
+	usb_nop_xceiv_register(musb->id);
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv))
 		goto fail;
@@ -460,7 +460,7 @@ static int da8xx_musb_exit(struct musb *musb)
 	phy_off();
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 
 	return 0;
 }
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index b1f3fb0..221348b 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -385,7 +385,7 @@ static int davinci_musb_init(struct musb *musb)
 	void __iomem	*tibase = musb->ctrl_base;
 	u32		revision;
 
-	usb_nop_xceiv_register();
+	usb_nop_xceiv_register(musb->id);
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv))
 		goto unregister;
@@ -447,7 +447,7 @@ static int davinci_musb_init(struct musb *musb)
 fail:
 	usb_put_phy(musb->xceiv);
 unregister:
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 	return -ENODEV;
 }
 
@@ -496,7 +496,7 @@ static int davinci_musb_exit(struct musb *musb)
 	phy_off();
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 
 	return 0;
 }
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index e76b4d8..17efd3d 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -420,8 +420,8 @@ static int dsps_musb_init(struct musb *musb)
 	/* mentor core register starts at offset of 0x400 from musb base */
 	musb->mregs += wrp->musb_core_offset;
 
-	/* NOP driver needs change if supporting dual instance */
-	usb_nop_xceiv_register();
+	/* Register NOP driver */
+	usb_nop_xceiv_register(musb->id);
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv))
 		return -ENODEV;
@@ -456,7 +456,7 @@ static int dsps_musb_init(struct musb *musb)
 	return 0;
 err0:
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 	return status;
 }
 
@@ -472,9 +472,9 @@ static int dsps_musb_exit(struct musb *musb)
 	/* Shutdown the on-chip PHY and its PLL. */
 	musb_dsps_phy_control(glue, musb->id, 0);
 
-	/* NOP driver needs change if supporting dual instance */
+	/* Unregister NOP driver */
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 
 	return 0;
 }
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 901aa05..9d2b99c 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1078,7 +1078,7 @@ static int tusb_musb_init(struct musb *musb)
 	void __iomem		*sync = NULL;
 	int			ret;
 
-	usb_nop_xceiv_register();
+	usb_nop_xceiv_register(musb->id);
 	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
 	if (IS_ERR_OR_NULL(musb->xceiv))
 		return -ENODEV;
@@ -1132,7 +1132,7 @@ done:
 			iounmap(sync);
 
 		usb_put_phy(musb->xceiv);
-		usb_nop_xceiv_unregister();
+		usb_nop_xceiv_unregister(musb->xceiv);
 	}
 	return ret;
 }
@@ -1148,7 +1148,7 @@ static int tusb_musb_exit(struct musb *musb)
 	iounmap(musb->sync_va);
 
 	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
+	usb_nop_xceiv_unregister(musb->xceiv);
 	return 0;
 }
 
diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
index 803f958..2e5e889 100644
--- a/drivers/usb/otg/nop-usb-xceiv.c
+++ b/drivers/usb/otg/nop-usb-xceiv.c
@@ -35,15 +35,14 @@
 struct nop_usb_xceiv {
 	struct usb_phy		phy;
 	struct device		*dev;
+	struct platform_device	*pd;
 };
 
-static struct platform_device *pd;
-
-void usb_nop_xceiv_register(void)
+void usb_nop_xceiv_register(int id)
 {
-	if (pd)
-		return;
-	pd = platform_device_register_simple("nop_usb_xceiv", -1, NULL, 0);
+	struct platform_device *pd;
+
+	pd = platform_device_register_simple("nop_usb_xceiv", id, NULL, 0);
 	if (!pd) {
 		printk(KERN_ERR "Unable to register usb nop transceiver\n");
 		return;
@@ -51,10 +50,13 @@ void usb_nop_xceiv_register(void)
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
 }
 EXPORT_SYMBOL(usb_nop_xceiv_unregister);
 
@@ -107,11 +109,13 @@ static int __devinit nop_usb_xceiv_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	nop->pd			= pdev;
 	nop->dev		= &pdev->dev;
 	nop->phy.dev		= nop->dev;
 	nop->phy.label		= "nop-xceiv";
 	nop->phy.set_suspend	= nop_set_suspend;
 	nop->phy.state		= OTG_STATE_UNDEFINED;
+	nop->phy.id		= pdev->id;
 
 	nop->phy.otg->phy		= &nop->phy;
 	nop->phy.otg->set_host		= nop_set_host;
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index 4636d39..36cc791 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -95,6 +95,7 @@ struct usb_phy {
 	struct device		*dev;
 	const char		*label;
 	unsigned int		 flags;
+	u8			id;
 
 	enum usb_phy_type	type;
 	enum usb_otg_state	state;
@@ -137,14 +138,14 @@ extern void usb_remove_phy(struct usb_phy *);
 
 #if defined(CONFIG_NOP_USB_XCEIV) || (defined(CONFIG_NOP_USB_XCEIV_MODULE) && defined(MODULE))
 /* sometimes transceivers are accessed only through e.g. ULPI */
-extern void usb_nop_xceiv_register(void);
-extern void usb_nop_xceiv_unregister(void);
+extern void usb_nop_xceiv_register(int id);
+extern void usb_nop_xceiv_unregister(struct usb_phy *);
 #else
-static inline void usb_nop_xceiv_register(void)
+static inline void usb_nop_xceiv_register(int id)
 {
 }
 
-static inline void usb_nop_xceiv_unregister(void)
+static inline void usb_nop_xceiv_unregister(struct usb_phy *phy)
 {
 }
 #endif
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
