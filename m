From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v5 11/12] ARM/dts: am335x-evmsk: Audio support
Date: Fri, 18 Oct 2013 18:37:50 +0300
Message-ID: <d4261eb9f47a699bf331586b085a4ec174064f1c.1382110090.git.jsarha@ti.com>
References: <cover.1382110089.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48904 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756284Ab3JRPiQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Oct 2013 11:38:16 -0400
In-Reply-To: <cover.1382110089.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, bcousson@baylibre.com, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, joelf@ti.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

AM335x EVM-SK have only support for audio playback (stereo jack on the
board) via tlv320aic3106 codec connected to McASP1.
Enable the support for audio playback on the board:
- McASP1 configuration
- tlv320aic3106 configuration
- Machine driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts |   48 ++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 4f339fa..9e570fb 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -158,6 +158,15 @@
 				0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
 			>;
 		};
+
+		mcasp1_pins: mcasp1_pins {
+			pinctrl-single,pins = <
+				0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
+				0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rxerr.mcasp1_fsx */
+				0x108 (PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* mii1_col.mcasp1_axr2 */
+				0x144 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
+			>;
+		};
 	};
 
 	ocp {
@@ -206,6 +215,18 @@
 				st,max-limit-y = <550>;
 				st,max-limit-z = <750>;
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
 
 		musb: usb@47400000 {
@@ -233,6 +254,17 @@
 				pinctrl-0 = <&ecap2_pins>;
 			};
 		};
+
+		sound {
+			compatible = "ti,da830-evm-audio";
+			ti,model = "AM335x-EVMSK";
+			ti,audio-codec = <&tlv320aic3106>;
+			ti,mcasp-controller = <&mcasp1>;
+			ti,codec-clock-rate = <24576000>;
+			ti,audio-routing =
+				"Headphone Jack",       "HPLOUT",
+				"Headphone Jack",       "HPROUT";
+		};
 	};
 
 	vbat: fixedregulator@0 {
@@ -419,3 +451,19 @@
 	phy_id = <&davinci_mdio>, <1>;
 	phy-mode = "rgmii-txid";
 };
+
+&mcasp1 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&mcasp1_pins>;
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
-- 
1.7.9.5

