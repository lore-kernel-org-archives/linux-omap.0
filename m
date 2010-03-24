From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.34-rc2+ 10/11] musb_core: don't call musb_platform_exit() twice
Date: Wed, 24 Mar 2010 13:47:58 +0200
Message-ID: <1269431279-22438-11-git-send-email-felipe.balbi@nokia.com>
References: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45743 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755855Ab0CXLso (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 07:48:44 -0400
In-Reply-To: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

musb_platform_exit() is called twice from musb_init_controller() iff controller
initialization fails. Move the call (and the DevCtl register writes surrounding
it) from musb_free() to musb_remove().

Fix misplaced and now incorrect 'goto's in musb_init_controller().

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 827b813..90ac17b 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1848,10 +1848,6 @@ static void musb_free(struct musb *musb)
 	put_device(musb->xceiv->dev);
 #endif
 
-	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
-	musb_platform_exit(musb);
-	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
-
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	usb_put_hcd(musb_to_hcd(musb));
 #else
@@ -2029,8 +2025,6 @@ bad_config:
 		musb->xceiv->state = OTG_STATE_A_IDLE;
 
 		status = usb_add_hcd(musb_to_hcd(musb), -1, 0);
-		if (status)
-			goto fail;
 
 		DBG(1, "%s mode, status %d, devctl %02x %c\n",
 			"HOST", status,
@@ -2045,8 +2039,6 @@ bad_config:
 		musb->xceiv->state = OTG_STATE_B_IDLE;
 
 		status = musb_gadget_setup(musb);
-		if (status)
-			goto fail;
 
 		DBG(1, "%s mode, status %d, dev%02x\n",
 			is_otg_enabled(musb) ? "OTG" : "PERIPHERAL",
@@ -2054,6 +2046,8 @@ bad_config:
 			musb_readb(musb->mregs, MUSB_DEVCTL));
 
 	}
+	if (status < 0)
+		goto fail2;
 
 	status = musb_init_debugfs(musb);
 	if (status < 0)
@@ -2061,9 +2055,9 @@ bad_config:
 
 #ifdef CONFIG_SYSFS
 	status = sysfs_create_group(&musb->controller->kobj, &musb_attr_group);
-#endif
 	if (status)
 		goto fail2;
+#endif
 
 	dev_info(dev, "USB %s mode controller at %p using %s, IRQ %d\n",
 			({char *s;
@@ -2126,7 +2120,6 @@ static int __init musb_probe(struct platform_device *pdev)
 	/* clobbered by use_dma=n */
 	orig_dma_mask = dev->dma_mask;
 #endif
-
 	status = musb_init_controller(dev, irq, base);
 	if (status < 0)
 		iounmap(base);
@@ -2150,6 +2143,10 @@ static int __exit musb_remove(struct platform_device *pdev)
 	if (musb->board_mode == MUSB_HOST)
 		usb_remove_hcd(musb_to_hcd(musb));
 #endif
+	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
+	musb_platform_exit(musb);
+	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
+
 	musb_free(musb);
 	iounmap(ctrl_base);
 	device_init_wakeup(&pdev->dev, 0);
-- 
1.7.0.rc0.33.g7c3932

