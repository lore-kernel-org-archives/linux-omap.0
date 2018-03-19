From: Adam Ford <aford173@gmail.com>
Subject: [PATCH] ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux
Date: Mon, 19 Mar 2018 07:38:28 -0500
Message-ID: <1521463108-9014-1-git-send-email-aford173@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, ben.hutchings@codethink.co.uk, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>
List-Id: linux-omap@vger.kernel.org

commit 74402055a2d3ec998a1ded599e86185a27d9bbf4 upstream.

The pinmuxing was missing for I2C1 which was causing intermittent issues
with the PMIC which is connected to I2C1.  The bootloader did not quite
configure the I2C1 either, so when running at 2.6MHz, it was generating
errors at time.

This correctly sets the I2C1 pinmuxing so it can operate at 2.6MHz

Fixes: 687c27676151 ("ARM: dts: Add minimal support for LogicPD Torpedo
DM3730 devkit")

For linux-4.4.y

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
index 80f6c78..e056704 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -90,6 +90,8 @@
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <2600000>;
 
 	twl: twl@48 {
@@ -137,6 +139,12 @@
 			OMAP3_CORE1_IOPAD(0x218e, PIN_OUTPUT | MUX_MODE4)	/* mcbsp1_fsr.gpio_157 */
 		>;
 	};
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)        /* i2c1_scl.i2c1_scl */
+			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)        /* i2c1_sda.i2c1_sda */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
-- 
2.7.4
