From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] mfd: omap-usb-host: Fix dts probe of children
Date: Wed, 25 Apr 2018 07:29:22 -0700
Message-ID: <20180425142922.128233-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

It currently only works if the parent bus uses "simple-bus". We
currently try to probe children with non-existing compatible values.
And we're missing .probe.

I noticed this while testing devices configured to probe using ti-sysc
interconnect target module driver. For that we also may want to rebind
the driver, so let's remove __init and __exit.

Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

This is OK to wait for v4.18 merge window as the related dts node has
not yet been updated to probe via ti-sysc interconnect target driver.

---
 drivers/mfd/omap-usb-host.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -548,8 +548,8 @@ static int usbhs_omap_get_dt_pdata(struct device *dev,
 }
 
 static const struct of_device_id usbhs_child_match_table[] = {
-	{ .compatible = "ti,omap-ehci", },
-	{ .compatible = "ti,omap-ohci", },
+	{ .compatible = "ti,ehci-omap", },
+	{ .compatible = "ti,ohci-omap3", },
 	{ }
 };
 
@@ -875,6 +875,7 @@ static struct platform_driver usbhs_omap_driver = {
 		.pm		= &usbhsomap_dev_pm_ops,
 		.of_match_table = usbhs_omap_dt_ids,
 	},
+	.probe		= usbhs_omap_probe,
 	.remove		= usbhs_omap_remove,
 };
 
@@ -884,9 +885,9 @@ MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("usb host common core driver for omap EHCI and OHCI");
 
-static int __init omap_usbhs_drvinit(void)
+static int omap_usbhs_drvinit(void)
 {
-	return platform_driver_probe(&usbhs_omap_driver, usbhs_omap_probe);
+	return platform_driver_register(&usbhs_omap_driver);
 }
 
 /*
@@ -898,7 +899,7 @@ static int __init omap_usbhs_drvinit(void)
  */
 fs_initcall_sync(omap_usbhs_drvinit);
 
-static void __exit omap_usbhs_drvexit(void)
+static void omap_usbhs_drvexit(void)
 {
 	platform_driver_unregister(&usbhs_omap_driver);
 }
-- 
2.17.0
