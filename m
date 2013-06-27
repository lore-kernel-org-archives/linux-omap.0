From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/4] ARM: dts: omap5 clock data
Date: Thu, 27 Jun 2013 11:38:16 +0300
Message-ID: <1372322299-25046-2-git-send-email-t-kristo@ti.com>
References: <1372322299-25046-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34670 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3F0Ijf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jun 2013 04:39:35 -0400
In-Reply-To: <1372322299-25046-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

This patch creates the clock node mapping for OMAP5, and includes it to
the base omap5.dtsi file.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap5-clocks.dtsi | 1442 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi        |    2 +
 2 files changed, 1444 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap5-clocks.dtsi

diff --git a/arch/arm/boot/dts/omap5-clocks.dtsi b/arch/arm/boot/dts/omap5-clocks.dtsi
new file mode 100644
index 0000000..5767195
--- /dev/null
+++ b/arch/arm/boot/dts/omap5-clocks.dtsi
@@ -0,0 +1,1442 @@
+/*
+ * Device Tree Source for OMAP5 clock data
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* Root clocks */
+pad_clks_src_ck: pad_clks_src_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <12000000>;
+};
+
+pad_clks_ck: pad_clks_ck@4a004108 {
+	compatible = "gate-clock";
+	reg = <0x4a004108 0x4>;
+	bit-shift = <8>;
+	clocks = <&pad_clks_src_ck>;
+	#clock-cells = <0>;
+};
+
+secure_32k_clk_src_ck: secure_32k_clk_src_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <32768>;
+};
+
+slimbus_src_clk: slimbus_src_clk {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <12000000>;
+};
+
+slimbus_clk: slimbus_clk@4a004108 {
+	compatible = "gate-clock";
+	reg = <0x4a004108 0x4>;
+	bit-shift = <10>;
+	clocks = <&slimbus_src_clk>;
+	#clock-cells = <0>;
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
+sys_clkin: sys_clkin@4ae06110 {
+	compatible = "mux-clock";
+	clocks = <&virt_12000000_ck>, <&virt_13000000_ck>, <&virt_16800000_ck>, <&virt_19200000_ck>, <&virt_26000000_ck>, <&virt_27000000_ck>, <&virt_38400000_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae06110 0x4>;
+	bit-mask = <0x7>;
+	index-starts-at-one;
+};
+
+xclk60mhsp1_ck: xclk60mhsp1_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <60000000>;
+};
+
+xclk60mhsp2_ck: xclk60mhsp2_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <60000000>;
+};
+
+/* Module clocks and DPLL outputs */
+abe_dpll_bypass_clk_mux: abe_dpll_bypass_clk_mux@4ae06108 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae06108 0x4>;
+	bit-mask = <0x1>;
+};
+
+abe_dpll_clk_mux: abe_dpll_clk_mux@4ae0610c {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0610c 0x4>;
+	bit-mask = <0x1>;
+};
+
+/* DPLL_ABE */
+dpll_abe_ck: dpll_abe_ck {
+	clocks = <&abe_dpll_clk_mux>, <&abe_dpll_bypass_clk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a0041e0 0x4>, <0x4a0041e4 0x4>, <0x4a0041e8 0x4>, <0x4a0041ec 0x4>;
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
+dpll_abe_m2x2_ck: dpll_abe_m2x2_ck@4a0041f0 {
+	compatible = "divider-clock";
+	clocks = <&dpll_abe_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0041f0 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+abe_24m_fclk: abe_24m_fclk {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_abe_m2x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <8>;
+	clock-mult = <1>;
+};
+
+abe_clk: abe_clk@4a004108 {
+	compatible = "divider-clock";
+	clocks = <&dpll_abe_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004108 0x4>;
+	bit-mask = <0x3>;
+	index-power-of-two;
+};
+
+abe_iclk: abe_iclk {
+	compatible = "fixed-factor-clock";
+	clocks = <&abe_clk>;
+	#clock-cells = <0>;
+	clock-div = <2>;
+	clock-mult = <1>;
+};
+
+abe_lp_clk_div: abe_lp_clk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_abe_m2x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <16>;
+	clock-mult = <1>;
+};
+
+dpll_abe_m3x2_ck: dpll_abe_m3x2_ck@4a0041f4 {
+	compatible = "divider-clock";
+	clocks = <&dpll_abe_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0041f4 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+/* DPLL_CORE */
+dpll_core_ck: dpll_core_ck {
+	clocks = <&sys_clkin>, <&dpll_abe_m3x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004120 0x4>, <0x4a004124 0x4>, <0x4a004128 0x4>, <0x4a00412c 0x4>;
+	ti,clk-bypass = <&dpll_abe_m3x2_ck>;
+	ti,clk-ref = <&sys_clkin>;
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
+dpll_core_h21x2_ck: dpll_core_h21x2_ck@4a004150 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004150 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+c2c_fclk: c2c_fclk {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_core_h21x2_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+c2c_iclk: c2c_iclk {
+	compatible = "fixed-factor-clock";
+	clocks = <&c2c_fclk>;
+	#clock-cells = <0>;
+	clock-div = <2>;
+	clock-mult = <1>;
+};
+
+custefuse_sys_gfclk_div: custefuse_sys_gfclk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&sys_clkin>;
+	#clock-cells = <0>;
+	clock-div = <2>;
+	clock-mult = <1>;
+};
+
+dpll_core_h11x2_ck: dpll_core_h11x2_ck@4a004138 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004138 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_core_h12x2_ck: dpll_core_h12x2_ck@4a00413c {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00413c 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_core_h13x2_ck: dpll_core_h13x2_ck@4a004140 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004140 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_core_h14x2_ck: dpll_core_h14x2_ck@4a004144 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004144 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_core_h22x2_ck: dpll_core_h22x2_ck@4a004154 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004154 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_core_h23x2_ck: dpll_core_h23x2_ck@4a004158 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004158 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_core_h24x2_ck: dpll_core_h24x2_ck@4a00415c {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00415c 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_core_m2_ck: dpll_core_m2_ck@4a004130 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004130 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_core_m3x2_ck: dpll_core_m3x2_ck@4a004134 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004134 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
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
+	clocks = <&sys_clkin>, <&iva_dpll_hs_clk_div>;
+	#clock-cells = <0>;
+	reg = <0x4a0041a0 0x4>, <0x4a0041a4 0x4>, <0x4a0041a8 0x4>, <0x4a0041ac 0x4>;
+	ti,clk-bypass = <&iva_dpll_hs_clk_div>;
+	ti,clk-ref = <&sys_clkin>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+dpll_iva_x2_ck: dpll_iva_x2_ck {
+	clocks = <&dpll_iva_ck>;
+	#clock-cells = <0>;
+	compatible = "ti,omap4-dpll-clock";
+	ti,dpll-clk-x2;
+};
+
+dpll_iva_h11x2_ck: dpll_iva_h11x2_ck@4a0041b8 {
+	compatible = "divider-clock";
+	clocks = <&dpll_iva_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0041b8 0x4>;
+	bit-mask = <0x3f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_iva_h12x2_ck: dpll_iva_h12x2_ck@4a0041bc {
+	compatible = "divider-clock";
+	clocks = <&dpll_iva_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0041bc 0x4>;
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
+	clocks = <&sys_clkin>, <&mpu_dpll_hs_clk_div>;
+	#clock-cells = <0>;
+	reg = <0x4a004160 0x4>, <0x4a004164 0x4>, <0x4a004168 0x4>, <0x4a00416c 0x4>;
+	ti,clk-bypass = <&mpu_dpll_hs_clk_div>;
+	ti,clk-ref = <&sys_clkin>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+dpll_mpu_m2_ck: dpll_mpu_m2_ck@4a004170 {
+	compatible = "divider-clock";
+	clocks = <&dpll_mpu_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004170 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
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
+	clocks = <&sys_clkin>, <&per_dpll_hs_clk_div>;
+	#clock-cells = <0>;
+	reg = <0x4a008140 0x4>, <0x4a008144 0x4>, <0x4a008148 0x4>, <0x4a00814c 0x4>;
+	ti,clk-bypass = <&per_dpll_hs_clk_div>;
+	ti,clk-ref = <&sys_clkin>;
+	compatible = "ti,omap4-dpll-clock";
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
+dpll_per_m3x2_ck: dpll_per_m3x2_ck@4a008154 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008154 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+/* DPLL_UNIPRO1 */
+dpll_unipro1_ck: dpll_unipro1_ck {
+	clocks = <&sys_clkin>;
+	#clock-cells = <0>;
+	reg = <0x4a008200 0x4>, <0x4a008204 0x4>, <0x4a008208 0x4>, <0x4a00820c 0x4>;
+	ti,clk-bypass = <&sys_clkin>;
+	ti,clk-ref = <&sys_clkin>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+dpll_unipro1_clkdcoldo: dpll_unipro1_clkdcoldo {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_unipro1_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+dpll_unipro1_m2_ck: dpll_unipro1_m2_ck@4a008210 {
+	compatible = "divider-clock";
+	clocks = <&dpll_unipro1_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008210 0x4>;
+	bit-mask = <0x7f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+/* DPLL_UNIPRO2 */
+dpll_unipro2_ck: dpll_unipro2_ck {
+	clocks = <&sys_clkin>;
+	#clock-cells = <0>;
+	reg = <0x4a0081c0 0x4>, <0x4a0081c4 0x4>, <0x4a0081c8 0x4>, <0x4a0081cc 0x4>;
+	ti,clk-bypass = <&sys_clkin>;
+	ti,clk-ref = <&sys_clkin>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+dpll_unipro2_clkdcoldo: dpll_unipro2_clkdcoldo {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_unipro2_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+dpll_unipro2_m2_ck: dpll_unipro2_m2_ck@4a0081d0 {
+	compatible = "divider-clock";
+	clocks = <&dpll_unipro2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0081d0 0x4>;
+	bit-mask = <0x7f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
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
+	clocks = <&sys_clkin>, <&usb_dpll_hs_clk_div>;
+	#clock-cells = <0>;
+	reg = <0x4a008180 0x4>, <0x4a008184 0x4>, <0x4a008188 0x4>, <0x4a00818c 0x4>;
+	ti,clk-bypass = <&usb_dpll_hs_clk_div>;
+	ti,clk-ref = <&sys_clkin>;
+	ti,clkdm-name = "l3init_clkdm";
+	compatible = "ti,omap4-dpll-clock";
+	ti,dpll-j-type;
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
+dss_syc_gfclk_div: dss_syc_gfclk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&sys_clkin>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
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
+l3_iclk_div: l3_iclk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_core_h12x2_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+gpu_l3_iclk: gpu_l3_iclk {
+	compatible = "fixed-factor-clock";
+	clocks = <&l3_iclk_div>;
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
+wkupaon_iclk_mux: wkupaon_iclk_mux@4ae06108 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin>, <&abe_lp_clk_div>;
+	#clock-cells = <0>;
+	reg = <0x4ae06108 0x4>;
+	bit-mask = <0x1>;
+};
+
+l3instr_ts_gclk_div: l3instr_ts_gclk_div {
+	compatible = "fixed-factor-clock";
+	clocks = <&wkupaon_iclk_mux>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
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
+/* Leaf clocks controlled by modules */
+dss_32khz_clk: dss_32khz_clk@4a009420 {
+	compatible = "gate-clock";
+	reg = <0x4a009420 0x4>;
+	bit-shift = <11>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+dss_48mhz_clk: dss_48mhz_clk@4a009420 {
+	compatible = "gate-clock";
+	reg = <0x4a009420 0x4>;
+	bit-shift = <9>;
+	clocks = <&func_48m_fclk>;
+	#clock-cells = <0>;
+};
+
+dss_dss_clk: dss_dss_clk@4a009420 {
+	compatible = "gate-clock";
+	reg = <0x4a009420 0x4>;
+	bit-shift = <8>;
+	clocks = <&dpll_per_h12x2_ck>;
+	#clock-cells = <0>;
+};
+
+dss_sys_clk: dss_sys_clk@4a009420 {
+	compatible = "gate-clock";
+	reg = <0x4a009420 0x4>;
+	bit-shift = <10>;
+	clocks = <&dss_syc_gfclk_div>;
+	#clock-cells = <0>;
+};
+
+gpio1_dbclk: gpio1_dbclk@4ae07938 {
+	compatible = "gate-clock";
+	reg = <0x4ae07938 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio2_dbclk: gpio2_dbclk@4a009060 {
+	compatible = "gate-clock";
+	reg = <0x4a009060 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio3_dbclk: gpio3_dbclk@4a009068 {
+	compatible = "gate-clock";
+	reg = <0x4a009068 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio4_dbclk: gpio4_dbclk@4a009070 {
+	compatible = "gate-clock";
+	reg = <0x4a009070 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio5_dbclk: gpio5_dbclk@4a009078 {
+	compatible = "gate-clock";
+	reg = <0x4a009078 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio6_dbclk: gpio6_dbclk@4a009080 {
+	compatible = "gate-clock";
+	reg = <0x4a009080 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio7_dbclk: gpio7_dbclk@4a009110 {
+	compatible = "gate-clock";
+	reg = <0x4a009110 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio8_dbclk: gpio8_dbclk@4a009118 {
+	compatible = "gate-clock";
+	reg = <0x4a009118 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+iss_ctrlclk: iss_ctrlclk@4a009320 {
+	compatible = "gate-clock";
+	reg = <0x4a009320 0x4>;
+	bit-shift = <8>;
+	clocks = <&func_96m_fclk>;
+	#clock-cells = <0>;
+};
+
+lli_txphy_clk: lli_txphy_clk@4a008f20 {
+	compatible = "gate-clock";
+	reg = <0x4a008f20 0x4>;
+	bit-shift = <8>;
+	clocks = <&dpll_unipro1_clkdcoldo>;
+	#clock-cells = <0>;
+};
+
+lli_txphy_ls_clk: lli_txphy_ls_clk@4a008f20 {
+	compatible = "gate-clock";
+	reg = <0x4a008f20 0x4>;
+	bit-shift = <9>;
+	clocks = <&dpll_unipro1_m2_ck>;
+	#clock-cells = <0>;
+};
+
+mmc1_32khz_clk: mmc1_32khz_clk@4a009628 {
+	compatible = "gate-clock";
+	reg = <0x4a009628 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+sata_ref_clk: sata_ref_clk@4a009688 {
+	compatible = "gate-clock";
+	reg = <0x4a009688 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_clkin>;
+	#clock-cells = <0>;
+};
+
+slimbus1_slimbus_clk: slimbus1_slimbus_clk@4a004560 {
+	compatible = "gate-clock";
+	reg = <0x4a004560 0x4>;
+	bit-shift = <11>;
+	clocks = <&slimbus_clk>;
+	#clock-cells = <0>;
+};
+
+usb_host_hs_hsic480m_p1_clk: usb_host_hs_hsic480m_p1_clk@4a009658 {
+	compatible = "gate-clock";
+	reg = <0x4a009658 0x4>;
+	bit-shift = <13>;
+	clocks = <&dpll_usb_m2_ck>;
+	#clock-cells = <0>;
+};
+
+usb_host_hs_hsic480m_p2_clk: usb_host_hs_hsic480m_p2_clk@4a009658 {
+	compatible = "gate-clock";
+	reg = <0x4a009658 0x4>;
+	bit-shift = <14>;
+	clocks = <&dpll_usb_m2_ck>;
+	#clock-cells = <0>;
+};
+
+usb_host_hs_hsic480m_p3_clk: usb_host_hs_hsic480m_p3_clk@4a009658 {
+	compatible = "gate-clock";
+	reg = <0x4a009658 0x4>;
+	bit-shift = <7>;
+	clocks = <&dpll_usb_m2_ck>;
+	#clock-cells = <0>;
+};
+
+usb_host_hs_hsic60m_p1_clk: usb_host_hs_hsic60m_p1_clk@4a009658 {
+	compatible = "gate-clock";
+	reg = <0x4a009658 0x4>;
+	bit-shift = <11>;
+	clocks = <&l3init_60m_fclk>;
+	#clock-cells = <0>;
+};
+
+usb_host_hs_hsic60m_p2_clk: usb_host_hs_hsic60m_p2_clk@4a009658 {
+	compatible = "gate-clock";
+	reg = <0x4a009658 0x4>;
+	bit-shift = <12>;
+	clocks = <&l3init_60m_fclk>;
+	#clock-cells = <0>;
+};
+
+usb_host_hs_hsic60m_p3_clk: usb_host_hs_hsic60m_p3_clk@4a009658 {
+	compatible = "gate-clock";
+	reg = <0x4a009658 0x4>;
+	bit-shift = <6>;
+	clocks = <&l3init_60m_fclk>;
+	#clock-cells = <0>;
+};
+
+utmi_p1_gfclk: utmi_p1_gfclk@4a009658 {
+	compatible = "mux-clock";
+	clocks = <&l3init_60m_fclk>, <&xclk60mhsp1_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009658 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+usb_host_hs_utmi_p1_clk: usb_host_hs_utmi_p1_clk@4a009658 {
+	compatible = "gate-clock";
+	reg = <0x4a009658 0x4>;
+	bit-shift = <8>;
+	clocks = <&utmi_p1_gfclk>;
+	#clock-cells = <0>;
+};
+
+utmi_p2_gfclk: utmi_p2_gfclk@4a009658 {
+	compatible = "mux-clock";
+	clocks = <&l3init_60m_fclk>, <&xclk60mhsp2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009658 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <25>;
+};
+
+usb_host_hs_utmi_p2_clk: usb_host_hs_utmi_p2_clk@4a009658 {
+	compatible = "gate-clock";
+	reg = <0x4a009658 0x4>;
+	bit-shift = <9>;
+	clocks = <&utmi_p2_gfclk>;
+	#clock-cells = <0>;
+};
+
+usb_host_hs_utmi_p3_clk: usb_host_hs_utmi_p3_clk@4a009658 {
+	compatible = "gate-clock";
+	reg = <0x4a009658 0x4>;
+	bit-shift = <10>;
+	clocks = <&l3init_60m_fclk>;
+	#clock-cells = <0>;
+};
+
+usb_otg_ss_refclk960m: usb_otg_ss_refclk960m@4a0096f0 {
+	compatible = "gate-clock";
+	reg = <0x4a0096f0 0x4>;
+	bit-shift = <8>;
+	clocks = <&dpll_usb_clkdcoldo>;
+	#clock-cells = <0>;
+};
+
+usb_phy_cm_clk32k: usb_phy_cm_clk32k@4a008640 {
+	compatible = "gate-clock";
+	reg = <0x4a008640 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+usb_tll_hs_usb_ch0_clk: usb_tll_hs_usb_ch0_clk@4a009668 {
+	compatible = "gate-clock";
+	reg = <0x4a009668 0x4>;
+	bit-shift = <8>;
+	clocks = <&l3init_60m_fclk>;
+	#clock-cells = <0>;
+};
+
+usb_tll_hs_usb_ch1_clk: usb_tll_hs_usb_ch1_clk@4a009668 {
+	compatible = "gate-clock";
+	reg = <0x4a009668 0x4>;
+	bit-shift = <9>;
+	clocks = <&l3init_60m_fclk>;
+	#clock-cells = <0>;
+};
+
+usb_tll_hs_usb_ch2_clk: usb_tll_hs_usb_ch2_clk@4a009668 {
+	compatible = "gate-clock";
+	reg = <0x4a009668 0x4>;
+	bit-shift = <10>;
+	clocks = <&l3init_60m_fclk>;
+	#clock-cells = <0>;
+};
+
+/* Remaining optional clocks */
+aess_fclk: aess_fclk@4a004528 {
+	compatible = "divider-clock";
+	clocks = <&abe_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004528 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+dmic_sync_mux_ck: dmic_sync_mux_ck@4a004538 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&dss_syc_gfclk_div>, <&func_24m_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004538 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <26>;
+};
+
+dmic_gfclk: dmic_gfclk@4a004538 {
+	compatible = "mux-clock";
+	clocks = <&dmic_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004538 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+};
+
+fdif_fclk: fdif_fclk@4a009328 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_h11x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009328 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+gpu_core_gclk_mux: gpu_core_gclk_mux@4a009520 {
+	compatible = "mux-clock";
+	clocks = <&dpll_core_h14x2_ck>, <&dpll_per_h14x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009520 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+gpu_hyd_gclk_mux: gpu_hyd_gclk_mux@4a009520 {
+	compatible = "mux-clock";
+	clocks = <&dpll_core_h14x2_ck>, <&dpll_per_h14x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009520 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <25>;
+};
+
+hsi_fclk: hsi_fclk@4a009638 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009638 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+mcasp_sync_mux_ck: mcasp_sync_mux_ck@4a004540 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&dss_syc_gfclk_div>, <&func_24m_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004540 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <26>;
+};
+
+mcasp_gfclk: mcasp_gfclk@4a004540 {
+	compatible = "mux-clock";
+	clocks = <&mcasp_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004540 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+};
+
+mcbsp1_sync_mux_ck: mcbsp1_sync_mux_ck@4a004548 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&dss_syc_gfclk_div>, <&func_24m_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004548 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <26>;
+};
+
+mcbsp1_gfclk: mcbsp1_gfclk@4a004548 {
+	compatible = "mux-clock";
+	clocks = <&mcbsp1_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004548 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+};
+
+mcbsp2_sync_mux_ck: mcbsp2_sync_mux_ck@4a004550 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&dss_syc_gfclk_div>, <&func_24m_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004550 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <26>;
+};
+
+mcbsp2_gfclk: mcbsp2_gfclk@4a004550 {
+	compatible = "mux-clock";
+	clocks = <&mcbsp2_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004550 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+};
+
+mcbsp3_sync_mux_ck: mcbsp3_sync_mux_ck@4a004558 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&dss_syc_gfclk_div>, <&func_24m_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004558 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <26>;
+};
+
+mcbsp3_gfclk: mcbsp3_gfclk@4a004558 {
+	compatible = "mux-clock";
+	clocks = <&mcbsp3_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004558 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+};
+
+mmc1_fclk_mux: mmc1_fclk_mux@4a009628 {
+	compatible = "mux-clock";
+	clocks = <&func_128m_clk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009628 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+mmc1_fclk: mmc1_fclk@4a009628 {
+	compatible = "divider-clock";
+	clocks = <&mmc1_fclk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a009628 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <25>;
+};
+
+mmc2_fclk_mux: mmc2_fclk_mux@4a009630 {
+	compatible = "mux-clock";
+	clocks = <&func_128m_clk>, <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009630 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+mmc2_fclk: mmc2_fclk@4a009630 {
+	compatible = "divider-clock";
+	clocks = <&mmc2_fclk_mux>;
+	#clock-cells = <0>;
+	reg = <0x4a009630 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <25>;
+};
+
+timer10_gfclk_mux: timer10_gfclk_mux@4a009028 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009028 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+timer11_gfclk_mux: timer11_gfclk_mux@4a009030 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009030 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+timer1_gfclk_mux: timer1_gfclk_mux@4ae07940 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae07940 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+timer2_gfclk_mux: timer2_gfclk_mux@4a009038 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009038 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+timer3_gfclk_mux: timer3_gfclk_mux@4a009040 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009040 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+timer4_gfclk_mux: timer4_gfclk_mux@4a009048 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009048 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+timer5_gfclk_mux: timer5_gfclk_mux@4a004568 {
+	compatible = "mux-clock";
+	clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004568 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+timer6_gfclk_mux: timer6_gfclk_mux@4a004570 {
+	compatible = "mux-clock";
+	clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004570 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+timer7_gfclk_mux: timer7_gfclk_mux@4a004578 {
+	compatible = "mux-clock";
+	clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004578 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+timer8_gfclk_mux: timer8_gfclk_mux@4a004580 {
+	compatible = "mux-clock";
+	clocks = <&dss_syc_gfclk_div>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004580 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+timer9_gfclk_mux: timer9_gfclk_mux@4a009050 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009050 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+/* SCRM aux clk nodes */
+auxclk0_src_mux_ck: auxclk0_src_mux_ck@4ae0a310 {
+	compatible = "mux-clock";
+	reg = <0x4ae0a310 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <1>;
+	clocks = <&sys_clkin>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
+	#clock-cells = <0>;
+};
+
+auxclk0_src_ck: auxclk0_src_ck@4ae0a310 {
+	compatible = "gate-clock";
+	#clock-cells = <0>;
+	reg = <0x4ae0a310 0x4>;
+	bit-shift = <8>;
+	clocks = <&auxclk0_src_mux_ck>;
+};
+
+auxclk0_ck: auxclk0_ck@4ae0a310 {
+	compatible = "divider-clock";
+	clocks = <&auxclk0_src_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0a310 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <16>;
+};
+
+auxclk1_src_mux_ck: auxclk1_src_mux_ck@4ae0a314 {
+	compatible = "mux-clock";
+	reg = <0x4ae0a314 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <1>;
+	clocks = <&sys_clkin>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
+	#clock-cells = <0>;
+};
+
+auxclk1_src_ck: auxclk1_src_ck@4ae0a314 {
+	compatible = "gate-clock";
+	#clock-cells = <0>;
+	reg = <0x4ae0a314 0x4>;
+	bit-shift = <8>;
+	clocks = <&auxclk1_src_mux_ck>;
+};
+
+auxclk1_ck: auxclk1_ck@4ae0a314 {
+	compatible = "divider-clock";
+	clocks = <&auxclk1_src_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0a314 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <16>;
+};
+
+auxclk2_src_mux_ck: auxclk2_src_mux_ck@4ae0a318 {
+	compatible = "mux-clock";
+	reg = <0x4ae0a318 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <1>;
+	clocks = <&sys_clkin>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
+	#clock-cells = <0>;
+};
+
+auxclk2_src_ck: auxclk2_src_ck@4ae0a318 {
+	compatible = "gate-clock";
+	#clock-cells = <0>;
+	reg = <0x4ae0a318 0x4>;
+	bit-shift = <8>;
+	clocks = <&auxclk2_src_mux_ck>;
+};
+
+auxclk2_ck: auxclk2_ck@4ae0a318 {
+	compatible = "divider-clock";
+	clocks = <&auxclk2_src_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0a318 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <16>;
+};
+
+auxclk3_src_mux_ck: auxclk3_src_mux_ck@4ae0a31c {
+	compatible = "mux-clock";
+	reg = <0x4ae0a31c 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <1>;
+	clocks = <&sys_clkin>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
+	#clock-cells = <0>;
+};
+
+auxclk3_src_ck: auxclk3_src_ck@4ae0a31c {
+	compatible = "gate-clock";
+	#clock-cells = <0>;
+	reg = <0x4ae0a31c 0x4>;
+	bit-shift = <8>;
+	clocks = <&auxclk3_src_mux_ck>;
+};
+
+auxclk3_ck: auxclk3_ck@4ae0a31c {
+	compatible = "divider-clock";
+	clocks = <&auxclk3_src_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0a31c 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <16>;
+};
+
+auxclk4_src_mux_ck: auxclk4_src_mux_ck@4ae0a320 {
+	compatible = "mux-clock";
+	reg = <0x4ae0a320 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <1>;
+	clocks = <&sys_clkin>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
+	#clock-cells = <0>;
+};
+
+auxclk4_src_ck: auxclk4_src_ck@4ae0a320 {
+	compatible = "gate-clock";
+	#clock-cells = <0>;
+	reg = <0x4ae0a320 0x4>;
+	bit-shift = <8>;
+	clocks = <&auxclk4_src_mux_ck>;
+};
+
+auxclk4_ck: auxclk4_ck@4ae0a320 {
+	compatible = "divider-clock";
+	clocks = <&auxclk4_src_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0a320 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <16>;
+};
+
+auxclkreq0_ck: auxclkreq0_ck@4ae0a210 {
+	compatible = "mux-clock";
+	clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0a210 0x4>;
+	bit-mask = <0x7>;
+	bit-shift = <2>;
+};
+
+auxclkreq1_ck: auxclkreq1_ck@4ae0a214 {
+	compatible = "mux-clock";
+	clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0a214 0x4>;
+	bit-mask = <0x7>;
+	bit-shift = <2>;
+};
+
+auxclkreq2_ck: auxclkreq2_ck@4ae0a218 {
+	compatible = "mux-clock";
+	clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0a218 0x4>;
+	bit-mask = <0x7>;
+	bit-shift = <2>;
+};
+
+auxclkreq3_ck: auxclkreq3_ck@4ae0a21c {
+	compatible = "mux-clock";
+	clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0a21c 0x4>;
+	bit-mask = <0x7>;
+	bit-shift = <2>;
+};
+
+auxclkreq4_ck: auxclkreq4_ck@4ae0a220 {
+	compatible = "mux-clock";
+	clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>;
+	#clock-cells = <0>;
+	reg = <0x4ae0a220 0x4>;
+	bit-mask = <0x7>;
+	bit-shift = <2>;
+};
+
+/*
+ * clkdev
+ */
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 635cae2..ca40724 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -74,6 +74,8 @@
 		};
 	};
 
+	/include/ "omap5-clocks.dtsi"
+
 	/*
 	 * XXX: Use a flat representation of the OMAP3 interconnect.
 	 * The real OMAP interconnect network is quite complex.
-- 
1.7.9.5

