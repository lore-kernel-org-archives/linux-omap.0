From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH RFC 7/7] ARM: dts: omap3-igep0020: Add SMSC911x LAN chip support
Date: Sat,  9 Feb 2013 21:44:31 +0100
Message-ID: <1360442671-15216-8-git-send-email-javier.martinez@collabora.co.uk>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40118 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932490Ab3BIUpJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 15:45:09 -0500
In-Reply-To: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

IGEPv2 boards has an SMSC LAN9221i ethernet chip connected to
the OMAP3 processor though the General-Purpose Memory Controller.

This patch adds a device node for the ethernet chip so the GPMC
driver will call the gpmc-smsc911x setup code.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep.dtsi    |    6 ++++++
 arch/arm/boot/dts/omap3-igep0020.dts |   24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 100eb41..2f02581 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -48,6 +48,12 @@
 			0x126 0x0100	/* sdmmc1_dat7.sdmmc1_dat7 INPUT | MODE 0 */
 		>;
 	};
+
+        smsc911x_pins: pinmux_smsc911x_pins {
+                pinctrl-single,pins = <
+                        0x1a2 0x0104    /* mcspi1_cs2.gpio_176 INPUT | MODE4 */
+                >;
+        };
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index e2b9849..68b7cf3 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -40,6 +40,18 @@
 			gpios = <&twl_gpio 19 1>;
 		};
 	};
+
+        vddvario: regulator-vddvario {
+                compatible = "regulator-fixed";
+                regulator-name = "vddvario";
+                regulator-always-on;
+        };
+
+        vdd33a: regulator-vdd33a {
+                compatible = "regulator-fixed";
+                regulator-name = "vdd33a";
+                regulator-always-on;
+        };
 };
 
 &i2c3 {
@@ -54,3 +66,15 @@
 		reg = <0x50>;
 	};
 };
+
+&gpmc {
+	gpmc_smsc911x@0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&smsc911x_pins>;
+		gpmc,cs = <5>; /* IGEP2_SMSC911X_CS */
+		gpmc,gpio_irq = <176>; /* IGEP2_SMSC911X_GPIO */
+		gpmc,flags = <18>; /* SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS */
+		vmmc-supply = <&vddvario>;
+		vmmc_aux-supply = <&vdd33a>;
+      };
+};
-- 
1.7.7.6

