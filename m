From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC PATCH 2/5] USB: MUSB: Change srp sysfs entry to session
Date: Tue, 13 May 2008 15:29:53 +0300
Message-ID: <1210681796-1984-3-git-send-email-felipe.balbi@nokia.com>
References: <1210681796-1984-1-git-send-email-felipe.balbi@nokia.com>
 <1210681796-1984-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53993 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485AbYEMMcJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 08:32:09 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DCVgFo016204
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 15:32:07 +0300
In-Reply-To: <1210681796-1984-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ext Felipe Balbi <felipe.balbi@nokia.com>

From: ext Felipe Balbi <felipe.balbi@nokia.com>

The name session is more generic as this interface could
be used also by host side to turn vbus on.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 019898a..5b58d18 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1736,32 +1736,36 @@ musb_vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR(vbus, 0644, musb_vbus_show, musb_vbus_store);
 
-#ifdef CONFIG_USB_GADGET_MUSB_HDRC
-
-/* Gadget drivers can't know that a host is connected so they might want
- * to start SRP, but users can.  This allows userspace to trigger SRP.
- */
 static ssize_t
-musb_srp_store(struct device *dev, struct device_attribute *attr,
+musb_session_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t n)
 {
 	struct musb	*musb = dev_to_musb(dev);
-	unsigned short	srp;
+	unsigned short	session;
 
-	if (sscanf(buf, "%hu", &srp) != 1
-			|| (srp != 1)) {
-		printk(KERN_ERR "SRP: Value must be 1\n");
+	if (sscanf(buf, "%hu", &session) != 1
+			|| (session != 1)) {
+		printk(KERN_ERR "Value must be 1\n");
 		return -EINVAL;
 	}
 
-	if (srp == 1)
-		musb_g_wakeup(musb);
+	if (session == 1) {
+		switch (musb->xceiv.state) {
+		case OTG_STATE_B_IDLE:
+			musb_g_wakeup(musb);
+			break;
+		case OTG_STATE_A_IDLE:
+			musb_set_vbus(musb, 1);
+			break;
+		default:
+			printk(KERN_INFO "Vbus might be on already\n");
+			break;
+		}
+	}
 
 	return n;
 }
-static DEVICE_ATTR(srp, 0644, NULL, musb_srp_store);
-
-#endif /* CONFIG_USB_GADGET_MUSB_HDRC */
+static DEVICE_ATTR(session, 0644, NULL, musb_session_store);
 
 #endif	/* sysfs */
 
@@ -1839,9 +1843,7 @@ static void musb_free(struct musb *musb)
 #ifdef CONFIG_SYSFS
 	device_remove_file(musb->controller, &dev_attr_mode);
 	device_remove_file(musb->controller, &dev_attr_vbus);
-#ifdef CONFIG_USB_MUSB_OTG
-	device_remove_file(musb->controller, &dev_attr_srp);
-#endif
+	device_remove_file(musb->controller, &dev_attr_session);
 #endif
 
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
@@ -2075,9 +2077,7 @@ fail:
 #ifdef CONFIG_SYSFS
 	status = device_create_file(dev, &dev_attr_mode);
 	status = device_create_file(dev, &dev_attr_vbus);
-#ifdef CONFIG_USB_GADGET_MUSB_HDRC
-	status = device_create_file(dev, &dev_attr_srp);
-#endif /* CONFIG_USB_GADGET_MUSB_HDRC */
+	status = device_create_file(dev, &dev_attr_session);
 	status = 0;
 #endif
 
-- 
1.5.5.1.125.gc697a

