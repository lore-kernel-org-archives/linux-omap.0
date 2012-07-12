From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 03/11] usb: musb: am335x: add support for dual instance
Date: Thu, 12 Jul 2012 15:23:26 +0530
Message-ID: <1342086814-32181-4-git-send-email-ajay.gupta@ti.com>
References: <1342086814-32181-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36839 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758995Ab2GLJxu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jul 2012 05:53:50 -0400
In-Reply-To: <1342086814-32181-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

AM335x and TI81xx platform has dual musb controller so updating the
musb_dspc.c to support the same.

Changes:
	- Moved otg_workaround timer to glue structure
	- Moved static local variable last_timer to glue structure
	- PHY on/off related cleanups

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/musb_dsps.c |   92 ++++++++++++++++++++++++++----------------
 1 files changed, 57 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 71fbe0e..e76b4d8 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -105,6 +105,8 @@ struct dsps_musb_wrapper {
 	/* miscellaneous stuff */
 	u32		musb_core_offset;
 	u8		poll_seconds;
+	/* number of musb instances */
+	u8		instances;
 };
 
 /**
@@ -112,16 +114,18 @@ struct dsps_musb_wrapper {
  */
 struct dsps_glue {
 	struct device *dev;
-	struct platform_device *musb;	/* child musb pdev */
+	struct platform_device *musb[2];	/* child musb pdev */
 	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
-	struct timer_list timer;	/* otg_workaround timer */
-	u32 __iomem *usb_ctrl;
+	struct timer_list timer[2];	/* otg_workaround timer */
+	unsigned long last_timer[2];    /* last timer data for each instance */
+	u32 __iomem *usb_ctrl[2];
 	u8      usbss_rev;
 };
 
 /**
  * musb_dsps_phy_control - phy on/off
  * @glue: struct dsps_glue *
+ * @id: musb instance
  * @on: flag for phy to be switched on or off
  *
  * This is to enable the PHY using usb_ctrl register in system control
@@ -130,11 +134,11 @@ struct dsps_glue {
  * XXX: This function will be removed once we have a seperate driver for
  * control module
  */
-static void musb_dsps_phy_control(struct dsps_glue *glue, u8 on)
+static void musb_dsps_phy_control(struct dsps_glue *glue, u8 id, u8 on)
 {
 	u32 usbphycfg;
 
-	usbphycfg = __raw_readl(glue->usb_ctrl);
+	usbphycfg = __raw_readl(glue->usb_ctrl[id]);
 
 	if (on) {
 		if (glue->usbss_rev == MUSB_USBSS_REV_816X) {
@@ -157,7 +161,7 @@ static void musb_dsps_phy_control(struct dsps_glue *glue, u8 on)
 				glue->usbss_rev == MUSB_USBSS_REV_33XX)
 			usbphycfg |= USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
 	}
-	__raw_writel(usbphycfg, glue->usb_ctrl);
+	__raw_writel(usbphycfg, glue->usb_ctrl[id]);
 }
 /**
  * dsps_musb_enable - enable interrupts
@@ -247,7 +251,7 @@ static void otg_timer(unsigned long _musb)
 
 		devctl = dsps_readb(mregs, MUSB_DEVCTL);
 		if (devctl & MUSB_DEVCTL_BDEVICE)
-			mod_timer(&glue->timer,
+			mod_timer(&glue->timer[musb->id],
 					jiffies + wrp->poll_seconds * HZ);
 		else
 			musb->xceiv->state = OTG_STATE_A_IDLE;
@@ -263,7 +267,6 @@ static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
 	struct device *dev = musb->controller;
 	struct platform_device *pdev = to_platform_device(dev->parent);
 	struct dsps_glue *glue = platform_get_drvdata(pdev);
-	static unsigned long last_timer;
 
 	if (!is_otg_enabled(musb))
 		return;
@@ -276,22 +279,23 @@ static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
 				musb->xceiv->state == OTG_STATE_A_WAIT_BCON)) {
 		dev_dbg(musb->controller, "%s active, deleting timer\n",
 				otg_state_string(musb->xceiv->state));
-		del_timer(&glue->timer);
-		last_timer = jiffies;
+		del_timer(&glue->timer[musb->id]);
+		glue->last_timer[musb->id] = jiffies;
 		return;
 	}
 
-	if (time_after(last_timer, timeout) && timer_pending(&glue->timer)) {
+	if (time_after(glue->last_timer[musb->id], timeout) &&
+				timer_pending(&glue->timer[musb->id])) {
 		dev_dbg(musb->controller,
 			"Longer idle timer already pending, ignoring...\n");
 		return;
 	}
-	last_timer = timeout;
+	glue->last_timer[musb->id] = timeout;
 
 	dev_dbg(musb->controller, "%s inactive, starting idle timer for %u ms\n",
 		otg_state_string(musb->xceiv->state),
 			jiffies_to_msecs(timeout - jiffies));
-	mod_timer(&glue->timer, timeout);
+	mod_timer(&glue->timer[musb->id], timeout);
 }
 
 static irqreturn_t dsps_interrupt(int irq, void *hci)
@@ -360,7 +364,7 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 			 */
 			musb->int_usb &= ~MUSB_INTR_VBUSERROR;
 			musb->xceiv->state = OTG_STATE_A_WAIT_VFALL;
