From: Ravi Babu <ravibabu@ti.com>
Subject: [PATCH v10 3/5] usb: musb: am335x: add support for dual instance
Date: Tue, 11 Sep 2012 21:43:17 +0530
Message-ID: <1347379999-26061-4-git-send-email-ravibabu@ti.com>
References: <1347379999-26061-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47033 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757612Ab2IKQNb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 12:13:31 -0400
In-Reply-To: <1347379999-26061-1-git-send-email-ravibabu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com

From: B, Ravi <ravibabu@ti.com>

AM335x and TI81xx platform has dual musb controller so updating the
musb_dspc.c to support the same.

Changes:
        - Moved otg_workaround timer to glue structure
        - Moved static local variable last_timer to glue structure
        - PHY on/off related cleanups

Signed-off-by: Ravi Babu <ravibabu@ti.com>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
[afzal@ti.com: remove control module related modifications]
Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/musb_dsps.c |   81 +++++++++++++++++++++++++----------------
 1 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 5351e96..796fc60 100644
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
@@ -112,9 +114,10 @@ struct dsps_musb_wrapper {
  */
 struct dsps_glue {
 	struct device *dev;
-	struct platform_device *musb;	/* child musb pdev */
+	struct platform_device *musb[2];	/* child musb pdev */
 	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
-	struct timer_list timer;	/* otg_workaround timer */
+	struct timer_list timer[2];	/* otg_workaround timer */
+	unsigned long last_timer[2];    /* last timer data for each instance */
 };
 
 /**
@@ -164,8 +167,8 @@ static void otg_timer(unsigned long _musb)
 	struct musb *musb = (void *)_musb;
 	void __iomem *mregs = musb->mregs;
 	struct device *dev = musb->controller;
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	u8 devctl;
 	unsigned long flags;
@@ -201,7 +204,7 @@ static void otg_timer(unsigned long _musb)
 	case OTG_STATE_B_IDLE:
 		devctl = dsps_readb(mregs, MUSB_DEVCTL);
 		if (devctl & MUSB_DEVCTL_BDEVICE)
-			mod_timer(&glue->timer,
+			mod_timer(&glue->timer[pdev->id],
 					jiffies + wrp->poll_seconds * HZ);
 		else
 			musb->xceiv->state = OTG_STATE_A_IDLE;
@@ -215,9 +218,8 @@ static void otg_timer(unsigned long _musb)
 static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
 {
 	struct device *dev = musb->controller;
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct dsps_glue *glue = platform_get_drvdata(pdev);
-	static unsigned long last_timer;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
 
 	if (timeout == 0)
 		timeout = jiffies + msecs_to_jiffies(3);
@@ -227,22 +229,23 @@ static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
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
@@ -250,8 +253,8 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 	struct musb  *musb = hci;
 	void __iomem *reg_base = musb->ctrl_base;
 	struct device *dev = musb->controller;
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
@@ -310,7 +313,7 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 			 */
 			musb->int_usb &= ~MUSB_INTR_VBUSERROR;
 			musb->xceiv->state = OTG_STATE_A_WAIT_VFALL;
-			mod_timer(&glue->timer,
+			mod_timer(&glue->timer[pdev->id],
 					jiffies + wrp->poll_seconds * HZ);
 			WARNING("VBUS error workaround (delay coming)\n");
 		} else if (drvvbus) {
@@ -318,7 +321,7 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 			MUSB_HST_MODE(musb);
 			musb->xceiv->otg->default_a = 1;
 			musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
-			del_timer(&glue->timer);
+			del_timer(&glue->timer[pdev->id]);
 		} else {
 			musb->is_active = 0;
 			MUSB_DEV_MODE(musb);
@@ -345,7 +348,8 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 
 	/* Poll for ID change */
 	if (musb->xceiv->state == OTG_STATE_B_IDLE)
-		mod_timer(&glue->timer, jiffies + wrp->poll_seconds * HZ);
+		mod_timer(&glue->timer[pdev->id],
+			 jiffies + wrp->poll_seconds * HZ);
 
 	spin_unlock_irqrestore(&musb->lock, flags);
 
@@ -356,8 +360,8 @@ static int dsps_musb_init(struct musb *musb)
 {
 	struct device *dev = musb->controller;
 	struct musb_hdrc_platform_data *plat = dev->platform_data;
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	struct omap_musb_board_data *data = plat->board_data;
 	void __iomem *reg_base = musb->ctrl_base;
@@ -380,7 +384,7 @@ static int dsps_musb_init(struct musb *musb)
 		goto err0;
 	}
 
-	setup_timer(&glue->timer, otg_timer, (unsigned long) musb);
+	setup_timer(&glue->timer[pdev->id], otg_timer, (unsigned long) musb);
 
 	/* Reset the musb */
 	dsps_writel(reg_base, wrp->control, (1 << wrp->reset));
@@ -411,10 +415,10 @@ static int dsps_musb_exit(struct musb *musb)
 	struct device *dev = musb->controller;
 	struct musb_hdrc_platform_data *plat = dev->platform_data;
 	struct omap_musb_board_data *data = plat->board_data;
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct dsps_glue *glue = platform_get_drvdata(pdev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
 
-	del_timer_sync(&glue->timer);
+	del_timer_sync(&glue->timer[pdev->id]);
 
 	/* Shutdown the on-chip PHY and its PLL. */
 	if (data->set_phy_power)
@@ -493,7 +497,7 @@ static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 	musb->dev.dma_mask		= &musb_dmamask;
 	musb->dev.coherent_dma_mask	= musb_dmamask;
 
-	glue->musb			= musb;
+	glue->musb[id]			= musb;
 
 	pdata->platform_ops		= &dsps_ops;
 
@@ -525,11 +529,11 @@ err0:
 	return ret;
 }
 
-static void __devexit dsps_delete_musb_pdev(struct dsps_glue *glue)
+static void dsps_delete_musb_pdev(struct dsps_glue *glue, u8 id)
 {
-	musb_put_id(glue->dev, glue->musb->id);
-	platform_device_del(glue->musb);
-	platform_device_put(glue->musb);
+	musb_put_id(glue->dev, glue->musb[id]->id);
+	platform_device_del(glue->musb[id]);
+	platform_device_put(glue->musb[id]);
 }
 
 static int __devinit dsps_probe(struct platform_device *pdev)
@@ -539,7 +543,7 @@ static int __devinit dsps_probe(struct platform_device *pdev)
 				(struct dsps_musb_wrapper *)id->driver_data;
 	struct dsps_glue *glue;
 	struct resource *iomem;
-	int ret;
+	int ret, i;
 
 	/* allocate glue */
 	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
@@ -580,7 +584,16 @@ static int __devinit dsps_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pm_runtime_get_sync FAILED");
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
 
 	return 0;
@@ -597,9 +610,12 @@ err0:
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
@@ -665,6 +681,7 @@ static const struct dsps_musb_wrapper ti81xx_driver_data __devinitconst = {
 	.rxep_bitmap		= (0xfffe << 16),
 	.musb_core_offset	= 0x400,
 	.poll_seconds		= 2,
+	.instances		= 2,
 };
 
 static const struct platform_device_id musb_dsps_id_table[] __devinitconst = {
-- 
1.7.0.4

