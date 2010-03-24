From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.34-rc2+ 11/11] musb_core: fix musb_init_controller() error cleanup path
Date: Wed, 24 Mar 2010 13:47:59 +0200
Message-ID: <1269431279-22438-12-git-send-email-felipe.balbi@nokia.com>
References: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53850 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889Ab0CXLtB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 07:49:01 -0400
In-Reply-To: <1269431279-22438-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

This function forgets to call usb_remove_hcd() or musb_gadget_cleanup() iff
sysfs_create_group() fails.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

[ felipe.balbi@nokia.com : review the entire error path
	not only when we fail hcd or gadget ]

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c |   50 +++++++++++++++++++++++++++--------------
 1 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 90ac17b..13f36bf 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1875,8 +1875,10 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	 */
 	if (!plat) {
 		dev_dbg(dev, "no platform_data?\n");
-		return -ENODEV;
+		status = -ENODEV;
+		goto fail0;
 	}
+
 	switch (plat->mode) {
 	case MUSB_HOST:
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
@@ -1898,13 +1900,16 @@ bad_config:
 #endif
 	default:
 		dev_err(dev, "incompatible Kconfig role setting\n");
-		return -EINVAL;
+		status = -EINVAL;
+		goto fail0;
 	}
 
 	/* allocate */
 	musb = allocate_instance(dev, plat->config, ctrl);
-	if (!musb)
-		return -ENOMEM;
+	if (!musb) {
+		status = -ENOMEM;
+		goto fail0;
+	}
 
 	spin_lock_init(&musb->lock);
 	musb->board_mode = plat->mode;
@@ -1922,7 +1927,7 @@ bad_config:
 		if (IS_ERR(musb->clock)) {
 			status = PTR_ERR(musb->clock);
 			musb->clock = NULL;
-			goto fail;
+			goto fail1;
 		}
 	}
 
@@ -1941,12 +1946,12 @@ bad_config:
 	 */
 	musb->isr = generic_interrupt;
 	status = musb_platform_init(musb, plat->board_data);
-
 	if (status < 0)
-		goto fail;
+		goto fail2;
+
 	if (!musb->isr) {
 		status = -ENODEV;
-		goto fail2;
+		goto fail3;
 	}
 
 #ifndef CONFIG_MUSB_PIO_ONLY
@@ -1972,7 +1977,7 @@ bad_config:
 			? MUSB_CONTROLLER_MHDRC
 			: MUSB_CONTROLLER_HDRC, musb);
 	if (status < 0)
-		goto fail2;
+		goto fail3;
 
 #ifdef CONFIG_USB_MUSB_OTG
 	setup_timer(&musb->otg_timer, musb_otg_timer_func, (unsigned long) musb);
@@ -1985,7 +1990,7 @@ bad_config:
 	if (request_irq(nIrq, musb->isr, 0, dev_name(dev), musb)) {
 		dev_err(dev, "request_irq %d failed!\n", nIrq);
 		status = -ENODEV;
-		goto fail2;
+		goto fail3;
 	}
 	musb->nIrq = nIrq;
 /* FIXME this handles wakeup irqs wrong */
@@ -2047,7 +2052,7 @@ bad_config:
 
 	}
 	if (status < 0)
-		goto fail2;
+		goto fail4;
 
 	status = musb_init_debugfs(musb);
 	if (status < 0)
@@ -2056,7 +2061,7 @@ bad_config:
 #ifdef CONFIG_SYSFS
 	status = sysfs_create_group(&musb->controller->kobj, &musb_attr_group);
 	if (status)
-		goto fail2;
+		goto fail4;
 #endif
 
 	dev_info(dev, "USB %s mode controller at %p using %s, IRQ %d\n",
@@ -2073,17 +2078,28 @@ bad_config:
 
 	return 0;
 
-fail2:
+fail4:
+	if (!is_otg_enabled(musb) && is_host_enabled(musb))
+		usb_remove_hcd(musb_to_hcd(musb));
+	else
+		musb_gadget_cleanup(musb);
+	device_init_wakeup(dev, 0);
+
+fail3:
 	musb_platform_exit(musb);
-fail:
-	dev_err(musb->controller,
-		"musb_init_controller failed with status %d\n", status);
 
+fail2:
 	if (musb->clock)
 		clk_put(musb->clock);
-	device_init_wakeup(dev, 0);
+
+fail1:
+	dev_err(musb->controller,
+		"musb_init_controller failed with status %d\n", status);
+
 	musb_free(musb);
 
+fail0:
+
 	return status;
 
 }
-- 
1.7.0.rc0.33.g7c3932

