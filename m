From: Benoit Parrot <bparrot@ti.com>
Subject: [Patch v2 3/5] ARM: dts: dra7: add vpe clkctrl node
Date: Mon, 4 Nov 2019 14:38:39 -0600
Message-ID: <20191104203841.3628-4-bparrot@ti.com>
References: <20191104203841.3628-1-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191104203841.3628-1-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
List-Id: linux-omap@vger.kernel.org

Add clkctrl nodes for VPE module.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 93e1eb83bed9..d1c2406ec71c 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -1591,10 +1591,10 @@
 
 	rtc_cm: rtc-cm@700 {
 		compatible = "ti,omap4-cm";
-		reg = <0x700 0x100>;
+		reg = <0x700 0x60>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0 0x700 0x100>;
+		ranges = <0 0x700 0x60>;
 
 		rtc_clkctrl: rtc-clkctrl@20 {
 			compatible = "ti,clkctrl";
@@ -1603,6 +1603,20 @@
 		};
 	};
 
+	vpe_cm: vpe-cm@760 {
+		compatible = "ti,omap4-cm";
+		reg = <0x760 0xc>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x760 0xc>;
+
+		vpe_clkctrl: vpe-clkctrl@0 {
+			compatible = "ti,clkctrl";
+			reg = <0x0 0xc>;
+			#clock-cells = <2>;
+		};
+	};
+
 };
 
 &cm_core {
-- 
2.17.1
