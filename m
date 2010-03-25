From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-2.6.34-rc2+ 10/11] musb_core: don't call musb_platform_exit() twice
Date: Thu, 25 Mar 2010 13:14:32 +0200
Message-ID: <1269515673-27980-11-git-send-email-felipe.balbi@nokia.com>
References: <1269515673-27980-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269515673-27980-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>

musb_platform_exit() is called twice from musb_init_controller() iff controller
initialization fails. Move the call (and the DevCtl register writes surrounding
it) from musb_free() to musb_remove().

Fix mispalced and now incorrect 'goto's in musb_init_controller().

Signed-off-by: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 8b68f21..508fd58 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1851,10 +1851,6 @@ static void musb_free(struct musb *musb)
 	put_device(musb->xceiv->dev);
 #endif
 
-	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
-	musb_platform_exit(musb);
-	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
-
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	usb_put_hcd(musb_to_hcd(musb));
 #else
@@ -2032,8 +2028,6 @@ bad_config:
 		musb->xceiv->state = OTG_STATE_A_IDLE;
 
 		status = usb_add_hcd(musb_to_hcd(musb), -1, 0);
-		if (status)
-			goto fail;
 
 		DBG(1, "%s mode, status %d, devctl %02x %c\n",
 			"HOST", status,
@@ -2048,8 +2042,6 @@ bad_config:
 		musb->xceiv->state = OTG_STATE_B_IDLE;
 
 		status = musb_gadget_setup(musb);
-		if (status)
-			goto fail;
 
 		DBG(1, "%s mode, status %d, dev%02x\n",
 			is_otg_enabled(musb) ? "OTG" : "PERIPHERAL",
@@ -2057,12 +2049,14 @@ bad_config:
 			musb_readb(musb->mregs, MUSB_DEVCTL));
 
 	}
+	if (status < 0)
+		goto fail2;
 
 #ifdef CONFIG_SYSFS
 	status = sysfs_create_group(&musb->controller->kobj, &musb_attr_group);
-#endif
 	if (status)
 		goto fail2;
+#endif
 
 	dev_info(dev, "USB %s mode controller at %p using %s, IRQ %d\n",
 			({char *s;
@@ -2125,7 +2119,6 @@ static int __init musb_probe(struct platform_device *pdev)
 	/* clobbered by use_dma=n */
 	orig_dma_mask = dev->dma_mask;
 #endif