-			mod_timer(&glue->timer,
+			mod_timer(&glue->timer[musb->id],
 					jiffies + wrp->poll_seconds * HZ);
 			WARNING("VBUS error workaround (delay coming)\n");
 		} else if (is_host_enabled(musb) && drvvbus) {
@@ -368,7 +372,7 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 			MUSB_HST_MODE(musb);
 			musb->xceiv->otg->default_a = 1;
 			musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
-			del_timer(&glue->timer);
+			del_timer(&glue->timer[musb->id]);
 		} else {
 			musb->is_active = 0;
 			MUSB_DEV_MODE(musb);
@@ -395,7 +399,8 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 
 	/* Poll for ID change */
 	if (is_otg_enabled(musb) && musb->xceiv->state == OTG_STATE_B_IDLE)
-		mod_timer(&glue->timer, jiffies + wrp->poll_seconds * HZ);
+		mod_timer(&glue->timer[musb->id],
+				jiffies + wrp->poll_seconds * HZ);
 
 	spin_unlock_irqrestore(&musb->lock, flags);
 
@@ -429,13 +434,14 @@ static int dsps_musb_init(struct musb *musb)
 	}
 
 	if (is_host_enabled(musb))
-		setup_timer(&glue->timer, otg_timer, (unsigned long) musb);
+		setup_timer(&glue->timer[musb->id], otg_timer,
+			(unsigned long) musb);
 
 	/* Reset the musb */
 	dsps_writel(reg_base, wrp->control, (1 << wrp->reset));
 
 	/* Start the on-chip PHY and its PLL. */
-	musb_dsps_phy_control(glue, 1);
+	musb_dsps_phy_control(glue, musb->id, 1);
 
 	musb->isr = dsps_interrupt;
 
@@ -461,10 +467,10 @@ static int dsps_musb_exit(struct musb *musb)
 	struct dsps_glue *glue = platform_get_drvdata(pdev);
 
 	if (is_host_enabled(musb))
-		del_timer_sync(&glue->timer);
+		del_timer_sync(&glue->timer[musb->id]);
 
 	/* Shutdown the on-chip PHY and its PLL. */
-	musb_dsps_phy_control(glue, 0);
+	musb_dsps_phy_control(glue, musb->id, 0);
 
 	/* NOP driver needs change if supporting dual instance */
 	usb_put_phy(musb->xceiv);
@@ -504,8 +510,8 @@ static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 		goto err0;
 	}
 
