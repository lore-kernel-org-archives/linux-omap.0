From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 6/8] ARM: dts: am335x-sl50: use audio-graph-card for sound.
Date: Wed,  6 Jun 2018 17:54:11 +0200
Message-ID: <20180606155413.23542-6-enric.balletbo@collabora.com>
References: <20180606155413.23542-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606155413.23542-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, devicetree@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

audio-graph-card is recommended for audio bindings. Let's change to it and
improve the support by adding the Amplifier configuration and the clock
enable control.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm/boot/dts/am335x-sl50.dts | 111 +++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index b15690155159..495a4a0be25c 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -105,11 +105,20 @@
 		#size-cells = <0>;
 
 		/* audio external oscillator */
-		tlv320aic3x_mclk: oscillator@0 {
+		audio_mclk_fixed: oscillator@0 {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency  = <24576000>;	/* 24.576MHz */
 		};
+
+		audio_mclk: audio_mclk_gate@0 {
+			compatible = "gpio-gate-clock";
+			#clock-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&audio_mclk_pins>;
+			clocks = <&audio_mclk_fixed>;
+			enable-gpios = <&gpio1 27 0>;
+		};
 	};
 
 	panel: lcd_panel {
@@ -152,19 +161,29 @@
 	};
 
 	sound {
-		compatible = "ti,da830-evm-audio";
-		ti,model = "AM335x-SL50";
-		ti,audio-codec = <&audio_codec>;
-		ti,mcasp-controller = <&mcasp0>;
+		compatible = "audio-graph-card";
+		label = "sound-card";
+		pinctrl-names = "default";
+		pinctrl-0 = <&audio_pa_pins>;
+
+		widgets = "Headphone", "Headphone Jack",
+			  "Speaker", "Speaker External",
+			  "Line", "Line In",
+			  "Microphone", "Microphone Jack";
 
-		clocks = <&tlv320aic3x_mclk>;
-		clock-names = "mclk";
+		routing = "Headphone Jack",	"HPLOUT",
+			  "Headphone Jack",	"HPROUT",
+			  "Amplifier",		"MONO_LOUT",
+			  "Speaker External",	"Amplifier",
+			  "LINE1R",		"Line In",
+			  "LINE1L",		"Line In",
+			  "MIC3L",		"Microphone Jack",
+			  "MIC3R",		"Microphone Jack",
+			  "Microphone Jack",	"Mic Bias";
 
-		ti,audio-routing =
-			"Headphone Jack",	"HPLOUT",
-			"Headphone Jack",	"HPROUT",
-			"LINE1R",               "Line In",
-			"LINE1L",		"Line In";
+		dais = <&cpu_port>;
+
+		pa-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
 	};
 
 	emmc_pwrseq: pwrseq@0 {
@@ -194,6 +213,28 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&lwb_pins>;
 
+	audio_pins: pinmux_audio_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_ahcklx.mcasp0_ahclkx */
+			AM33XX_IOPAD(0x994, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
+			AM33XX_IOPAD(0x990, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
+			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr0.mcasp0_axr0 */
+			AM33XX_IOPAD(0x99c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mcasp0_ahclkr.mcasp0_axr2 */
+		>;
+	};
+
+	audio_pa_pins: pinmux_audio_pa_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* SoundPA_en - mcasp0_aclkr.gpio3_18 */
+		>;
+	};
+
+	audio_mclk_pins: pinmux_audio_mclk_pins {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a11.gpio1_27 */
+		>;
+	};
+
 	backlight0_pins: pinmux_backlight0_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE7)	/* gpmc_wen.gpio2_4 */
@@ -358,16 +399,6 @@
 		>;
 	};
 
-	audio_pins: pinmux_audio_pins {
-		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_ahcklx.mcasp0_ahclkx */
-			AM33XX_IOPAD(0x994, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
-			AM33XX_IOPAD(0x990, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
-			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr0.mcasp0_axr0 */
-			AM33XX_IOPAD(0x99c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mcasp0_ahclkr.mcasp0_axr2 */
-		>;
-	};
-
 	ehrpwm1_pins: pinmux_ehrpwm1a_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x848, PIN_OUTPUT | MUX_MODE6)	/* gpmc_a2.ehrpwm1a */
@@ -393,7 +424,6 @@
 
 	lwb_pins: pinmux_lwb_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9a4, PIN_OUTPUT | MUX_MODE7)	/* SoundPA_en - mcasp0_fsr.gpio3_19 */
 			AM33XX_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE7)	/* nKbdInt - gpmc_ad12.gpio1_12 */
 			AM33XX_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE7)	/* nKbdReset - gpmc_ad13.gpio1_13 */
 			AM33XX_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE7)	/* USB1_enPower - gpmc_a1.gpio1_17 */
@@ -448,12 +478,21 @@
 	audio_codec: tlv320aic3106@1b {
 		status = "okay";
 		compatible = "ti,tlv320aic3106";
+		#sound-dai-cells = <0>;
 		reg = <0x1b>;
+		ai3x-micbias-vg = <2>;  /* 2.5V */
 
 		AVDD-supply = <&ldo4_reg>;
 		IOVDD-supply = <&ldo4_reg>;
 		DRVDD-supply = <&ldo4_reg>;
 		DVDD-supply = <&ldo3_reg>;
+
+		codec_port: port {
+			codec_endpoint: endpoint {
+				remote-endpoint = <&cpu_endpoint>;
+				clocks = <&audio_mclk>;
+			};
+		};
 	};
 
 	/* Ambient Light Sensor */
@@ -519,17 +558,27 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&audio_pins>;
-
+	#sound-dai-cells = <0>;
 	op-mode = <0>;  /* MCASP_ISS_MODE */
 	tdm-slots = <2>;
-	serial-dir = <
-		2 0 1 0
-		0 0 0 0
-		0 0 0 0
-		0 0 0 0
+	/* 4 serializers */
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+		0 0 1 2
 	>;
-	tx-num-evt = <1>;
-	rx-num-evt = <1>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+
+	cpu_port: port {
+		cpu_endpoint: endpoint {
+			remote-endpoint = <&codec_endpoint>;
+
+			dai-format = "dsp_b";
+			bitclock-master = <&codec_port>;
+			frame-master = <&codec_port>;
+			bitclock-inversion;
+			clocks = <&audio_mclk>;
+		};
+	};
 };
 
 &uart0 {
-- 
2.17.1
