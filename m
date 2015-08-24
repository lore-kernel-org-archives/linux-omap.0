From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 11/11] ARM: DTS: am57xx-beagle-x15: Enable analog audio support
Date: Mon, 24 Aug 2015 10:20:07 +0300
Message-ID: <1440400807-32274-12-git-send-email-peter.ujfalusi@ti.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

The analog audio setup consists of:
McASP3 <-> tlv320aic3104 codec

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 87 +++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 485be19822f7..fd4c96ca8728 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -157,6 +157,32 @@
 			};
 		};
 	};
+
+	sound0: sound@0 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "BeagleBoard-X15";
+		simple-audio-card,widgets =
+			"Line", "Line Out",
+			"Line", "Line In";
+		simple-audio-card,routing =
+			"Line Out",	"LLOUT",
+			"Line Out",	"RLOUT",
+			"MIC2L",	"Line In",
+			"MIC2R",	"Line In";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&sound0_master>;
+		simple-audio-card,frame-master = <&sound0_master>;
+		simple-audio-card,bitclock-inversion;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp3>;
+		};
+
+		sound0_master: simple-audio-card,codec {
+			sound-dai = <&tlv320aic3104>;
+			clocks = <&clkout2_clk>;
+		};
+	};
 };
 
 &dra7_pmx_core {
@@ -347,6 +373,36 @@
 			0x370 (PIN_OUTPUT | MUX_MODE14)		/* gpio6_28 LS_OE */
 		>;
 	};
+
+	clkout2_pins_default: clkout2_pins_default {
+		pinctrl-single,pins = <
+			0x294 (PIN_OUTPUT_PULLDOWN | MUX_MODE9)	/* xref_clk0.clkout2 */
+		>;
+	};
+
+	clkout2_pins_sleep: clkout2_pins_sleep {
+		pinctrl-single,pins = <
+			0x294 (PIN_INPUT | MUX_MODE15)	/* xref_clk0.clkout2 */
+		>;
+	};
+
+	mcasp3_pins_default: mcasp3_pins_default {
+		pinctrl-single,pins = <
+			0x324 (PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_aclkx.mcasp3_aclkx */
+			0x328 (PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_fsx.mcasp3_fsx */
+			0x32c (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp3_axr0.mcasp3_axr0 */
+			0x330 (PIN_INPUT_PULLDOWN | MUX_MODE0) /* mcasp3_axr1.mcasp3_axr1 */
+		>;
+	};
+
+	mcasp3_pins_sleep: mcasp3_pins_sleep {
+		pinctrl-single,pins = <
+			0x324 (PIN_INPUT | MUX_MODE15)
+			0x328 (PIN_INPUT | MUX_MODE15)
+			0x32c (PIN_INPUT | MUX_MODE15)
+			0x330 (PIN_INPUT | MUX_MODE15)
+		>;
+	};
 };
 
 &i2c1 {
@@ -514,6 +570,22 @@
 		interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
 		#thermal-sensor-cells = <1>;
 	};
+
+	tlv320aic3104: tlv320aic3104@18 {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3104";
+		reg = <0x18>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&clkout2_pins_default>;
+		pinctrl-1 = <&clkout2_pins_sleep>;
+		status = "okay";
+		adc-settle-ms = <40>;
+
+		AVDD-supply = <&vdd_3v3>;
+		IOVDD-supply = <&vdd_3v3>;
+		DRVDD-supply = <&vdd_3v3>;
+		DVDD-supply = <&aic_dvdd>;
+	};
 };
 
 &i2c3 {
@@ -704,3 +776,18 @@
 &pcie1 {
 	gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
 };
+
+&mcasp3 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&mcasp3_pins_default>;
+	pinctrl-1 = <&mcasp3_pins_sleep>;
+	status = "okay";
+
+	op-mode = <0>;	/* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	/* 4 serializers */
+	serial-dir = <	/* 0: INACTIVE, 1: TX, 2: RX */
+		1 2 0 0
+	>;
+};
-- 
2.5.0
