From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 01/11] usb: musb: add musb->id to identify core instance
Date: Thu, 12 Jul 2012 15:23:24 +0530
Message-ID: <1342086814-32181-2-git-send-email-ajay.gupta@ti.com>
References: <1342086814-32181-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1342086814-32181-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Added 'id' field within 'struct musb' which can be used to determine
the current instance of musb controller.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/am35x.c     |    2 +-
 drivers/usb/musb/blackfin.c  |    2 +-
 drivers/usb/musb/da8xx.c     |    2 +-
 drivers/usb/musb/davinci.c   |    2 +-
 drivers/usb/musb/musb_core.c |    2 ++
 drivers/usb/musb/musb_core.h |    2 ++
 drivers/usb/musb/musb_dsps.c |    2 +-
 drivers/usb/musb/omap2430.c  |    2 +-
 drivers/usb/musb/tusb6010.c  |    2 +-
 drivers/usb/musb/ux500.c     |    2 +-
 10 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 7a95ab8..cc0f06a 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -475,7 +475,7 @@ static int __devinit am35x_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	musb = platform_device_alloc("musb-hdrc", -1);
+	musb = platform_device_alloc("musb-hdrc", pdev->id);
 	if (!musb) {
 		dev_err(&pdev->dev, "failed to allocate musb device\n");
 		goto err1;
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index 428e6aa..c217781 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -478,7 +478,7 @@ static int __devinit bfin_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	musb = platform_device_alloc("musb-hdrc", -1);
+	musb = platform_device_alloc("musb-hdrc", pdev->id);
 	if (!musb) {
 		dev_err(&pdev->dev, "failed to allocate musb device\n");
 		goto err1;
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 0f9fcec..3f072a0 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -496,7 +496,7 @@ static int __devinit da8xx_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	musb = platform_device_alloc("musb-hdrc", -1);
+	musb = platform_device_alloc("musb-hdrc", pdev->id);
 	if (!musb) {
 		dev_err(&pdev->dev, "failed to allocate musb device\n");
 		goto err1;
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 472c8b4..b1f3fb0 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -530,7 +530,7 @@ static int __devinit davinci_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	musb = platform_device_alloc("musb-hdrc", -1);
+	musb = platform_device_alloc("musb-hdrc", pdev->id);
 	if (!musb) {
 		dev_err(&pdev->dev, "failed to allocate musb device\n");
 		goto err1;
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 89d1871..f6ce66f 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1867,6 +1867,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	int			status;
 	struct musb		*musb;
 	struct musb_hdrc_platform_data *plat = dev->platform_data;
+	struct platform_device *pdev = to_platform_device(dev);
 
 	/* The driver might handle more features than the board; OK.
 	 * Fail when the board needs a feature that's not enabled.
@@ -1889,6 +1890,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	pm_runtime_enable(musb->controller);
 
 	spin_lock_init(&musb->lock);
+	musb->id = pdev->id;
 	musb->board_mode = plat->mode;
 	musb->board_set_power = plat->set_power;
 	musb->min_power = plat->min_power;
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 51bd7b2..24daafd 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -450,6 +450,8 @@ struct musb {
 #ifdef MUSB_CONFIG_PROC_FS
 	struct proc_dir_entry *proc_entry;
 #endif
+	/* id for multiple musb instances */
+	u8			id;
 };
 
 static inline struct musb *gadget_to_musb(struct usb_gadget *g)
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 46b07cc..71fbe0e 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -535,7 +535,7 @@ static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 	resources[1].name = "mc";
 
 	/* allocate the child platform device */
-	musb = platform_device_alloc("musb-hdrc", -1);
+	musb = platform_device_alloc("musb-hdrc", pdev->id);
 	if (!musb) {
 		dev_err(dev, "failed to allocate musb device\n");
 		ret = -ENOMEM;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 5fdb9da..15506a4 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -448,7 +448,7 @@ static int __devinit omap2430_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	musb = platform_device_alloc("musb-hdrc", -1);
+	musb = platform_device_alloc("musb-hdrc", pdev->id);
 	if (!musb) {
 		dev_err(&pdev->dev, "failed to allocate musb device\n");
 		goto err0;
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 1a1bd9c..901aa05 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1182,7 +1182,7 @@ static int __devinit tusb_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	musb = platform_device_alloc("musb-hdrc", -1);
+	musb = platform_device_alloc("musb-hdrc", pdev->id);
 	if (!musb) {
 		dev_err(&pdev->dev, "failed to allocate musb device\n");
 		goto err1;
diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index a8c0fad..1eafb7c 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -74,7 +74,7 @@ static int __devinit ux500_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	musb = platform_device_alloc("musb-hdrc", -1);
+	musb = platform_device_alloc("musb-hdrc", pdev->id);
 	if (!musb) {
 		dev_err(&pdev->dev, "failed to allocate musb device\n");
 		goto err1;
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
