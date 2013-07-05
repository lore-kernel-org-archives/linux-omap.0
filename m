From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/5] usb: musb: dsps: remove the hardcoded phy pieces
Date: Fri,  5 Jul 2013 15:32:56 +0200
Message-ID: <1373031178-8871-4-git-send-email-bigeasy@linutronix.de>
References: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45311 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756922Ab3GENdG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jul 2013 09:33:06 -0400
In-Reply-To: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, george.cherian@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, b-cousson@ti.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

dsps uses a nop driver which is added in dsps itself and does the PHY
on/off calls within dsps. Since those calls are now moved the nop driver
itself, we can now request the phy proper phy and remove those calls.
Currently only the first musb interface is used so we only add one phy
node for now.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/boot/dts/am335x-bone.dts  |  4 ++
 arch/arm/boot/dts/am335x-evm.dts   |  4 ++
 arch/arm/boot/dts/am335x-evmsk.dts |  4 ++
 arch/arm/boot/dts/am33xx.dtsi      |  1 +
 drivers/usb/musb/musb_dsps.c       | 97 +-------------------------------------
 5 files changed, 14 insertions(+), 96 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 04feaf8..83184e5 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -120,6 +120,10 @@
 			status = "okay";
 		};
 
+		musb0_phy: phy0@47401000 {
+			status = "okay";
+		};
+
 		i2c0: i2c@44e0b000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins>;
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index a16bb96..317637a 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -171,6 +171,10 @@
 			};
 		};
 
+		musb0_phy: phy0@47401000 {
+			status = "okay";
+		};
+
 		i2c1: i2c@4802a000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c1_pins>;
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 9e00eef..99d9444 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -207,6 +207,10 @@
 			};
 		};
 
+		musb0_phy: phy0@47401000 {
+			status = "okay";
+		};
+
 		epwmss2: epwmss@48304000 {
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index a24f1cb..66bb420 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -364,6 +364,7 @@
 			port1-mode = <3>;
 			power = <250>;
 			ti,hwmods = "usb_otg_hs";
+			phys = <&musb1_phy>;
 		};
 
 		epwmss0: epwmss@48300000 {
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index e1b661d..22ad532 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -123,49 +123,8 @@ struct dsps_glue {
 	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
 	struct timer_list timer[2];	/* otg_workaround timer */
 	unsigned long last_timer[2];    /* last timer data for each instance */
-	u32 __iomem *usb_ctrl[2];
 };
 
-#define	DSPS_AM33XX_CONTROL_MODULE_PHYS_0	0x44e10620
-#define	DSPS_AM33XX_CONTROL_MODULE_PHYS_1	0x44e10628
-
-static const resource_size_t dsps_control_module_phys[] = {
-	DSPS_AM33XX_CONTROL_MODULE_PHYS_0,
-	DSPS_AM33XX_CONTROL_MODULE_PHYS_1,
-};
-
-#define USBPHY_CM_PWRDN		(1 << 0)
-#define USBPHY_OTG_PWRDN	(1 << 1)
-#define USBPHY_OTGVDET_EN	(1 << 19)
-#define USBPHY_OTGSESSEND_EN	(1 << 20)
-
-/**
- * musb_dsps_phy_control - phy on/off
- * @glue: struct dsps_glue *
- * @id: musb instance
- * @on: flag for phy to be switched on or off
- *
- * This is to enable the PHY using usb_ctrl register in system control
- * module space.
- *
- * XXX: This function will be removed once we have a seperate driver for
- * control module
- */
-static void musb_dsps_phy_control(struct dsps_glue *glue, u8 id, u8 on)
-{
-	u32 usbphycfg;
-
-	usbphycfg = readl(glue->usb_ctrl[id]);
-
-	if (on) {
-		usbphycfg &= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN);
-		usbphycfg |= USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN;
-	} else {
-		usbphycfg |= USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
-	}
-
-	writel(usbphycfg, glue->usb_ctrl[id]);
-}
 /**
  * dsps_musb_enable - enable interrupts
  */
@@ -416,8 +375,7 @@ static int dsps_musb_init(struct musb *musb)
 	musb->mregs += wrp->musb_core_offset;
 
 	/* NOP driver needs change if supporting dual instance */
-	usb_nop_xceiv_register();
-	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
+	musb->xceiv = devm_usb_get_phy_by_phandle(glue->dev, "phys", 0);
 	if (IS_ERR_OR_NULL(musb->xceiv))
 		return -EPROBE_DEFER;
 
@@ -433,9 +391,6 @@ static int dsps_musb_init(struct musb *musb)
 	/* Reset the musb */
 	dsps_writel(reg_base, wrp->control, (1 << wrp->reset));
 
-	/* Start the on-chip PHY and its PLL. */
-	musb_dsps_phy_control(glue, pdev->id, 1);
-
 	musb->isr = dsps_interrupt;
 
 	/* reset the otgdisable bit, needed for host mode to work */
@@ -448,8 +403,6 @@ static int dsps_musb_init(struct musb *musb)
 
 	return 0;
 err0:
-	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
 	return status;
 }
 
@@ -461,13 +414,6 @@ static int dsps_musb_exit(struct musb *musb)
 
 	del_timer_sync(&glue->timer[pdev->id]);
 
-	/* Shutdown the on-chip PHY and its PLL. */
-	musb_dsps_phy_control(glue, pdev->id, 0);
-
-	/* NOP driver needs change if supporting dual instance */
-	usb_put_phy(musb->xceiv);
-	usb_nop_xceiv_unregister();
-
 	return 0;
 }
 
@@ -496,16 +442,6 @@ static int dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 	char res_name[11];
 	int ret;
 
-	resources[0].start = dsps_control_module_phys[id];
-	resources[0].end = resources[0].start + SZ_4 - 1;
-	resources[0].flags = IORESOURCE_MEM;
-
-	glue->usb_ctrl[id] = devm_ioremap_resource(&pdev->dev, resources);
-	if (IS_ERR(glue->usb_ctrl[id])) {
-		ret = PTR_ERR(glue->usb_ctrl[id]);
-		goto err0;
-	}
-
 	/* first resource is for usbss, so start index from 1 */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, id + 1);
 	if (!res) {
@@ -689,36 +625,6 @@ static int dsps_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int dsps_suspend(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct dsps_glue *glue = platform_get_drvdata(pdev);
-	const struct dsps_musb_wrapper *wrp = glue->wrp;
-	int i;
-
-	for (i = 0; i < wrp->instances; i++)
-		musb_dsps_phy_control(glue, i, 0);
-
-	return 0;
-}
-
-static int dsps_resume(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev->parent);
-	struct dsps_glue *glue = platform_get_drvdata(pdev);
-	const struct dsps_musb_wrapper *wrp = glue->wrp;
-	int i;
-
-	for (i = 0; i < wrp->instances; i++)
-		musb_dsps_phy_control(glue, i, 1);
-
-	return 0;
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(dsps_pm_ops, dsps_suspend, dsps_resume);
-
 static const struct dsps_musb_wrapper ti81xx_driver_data = {
 	.revision		= 0x00,
 	.control		= 0x14,
@@ -773,7 +679,6 @@ static struct platform_driver dsps_usbss_driver = {
 	.remove         = dsps_remove,
 	.driver         = {
 		.name   = "musb-dsps",
-		.pm	= &dsps_pm_ops,
 		.of_match_table	= of_match_ptr(musb_dsps_of_match),
 	},
 	.id_table	= musb_dsps_id_table,
-- 
1.8.3.2

