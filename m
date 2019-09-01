From: David Lechner <david@lechnology.com>
Subject: [PATCH v3 5/6] ARM: dts: am335x-boneblue: Enable eQEP
Date: Sun,  1 Sep 2019 17:58:26 -0500
Message-ID: <20190901225827.12301-6-david@lechnology.com>
References: <20190901225827.12301-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190901225827.12301-1-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This enables the Enhanced Quadrature Encoder Pulse (eQEP) module for
connectors E1, E2 and E3 on BeagleBone Blue.

Signed-off-by: David Lechner <david@lechnology.com>
---

v3 changes:
- none
v2 changes:
- none

 arch/arm/boot/dts/am335x-boneblue.dts | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index 0257576d5d16..df3978ce061c 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -258,6 +258,30 @@
 			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_OUTPUT, MUX_MODE7)		/* (M16) gmii1_rxd0.gpio2[21] */
 		>;
 	};
+
+	/* E1 */
+	eqep0_pins: pinmux_eqep0_pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR0, PIN_INPUT, MUX_MODE1)		/* (B12) mcasp0_aclkr.eQEP0A_in */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSR, PIN_INPUT, MUX_MODE1)		/* (C13) mcasp0_fsr.eQEP0B_in */
+		>;
+	};
+
+	/* E2 */
+	eqep1_pins: pinmux_eqep1_pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA12, PIN_INPUT, MUX_MODE2)		/* (V2) lcd_data12.eQEP1A_in */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA13, PIN_INPUT, MUX_MODE2)		/* (V3) lcd_data13.eQEP1B_in */
+		>;
+	};
+
+	/* E3 */
+	eqep2_pins: pinmux_eqep2_pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_INPUT, MUX_MODE4)		/* (T12) gpmc_ad12.eQEP2A_in */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_INPUT, MUX_MODE4)		/* (R12) gpmc_ad13.eQEP2B_in */
+		>;
+	};
 };
 
 &uart0 {
@@ -530,3 +554,33 @@
 		line-name = "LS_BUF_EN";
 	};
 };
+
+&epwmss0 {
+	status = "okay";
+};
+
+&eqep0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&eqep0_pins>;
+};
+
+&epwmss1 {
+	status = "okay";
+};
+
+&eqep1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&eqep1_pins>;
+};
+
+&epwmss2 {
+	status = "okay";
+};
+
+&eqep2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&eqep2_pins>;
+};
-- 
2.17.1
