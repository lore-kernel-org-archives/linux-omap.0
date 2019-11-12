From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch v3 02/10] ARM: dts: dra7: add cam clkctrl node
Date: Tue, 12 Nov 2019 08:27:45 -0600
Message-ID: <20191112142753.22976-3-bparrot@ti.com>
References: <20191112142753.22976-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112142753.22976-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Add clkctrl nodes for CAM domain.

Note that because of the current dts node name dependency for mapping to
clock domain, we must still use "cam-clkctrl@" naming instead of generic
"clock@" naming for the node. And because of this, it's probably best to
apply the dts node addition together along with the other clock changes.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index d1c2406ec71c..199f8d483f75 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1734,6 +1734,20 @@
 		};
 	};
 
+	cam_cm: cam-cm@1000 {
+		compatible = "ti,omap4-cm";
+		reg = <0x1000 0x100>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x1000 0x100>;
+
+		cam_clkctrl: cam-clkctrl@20 {
+			compatible = "ti,clkctrl";
+			reg = <0x20 0x2c>;
+			#clock-cells = <2>;
+		};
+	};
+
 	dss_cm: dss-cm@1100 {
 		compatible = "ti,omap4-cm";
 		reg = <0x1100 0x100>;
-- 
2.17.1
