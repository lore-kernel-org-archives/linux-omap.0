From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Add clocks for dm814x ADPLL
Date: Fri, 12 Feb 2016 13:21:58 -0800
Message-ID: <1455312118-963-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

These use the standard clock bindings and now we can make some
of the fixed clocks into real clocks.

Note that the clock output names may become optional as we
probably want to eventually use descriptive names, or use
just dynamically generated names as suggested by Tero.

Acked-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm814x-clocks.dtsi | 256 ++++++++++++++++++++++++++++++-----
 arch/arm/boot/dts/dra62x-clocks.dtsi |  26 ++++
 2 files changed, 251 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/dm814x-clocks.dtsi b/arch/arm/boot/dts/dm814x-clocks.dtsi
index 2600158..cdceda9 100644
--- a/arch/arm/boot/dts/dm814x-clocks.dtsi
+++ b/arch/arm/boot/dts/dm814x-clocks.dtsi
@@ -4,6 +4,170 @@
  * published by the Free Software Foundation.
  */
 
+&pllss {
+	/*
+	 * See TRM "2.6.10 Connected outputso DPLLS" and
+	 * "2.6.11 Connected Outputs of DPLLJ". Only clkout is
+	 * connected except for hdmi and usb.
+	 */
+	adpll_mpu_ck: adpll@40 {
+		#clock-cells = <1>;
+		compatible = "ti,dm814-adpll-s-clock";
+		reg = <0x40 0x40>;
+		clocks = <&devosc_ck &devosc_ck &devosc_ck>;
+		clock-names = "clkinp", "clkinpulow", "clkinphif";
+		clock-indices = <0>, <1>, <2>, <3>;
+		clock-output-names = "481c5040.adpll.dcoclkldo",
+				     "481c5040.adpll.clkout",
+				     "481c5040.adpll.clkoutx2",
+				     "481c5040.adpll.clkouthif";
+	};
+
+	adpll_dsp_ck: adpll@80 {
+		#clock-cells = <1>;
+		compatible = "ti,dm814-adpll-lj-clock";
+		reg = <0x80 0x30>;
+		clocks = <&devosc_ck &devosc_ck>;
+		clock-names = "clkinp", "clkinpulow";
+		clock-indices = <0>, <1>, <2>;
+		clock-output-names = "481c5080.adpll.dcoclkldo",
+				     "481c5080.adpll.clkout",
+				     "481c5080.adpll.clkoutldo";
+	};
+
+	adpll_sgx_ck: adpll@b0 {
+		#clock-cells = <1>;
+		compatible = "ti,dm814-adpll-lj-clock";
+		reg = <0xb0 0x30>;
+		clocks = <&devosc_ck &devosc_ck>;
+		clock-names = "clkinp", "clkinpulow";
+		clock-indices = <0>, <1>, <2>;
+		clock-output-names = "481c50b0.adpll.dcoclkldo",
+				     "481c50b0.adpll.clkout",
+				     "481c50b0.adpll.clkoutldo";
+	};
+
+	adpll_hdvic_ck: adpll@e0 {
+		#clock-cells = <1>;
+		compatible = "ti,dm814-adpll-lj-clock";
+		reg = <0xe0 0x30>;
+		clocks = <&devosc_ck &devosc_ck>;
+		clock-names = "clkinp", "clkinpulow";
+		clock-indices = <0>, <1>, <2>;
+		clock-output-names = "481c50e0.adpll.dcoclkldo",
+				     "481c50e0.adpll.clkout",
+				     "481c50e0.adpll.clkoutldo";
+	};
+
+	adpll_l3_ck: adpll@110 {
+		#clock-cells = <1>;
+		compatible = "ti,dm814-adpll-lj-clock";
+		reg = <0x110 0x30>;
+		clocks = <&devosc_ck &devosc_ck>;
+		clock-names = "clkinp", "clkinpulow";
+		clock-indices = <0>, <1>, <2>;
+		clock-output-names = "481c5110.adpll.dcoclkldo",
+				     "481c5110.adpll.clkout",
+				     "481c5110.adpll.clkoutldo";
+	};
+
+	adpll_isp_ck: adpll@140 {
+		#clock-cells = <1>;
+		compatible = "ti,dm814-adpll-lj-clock";
+		reg = <0x140 0x30>;
+		clocks = <&devosc_ck &devosc_ck>;
+		clock-names = "clkinp", "clkinpulow";
+		clock-indices = <0>, <1>, <2>;
+		clock-output-names = "481c5140.adpll.dcoclkldo",
+				     "481c5140.adpll.clkout",
+				     "481c5140.adpll.clkoutldo";
+	};
+
+	adpll_dss_ck: adpll@170 {
+		#clock-cells = <1>;
+		compatible = "ti,dm814-adpll-lj-clock";
+		reg = <0x170 0x30>;
+		clocks = <&devosc_ck &devosc_ck>;
+		clock-names = "clkinp", "clkinpulow";
+		clock-indices = <0>, <1>, <2>;
+		clock-output-names = "481c5170.adpll.dcoclkldo",
+				     "481c5170.adpll.clkout",
+				     "481c5170.adpll.clkoutldo";
+	};
+
+	adpll_video0_ck: adpll@1a0 {
+		#clock-cells = <1>;
+		compatible = "ti,dm814-adpll-lj-clock";
+		reg = <0x1a0 0x30>;
+		clocks = <&devosc_ck &devosc_ck>;
+		clock-names = "clkinp", "clkinpulow";
+		clock-indices = <0>, <1>, <2>;
+		clock-output-names = "481c51a0.adpll.dcoclkldo",
+				     "481c51a0.adpll.clkout",
+				     "481c51a0.adpll.clkoutldo";
+	};
+
+	adpll_video1_ck: adpll@1d0 {
+		#clock-cells = <1>;
+		compatible = "ti,dm814-adpll-lj-clock";
+		reg = <0x1d0 0x30>;
+		clocks = <&devosc_ck &devosc_ck>;
+		clock-names = "clkinp", "clkinpulow";
+		clock-indices = <0>, <1>, <2>;
+		clock-output-names = "481c51d0.adpll.dcoclkldo",
+				     "481c51d0.adpll.clkout",
+				     "481c51d0.adpll.clkoutldo";
+	};
+
+	adpll_hdmi_ck: adpll@200 {
+		#clock-cells = <1>;
+		compatible = "ti,dm814-adpll-lj-clock";
+		reg = <0x200 0x30>;
+		clocks = <&devosc_ck &devosc_ck>;
+		clock-names = "clkinp", "clkinpulow";
+		clock-indices = <0>, <1>, <2>;
+		clock-output-names = "481c5200.adpll.dcoclkldo",
+				     "481c5200.adpll.clkout",
+				     "481c5200.adpll.clkoutldo";
+	};
+
+	adpll_audio_ck: adpll@230 {
+		#clock-cells = <1>;
+		compatible = "ti,dm814-adpll-lj-clock";
+		reg = <0x230 0x30>;
+		clocks = <&devosc_ck &devosc_ck>;
+		clock-names = "clkinp", "clkinpulow";
+		clock-indices = <0>, <1>, <2>;
+		clock-output-names = "481c5230.adpll.dcoclkldo",
+				     "481c5230.adpll.clkout",
+				     "481c5230.adpll.clkoutldo";
+	};
+
+	adpll_usb_ck: adpll@260 {
+		#clock-cells = <1>;
+		compatible = "ti,dm814-adpll-lj-clock";
+		reg = <0x260 0x30>;
+		clocks = <&devosc_ck &devosc_ck>;
+		clock-names = "clkinp", "clkinpulow";
+		clock-indices = <0>, <1>, <2>;
+		clock-output-names = "481c5260.adpll.dcoclkldo",
+				     "481c5260.adpll.clkout",
+				     "481c5260.adpll.clkoutldo";
+	};
+
+	adpll_ddr_ck: adpll@290 {
+		#clock-cells = <1>;
+		compatible = "ti,dm814-adpll-lj-clock";
+		reg = <0x290 0x30>;
+		clocks = <&devosc_ck &devosc_ck>;
+		clock-names = "clkinp", "clkinpulow";
+		clock-indices = <0>, <1>, <2>;
+		clock-output-names = "481c5290.adpll.dcoclkldo",
+				     "481c5290.adpll.clkout",
+				     "481c5290.adpll.clkoutldo";
+	};
+};
+
 &pllss_clocks {
 	timer1_fck: timer1_fck {
 		#clock-cells = <0>;
@@ -23,6 +187,24 @@
 		reg = <0x2e0>;
 	};
 
+	/* CPTS_RFT_CLK in RMII_REFCLK_SRC, usually sourced from auiod */
+	cpsw_cpts_rft_clk: cpsw_cpts_rft_clk {
+		#clock-cells = <0>;
+		compatible = "ti,mux-clock";
+		clocks = <&adpll_video0_ck 1
+			  &adpll_video1_ck 1
+			  &adpll_audio_ck 1>;
+		ti,bit-shift = <1>;
+		reg = <0x2e8>;
+	};
+
+	/* REVISIT: Set up with a proper mux using RMII_REFCLK_SRC */
+	cpsw_125mhz_gclk: cpsw_125mhz_gclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+	};
+
 	sysclk18_ck: sysclk18_ck {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
@@ -79,37 +261,6 @@
 		compatible = "fixed-clock";
 		clock-frequency = <1000000000>;
 	};