-	glue->usb_ctrl = devm_request_and_ioremap(&pdev->dev, res);
-	if (glue->usb_ctrl == NULL) {
+	glue->usb_ctrl[id] = devm_request_and_ioremap(&pdev->dev, res);
+	if (glue->usb_ctrl[id] == NULL) {
 		dev_err(dev, "Failed to obtain usb_ctrl%d memory\n", id);
 		ret = -ENODEV;
 		goto err0;
@@ -542,11 +548,12 @@ static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 		goto err0;
 	}
 
+	musb->id			= id;
 	musb->dev.parent		= dev;
 	musb->dev.dma_mask		= &musb_dmamask;
 	musb->dev.coherent_dma_mask	= musb_dmamask;
 
-	glue->musb			= musb;
+	glue->musb[id]			= musb;
 
 	pdata->platform_ops		= &dsps_ops;
 
@@ -576,10 +583,10 @@ err0:
 	return ret;
 }
 
-static void __devexit dsps_delete_musb_pdev(struct dsps_glue *glue)
+static void __devexit dsps_delete_musb_pdev(struct dsps_glue *glue, u8 id)
 {
-	platform_device_del(glue->musb);
-	platform_device_put(glue->musb);
+	platform_device_del(glue->musb[id]);
+	platform_device_put(glue->musb[id]);
 }
 
 static int __devinit dsps_probe(struct platform_device *pdev)
@@ -590,7 +597,7 @@ static int __devinit dsps_probe(struct platform_device *pdev)
 	struct dsps_glue *glue;
 	struct resource *iomem;
 	u32 __iomem *usbss;
-	int ret;
+	int ret, i;
 
 	/* allocate glue */
 	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
@@ -634,11 +641,16 @@ static int __devinit dsps_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
-	/* create the child platform device for first instances of musb */
-	ret = dsps_create_musb_pdev(glue, 0);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "failed to create child pdev\n");
-		goto err3;
+	/* create the child platform device for all instances of musb */
+	for (i = 0; i < wrp->instances ; i++) {
+		ret = dsps_create_musb_pdev(glue, i);
+		if (ret != 0) {
+			dev_err(&pdev->dev, "failed to create child pdev\n");
+			/* release resources of previously created instances */
+			for (i--; i >= 0 ; i--)
+				dsps_delete_musb_pdev(glue, i);
+			goto err3;
+		}
 	}
 
 	/* read the usbss revision register */
@@ -659,9 +671,12 @@ err0:
 static int __devexit dsps_remove(struct platform_device *pdev)
 {
 	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	const struct dsps_musb_wrapper *wrp = glue->wrp;
+	int i;
 
 	/* delete the child platform device */
-	dsps_delete_musb_pdev(glue);
+	for (i = 0; i < wrp->instances ; i++)
+		dsps_delete_musb_pdev(glue, i);
 
 	/* disable usbss clocks */
 	pm_runtime_put(&pdev->dev);
@@ -676,9 +691,12 @@ static int dsps_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev->parent);
 	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	const struct dsps_musb_wrapper *wrp = glue->wrp;
+	int i;
 
 	/* Shutdown the on-chip PHY and its PLL. */
-	musb_dsps_phy_control(glue, 0);
+	for (i = 0 ; i < wrp->instances ; i++)
+		musb_dsps_phy_control(glue, i, 0);
 
 	return 0;
 }
@@ -687,9 +705,12 @@ static int dsps_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev->parent);
 	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	const struct dsps_musb_wrapper *wrp = glue->wrp;
+	int i;
 
 	/* Start the on-chip PHY and its PLL. */
-	musb_dsps_phy_control(glue, 1);
+	for (i = 0 ; i < wrp->instances ; i++)
+		musb_dsps_phy_control(glue, i, 1);
 
 	return 0;
 }
@@ -725,6 +746,7 @@ static const struct dsps_musb_wrapper ti81xx_driver_data __devinitconst = {
 	.rxep_bitmap		= (0xfffe << 16),
 	.musb_core_offset	= 0x400,
 	.poll_seconds		= 2,
+	.instances		= 2,
 };
 
 static const struct platform_device_id musb_dsps_id_table[] __devinitconst = {
-- 
1.7.0.4

