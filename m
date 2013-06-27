From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 3/4] ARM: dts: dra7xx clock data
Date: Thu, 27 Jun 2013 11:38:18 +0300
Message-ID: <1372322299-25046-4-git-send-email-t-kristo@ti.com>
References: <1372322299-25046-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35764 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720Ab3F0Ijm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jun 2013 04:39:42 -0400
In-Reply-To: <1372322299-25046-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

This patch creates the clock node mapping for DRA7xx.

TODO: 1) include this from base dra7.dtsi file once available
      2) apll_pcie_ck is currently broken, proper support code missing

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra7-clocks.dtsi | 2099 ++++++++++++++++++++++++++++++++++++
 1 file changed, 2099 insertions(+)
 create mode 100644 arch/arm/boot/dts/dra7-clocks.dtsi

diff --git a/arch/arm/boot/dts/dra7-clocks.dtsi b/arch/arm/boot/dts/dra7-clocks.dtsi
new file mode 100644
index 0000000..5b1e107
--- /dev/null
+++ b/arch/arm/boot/dts/dra7-clocks.dtsi
@@ -0,0 +1,2099 @@
+/*
+ * Device Tree Source for DRA7xx Clock data
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* Root clocks */
+atl_clkin0_ck: atl_clkin0_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+atl_clkin1_ck: atl_clkin1_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+atl_clkin2_ck: atl_clkin2_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+atlclkin3_ck: atlclkin3_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+hdmi_clkin_ck: hdmi_clkin_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+mlb_clkin_ck: mlb_clkin_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+mlbp_clkin_ck: mlbp_clkin_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+pciesref_acs_clk_ck: pciesref_acs_clk_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <100000000>;
+};
+
+ref_clkin0_ck: ref_clkin0_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+ref_clkin1_ck: ref_clkin1_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+ref_clkin2_ck: ref_clkin2_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+ref_clkin3_ck: ref_clkin3_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+rmii_clk_ck: rmii_clk_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+sdvenc_clkin_ck: sdvenc_clkin_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+secure_32k_clk_src_ck: secure_32k_clk_src_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <32768>;
+};
+
+sys_32k_ck: sys_32k_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <32768>;
+};
+
+virt_12000000_ck: virt_12000000_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <12000000>;
+};
+
+virt_13000000_ck: virt_13000000_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <13000000>;
+};
+
+virt_16800000_ck: virt_16800000_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <16800000>;
+};
+
+virt_19200000_ck: virt_19200000_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <19200000>;
+};
+
+virt_20000000_ck: virt_20000000_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <20000000>;
+};
+
+virt_26000000_ck: virt_26000000_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <26000000>;
+};
+
+virt_27000000_ck: virt_27000000_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <27000000>;
+};
+
+virt_38400000_ck: virt_38400000_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <38400000>;
+};
+
+sys_clkin1: sys_clkin1@4ae06110 {
+	compatible = "mux-clock";
+	clocks = <&virt_12000000_ck>, <&virt_20000000_ck>, <&virt_16800000_ck>, <&virt_19200000_ck>, <&virt_26000000_ck>, <&virt_27000000_ck>, <&virt_38400000_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae06110 0x4>;
+	bit-mask = <0x7>;
+	index-starts-at-one;
+};
+
+sys_clkin2: sys_clkin2 {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <22579200>;
+};
+
+usb_otg_clkin_ck: usb_otg_clkin_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+video1_clkin_ck: video1_clkin_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+video1_m2_clkin_ck: video1_m2_clkin_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+video2_clkin_ck: video2_clkin_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+video2_m2_clkin_ck: video2_m2_clkin_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+/* Module clocks and DPLL outputs */
+abe_dpll_sys_clk_mux: abe_dpll_sys_clk_mux@4ae06118 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin1>, <&sys_clkin2>;
+	#clock-cells = <0>;
+	reg = <0x4ae06118 0x4>;
+	bit-mask = <0x1>;
+};
+
+abe_dpll_bypass_clk_mux: abe_dpll_bypass_clk_mux@4ae06114 {
+	compatible = "mux-clock";
+	clocks = <&abe_dpll_sys_clk_mux>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae06114 0x4>;
+	bit-mask = <0x1>;
+};
+
+abe_dpll_clk_mux: abe_dpll_clk_mux@4ae0610c {
+	compatible = "mux-clock";
+	clocks = <&abe_dpll_sys_clk_mux>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0610c 0x4>;
+	bit-mask = <0x1>;
+};
+
+/* DPLL_ABE */
+dpll_abe_ck: dpll_abe_ck {
+	clocks = <&abe_dpll_clk_mux>, <&abe_dpll_bypass_clk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a0051e0 0x4>, <0x4a0051e4 0x4>, <0x4a0051e8 0x4>, <0x4a0051ec 0x4>;
+	ti,clk-bypass = <&abe_dpll_bypass_clk_mux>;
+	ti,clk-ref = <&abe_dpll_clk_mux>;
+	compatible = "ti,omap4-dpll-clock";
+	ti,dpll-regm4xen;
+};
+
+dpll_abe_x2_ck: dpll_abe_x2_ck {
+	clocks = <&dpll_abe_ck>;
+	#clock-cells = <0>;
+	compatible = "ti,omap4-dpll-clock";
+	ti,dpll-clk-x2;
+};
+
+dpll_abe_m2x2_ck: dpll_abe_m2x2_ck@4a0051f0 {
+	compatible = "divider-clock";
+	clocks = <&dpll_abe_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0051f0 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+abe_24m_fclk: abe_24m_fclk@4ae0611c {
+	compatible = "divider-clock";
+	clocks = <&dpll_abe_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0611c 0x4>;
+	bit-mask = <0x1>;
+	table = < 8 0 >, < 16 1 >;
+};
+
+abe_clk: abe_clk@4a005108 {
+	compatible = "divider-clock";
+	clocks = <&dpll_abe_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005108 0x4>;
+	bit-mask = <0x3>;
+	index-power-of-two;
+};
+
+aess_fclk: aess_fclk@4ae06178 {
+	compatible = "divider-clock";
+	clocks = <&abe_clk>;
+	#clock-cells = <0>;
+	reg = <0x4ae06178 0x4>;
+	bit-mask = <0x1>;
+};
+
+abe_giclk_div: abe_giclk_div@4ae06174 {
+	compatible = "divider-clock";
+	clocks = <&aess_fclk>;
+	#clock-cells = <0>;
+	reg = <0x4ae06174 0x4>;
+	bit-mask = <0x1>;
+};
+
+abe_lp_clk_div: abe_lp_clk_div@4ae061d8 {
+	compatible = "divider-clock";
+	clocks = <&dpll_abe_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae061d8 0x4>;
+	bit-mask = <0x1>;
+	table = < 16 0 >, < 32 1 >;
+};
+
+abe_sys_clk_div: abe_sys_clk_div@4ae06120 {
+	compatible = "divider-clock";
+	clocks = <&sys_clkin1>;
+	#clock-cells = <0>;
+	reg = <0x4ae06120 0x4>;
+	bit-mask = <0x1>;
+};
+
+adc_gfclk_mux: adc_gfclk_mux@4ae061dc {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin1>, <&sys_clkin2>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae061dc 0x4>;
+	bit-mask = <0x7>;
+};
+
+/* DPLL_PCIE_REF */
+dpll_pcie_ref_ck: dpll_pcie_ref_ck {
+	clocks = <&sys_clkin1>;
+	#clock-cells = <0>;
+	reg = <0x4a008200 0x4>, <0x4a008204 0x4>, <0x4a008208 0x4>, <0x4a00820c 0x4>;
+	ti,clk-bypass = <&sys_clkin1>;
+	ti,clk-ref = <&sys_clkin1>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+dpll_pcie_ref_m2ldo_ck: dpll_pcie_ref_m2ldo_ck@4a008210 {
+	compatible = "divider-clock";
+	clocks = <&dpll_pcie_ref_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008210 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+/* APLL_PCIE */
+/* XXX: apll_pcie_ck is currently broken, needs proper support code for it */
+apll_pcie_ck: apll_pcie_ck {
+	clocks = <&dpll_pcie_ref_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008200 0x4>, <0x4a008204 0x4>, <0x4a008208 0x4>, <0x4a00820c 0x4>;
+	ti,clk-bypass = <&dpll_pcie_ref_ck>;
+	ti,clk-ref = <&dpll_pcie_ref_ck>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+apll_pcie_clkvcoldo: apll_pcie_clkvcoldo {
+	compatible = "fixed-factor-clock";
+	clocks = <&apll_pcie_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+apll_pcie_clkvcoldo_div: apll_pcie_clkvcoldo_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&apll_pcie_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+apll_pcie_m2_ck: apll_pcie_m2_ck@4a008224 {
+	compatible = "divider-clock";
+	clocks = <&apll_pcie_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008224 0x4>;
+	bit-mask = <0x7f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+sys_clk1_dclk_div: sys_clk1_dclk_div@4ae061c8 {
+	compatible = "divider-clock";
+	clocks = <&sys_clkin1>;
+	#clock-cells = <0>;
+	reg = <0x4ae061c8 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+sys_clk2_dclk_div: sys_clk2_dclk_div@4ae061cc {
+	compatible = "divider-clock";
+	clocks = <&sys_clkin2>;
+	#clock-cells = <0>;
+	reg = <0x4ae061cc 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+dpll_abe_m2_ck: dpll_abe_m2_ck@4a0051f0 {
+	compatible = "divider-clock";
+	clocks = <&dpll_abe_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0051f0 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+per_abe_x1_dclk_div: per_abe_x1_dclk_div@4ae061bc {
+	compatible = "divider-clock";
+	clocks = <&dpll_abe_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae061bc 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+dpll_abe_m3x2_ck: dpll_abe_m3x2_ck@4a0051f4 {
+	compatible = "divider-clock";
+	clocks = <&dpll_abe_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0051f4 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+/* DPLL_CORE */
+dpll_core_ck: dpll_core_ck {
+	clocks = <&sys_clkin1>, <&dpll_abe_m3x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005120 0x4>, <0x4a005124 0x4>, <0x4a005128 0x4>, <0x4a00512c 0x4>;
+	ti,clk-bypass = <&dpll_abe_m3x2_ck>;
+	ti,clk-ref = <&sys_clkin1>;
+	compatible = "ti,omap4-dpll-clock";
+	ti,dpll-core;
+};
+
+dpll_core_x2_ck: dpll_core_x2_ck {
+	clocks = <&dpll_core_ck>;
+	#clock-cells = <0>;
+	compatible = "ti,omap4-dpll-clock";
+	ti,dpll-clk-x2;
+};
+
+dpll_core_h12x2_ck: dpll_core_h12x2_ck@4a00513c {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00513c 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+mpu_dpll_hs_clk_div: mpu_dpll_hs_clk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_core_h12x2_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+/* DPLL_MPU */
+dpll_mpu_ck: dpll_mpu_ck {
+	clocks = <&sys_clkin1>, <&mpu_dpll_hs_clk_div>;
+	#clock-cells = <0>;
+	reg = <0x4a005160 0x4>, <0x4a005164 0x4>, <0x4a005168 0x4>, <0x4a00516c 0x4>;
+	ti,clk-bypass = <&mpu_dpll_hs_clk_div>;
+	ti,clk-ref = <&sys_clkin1>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+dpll_mpu_m2_ck: dpll_mpu_m2_ck@4a005170 {
+	compatible = "divider-clock";
+	clocks = <&dpll_mpu_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005170 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+mpu_dclk_div: mpu_dclk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_mpu_m2_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+dsp_dpll_hs_clk_div: dsp_dpll_hs_clk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_core_h12x2_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+/* DPLL_DSP */
+dpll_dsp_ck: dpll_dsp_ck {
+	clocks = <&sys_clkin1>, <&dsp_dpll_hs_clk_div>;
+	#clock-cells = <0>;
+	reg = <0x4a005234 0x4>, <0x4a005238 0x4>, <0x4a00523c 0x4>, <0x4a005240 0x4>;
+	ti,clk-bypass = <&dsp_dpll_hs_clk_div>;
+	ti,clk-ref = <&sys_clkin1>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+dpll_dsp_m2_ck: dpll_dsp_m2_ck@4a005244 {
+	compatible = "divider-clock";
+	clocks = <&dpll_dsp_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005244 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dsp_gclk_div: dsp_gclk_div@4ae0618c {
+	compatible = "divider-clock";
+	clocks = <&dpll_dsp_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0618c 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+iva_dpll_hs_clk_div: iva_dpll_hs_clk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_core_h12x2_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+/* DPLL_IVA */
+dpll_iva_ck: dpll_iva_ck {
+	clocks = <&sys_clkin1>, <&iva_dpll_hs_clk_div>;
+	#clock-cells = <0>;
+	reg = <0x4a0051a0 0x4>, <0x4a0051a4 0x4>, <0x4a0051a8 0x4>, <0x4a0051ac 0x4>;
+	ti,clk-bypass = <&iva_dpll_hs_clk_div>;
+	ti,clk-ref = <&sys_clkin1>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+dpll_iva_m2_ck: dpll_iva_m2_ck@4a0051b0 {
+	compatible = "divider-clock";
+	clocks = <&dpll_iva_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0051b0 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+iva_dclk: iva_dclk {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_iva_m2_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+/* DPLL_GPU */
+dpll_gpu_ck: dpll_gpu_ck {
+	clocks = <&sys_clkin1>, <&dpll_abe_m3x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0052d8 0x4>, <0x4a0052dc 0x4>, <0x4a0052e0 0x4>, <0x4a0052e4 0x4>;
+	ti,clk-bypass = <&dpll_abe_m3x2_ck>;
+	ti,clk-ref = <&sys_clkin1>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+dpll_gpu_m2_ck: dpll_gpu_m2_ck@4a0052e8 {
+	compatible = "divider-clock";
+	clocks = <&dpll_gpu_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0052e8 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+gpu_dclk: gpu_dclk@4ae061a0 {
+	compatible = "divider-clock";
+	clocks = <&dpll_gpu_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae061a0 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+dpll_core_m2_ck: dpll_core_m2_ck@4a005130 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005130 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+core_dpll_out_dclk_div: core_dpll_out_dclk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_core_m2_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+/* DPLL_DDR */
+dpll_ddr_ck: dpll_ddr_ck {
+	clocks = <&sys_clkin1>, <&dpll_abe_m3x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005210 0x4>, <0x4a005214 0x4>, <0x4a005218 0x4>, <0x4a00521c 0x4>;
+	ti,clk-bypass = <&dpll_abe_m3x2_ck>;
+	ti,clk-ref = <&sys_clkin1>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+dpll_ddr_m2_ck: dpll_ddr_m2_ck@4a005220 {
+	compatible = "divider-clock";
+	clocks = <&dpll_ddr_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005220 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+emif_phy_dclk_div: emif_phy_dclk_div@4ae06190 {
+	compatible = "divider-clock";
+	clocks = <&dpll_ddr_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae06190 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+/* DPLL_GMAC */
+dpll_gmac_ck: dpll_gmac_ck {
+	clocks = <&sys_clkin1>, <&dpll_abe_m3x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0052a8 0x4>, <0x4a0052ac 0x4>, <0x4a0052b0 0x4>, <0x4a0052b4 0x4>;
+	ti,clk-bypass = <&dpll_abe_m3x2_ck>;
+	ti,clk-ref = <&sys_clkin1>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+dpll_gmac_m2_ck: dpll_gmac_m2_ck@4a0052b8 {
+	compatible = "divider-clock";
+	clocks = <&dpll_gmac_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0052b8 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+gmac_250m_dclk_div: gmac_250m_dclk_div@4ae0619c {
+	compatible = "divider-clock";
+	clocks = <&dpll_gmac_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0619c 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+video2_dclk_div: video2_dclk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&video2_m2_clkin_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+video1_dclk_div: video1_dclk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&video1_m2_clkin_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+hdmi_dclk_div: hdmi_dclk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&hdmi_clkin_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+per_dpll_hs_clk_div: per_dpll_hs_clk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_abe_m3x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <2>;
+	clock-mult = <1>;
+};
+
+/* DPLL_PER */
+dpll_per_ck: dpll_per_ck {
+	clocks = <&sys_clkin1>, <&per_dpll_hs_clk_div>;
+	#clock-cells = <0>;
+	reg = <0x4a008140 0x4>, <0x4a008144 0x4>, <0x4a008148 0x4>, <0x4a00814c 0x4>;
+	ti,clk-bypass = <&per_dpll_hs_clk_div>;
+	ti,clk-ref = <&sys_clkin1>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+dpll_per_m2_ck: dpll_per_m2_ck@4a008150 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008150 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+func_96m_aon_dclk_div: func_96m_aon_dclk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_per_m2_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+usb_dpll_hs_clk_div: usb_dpll_hs_clk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_abe_m3x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <3>;
+	clock-mult = <1>;
+};
+
+/* DPLL_USB */
+dpll_usb_ck: dpll_usb_ck {
+	clocks = <&sys_clkin1>, <&usb_dpll_hs_clk_div>;
+	#clock-cells = <0>;
+	reg = <0x4a008180 0x4>, <0x4a008184 0x4>, <0x4a008188 0x4>, <0x4a00818c 0x4>;
+	ti,clk-bypass = <&usb_dpll_hs_clk_div>;
+	ti,clk-ref = <&sys_clkin1>;
+	ti,clkdm-name = "coreaon_clkdm";
+	compatible = "ti,omap4-dpll-clock";
+	ti,dpll-j-type;
+};
+
+dpll_usb_m2_ck: dpll_usb_m2_ck@4a008190 {
+	compatible = "divider-clock";
+	clocks = <&dpll_usb_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008190 0x4>;
+	bit-mask = <0x7f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+l3init_480m_dclk_div: l3init_480m_dclk_div@4ae061ac {
+	compatible = "divider-clock";
+	clocks = <&dpll_usb_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae061ac 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+usb_otg_dclk_div: usb_otg_dclk_div@4ae06184 {
+	compatible = "divider-clock";
+	clocks = <&usb_otg_clkin_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae06184 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+sata_dclk_div: sata_dclk_div@4ae061c0 {
+	compatible = "divider-clock";
+	clocks = <&sys_clkin1>;
+	#clock-cells = <0>;
+	reg = <0x4ae061c0 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+dpll_pcie_ref_m2_ck: dpll_pcie_ref_m2_ck@4a008210 {
+	compatible = "divider-clock";
+	clocks = <&dpll_pcie_ref_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008210 0x4>;
+	bit-mask = <0x7f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+pcie2_dclk_div: pcie2_dclk_div@4ae061b8 {
+	compatible = "divider-clock";
+	clocks = <&dpll_pcie_ref_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae061b8 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+pcie_dclk_div: pcie_dclk_div@4ae061b4 {
+	compatible = "divider-clock";
+	clocks = <&apll_pcie_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae061b4 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+emu_dclk_div: emu_dclk_div@4ae06194 {
+	compatible = "divider-clock";
+	clocks = <&sys_clkin1>;
+	#clock-cells = <0>;
+	reg = <0x4ae06194 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+secure_32k_dclk_div: secure_32k_dclk_div@4ae061c4 {
+	compatible = "divider-clock";
+	clocks = <&secure_32k_clk_src_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae061c4 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+eve_dpll_hs_clk_div: eve_dpll_hs_clk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_core_h12x2_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+/* DPLL_EVE */
+dpll_eve_ck: dpll_eve_ck {
+	clocks = <&sys_clkin1>, <&eve_dpll_hs_clk_div>;
+	#clock-cells = <0>;
+	reg = <0x4a005284 0x4>, <0x4a005288 0x4>, <0x4a00528c 0x4>, <0x4a005290 0x4>;
+	ti,clk-bypass = <&eve_dpll_hs_clk_div>;
+	ti,clk-ref = <&sys_clkin1>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+dpll_eve_m2_ck: dpll_eve_m2_ck@4a005294 {
+	compatible = "divider-clock";
+	clocks = <&dpll_eve_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005294 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+eve_dclk_div: eve_dclk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_eve_m2_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+clkoutmux0_clk_mux: clkoutmux0_clk_mux@4ae06158 {
+	compatible = "mux-clock";
+	clocks = <&sys_clk1_dclk_div>, <&sys_clk2_dclk_div>, <&per_abe_x1_dclk_div>, <&mpu_dclk_div>, <&dsp_gclk_div>, <&iva_dclk>, <&gpu_dclk>, <&core_dpll_out_dclk_div>, <&emif_phy_dclk_div>, <&gmac_250m_dclk_div>, <&video2_dclk_div>, <&video1_dclk_div>, <&hdmi_dclk_div>, <&func_96m_aon_dclk_div>, <&l3init_480m_dclk_div>, <&usb_otg_dclk_div>, <&sata_dclk_div>, <&pcie2_dclk_div>, <&pcie_dclk_div>, <&emu_dclk_div>, <&secure_32k_dclk_div>, <&eve_dclk_div>;
+	#clock-cells = <0>;
+	reg = <0x4ae06158 0x4>;
+	bit-mask = <0x1f>;
+};
+
+clkoutmux1_clk_mux: clkoutmux1_clk_mux@4ae0615c {
+	compatible = "mux-clock";
+	clocks = <&sys_clk1_dclk_div>, <&sys_clk2_dclk_div>, <&per_abe_x1_dclk_div>, <&mpu_dclk_div>, <&dsp_gclk_div>, <&iva_dclk>, <&gpu_dclk>, <&core_dpll_out_dclk_div>, <&emif_phy_dclk_div>, <&gmac_250m_dclk_div>, <&video2_dclk_div>, <&video1_dclk_div>, <&hdmi_dclk_div>, <&func_96m_aon_dclk_div>, <&l3init_480m_dclk_div>, <&usb_otg_dclk_div>, <&sata_dclk_div>, <&pcie2_dclk_div>, <&pcie_dclk_div>, <&emu_dclk_div>, <&secure_32k_dclk_div>, <&eve_dclk_div>;
+	#clock-cells = <0>;
+	reg = <0x4ae0615c 0x4>;
+	bit-mask = <0x1f>;
+};
+
+clkoutmux2_clk_mux: clkoutmux2_clk_mux@4ae06160 {
+	compatible = "mux-clock";
+	clocks = <&sys_clk1_dclk_div>, <&sys_clk2_dclk_div>, <&per_abe_x1_dclk_div>, <&mpu_dclk_div>, <&dsp_gclk_div>, <&iva_dclk>, <&gpu_dclk>, <&core_dpll_out_dclk_div>, <&emif_phy_dclk_div>, <&gmac_250m_dclk_div>, <&video2_dclk_div>, <&video1_dclk_div>, <&hdmi_dclk_div>, <&func_96m_aon_dclk_div>, <&l3init_480m_dclk_div>, <&usb_otg_dclk_div>, <&sata_dclk_div>, <&pcie2_dclk_div>, <&pcie_dclk_div>, <&emu_dclk_div>, <&secure_32k_dclk_div>, <&eve_dclk_div>;
+	#clock-cells = <0>;
+	reg = <0x4ae06160 0x4>;
+	bit-mask = <0x1f>;
+};
+
+custefuse_sys_gfclk_div: custefuse_sys_gfclk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&sys_clkin1>;
+	#clock-cells = <0>;
+	clock-div = <2>;
+	clock-mult = <1>;
+};
+
+dpll_core_h13x2_ck: dpll_core_h13x2_ck@4a005140 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005140 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_core_h14x2_ck: dpll_core_h14x2_ck@4a005144 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005144 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_core_h22x2_ck: dpll_core_h22x2_ck@4a005154 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005154 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_core_h23x2_ck: dpll_core_h23x2_ck@4a005158 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005158 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_core_h24x2_ck: dpll_core_h24x2_ck@4a00515c {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00515c 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_ddr_x2_ck: dpll_ddr_x2_ck {
+	clocks = <&dpll_ddr_ck>;
+	#clock-cells = <0>;
+	compatible = "ti,omap4-dpll-clock";
+	ti,dpll-clk-x2;
+};
+
+dpll_ddr_h11x2_ck: dpll_ddr_h11x2_ck@4a005228 {
+	compatible = "divider-clock";
+	clocks = <&dpll_ddr_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005228 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_dsp_x2_ck: dpll_dsp_x2_ck {
+	clocks = <&dpll_dsp_ck>;
+	#clock-cells = <0>;
+	compatible = "ti,omap4-dpll-clock";
+	ti,dpll-clk-x2;
+};
+
+dpll_dsp_m3x2_ck: dpll_dsp_m3x2_ck@4a005248 {
+	compatible = "divider-clock";
+	clocks = <&dpll_dsp_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005248 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_gmac_x2_ck: dpll_gmac_x2_ck {
+	clocks = <&dpll_gmac_ck>;
+	#clock-cells = <0>;
+	compatible = "ti,omap4-dpll-clock";
+	ti,dpll-clk-x2;
+};
+
+dpll_gmac_h11x2_ck: dpll_gmac_h11x2_ck@4a0052c0 {
+	compatible = "divider-clock";
+	clocks = <&dpll_gmac_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0052c0 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_gmac_h12x2_ck: dpll_gmac_h12x2_ck@4a0052c4 {
+	compatible = "divider-clock";
+	clocks = <&dpll_gmac_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0052c4 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_gmac_h13x2_ck: dpll_gmac_h13x2_ck@4a0052c8 {
+	compatible = "divider-clock";
+	clocks = <&dpll_gmac_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0052c8 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_gmac_m3x2_ck: dpll_gmac_m3x2_ck@4a0052bc {
+	compatible = "divider-clock";
+	clocks = <&dpll_gmac_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0052bc 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_per_x2_ck: dpll_per_x2_ck {
+	clocks = <&dpll_per_ck>;
+	#clock-cells = <0>;
+	compatible = "ti,omap4-dpll-clock";
+	ti,dpll-clk-x2;
+};
+
+dpll_per_h11x2_ck: dpll_per_h11x2_ck@4a008158 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008158 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_per_h12x2_ck: dpll_per_h12x2_ck@4a00815c {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00815c 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_per_h13x2_ck: dpll_per_h13x2_ck@4a008160 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008160 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_per_h14x2_ck: dpll_per_h14x2_ck@4a008164 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008164 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_per_m2x2_ck: dpll_per_m2x2_ck@4a008150 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008150 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_usb_clkdcoldo: dpll_usb_clkdcoldo {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_usb_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+eve_clk: eve_clk@4ae06180 {
+	compatible = "mux-clock";
+	clocks = <&dpll_eve_m2_ck>, <&dpll_dsp_m3x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae06180 0x4>;
+	bit-mask = <0x1>;
+};
+
+func_128m_clk: func_128m_clk {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_per_h11x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <2>;
+	clock-mult = <1>;
+};
+
+func_12m_fclk: func_12m_fclk {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <16>;
+	clock-mult = <1>;
+};
+
+func_24m_clk: func_24m_clk {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_per_m2_ck>;
+	#clock-cells = <0>;
+	clock-div = <4>;
+	clock-mult = <1>;
+};
+
+func_48m_fclk: func_48m_fclk {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <4>;
+	clock-mult = <1>;
+};
+
+func_96m_fclk: func_96m_fclk {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <2>;
+	clock-mult = <1>;
+};
+
+gmii_m_clk_div: gmii_m_clk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_gmac_h11x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <2>;
+	clock-mult = <1>;
+};
+
+hdmi_clk2_div: hdmi_clk2_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&hdmi_clkin_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+hdmi_div_clk: hdmi_div_clk {
+	compatible = "fixed-factor-clock";
+	clocks = <&hdmi_clkin_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+hdmi_dpll_clk_mux: hdmi_dpll_clk_mux@4ae061a4 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin1>, <&sys_clkin2>;
+	#clock-cells = <0>;
+	reg = <0x4ae061a4 0x4>;
+	bit-mask = <0x7>;
+};
+
+l3_iclk_div: l3_iclk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_core_h12x2_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+l3init_60m_fclk: l3init_60m_fclk@4a008104 {
+	compatible = "divider-clock";
+	clocks = <&dpll_usb_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008104 0x4>;
+	bit-mask = <0x1>;
+	table = < 1 0 >, < 8 1 >;
+};
+
+l4_root_clk_div: l4_root_clk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&l3_iclk_div>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+mlb_clk: mlb_clk@4ae06134 {
+	compatible = "divider-clock";
+	clocks = <&mlb_clkin_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae06134 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+mlbp_clk: mlbp_clk@4ae06130 {
+	compatible = "divider-clock";
+	clocks = <&mlbp_clkin_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae06130 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+per_abe_x1_gfclk2_div: per_abe_x1_gfclk2_div@4ae06138 {
+	compatible = "divider-clock";
+	clocks = <&dpll_abe_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae06138 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+timer_sys_clk_div: timer_sys_clk_div@4ae06144 {
+	compatible = "divider-clock";
+	clocks = <&sys_clkin1>;
+	#clock-cells = <0>;
+	reg = <0x4ae06144 0x4>;
+	bit-mask = <0x1>;
+};
+
+video1_clk2_div: video1_clk2_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&video1_clkin_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+video1_div_clk: video1_div_clk {
+	compatible = "fixed-factor-clock";
+	clocks = <&video1_clkin_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+video1_dpll_clk_mux: video1_dpll_clk_mux@4ae061d0 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin1>, <&sys_clkin2>;
+	#clock-cells = <0>;
+	reg = <0x4ae061d0 0x4>;
+	bit-mask = <0x7>;
+};
+
+video2_clk2_div: video2_clk2_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&video2_clkin_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+video2_div_clk: video2_div_clk {
+	compatible = "fixed-factor-clock";
+	clocks = <&video2_clkin_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+video2_dpll_clk_mux: video2_dpll_clk_mux@4ae061d4 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin1>, <&sys_clkin2>;
+	#clock-cells = <0>;
+	reg = <0x4ae061d4 0x4>;
+	bit-mask = <0x7>;
+};
+
+wkupaon_iclk_mux: wkupaon_iclk_mux@4ae06108 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin1>, <&abe_lp_clk_div>;
+	#clock-cells = <0>;
+	reg = <0x4ae06108 0x4>;
+	bit-mask = <0x1>;
+};
+
+/* Leaf clocks controlled by modules */
+dss_32khz_clk: dss_32khz_clk@4a009120 {
+	compatible = "gate-clock";
+	reg = <0x4a009120 0x4>;
+	bit-shift = <11>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+dss_48mhz_clk: dss_48mhz_clk@4a009120 {
+	compatible = "gate-clock";
+	reg = <0x4a009120 0x4>;
+	bit-shift = <9>;
+	clocks = <&func_48m_fclk>;
+	#clock-cells = <0>;
+};
+
+dss_dss_clk: dss_dss_clk@4a009120 {
+	compatible = "gate-clock";
+	reg = <0x4a009120 0x4>;
+	bit-shift = <8>;
+	clocks = <&dpll_per_h12x2_ck>;
+	#clock-cells = <0>;
+};
+
+dss_hdmi_clk: dss_hdmi_clk@4a009120 {
+	compatible = "gate-clock";
+	reg = <0x4a009120 0x4>;
+	bit-shift = <10>;
+	clocks = <&hdmi_dpll_clk_mux>;
+	#clock-cells = <0>;
+};
+
+dss_video1_clk: dss_video1_clk@4a009120 {
+	compatible = "gate-clock";
+	reg = <0x4a009120 0x4>;
+	bit-shift = <12>;
+	clocks = <&video1_dpll_clk_mux>;
+	#clock-cells = <0>;
+};
+
+dss_video2_clk: dss_video2_clk@4a009120 {
+	compatible = "gate-clock";
+	reg = <0x4a009120 0x4>;
+	bit-shift = <13>;
+	clocks = <&video2_dpll_clk_mux>;
+	#clock-cells = <0>;
+};
+
+gpio1_dbclk: gpio1_dbclk@4ae07838 {
+	compatible = "gate-clock";
+	reg = <0x4ae07838 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio2_dbclk: gpio2_dbclk@4a009760 {
+	compatible = "gate-clock";
+	reg = <0x4a009760 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio3_dbclk: gpio3_dbclk@4a009768 {
+	compatible = "gate-clock";
+	reg = <0x4a009768 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio4_dbclk: gpio4_dbclk@4a009770 {
+	compatible = "gate-clock";
+	reg = <0x4a009770 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio5_dbclk: gpio5_dbclk@4a009778 {
+	compatible = "gate-clock";
+	reg = <0x4a009778 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio6_dbclk: gpio6_dbclk@4a009780 {
+	compatible = "gate-clock";
+	reg = <0x4a009780 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio7_dbclk: gpio7_dbclk@4a009810 {
+	compatible = "gate-clock";
+	reg = <0x4a009810 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio8_dbclk: gpio8_dbclk@4a009818 {
+	compatible = "gate-clock";
+	reg = <0x4a009818 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+mmc1_clk32k: mmc1_clk32k@4a009328 {
+	compatible = "gate-clock";
+	reg = <0x4a009328 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+mmc2_clk32k: mmc2_clk32k@4a009330 {
+	compatible = "gate-clock";
+	reg = <0x4a009330 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+mmc3_clk32k: mmc3_clk32k@4a009820 {
+	compatible = "gate-clock";
+	reg = <0x4a009820 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+mmc4_clk32k: mmc4_clk32k@4a009828 {
+	compatible = "gate-clock";
+	reg = <0x4a009828 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+sata_ref_clk: sata_ref_clk@4a009388 {
+	compatible = "gate-clock";
+	reg = <0x4a009388 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_clkin1>;
+	#clock-cells = <0>;
+};
+
+usb_otg_ss1_refclk960m: usb_otg_ss1_refclk960m@4a0093f0 {
+	compatible = "gate-clock";
+	reg = <0x4a0093f0 0x4>;
+	bit-shift = <8>;
+	clocks = <&dpll_usb_clkdcoldo>;
+	#clock-cells = <0>;
+};
+
+usb_otg_ss2_refclk960m: usb_otg_ss2_refclk960m@4a009340 {
+	compatible = "gate-clock";
+	reg = <0x4a009340 0x4>;
+	bit-shift = <8>;
+	clocks = <&dpll_usb_clkdcoldo>;
+	#clock-cells = <0>;
+};
+
+usb_phy1_always_on_clk32k: usb_phy1_always_on_clk32k@4a008640 {
+	compatible = "gate-clock";
+	reg = <0x4a008640 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+usb_phy2_always_on_clk32k: usb_phy2_always_on_clk32k@4a008688 {
+	compatible = "gate-clock";
+	reg = <0x4a008688 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+usb_phy3_always_on_clk32k: usb_phy3_always_on_clk32k@4a008698 {
+	compatible = "gate-clock";
+	reg = <0x4a008698 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+/* Remaining optional clocks */
+atl_dpll_clk_mux: atl_dpll_clk_mux@4a008c00 {
+	compatible = "mux-clock";
+	clocks = <&sys_32k_ck>, <&video1_clkin_ck>, <&video2_clkin_ck>, <&hdmi_clkin_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008c00 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+};
+
+atl_gfclk_mux: atl_gfclk_mux@4a008c00 {
+	compatible = "mux-clock";
+	clocks = <&l3_iclk_div>, <&dpll_abe_m2_ck>, <&atl_dpll_clk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a008c00 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <26>;
+};
+
+dcan1_sys_clk_mux: dcan1_sys_clk_mux@4ae07888 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin1>, <&sys_clkin2>;
+	#clock-cells = <0>;
+	reg = <0x4ae07888 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+gmac_gmii_ref_clk_div: gmac_gmii_ref_clk_div@4a0093d0 {
+	compatible = "divider-clock";
+	clocks = <&dpll_gmac_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0093d0 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	table = < 2 0 >;
+};
+
+gmac_rft_clk_mux: gmac_rft_clk_mux@4a0093d0 {
+	compatible = "mux-clock";
+	clocks = <&video1_clkin_ck>, <&video2_clkin_ck>, <&dpll_abe_m2_ck>, <&hdmi_clkin_ck>, <&l3_iclk_div>;
+	#clock-cells = <0>;
+	reg = <0x4a0093d0 0x4>;
+	bit-mask = <0x7>;
+	bit-shift = <25>;
+};
+
+gpu_core_gclk_mux: gpu_core_gclk_mux@4a009220 {
+	compatible = "mux-clock";
+	clocks = <&dpll_core_h14x2_ck>, <&dpll_per_h14x2_ck>, <&dpll_gpu_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009220 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+};
+
+gpu_hyd_gclk_mux: gpu_hyd_gclk_mux@4a009220 {
+	compatible = "mux-clock";
+	clocks = <&dpll_core_h14x2_ck>, <&dpll_per_h14x2_ck>, <&dpll_gpu_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009220 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <26>;
+};
+
+ipu1_gfclk_mux: ipu1_gfclk_mux@4a005520 {
+	compatible = "mux-clock";
+	clocks = <&dpll_abe_m2x2_ck>, <&dpll_core_h22x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005520 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+l3instr_ts_gclk_div: l3instr_ts_gclk_div@4a008e50 {
+	compatible = "divider-clock";
+	clocks = <&wkupaon_iclk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a008e50 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+	table = < 8 0 >, < 16 1 >, < 32 2 >;
+};
+
+mcasp1_ahclkr_mux: mcasp1_ahclkr_mux@4a005550 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a005550 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <28>;
+};
+
+mcasp1_ahclkx_mux: mcasp1_ahclkx_mux@4a005550 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a005550 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+mcasp1_aux_gfclk_mux: mcasp1_aux_gfclk_mux@4a005550 {
+	compatible = "mux-clock";
+	clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
+	#clock-cells = <0>;
+	reg = <0x4a005550 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <22>;
+};
+
+mcasp2_ahclkr_mux: mcasp2_ahclkr_mux@4a009860 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009860 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <28>;
+};
+
+mcasp2_ahclkx_mux: mcasp2_ahclkx_mux@4a009860 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009860 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <28>;
+};
+
+mcasp2_aux_gfclk_mux: mcasp2_aux_gfclk_mux@4a009860 {
+	compatible = "mux-clock";
+	clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
+	#clock-cells = <0>;
+	reg = <0x4a009860 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <22>;
+};
+
+mcasp3_ahclkx_mux: mcasp3_ahclkx_mux@4a009868 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009868 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+mcasp3_aux_gfclk_mux: mcasp3_aux_gfclk_mux@4a009868 {
+	compatible = "mux-clock";
+	clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
+	#clock-cells = <0>;
+	reg = <0x4a009868 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <22>;
+};
+
+mcasp4_ahclkx_mux: mcasp4_ahclkx_mux@4a009898 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009898 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+mcasp4_aux_gfclk_mux: mcasp4_aux_gfclk_mux@4a009898 {
+	compatible = "mux-clock";
+	clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
+	#clock-cells = <0>;
+	reg = <0x4a009898 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <22>;
+};
+
+mcasp5_ahclkx_mux: mcasp5_ahclkx_mux@4a009878 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009878 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+mcasp5_aux_gfclk_mux: mcasp5_aux_gfclk_mux@4a009878 {
+	compatible = "mux-clock";
+	clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
+	#clock-cells = <0>;
+	reg = <0x4a009878 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <22>;
+};
+
+mcasp6_ahclkx_mux: mcasp6_ahclkx_mux@4a009904 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009904 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+mcasp6_aux_gfclk_mux: mcasp6_aux_gfclk_mux@4a009904 {
+	compatible = "mux-clock";
+	clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
+	#clock-cells = <0>;
+	reg = <0x4a009904 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <22>;
+};
+
+mcasp7_ahclkx_mux: mcasp7_ahclkx_mux@4a009908 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009908 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+mcasp7_aux_gfclk_mux: mcasp7_aux_gfclk_mux@4a009908 {
+	compatible = "mux-clock";
+	clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
+	#clock-cells = <0>;
+	reg = <0x4a009908 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <22>;
+};
+
+mcasp8_ahclk_mux: mcasp8_ahclk_mux@4a009890 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009890 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <22>;
+};
+
+mcasp8_aux_gfclk_mux: mcasp8_aux_gfclk_mux@4a009890 {
+	compatible = "mux-clock";
+	clocks = <&per_abe_x1_gfclk2_div>, <&video1_clk2_div>, <&video2_clk2_div>, <&hdmi_clk2_div>;
+	#clock-cells = <0>;
+	reg = <0x4a009890 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+mmc1_fclk_mux: mmc1_fclk_mux@4a009328 {
+	compatible = "mux-clock";
+	clocks = <&func_128m_clk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009328 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+mmc1_fclk_div: mmc1_fclk_div@4a009328 {
+	compatible = "divider-clock";
+	clocks = <&mmc1_fclk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a009328 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <25>;
+	index-power-of-two;
+};
+
+mmc2_fclk_mux: mmc2_fclk_mux@4a009330 {
+	compatible = "mux-clock";
+	clocks = <&func_128m_clk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009330 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+mmc2_fclk_div: mmc2_fclk_div@4a009330 {
+	compatible = "divider-clock";
+	clocks = <&mmc2_fclk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a009330 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <25>;
+	index-power-of-two;
+};
+
+mmc3_gfclk_mux: mmc3_gfclk_mux@4a009820 {
+	compatible = "mux-clock";
+	clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009820 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+mmc3_gfclk_div: mmc3_gfclk_div@4a009820 {
+	compatible = "divider-clock";
+	clocks = <&mmc3_gfclk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a009820 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <25>;
+	index-power-of-two;
+};
+
+mmc4_gfclk_mux: mmc4_gfclk_mux@4a009828 {
+	compatible = "mux-clock";
+	clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009828 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+mmc4_gfclk_div: mmc4_gfclk_div@4a009828 {
+	compatible = "divider-clock";
+	clocks = <&mmc4_gfclk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a009828 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <25>;
+	index-power-of-two;
+};
+
+qspi_gfclk_mux: qspi_gfclk_mux@4a009838 {
+	compatible = "mux-clock";
+	clocks = <&func_128m_clk>, <&dpll_per_h13x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009838 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+qspi_gfclk_div: qspi_gfclk_div@4a009838 {
+	compatible = "divider-clock";
+	clocks = <&qspi_gfclk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a009838 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <25>;
+	index-power-of-two;
+};
+
+timer10_gfclk_mux: timer10_gfclk_mux@4a009728 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009728 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+timer11_gfclk_mux: timer11_gfclk_mux@4a009730 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009730 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+timer13_gfclk_mux: timer13_gfclk_mux@4a0097c8 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a0097c8 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+timer14_gfclk_mux: timer14_gfclk_mux@4a0097d0 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a0097d0 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+timer15_gfclk_mux: timer15_gfclk_mux@4a0097d8 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a0097d8 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+timer16_gfclk_mux: timer16_gfclk_mux@4a009830 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009830 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+timer1_gfclk_mux: timer1_gfclk_mux@4ae07840 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+	#clock-cells = <0>;
+	reg = <0x4ae07840 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+timer2_gfclk_mux: timer2_gfclk_mux@4a009738 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009738 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+timer3_gfclk_mux: timer3_gfclk_mux@4a009740 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009740 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+timer4_gfclk_mux: timer4_gfclk_mux@4a009748 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009748 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+timer5_gfclk_mux: timer5_gfclk_mux@4a005558 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a005558 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+timer6_gfclk_mux: timer6_gfclk_mux@4a005560 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a005560 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+timer7_gfclk_mux: timer7_gfclk_mux@4a005568 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a005568 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+timer8_gfclk_mux: timer8_gfclk_mux@4a005570 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>, <&clkoutmux0_clk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a005570 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+timer9_gfclk_mux: timer9_gfclk_mux@4a009750 {
+	compatible = "mux-clock";
+	clocks = <&timer_sys_clk_div>, <&sys_32k_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&abe_giclk_div>, <&video1_div_clk>, <&video2_div_clk>, <&hdmi_div_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a009750 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <24>;
+};
+
+uart10_gfclk_mux: uart10_gfclk_mux@4ae07880 {
+	compatible = "mux-clock";
+	clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae07880 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+uart1_gfclk_mux: uart1_gfclk_mux@4a009840 {
+	compatible = "mux-clock";
+	clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009840 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+uart2_gfclk_mux: uart2_gfclk_mux@4a009848 {
+	compatible = "mux-clock";
+	clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009848 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+uart3_gfclk_mux: uart3_gfclk_mux@4a009850 {
+	compatible = "mux-clock";
+	clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009850 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+uart4_gfclk_mux: uart4_gfclk_mux@4a009858 {
+	compatible = "mux-clock";
+	clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009858 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+uart5_gfclk_mux: uart5_gfclk_mux@4a009870 {
+	compatible = "mux-clock";
+	clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009870 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+uart6_gfclk_mux: uart6_gfclk_mux@4a005580 {
+	compatible = "mux-clock";
+	clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a005580 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+uart7_gfclk_mux: uart7_gfclk_mux@4a0098d0 {
+	compatible = "mux-clock";
+	clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0098d0 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+uart8_gfclk_mux: uart8_gfclk_mux@4a0098e0 {
+	compatible = "mux-clock";
+	clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0098e0 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+uart9_gfclk_mux: uart9_gfclk_mux@4a0098e8 {
+	compatible = "mux-clock";
+	clocks = <&func_48m_fclk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0098e8 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+vip1_gclk_mux: vip1_gclk_mux@4a009020 {
+	compatible = "mux-clock";
+	clocks = <&l3_iclk_div>, <&dpll_core_h23x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009020 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+vip2_gclk_mux: vip2_gclk_mux@4a009028 {
+	compatible = "mux-clock";
+	clocks = <&l3_iclk_div>, <&dpll_core_h23x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009028 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+vip3_gclk_mux: vip3_gclk_mux@4a009030 {
+	compatible = "mux-clock";
+	clocks = <&l3_iclk_div>, <&dpll_core_h23x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009030 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
-- 
1.7.9.5

