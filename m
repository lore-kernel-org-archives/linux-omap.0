From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.20-rc3-omap1] musb_hdrc workqueue build fix
Date: Wed, 10 Jan 2007 17:17:17 -0800
Message-ID: <200701101717.18559.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Yet another workqueue-api-changed build fix.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- h4.orig/drivers/usb/musb/plat_uds.c	2007-01-10 14:19:43.000000000 -0800
+++ h4/drivers/usb/musb/plat_uds.c	2007-01-10 00:21:44.000000000 -0800
@@ -1561,9 +1561,9 @@ static DEVICE_ATTR(cable, S_IRUGO, musb_
 #endif
 
 /* Only used to provide cable state change events */
-static void musb_irq_work(void *data)
+static void musb_irq_work(struct work_struct *data)
 {
-	struct musb *musb = (struct musb *)data;
+	struct musb *musb = container_of(data, struct musb, irq_work);
 
 	sysfs_notify(&musb->controller->kobj, NULL, "cable");
 }
@@ -1835,7 +1835,7 @@ fail:
 		return status;
 	}
 
-	INIT_WORK(&pThis->irq_work, musb_irq_work, pThis);
+	INIT_WORK(&pThis->irq_work, musb_irq_work);
 
 #ifdef CONFIG_SYSFS
 	status = device_create_file(dev, &dev_attr_mode);
