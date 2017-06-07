From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/6] ARM: dts: omap54xx-clocks: Set IVA DPLL and its output
 clock rates
Date: Wed, 7 Jun 2017 16:27:26 -0500
Message-ID: <20170607212730.33002-3-s-anna@ti.com>
References: <20170607212730.33002-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170607212730.33002-1-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <t-kristo@ti.com>, Subhajit Paul <subhajit_paul@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The IVA DPLL is not an essential DPLL for the functionality of a
bootloader and is usually not configured (e.g. older u-boots configure
it only if CONFIG_SYS_CLOCKS_ENABLE_ALL is enabled and u-boots newer
than 2014.01 do not even have an option), and this results in incorrect
operating frequencies when trying to use a DSP or IVAHD, whose root
clocks are derived from this DPLL. Use the DT standard properties
"assigned-clocks" and "assigned-clock-rates" to set the IVA DPLL clock
rate and the rates for its derivative clocks at boot time to properly
initialize/lock this DPLL. The DPLL will automatically transition
into a low-power stop mode when the associated output clocks are
not utilized or gated automatically.

The reset values of the dividers H11 & H12 (functional clocks for DSP
and IVAHD respectively) are identical to each other, but are different
at each OPP. The reset values also do not match a specific OPP. So, the
derived output clocks from the IVA DPLL have to be initialized as well
to avoid initializing these divider outputs to incorrect frequencies.

The clock rates are chosen based on the OPP_NOM values as defined in
the OMAP5432 SR2.0 Data Manual Book vK, section 5.2.3.5 "DPLL_IVA
Preferred Settings". The recommended maximum DPLL locked frequency is
2330 MHz for OPP_NOM (value for DPLL_IVA_X2_CLK), so the dpll_iva_ck
clock rate used is half of this value. The value 465.92 MHz is used
instead of 465.9 MHz for dpll_iva_h11x2_ck so that proper divider
value can be calculated.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap54xx-clocks.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap54xx-clocks.dtsi b/arch/arm/boot/dts/omap54xx-clocks.dtsi
index 4899c2359d0a..529193442620 100644
--- a/arch/arm/boot/dts/omap54xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap54xx-clocks.dtsi
@@ -315,6 +315,8 @@
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin>, <&dpll_iva_byp_mux>;
 		reg = <0x01a0>, <0x01a4>, <0x01ac>, <0x01a8>;
+		assigned-clocks = <&dpll_iva_ck>;
+		assigned-clock-rates = <1165000000>;
 	};
 
 	dpll_iva_x2_ck: dpll_iva_x2_ck {
@@ -330,6 +332,8 @@
 		ti,max-div = <63>;
 		reg = <0x01b8>;
 		ti,index-starts-at-one;
+		assigned-clocks = <&dpll_iva_h11x2_ck>;
+		assigned-clock-rates = <465920000>;
 	};
 
 	dpll_iva_h12x2_ck: dpll_iva_h12x2_ck@1bc {
@@ -339,6 +343,8 @@
 		ti,max-div = <63>;
 		reg = <0x01bc>;
 		ti,index-starts-at-one;
+		assigned-clocks = <&dpll_iva_h12x2_ck>;
+		assigned-clock-rates = <388300000>;
 	};
 
 	mpu_dpll_hs_clk_div: mpu_dpll_hs_clk_div {
-- 
2.12.0
