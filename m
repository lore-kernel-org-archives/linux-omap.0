From: Jyri Sarha <jsarha@ti.com>
Subject: [RFC v2] ARM/dts: am335x-boneblack: Add HDMI audio support
Date: Sun, 8 Dec 2013 14:20:05 +0200
Message-ID: <f3c6306b5f283910630602c373407cbf4df91cea.1386504183.git.jsarha@ti.com>
References: <cover.1386504183.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39283 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363Ab3LHMUo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Dec 2013 07:20:44 -0500
In-Reply-To: <cover.1386504183.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
Cc: broonie@kernel.org, peter.ujfalusi@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Adds mcasp0_pins, clk_mcasp0_fixed, clk_mcasp0, mcasp0, hdmi_audio,
and sound nodes.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts |   52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 6b71ad9..860ea98 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -60,12 +60,35 @@
 			0x1b0 0x03      /* xdma_event_intr0, OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
 		>;
 	};
+
+	mcasp0_pins: mcasp0_pins {
+		pinctrl-single,pins = <
+			0x1ac (PIN_INPUT_PULLUP | MUX_MODE0) /* mcasp0_ahclkx.mcasp0_ahclkx */
+			0x19c (PIN_OUTPUT_PULLDOWN | MUX_MODE2) /* mcasp0_ahclkr.mcasp0_axr2 */
+			0x194 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* mcasp0_fsx.mcasp0_fsx */
+			0x190 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
+			0x06c (PIN_OUTPUT_PULLUP | MUX_MODE7) /* gpmc_a11.gpio1_27 */
+		>;
+	};
 };
 
 &lcdc {
 	status = "okay";
 };
 
+&mcasp0	{
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcasp0_pins>;
+	status = "okay";
+	op-mode = <0>;	/* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	serial-dir = <	/* 0: INACTIVE, 1: TX, 2: RX */
+			0 0 1 0
+		>;
+	tx-num-evt = <1>;
+	rx-num-evt = <1>;
+};
+
 / {
 	hdmi {
 		compatible = "ti,tilcdc,slave";
@@ -75,4 +98,33 @@
 		pinctrl-1 = <&nxp_hdmi_bonelt_off_pins>;
 		status = "okay";
 	};
+
+	clk_mcasp0_fixed: clk_mcasp0_fixed {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24576000>;
+	};
+
+	clk_mcasp0: clk_mcasp0 {
+		#clock-cells = <0>;
+		compatible = "gpio-clock";
+		clocks = <&clk_mcasp0_fixed>;
+		enable-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>; /* BeagleBone Black Clk enable on GPIO1_27 */
+	};
+
+	hdmi_audio: hdmi_audio@0 {
+	       compatible = "linux,hdmi-audio";
+	       status = "okay";
+	};
+
+	sound {
+		compatible = "ti,am33xx-beaglebone-black-audio";
+		ti,model = "TI BeagleBone Black";
+		ti,audio-codec = <&hdmi_audio>;
+		ti,mcasp-controller = <&mcasp0>;
+		ti,audio-routing =
+			"HDMI Out",	"TX";
+		clocks = <&clk_mcasp0>;
+		clock-names = "ti,codec-clock";
+	};
 };
-- 
1.7.9.5

