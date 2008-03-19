From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 5/7] I2C: TWL4030: Make twl4030-usb.c initialize otg_transceiver
Date: Wed, 19 Mar 2008 15:42:33 +0200
Message-ID: <1205934155-24070-6-git-send-email-felipe.balbi@nokia.com>
References: <1205934155-24070-1-git-send-email-felipe.balbi@nokia.com>
 <1205934155-24070-2-git-send-email-felipe.balbi@nokia.com>
 <1205934155-24070-3-git-send-email-felipe.balbi@nokia.com>
 <1205934155-24070-4-git-send-email-felipe.balbi@nokia.com>
 <1205934155-24070-5-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-fb01.nokia.com ([192.100.122.235]:48092 "EHLO
	mgw-fb01.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758454AbYCSUNM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2008 16:13:12 -0400
Received: from mgw-mx03.nokia.com (mgw-mx03.nokia.com [192.100.122.230])
	by mgw-fb01.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2JEGKdI029424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-omap@vger.kernel.org>; Wed, 19 Mar 2008 16:16:21 +0200
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2JDinlK002018
	for <linux-omap@vger.kernel.org>; Wed, 19 Mar 2008 15:44:49 +0200
In-Reply-To: <1205934155-24070-5-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Code still needs some reorganization which will come in later
patches but we can already put omap3 in host mode by echo:ing
sysfs node

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-usb.c |  111 ++++++++++++++++++++++++++++++++++++---
 drivers/usb/musb/musb_core.h    |    4 +-
 drivers/usb/musb/omap2430.c     |   25 ++++++---
 drivers/usb/musb/omap2430.h     |    8 ---
 4 files changed, 121 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index eca5aef..136e1c6 100644
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -28,7 +28,11 @@
 #include <linux/time.h>
 #include <linux/interrupt.h>
 #include <linux/usb.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/otg.h>
 #include <linux/i2c/twl4030.h>
+#include <asm/arch/usb.h>
 
 /* Register defines */
 
@@ -245,9 +249,28 @@
 #define REG_PWR_SIH_CTRL		0x07
 #define COR				(1 << 2)
 
+/* internal define on top of container_of */
+#define xceiv_to_twl(x)		container_of((x), struct twl4030_usb, otg);
+
+/* bits in OTG_CTRL_REG */
+
+#define	OTG_XCEIV_OUTPUTS \
+	(OTG_ASESSVLD|OTG_BSESSEND|OTG_BSESSVLD|OTG_VBUSVLD|OTG_ID)
+#define	OTG_XCEIV_INPUTS \
+	(OTG_PULLDOWN|OTG_PULLUP|OTG_DRV_VBUS|OTG_PD_VBUS|OTG_PU_VBUS|OTG_PU_ID)
+#define	OTG_CTRL_BITS \
+	(OTG_A_BUSREQ|OTG_A_SETB_HNPEN|OTG_B_BUSREQ|OTG_B_HNPEN|OTG_BUSDROP)
+	/* and OTG_PULLUP is sometimes written */
+
+#define	OTG_CTRL_MASK	(OTG_DRIVER_SEL| \
+	OTG_XCEIV_OUTPUTS|OTG_XCEIV_INPUTS| \
+	OTG_CTRL_BITS)
+
+
 /*-------------------------------------------------------------------------*/
 
 struct twl4030_usb {
+	struct otg_transceiver	otg;
 	int			irq;
 	u8			usb_mode;	/* pin configuration */
 #define T2_USB_MODE_ULPI		1
@@ -328,6 +351,7 @@ static inline int
 twl4030_usb_clear_bits(struct twl4030_usb *twl, u8 reg, u8 bits)
 {
 	return twl4030_usb_write(reg + 2, bits);
+
 }
 
 /*-------------------------------------------------------------------------*/
@@ -472,8 +496,8 @@ static void usb_irq_disable(void)
 	return;
 }
 
