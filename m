From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 6/8] ARM: dts: am335x-boneblack: Add HDMI audio support
Date: Tue, 19 Aug 2014 00:46:44 +0300
Message-ID: <9bac9db7ac3a7d6bde6fd84dce836804f3599e4b.1408397864.git.jsarha@ti.com>
References: <cover.1408397864.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40735 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbaHRVrK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Aug 2014 17:47:10 -0400
In-Reply-To: <cover.1408397864.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, alsa-devel@alsa-project.org
Cc: tony@atomide.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, ezequiel.garcia@free-electrons.com, t-kristo@ti.com, Jyri Sarha <jsarha@ti.com>

Adds mcasp0_pins, clk_mcasp0_fixed, clk_mcasp0, mcasp0, hdmi_audio,
and sound nodes.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts |   54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 305975d..e815fee 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -59,12 +59,50 @@
 			0x1b0 0x03      /* xdma_event_intr0, OMAP_MUX_MODE3 | AM33XX_PIN_OUTPUT */
 		>;
 	};
+
+	mcasp0_pins: mcasp0_pins {
+		pinctrl-single,pins = <
+			0x1ac (PIN_INPUT_PULLUP | MUX_MODE0)	/* mcasp0_ahclkx.mcasp0_ahclkx */
+			0x19c (PIN_OUTPUT_PULLDOWN | MUX_MODE2) /* mcasp0_ahclkr.mcasp0_axr2 */
+			0x194 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
+			0x190 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
+			0x06c (PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a11.GPIO1_27 */
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
+&ext_clocks {
+	clk_mcasp0_fixed: clk_mcasp0_fixed {
+	      #clock-cells = <0>;
+	      compatible = "fixed-clock";
+	      clock-frequency = <24576000>;
+	};
+
+	clk_mcasp0: clk_mcasp0 {
+	      #clock-cells = <0>;
+	      compatible = "ti,gpio-clock";
+	      clocks = <&clk_mcasp0_fixed>;
+	      enable-gpios = <&gpio1 27 0>; /* BeagleBone Black Clk enable on GPIO1_27 */
+	};
+};
+
 / {
 	hdmi {
 		compatible = "ti,tilcdc,slave";
@@ -74,4 +112,20 @@
 		pinctrl-1 = <&nxp_hdmi_bonelt_off_pins>;
 		status = "okay";
 	};
+
+	hdmi_audio: hdmi_audio@0 {
+	       compatible = "linux,hdmi-audio";
+	       status = "okay";
+	};
+
+	sound {
+		compatible = "ti,am335x-beaglebone-black-audio";
+		ti,model = "TI BeagleBone Black";
+		ti,audio-codec = <&hdmi_audio>;
+		ti,mcasp-controller = <&mcasp0>;
+		ti,audio-routing =
+			"HDMI Out",	"TX";
+		clocks = <&clk_mcasp0>;
+		clock-names = "mclk";
+	};
 };
-- 
1.7.9.5

