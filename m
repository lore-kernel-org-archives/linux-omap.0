From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 DTS 3/4] ARM/dts: am335x-evm: Add audio support for am335x-evm.dts
Date: Sun, 20 Oct 2013 20:04:10 +0300
Message-ID: <d7ea80e9e503939a12002f19bddddecb4f6e7e67.1382288457.git.jsarha@ti.com>
References: <cover.1382288454.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53385 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab3JTRE3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Oct 2013 13:04:29 -0400
In-Reply-To: <cover.1382288454.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, joelf@ti.com, Darren Etheridge <detheridge@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>

From: Darren Etheridge <detheridge@ti.com>

Adds sound, tlv320aic3106, mcasp1, and am335x_evm_audio_pin nodes.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index eabacf9..9874294 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -119,6 +119,19 @@
 			};
 		};
 	};
+
+	sound {
+		compatible = "ti,da830-evm-audio";
+		ti,model = "AM335x-EVM";
+		ti,audio-codec = <&tlv320aic3106>;
+		ti,mcasp-controller = <&mcasp1>;
+		ti,codec-clock-rate = <12000000>;
+		ti,audio-routing =
+			"Headphone Jack",       "HPLOUT",
+			"Headphone Jack",       "HPROUT",
+			"LINE1L",               "Line In",
+			"LINE1R",               "Line In";
+	};
 };
 
 &am33xx_pinmux {
@@ -279,6 +292,15 @@
 			0xec 0x00	/* lcd_ac_bias_en.lcd_ac_bias_en, OUTPUT | MODE0 */
 		>;
 	};
+
+	am335x_evm_audio_pins: am335x_evm_audio_pins {
+		pinctrl-single,pins = <
+			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rx_dv.mcasp1_aclkx */
+			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_txd3.mcasp1_fsx */
+			0x108 (PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* mii1_col.mcasp1_axr2 */
+			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
+		>;
+	};
 };
 
 &uart0 {
@@ -373,6 +395,18 @@
 		compatible = "ti,tmp275";
 		reg = <0x48>;
 	};
+
+	tlv320aic3106: tlv320aic3106@1b {
+		compatible = "ti,tlv320aic3106";
+		reg = <0x1b>;
+		status = "okay";
+
+		/* Regulators */
+		AVDD-supply = <&vaux2_reg>;
+		IOVDD-supply = <&vaux2_reg>;
+		DRVDD-supply = <&vaux2_reg>;
+		DVDD-supply = <&vbat>;
+	};
 };
 
 &lcdc {
@@ -476,6 +510,22 @@
 
 #include "tps65910.dtsi"
 
+&mcasp1 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&am335x_evm_audio_pins>;
+
+		status = "okay";
+
+		op-mode = <0>;          /* MCASP_IIS_MODE */
+		tdm-slots = <2>;
+		/* 4 serializers */
+		serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+			0 0 1 2
+		>;
+		tx-num-evt = <1>;
+		rx-num-evt = <1>;
+};
+
 &tps {
 	vcc1-supply = <&vbat>;
 	vcc2-supply = <&vbat>;
-- 
1.7.9.5

