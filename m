From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 11/11] ARM/dts: am335x-evm: Add audio support for am335x-evm.dts
Date: Thu, 19 Sep 2013 14:29:44 +0300
Message-ID: <cd7271a46f1c6937039b749ed105afa8057b9770.1379590036.git.jsarha@ti.com>
References: <cover.1379590035.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1379590035.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>

Adds sound, tlv320aic3x, mcasp1, and am335x_evm_audio_pin nodes.

Signed-off-by: Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-evm.dts |   56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 3aee1a4..4a49229 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -149,6 +149,16 @@
 				0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
 			>;
 		};
+
+		am335x_evm_audio_pins: am335x_evm_audio_pins {
+			pinctrl-single,pins = <
+				0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rx_dv.mcasp1_aclkx */
+				0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_txd3.mcasp1_fsx */
+				0x108 (PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* mii1_col.mcasp1_axr2 */
+				0x144 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
+			>;
+		};
+
 	};
 
 	ocp {
@@ -215,6 +225,19 @@
 				compatible = "ti,tmp275";
 				reg = <0x48>;
 			};
+
+			tlv320aic3x: tlv320aic3x@1b {
+				compatible = "ti,tlv320aic3x";
+				reg = <0x1b>;
+				status = "okay";
+
+				/* Regulators */
+				AVDD-supply = <&vaux2_reg>;
+				IOVDD-supply = <&vaux2_reg>;
+				DRVDD-supply = <&vaux2_reg>;
+				DVDD-supply = <&vbat>;
+			};
+
 		};
 
 		elm: elm@48080000 {
@@ -311,6 +334,20 @@
 				};
 			};
 		};
+
+		sound {
+			compatible = "ti,da830-evm-audio";
+			ti,model = "DA830 EVM";
+			ti,audio-codec = <&tlv320aic3x>;
+			ti,mcasp-controller = <&mcasp1>;
+			ti,codec-clock-rate = <12000000>;
+			ti,audio-routing =
+				"Headphone Jack",       "HPLOUT",
+				"Headphone Jack",       "HPROUT",
+				"LINE1L",               "Line In",
+				"LINE1R",               "Line In";
+		};
+
 	};
 
 	vbat: fixedregulator@0 {
@@ -378,6 +415,25 @@
 
 #include "tps65910.dtsi"
 
+&mcasp1 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&am335x_evm_audio_pins>;
+
+		status = "okay";
+
+		op-mode = <0>;          /* MCASP_IIS_MODE */
+		tdm-slots = <2>;
+		num-serializer = <16>;
+		serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+			0 0 1 2
+			0 0 0 0
+			0 0 0 0
+			0 0 0 0
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
