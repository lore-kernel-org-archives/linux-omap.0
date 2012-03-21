From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH v2] usb: musb: wake the device before ulpi transfers
Date: Wed, 21 Mar 2012 16:35:52 +0200
Message-ID: <1332340552-9270-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34410 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030742Ab2CUOf5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 10:35:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>

musb can be suspended at the time some other driver wants to do ulpi
transfers using usb_phy_io_* functions, and that can cause data abort,
as it happened with isp1704_charger:
http://article.gmane.org/gmane.linux.kernel/1226122

Add pm_runtime to ulpi functions to rectify this. This also adds io_dev
to usb_phy so that pm_runtime_* functions can be used.

Cc: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 v2: refreshed for current tree

 drivers/usb/musb/musb_core.c |   31 +++++++++++++++++++++++++------
 include/linux/usb/otg.h      |    1 +
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 2392146..66aaccf 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -137,6 +137,9 @@ static int musb_ulpi_read(struct usb_phy *phy, u32 offset)
 	int	i = 0;
 	u8	r;
 	u8	power;
+	int	ret;
+
+	pm_runtime_get_sync(phy->io_dev);
 
 	/* Make sure the transceiver is not in low power mode */
 	power = musb_readb(addr, MUSB_POWER);
@@ -154,15 +157,22 @@ static int musb_ulpi_read(struct usb_phy *phy, u32 offset)
 	while (!(musb_readb(addr, MUSB_ULPI_REG_CONTROL)
 				& MUSB_ULPI_REG_CMPLT)) {
 		i++;
-		if (i == 10000)
-			return -ETIMEDOUT;
+		if (i == 10000) {
+			ret = -ETIMEDOUT;
+			goto out;
+		}
 
 	}
 	r = musb_readb(addr, MUSB_ULPI_REG_CONTROL);
 	r &= ~MUSB_ULPI_REG_CMPLT;
 	musb_writeb(addr, MUSB_ULPI_REG_CONTROL, r);
 
-	return musb_readb(addr, MUSB_ULPI_REG_DATA);
+	ret = musb_readb(addr, MUSB_ULPI_REG_DATA);
+
+out:
+	pm_runtime_put(phy->io_dev);
+
+	return ret;
 }
 
 static int musb_ulpi_write(struct usb_phy *phy, u32 offset, u32 data)
@@ -171,6 +181,9 @@ static int musb_ulpi_write(struct usb_phy *phy, u32 offset, u32 data)
 	int	i = 0;
 	u8	r = 0;
 	u8	power;
+	int	ret = 0;
+
+	pm_runtime_get_sync(phy->io_dev);
 
 	/* Make sure the transceiver is not in low power mode */
 	power = musb_readb(addr, MUSB_POWER);
@@ -184,15 +197,20 @@ static int musb_ulpi_write(struct usb_phy *phy, u32 offset, u32 data)
 	while (!(musb_readb(addr, MUSB_ULPI_REG_CONTROL)
 				& MUSB_ULPI_REG_CMPLT)) {
 		i++;
-		if (i == 10000)
-			return -ETIMEDOUT;
+		if (i == 10000) {
+			ret = -ETIMEDOUT;
+			goto out;
+		}
 	}
 
 	r = musb_readb(addr, MUSB_ULPI_REG_CONTROL);
 	r &= ~MUSB_ULPI_REG_CMPLT;
 	musb_writeb(addr, MUSB_ULPI_REG_CONTROL, r);
 
-	return 0;
+out:
+	pm_runtime_put(phy->io_dev);
+
+	return ret;
 }
 #else
 #define musb_ulpi_read		NULL
@@ -1908,6 +1926,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	}
 
 	if (!musb->xceiv->io_ops) {
+		musb->xceiv->io_dev = musb->controller;
 		musb->xceiv->io_priv = musb->mregs;
 		musb->xceiv->io_ops = &musb_ulpi_access;
 	}
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index f67810f..38ab3f4 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -94,6 +94,7 @@ struct usb_phy {
 
 	struct usb_otg		*otg;
 
+	struct device		*io_dev;
 	struct usb_phy_io_ops	*io_ops;
 	void __iomem		*io_priv;
 
-- 
1.7.0.4

