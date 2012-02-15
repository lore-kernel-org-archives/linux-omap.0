From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 4/5] arm/dts: OMAP4: Add gpio nodes
Date: Wed, 15 Feb 2012 17:04:13 +0100
Message-ID: <1329321854-24490-5-git-send-email-b-cousson@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55028 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab2BOQEw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 11:04:52 -0500
In-Reply-To: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Add the 6 GPIOs controller nodes present in OMAP4.

Remove gpio static device initialisation if DT is populated.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/boot/dts/omap4.dtsi |   54 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpio.c   |    8 ++++-
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 29f4589..4b81f03 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -104,6 +104,60 @@
 			      <0x48240100 0x0100>;
 		};
 
+		gpio1: gpio@1 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio1";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio2: gpio@2 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio2";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio3: gpio@3 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio3";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio4: gpio@4 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio4";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio5: gpio@5 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio5";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio6: gpio@6 {
+			compatible = "ti,omap4-gpio";
+			ti,hwmods = "gpio6";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
 		uart1: serial@0x4806a000 {
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

