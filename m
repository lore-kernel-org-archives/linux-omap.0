From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] ARM: OMAP3: Fix errors for omap_l3_smx when booted with device tree
Date: Wed,  5 Nov 2014 10:35:46 -0800
Message-ID: <1415212550-24692-2-git-send-email-tony@atomide.com>
References: <1415212550-24692-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19573 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751122AbaKEShr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2014 13:37:47 -0500
In-Reply-To: <1415212550-24692-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <ssantosh@kernel.org>

When booting omap3 in device tree mode, we're currently getting
the following errors:

omap_l3_smx omap_l3_smx.0: couldn't request debug irq
omap_l3_smx: probe of omap_l3_smx.0 failed with error -22

This is because we don't have handling in the driver for the
compatible property and instead assume platform data being
passed.

Note that this binding is already documented, and implemented
for the related omap_l3_noc driver for omap4 and later. Looks
like the binding somehow never got never implemented for this
omap_l3_smx driver though.

Let's also remove __exit_p to allow binding and unbinding
of the driver while at it.

Reported-by: Pavel Machek <pavel@ucw.cz>
Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3.dtsi  |  2 +-
 arch/arm/mach-omap2/devices.c |  2 +-
 drivers/bus/omap_l3_smx.c     | 26 +++++++++++++++++++++-----
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index d0e884d..e602e75 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -79,7 +79,7 @@
 	 * hierarchy.
 	 */
 	ocp {
-		compatible = "simple-bus";
+		compatible = "ti,omap3-l3-smx", "simple-bus";
 		reg = <0x68000000 0x10000>;
 		interrupts = <9 10>;
 		#address-cells = <1>;
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 324f02b..5544797 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -49,7 +49,7 @@ static int __init omap3_l3_init(void)
 	 * To avoid code running on other OMAPs in
 	 * multi-omap builds
 	 */
-	if (!(cpu_is_omap34xx()))
+	if (!(cpu_is_omap34xx()) || of_have_populated_dt())
 		return -ENODEV;
 
 	snprintf(oh_name, L3_MODULES_MAX_LEN, "l3_main");
diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
index acc2164..597fdae 100644
--- a/drivers/bus/omap_l3_smx.c
+++ b/drivers/bus/omap_l3_smx.c
@@ -27,6 +27,10 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
 #include "omap_l3_smx.h"
 
 static inline u64 omap3_l3_readll(void __iomem *base, u16 reg)
@@ -211,7 +215,17 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 	return ret;
 }
 
-static int __init omap3_l3_probe(struct platform_device *pdev)
+#if IS_BUILTIN(CONFIG_OF)
+static const struct of_device_id omap3_l3_match[] = {
+	{
+		.compatible = "ti,omap3-l3-smx",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, omap3_l3_match);
+#endif
+
+static int omap3_l3_probe(struct platform_device *pdev)
 {
 	struct omap3_l3 *l3;
 	struct resource *res;
@@ -265,7 +279,7 @@ err0:
 	return ret;
 }
 
-static int __exit omap3_l3_remove(struct platform_device *pdev)
+static int omap3_l3_remove(struct platform_device *pdev)
 {
 	struct omap3_l3         *l3 = platform_get_drvdata(pdev);
 
@@ -278,15 +292,17 @@ static int __exit omap3_l3_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver omap3_l3_driver = {
-	.remove         = __exit_p(omap3_l3_remove),
+	.probe		= omap3_l3_probe,
+	.remove         = omap3_l3_remove,
 	.driver         = {
-	.name   = "omap_l3_smx",
+		.name   = "omap_l3_smx",
+		.of_match_table = of_match_ptr(omap3_l3_match),
 	},
 };
 
 static int __init omap3_l3_init(void)
 {
-	return platform_driver_probe(&omap3_l3_driver, omap3_l3_probe);
+	return platform_driver_register(&omap3_l3_driver);
 }
 postcore_initcall_sync(omap3_l3_init);
 
-- 
2.1.1

