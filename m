From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 03/16] USB: musb: move to sysfs_groups
Date: Tue, 19 Jan 2010 15:14:02 +0200
Message-ID: <1263906855-28341-4-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54486 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab0ASNOx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:14:53 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

it's easier to keep up and add more sysfs entries
as necessary.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/musb/musb_core.c |   33 +++++++++++++++------------------
 1 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 91c31f2..52295bc 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1759,6 +1759,19 @@ static DEVICE_ATTR(srp, 0644, NULL, musb_srp_store);
 
 #endif /* CONFIG_USB_GADGET_MUSB_HDRC */
 
+static struct attribute *musb_attributes[] = {
+	&dev_attr_mode.attr,
+	&dev_attr_vbus.attr,
+#ifdef CONFIG_USB_GADGET_MUSB_HDRC
+	&dev_attr_srp.attr,
+#endif
+	NULL
+};
+
+static const struct attribute_group musb_attr_group = {
+	.attrs = musb_attributes,
+};
+
 #endif	/* sysfs */
 
 /* Only used to provide driver mode change events */
@@ -1833,11 +1846,7 @@ static void musb_free(struct musb *musb)
 	 */
 
 #ifdef CONFIG_SYSFS
-	device_remove_file(musb->controller, &dev_attr_mode);
-	device_remove_file(musb->controller, &dev_attr_vbus);
-#ifdef CONFIG_USB_GADGET_MUSB_HDRC
-	device_remove_file(musb->controller, &dev_attr_srp);
-#endif
+	sysfs_remove_group(&musb->controller->kobj, &musb_attr_group);
 #endif
 
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
@@ -2079,12 +2088,7 @@ bad_config:
 	}
 
 #ifdef CONFIG_SYSFS
-	status = device_create_file(dev, &dev_attr_mode);
-	status = device_create_file(dev, &dev_attr_vbus);
-#ifdef CONFIG_USB_GADGET_MUSB_HDRC
-	status = device_create_file(dev, &dev_attr_srp);
-#endif /* CONFIG_USB_GADGET_MUSB_HDRC */
-	status = 0;
+	status = sysfs_create_group(&musb->controller->kobj, &musb_attr_group);
 #endif
 	if (status)
 		goto fail2;
@@ -2092,13 +2096,6 @@ bad_config:
 	return 0;
 
 fail2:
-#ifdef CONFIG_SYSFS
-	device_remove_file(musb->controller, &dev_attr_mode);
-	device_remove_file(musb->controller, &dev_attr_vbus);
-#ifdef CONFIG_USB_GADGET_MUSB_HDRC
-	device_remove_file(musb->controller, &dev_attr_srp);
-#endif
-#endif
 	musb_platform_exit(musb);
 fail:
 	dev_err(musb->controller,
-- 
1.6.6.rc0

