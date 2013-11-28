From: anaumann@ultratronik.de
Subject: [PATCH V2] usb: musb: Fix unstable init of OTG_INTERFSEL.
Date: Thu, 28 Nov 2013 08:51:45 +0100
Message-ID: <1385625105-7348-1-git-send-email-anaumann@ultratronik.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from dd5612.kasserver.com ([85.13.130.143]:36558 "EHLO
	dd5612.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab3K1Hwp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Nov 2013 02:52:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Naumann <anaumann@ultratronik.de>

From: Andreas Naumann <anaumann@ultratronik.de>

This is a hard to reproduce problem which leads to non-functional
USB-OTG port in 0.1%-1% of all boots. Tracked it down to commit
e25bec160158abe86c276d7d206264afc3646281, which introduces save/restore
of OTG_INTERFSEL over suspend.
Since the resume function is also called early in driver init, it uses a
non-initialized value (which is 0 and a non-supported setting in DM37xx
for INTERFSEL). Shortly after the correct value is set. Apparently this
works most time, but not always.

The fix is to initialize the value, BEFORE being written in the resume
function.


Signed-off-by: Andreas Naumann <anaumann@ultratronik.de>
---
 drivers/usb/musb/omap2430.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 4315d35..783547c 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -337,7 +337,6 @@ static irqreturn_t omap2430_musb_interrupt(int irq, void *__hci)
 
 static int omap2430_musb_init(struct musb *musb)
 {
-	u32 l;
 	int status = 0;
 	struct device *dev = musb->controller;
 	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
@@ -366,23 +365,24 @@ static int omap2430_musb_init(struct musb *musb)
 
 	musb->isr = omap2430_musb_interrupt;
 
+	musb->context.otg_interfsel = musb_readl(musb->mregs, OTG_INTERFSEL);
+
+	if (data->interface_type == MUSB_INTERFACE_UTMI) {
+		/* OMAP4 uses Internal PHY GS70 which uses UTMI interface */
+		musb->context.otg_interfsel &= ~ULPI_12PIN;  /* Disable ULPI */
+		musb->context.otg_interfsel |= UTMI_8BIT;    /* Enable UTMI  */
+	} else {
+		musb->context.otg_interfsel |= ULPI_12PIN;
+	}
+
 	status = pm_runtime_get_sync(dev);
 	if (status < 0) {
 		dev_err(dev, "pm_runtime_get_sync FAILED %d\n", status);
 		goto err1;
 	}
 
-	l = musb_readl(musb->mregs, OTG_INTERFSEL);
-
-	if (data->interface_type == MUSB_INTERFACE_UTMI) {
-		/* OMAP4 uses Internal PHY GS70 which uses UTMI interface */
-		l &= ~ULPI_12PIN;       /* Disable ULPI */
-		l |= UTMI_8BIT;         /* Enable UTMI  */
-	} else {
-		l |= ULPI_12PIN;
-	}
 
-	musb_writel(musb->mregs, OTG_INTERFSEL, l);
+	musb_writel(musb->mregs, OTG_INTERFSEL, musb->context.otg_interfsel);
 
 	pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
 			"sysstatus 0x%x, intrfsel 0x%x, simenable  0x%x\n",
-- 
1.8.4.1

