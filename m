From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 06/11] ARM: DTS: dra7-evm: Audio support
Date: Mon, 24 Aug 2015 10:20:02 +0300
Message-ID: <1440400807-32274-7-git-send-email-peter.ujfalusi@ti.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

The board uses tlv320aic3106 codec connected to McASP3. The master clock
for the codec and McASP3 is coming from ATL2.
McASP3 is the master on the I2S bus.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 113 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 3694046c29eb..1a66d359f3e3 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -9,6 +9,7 @@
 
 #include "dra74x.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/clk/ti-dra7-atl.h>
 
 / {
 	model = "TI DRA742";
@@ -64,6 +65,40 @@
 		enable-active-high;
 		gpio = <&gpio7 11 GPIO_ACTIVE_HIGH>;
 	};
+
+	sound0: sound@0 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "DRA7xx-EVM";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Line", "Line Out",
+			"Microphone", "Mic Jack",
+			"Line", "Line In";
+		simple-audio-card,routing =
+			"Headphone Jack",	"HPLOUT",
+			"Headphone Jack",	"HPROUT",
+			"Line Out",		"LLOUT",
+			"Line Out",		"RLOUT",
+			"MIC3L",		"Mic Jack",
+			"MIC3R",		"Mic Jack",
+			"Mic Jack",		"Mic Bias",
+			"LINE1L",		"Line In",
+			"LINE1R",		"Line In";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&sound0_master>;
+		simple-audio-card,frame-master = <&sound0_master>;
+		simple-audio-card,bitclock-inversion;
+
+		sound0_master: simple-audio-card,cpu {
+			sound-dai = <&mcasp3>;
+			system-clock-frequency = <5644800>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&tlv320aic3106>;
+			clocks = <&atl_clkin2_ck>;
+		};
+	};
 };
 
 &dra7_pmx_core {
@@ -292,6 +327,31 @@
 			0x418   (MUX_MODE15 | PULL_UP)	/* wakeup0.off */
 		>;
 	};
+
+	atl_pins: pinmux_atl_pins {
+		pinctrl-single,pins = <
+			0x298 (PIN_OUTPUT | MUX_MODE5)	/* xref_clk1.atl_clk1 */
+			0x29c (PIN_OUTPUT | MUX_MODE5)	/* xref_clk2.atl_clk2 */
+		>;
+	};
+
+	mcasp3_pins: pinmux_mcasp3_pins {
+		pinctrl-single,pins = <
+			0x324 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_aclkx */
+			0x328 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_fsx */
+			0x32c (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_axr0 */
+			0x330 (PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp3_axr1 */
+		>;
+	};
+
+	mcasp3_sleep_pins: pinmux_mcasp3_sleep_pins {
+		pinctrl-single,pins = <
+			0x324 (MUX_MODE15)
+			0x328 (MUX_MODE15)
+			0x32c (MUX_MODE15)
+			0x330 (MUX_MODE15)
+		>;
+	};
 };
 
 &i2c1 {
@@ -431,6 +491,20 @@
 		#interrupt-cells = <2>;
 	};
 
+	tlv320aic3106: tlv320aic3106@19 {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3106";
+		reg = <0x19>;
+		adc-settle-ms = <40>;
+		ai3x-micbias-vg = <1>;		/* 2.0V */
+		status = "okay";
+
+		/* Regulators */
+		AVDD-supply = <&evm_3v3_sw>;
+		IOVDD-supply = <&evm_3v3_sw>;
+		DRVDD-supply = <&evm_3v3_sw>;
+		DVDD-supply = <&aic_dvdd>;
+	};
 };
 
 &i2c2 {
@@ -730,3 +804,42 @@
 	pinctrl-1 = <&dcan1_pins_sleep>;
 	pinctrl-2 = <&dcan1_pins_default>;
 };
+
+&atl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&atl_pins>;
+
+	assigned-clocks = <&abe_dpll_sys_clk_mux>,
+			  <&atl_gfclk_mux>,
+			  <&dpll_abe_ck>,
+			  <&dpll_abe_m2x2_ck>,
+			  <&atl_clkin2_ck>;
+	assigned-clock-parents = <&sys_clkin2>, <&dpll_abe_m2_ck>;
+	assigned-clock-rates = <0>, <0>, <180633600>, <361267200>, <5644800>;
+
+	status = "okay";
+
+	atl2 {
+		bws = <DRA7_ATL_WS_MCASP2_FSX>;
+		aws = <DRA7_ATL_WS_MCASP3_FSX>;
+	};
+};
+
+&mcasp3 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&mcasp3_pins>;
+	pinctrl-1 = <&mcasp3_sleep_pins>;
+
+	assigned-clocks = <&mcasp3_ahclkx_mux>;
+	assigned-clock-parents = <&atl_clkin2_ck>;
+
+	status = "okay";
+
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	/* 4 serializer */
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+		1 2 0 0
+	>;
+};
-- 
2.5.0
