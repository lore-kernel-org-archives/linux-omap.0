From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 4/6] ARM: dts: dra7xx-clocks: Set DSP DPLL and its output
 clock rates
Date: Wed, 7 Jun 2017 16:27:28 -0500
Message-ID: <20170607212730.33002-5-s-anna@ti.com>
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

The DSP DPLL is a new DPLL compared to previous OMAP generations and
supplies the root clocks for the DSP processors, as well as a mux
input source for EVE sub-system (on applicable SoCs). This DPLL is
currently not configured by older bootloaders. Use the DT standard
properties "assigned-clocks" and "assigned-clock-rates" to set the
DSP DPLL clock rate and the rates for its derivative clocks at boot
time to properly initialize/lock this DPLL and be independent of the
bootloader version. Newer u-boots (from 2017.01 onwards) reuse and
can update these properties to choose an appropriate one-time fixed
OPP configuration. The DPLL will automatically transition into a
low-power stop mode when the associated output clocks are not
utilized or gated automatically.

The DSP DPLL provides two output clocks, DSP_GFCLK and EVE_GCLK. The
desired rate for DSP_GFCLK is 600 MHz (same as DSP DPLL CLKOUT frequency),
and is currently auto set due to the desired M2 divider value being the
same as reset value for the locked frequency of 600 MHz. The EVE_GCLK
however is required to be 400 MHz, so set the dpll_dsp_m3x2_ck's rate
explicitly so that the divider is set properly. The dpll_dsp_m2_ck rate
is also set explicitly to not rely on any implicit matching divider reset
values to the locked DPLL frequency.

The OPP_NOM clock frequencies are defined in the AM572x SR2.0 Data
Sheet vB, section 5.5.2 "Voltage And Core Clock Specifications". The
clock rates are chosen based on these OPP_NOM values and defined as per
a DRA7xx PLL spec document. The DPLL locked frequency is 1200 MHz, so
the dpll_dsp_ck clock rate used is half of this value.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index cfaf27215901..8a82490035d9 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -338,6 +338,8 @@
 		compatible = "ti,omap4-dpll-clock";
 		clocks = <&sys_clkin1>, <&dpll_dsp_byp_mux>;
 		reg = <0x0234>, <0x0238>, <0x0240>, <0x023c>;
+		assigned-clocks = <&dpll_dsp_ck>;
+		assigned-clock-rates = <600000000>;
 	};
 
 	dpll_dsp_m2_ck: dpll_dsp_m2_ck@244 {
@@ -349,6 +351,8 @@
 		reg = <0x0244>;
 		ti,index-starts-at-one;
 		ti,invert-autoidle-bit;
+		assigned-clocks = <&dpll_dsp_m2_ck>;
+		assigned-clock-rates = <600000000>;
 	};
 
 	iva_dpll_hs_clk_div: iva_dpll_hs_clk_div {
@@ -659,6 +663,8 @@
 		reg = <0x0248>;
 		ti,index-starts-at-one;
 		ti,invert-autoidle-bit;
+		assigned-clocks = <&dpll_dsp_m3x2_ck>;
+		assigned-clock-rates = <400000000>;
 	};
 
 	dpll_gmac_x2_ck: dpll_gmac_x2_ck {
-- 
2.12.0
