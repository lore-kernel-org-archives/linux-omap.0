From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v4 3/3] arm: dts: omap3-gta04: Add handling for tv output
Date: Wed,  3 Dec 2014 22:33:22 +0100
Message-ID: <1417642402-20538-4-git-send-email-marek@goldelico.com>
References: <1417642402-20538-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417642402-20538-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: plagnioj@jcrosoft.com, tony@atomide.com, bcousson@baylibre.com, hns@goldelico.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Add handling for gta04 tv out chain:
venc -> opa362 -> svideo

Use invert-polarity in venc node because opa362
is doing polarity inversion also.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index fd34f91..a6e995b 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -83,6 +83,41 @@
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
 	};
+
+	tv0: connector@1 {
+		compatible = "svideo-connector";
+		label = "tv";
+
+		port {
+			tv_connector_in: endpoint {
+				remote-endpoint = <&opa_out>;
+			};
+		};
+	};
+
+	tv_amp: opa362 {
+		compatible = "ti,opa362";
+		enable-gpios = <&gpio1 23 0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				opa_in: endpoint@0 {
+					remote-endpoint = <&venc_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				opa_out: endpoint@0 {
+					remote-endpoint = <&tv_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &omap3_pmx_core {
@@ -396,6 +431,20 @@
 	};
 };
 
+&venc {
+	status = "okay";
+
+	vdda-supply = <&vdac>;
+
+	port {
+		venc_out: endpoint {
+			remote-endpoint = <&opa_in>;
+			ti,channels = <2>;
+			ti,invert-polarity;
+		};
+	};
+};
+
 &gpmc {
 	ranges = <0 0 0x30000000 0x04>; /* CS0: NAND */
 
-- 
1.9.1
