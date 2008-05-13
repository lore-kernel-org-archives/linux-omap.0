From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC PATCH 5/5] USB: MUSB: We already know the default timeout
Date: Tue, 13 May 2008 15:29:56 +0300
Message-ID: <1210681796-1984-6-git-send-email-felipe.balbi@nokia.com>
References: <1210681796-1984-1-git-send-email-felipe.balbi@nokia.com>
 <1210681796-1984-2-git-send-email-felipe.balbi@nokia.com>
 <1210681796-1984-3-git-send-email-felipe.balbi@nokia.com>
 <1210681796-1984-4-git-send-email-felipe.balbi@nokia.com>
 <1210681796-1984-5-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:35355 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbYEMMbR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 08:31:17 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DCVEG7029125
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 07:31:15 -0500
In-Reply-To: <1210681796-1984-5-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ext Felipe Balbi <felipe.balbi@nokia.com>

From: ext Felipe Balbi <felipe.balbi@nokia.com>

Default idle timeout is set on platform_init, not need
to report it anymore.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c |   30 ++----------------------------
 1 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 5b58d18..c407607 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1696,45 +1696,19 @@ musb_mode_store(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR(mode, 0644, musb_mode_show, musb_mode_store);
 
 static ssize_t
-musb_vbus_store(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t n)
-{
-	struct musb	*musb = dev_to_musb(dev);
-	unsigned long	flags;
-	unsigned long	val;
-
-	if (sscanf(buf, "%lu", &val) < 1) {
-		printk(KERN_ERR "Invalid VBUS timeout ms value\n");
-		return -EINVAL;
-	}
-
-	spin_lock_irqsave(&musb->lock, flags);
-	musb->a_wait_bcon = val;
-	if (musb->xceiv.state == OTG_STATE_A_WAIT_BCON)
-		musb->is_active = 0;
-	musb_platform_try_idle(musb, jiffies + msecs_to_jiffies(val));
-	spin_unlock_irqrestore(&musb->lock, flags);
-
-	return n;
-}
-
-static ssize_t
 musb_vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct musb	*musb = dev_to_musb(dev);
 	unsigned long	flags;
-	unsigned long	val;
 	int		vbus;
 
 	spin_lock_irqsave(&musb->lock, flags);
-	val = musb->a_wait_bcon;
 	vbus = musb_platform_get_vbus_status(musb);
 	spin_unlock_irqrestore(&musb->lock, flags);
 
-	return sprintf(buf, "Vbus %s, timeout %lu\n",
-			vbus ? "on" : "off", val);
+	return sprintf(buf, "Vbus %s\n", vbus ? "on" : "off");
 }
-static DEVICE_ATTR(vbus, 0644, musb_vbus_show, musb_vbus_store);
+static DEVICE_ATTR(vbus, 0444, musb_vbus_show, NULL);
 
 static ssize_t
 musb_session_store(struct device *dev, struct device_attribute *attr,
-- 
1.5.5.1.125.gc697a

