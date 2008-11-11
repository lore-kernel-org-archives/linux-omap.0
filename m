From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 25/59] omap: namespace cleanup to drivers/cbus/tahvo-usb.c
Date: Wed, 12 Nov 2008 00:56:44 +0200
Message-ID: <1226444238-14614-26-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
 <1226444238-14614-25-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40103 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbYKKXBc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:01:32 -0500
In-Reply-To: <1226444238-14614-25-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/tahvo-usb.c |   70 +++++++++++++++++++++++-----------------------
 1 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index d8ad836..8ee066d 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -118,27 +118,27 @@ static irqreturn_t omap_otg_irq(int irq, void *arg)
 	struct tahvo_usb *tu = (struct tahvo_usb *) otg_dev->dev.driver_data;
 	u16 otg_irq;
 
-	otg_irq = omap_readw(OTG_IRQ_SRC);
+	otg_irq = __raw_readw(OTG_IRQ_SRC);
 	if (otg_irq & OPRT_CHG) {
-		omap_writew(OPRT_CHG, OTG_IRQ_SRC);
+		__raw_writew(OPRT_CHG, OTG_IRQ_SRC);
 	} else if (otg_irq & B_SRP_TMROUT) {
-		omap_writew(B_SRP_TMROUT, OTG_IRQ_SRC);
+		__raw_writew(B_SRP_TMROUT, OTG_IRQ_SRC);
 	} else if (otg_irq & B_HNP_FAIL) {
-		omap_writew(B_HNP_FAIL, OTG_IRQ_SRC);
+		__raw_writew(B_HNP_FAIL, OTG_IRQ_SRC);
 	} else if (otg_irq & A_SRP_DETECT) {
-		omap_writew(A_SRP_DETECT, OTG_IRQ_SRC);
+		__raw_writew(A_SRP_DETECT, OTG_IRQ_SRC);
 	} else if (otg_irq & A_REQ_TMROUT) {
-		omap_writew(A_REQ_TMROUT, OTG_IRQ_SRC);
+		__raw_writew(A_REQ_TMROUT, OTG_IRQ_SRC);
 	} else if (otg_irq & A_VBUS_ERR) {
-		omap_writew(A_VBUS_ERR, OTG_IRQ_SRC);
+		__raw_writew(A_VBUS_ERR, OTG_IRQ_SRC);
 	} else if (otg_irq & DRIVER_SWITCH) {
-		if ((!(omap_readl(OTG_CTRL) & OTG_DRIVER_SEL)) &&
+		if ((!(__raw_readl(OTG_CTRL) & OTG_DRIVER_SEL)) &&
 		   tu->otg.host && tu->otg.state == OTG_STATE_A_HOST) {
 			/* role is host */
 			usb_bus_start_enum(tu->otg.host,
 					   tu->otg.host->otg_port);
 		}
-		omap_writew(DRIVER_SWITCH, OTG_IRQ_SRC);
+		__raw_writew(DRIVER_SWITCH, OTG_IRQ_SRC);
 	} else
 		return IRQ_NONE;
 
@@ -157,13 +157,13 @@ static int omap_otg_init(void)
 	}
 #endif
 
-	l = omap_readl(OTG_SYSCON_1);
+	l = __raw_readl(OTG_SYSCON_1);
 	l &= ~OTG_IDLE_EN;
-	omap_writel(l, OTG_SYSCON_1);
+	__raw_writel(l, OTG_SYSCON_1);
 	udelay(100);
 
 	/* some of these values are board-specific... */
-	l = omap_readl(OTG_SYSCON_2);
+	l = __raw_readl(OTG_SYSCON_2);
 	l |= OTG_EN
 		/* for B-device: */
 		| SRP_GPDATA		/* 9msec Bdev D+ pulse */
@@ -173,15 +173,15 @@ static int omap_otg_init(void)
 		| (0 << 20)		/* 200ms nominal A_WAIT_VRISE timer */
 		| SRP_DPW		/* detect 167+ns SRP pulses */
 		| SRP_DATA | SRP_VBUS;	/* accept both kinds of SRP pulse */
-	omap_writel(l, OTG_SYSCON_2);
+	__raw_writel(l, OTG_SYSCON_2);
 
-	omap_writew(DRIVER_SWITCH | OPRT_CHG
+	__raw_writew(DRIVER_SWITCH | OPRT_CHG
 			| B_SRP_TMROUT | B_HNP_FAIL
 				  | A_VBUS_ERR | A_SRP_DETECT | A_REQ_TMROUT,
 					OTG_IRQ_EN);
-	l = omap_readl(OTG_SYSCON_2);
+	l = __raw_readl(OTG_SYSCON_2);
 	l |= OTG_EN;
-	omap_writel(l, OTG_SYSCON_2);
+	__raw_writel(l, OTG_SYSCON_2);
 
 	return 0;
 }
@@ -291,10 +291,10 @@ static void check_vbus_state(struct tahvo_usb *tu)
 				usb_gadget_vbus_connect(tu->otg.gadget);
 			/* Set B-session valid and not B-sessio ended to indicate
 			 * Vbus to be ok. */
-			l = omap_readl(OTG_CTRL);
+			l = __raw_readl(OTG_CTRL);
 			l &= ~OTG_BSESSEND;
 			l |= OTG_BSESSVLD;
