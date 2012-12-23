From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] watchdog: twl4030_wdt: add DT support
Date: Sun, 23 Dec 2012 22:03:37 +0200
Message-ID: <1356293017-29443-2-git-send-email-aaro.koskinen@iki.fi>
References: <1356293017-29443-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:43713 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab2LWUDz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Dec 2012 15:03:55 -0500
In-Reply-To: <1356293017-29443-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Add DT support for twl4030_wdt. This is needed to get twl4030_wdt to
probe when booting with DT.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt |   10 ++++++++++
 arch/arm/boot/dts/twl4030.dtsi                             |    4 ++++
 drivers/watchdog/twl4030_wdt.c                             |   11 +++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt b/Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt
new file mode 100644
index 0000000..80a3719
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt
@@ -0,0 +1,10 @@
+Device tree bindings for twl4030-wdt driver (TWL4030 watchdog)
+
+Required properties:
+	compatible = "ti,twl4030-wdt";
+
+Example:
+
+watchdog {
+	compatible = "ti,twl4030-wdt";
+};
diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 63411b0..ed0bc95 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -19,6 +19,10 @@
 		interrupts = <11>;
 	};
 
+	watchdog {
+		compatible = "ti,twl4030-wdt";
+	};
+
 	vdac: regulator-vdac {
 		compatible = "ti,twl4030-vdac";
 		regulator-min-microvolt = <1800000>;
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 81918cf..0f03106 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -131,14 +131,21 @@ static int twl4030_wdt_resume(struct platform_device *pdev)
 #define twl4030_wdt_resume         NULL
 #endif
 
+static const struct of_device_id twl_wdt_of_match[] = {
+	{ .compatible = "ti,twl4030-wdt", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, twl_wdt_of_match);
+
 static struct platform_driver twl4030_wdt_driver = {
 	.probe		= twl4030_wdt_probe,
 	.remove		= twl4030_wdt_remove,
 	.suspend	= twl4030_wdt_suspend,
 	.resume		= twl4030_wdt_resume,
 	.driver		= {
-		.owner	= THIS_MODULE,
-		.name	= "twl4030_wdt",
+		.owner		= THIS_MODULE,
+		.name		= "twl4030_wdt",
+		.of_match_table	= twl_wdt_of_match,
 	},
 };
 
-- 
1.7.10.4