-void twl4030_phy_suspend(int controller_off);
-void twl4030_phy_resume(void);
+static void twl4030_phy_suspend(int controller_off);
+static void twl4030_phy_resume(void);
 
 static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
@@ -565,7 +589,7 @@ static void twl4030_usb_ldo_init(struct twl4030_usb *twl)
 	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, PROTECT_KEY);
 }
 
-void twl4030_phy_suspend(int controller_off)
+static void twl4030_phy_suspend(int controller_off)
 {
 	struct twl4030_usb *twl = the_transceiver;
 
@@ -583,10 +607,8 @@ void twl4030_phy_suspend(int controller_off)
 	twl->asleep = 1;
 	return;
 }
-EXPORT_SYMBOL(twl4030_phy_suspend);
 
-
-void twl4030_phy_resume(void)
+static void twl4030_phy_resume(void)
 {
 	struct twl4030_usb *twl = the_transceiver;
 
@@ -604,8 +626,76 @@ void twl4030_phy_resume(void)
 	twl->asleep = 0;
 	return;
 }
-EXPORT_SYMBOL(twl4030_phy_resume);
 
+static int twl4030_set_suspend(struct otg_transceiver *x, int suspend)
+{
+	if (suspend)
+		twl4030_phy_suspend(1);
+	else
+		twl4030_phy_resume();
+
+	return 0;
+}
+
+static int twl4030_set_peripheral(struct otg_transceiver *xceiv, struct usb_gadget *gadget)
+{
+	struct twl4030_usb *twl = xceiv_to_twl(xceiv);
+
+	if (!xceiv)
+		return -ENODEV;
+
+	if (!gadget) {
+		OTG_IRQ_EN_REG = 0;
+		twl4030_phy_suspend(1);
+		twl->otg.gadget = NULL;
+
+		return -ENODEV;
+	}
+
+	twl->otg.gadget = gadget;
+	twl4030_phy_resume();
+
+	OTG_CTRL_REG = (OTG_CTRL_REG & OTG_CTRL_MASK
+			& ~(OTG_XCEIV_OUTPUTS|OTG_CTRL_BITS))
+			| OTG_ID;
+
+	twl->otg.state = OTG_STATE_B_IDLE;
+
+	twl4030_usb_set_bits(twl, USB_INT_EN_RISE,
+			USB_INT_SESSVALID | USB_INT_VBUSVALID);
+	twl4030_usb_set_bits(twl, USB_INT_EN_FALL,
+			USB_INT_SESSVALID | USB_INT_VBUSVALID);
+
+	return 0;
+}
+
+static int twl4030_set_host(struct otg_transceiver *xceiv, struct usb_bus *host)
+{
+	struct twl4030_usb *twl = xceiv_to_twl(xceiv);
+
+	if (!xceiv)
+		return -ENODEV;
+
+	if (!host) {
+		OTG_IRQ_EN_REG = 0;
+		twl4030_phy_suspend(1);
+		twl->otg.host = NULL;
+
+		return -ENODEV;
+	}
+
+	twl->otg.host = host;
+	twl4030_phy_resume();
+
+	twl4030_usb_set_bits(twl, OTG_CTRL,
+			OTG_CTRL_DMPULLDOWN | OTG_CTRL_DPPULLDOWN);
+	twl4030_usb_set_bits(twl, USB_INT_EN_RISE, USB_INT_IDGND);
+	twl4030_usb_set_bits(twl, USB_INT_EN_FALL, USB_INT_IDGND);
+	twl4030_usb_set_bits(twl, FUNC_CTRL, FUNC_CTRL_SUSPENDM);
+	twl4030_usb_set_bits(twl, OTG_CTRL, OTG_CTRL_DRVVBUS);
+
+	return 0;
+}
 
 static int __init twl4030_usb_init(void)
 {
@@ -621,7 +711,10 @@ static int __init twl4030_usb_init(void)
 
 	the_transceiver = twl;
 
-	twl->irq = TWL4030_MODIRQ_PWR;
+	twl->irq		= TWL4030_MODIRQ_PWR;
+	twl->otg.set_host	= twl4030_set_host;
+	twl->otg.set_peripheral	= twl4030_set_peripheral;
+	twl->otg.set_suspend	= twl4030_set_suspend;
 
 	usb_irq_disable();
 	status = request_irq(twl->irq, twl4030_usb_irq,
@@ -648,6 +741,8 @@ static int __init twl4030_usb_init(void)
 	if (twl->usb_mode == T2_USB_MODE_ULPI)
 		twl4030_phy_suspend(1);
 
+	otg_set_transceiver(&twl->otg);
+
 	printk(KERN_INFO "Initialized TWL4030 USB module");
 
 	return 0;
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index a76ed82..3494b99 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -476,6 +476,8 @@ extern void musb_platform_disable(struct musb *musb);
 
 extern void musb_hnp_stop(struct musb *musb);
 
+extern void musb_platform_set_mode(struct musb *musb, u8 musb_mode);
+
 #if defined(CONFIG_USB_TUSB6010) || \
 	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
 extern void musb_platform_try_idle(struct musb *musb, unsigned long timeout);
@@ -485,10 +487,8 @@ extern void musb_platform_try_idle(struct musb *musb, unsigned long timeout);
 
 #ifdef CONFIG_USB_TUSB6010
 extern int musb_platform_get_vbus_status(struct musb *musb);
-extern void musb_platform_set_mode(struct musb *musb, u8 musb_mode);
 #else
 #define musb_platform_get_vbus_status(x)	0
-#define musb_platform_set_mode(x, y)		do {} while (0)
 #endif
 
 extern int __init musb_platform_init(struct musb *musb);
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index eacd6c4..3c46738 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -192,19 +192,26 @@ static int omap_set_power(struct otg_transceiver *x, unsigned mA)
 	return 0;
 }
 
-static int omap_set_suspend(struct otg_transceiver *x, int suspend)
+int musb_platform_resume(struct musb *musb);
+
+void musb_platform_set_mode(struct musb *musb, u8 musb_mode)
 {
-	if (suspend)
-		twl4030_phy_suspend(1);
-	else
-		twl4030_phy_resume();
-	return 0;
+	switch (musb_mode) {
+	case MUSB_HOST:
+		otg_set_host(&musb->xceiv, musb->xceiv.host);
+		break;
+	case MUSB_PERIPHERAL:
+		otg_set_peripheral(&musb->xceiv, musb->xceiv.gadget);
+		break;
+	case MUSB_OTG:
+		break;
+	}
 }
 
-int musb_platform_resume(struct musb *musb);
-
 int __init musb_platform_init(struct musb *musb)
 {
+	struct otg_transceiver *xceiv = otg_get_transceiver();
+
 #if defined(CONFIG_ARCH_OMAP2430)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
 	/* get the clock */
@@ -215,7 +222,7 @@ int __init musb_platform_init(struct musb *musb)
 	if(IS_ERR(musb->clock))
 		return PTR_ERR(musb->clock);
 
-	musb->xceiv.set_suspend = omap_set_suspend;
+	musb->xceiv = *xceiv;
 	musb_platform_resume(musb);
 
 	OTG_INTERFSEL_REG |= ULPI_12PIN;
diff --git a/drivers/usb/musb/omap2430.h b/drivers/usb/musb/omap2430.h
index e89d7bd..d036382 100644
--- a/drivers/usb/musb/omap2430.h
+++ b/drivers/usb/musb/omap2430.h
@@ -14,14 +14,6 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/usb.h>
 
-#if defined(CONFIG_TWL4030_USB_HS_ULPI)
-extern void twl4030_phy_suspend(int controller_off);
-extern void twl4030_phy_resume(void);
-#else
-#define twl4030_phy_suspend(x)		do {} while (0)
-#define twl4030_phy_resume()		do {} while (0)
-#endif
-
 /*
  * OMAP2430-specific definitions
  */
-- 
1.5.5.rc0.16.g02b00

