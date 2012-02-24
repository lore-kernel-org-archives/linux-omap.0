From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 5/6] arm/dts: OMAP4: Add gpio nodes
Date: Fri, 24 Feb 2012 23:21:30 +0100
Message-ID: <1330122091-28113-6-git-send-email-b-cousson@ti.com>
References: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59293 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758178Ab2BXWWV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 17:22:21 -0500
In-Reply-To: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Add the 6 GPIOs controller nodes present in OMAP4.

Remove gpio static device initialisation if DT is populated.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/boot/dts/omap4.dtsi |   54 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpio.c   |    8 ++++-
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 930a404..f654609 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -104,6 +104,60 @@
 			      <0x48240100 0x0100>;
 		};
 
+		gpio1: gpio@4a310000 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio1";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio2: gpio@48055000 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio2";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio3: gpio@48057000 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio3";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio4: gpio@48059000 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio4";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio5: gpio@4805b000 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio5";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio6: gpio@4805d000 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio6";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
 		uart1: serial@4806a000 {
 			compatible = "ti,omap4-uart";
 			ti,hwmods = "uart1";
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 1e0b750..de22abd 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
 
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
@@ -146,7 +147,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
  */
 static int __init omap2_gpio_init(void)
 {
-	return omap_hwmod_for_each_by_class("gpio", omap2_gpio_dev_init,
-						NULL);
+	/* If dtb is there, the devices will be created dynamically */
+	if (of_have_populated_dt())
+		return -ENODEV;
+
+	return omap_hwmod_for_each_by_class("gpio", omap2_gpio_dev_init, NULL);
 }
 postcore_initcall(omap2_gpio_init);
-- 
1.7.0.4

