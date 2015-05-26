From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2 7/7] ARM: dts: am335x-boneblack: Add HDMI audio support DO NOT MERGE
Date: Tue, 26 May 2015 21:59:11 +0300
Message-ID: <1432666751-24794-8-git-send-email-jsarha@ti.com>
References: <1432666751-24794-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59056 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbbEZTAb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 May 2015 15:00:31 -0400
In-Reply-To: <1432666751-24794-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, moinejf@free.fr, rmk+kernel@arm.linux.org.uk, Jyri Sarha <jsarha@ti.com>

This patch is here only to demonstrate HDMI codec functionality on
Beaglebone-Black.

Adds mcasp0_pins, clk_mcasp0_fixed, clk_mcasp0, mcasp0, sound node,
and changes the tda19988 node to follow the new binding.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 78 +++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index eadbba3..8a8abf5 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -64,6 +64,16 @@
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
@@ -76,21 +86,85 @@
 };
 
 &i2c0 {
-	tda19988 {
+	tda19988: tda19988 {
 		compatible = "nxp,tda998x";
 		reg = <0x70>;
+
+		#sound-dai-cells = <0>;
+
 		pinctrl-names = "default", "off";
 		pinctrl-0 = <&nxp_hdmi_bonelt_pins>;
 		pinctrl-1 = <&nxp_hdmi_bonelt_off_pins>;
 
-		port {
+		port@0 {
+			port-type = "rgb";
+			reg = <0x230145>;
 			hdmi_0: endpoint@0 {
 				remote-endpoint = <&lcdc_0>;
 			};
 		};
+		port@1 {
+			port-type = "i2s";
+			reg = <0x03>;
+			tda19988_i2s: endpoint {
+				remote-endpoint = <&mcasp0_i2s>;
+			};
+		};
 	};
 };
 
 &rtc {
 	system-power-controller;
 };
+
+&mcasp0	{
+	#sound-dai-cells = <0>;
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
+
+	port {
+		mcasp0_i2s: endpoint {
+			remote-endpoint = <&tda19988_i2s>;
+		};
+	};
+};
+
+/ {
+	clk_mcasp0_fixed: clk_mcasp0_fixed {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24576000>;
+	};
+
+	clk_mcasp0: clk_mcasp0 {
+		#clock-cells = <0>;
+		compatible = "gpio-gate-clock";
+		clocks = <&clk_mcasp0_fixed>;
+		enable-gpios = <&gpio1 27 0>; /* BeagleBone Black Clk enable on GPIO1_27 */
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "TI BeagleBone Black";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink0_master>;
+		simple-audio-card,frame-master = <&dailink0_master>;
+
+		dailink0_master: simple-audio-card,cpu {
+			sound-dai = <&mcasp0>;
+			clocks = <&clk_mcasp0>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&tda19988>;
+		};
+	};
+};
-- 
1.9.1

