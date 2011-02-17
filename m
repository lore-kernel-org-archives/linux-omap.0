From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [patch-v2.6.39 01/12] usb: musb: do not error out if Kconfig doesn't match board mode
Date: Thu, 17 Feb 2011 14:38:38 +0200
Message-ID: <1297946329-9353-2-git-send-email-balbi@ti.com>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297946329-9353-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

During development, even though board is wired
to e.g. OTG, we might want to compile host-only
or peripheral-only configurations.

Let's allow that to happen.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
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
