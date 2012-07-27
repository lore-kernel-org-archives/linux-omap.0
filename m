From: Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v6 03/11] usb: musb: am335x: add support for dual instance
Date: Fri, 27 Jul 2012 14:01:59 +0530
Message-ID: <1343377927-7850-3-git-send-email-ravibabu@ti.com>
References: <1343377927-7850-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343377927-7850-1-git-send-email-ravibabu-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

AM335x and TI81xx platform has dual musb controller so updating the
musb_dspc.c to support the same.

Changes:
	- Moved otg_workaround timer to glue structure
	- Moved static local variable last_timer to glue structure
	- PHY on/off related cleanups

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Signed-off-by: Ravi B <ravibabu-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_dsps.c |  118 +++++++++++++++++++++++++----------------
 1 files changed, 72 insertions(+), 46 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 2174699..2fd5dc8 100644
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
@@ -207,8 +211,9 @@ static void otg_timer(unsigned long _musb)
 	struct musb *musb = (void *)_musb;
 	void __iomem *mregs = musb->mregs;
 	struct device *dev = musb->controller;
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *parent_pdev = to_platform_device(dev->parent);
+	struct dsps_glue *glue = platform_get_drvdata(parent_pdev);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	u8 devctl;
 	unsigned long flags;
@@ -247,7 +252,7 @@ static void otg_timer(unsigned long _musb)
 
 		devctl = dsps_readb(mregs, MUSB_DEVCTL);
 		if (devctl & MUSB_DEVCTL_BDEVICE)
-			mod_timer(&glue->timer,
+			mod_timer(&glue->timer[pdev->id],
 					jiffies + wrp->poll_seconds * HZ);
 		else
 			musb->xceiv->state = OTG_STATE_A_IDLE;
@@ -261,9 +266,9 @@ static void otg_timer(unsigned long _musb)
 static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
 {
 	struct device *dev = musb->controller;
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct dsps_glue *glue = platform_get_drvdata(pdev);
-	static unsigned long last_timer;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *parent_pdev = to_platform_device(dev->parent);
+	struct dsps_glue *glue = platform_get_drvdata(parent_pdev);
 
 	if (!is_otg_enabled(musb))
 		return;
@@ -276,22 +281,23 @@ static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
 				musb->xceiv->state == OTG_STATE_A_WAIT_BCON)) {
 		dev_dbg(musb->controller, "%s active, deleting timer\n",
 				otg_state_string(musb->xceiv->state));
-		del_timer(&glue->timer);
-		last_timer = jiffies;
+		del_timer(&glue->timer[pdev->id]);
+		glue->last_timer[pdev->id] = jiffies;
 		return;
 	}
 
-	if (time_after(last_timer, timeout) && timer_pending(&glue->timer)) {
+	if (time_after(glue->last_timer[pdev->id], timeout) &&
+				timer_pending(&glue->timer[pdev->id])) {
 		dev_dbg(musb->controller,
 			"Longer idle timer already pending, ignoring...\n");
 		return;
 	}
-	last_timer = timeout;
+	glue->last_timer[pdev->id] = timeout;
 
 	dev_dbg(musb->controller, "%s inactive, starting idle timer for %u ms\n",
 		otg_state_string(musb->xceiv->state),
 			jiffies_to_msecs(timeout - jiffies));
-	mod_timer(&glue->timer, timeout);
+	mod_timer(&glue->timer[pdev->id], timeout);
 }
 
 static irqreturn_t dsps_interrupt(int irq, void *hci)
@@ -299,8 +305,9 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 	struct musb  *musb = hci;
 	void __iomem *reg_base = musb->ctrl_base;
 	struct device *dev = musb->controller;
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *parent_pdev = to_platform_device(dev->parent);
+	struct dsps_glue *glue = platform_get_drvdata(parent_pdev);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
@@ -360,7 +367,7 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 			 */
 			musb->int_usb &= ~MUSB_INTR_VBUSERROR;
 			musb->xceiv->state = OTG_STATE_A_WAIT_VFALL;
