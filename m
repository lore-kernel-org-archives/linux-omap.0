From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 8/9] ARM: dts: omap4 clock data
Date: Tue, 25 Jun 2013 15:38:32 +0300
Message-ID: <1372163913-16566-9-git-send-email-t-kristo@ti.com>
References: <1372163913-16566-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51282 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729Ab3FYMjm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jun 2013 08:39:42 -0400
In-Reply-To: <1372163913-16566-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

This patch creates a unique node for each clock in the OMAP4 power,
reset and clock manager (PRCM).

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap4-clocks.dtsi | 1692 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi        |    2 +
 2 files changed, 1694 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-clocks.dtsi

diff --git a/arch/arm/boot/dts/omap4-clocks.dtsi b/arch/arm/boot/dts/omap4-clocks.dtsi
new file mode 100644
index 0000000..2ece8b0
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-clocks.dtsi
@@ -0,0 +1,1692 @@
+/*
+ * Device Tree Source for OMAP4 clock data
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* Root clocks */
+extalt_clkin_ck: extalt_clkin_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <59000000>;
+};
+
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
+pad_slimbus_core_clks_ck: pad_slimbus_core_clks_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <12000000>;
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
+sys_clkin_ck: sys_clkin_ck@4a306110 {
+	compatible = "mux-clock";
+	clocks = <&virt_12000000_ck>, <&virt_13000000_ck>, <&virt_16800000_ck>, <&virt_19200000_ck>, <&virt_26000000_ck>, <&virt_27000000_ck>, <&virt_38400000_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a306110 0x4>;
+	bit-mask = <0x7>;
+	index-starts-at-one;
+};
+
+tie_low_clock_ck: tie_low_clock_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+utmi_phy_clkout_ck: utmi_phy_clkout_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <60000000>;
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
+xclk60motg_ck: xclk60motg_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <60000000>;
+};
+
+/* Module clocks and DPLL outputs */
+abe_dpll_bypass_clk_mux_ck: abe_dpll_bypass_clk_mux_ck@4a306108 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a306108 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+abe_dpll_refclk_mux_ck: abe_dpll_refclk_mux_ck@4a30610c {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a30610c 0x4>;
+	bit-mask = <0x1>;
+};
+
+/* DPLL_ABE */
+dpll_abe_ck: dpll_abe_ck {
+	clocks = <&abe_dpll_refclk_mux_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0041e0 0x4>, <0x4a0041e4 0x4>, <0x4a0041e8 0x4>, <0x4a0041ec 0x4>;
+	ti,clk-bypass = <&abe_dpll_bypass_clk_mux_ck>;
+	ti,clk-ref = <&abe_dpll_refclk_mux_ck>;
+	compatible = "ti,omap4-dpll-clock";
+	ti,dpll-regm4xen;
+};
+
+dpll_abe_x2_ck: dpll_abe_x2_ck {
+	clocks = <&dpll_abe_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0041f0 0x4>;
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
+aess_fclk: aess_fclk@4a004528 {
+	compatible = "divider-clock";
+	clocks = <&abe_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004528 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
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
+core_hsd_byp_clk_mux_ck: core_hsd_byp_clk_mux_ck@4a00412c {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin_ck>, <&dpll_abe_m3x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00412c 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <23>;
+};
+
+/* DPLL_CORE */
+dpll_core_ck: dpll_core_ck {
+	clocks = <&sys_clkin_ck>, <&core_hsd_byp_clk_mux_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004120 0x4>, <0x4a004124 0x4>, <0x4a004128 0x4>, <0x4a00412c 0x4>;
+	ti,clk-bypass = <&core_hsd_byp_clk_mux_ck>;
+	ti,clk-ref = <&sys_clkin_ck>;
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
+dpll_core_m6x2_ck: dpll_core_m6x2_ck@4a004140 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004140 0x4>;
+	bit-mask = <0x1f>;
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
+ddrphy_ck: ddrphy_ck {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_core_m2_ck>;
+	#clock-cells = <0>;
+	clock-div = <2>;
+	clock-mult = <1>;
+};
+
+dpll_core_m5x2_ck: dpll_core_m5x2_ck@4a00413c {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00413c 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+div_core_ck: div_core_ck@4a004100 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_m5x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004100 0x4>;
+	bit-mask = <0x1>;
+};
+
+div_iva_hs_clk: div_iva_hs_clk@4a0041dc {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_m5x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0041dc 0x4>;
+	bit-mask = <0x3>;
+	index-power-of-two;
+};
+
+div_mpu_hs_clk: div_mpu_hs_clk@4a00419c {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_m5x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00419c 0x4>;
+	bit-mask = <0x3>;
+	index-power-of-two;
+};
+
+dpll_core_m4x2_ck: dpll_core_m4x2_ck@4a004138 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004138 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dll_clk_div_ck: dll_clk_div_ck {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_core_m4x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <2>;
+	clock-mult = <1>;
+};
+
+dpll_abe_m2_ck: dpll_abe_m2_ck@4a0041f0 {
+	compatible = "divider-clock";
+	clocks = <&dpll_abe_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0041f0 0x4>;
+	bit-mask = <0x1f>;
+	index-starts-at-one;
+};
+
+dpll_core_m3x2_div_ck: dpll_core_m3x2_div_ck@4a004134 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004134 0x4>;
+	bit-mask = <0x1f>;
+	index-starts-at-one;
+};
+
+dpll_core_m3x2_ck: dpll_core_m3x2_ck@4a004134 {
+	compatible = "gate-clock";
+	#clock-cells = <0>;
+	reg = <0x4a004134 0x4>;
+	bit-shift = <8>;
+	clocks = <&dpll_core_m3x2_div_ck>;
+};
+
+dpll_core_m7x2_ck: dpll_core_m7x2_ck@4a004144 {
+	compatible = "divider-clock";
+	clocks = <&dpll_core_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004144 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+iva_hsd_byp_clk_mux_ck: iva_hsd_byp_clk_mux_ck@4a0041ac {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin_ck>, <&div_iva_hs_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a0041ac 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <23>;
+};
+
+/* DPLL_IVA */
+dpll_iva_ck: dpll_iva_ck {
+	clocks = <&sys_clkin_ck>, <&iva_hsd_byp_clk_mux_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0041a0 0x4>, <0x4a0041a4 0x4>, <0x4a0041a8 0x4>, <0x4a0041ac 0x4>;
+	ti,clk-bypass = <&iva_hsd_byp_clk_mux_ck>;
+	ti,clk-ref = <&sys_clkin_ck>;
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
+dpll_iva_m4x2_ck: dpll_iva_m4x2_ck@4a0041b8 {
+	compatible = "divider-clock";
+	clocks = <&dpll_iva_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0041b8 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_iva_m5x2_ck: dpll_iva_m5x2_ck@4a0041bc {
+	compatible = "divider-clock";
+	clocks = <&dpll_iva_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a0041bc 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+/* DPLL_MPU */
+dpll_mpu_ck: dpll_mpu_ck {
+	clocks = <&sys_clkin_ck>, <&div_mpu_hs_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004160 0x4>, <0x4a004164 0x4>, <0x4a004168 0x4>, <0x4a00416c 0x4>;
+	ti,clk-bypass = <&div_mpu_hs_clk>;
+	ti,clk-ref = <&sys_clkin_ck>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+mpu_periphclk: mpu_periphclk {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_mpu_ck>;
+	#clock-cells = <0>;
+	clock-div = <2>;
+	clock-mult = <1>;
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
+per_hs_clk_div_ck: per_hs_clk_div_ck {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_abe_m3x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <2>;
+	clock-mult = <1>;
+};
+
+per_hsd_byp_clk_mux_ck: per_hsd_byp_clk_mux_ck@4a00814c {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin_ck>, <&per_hs_clk_div_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00814c 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <23>;
+};
+
+/* DPLL_PER */
+dpll_per_ck: dpll_per_ck {
+	clocks = <&sys_clkin_ck>, <&per_hsd_byp_clk_mux_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008140 0x4>, <0x4a008144 0x4>, <0x4a008148 0x4>, <0x4a00814c 0x4>;
+	ti,clk-bypass = <&per_hsd_byp_clk_mux_ck>;
+	ti,clk-ref = <&sys_clkin_ck>;
+	compatible = "ti,omap4-dpll-clock";
+};
+
+dpll_per_m2_ck: dpll_per_m2_ck@4a008150 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008150 0x4>;
+	bit-mask = <0x1f>;
+	index-starts-at-one;
+};
+
+dpll_per_x2_ck: dpll_per_x2_ck {
+	clocks = <&dpll_per_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008150 0x4>;
+	compatible = "ti,omap4-dpll-clock";
+	ti,dpll-clk-x2;
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
+dpll_per_m3x2_div_ck: dpll_per_m3x2_div_ck@4a008154 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008154 0x4>;
+	bit-mask = <0x1f>;
+	index-starts-at-one;
+};
+
+dpll_per_m3x2_ck: dpll_per_m3x2_ck@4a008154 {
+	compatible = "gate-clock";
+	#clock-cells = <0>;
+	reg = <0x4a008154 0x4>;
+	bit-shift = <8>;
+	clocks = <&dpll_per_m3x2_div_ck>;
+};
+
+dpll_per_m4x2_ck: dpll_per_m4x2_ck@4a008158 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008158 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_per_m5x2_ck: dpll_per_m5x2_ck@4a00815c {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a00815c 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_per_m6x2_ck: dpll_per_m6x2_ck@4a008160 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008160 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+dpll_per_m7x2_ck: dpll_per_m7x2_ck@4a008164 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008164 0x4>;
+	bit-mask = <0x1f>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
+	index-starts-at-one;
+};
+
+usb_hs_clk_div_ck: usb_hs_clk_div_ck {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_abe_m3x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <3>;
+	clock-mult = <1>;
+};
+
+/* DPLL_USB */
+dpll_usb_ck: dpll_usb_ck {
+	clocks = <&sys_clkin_ck>, <&usb_hs_clk_div_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008180 0x4>, <0x4a008184 0x4>, <0x4a008188 0x4>, <0x4a00818c 0x4>;
+	ti,clk-bypass = <&usb_hs_clk_div_ck>;
+	ti,clk-ref = <&sys_clkin_ck>;
+	ti,clkdm-name = "l3_init_clkdm";
+	compatible = "ti,omap4-dpll-clock";
+	ti,dpll-j-type;
+};
+
+dpll_usb_clkdcoldo_ck: dpll_usb_clkdcoldo_ck {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_usb_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+	reg = <0x4a0081b4 0x4>;
+	ti,autoidle-shift = <8>;
+	ti,autoidle-low;
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
+ducati_clk_mux_ck: ducati_clk_mux_ck@4a008100 {
+	compatible = "mux-clock";
+	clocks = <&div_core_ck>, <&dpll_per_m6x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008100 0x4>;
+	bit-mask = <0x1>;
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
+func_24mc_fclk: func_24mc_fclk {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <8>;
+	clock-mult = <1>;
+};
+
+func_48m_fclk: func_48m_fclk@4a008108 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008108 0x4>;
+	bit-mask = <0x1>;
+	table = < 4 0 >, < 8 1 >;
+};
+
+func_48mc_fclk: func_48mc_fclk {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <4>;
+	clock-mult = <1>;
+};
+
+func_64m_fclk: func_64m_fclk@4a008108 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_m4x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008108 0x4>;
+	bit-mask = <0x1>;
+	table = < 2 0 >, < 4 1 >;
+};
+
+func_96m_fclk: func_96m_fclk@4a008108 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008108 0x4>;
+	bit-mask = <0x1>;
+	table = < 2 0 >, < 4 1 >;
+};
+
+init_60m_fclk: init_60m_fclk@4a008104 {
+	compatible = "divider-clock";
+	clocks = <&dpll_usb_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008104 0x4>;
+	bit-mask = <0x1>;
+	table = < 1 0 >, < 8 1 >;
+};
+
+l3_div_ck: l3_div_ck@4a004100 {
+	compatible = "divider-clock";
+	clocks = <&div_core_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004100 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <4>;
+};
+
+l4_div_ck: l4_div_ck@4a004100 {
+	compatible = "divider-clock";
+	clocks = <&l3_div_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a004100 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <8>;
+};
+
+lp_clk_div_ck: lp_clk_div_ck {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_abe_m2x2_ck>;
+	#clock-cells = <0>;
+	clock-div = <16>;
+	clock-mult = <1>;
+};
+
+l4_wkup_clk_mux_ck: l4_wkup_clk_mux_ck@4a306108 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin_ck>, <&lp_clk_div_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a306108 0x4>;
+	bit-mask = <0x1>;
+};
+
+ocp_abe_iclk: ocp_abe_iclk@4a004528 {
+	compatible = "divider-clock";
+	clocks = <&aess_fclk>;
+	#clock-cells = <0>;
+	reg = <0x4a004528 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	table = < 2 0 >, < 1 1 >;
+};
+
+per_abe_24m_fclk: per_abe_24m_fclk {
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll_abe_m2_ck>;
+	#clock-cells = <0>;
+	clock-div = <4>;
+	clock-mult = <1>;
+};
+
+per_abe_nc_fclk: per_abe_nc_fclk@4a008108 {
+	compatible = "divider-clock";
+	clocks = <&dpll_abe_m2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a008108 0x4>;
+	bit-mask = <0x1>;
+};
+
+syc_clk_div_ck: syc_clk_div_ck@4a306100 {
+	compatible = "divider-clock";
+	clocks = <&sys_clkin_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a306100 0x4>;
+	bit-mask = <0x1>;
+};
+
+dbgclk_mux_ck: dbgclk_mux_ck {
+	compatible = "fixed-factor-clock";
+	clocks = <&sys_clkin_ck>;
+	#clock-cells = <0>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+/* Leaf clocks controlled by modules */
+aes1_fck: aes1_fck@4a0095a0 {
+	compatible = "gate-clock";
+	reg = <0x4a0095a0 0x4>;
+	bit-shift = <1>;
+	clocks = <&l3_div_ck>;
+	#clock-cells = <0>;
+};
+
+aes2_fck: aes2_fck@4a0095a8 {
+	compatible = "gate-clock";
+	reg = <0x4a0095a8 0x4>;
+	bit-shift = <1>;
+	clocks = <&l3_div_ck>;
+	#clock-cells = <0>;
+};
+
+bandgap_fclk: bandgap_fclk@4a307888 {
+	compatible = "gate-clock";
+	reg = <0x4a307888 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+div_ts_ck: div_ts_ck@4a307888 {
+	compatible = "divider-clock";
+	clocks = <&l4_wkup_clk_mux_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a307888 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+	table = < 8 0 >, < 16 1 >, < 32 2 >;
+};
+
+bandgap_ts_fclk: bandgap_ts_fclk@4a307888 {
+	compatible = "gate-clock";
+	reg = <0x4a307888 0x4>;
+	bit-shift = <8>;
+	clocks = <&div_ts_ck>;
+	#clock-cells = <0>;
+};
+
+dmic_sync_mux_ck: dmic_sync_mux_ck@4a004538 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004538 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <25>;
+};
+
+func_dmic_abe_gfclk: func_dmic_abe_gfclk@4a004538 {
+	compatible = "mux-clock";
+	reg = <0x4a004538 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+	clocks = <&dmic_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
+	#clock-cells = <0>;
+};
+
+dss_sys_clk: dss_sys_clk@4a009120 {
+	compatible = "gate-clock";
+	reg = <0x4a009120 0x4>;
+	bit-shift = <10>;
+	clocks = <&syc_clk_div_ck>;
+	#clock-cells = <0>;
+};
+
+dss_tv_clk: dss_tv_clk@4a009120 {
+	compatible = "gate-clock";
+	reg = <0x4a009120 0x4>;
+	bit-shift = <11>;
+	clocks = <&extalt_clkin_ck>;
+	#clock-cells = <0>;
+};
+
+dss_dss_clk: dss_dss_clk@4a009120 {
+	compatible = "gate-clock";
+	reg = <0x4a009120 0x4>;
+	bit-shift = <8>;
+	clocks = <&dpll_per_m5x2_ck>;
+	#clock-cells = <0>;
+};
+
+dss_48mhz_clk: dss_48mhz_clk@4a009120 {
+	compatible = "gate-clock";
+	reg = <0x4a009120 0x4>;
+	bit-shift = <9>;
+	clocks = <&func_48mc_fclk>;
+	#clock-cells = <0>;
+};
+
+dss_fck: dss_fck@4a009120 {
+	compatible = "gate-clock";
+	reg = <0x4a009120 0x4>;
+	bit-shift = <1>;
+	clocks = <&l3_div_ck>;
+	#clock-cells = <0>;
+};
+
+fdif_fck: fdif_fck@4a009028 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_m4x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009028 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+	index-power-of-two;
+};
+
+gpio1_dbclk: gpio1_dbclk@4a307838 {
+	compatible = "gate-clock";
+	reg = <0x4a307838 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio2_dbclk: gpio2_dbclk@4a009460 {
+	compatible = "gate-clock";
+	reg = <0x4a009460 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio3_dbclk: gpio3_dbclk@4a009468 {
+	compatible = "gate-clock";
+	reg = <0x4a009468 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio4_dbclk: gpio4_dbclk@4a009470 {
+	compatible = "gate-clock";
+	reg = <0x4a009470 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio5_dbclk: gpio5_dbclk@4a009478 {
+	compatible = "gate-clock";
+	reg = <0x4a009478 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+gpio6_dbclk: gpio6_dbclk@4a009480 {
+	compatible = "gate-clock";
+	reg = <0x4a009480 0x4>;
+	bit-shift = <8>;
+	clocks = <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+sgx_clk_mux: sgx_clk_mux@4a009220 {
+	compatible = "mux-clock";
+	reg = <0x4a009220 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&dpll_core_m7x2_ck>, <&dpll_per_m7x2_ck>;
+	#clock-cells = <0>;
+};
+
+hsi_fck: hsi_fck@4a009338 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_m2x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009338 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+	index-power-of-two;
+};
+
+iss_ctrlclk: iss_ctrlclk@4a009020 {
+	compatible = "gate-clock";
+	reg = <0x4a009020 0x4>;
+	bit-shift = <8>;
+	clocks = <&func_96m_fclk>;
+	#clock-cells = <0>;
+};
+
+mcasp_sync_mux_ck: mcasp_sync_mux_ck@4a004540 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004540 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <25>;
+};
+
+func_mcasp_abe_gfclk: func_mcasp_abe_gfclk@4a004540 {
+	compatible = "mux-clock";
+	reg = <0x4a004540 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+	clocks = <&mcasp_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
+	#clock-cells = <0>;
+};
+
+mcbsp1_sync_mux_ck: mcbsp1_sync_mux_ck@4a004548 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004548 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <25>;
+};
+
+func_mcbsp1_gfclk: func_mcbsp1_gfclk@4a004548 {
+	compatible = "mux-clock";
+	reg = <0x4a004548 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+	clocks = <&mcbsp1_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
+	#clock-cells = <0>;
+};
+
+mcbsp2_sync_mux_ck: mcbsp2_sync_mux_ck@4a004550 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004550 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <25>;
+};
+
+func_mcbsp2_gfclk: func_mcbsp2_gfclk@4a004550 {
+	compatible = "mux-clock";
+	reg = <0x4a004550 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+	clocks = <&mcbsp2_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
+	#clock-cells = <0>;
+};
+
+mcbsp3_sync_mux_ck: mcbsp3_sync_mux_ck@4a004558 {
+	compatible = "mux-clock";
+	clocks = <&abe_24m_fclk>, <&syc_clk_div_ck>, <&func_24m_clk>;
+	#clock-cells = <0>;
+	reg = <0x4a004558 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <25>;
+};
+
+func_mcbsp3_gfclk: func_mcbsp3_gfclk@4a004558 {
+	compatible = "mux-clock";
+	reg = <0x4a004558 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <24>;
+	clocks = <&mcbsp3_sync_mux_ck>, <&pad_clks_ck>, <&slimbus_clk>;
+	#clock-cells = <0>;
+};
+
+mcbsp4_sync_mux_ck: mcbsp4_sync_mux_ck@4a0094e0 {
+	compatible = "mux-clock";
+	clocks = <&func_96m_fclk>, <&per_abe_nc_fclk>;
+	#clock-cells = <0>;
+	reg = <0x4a0094e0 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <25>;
+};
+
+per_mcbsp4_gfclk: per_mcbsp4_gfclk@4a0094e0 {
+	compatible = "mux-clock";
+	reg = <0x4a0094e0 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&mcbsp4_sync_mux_ck>, <&pad_clks_ck>;
+	#clock-cells = <0>;
+};
+
+hsmmc1_fclk: hsmmc1_fclk@4a009328 {
+	compatible = "mux-clock";
+	reg = <0x4a009328 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&func_64m_fclk>, <&func_96m_fclk>;
+	#clock-cells = <0>;
+};
+
+hsmmc2_fclk: hsmmc2_fclk@4a009330 {
+	compatible = "mux-clock";
+	reg = <0x4a009330 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&func_64m_fclk>, <&func_96m_fclk>;
+	#clock-cells = <0>;
+};
+
+ocp2scp_usb_phy_phy_48m: ocp2scp_usb_phy_phy_48m@4a0093e0 {
+	compatible = "gate-clock";
+	reg = <0x4a0093e0 0x4>;
+	bit-shift = <8>;
+	clocks = <&func_48m_fclk>;
+	#clock-cells = <0>;
+};
+
+sha2md5_fck: sha2md5_fck@4a0095c8 {
+	compatible = "gate-clock";
+	reg = <0x4a0095c8 0x4>;
+	bit-shift = <1>;
+	clocks = <&l3_div_ck>;
+	#clock-cells = <0>;
+};
+
+slimbus1_fclk_1: slimbus1_fclk_1@4a004560 {
+	compatible = "gate-clock";
+	reg = <0x4a004560 0x4>;
+	bit-shift = <9>;
+	clocks = <&func_24m_clk>;
+	#clock-cells = <0>;
+};
+
+slimbus1_fclk_0: slimbus1_fclk_0@4a004560 {
+	compatible = "gate-clock";
+	reg = <0x4a004560 0x4>;
+	bit-shift = <8>;
+	clocks = <&abe_24m_fclk>;
+	#clock-cells = <0>;
+};
+
+slimbus1_fclk_2: slimbus1_fclk_2@4a004560 {
+	compatible = "gate-clock";
+	reg = <0x4a004560 0x4>;
+	bit-shift = <10>;
+	clocks = <&pad_clks_ck>;
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
+slimbus2_fclk_1: slimbus2_fclk_1@4a009538 {
+	compatible = "gate-clock";
+	reg = <0x4a009538 0x4>;
+	bit-shift = <9>;
+	clocks = <&per_abe_24m_fclk>;
+	#clock-cells = <0>;
+};
+
+slimbus2_fclk_0: slimbus2_fclk_0@4a009538 {
+	compatible = "gate-clock";
+	reg = <0x4a009538 0x4>;
+	bit-shift = <8>;
+	clocks = <&func_24mc_fclk>;
+	#clock-cells = <0>;
+};
+
+slimbus2_slimbus_clk: slimbus2_slimbus_clk@4a009538 {
+	compatible = "gate-clock";
+	reg = <0x4a009538 0x4>;
+	bit-shift = <10>;
+	clocks = <&pad_slimbus_core_clks_ck>;
+	#clock-cells = <0>;
+};
+
+smartreflex_core_fck: smartreflex_core_fck@4a008638 {
+	compatible = "gate-clock";
+	reg = <0x4a008638 0x4>;
+	bit-shift = <1>;
+	clocks = <&l4_wkup_clk_mux_ck>;
+	#clock-cells = <0>;
+};
+
+smartreflex_iva_fck: smartreflex_iva_fck@4a008630 {
+	compatible = "gate-clock";
+	reg = <0x4a008630 0x4>;
+	bit-shift = <1>;
+	clocks = <&l4_wkup_clk_mux_ck>;
+	#clock-cells = <0>;
+};
+
+smartreflex_mpu_fck: smartreflex_mpu_fck@4a008628 {
+	compatible = "gate-clock";
+	reg = <0x4a008628 0x4>;
+	bit-shift = <1>;
+	clocks = <&l4_wkup_clk_mux_ck>;
+	#clock-cells = <0>;
+};
+
+dmt1_clk_mux: dmt1_clk_mux@4a307840 {
+	compatible = "mux-clock";
+	reg = <0x4a307840 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+cm2_dm10_mux: cm2_dm10_mux@4a009428 {
+	compatible = "mux-clock";
+	reg = <0x4a009428 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+cm2_dm11_mux: cm2_dm11_mux@4a009430 {
+	compatible = "mux-clock";
+	reg = <0x4a009430 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+cm2_dm2_mux: cm2_dm2_mux@4a009438 {
+	compatible = "mux-clock";
+	reg = <0x4a009438 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+cm2_dm3_mux: cm2_dm3_mux@4a009440 {
+	compatible = "mux-clock";
+	reg = <0x4a009440 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+cm2_dm4_mux: cm2_dm4_mux@4a009448 {
+	compatible = "mux-clock";
+	reg = <0x4a009448 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+timer5_sync_mux: timer5_sync_mux@4a004568 {
+	compatible = "mux-clock";
+	reg = <0x4a004568 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+timer6_sync_mux: timer6_sync_mux@4a004570 {
+	compatible = "mux-clock";
+	reg = <0x4a004570 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+timer7_sync_mux: timer7_sync_mux@4a004578 {
+	compatible = "mux-clock";
+	reg = <0x4a004578 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+timer8_sync_mux: timer8_sync_mux@4a004580 {
+	compatible = "mux-clock";
+	reg = <0x4a004580 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&syc_clk_div_ck>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+cm2_dm9_mux: cm2_dm9_mux@4a009450 {
+	compatible = "mux-clock";
+	reg = <0x4a009450 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
+	#clock-cells = <0>;
+};
+
+usb_host_fs_fck: usb_host_fs_fck {
+	clocks = <&func_48mc_fclk>;
+	#clock-cells = <0>;
+	bit-shift = <1>;
+	reg = <0x4a0093d0 0x4>;
+	compatible = "gate-clock";
+};
+
+utmi_p1_gfclk: utmi_p1_gfclk@4a009358 {
+	compatible = "mux-clock";
+	clocks = <&init_60m_fclk>, <&xclk60mhsp1_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009358 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+usb_host_hs_utmi_p1_clk: usb_host_hs_utmi_p1_clk@4a009358 {
+	compatible = "gate-clock";
+	reg = <0x4a009358 0x4>;
+	bit-shift = <8>;
+	clocks = <&utmi_p1_gfclk>;
+	#clock-cells = <0>;
+};
+
+utmi_p2_gfclk: utmi_p2_gfclk@4a009358 {
+	compatible = "mux-clock";
+	clocks = <&init_60m_fclk>, <&xclk60mhsp2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009358 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <25>;
+};
+
+usb_host_hs_utmi_p2_clk: usb_host_hs_utmi_p2_clk@4a009358 {
+	compatible = "gate-clock";
+	reg = <0x4a009358 0x4>;
+	bit-shift = <9>;
+	clocks = <&utmi_p2_gfclk>;
+	#clock-cells = <0>;
+};
+
+usb_host_hs_utmi_p3_clk: usb_host_hs_utmi_p3_clk@4a009358 {
+	compatible = "gate-clock";
+	reg = <0x4a009358 0x4>;
+	bit-shift = <10>;
+	clocks = <&init_60m_fclk>;
+	#clock-cells = <0>;
+};
+
+usb_host_hs_hsic480m_p1_clk: usb_host_hs_hsic480m_p1_clk@4a009358 {
+	compatible = "gate-clock";
+	reg = <0x4a009358 0x4>;
+	bit-shift = <13>;
+	clocks = <&dpll_usb_m2_ck>;
+	#clock-cells = <0>;
+};
+
+usb_host_hs_hsic60m_p1_clk: usb_host_hs_hsic60m_p1_clk@4a009358 {
+	compatible = "gate-clock";
+	reg = <0x4a009358 0x4>;
+	bit-shift = <11>;
+	clocks = <&init_60m_fclk>;
+	#clock-cells = <0>;
+};
+
+usb_host_hs_hsic60m_p2_clk: usb_host_hs_hsic60m_p2_clk@4a009358 {
+	compatible = "gate-clock";
+	reg = <0x4a009358 0x4>;
+	bit-shift = <12>;
+	clocks = <&init_60m_fclk>;
+	#clock-cells = <0>;
+};
+
+usb_host_hs_hsic480m_p2_clk: usb_host_hs_hsic480m_p2_clk@4a009358 {
+	compatible = "gate-clock";
+	reg = <0x4a009358 0x4>;
+	bit-shift = <14>;
+	clocks = <&dpll_usb_m2_ck>;
+	#clock-cells = <0>;
+};
+
+usb_host_hs_func48mclk: usb_host_hs_func48mclk@4a009358 {
+	compatible = "gate-clock";
+	reg = <0x4a009358 0x4>;
+	bit-shift = <15>;
+	clocks = <&func_48mc_fclk>;
+	#clock-cells = <0>;
+};
+
+usb_host_hs_fck: usb_host_hs_fck@4a009358 {
+	compatible = "gate-clock";
+	reg = <0x4a009358 0x4>;
+	bit-shift = <1>;
+	clocks = <&init_60m_fclk>;
+	#clock-cells = <0>;
+};
+
+otg_60m_gfclk: otg_60m_gfclk@4a009360 {
+	compatible = "mux-clock";
+	clocks = <&utmi_phy_clkout_ck>, <&xclk60motg_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a009360 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+};
+
+usb_otg_hs_xclk: usb_otg_hs_xclk@4a009360 {
+	compatible = "gate-clock";
+	reg = <0x4a009360 0x4>;
+	bit-shift = <8>;
+	clocks = <&otg_60m_gfclk>;
+	#clock-cells = <0>;
+};
+
+usb_otg_hs_ick: usb_otg_hs_ick@4a009360 {
+	compatible = "gate-clock";
+	reg = <0x4a009360 0x4>;
+	bit-shift = <0>;
+	clocks = <&l3_div_ck>;
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
+usb_tll_hs_usb_ch2_clk: usb_tll_hs_usb_ch2_clk@4a009368 {
+	compatible = "gate-clock";
+	reg = <0x4a009368 0x4>;
+	bit-shift = <10>;
+	clocks = <&init_60m_fclk>;
+	#clock-cells = <0>;
+};
+
+usb_tll_hs_usb_ch0_clk: usb_tll_hs_usb_ch0_clk@4a009368 {
+	compatible = "gate-clock";
+	reg = <0x4a009368 0x4>;
+	bit-shift = <8>;
+	clocks = <&init_60m_fclk>;
+	#clock-cells = <0>;
+};
+
+usb_tll_hs_usb_ch1_clk: usb_tll_hs_usb_ch1_clk@4a009368 {
+	compatible = "gate-clock";
+	reg = <0x4a009368 0x4>;
+	bit-shift = <9>;
+	clocks = <&init_60m_fclk>;
+	#clock-cells = <0>;
+};
+
+usb_tll_hs_ick: usb_tll_hs_ick@4a009368 {
+	compatible = "gate-clock";
+	reg = <0x4a009368 0x4>;
+	bit-shift = <0>;
+	clocks = <&l4_div_ck>;
+	#clock-cells = <0>;
+};
+
+usim_ck: usim_ck@4a307858 {
+	compatible = "divider-clock";
+	clocks = <&dpll_per_m4x2_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a307858 0x4>;
+	bit-mask = <0x1>;
+	bit-shift = <24>;
+	table = < 14 0 >, < 18 1 >;
+};
+
+usim_fclk: usim_fclk@4a307858 {
+	compatible = "gate-clock";
+	reg = <0x4a307858 0x4>;
+	bit-shift = <8>;
+	clocks = <&usim_ck>;
+	#clock-cells = <0>;
+};
+
+/* Remaining optional clocks */
+pmd_stm_clock_mux_ck: pmd_stm_clock_mux_ck@4a307a20 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin_ck>, <&dpll_core_m6x2_ck>, <&tie_low_clock_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a307a20 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <20>;
+};
+
+pmd_trace_clk_mux_ck: pmd_trace_clk_mux_ck@4a307a20 {
+	compatible = "mux-clock";
+	clocks = <&sys_clkin_ck>, <&dpll_core_m6x2_ck>, <&tie_low_clock_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a307a20 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <22>;
+};
+
+stm_clk_div_ck: stm_clk_div_ck@4a307a20 {
+	compatible = "divider-clock";
+	clocks = <&pmd_stm_clock_mux_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a307a20 0x4>;
+	bit-mask = <0x7>;
+	bit-shift = <27>;
+	index-power-of-two;
+};
+
+trace_clk_div_div_ck: trace_clk_div_div_ck@4a307a20 {
+	compatible = "divider-clock";
+	clocks = <&pmd_trace_clk_mux_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a307a20 0x4>;
+	bit-mask = <0x7>;
+	bit-shift = <24>;
+	index-power-of-two;
+};
+
+trace_clk_div_ck: trace_clk_div_ck {
+	clocks = <&trace_clk_div_div_ck>;
+	#clock-cells = <0>;
+	ti,clkdm-name = "emu_sys_clkdm";
+	compatible = "ti,gate-clock";
+};
+
+/* SCRM aux clk nodes */
+auxclk0_src_mux_ck: auxclk0_src_mux_ck@4a30a310 {
+	compatible = "mux-clock";
+	reg = <0x4a30a310 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <1>;
+	clocks = <&sys_clkin_ck>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
+	#clock-cells = <0>;
+};
+
+auxclk0_src_ck: auxclk0_src_ck@4a30a310 {
+	compatible = "gate-clock";
+	#clock-cells = <0>;
+	reg = <0x4a30a310 0x4>;
+	bit-shift = <8>;
+	clocks = <&auxclk0_src_mux_ck>;
+};
+
+auxclk0_ck: auxclk0_ck@4a30a310 {
+	compatible = "divider-clock";
+	clocks = <&auxclk0_src_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a30a310 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <16>;
+};
+
+auxclk1_src_mux_ck: auxclk1_src_mux_ck@4a30a314 {
+	compatible = "mux-clock";
+	reg = <0x4a30a314 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <1>;
+	clocks = <&sys_clkin_ck>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
+	#clock-cells = <0>;
+};
+
+auxclk1_src_ck: auxclk1_src_ck@4a30a314 {
+	compatible = "gate-clock";
+	#clock-cells = <0>;
+	reg = <0x4a30a314 0x4>;
+	bit-shift = <8>;
+	clocks = <&auxclk1_src_mux_ck>;
+};
+
+auxclk1_ck: auxclk1_ck@4a30a314 {
+	compatible = "divider-clock";
+	clocks = <&auxclk1_src_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a30a314 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <16>;
+};
+
+auxclk2_src_mux_ck: auxclk2_src_mux_ck@4a30a318 {
+	compatible = "mux-clock";
+	reg = <0x4a30a318 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <1>;
+	clocks = <&sys_clkin_ck>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
+	#clock-cells = <0>;
+};
+
+auxclk2_src_ck: auxclk2_src_ck@4a30a318 {
+	compatible = "gate-clock";
+	#clock-cells = <0>;
+	reg = <0x4a30a318 0x4>;
+	bit-shift = <8>;
+	clocks = <&auxclk2_src_mux_ck>;
+};
+
+auxclk2_ck: auxclk2_ck@4a30a318 {
+	compatible = "divider-clock";
+	clocks = <&auxclk2_src_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a30a318 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <16>;
+};
+
+auxclk3_src_mux_ck: auxclk3_src_mux_ck@4a30a31c {
+	compatible = "mux-clock";
+	reg = <0x4a30a31c 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <1>;
+	clocks = <&sys_clkin_ck>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
+	#clock-cells = <0>;
+};
+
+auxclk3_src_ck: auxclk3_src_ck@4a30a31c {
+	compatible = "gate-clock";
+	#clock-cells = <0>;
+	reg = <0x4a30a31c 0x4>;
+	bit-shift = <8>;
+	clocks = <&auxclk3_src_mux_ck>;
+};
+
+auxclk3_ck: auxclk3_ck@4a30a31c {
+	compatible = "divider-clock";
+	clocks = <&auxclk3_src_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a30a31c 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <16>;
+};
+
+auxclk4_src_mux_ck: auxclk4_src_mux_ck@4a30a320 {
+	compatible = "mux-clock";
+	reg = <0x4a30a320 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <1>;
+	clocks = <&sys_clkin_ck>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
+	#clock-cells = <0>;
+};
+
+auxclk4_src_ck: auxclk4_src_ck@4a30a320 {
+	compatible = "gate-clock";
+	#clock-cells = <0>;
+	reg = <0x4a30a320 0x4>;
+	bit-shift = <8>;
+	clocks = <&auxclk4_src_mux_ck>;
+};
+
+auxclk4_ck: auxclk4_ck@4a30a320 {
+	compatible = "divider-clock";
+	clocks = <&auxclk4_src_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a30a320 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <16>;
+};
+
+auxclk5_src_mux_ck: auxclk5_src_mux_ck@4a30a324 {
+	compatible = "mux-clock";
+	reg = <0x4a30a324 0x4>;
+	bit-mask = <0x3>;
+	bit-shift = <1>;
+	clocks = <&sys_clkin_ck>, <&dpll_core_m3x2_ck>, <&dpll_per_m3x2_ck>;
+	#clock-cells = <0>;
+};
+
+auxclk5_src_ck: auxclk5_src_ck@4a30a324 {
+	compatible = "gate-clock";
+	#clock-cells = <0>;
+	reg = <0x4a30a324 0x4>;
+	bit-shift = <8>;
+	clocks = <&auxclk5_src_mux_ck>;
+};
+
+auxclk5_ck: auxclk5_ck@4a30a324 {
+	compatible = "divider-clock";
+	clocks = <&auxclk5_src_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a30a324 0x4>;
+	bit-mask = <0xf>;
+	bit-shift = <16>;
+};
+
+auxclkreq0_ck: auxclkreq0_ck@4a30a210 {
+	compatible = "mux-clock";
+	clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>, <&auxclk5_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a30a210 0x4>;
+	bit-mask = <0x7>;
+	bit-shift = <2>;
+};
+
+auxclkreq1_ck: auxclkreq1_ck@4a30a214 {
+	compatible = "mux-clock";
+	clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>, <&auxclk5_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a30a214 0x4>;
+	bit-mask = <0x7>;
+	bit-shift = <2>;
+};
+
+auxclkreq2_ck: auxclkreq2_ck@4a30a218 {
+	compatible = "mux-clock";
+	clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>, <&auxclk5_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a30a218 0x4>;
+	bit-mask = <0x7>;
+	bit-shift = <2>;
+};
+
+auxclkreq3_ck: auxclkreq3_ck@4a30a21c {
+	compatible = "mux-clock";
+	clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>, <&auxclk5_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a30a21c 0x4>;
+	bit-mask = <0x7>;
+	bit-shift = <2>;
+};
+
+auxclkreq4_ck: auxclkreq4_ck@4a30a220 {
+	compatible = "mux-clock";
+	clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>, <&auxclk5_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a30a220 0x4>;
+	bit-mask = <0x7>;
+	bit-shift = <2>;
+};
+
+auxclkreq5_ck: auxclkreq5_ck@4a30a224 {
+	compatible = "mux-clock";
+	clocks = <&auxclk0_ck>, <&auxclk1_ck>, <&auxclk2_ck>, <&auxclk3_ck>, <&auxclk4_ck>, <&auxclk5_ck>;
+	#clock-cells = <0>;
+	reg = <0x4a30a224 0x4>;
+	bit-mask = <0x7>;
+	bit-shift = <2>;
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 2a56428..8e142f9 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -81,6 +81,8 @@
 		};
 	};
 
+	/include/ "omap4-clocks.dtsi"
+
 	/*
 	 * XXX: Use a flat representation of the OMAP4 interconnect.
 	 * The real OMAP interconnect network is quite complex.
-- 
1.7.9.5