-
-	sysclk4_ck: sysclk4_ck {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <222000000>;
-	};
-
-	sysclk6_ck: sysclk6_ck {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <100000000>;
-	};
-
-	sysclk10_ck: sysclk10_ck {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <48000000>;
-	};
-
-        cpsw_125mhz_gclk: cpsw_125mhz_gclk {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <125000000>;
-	};
-
-	cpsw_cpts_rft_clk: cpsw_cpts_rft_clk {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <250000000>;
-	};
-
 };
 
 &prcm_clocks {
@@ -138,6 +289,49 @@
 		clock-div = <78125>;
 	};
 
+	/* L4_HS 220 MHz*/
+	sysclk4_ck: sysclk4_ck {
+		#clock-cells = <0>;
+		compatible = "ti,fixed-factor-clock";
+		clocks = <&adpll_l3_ck 1>;
+		ti,clock-mult = <1>;
+		ti,clock-div = <1>;
+	};
+
+	/* L4_FWCFG */
+	sysclk5_ck: sysclk5_ck {
+		#clock-cells = <0>;
+		compatible = "ti,fixed-factor-clock";
+		clocks = <&adpll_l3_ck 1>;
+		ti,clock-mult = <1>;
+		ti,clock-div = <2>;
+	};
+
+	/* L4_LS 110 MHz */
+	sysclk6_ck: sysclk6_ck {
+		#clock-cells = <0>;
+		compatible = "ti,fixed-factor-clock";
+		clocks = <&adpll_l3_ck 1>;
+		ti,clock-mult = <1>;
+		ti,clock-div = <2>;
+	};
+
+	sysclk8_ck: sysclk8_ck {
+		#clock-cells = <0>;
+		compatible = "ti,fixed-factor-clock";
+		clocks = <&adpll_usb_ck 1>;
+		ti,clock-mult = <1>;
+		ti,clock-div = <1>;
+	};
+
+	sysclk10_ck: sysclk10_ck {
+		compatible = "ti,divider-clock";
+		reg = <0x324>;
+		ti,max-div = <7>;
+		#clock-cells = <0>;
+		clocks = <&adpll_usb_ck 1>;
+	};
+
 	aud_clkin0_ck: aud_clkin0_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
