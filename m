From: Felipe Balbi <felipebalbi@users.sourceforge.net>
Subject: [PATCH] Add Sysfs Interface to Control Vbus states
Date: Tue, 29 May 2007 15:02:35 +0300
Message-ID: <1180440173922-git-send-email-felipebalbi@users.sourceforge.net>
References: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401651954-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401662563-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401722783-git-send-email-felipebalbi@users.sourceforge.net>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11804401722783-git-send-email-felipebalbi@users.sourceforge.net>
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

From: Felipe Balbi <felipe.lima@indt.org.br>

	We need to control Vbus in order to save power and
	let us test SRP features.
	This sysfs interface provides an easy way to control
	the Vbus states.

	HowTo use it:
	echo off > /sys/devices/platform/musb_hdrc/vbus
		or
	echo on > /sys/devices/platform/musb_hdrc/vbus

	Later improvements:
	* Check current Vbus state before setting new state.
	* Implement MUSB PM features and shutdown Vbus whenever we're
	  not using the Bus.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---

Index: linux-omap-2.6/drivers/usb/musb/plat_uds.c
===================================================================
--- linux-omap-2.6.orig/drivers/usb/musb/plat_uds.c	2007-05-28 13:18:47.000000000 +0300
+++ linux-omap-2.6/drivers/usb/musb/plat_uds.c	2007-05-28 13:18:52.000000000 +0300
@@ -1579,6 +1579,78 @@
 }
 static DEVICE_ATTR(cable, S_IRUGO, musb_cable_show, NULL);
 
+static ssize_t
+musb_vbus_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t n)
+{
+	struct musb	*musb = dev_to_musb(dev);
+	unsigned long	flags;
+	u8		devctl;
+
+	/* REVISIT the correct way to do it would be checking if we're
+	 * the Standard A device. B devices do not provide Vbus.
+	 */
+	spin_lock_irqsave(&musb->Lock, flags);
+	devctl = musb_readb(musb->pRegs, MGC_O_HDRC_DEVCTL);
+	if (!strncmp(buf, "on", 2)) {
+		u8 power = musb_readb(musb->pRegs, MGC_O_HDRC_POWER);
+
+		musb->xceiv.default_a = 1;
+		devctl |= MGC_M_DEVCTL_SESSION;
+		musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, devctl);
+		musb_set_vbus(musb, 1);
+
+		/* After turning on Vbus we need to generate a reset signal
+		 * on the bus. The following code treats this
+		 */
+		power &= 0xf0;
+		musb_writeb(musb->pRegs, MGC_O_HDRC_POWER,
+				power | MGC_M_POWER_RESET);
+		musb->port1_status |= USB_PORT_STAT_RESET;
+		musb->port1_status &= ~USB_PORT_STAT_ENABLE;
+		musb->rh_timer = jiffies + msecs_to_jiffies(20);
+
+		/* REVISIT after sending the reset signal during 20msecs
+		 * we need to clear the RESET bit in the power register
+		 */
+		if (time_after(jiffies, musb->rh_timer))
+			musb_writeb(musb->pRegs, MGC_O_HDRC_POWER,
+					power & ~MGC_M_POWER_RESET);
+
+	}
+	if (!strncmp(buf, "off", 3)) {
+		devctl |= ~MGC_M_DEVCTL_SESSION;
+		musb_writeb(musb->pRegs, MGC_O_HDRC_DEVCTL, devctl);
+		musb_set_vbus(musb, 0);
+	}
+	/* REVIST when shutting down Vbus we should enter A_IDLE state and not
+	 * B_IDLE. Check tusb_source_power() definition
+	 */
+	spin_unlock_irqrestore(&musb->Lock, flags);
+
+	return n;
+}
+
+static ssize_t
+musb_vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct musb	*musb = dev_to_musb(dev);
+	unsigned long	flags;
+	int		vbus;
+	char		*ret;
+
+	spin_lock_irqsave(&musb->Lock, flags);
+	vbus = musb_platform_get_vbus_status(musb);
+	if (vbus)
+		ret = "Vbus on";
+	else
+		ret = "Vbus off";
+	spin_unlock_irqrestore(&musb->Lock, flags);
+
+	return sprintf(buf, "%s\n", ret);
+}
+static DEVICE_ATTR(vbus, 0644, musb_vbus_show, musb_vbus_store);
+
 #ifdef CONFIG_USB_MUSB_OTG
 static ssize_t
 musb_srp_store(struct device *dev, struct device_attribute *attr,
@@ -1674,6 +1746,7 @@
 #ifdef CONFIG_SYSFS
 	device_remove_file(musb->controller, &dev_attr_mode);
 	device_remove_file(musb->controller, &dev_attr_cable);
+	device_remove_file(musb->controller, &dev_attr_vbus);
 #ifdef CONFIG_USB_MUSB_OTG
 	device_remove_file(musb->controller, &dev_attr_srp);
 #endif
@@ -1905,6 +1978,7 @@
 #ifdef CONFIG_SYSFS
 	status = device_create_file(dev, &dev_attr_mode);
 	status = device_create_file(dev, &dev_attr_cable);
+	status = device_create_file(dev, &dev_attr_vbus);
 #ifdef CONFIG_USB_MUSB_OTG
 	status = device_create_file(dev, &dev_attr_srp);
 #endif /* CONFIG_USB_MUSB_OTG */