-			mod_timer(&glue->timer,
+			mod_timer(&glue->timer[pdev->id],
 					jiffies + wrp->poll_seconds * HZ);
 			WARNING("VBUS error workaround (delay coming)\n");
 		} else if (is_host_enabled(musb) && drvvbus) {
@@ -368,7 +375,7 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 			MUSB_HST_MODE(musb);
 			musb->xceiv->otg->default_a = 1;
 			musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
-			del_timer(&glue->timer);
+			del_timer(&glue->timer[pdev->id]);
 		} else {
 			musb->is_active = 0;
 			MUSB_DEV_MODE(musb);
@@ -395,7 +402,8 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 
 	/* Poll for ID change */
 	if (is_otg_enabled(musb) && musb->xceiv->state == OTG_STATE_B_IDLE)
-		mod_timer(&glue->timer, jiffies + wrp->poll_seconds * HZ);
+		mod_timer(&glue->timer[pdev->id],
+				jiffies + wrp->poll_seconds * HZ);
 
 	spin_unlock_irqrestore(&musb->lock, flags);
 
@@ -405,8 +413,9 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 static int dsps_musb_init(struct musb *musb)
 {
 	struct device *dev = musb->controller;
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *parent_pdev = to_platform_device(dev->parent);
+	struct dsps_glue *glue = platform_get_drvdata(parent_pdev);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	void __iomem *reg_base = musb->ctrl_base;
 	u32 rev, val;
@@ -429,13 +438,14 @@ static int dsps_musb_init(struct musb *musb)
 	}
 
 	if (is_host_enabled(musb))
-		setup_timer(&glue->timer, otg_timer, (unsigned long) musb);
+		setup_timer(&glue->timer[pdev->id], otg_timer,
+			(unsigned long) musb);
 
 	/* Reset the musb */
 	dsps_writel(reg_base, wrp->control, (1 << wrp->reset));
 
 	/* Start the on-chip PHY and its PLL. */
-	musb_dsps_phy_control(glue, 1);
+	musb_dsps_phy_control(glue, pdev->id, 1);
 
 	musb->isr = dsps_interrupt;
 
@@ -457,14 +467,15 @@ err0:
 static int dsps_musb_exit(struct musb *musb)
 {
 	struct device *dev = musb->controller;
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_device *parent_pdev = to_platform_device(dev->parent);
+	struct dsps_glue *glue = platform_get_drvdata(parent_pdev);
 
 	if (is_host_enabled(musb))
-		del_timer_sync(&glue->timer);
+		del_timer_sync(&glue->timer[pdev->id]);
 
 	/* Shutdown the on-chip PHY and its PLL. */
-	musb_dsps_phy_control(glue, 0);
+	musb_dsps_phy_control(glue, pdev->id, 0);
 
 	/* NOP driver needs change if supporting dual instance */
 	usb_put_phy(musb->xceiv);
@@ -504,8 +515,8 @@ static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 		goto err0;
 	}
 
-	glue->usb_ctrl = devm_request_and_ioremap(&pdev->dev, res);
-	if (glue->usb_ctrl == NULL) {
+	glue->usb_ctrl[id] = devm_request_and_ioremap(&pdev->dev, res);
+	if (glue->usb_ctrl[id] == NULL) {
 		dev_err(dev, "Failed to obtain usb_ctrl%d memory\n", id);
 		ret = -ENODEV;
 		goto err0;
@@ -554,7 +565,7 @@ static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 	musb->dev.dma_mask		= &musb_dmamask;
 	musb->dev.coherent_dma_mask	= musb_dmamask;
 
-	glue->musb			= musb;
+	glue->musb[id]			= musb;
 
 	pdata->platform_ops		= &dsps_ops;
 
@@ -586,11 +597,11 @@ err0:
 	return ret;
 }
 
-static void __devexit dsps_delete_musb_pdev(struct dsps_glue *glue)
+static void __devexit dsps_delete_musb_pdev(struct dsps_glue *glue, u8 id)
 {
-	musb_put_id(glue->dev, glue->musb->id);
-	platform_device_del(glue->musb);
-	platform_device_put(glue->musb);
+	musb_put_id(glue->dev, glue->musb[id]->id);
+	platform_device_del(glue->musb[id]);
+	platform_device_put(glue->musb[id]);
 }
 
 static int __devinit dsps_probe(struct platform_device *pdev)
@@ -601,7 +612,7 @@ static int __devinit dsps_probe(struct platform_device *pdev)
 	struct dsps_glue *glue;
 	struct resource *iomem;
 	u32 __iomem *usbss;
-	int ret;
+	int ret, i;
 
 	/* allocate glue */
 	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
@@ -645,11 +656,16 @@ static int __devinit dsps_probe(struct platform_device *pdev)
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
@@ -670,9 +686,12 @@ err0:
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
@@ -687,9 +706,12 @@ static int dsps_suspend(struct device *dev)
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
@@ -698,9 +720,12 @@ static int dsps_resume(struct device *dev)
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
@@ -736,6 +761,7 @@ static const struct dsps_musb_wrapper ti81xx_driver_data __devinitconst = {
 	.rxep_bitmap		= (0xfffe << 16),
 	.musb_core_offset	= 0x400,
 	.poll_seconds		= 2,
+	.instances		= 2,
 };
 
 static const struct platform_device_id musb_dsps_id_table[] __devinitconst = {
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
