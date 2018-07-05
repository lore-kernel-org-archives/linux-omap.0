From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v4 5/6] ARM: dts: Add generic interconnect target module node for MCAN
Date: Thu, 5 Jul 2018 19:53:18 +0530
Message-ID: <20180705142319.19583-6-faiz_abbas@ti.com>
References: <20180705142319.19583-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705142319.19583-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: robh+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, mark.rutland@arm.com, faiz_abbas@ti.com
List-Id: linux-omap@vger.kernel.org

The ti-sysc driver provides support for manipulating the idle modes
and interconnect level resets.

Add the generic interconnect target module node for MCAN to support
the same.

CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/dra76x.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index bfc82636999c..5157cc431574 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -11,6 +11,24 @@
 / {
 	compatible = "ti,dra762", "ti,dra7";
 
+	ocp {
+		target-module@42c01900 {
+			compatible = "ti,sysc-dra7-mcan", "ti,sysc";
+			ranges = <0x0 0x42c00000 0x2000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x42c01900 0x4>,
+			      <0x42c01904 0x4>,
+			      <0x42c01908 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-mask = <(SYSC_OMAP4_SOFTRESET |
+					 SYSC_DRA7_MCAN_ENAWAKEUP)>;
+			ti,syss-mask = <1>;
+			clocks = <&wkupaon_clkctrl DRA7_ADC_CLKCTRL 0>;
+			clock-names = "fck";
+		};
+	};
+
 };
 
 /* MCAN interrupts are hard-wired to irqs 67, 68 */
-- 
2.17.0
