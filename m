From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v4.2 09/10] ARM/dts: am335x-evm: Add audio support for am335x-evm.dts
Date: Wed, 9 Oct 2013 17:32:54 +0300
Message-ID: <1381329174-9556-1-git-send-email-jsarha@ti.com>
References: <1381322701-8851-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36634 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab3JIOdJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 10:33:09 -0400
In-Reply-To: <1381322701-8851-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, mark.rutland@arm.com, joelf@ti.com, Darren Etheridge <detheridge@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>

From: Darren Etheridge <detheridge@ti.com>

Adds sound, tlv320aic3106, mcasp1, and am335x_evm_audio_pin nodes.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   51 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e8ec875..814b3e9 100644
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
@@ -244,6 +254,18 @@
 				compatible = "ti,tmp275";
 				reg = <0x48>;
 			};
+
+			tlv320aic3106: tlv320aic3106@1b {
+				compatible = "ti,tlv320aic3106";
+				reg = <0x1b>;
+				status = "okay";
+
+				/* Regulators */
+				AVDD-supply = <&vaux2_reg>;
+				IOVDD-supply = <&vaux2_reg>;
+				DRVDD-supply = <&vaux2_reg>;
+				DVDD-supply = <&vbat>;
+			};
 		};
 
 		elm: elm@48080000 {
@@ -340,6 +362,19 @@
 				};
 			};
 		};
+
+		sound {
+			compatible = "ti,da830-evm-audio";
+			ti,model = "AM335x-EVM";
+			ti,audio-codec = <&tlv320aic3106>;
+			ti,mcasp-controller = <&mcasp1>;
+			ti,codec-clock-rate = <12000000>;
+			ti,audio-routing =
+				"Headphone Jack",       "HPLOUT",
+				"Headphone Jack",       "HPROUT",
+				"LINE1L",               "Line In",
+				"LINE1R",               "Line In";
+		};
 	};
 
 	vbat: fixedregulator@0 {
@@ -407,6 +442,22 @@
 
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