diff --git a/arch/arm/boot/dts/dra62x-clocks.dtsi b/arch/arm/boot/dts/dra62x-clocks.dtsi
index 6f98dc8..0e49741 100644
--- a/arch/arm/boot/dts/dra62x-clocks.dtsi
+++ b/arch/arm/boot/dts/dra62x-clocks.dtsi
@@ -6,6 +6,32 @@
 
 #include "dm814x-clocks.dtsi"
 
+/* Compared to dm814x, dra62x does not have hdic, l3 or dss PLLs */
+&adpll_hdvic_ck {
+	status = "disabled";
+};
+
+&adpll_l3_ck {
+	status = "disabled";
+};
+
+&adpll_dss_ck {
+	status = "disabled";
+};
+
+/* Compared to dm814x, dra62x has interconnect clocks on isp PLL */
+&sysclk4_ck {
+	clocks = <&adpll_isp_ck 1>;
+};
+
+&sysclk5_ck {
+	clocks = <&adpll_isp_ck 1>;
+};
+
+&sysclk6_ck {
+	clocks = <&adpll_isp_ck 1>;
+};
+
 /*
  * Compared to dm814x, dra62x has different shifts and more mux options.
  * Please add the extra options for ysclk_14 and 16 if really needed.
-- 
2.7.0
