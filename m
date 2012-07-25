From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 02/11] usb: musb: kill global and static for multi instance
Date: Wed, 25 Jul 2012 17:42:06 +0530
Message-ID: <1343218326-30610-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Moved global variable "musb_debugfs_root" and static variable
"old_state" to 'struct musb' to help support multi instance of
musb controller as present on AM335x platform.

Also removed the global variable "orig_dma_mask" and filled the
dev->dma_mask with parent device's dma_mask.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_core.c    |   22 +++++++---------------
 drivers/usb/musb/musb_core.h    |    4 ++++
 drivers/usb/musb/musb_debugfs.c |   14 ++++++++------
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index f5eb8a7..cfd93b7 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -100,6 +100,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/idr.h>
+#include <linux/dma-mapping.h>
 
 #include "musb_core.h"
 
@@ -1804,10 +1805,9 @@ static const struct attribute_group musb_attr_group = {
 static void musb_irq_work(struct work_struct *data)
 {
 	struct musb *musb = container_of(data, struct musb, irq_work);
-	static int old_state;
 
-	if (musb->xceiv->state != old_state) {
-		old_state = musb->xceiv->state;
+	if (musb->xceiv->state != musb->xceiv_old_state) {
+		musb->xceiv_old_state = musb->xceiv->state;
 		sysfs_notify(&musb->controller->kobj, NULL, "mode");
 	}
 }
@@ -2117,11 +2117,6 @@ fail0:
 /* all implementations (PCI bridge to FPGA, VLYNQ, etc) should just
  * bridge to a platform device; this driver then suffices.
  */
-
-#ifndef CONFIG_MUSB_PIO_ONLY
-static u64	*orig_dma_mask;
-#endif
-
 static int __devinit musb_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
@@ -2140,10 +2135,6 @@ static int __devinit musb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-#ifndef CONFIG_MUSB_PIO_ONLY
-	/* clobbered by use_dma=n */
-	orig_dma_mask = dev->dma_mask;
-#endif
 	status = musb_init_controller(dev, irq, base);
 	if (status < 0)
 		iounmap(base);
@@ -2153,7 +2144,8 @@ static int __devinit musb_probe(struct platform_device *pdev)
 
 static int __devexit musb_remove(struct platform_device *pdev)
 {
-	struct musb	*musb = dev_to_musb(&pdev->dev);
+	struct device	*dev = &pdev->dev;
+	struct musb	*musb = dev_to_musb(dev);
 	void __iomem	*ctrl_base = musb->ctrl_base;
 
 	/* this gets called on rmmod.
@@ -2166,9 +2158,9 @@ static int __devexit musb_remove(struct platform_device *pdev)
 
 	musb_free(musb);
 	iounmap(ctrl_base);
-	device_init_wakeup(&pdev->dev, 0);
+	device_init_wakeup(dev, 0);
 #ifndef CONFIG_MUSB_PIO_ONLY
-	pdev->dev.dma_mask = orig_dma_mask;
+	dma_set_mask(dev, *dev->parent->dma_mask);
 #endif
 	return 0;
 }
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 69ed141..6b6cee9 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -452,6 +452,10 @@ struct musb {
 #endif
 	/* id for multiple musb instances */
 	u8			id;
+	int                     xceiv_old_state;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry           *debugfs_root;
+#endif
 };
 
 static inline struct musb *gadget_to_musb(struct usb_gadget *g)
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 40a37c9..b1e8f21 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -103,8 +103,6 @@ static const struct musb_register_map musb_regmap[] = {
 	{  }	/* Terminating Entry */
 };
 
-static struct dentry *musb_debugfs_root;
-
 static int musb_regdump_show(struct seq_file *s, void *unused)
 {
 	struct musb		*musb = s->private;
@@ -240,20 +238,24 @@ int __devinit musb_init_debugfs(struct musb *musb)
 	struct dentry		*root;
 	struct dentry		*file;
 	int			ret;
+	char			name[10];
 
-	root = debugfs_create_dir("musb", NULL);
+	sprintf(name, "musb%d", musb->id);
+	root = debugfs_create_dir(name, NULL);
 	if (!root) {
 		ret = -ENOMEM;
 		goto err0;
 	}
 
-	file = debugfs_create_file("regdump", S_IRUGO, root, musb,
+	sprintf(name, "regdump%d", musb->id);
+	file = debugfs_create_file(name, S_IRUGO, root, musb,
 			&musb_regdump_fops);
 	if (!file) {
 		ret = -ENOMEM;
 		goto err1;
 	}
 
+	sprintf(name, "testmode%d", musb->id);
 	file = debugfs_create_file("testmode", S_IRUGO | S_IWUSR,
 			root, musb, &musb_test_mode_fops);
 	if (!file) {
@@ -261,7 +263,7 @@ int __devinit musb_init_debugfs(struct musb *musb)
 		goto err1;
 	}
 
-	musb_debugfs_root = root;
+	musb->debugfs_root = root;
 
 	return 0;
 
@@ -274,5 +276,5 @@ err0:
 
 void /* __init_or_exit */ musb_exit_debugfs(struct musb *musb)
 {
-	debugfs_remove_recursive(musb_debugfs_root);
+	debugfs_remove_recursive(musb->debugfs_root);
 }
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
