From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch v2 2/3] ARM: dts: am437x-sk-evm: Add VPFE and OV2659 entries
Date: Tue, 12 Nov 2019 08:29:28 -0600
Message-ID: <20191112142929.23058-3-bparrot@ti.com>
References: <20191112142929.23058-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112142929.23058-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Add VPFE device nodes entries.
Add OmniVision OV2659 sensor device nodes and linkage.

The sensor clock (xvclk) is sourced from clkout1.
Add clock entries to properly select clkout1 and set its parent
clock to sys_clkin_ck.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 74eaa6a3b258..25222497f828 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -272,6 +272,12 @@
 		>;
 	};
 
+	clkout1_pin: pinmux_clkout1_pin {
+		pinctrl-single,pins = <
+			0x270 (PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* XDMA_EVENT_INTR0/CLKOUT1 */
+		>;
+	};
+
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
@@ -593,6 +599,25 @@
 	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <400000>;
 
+	ov2659@30 {
+		compatible = "ovti,ov2659";
+		reg = <0x30>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&clkout1_pin>;
+
+		clocks = <&clkout1_mux_ck>;
+		clock-names = "xvclk";
+		assigned-clocks = <&clkout1_mux_ck>;
+		assigned-clock-parents = <&clkout1_osc_div_ck>;
+
+		port {
+			ov2659_1: endpoint {
+				remote-endpoint = <&vpfe0_ep>;
+				link-frequencies = /bits/ 64 <70000000>;
+			};
+		};
+	};
+
 	edt-ft5306@38 {
 		status = "okay";
 		compatible = "edt,edt-ft5306", "edt,edt-ft5x06";
@@ -877,7 +902,7 @@
 	/* Camera port */
 	port {
 		vpfe0_ep: endpoint {
-			/* remote-endpoint = <&sensor>; add once we have it */
+			remote-endpoint = <&ov2659_1>;
 			ti,am437x-vpfe-interface = <0>;
 			bus-width = <8>;
 			hsync-active = <0>;
-- 
2.17.1
