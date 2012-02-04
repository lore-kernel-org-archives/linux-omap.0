From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 1/2] usb: musb: fix some runtime_pm issues
Date: Sat,  4 Feb 2012 19:43:51 +0200
Message-ID: <1328377432-13563-2-git-send-email-notasas@gmail.com>
References: <1328377432-13563-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35021 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab2BDRoA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 12:44:00 -0500
In-Reply-To: <1328377432-13563-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>

When runtime_pm was originally added, it was done in rather confusing
way: omap2430_musb_init() (called from musb_init_controller) would do
runtime_pm_get_sync() and musb_init_controller() itself would do
runtime_pm_put to balance it out. This is not only confusing but also
wrong if non-omap2430 glue layer is used.

This confusion resulted in commit 772aed45b604 "usb: musb: fix
pm_runtime mismatch", that removed runtime_pm_put() from
musb_init_controller as that looked unbalanced, and also happened to
fix unrelated isp1704_charger crash. However this broke runtime PM
functionality (musb is now always powered, even without gadget active).

Avoid these confusing runtime pm dependences by making
musb_init_controller() and omap2430_musb_init() do their own runtime
get/put pairs; also cover error paths. Remove unneeded runtime_pm_put
in omap2430_remove too. isp1704_charger crash that motivated
772aed45b604 will be fixed by following patch.

Cc: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/usb/musb/musb_core.c |    9 ++++++++-
 drivers/usb/musb/omap2430.c  |    2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 3d11cf6..19543c9 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1904,7 +1904,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 
 	if (!musb->isr) {
 		status = -ENODEV;
-		goto fail3;
+		goto fail2;
 	}
 
 	if (!musb->xceiv->io_ops) {
@@ -1912,6 +1912,8 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		musb->xceiv->io_ops = &musb_ulpi_access;
 	}
 
+	pm_runtime_get_sync(musb->controller);
+
 #ifndef CONFIG_MUSB_PIO_ONLY
 	if (use_dma && dev->dma_mask) {
 		struct dma_controller	*c;
@@ -2023,6 +2025,8 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 		goto fail5;
 #endif
 
+	pm_runtime_put(musb->controller);
+
 	dev_info(dev, "USB %s mode controller at %p using %s, IRQ %d\n",
 			({char *s;
 			 switch (musb->board_mode) {
@@ -2047,6 +2051,9 @@ fail4:
 		musb_gadget_cleanup(musb);
 
 fail3:
+	pm_runtime_put_sync(musb->controller);
+
+fail2:
 	if (musb->irq_wake)
 		device_init_wakeup(dev, 0);
 	musb_platform_exit(musb);
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index df719ea..b105d46 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -332,6 +332,7 @@ static int omap2430_musb_init(struct musb *musb)
 
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
 
+	pm_runtime_put_noidle(musb->controller);
 	return 0;
 
 err1:
@@ -477,7 +478,6 @@ static int __exit omap2430_remove(struct platform_device *pdev)
 
 	platform_device_del(glue->musb);
 	platform_device_put(glue->musb);
-	pm_runtime_put(&pdev->dev);
 	kfree(glue);
 
 	return 0;
-- 
1.7.0.4

