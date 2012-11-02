From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 1/5] usb: musb: dsps: remove platform callback
Date: Fri, 2 Nov 2012 22:02:28 +0530
Message-ID: <6d119c23435a6ecbb47856ae71539efeac39271a.1351870620.git.afzal@ti.com>
References: <cover.1351870620.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <cover.1351870620.git.afzal@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Santhapuri Damodar <damodar.santhapuri@ti.com>, Ravi Babu <ravibabu@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

dsps wrapper is dt only, it cannot execute platform callbacks.
Presence of this would cause NULL dereference, hence remove it.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 drivers/usb/musb/musb_dsps.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 625400f..2396bcd 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -365,11 +365,9 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 static int dsps_musb_init(struct musb *musb)
 {
 	struct device *dev = musb->controller;
-	struct musb_hdrc_platform_data *plat = dev->platform_data;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
-	struct omap_musb_board_data *data = plat->board_data;
 	void __iomem *reg_base = musb->ctrl_base;
 	u32 rev, val;
 	int status;
@@ -395,10 +393,6 @@ static int dsps_musb_init(struct musb *musb)
 	/* Reset the musb */
 	dsps_writel(reg_base, wrp->control, (1 << wrp->reset));
 
-	/* Start the on-chip PHY and its PLL. */
-	if (data->set_phy_power)
-		data->set_phy_power(1);
-
 	musb->isr = dsps_interrupt;
 
 	/* reset the otgdisable bit, needed for host mode to work */
@@ -419,17 +413,11 @@ err0:
 static int dsps_musb_exit(struct musb *musb)
 {
 	struct device *dev = musb->controller;
-	struct musb_hdrc_platform_data *plat = dev->platform_data;
-	struct omap_musb_board_data *data = plat->board_data;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
 
 	del_timer_sync(&glue->timer[pdev->id]);
 
-	/* Shutdown the on-chip PHY and its PLL. */
-	if (data->set_phy_power)
-		data->set_phy_power(0);
-
 	/* NOP driver needs change if supporting dual instance */
 	usb_put_phy(musb->xceiv);
 	usb_nop_xceiv_unregister();
@@ -650,25 +638,11 @@ static int __devexit dsps_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int dsps_suspend(struct device *dev)
 {
-	struct musb_hdrc_platform_data *plat = dev->platform_data;
-	struct omap_musb_board_data *data = plat->board_data;
-
-	/* Shutdown the on-chip PHY and its PLL. */
-	if (data->set_phy_power)
-		data->set_phy_power(0);
-
 	return 0;
 }
 
 static int dsps_resume(struct device *dev)
 {
-	struct musb_hdrc_platform_data *plat = dev->platform_data;
-	struct omap_musb_board_data *data = plat->board_data;
-
-	/* Start the on-chip PHY and its PLL. */
-	if (data->set_phy_power)
-		data->set_phy_power(1);
-
 	return 0;
 }
 #endif
-- 
1.7.12

