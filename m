From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 5/5] usb: musb: dsps: indentation and whitespace fixes
Date: Mon, 25 Nov 2013 20:39:53 +0100
Message-ID: <1385408393-19707-6-git-send-email-zonque@gmail.com>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:49082 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab3KYTkJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 14:40:09 -0500
In-Reply-To: <1385408393-19707-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, Daniel Mack <zonque@gmail.com>

Just a cosmetic thing, no functional change.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/usb/musb/musb_dsps.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 361ddf8..b27c072 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -131,9 +131,9 @@ struct dsps_context {
 struct dsps_glue {
 	struct device *dev;
 	struct platform_device *musb;	/* child musb pdev */
-	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
+	const struct dsps_musb_wrapper *wrp;	/* wrapper register offsets */
 	struct timer_list timer;	/* otg_workaround timer */
-	unsigned long last_timer;    /* last timer data for each instance */
+	unsigned long last_timer;	/* last timer data for each instance */
 
 	struct dsps_context context;
 };
@@ -213,7 +213,7 @@ static void dsps_musb_disable(struct musb *musb)
 
 	dsps_writel(reg_base, wrp->coreintr_clear, wrp->usb_bitmap);
 	dsps_writel(reg_base, wrp->epintr_clear,
-			 wrp->txep_bitmap | wrp->rxep_bitmap);
+		    wrp->txep_bitmap | wrp->rxep_bitmap);
 	dsps_writeb(musb->mregs, MUSB_DEVCTL, 0);
 }
 
@@ -234,7 +234,7 @@ static void otg_timer(unsigned long _musb)
 	 */
 	devctl = dsps_readb(mregs, MUSB_DEVCTL);
 	dev_dbg(musb->controller, "Poll devctl %02x (%s)\n", devctl,
-				usb_otg_state_string(musb->xceiv->state));
+		usb_otg_state_string(musb->xceiv->state));
 
 	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv->state) {
@@ -298,7 +298,7 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 		dsps_writel(reg_base, wrp->coreintr_status, usbintr);
 
 	dev_dbg(musb->controller, "usbintr (%x) epintr(%x)\n",
-			usbintr, epintr);
+		usbintr, epintr);
 	/*
 	 * DRVVBUS IRQs are the only proxy we have (a very poor one!) for
 	 * DSPS IP's missing ID change IRQ.  We need an ID change IRQ to
@@ -348,10 +348,9 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 
 		/* NOTE: this must complete power-on within 100 ms. */
 		dev_dbg(musb->controller, "VBUS %s (%s)%s, devctl %02x\n",
-				drvvbus ? "on" : "off",
-				usb_otg_state_string(musb->xceiv->state),
-				err ? " ERROR" : "",
-				devctl);
+			drvvbus ? "on" : "off",
+			usb_otg_state_string(musb->xceiv->state),
+			err ? " ERROR" : "", devctl);
 		ret = IRQ_HANDLED;
 	}
 
@@ -692,9 +691,9 @@ static SIMPLE_DEV_PM_OPS(dsps_pm_ops, dsps_suspend, dsps_resume);
 
 static struct platform_driver dsps_usbss_driver = {
 	.probe		= dsps_probe,
-	.remove         = dsps_remove,
-	.driver         = {
-		.name   = "musb-dsps",
+	.remove		= dsps_remove,
+	.driver		= {
+		.name	= "musb-dsps",
 		.pm	= &dsps_pm_ops,
 		.of_match_table	= musb_dsps_of_match,
 	},
-- 
1.8.4.2

