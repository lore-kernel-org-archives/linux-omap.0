From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/12] musb_hdrc: Make vbus sysfs entry report current Vbus
	status
Date: Thu, 11 Oct 2007 10:05:23 -0700
Message-ID: <11921223381405-git-send-email-tony@atomide.com>
References: <1192122325531-git-send-email-tony@atomide.com>
	<11921223262203-git-send-email-tony@atomide.com>
	<11921223272557-git-send-email-tony@atomide.com>
	<11921223283749-git-send-email-tony@atomide.com>
	<11921223301447-git-send-email-tony@atomide.com>
	<11921223311131-git-send-email-tony@atomide.com>
	<11921223321890-git-send-email-tony@atomide.com>
	<11921223331118-git-send-email-tony@atomide.com>
	<11921223352146-git-send-email-tony@atomide.com>
	<11921223372253-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11921223372253-git-send-email-tony@atomide.com>
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

Getting the current status of Vbus is useful when running
USB Compliance Tests.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 3d35a4e..dc934dc 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1718,12 +1718,15 @@ musb_vbus_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct musb	*musb = dev_to_musb(dev);
 	unsigned long	flags;
 	unsigned long	val;
+	int		vbus;
 
 	spin_lock_irqsave(&musb->lock, flags);
 	val = musb->a_wait_bcon;
+	vbus = musb_platform_get_vbus_status(musb);
 	spin_unlock_irqrestore(&musb->lock, flags);
 
-	return sprintf(buf, "%lu\n", val);
+	return sprintf(buf, "Vbus %s, timeout %lu\n",
+			vbus ? "on" : "off", val);
 }
 static DEVICE_ATTR(vbus, 0644, musb_vbus_show, musb_vbus_store);
 
-- 
1.5.2.5
