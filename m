From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 01/13] hwspinlock: OMAP4: Add spinlock support in DT
Date: Mon, 26 Sep 2011 18:50:09 +0200
Message-ID: <1317055821-20652-2-git-send-email-b-cousson@ti.com>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48667 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191Ab1IZQvB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 12:51:01 -0400
In-Reply-To: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Add a device-tree node for the spinlock.
Remove the static device build code if CONFIG_OF
is set.
Update the hwspinlock driver to use the of_match method.
Add the information in Documentation/devicetree.

Add documentation for the HW spinlock in OMAP4.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
---
 .../bindings/hwspinlock/omap-spinlock.txt          |    5 +++++
 arch/arm/boot/dts/omap4.dtsi                       |    5 +++++
 arch/arm/mach-omap2/hwspinlock.c                   |    5 +++++
 drivers/hwspinlock/omap_hwspinlock.c               |   11 +++++++++++
 4 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwspinlock/omap-spinlock.txt

diff --git a/Documentation/devicetree/bindings/hwspinlock/omap-spinlock.txt b/Documentation/devicetree/bindings/hwspinlock/omap-spinlock.txt
new file mode 100644
index 0000000..4cea7cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwspinlock/omap-spinlock.txt
@@ -0,0 +1,5 @@
+* HW spinlock on OMAP4 platform:
+
+Required properties:
+- compatible : Must be "ti,omap4-spinlock";
+- ti,hwmods : "spinlock"
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 4c61c82..7a7f31e 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -99,5 +99,10 @@
 			reg = <0x48241000 0x1000>,
 			      <0x48240100 0x0100>;
 		};
+
+		spinlock {
+			compatible = "ti,omap4-spinlock";
+			ti,hwmods = "spinlock";
+		};
 	};
 };
diff --git a/arch/arm/mach-omap2/hwspinlock.c b/arch/arm/mach-omap2/hwspinlock.c
index 36e2109..80fc18f 100644
--- a/arch/arm/mach-omap2/hwspinlock.c
+++ b/arch/arm/mach-omap2/hwspinlock.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/of.h>
 
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
@@ -31,6 +32,10 @@ int __init hwspinlocks_init(void)
 	const char *oh_name = "spinlock";
 	const char *dev_name = "omap_hwspinlock";
 
+	/* If dtb is there, the devices will be created dynamically */
+	if (of_have_populated_dt())
+		return -ENODEV;
+
 	/*
 	 * Hwmod lookup will fail in case our platform doesn't support the
 	 * hardware spinlock module, so it is safe to run this initcall
diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index a8f0273..8dfa730 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -203,11 +203,22 @@ static int omap_hwspinlock_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id spinlock_match[] = {
+	{.compatible = "ti,omap4-spinlock", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, spinlock_match);
+#else
+#define spinlock_match NULL
+#endif
+
 static struct platform_driver omap_hwspinlock_driver = {
 	.probe		= omap_hwspinlock_probe,
 	.remove		= omap_hwspinlock_remove,
 	.driver		= {
 		.name	= "omap_hwspinlock",
+		.of_match_table = spinlock_match,
 	},
 };
 
-- 
1.7.0.4

