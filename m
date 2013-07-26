From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [RESEND PATCH v10 6/8] usb: musb: omap2430: use the new generic PHY framework
Date: Fri, 26 Jul 2013 18:19:21 +0530
Message-ID: <1374842963-13545-7-git-send-email-kishon@ti.com>
References: <1374842963-13545-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1374842963-13545-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Use the generic PHY framework API to get the PHY. The usb_phy_set_resume
and usb_phy_set_suspend is replaced with power_on and
power_off to align with the new PHY framework.

musb->xceiv can't be removed as of now because musb core uses xceiv.state and
xceiv.otg. Once there is a separate state machine to handle otg, these can be
moved out of xceiv and then we can start using the generic PHY framework.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Reviewed-by: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/Kconfig     |    1 +
 drivers/usb/musb/musb_core.h |    2 ++
 drivers/usb/musb/omap2430.c  |   26 ++++++++++++++++++++------
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 797e3fd..25e2e57 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -76,6 +76,7 @@ config USB_MUSB_TUSB6010
 config USB_MUSB_OMAP2PLUS
 	tristate "OMAP2430 and onwards"
 	depends on ARCH_OMAP2PLUS
+	select GENERIC_PHY
 
 config USB_MUSB_AM35X
 	tristate "AM35x"
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 7d341c3..6e567bd 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -46,6 +46,7 @@
 #include <linux/usb.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/musb.h>
+#include <linux/phy/phy.h>
 
 struct musb;
 struct musb_hw_ep;
@@ -346,6 +347,7 @@ struct musb {
 	u16			int_tx;
 
 	struct usb_phy		*xceiv;
+	struct phy		*phy;
 
 	int nIrq;
 	unsigned		irq_wake:1;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 6708a3b..f7b33f4 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -348,11 +348,21 @@ static int omap2430_musb_init(struct musb *musb)
 	 * up through ULPI.  TWL4030-family PMICs include one,
 	 * which needs a driver, drivers aren't always needed.
 	 */
-	if (dev->parent->of_node)
+	if (dev->parent->of_node) {
+		musb->phy = devm_phy_get(dev->parent, "usb2-phy");
+
+		/* We can't totally remove musb->xceiv as of now because
+		 * musb core uses xceiv.state and xceiv.otg. Once we have
+		 * a separate state machine to handle otg, these can be moved
+		 * out of xceiv and then we can start using the generic PHY
+		 * framework
+		 */
 		musb->xceiv = devm_usb_get_phy_by_phandle(dev->parent,
 		    "usb-phy", 0);
-	else
+	} else {
 		musb->xceiv = devm_usb_get_phy_dev(dev, 0);
+		musb->phy = devm_phy_get(dev, "usb");
+	}
 
 	if (IS_ERR(musb->xceiv)) {
 		status = PTR_ERR(musb->xceiv);
@@ -364,6 +374,10 @@ static int omap2430_musb_init(struct musb *musb)
 		return -EPROBE_DEFER;
 	}
 
+	if (IS_ERR(musb->phy)) {
+		pr_err("HS USB OTG: no PHY configured\n");
+		return PTR_ERR(musb->phy);
+	}
 	musb->isr = omap2430_musb_interrupt;
 
 	status = pm_runtime_get_sync(dev);
@@ -397,7 +411,7 @@ static int omap2430_musb_init(struct musb *musb)
 	if (glue->status != OMAP_MUSB_UNKNOWN)
 		omap_musb_set_mailbox(glue);
 
-	usb_phy_init(musb->xceiv);
+	phy_init(musb->phy);
 
 	pm_runtime_put_noidle(musb->controller);
 	return 0;
@@ -460,6 +474,7 @@ static int omap2430_musb_exit(struct musb *musb)
 	del_timer_sync(&musb_idle_timer);
 
 	omap2430_low_level_exit(musb);
+	phy_exit(musb->phy);
 
 	return 0;
 }
@@ -633,7 +648,7 @@ static int omap2430_runtime_suspend(struct device *dev)
 				OTG_INTERFSEL);
 
 		omap2430_low_level_exit(musb);
-		usb_phy_set_suspend(musb->xceiv, 1);
+		phy_power_off(musb->phy);
 	}
 
 	return 0;
@@ -648,8 +663,7 @@ static int omap2430_runtime_resume(struct device *dev)
 		omap2430_low_level_init(musb);
 		musb_writel(musb->mregs, OTG_INTERFSEL,
 				musb->context.otg_interfsel);
