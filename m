From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/6] mfd: omap-usb-host: move initialization to module_init()
Date: Wed, 10 Jul 2013 19:22:48 +0300
Message-ID: <1373473368-27476-1-git-send-email-rogerq@ti.com>
References: <1373473081-27181-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373473081-27181-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org, balbi@ti.com, sergei.shtylyov@cogentembedded.com, khilman@linaro.org, tony@atomide.com, ruslan.bilovol@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

We no longer need to be initialized in any particular order
so move driver initialization to the standard place i.e. module_init()

CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |   23 +++--------------------
 drivers/mfd/omap-usb-tll.c  |   20 ++------------------
 2 files changed, 5 insertions(+), 38 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 759fae3..fb2b3d8 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -895,31 +895,14 @@ static struct platform_driver usbhs_omap_driver = {
 		.pm		= &usbhsomap_dev_pm_ops,
 		.of_match_table = of_match_ptr(usbhs_omap_dt_ids),
 	},
+	.probe		= usbhs_omap_probe,
 	.remove		= usbhs_omap_remove,
 };
 
+module_platform_driver(usbhs_omap_driver);
+
 MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
 MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
 MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("usb host common core driver for omap EHCI and OHCI");
-
-static int __init omap_usbhs_drvinit(void)
-{
-	return platform_driver_probe(&usbhs_omap_driver, usbhs_omap_probe);
-}
-
-/*
- * init before ehci and ohci drivers;
- * The usbhs core driver should be initialized much before
- * the omap ehci and ohci probe functions are called.
- * This usbhs core driver should be initialized after
- * usb tll driver
- */
-fs_initcall_sync(omap_usbhs_drvinit);
-
-static void __exit omap_usbhs_drvexit(void)
-{
-	platform_driver_unregister(&usbhs_omap_driver);
-}
-module_exit(omap_usbhs_drvexit);
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index e59ac4c..1a3a26f 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -326,6 +326,8 @@ static struct platform_driver usbtll_omap_driver = {
 	.remove		= usbtll_omap_remove,
 };
 
+module_platform_driver(usbtll_omap_driver);
+
 int omap_tll_init(struct usbhs_omap_platform_data *pdata)
 {
 	int i;
@@ -477,21 +479,3 @@ MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
 MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI controllers");
-
-static int __init omap_usbtll_drvinit(void)
-{
-	return platform_driver_register(&usbtll_omap_driver);
-}
-
-/*
- * init before usbhs core driver;
- * The usbtll driver should be initialized before
- * the usbhs core driver probe function is called.
- */
-fs_initcall(omap_usbtll_drvinit);
-
-static void __exit omap_usbtll_drvexit(void)
-{
-	platform_driver_unregister(&usbtll_omap_driver);
-}
-module_exit(omap_usbtll_drvexit);
-- 
1.7.4.1
