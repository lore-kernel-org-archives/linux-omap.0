From: Felipe Balbi <balbi@ti.com>
Subject: [patch v2.6.39 1/3] usb: musb: do not error out if Kconfig doesn't match board mode
Date: Thu, 17 Feb 2011 13:30:19 +0200
Message-ID: <1297942221-22995-2-git-send-email-balbi@ti.com>
References: <1297942221-22995-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:56085 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755618Ab1BQLac (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 06:30:32 -0500
In-Reply-To: <1297942221-22995-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Anand Gadiyar <gadiyar@ti.com>, Hema Kalliguddi <hemahk@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

During development, even though board is wired
to e.g. OTG, we might want to compile host-only
or peripheral-only configurations.

Let's allow that to happen.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/musb_core.c |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 54a8bd1..bc29655 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1949,31 +1949,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		goto fail0;
 	}
 
-	switch (plat->mode) {
-	case MUSB_HOST:
-#ifdef CONFIG_USB_MUSB_HDRC_HCD
-		break;
-#else
-		goto bad_config;
-#endif
-	case MUSB_PERIPHERAL:
-#ifdef CONFIG_USB_GADGET_MUSB_HDRC
-		break;
-#else
-		goto bad_config;
-#endif
-	case MUSB_OTG:
-#ifdef CONFIG_USB_MUSB_OTG
-		break;
-#else
-bad_config:
-#endif
-	default:
-		dev_err(dev, "incompatible Kconfig role setting\n");
-		status = -EINVAL;
-		goto fail0;
-	}
-
 	/* allocate */
 	musb = allocate_instance(dev, plat->config, ctrl);
 	if (!musb) {
-- 
1.7.4.rc2

