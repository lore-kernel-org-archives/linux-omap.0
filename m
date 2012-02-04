From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] usb: musb: wake the device before ulpi transfers
Date: Sat,  4 Feb 2012 19:43:52 +0200
Message-ID: <1328377432-13563-3-git-send-email-notasas@gmail.com>
References: <1328377432-13563-1-git-send-email-notasas@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1328377432-13563-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

musb can be suspended at the time some other driver wants to do ulpi
transfers using otg_io_* functions, and that can cause data abort,
as it happened with isp1704_charger:
http://article.gmane.org/gmane.linux.kernel/1226122

Add pm_runtime to ulpi functions to rectify this. This also adds io_dev
to otg_transceiver so that pm_runtime can be used.

Cc: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |   31 +++++++++++++++++++++++++------
 include/linux/usb/otg.h      |    1 +
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 19543c9..ca9d74a 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -137,6 +137,9 @@ static int musb_ulpi_read(struct otg_transceiver *otg, u32 offset)
 	int	i = 0;
 	u8	r;
 	u8	power;
+	int	ret;
+
+	pm_runtime_get_sync(otg->io_dev);
 
 	/* Make sure the transceiver is not in low power mode */
 	power = musb_readb(addr, MUSB_POWER);
@@ -154,15 +157,22 @@ static int musb_ulpi_read(struct otg_transceiver *otg, u32 offset)
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
+	pm_runtime_put(otg->io_dev);
+
+	return ret;
 }
 
 static int musb_ulpi_write(struct otg_transceiver *otg,
@@ -172,6 +182,9 @@ static int musb_ulpi_write(struct otg_transceiver *otg,
 	int	i = 0;
 	u8	r = 0;
 	u8	power;
+	int	ret = 0;
+
+	pm_runtime_get_sync(otg->io_dev);
 
 	/* Make sure the transceiver is not in low power mode */
 	power = musb_readb(addr, MUSB_POWER);
@@ -185,15 +198,20 @@ static int musb_ulpi_write(struct otg_transceiver *otg,
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
+	pm_runtime_put(otg->io_dev);
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
index d87f44f..308b699 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -71,6 +71,7 @@ struct otg_transceiver {
 	struct usb_bus		*host;
 	struct usb_gadget	*gadget;
 
+	struct device			*io_dev;
 	struct otg_io_access_ops	*io_ops;
 	void __iomem			*io_priv;
 
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
