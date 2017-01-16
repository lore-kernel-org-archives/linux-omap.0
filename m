From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 1/6] ARM: dts: am335x-sl50: Remove I2C1 node.
Date: Mon, 16 Jan 2017 17:57:31 +0100
Message-ID: <20170116165736.17197-2-enric.balletbo@collabora.com>
References: <20170116165736.17197-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170116165736.17197-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

I2C1 is not used so remove it in order to avoid conflicts.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm/boot/dts/am335x-sl50.dts | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index b0dfa6f..34f4900 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -150,13 +150,6 @@
 		>;
 	};
 
-	i2c1_pins: pinmux_i2c1_pins {
-		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_rxd.i2c1_sda */
-			AM33XX_IOPAD(0x984, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_txdi2c1_scl */
-		>;
-	};
-
 	i2c2_pins: pinmux_i2c2_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE3)	/* uart1_ctsn.i2c2_sda */
@@ -298,12 +291,6 @@
 	};
 };
 
-&i2c1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
-};
-
 &i2c2 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.9.3