-			omap_writel(l, OTG_CTRL);
+			__raw_writel(l, OTG_CTRL);
 
 			tu->otg.state = OTG_STATE_B_PERIPHERAL;
 			break;
@@ -338,10 +338,10 @@ static void tahvo_usb_become_host(struct tahvo_usb *tu)
 	 * also mark the A-session is always valid */
 	omap_otg_init();
 
-	l = omap_readl(OTG_CTRL);
+	l = __raw_readl(OTG_CTRL);
 	l &= ~(OTG_CTRL_XCVR_MASK | OTG_CTRL_SYS_MASK);
 	l |= OTG_ASESSVLD;
-	omap_writel(l, OTG_CTRL);
+	__raw_writel(l, OTG_CTRL);
 
 	/* Power up the transceiver in USB host mode */
 	tahvo_write_reg(TAHVO_REG_USBR, USBR_REGOUT | USBR_NSUSPEND |
@@ -365,10 +365,10 @@ static void tahvo_usb_become_peripheral(struct tahvo_usb *tu)
 	 * and enable ID to mark peripheral mode and
 	 * BSESSEND to mark no Vbus */
 	omap_otg_init();
-	l = omap_readl(OTG_CTRL);
+	l = __raw_readl(OTG_CTRL);
 	l &= ~(OTG_CTRL_XCVR_MASK | OTG_CTRL_SYS_MASK | OTG_BSESSVLD);
 	l |= OTG_ID | OTG_BSESSEND;
-	omap_writel(l, OTG_CTRL);
+	__raw_writel(l, OTG_CTRL);
 
 	/* Power up transceiver and set it in USB perhiperal mode */
 	tahvo_write_reg(TAHVO_REG_USBR, USBR_SLAVE_CONTROL | USBR_REGOUT | USBR_NSUSPEND | USBR_SLAVE_SW);
@@ -381,10 +381,10 @@ static void tahvo_usb_stop_peripheral(struct tahvo_usb *tu)
 {
 	u32 l;
 
-	l = omap_readl(OTG_CTRL);
+	l = __raw_readl(OTG_CTRL);
 	l &= ~OTG_BSESSVLD;
 	l |= OTG_BSESSEND;
-	omap_writel(l, OTG_CTRL);
+	__raw_writel(l, OTG_CTRL);
 
 	if (tu->otg.gadget)
 		usb_gadget_vbus_disconnect(tu->otg.gadget);
@@ -408,19 +408,19 @@ static void tahvo_usb_power_off(struct tahvo_usb *tu)
 		id = OTG_ID;
 	else
 		id = 0;
-	l = omap_readl(OTG_CTRL);
+	l = __raw_readl(OTG_CTRL);
 	l &= ~(OTG_CTRL_XCVR_MASK | OTG_CTRL_SYS_MASK | OTG_BSESSVLD);
 	l |= id | OTG_BSESSEND;
-	omap_writel(l, OTG_CTRL);
-	omap_writew(0, OTG_IRQ_EN);
+	__raw_writel(l, OTG_CTRL);
+	__raw_writew(0, OTG_IRQ_EN);
 
-	l = omap_readl(OTG_SYSCON_2);
+	l = __raw_readl(OTG_SYSCON_2);
 	l &= ~OTG_EN;
-	omap_writel(l, OTG_SYSCON_2);
+	__raw_writel(l, OTG_SYSCON_2);
 
-	l = omap_readl(OTG_SYSCON_1);
+	l = __raw_readl(OTG_SYSCON_1);
 	l |= OTG_IDLE_EN;
-	omap_writel(l, OTG_SYSCON_1);
+	__raw_writel(l, OTG_SYSCON_1);
 
 	/* Power off transceiver */
 	tahvo_write_reg(TAHVO_REG_USBR, 0);
@@ -467,13 +467,13 @@ static int tahvo_usb_start_srp(struct otg_transceiver *dev)
 	if (!dev || tu->otg.state != OTG_STATE_B_IDLE)
 		return -ENODEV;
 
-	otg_ctrl = omap_readl(OTG_CTRL);
+	otg_ctrl = __raw_readl(OTG_CTRL);
 	if (!(otg_ctrl & OTG_BSESSEND))
 		return -EINVAL;
 
 	otg_ctrl |= OTG_B_BUSREQ;
 	otg_ctrl &= ~OTG_A_BUSREQ & OTG_CTRL_SYS_MASK;
-	omap_writel(otg_ctrl, OTG_CTRL);
+	__raw_writel(otg_ctrl, OTG_CTRL);
 	tu->otg.state = OTG_STATE_B_SRP_INIT;
 
 	return 0;
@@ -512,9 +512,9 @@ static int tahvo_usb_set_host(struct otg_transceiver *otg, struct usb_bus *host)
 		return 0;
 	}
 
-	l = omap_readl(OTG_SYSCON_1);
+	l = __raw_readl(OTG_SYSCON_1);
 	l &= ~(OTG_IDLE_EN | HST_IDLE_EN | DEV_IDLE_EN);
-	omap_writel(l, OTG_SYSCON_1);
+	__raw_writel(l, OTG_SYSCON_1);
 
 	if (TAHVO_MODE(tu) == TAHVO_MODE_HOST) {
 		tu->otg.host = NULL;
-- 
1.6.0.2.307.gc427

