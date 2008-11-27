From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc6-omap-git 2/2] twl4030-usb: get rid of OMAP1 OTG hooks
Date: Wed, 26 Nov 2008 16:44:47 -0800
Message-ID: <200811261644.47147.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:28491 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752317AbYK0Ao5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2008 19:44:57 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Remove incomplete/broken support for OMAP1 OTG controller.
Update the otg.state field in some more code paths.
Let IRQ logic handle PHY suspend/resume.
Fix an unlikely memory leak.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/i2c/chips/twl4030-usb.c |   75 ++++++++------------------------------
 1 file changed, 17 insertions(+), 58 deletions(-)

--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -34,7 +34,7 @@
 #include <linux/delay.h>
 #include <linux/usb/otg.h>
 #include <linux/i2c/twl4030.h>
-#include <mach/usb.h>
+
 
 /* Register defines */
 
@@ -234,19 +234,6 @@
 #define GPIO_USB_4PIN_ULPI_2430C	(3 << 0)
 
 
-/* bits in OTG_CTRL */
-#define	OTG_XCEIV_OUTPUTS \
-	(OTG_ASESSVLD|OTG_BSESSEND|OTG_BSESSVLD|OTG_VBUSVLD|OTG_ID)
-#define	OTG_XCEIV_INPUTS \
-	(OTG_PULLDOWN|OTG_PULLUP|OTG_DRV_VBUS|OTG_PD_VBUS|OTG_PU_VBUS|OTG_PU_ID)
-#define	OTG_CTRL_BITS \
-	(OTG_A_BUSREQ|OTG_A_SETB_HNPEN|OTG_B_BUSREQ|OTG_B_HNPEN|OTG_BUSDROP)
-	/* and OTG_PULLUP is sometimes written */
-
-#define	OTG_CTRL_MASK	(OTG_DRIVER_SEL| \
-	OTG_XCEIV_OUTPUTS|OTG_XCEIV_INPUTS| \
-	OTG_CTRL_BITS)
-
 
 enum linkstat {
 	USB_LINK_UNKNOWN = 0,
@@ -371,6 +358,10 @@ static enum linkstat twl4030_usb_linksta
 	dev_dbg(twl->dev, "HW_CONDITIONS 0x%02x/%d; link %d\n",
 			status, status, linkstat);
 
+	/* REVISIT this assumes host and peripheral controllers
+	 * are registered, and that both are active...
+	 */
+
 	spin_lock_irq(&twl->lock);
 	twl->linkstat = linkstat;
 	if (linkstat == USB_LINK_ID) {
@@ -397,13 +388,12 @@ static void twl4030_usb_set_mode(struct 
 					FUNC_CTRL_XCVRSELECT_MASK |
 					FUNC_CTRL_OPMODE_MASK);
 		break;
-/*
-	case T2_USB_MODE_CEA2011_3PIN:
-		twl4030_cea2011_3_pin_FS_setup(twl);
+	case -1:
+		/* FIXME: power on defaults */
 		break;
-*/
 	default:
-		/* FIXME: power on defaults */
+		dev_err(twl->dev, "unsupported T2 transceiver mode %d\n",
+				mode);
 		break;
 	};
 }
@@ -577,30 +567,14 @@ static int twl4030_set_peripheral(struct
 		struct usb_gadget *gadget)
 {
 	struct twl4030_usb *twl;
-	u32 l;
 
 	if (!x)
 		return -ENODEV;
 
 	twl = xceiv_to_twl(x);
-
-	if (!gadget) {
-		omap_writew(0, OTG_IRQ_EN);
-		twl4030_phy_suspend(twl, 1);
-		twl->otg.gadget = NULL;
-
-		return -ENODEV;
-	}
-
 	twl->otg.gadget = gadget;
-	twl4030_phy_resume(twl);
-
-	l = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
-	l &= ~(OTG_XCEIV_OUTPUTS|OTG_CTRL_BITS);
-	l |= OTG_ID;
-	omap_writel(l, OTG_CTRL);
-
-	twl->otg.state = OTG_STATE_B_IDLE;
+	if (!gadget)
+		twl->otg.state = OTG_STATE_UNDEFINED;
 
 	return 0;
 }
@@ -613,24 +587,9 @@ static int twl4030_set_host(struct otg_t
 		return -ENODEV;
 
 	twl = xceiv_to_twl(x);
-
-	if (!host) {
-		omap_writew(0, OTG_IRQ_EN);
-		twl4030_phy_suspend(twl, 1);
-		twl->otg.host = NULL;
-
-		return -ENODEV;
-	}
-
 	twl->otg.host = host;
-	twl4030_phy_resume(twl);
-
-	twl4030_usb_set_bits(twl, TWL4030_OTG_CTRL,
-			TWL4030_OTG_CTRL_DMPULLDOWN
-				| TWL4030_OTG_CTRL_DPPULLDOWN);
-
-	twl4030_usb_set_bits(twl, FUNC_CTRL, FUNC_CTRL_SUSPENDM);
-	twl4030_usb_set_bits(twl, TWL4030_OTG_CTRL, TWL4030_OTG_CTRL_DRVVBUS);
+	if (!host)
+		twl->otg.state = OTG_STATE_UNDEFINED;
 
 	return 0;
 }
@@ -641,15 +600,15 @@ static int __init twl4030_usb_probe(stru
 	struct twl4030_usb	*twl;
 	int			status;
 
-	twl = kzalloc(sizeof *twl, GFP_KERNEL);
-	if (!twl)
-		return -ENOMEM;
-
 	if (!pdata) {
 		dev_dbg(&pdev->dev, "platform_data not available\n");
 		return -EINVAL;
 	}
 
+	twl = kzalloc(sizeof *twl, GFP_KERNEL);
+	if (!twl)
+		return -ENOMEM;
+
 	twl->dev		= &pdev->dev;
 	twl->irq		= platform_get_irq(pdev, 0);
 	twl->otg.dev		= twl->dev;
