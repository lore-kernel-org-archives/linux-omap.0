From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3] ARM: dts: dra7: Correct clock tree for sys_32k_ck
Date: Mon, 4 Apr 2016 11:07:15 +0530
Message-ID: <1459748235-27232-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lokeshvutla@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

This is w.r.t J6/J6eco: 32clk is pseudo (erratum i856) - clock source.
Errata i856 for the AM572x (DRA7xx) points out that the 32.768KHz external
crystal is not enabled at power up. Instead the CPU falls back to using
an emulation for the 32KHz clock which is SYSCLK1/610.  SYSCLK1 is usually
20MHz on boards so far (which gives an emulated frequency of 32.786KHz)

Modelling the same in device tree.

Acked-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Errata Document: http://www.ti.com/lit/er/sprz429h/sprz429h.pdf
Errata number: i856

Tested the debugfs clock tree nodes on DRA7-EVM.

Changes in v3:

  Rebased to 4.6-rc2
  Tested on top of omap-for-v4.6/fixes-rc1 branch and the patch applied
  cleanly.
 
Changes in v2:

  Added missing Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

 arch/arm/boot/dts/dra7xx-clocks.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index d0bae06..ef2164a 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -98,12 +98,20 @@
 		clock-frequency = <32768>;
 	};
 
-	sys_32k_ck: sys_32k_ck {
+	sys_clk32_crystal_ck: sys_clk32_crystal_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 	};
 
+	sys_clk32_pseudo_ck: sys_clk32_pseudo_ck {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clocks = <&sys_clkin1>;
+		clock-mult = <1>;
+		clock-div = <610>;
+	};
+
 	virt_12000000_ck: virt_12000000_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -2170,4 +2178,12 @@
 		ti,bit-shift = <22>;
 		reg = <0x0558>;
 	};
+
+	sys_32k_ck: sys_32k_ck {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&sys_clk32_crystal_ck>, <&sys_clk32_pseudo_ck>, <&sys_clk32_pseudo_ck>, <&sys_clk32_pseudo_ck>;
+		ti,bit-shift = <8>;
+		reg = <0x6c4>;
+	};
 };
-- 
1.9.1
