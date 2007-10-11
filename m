From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/12] musb_hdrc: Remove old sysfs entry cable,
	use mode instead
Date: Thu, 11 Oct 2007 10:05:16 -0700
Message-ID: <11921223283749-git-send-email-tony@atomide.com>
References: <1192122325531-git-send-email-tony@atomide.com>
	<11921223262203-git-send-email-tony@atomide.com>
	<11921223272557-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11921223272557-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Cable was used earlier before OTG support for peripherals, however
it does not really work for OTG. Sysfs entry mode shows the right
OTG mode and should be used instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index f7dc22c..82bf57a 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1660,52 +1660,6 @@ musb_mode_store(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR(mode, 0644, musb_mode_show, musb_mode_store);
 
 static ssize_t
-musb_cable_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct musb *musb = dev_to_musb(dev);
-	char *v1= "", *v2 = "?";
-	unsigned long flags;
-	int vbus;
-
-	spin_lock_irqsave(&musb->lock, flags);
-#if defined(CONFIG_USB_TUSB6010) && !defined(CONFIG_USB_MUSB_OTG)
-	/* REVISIT: connect-A != connect-B ... */
-	vbus = musb_platform_get_vbus_status(musb);
-	if (vbus)
-		v2 = "connected";
-	else
-		v2 = "disconnected";
-#else
-	/* NOTE: board-specific issues, like too-big capacitors keeping
-	 * VBUS high for a long time after power has been removed, can
-	 * cause temporary false indications of a connection.
-	 */
-	vbus = musb_readb(musb->mregs, MUSB_DEVCTL);
-	if (vbus & 0x10) {
-		/* REVISIT retest on real OTG hardware */
-		switch (musb->board_mode) {
-		case MUSB_HOST:
-			v2 = "A";
-			break;
-		case MUSB_PERIPHERAL:
-			v2 = "B";
-			break;
-		case MUSB_OTG:
-			v1 = "Mini-";
-			v2 = (vbus & MUSB_DEVCTL_BDEVICE) ? "B" : "A";
-			break;
-		}
-	} else	/* VBUS level below A-Valid */
-		v2 = "disconnected";
-#endif
-	musb_platform_try_idle(musb, 0);
-	spin_unlock_irqrestore(&musb->lock, flags);
-
-	return sprintf(buf, "%s%s\n", v1, v2);
-}
-static DEVICE_ATTR(cable, S_IRUGO, musb_cable_show, NULL);
-
-static ssize_t
 musb_vbus_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t n)
 {
@@ -1780,7 +1734,6 @@ static void musb_irq_work(struct work_struct *data)
 
 	if (musb->xceiv.state != old_state) {
 		old_state = musb->xceiv.state;
-		sysfs_notify(&musb->controller->kobj, NULL, "cable");
 		sysfs_notify(&musb->controller->kobj, NULL, "mode");
 	}
 }
@@ -1846,7 +1799,6 @@ static void musb_free(struct musb *musb)
 
 #ifdef CONFIG_SYSFS
 	device_remove_file(musb->controller, &dev_attr_mode);
-	device_remove_file(musb->controller, &dev_attr_cable);
 	device_remove_file(musb->controller, &dev_attr_vbus);
 #ifdef CONFIG_USB_MUSB_OTG
 	device_remove_file(musb->controller, &dev_attr_srp);
@@ -2082,7 +2034,6 @@ fail:
 
 #ifdef CONFIG_SYSFS
 	status = device_create_file(dev, &dev_attr_mode);
-	status = device_create_file(dev, &dev_attr_cable);
 	status = device_create_file(dev, &dev_attr_vbus);
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	status = device_create_file(dev, &dev_attr_srp);
-- 
1.5.2.5
