From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v5 1/6] ARM: dts: dra762: Add MCAN clock support
Date: Mon, 9 Jul 2018 22:18:36 +0530
Message-ID: <20180709164841.14182-2-faiz_abbas@ti.com>
References: <20180709164841.14182-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180709164841.14182-1-faiz_abbas@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: mark.rutland@arm.com, paul@pwsan.com, tony@atomide.com, faiz_abbas@ti.com, t-kristo@ti.com, sboyd@kernel.org, robh+dt@kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

MCAN is clocked by H14 divider of DPLL_GMAC. Unlike other
DPLL dividers this DPLL_GMAC H14 divider is controlled by
control module. Adding support for these clocks.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm/boot/dts/dra76x.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index 1c88c581ff18..bfc82636999c 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -17,3 +17,36 @@
 &crossbar_mpu {
 	ti,irqs-skip = <10 67 68 133 139 140>;
 };
+
+&scm_conf_clocks {
+	dpll_gmac_h14x2_ctrl_ck: dpll_gmac_h14x2_ctrl_ck@3fc {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&dpll_gmac_x2_ck>;
+		ti,max-div = <63>;
+		reg = <0x03fc>;
+		ti,bit-shift=<20>;
+		ti,latch-bit=<26>;
+		assigned-clocks = <&dpll_gmac_h14x2_ctrl_ck>;
+		assigned-clock-rates = <80000000>;
+	};
+
+	dpll_gmac_h14x2_ctrl_mux_ck: dpll_gmac_h14x2_ctrl_mux_ck@3fc {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&dpll_gmac_ck>, <&dpll_gmac_h14x2_ctrl_ck>;
+		reg = <0x3fc>;
+		ti,bit-shift = <29>;
+		ti,latch-bit=<26>;
+		assigned-clocks = <&dpll_gmac_h14x2_ctrl_mux_ck>;
+		assigned-clock-parents = <&dpll_gmac_h14x2_ctrl_ck>;
+	};
+
+	mcan_clk: mcan_clk@3fc {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&dpll_gmac_h14x2_ctrl_mux_ck>;
+		ti,bit-shift = <27>;
+		reg = <0x3fc>;
+	};
+};
-- 
2.17.0
