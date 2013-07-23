From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 28/33] ARM: dts: omap3 clock data
Date: Tue, 23 Jul 2013 10:20:23 +0300
Message-ID: <1374564028-11352-29-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48720 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775Ab3GWHXm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 03:23:42 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

This patch creates a unique node for each clock in the OMAP3 power,
reset and clock manager (PRCM).

TODO: add still missing am35xx only clock nodes

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi                       |    7 +
 arch/arm/boot/dts/omap3430es1-clocks.dtsi          |  166 ++
 arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi    |  240 +++
 arch/arm/boot/dts/omap34xx.dtsi                    |    9 +
 .../omap36xx-am35xx-omap3430es2plus-clocks.dtsi    |  214 +++
 arch/arm/boot/dts/omap36xx-clocks.dtsi             |   97 ++
 .../boot/dts/omap36xx-omap3430es2plus-clocks.dtsi  |  185 +++
 arch/arm/boot/dts/omap36xx.dtsi                    |   10 +
 arch/arm/boot/dts/omap3xxx-clocks.dtsi             | 1594 ++++++++++++++++++++
 9 files changed, 2522 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3430es1-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/omap36xx-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/omap3xxx-clocks.dtsi

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 7d95cda..939cc20 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -533,4 +533,11 @@
 			ram-bits = <12>;
 		};
 	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		/include/ "omap3xxx-clocks.dtsi"
+	};
 };
diff --git a/arch/arm/boot/dts/omap3430es1-clocks.dtsi b/arch/arm/boot/dts/omap3430es1-clocks.dtsi
new file mode 100644
index 0000000..1d85f45
--- /dev/null
+++ b/arch/arm/boot/dts/omap3430es1-clocks.dtsi
@@ -0,0 +1,166 @@
+/*
+ * Device Tree Source for OMAP3430 ES1 clock data
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+gfx_l3_fck: gfx_l3_fck@48004b40 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&l3_ick>;
+	reg = <0x48004b40 0x4>;
+	bit-mask = <0x7>;
+	index-starts-at-one;
+};
+
+gfx_l3_ck: gfx_l3_ck {
+	#clock-cells = <0>;
+	compatible = ;
+};
+
+gfx_l3_ick: gfx_l3_ick {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&gfx_l3_ck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+gfx_cg1_ck: gfx_cg1_ck@48004b00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&gfx_l3_fck>;
+	reg = <0x48004b00 0x4>;
+	ti,clkdm-name = "gfx_3430es1_clkdm";
+	ti,enable-bit = <1>;
+};
+
+gfx_cg2_ck: gfx_cg2_ck@48004b00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&gfx_l3_fck>;
+	reg = <0x48004b00 0x4>;
+	ti,clkdm-name = "gfx_3430es1_clkdm";
+	ti,enable-bit = <2>;
+};
+
+d2d_26m_fck: d2d_26m_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "d2d_clkdm";
+	ti,enable-bit = <3>;
+};
+
+fshostusb_fck: fshostusb_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <5>;
+};
+
+ssi_ssr_div_fck_3430es1: ssi_ssr_div_fck_3430es1@48004a40 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&corex2_fck>;
+	bit-shift = <8>;
+	reg = <0x48004a40 0x4>;
+	table = < 1 1 >, < 2 2 >, < 3 3 >, < 4 4 >, < 6 6 >, < 8 8 >;
+	bit-mask = <0xf>;
+};
+
+ssi_ssr_fck_3430es1: ssi_ssr_fck_3430es1@48004a00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&ssi_ssr_div_fck_3430es1>;
+	bit-shift = <0>;
+	reg = <0x48004a00 0x4>;
+};
+
+ssi_sst_fck_3430es1: ssi_sst_fck_3430es1 {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&ssi_ssr_fck_3430es1>;
+	clock-mult = <1>;
+	clock-div = <2>;
+};
+
+hsotgusb_ick_3430es1: hsotgusb_ick_3430es1@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l3_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l3_clkdm";
+	ti,enable-bit = <4>;
+	ti,iclk-no-wait;
+};
+
+fac_ick: fac_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <8>;
+};
+
+ssi_l4_ick: ssi_l4_ick {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&l4_ick>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+ssi_ick_3430es1: ssi_ick_3430es1@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&ssi_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <0>;
+	ti,iclk-no-wait;
+};
+
+usb_l4_div_ick: usb_l4_div_ick@48004a40 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&l4_ick>;
+	bit-shift = <4>;
+	reg = <0x48004a40 0x4>;
+	bit-mask = <0x3>;
+	index-starts-at-one;
+};
+
+usb_l4_ick: usb_l4_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&usb_l4_div_ick>;
+	bit-shift = <5>;
+	reg = <0x48004a10 0x4>;
+};
+
+dss1_alwon_fck_3430es1: dss1_alwon_fck_3430es1@48004e00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&dpll4_m4x2_ck>;
+	reg = <0x48004e00 0x4>;
+	bit-shift = <0>;
+};
+
+dss_ick_3430es1: dss_ick_3430es1@48004e10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&l4_ick>;
+	reg = <0x48004e10 0x4>;
+	ti,clkdm-name = "dss_clkdm";
+	ti,enable-bit = <0>;
+	ti,iclk-no-wait;
+};
diff --git a/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi b/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi
new file mode 100644
index 0000000..8da7ba1
--- /dev/null
+++ b/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi
@@ -0,0 +1,240 @@
+/*
+ * Device Tree Source for OMAP34xx/OMAP36xx clock data
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+security_l4_ick2: security_l4_ick2 {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&l4_ick>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+aes1_ick: aes1_ick@48004a14 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&security_l4_ick2>;
+	reg = <0x48004a14 0x4>;
+	ti,enable-bit = <3>;
+};
+
+rng_ick: rng_ick@48004a14 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&security_l4_ick2>;
+	reg = <0x48004a14 0x4>;
+	ti,enable-bit = <2>;
+};
+
+sha11_ick: sha11_ick@48004a14 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&security_l4_ick2>;
+	reg = <0x48004a14 0x4>;
+	ti,enable-bit = <1>;
+};
+
+des1_ick: des1_ick@48004a14 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&security_l4_ick2>;
+	reg = <0x48004a14 0x4>;
+	ti,enable-bit = <0>;
+};
+
+cam_mclk: cam_mclk@48004f00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&dpll4_m5x2_ck>;
+	bit-shift = <0>;
+	reg = <0x48004f00 0x4>;
+	set-rate-parent;
+};
+
+cam_ick: cam_ick@48004f10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&l4_ick>;
+	reg = <0x48004f10 0x4>;
+	ti,clkdm-name = "cam_clkdm";
+	ti,enable-bit = <0>;
+	ti,iclk-no-wait;
+};
+
+csi2_96m_fck: csi2_96m_fck@48004f00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004f00 0x4>;
+	bit-shift = <1>;
+};
+
+security_l3_ick: security_l3_ick {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&l3_ick>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+pka_ick: pka_ick@48004a14 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&security_l3_ick>;
+	reg = <0x48004a14 0x4>;
+	ti,enable-bit = <4>;
+};
+
+icr_ick: icr_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <29>;
+};
+
+des2_ick: des2_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <26>;
+};
+
+mspro_ick: mspro_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <23>;
+};
+
+mailboxes_ick: mailboxes_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <7>;
+};
+
+ssi_l4_ick: ssi_l4_ick {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&l4_ick>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+sr1_fck: sr1_fck@48004c00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x48004c00 0x4>;
+	ti,clkdm-name = "wkup_clkdm";
+	ti,enable-bit = <6>;
+};
+
+sr2_fck: sr2_fck@48004c00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x48004c00 0x4>;
+	ti,clkdm-name = "wkup_clkdm";
+	ti,enable-bit = <7>;
+};
+
+sr_l4_ick: sr_l4_ick {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&l4_ick>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+dpll2_fck: dpll2_fck@48004040 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&core_ck>;
+	bit-shift = <19>;
+	reg = <0x48004040 0x4>;
+	bit-mask = <0x7>;
+	index-starts-at-one;
+};
+
+dpll2_ck: dpll2_ck@48004004 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-dpll-clock";
+	clocks = <&sys_ck>;
+	ti,modes = <0xa2>;
+	ti,clk-bypass = <&dpll2_fck>;
+	reg = <0x48004004 0x4>, <0x48004024 0x4>, <0x48004034 0x4>, <0x48004040 0x4>;
+	ti,clkdm-name = "dpll2_clkdm";
+	ti,clk-ref = <&sys_ck>;
+	ti,recal-en-bit = <0x8>;
+	ti,auto-recal-bit = <0x3>;
+	ti,recal-st-bit = <0x8>;
+};
+
+dpll2_m2_ck: dpll2_m2_ck@48004044 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&dpll2_ck>;
+	reg = <0x48004044 0x4>;
+	bit-mask = <0x1f>;
+	index-starts-at-one;
+};
+
+iva2_ck: iva2_ck@48004000 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&dpll2_m2_ck>;
+	reg = <0x48004000 0x4>;
+	ti,clkdm-name = "iva2_clkdm";
+	ti,enable-bit = <0>;
+};
+
+modem_fck: modem_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&sys_ck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "d2d_clkdm";
+	ti,enable-bit = <31>;
+};
+
+sad2d_ick: sad2d_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&l3_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "d2d_clkdm";
+	ti,enable-bit = <3>;
+};
+
+mad2d_ick: mad2d_ick@48004a18 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&l3_ick>;
+	reg = <0x48004a18 0x4>;
+	ti,clkdm-name = "d2d_clkdm";
+	ti,enable-bit = <3>;
+};
+
+mspro_fck: mspro_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <23>;
+};
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 5355d61..5f3c2ca 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -25,4 +25,13 @@
 			clock-latency = <300000>; /* From legacy driver */
 		};
 	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		/include/ "omap34xx-omap36xx-clocks.dtsi"
+		/include/ "omap36xx-omap3430es2plus-clocks.dtsi"
+		/include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
+	};
 };
diff --git a/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi b/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
new file mode 100644
index 0000000..e0bdfb3
--- /dev/null
+++ b/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
@@ -0,0 +1,214 @@
+/*
+ * Device Tree Source for OMAP36xx/AM35xx/OMAP34xx clock data
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+dpll5_ck: dpll5_ck@48004d04 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-dpll-clock";
+	clocks = <&sys_ck>;
+	ti,modes = <0x82>;
+	ti,clk-bypass = <&sys_ck>;
+	reg = <0x48004d04 0x4>, <0x48004d24 0x4>, <0x48004d34 0x4>, <0x48004d4c 0x4>;
+	ti,clkdm-name = "dpll5_clkdm";
+	ti,clk-ref = <&sys_ck>;
+	ti,recal-en-bit = <0x19>;
+	ti,auto-recal-bit = <0x3>;
+	ti,recal-st-bit = <0x19>;
+};
+
+dpll5_m2_ck: dpll5_m2_ck@48004d50 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&dpll5_ck>;
+	reg = <0x48004d50 0x4>;
+	bit-mask = <0x1f>;
+	index-starts-at-one;
+};
+
+core_d3_ck: core_d3_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&core_ck>;
+	clock-mult = <1>;
+	clock-div = <3>;
+};
+
+core_d4_ck: core_d4_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&core_ck>;
+	clock-mult = <1>;
+	clock-div = <4>;
+};
+
+core_d6_ck: core_d6_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&core_ck>;
+	clock-mult = <1>;
+	clock-div = <6>;
+};
+
+omap_192m_alwon_fck: omap_192m_alwon_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll4_m2x2_ck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+core_d2_ck: core_d2_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&core_ck>;
+	clock-mult = <1>;
+	clock-div = <2>;
+};
+
+corex2_d3_fck: corex2_d3_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&corex2_fck>;
+	clock-mult = <1>;
+	clock-div = <3>;
+};
+
+corex2_d5_fck: corex2_d5_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&corex2_fck>;
+	clock-mult = <1>;
+	clock-div = <5>;
+};
+
+sgx_mux_fck: sgx_mux_fck@48004b40 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&core_d3_ck>, <&core_d4_ck>, <&core_d6_ck>, <&cm_96m_fck>, <&omap_192m_alwon_fck>, <&core_d2_ck>, <&corex2_d3_fck>, <&corex2_d5_fck>;
+	reg = <0x48004b40 0x4>;
+	table = <&core_d3_ck 0>, <&core_d4_ck 1>, <&core_d6_ck 2>, <&cm_96m_fck 3>, <&omap_192m_alwon_fck 4>, <&core_d2_ck 5>, <&corex2_d3_fck 6>, <&corex2_d5_fck 7>;
+	bit-mask = <0x7>;
+};
+
+sgx_fck: sgx_fck@48004b00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&sgx_mux_fck>;
+	bit-shift = <1>;
+	reg = <0x48004b00 0x4>;
+};
+
+sgx_ick: sgx_ick@48004b10 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&l3_ick>;
+	reg = <0x48004b10 0x4>;
+	ti,clkdm-name = "sgx_clkdm";
+	ti,enable-bit = <0>;
+};
+
+cpefuse_fck: cpefuse_fck@48004a08 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x48004a08 0x4>;
+	bit-shift = <0>;
+};
+
+ts_fck: ts_fck@48004a08 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&omap_32k_fck>;
+	reg = <0x48004a08 0x4>;
+	bit-shift = <1>;
+};
+
+usbtll_fck: usbtll_fck@48004a08 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&dpll5_m2_ck>;
+	reg = <0x48004a08 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <2>;
+};
+
+usbtll_ick: usbtll_ick@48004a18 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a18 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <2>;
+};
+
+mmchs3_ick: mmchs3_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <30>;
+};
+
+mmchs3_fck: mmchs3_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <30>;
+};
+
+dss1_alwon_fck_3430es2: dss1_alwon_fck_3430es2@48004e00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&dpll4_m4x2_ck>;
+	reg = <0x48004e00 0x4>;
+	ti,clkdm-name = "dss_clkdm";
+	ti,enable-bit = <0>;
+	ti,dss-clk;
+};
+
+dss_ick_3430es2: dss_ick_3430es2@48004e10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&l4_ick>;
+	reg = <0x48004e10 0x4>;
+	ti,clkdm-name = "dss_clkdm";
+	ti,enable-bit = <0>;
+	ti,iclk-dss;
+};
+
+usbhost_120m_fck: usbhost_120m_fck@48005400 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&dpll5_m2_ck>;
+	reg = <0x48005400 0x4>;
+	bit-shift = <1>;
+};
+
+usbhost_48m_fck: usbhost_48m_fck@48005400 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&omap_48m_fck>;
+	reg = <0x48005400 0x4>;
+	ti,clkdm-name = "usbhost_clkdm";
+	ti,enable-bit = <0>;
+	ti,dss-clk;
+};
+
+usbhost_ick: usbhost_ick@48005410 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&l4_ick>;
+	reg = <0x48005410 0x4>;
+	ti,clkdm-name = "usbhost_clkdm";
+	ti,enable-bit = <0>;
+	ti,iclk-dss;
+};
diff --git a/arch/arm/boot/dts/omap36xx-clocks.dtsi b/arch/arm/boot/dts/omap36xx-clocks.dtsi
new file mode 100644
index 0000000..a52faa4
--- /dev/null
+++ b/arch/arm/boot/dts/omap36xx-clocks.dtsi
@@ -0,0 +1,97 @@
+/*
+ * Device Tree Source for OMAP36xx clock data
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+dpll4_ck: dpll4_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-dpll-clock";
+	clocks = <&sys_ck>;
+	ti,autoidle-mask = <0x38>;
+	ti,idlest-mask = <0x2>;
+	ti,clkdm-name = "dpll4_clkdm";
+	ti,recal-en-bit = <0x6>;
+	ti,auto-recal-bit = <0x13>;
+	ti,enable-mask = <0x70000>;
+	ti,recal-st-bit = <0x6>;
+	ti,clk-bypass = <&sys_ck>;
+	ti,modes = <0x82>;
+	ti,dco-mask = <0xe00000>;
+	reg = <0x48004d00 0x4>, <0x48004d20 0x4>, <0x48004d30 0x4>, <0x48004d44 0x4>;
+	ti,clk-ref = <&sys_ck>;
+	ti,dpll-j-type;
+	ti,dpll-peripheral;
+};
+
+dpll4_m2x2_ck: dpll4_m2x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&dpll4_m2x2_mul_ck>;
+	bit-shift = <0x1b>;
+	reg = <0x48004d00 0x4>;
+	set-bit-to-disable;
+	ti,hsdiv-restore;
+};
+
+dpll3_m3x2_ck: dpll3_m3x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&dpll3_m3x2_mul_ck>;
+	bit-shift = <0xc>;
+	reg = <0x48004d00 0x4>;
+	set-bit-to-disable;
+	ti,hsdiv-restore;
+};
+
+dpll4_m3x2_ck: dpll4_m3x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&dpll4_m3x2_mul_ck>;
+	bit-shift = <0x1c>;
+	reg = <0x48004d00 0x4>;
+	set-bit-to-disable;
+	ti,hsdiv-restore;
+};
+
+dpll4_m5x2_ck: dpll4_m5x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&dpll4_m5x2_mul_ck>;
+	bit-shift = <0x1e>;
+	reg = <0x48004d00 0x4>;
+	ti,hsdiv-restore;
+	set-rate-parent;
+	set-bit-to-disable;
+};
+
+dpll4_m6x2_ck: dpll4_m6x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&dpll4_m6x2_mul_ck>;
+	bit-shift = <0x1f>;
+	reg = <0x48004d00 0x4>;
+	set-bit-to-disable;
+	ti,hsdiv-restore;
+};
+
+omap_192m_alwon_fck: omap_192m_alwon_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll4_m2x2_ck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+uart4_fck: uart4_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&per_48m_fck>;
+	reg = <0x48005000 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <18>;
+};
diff --git a/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi b/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
new file mode 100644
index 0000000..0b93647
--- /dev/null
+++ b/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
@@ -0,0 +1,185 @@
+/*
+ * Device Tree Source for OMAP34xx/OMAP36xx clock data
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+ssi_ssr_div_fck_3430es2: ssi_ssr_div_fck_3430es2@48004a40 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&corex2_fck>;
+	bit-shift = <8>;
+	reg = <0x48004a40 0x4>;
+	table = < 1 1 >, < 2 2 >, < 3 3 >, < 4 4 >, < 6 6 >, < 8 8 >;
+	bit-mask = <0xf>;
+};
+
+ssi_ssr_fck_3430es2: ssi_ssr_fck_3430es2@48004a00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&ssi_ssr_div_fck_3430es2>;
+	bit-shift = <0>;
+	reg = <0x48004a00 0x4>;
+};
+
+ssi_sst_fck_3430es2: ssi_sst_fck_3430es2 {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&ssi_ssr_fck_3430es2>;
+	clock-mult = <1>;
+	clock-div = <2>;
+};
+
+hsotgusb_ick_3430es2: hsotgusb_ick_3430es2@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l3_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l3_clkdm";
+	ti,enable-bit = <4>;
+	ti,iclk-hsotgusb;
+};
+
+ssi_l4_ick: ssi_l4_ick {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&l4_ick>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+ssi_ick_3430es2: ssi_ick_3430es2@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&ssi_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <0>;
+	ti,iclk-ssi;
+};
+
+dpll5_ck: dpll5_ck@48004d04 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-dpll-clock";
+	clocks = <&sys_ck>;
+	ti,modes = <0x82>;
+	ti,clk-bypass = <&sys_ck>;
+	reg = <0x48004d04 0x4>, <0x48004d24 0x4>, <0x48004d34 0x4>, <0x48004d4c 0x4>;
+	ti,clkdm-name = "dpll5_clkdm";
+	ti,clk-ref = <&sys_ck>;
+	ti,recal-en-bit = <0x19>;
+	ti,auto-recal-bit = <0x3>;
+	ti,recal-st-bit = <0x19>;
+};
+
+dpll5_m2_ck: dpll5_m2_ck@48004d50 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&dpll5_ck>;
+	reg = <0x48004d50 0x4>;
+	bit-mask = <0x1f>;
+	index-starts-at-one;
+};
+
+dpll5_m2_d20_ck: dpll5_m2_d20_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll5_m2_ck>;
+	clock-mult = <1>;
+	clock-div = <20>;
+};
+
+sys_d2_ck: sys_d2_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&sys_ck>;
+	clock-mult = <1>;
+	clock-div = <2>;
+};
+
+omap_96m_d2_fck: omap_96m_d2_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&omap_96m_fck>;
+	clock-mult = <1>;
+	clock-div = <2>;
+};
+
+omap_96m_d4_fck: omap_96m_d4_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&omap_96m_fck>;
+	clock-mult = <1>;
+	clock-div = <4>;
+};
+
+omap_96m_d8_fck: omap_96m_d8_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&omap_96m_fck>;
+	clock-mult = <1>;
+	clock-div = <8>;
+};
+
+omap_96m_d10_fck: omap_96m_d10_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&omap_96m_fck>;
+	clock-mult = <1>;
+	clock-div = <10>;
+};
+
+dpll5_m2_d4_ck: dpll5_m2_d4_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll5_m2_ck>;
+	clock-mult = <1>;
+	clock-div = <4>;
+};
+
+dpll5_m2_d8_ck: dpll5_m2_d8_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll5_m2_ck>;
+	clock-mult = <1>;
+	clock-div = <8>;
+};
+
+dpll5_m2_d16_ck: dpll5_m2_d16_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll5_m2_ck>;
+	clock-mult = <1>;
+	clock-div = <16>;
+};
+
+usim_mux_fck: usim_mux_fck@48004c40 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&sys_ck>, <&dpll5_m2_d20_ck>, <&sys_d2_ck>, <&omap_96m_d2_fck>, <&omap_96m_d4_fck>, <&omap_96m_d8_fck>, <&omap_96m_d10_fck>, <&dpll5_m2_d4_ck>, <&dpll5_m2_d8_ck>, <&dpll5_m2_d16_ck>;
+	bit-shift = <3>;
+	reg = <0x48004c40 0x4>;
+	table = <&sys_ck 1>, <&dpll5_m2_d20_ck 10>, <&sys_d2_ck 2>, <&omap_96m_d2_fck 3>, <&omap_96m_d4_fck 4>, <&omap_96m_d8_fck 5>, <&omap_96m_d10_fck 6>, <&dpll5_m2_d4_ck 7>, <&dpll5_m2_d8_ck 8>, <&dpll5_m2_d16_ck 9>;
+	bit-mask = <0xf>;
+};
+
+usim_fck: usim_fck@48004c00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&usim_mux_fck>;
+	bit-shift = <9>;
+	reg = <0x48004c00 0x4>;
+};
+
+usim_ick: usim_ick@48004c10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&wkup_l4_ick>;
+	reg = <0x48004c10 0x4>;
+	ti,clkdm-name = "wkup_clkdm";
+	ti,enable-bit = <9>;
+};
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index f8b3765..583c212 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -35,4 +35,14 @@
 			clock-frequency = <48000000>;
 		};
 	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		/include/ "omap36xx-clocks.dtsi"
+		/include/ "omap34xx-omap36xx-clocks.dtsi"
+		/include/ "omap36xx-omap3430es2plus-clocks.dtsi"
+		/include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
+	};
 };
diff --git a/arch/arm/boot/dts/omap3xxx-clocks.dtsi b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
new file mode 100644
index 0000000..18a723f
--- /dev/null
+++ b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
@@ -0,0 +1,1594 @@
+/*
+ * Device Tree Source for OMAP3 clock data
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+dummy_apb_pclk: dummy_apb_pclk {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0x0>;
+};
+
+omap_32k_fck: omap_32k_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <32768>;
+};
+
+virt_12m_ck: virt_12m_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <12000000>;
+};
+
+virt_13m_ck: virt_13m_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <13000000>;
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
+virt_38_4m_ck: virt_38_4m_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <38400000>;
+};
+
+virt_16_8m_ck: virt_16_8m_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <16800000>;
+};
+
+osc_sys_ck: osc_sys_ck@48306d40 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&virt_12m_ck>, <&virt_13m_ck>, <&virt_19200000_ck>, <&virt_26000000_ck>, <&virt_38_4m_ck>, <&virt_16_8m_ck>;
+	reg = <0x48306d40 0x4>;
+	bit-mask = <0x7>;
+};
+
+sys_ck: sys_ck@48307270 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&osc_sys_ck>;
+	bit-shift = <6>;
+	reg = <0x48307270 0x4>;
+	bit-mask = <0x3>;
+	index-starts-at-one;
+};
+
+dpll4_ck: dpll4_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-dpll-clock";
+	clocks = <&sys_ck>;
+	ti,autoidle-mask = <0x38>;
+	ti,modes = <0x82>;
+	ti,clk-bypass = <&sys_ck>;
+	ti,idlest-mask = <0x2>;
+	reg = <0x48004d00 0x4>, <0x48004d20 0x4>, <0x48004d30 0x4>, <0x48004d44 0x4>;
+	ti,clkdm-name = "dpll4_clkdm";
+	ti,clk-ref = <&sys_ck>;
+	ti,recal-en-bit = <0x6>;
+	ti,auto-recal-bit = <0x13>;
+	ti,enable-mask = <0x70000>;
+	ti,recal-st-bit = <0x6>;
+	ti,dpll-peripheral;
+};
+
+dpll4_m2_ck: dpll4_m2_ck@48004d48 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&dpll4_ck>;
+	reg = <0x48004d48 0x4>;
+	bit-mask = <0x3f>;
+	index-starts-at-one;
+};
+
+dpll4_m2x2_mul_ck: dpll4_m2x2_mul_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll4_m2_ck>;
+	clock-mult = <2>;
+	clock-div = <1>;
+};
+
+dpll4_m2x2_ck: dpll4_m2x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&dpll4_m2x2_mul_ck>;
+	bit-shift = <0x1b>;
+	reg = <0x48004d00 0x4>;
+	set-bit-to-disable;
+};
+
+omap_96m_alwon_fck: omap_96m_alwon_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll4_m2x2_ck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+dpll3_ck: dpll3_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-dpll-clock";
+	clocks = <&sys_ck>;
+	ti,clk-bypass = <&sys_ck>;
+	reg = <0x48004d00 0x4>, <0x48004d20 0x4>, <0x48004d30 0x4>, <0x48004d40 0x4>;
+	ti,clk-ref = <&sys_ck>;
+	ti,clkdm-name = "dpll3_clkdm";
+	ti,recal-en-bit = <0x5>;
+	ti,auto-recal-bit = <0x3>;
+	ti,recal-st-bit = <0x5>;
+	ti,dpll-core;
+};
+
+dpll3_m3_ck: dpll3_m3_ck@48005140 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&dpll3_ck>;
+	bit-shift = <16>;
+	reg = <0x48005140 0x4>;
+	bit-mask = <0x1f>;
+	index-starts-at-one;
+};
+
+dpll3_m3x2_mul_ck: dpll3_m3x2_mul_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll3_m3_ck>;
+	clock-mult = <2>;
+	clock-div = <1>;
+};
+
+dpll3_m3x2_ck: dpll3_m3x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&dpll3_m3x2_mul_ck>;
+	bit-shift = <0xc>;
+	reg = <0x48004d00 0x4>;
+	set-bit-to-disable;
+};
+
+emu_core_alwon_ck: emu_core_alwon_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll3_m3x2_ck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+sys_altclk: sys_altclk {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0x0>;
+};
+
+mcbsp_clks: mcbsp_clks {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0x0>;
+};
+
+sys_clkout1: sys_clkout1@48306d70 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&osc_sys_ck>;
+	reg = <0x48306d70 0x4>;
+	bit-shift = <7>;
+};
+
+dpll1_ck: dpll1_ck@48004904 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-dpll-clock";
+	clocks = <&sys_ck>;
+	ti,clk-bypass = <&dpll1_fck>;
+	reg = <0x48004904 0x4>, <0x48004924 0x4>, <0x48004934 0x4>, <0x48004940 0x4>;
+	ti,clk-ref = <&sys_ck>;
+	ti,clkdm-name = "dpll1_clkdm";
+	ti,recal-en-bit = <0x7>;
+	ti,auto-recal-bit = <0x3>;
+	ti,recal-st-bit = <0x7>;
+};
+
+dpll1_x2_ck: dpll1_x2_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll1_ck>;
+	clock-mult = <2>;
+	clock-div = <1>;
+};
+
+dpll1_x2m2_ck: dpll1_x2m2_ck@48004944 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&dpll1_x2_ck>;
+	reg = <0x48004944 0x4>;
+	bit-mask = <0x1f>;
+	index-starts-at-one;
+};
+
+dpll3_m2_ck: dpll3_m2_ck@48004d40 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&dpll3_ck>;
+	bit-shift = <27>;
+	reg = <0x48004d40 0x4>;
+	bit-mask = <0x1f>;
+	index-starts-at-one;
+};
+
+core_ck: core_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll3_m2_ck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+dpll3_x2_ck: dpll3_x2_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll3_ck>;
+	clock-mult = <2>;
+	clock-div = <1>;
+};
+
+dpll3_m2x2_ck: dpll3_m2x2_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll3_m2_ck>;
+	clock-mult = <2>;
+	clock-div = <1>;
+};
+
+dpll4_x2_ck: dpll4_x2_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll4_ck>;
+	clock-mult = <2>;
+	clock-div = <1>;
+};
+
+cm_96m_fck: cm_96m_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&omap_96m_alwon_fck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+omap_96m_fck: omap_96m_fck@48004d40 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&cm_96m_fck>, <&sys_ck>;
+	bit-shift = <6>;
+	reg = <0x48004d40 0x4>;
+	bit-mask = <0x1>;
+};
+
+dpll4_m3_ck: dpll4_m3_ck@48004e40 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&dpll4_ck>;
+	bit-shift = <8>;
+	reg = <0x48004e40 0x4>;
+	bit-mask = <0x3f>;
+	index-starts-at-one;
+};
+
+dpll4_m3x2_mul_ck: dpll4_m3x2_mul_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll4_m3_ck>;
+	clock-mult = <2>;
+	clock-div = <1>;
+};
+
+dpll4_m3x2_ck: dpll4_m3x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&dpll4_m3x2_mul_ck>;
+	bit-shift = <0x1c>;
+	reg = <0x48004d00 0x4>;
+	set-bit-to-disable;
+};
+
+omap_54m_fck: omap_54m_fck@48004d40 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&dpll4_m3x2_ck>, <&sys_altclk>;
+	bit-shift = <5>;
+	reg = <0x48004d40 0x4>;
+	bit-mask = <0x1>;
+};
+
+cm_96m_d2_fck: cm_96m_d2_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&cm_96m_fck>;
+	clock-mult = <1>;
+	clock-div = <2>;
+};
+
+omap_48m_fck: omap_48m_fck@48004d40 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&cm_96m_d2_fck>, <&sys_altclk>;
+	bit-shift = <3>;
+	reg = <0x48004d40 0x4>;
+	table = <&cm_96m_d2_fck 0>, <&sys_altclk 1>;
+	bit-mask = <0x1>;
+};
+
+omap_12m_fck: omap_12m_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&omap_48m_fck>;
+	clock-mult = <1>;
+	clock-div = <4>;
+};
+
+dpll4_m4_ck: dpll4_m4_ck@48004e40 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&dpll4_ck>;
+	reg = <0x48004e40 0x4>;
+	bit-mask = <0x3f>;
+	index-starts-at-one;
+};
+
+dpll4_m4x2_mul_ck: dpll4_m4x2_mul_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll4_m4_ck>;
+	clock-mult = <2>;
+	clock-div = <1>;
+};
+
+dpll4_m4x2_ck: dpll4_m4x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&dpll4_m4x2_mul_ck>;
+	bit-shift = <0x1d>;
+	reg = <0x48004d00 0x4>;
+	set-bit-to-disable;
+};
+
+dpll4_m5_ck: dpll4_m5_ck@48004f40 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&dpll4_ck>;
+	reg = <0x48004f40 0x4>;
+	bit-mask = <0x3f>;
+	index-starts-at-one;
+};
+
+dpll4_m5x2_mul_ck: dpll4_m5x2_mul_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll4_m5_ck>;
+	clock-mult = <2>;
+	clock-div = <1>;
+};
+
+dpll4_m5x2_ck: dpll4_m5x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&dpll4_m5x2_mul_ck>;
+	bit-shift = <0x1e>;
+	reg = <0x48004d00 0x4>;
+	set-bit-to-disable;
+};
+
+dpll4_m6_ck: dpll4_m6_ck@48005140 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&dpll4_ck>;
+	bit-shift = <24>;
+	reg = <0x48005140 0x4>;
+	bit-mask = <0x3f>;
+	index-starts-at-one;
+};
+
+dpll4_m6x2_mul_ck: dpll4_m6x2_mul_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll4_m6_ck>;
+	clock-mult = <2>;
+	clock-div = <1>;
+};
+
+dpll4_m6x2_ck: dpll4_m6x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&dpll4_m6x2_mul_ck>;
+	bit-shift = <0x1f>;
+	reg = <0x48004d00 0x4>;
+	set-bit-to-disable;
+};
+
+emu_per_alwon_ck: emu_per_alwon_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll4_m6x2_ck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+clkout2_src_mux_ck: clkout2_src_mux_ck@48004d70 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&core_ck>, <&sys_ck>, <&cm_96m_fck>, <&omap_54m_fck>;
+	reg = <0x48004d70 0x4>;
+	bit-mask = <0x3>;
+};
+
+clkout2_src_ck: clkout2_src_ck@48004d70 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&clkout2_src_mux_ck>;
+	bit-shift = <7>;
+	reg = <0x48004d70 0x4>;
+};
+
+sys_clkout2: sys_clkout2@48004d70 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&clkout2_src_ck>;
+	bit-shift = <3>;
+	reg = <0x48004d70 0x4>;
+	bit-mask = <0x7>;
+	index-power-of-two;
+};
+
+corex2_fck: corex2_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll3_m2x2_ck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+dpll1_fck: dpll1_fck@48004940 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&core_ck>;
+	bit-shift = <19>;
+	reg = <0x48004940 0x4>;
+	bit-mask = <0x7>;
+	index-starts-at-one;
+};
+
+mpu_ck: mpu_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&dpll1_x2m2_ck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+arm_fck: arm_fck@48004924 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&mpu_ck>;
+	reg = <0x48004924 0x4>;
+	bit-mask = <0x1>;
+};
+
+emu_mpu_alwon_ck: emu_mpu_alwon_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&mpu_ck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+l3_ick: l3_ick@48004a40 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&core_ck>;
+	reg = <0x48004a40 0x4>;
+	bit-mask = <0x3>;
+	index-starts-at-one;
+};
+
+l4_ick: l4_ick@48004a40 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&l3_ick>;
+	bit-shift = <2>;
+	reg = <0x48004a40 0x4>;
+	bit-mask = <0x3>;
+	index-starts-at-one;
+};
+
+rm_ick: rm_ick@48004c40 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&l4_ick>;
+	bit-shift = <1>;
+	reg = <0x48004c40 0x4>;
+	bit-mask = <0x3>;
+	index-starts-at-one;
+};
+
+gpt10_mux_fck: gpt10_mux_fck@48004a40 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	bit-shift = <6>;
+	reg = <0x48004a40 0x4>;
+	bit-mask = <0x1>;
+};
+
+gpt10_fck: gpt10_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&gpt10_mux_fck>;
+	bit-shift = <11>;
+	reg = <0x48004a00 0x4>;
+};
+
+gpt11_mux_fck: gpt11_mux_fck@48004a40 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	bit-shift = <7>;
+	reg = <0x48004a40 0x4>;
+	bit-mask = <0x1>;
+};
+
+gpt11_fck: gpt11_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&gpt11_mux_fck>;
+	bit-shift = <12>;
+	reg = <0x48004a00 0x4>;
+};
+
+core_96m_fck: core_96m_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&omap_96m_fck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+mmchs2_fck: mmchs2_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <25>;
+};
+
+mmchs1_fck: mmchs1_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <24>;
+};
+
+i2c3_fck: i2c3_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <17>;
+};
+
+i2c2_fck: i2c2_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <16>;
+};
+
+i2c1_fck: i2c1_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <15>;
+};
+
+mcbsp5_mux_fck: mcbsp5_mux_fck@480022d8 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&core_96m_fck>, <&mcbsp_clks>;
+	bit-shift = <4>;
+	reg = <0x480022d8 0x4>;
+	bit-mask = <0x1>;
+};
+
+mcbsp5_fck: mcbsp5_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&mcbsp5_mux_fck>;
+	bit-shift = <10>;
+	reg = <0x48004a00 0x4>;
+};
+
+mcbsp1_mux_fck: mcbsp1_mux_fck@48002274 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&core_96m_fck>, <&mcbsp_clks>;
+	bit-shift = <2>;
+	reg = <0x48002274 0x4>;
+	bit-mask = <0x1>;
+};
+
+mcbsp1_fck: mcbsp1_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&mcbsp1_mux_fck>;
+	bit-shift = <9>;
+	reg = <0x48004a00 0x4>;
+};
+
+core_48m_fck: core_48m_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&omap_48m_fck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+mcspi4_fck: mcspi4_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <21>;
+};
+
+mcspi3_fck: mcspi3_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <20>;
+};
+
+mcspi2_fck: mcspi2_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <19>;
+};
+
+mcspi1_fck: mcspi1_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <18>;
+};
+
+uart2_fck: uart2_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <14>;
+};
+
+uart1_fck: uart1_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <13>;
+};
+
+core_12m_fck: core_12m_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&omap_12m_fck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+hdq_fck: hdq_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_12m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <22>;
+};
+
+core_l3_ick: core_l3_ick {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&l3_ick>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+sdrc_ick: sdrc_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_l3_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l3_clkdm";
+	ti,enable-bit = <1>;
+};
+
+gpmc_fck: gpmc_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&core_l3_ick>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+core_l4_ick: core_l4_ick {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&l4_ick>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+mmchs2_ick: mmchs2_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <25>;
+};
+
+mmchs1_ick: mmchs1_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <24>;
+};
+
+hdq_ick: hdq_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <22>;
+};
+
+mcspi4_ick: mcspi4_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <21>;
+};
+
+mcspi3_ick: mcspi3_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <20>;
+};
+
+mcspi2_ick: mcspi2_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <19>;
+};
+
+mcspi1_ick: mcspi1_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <18>;
+};
+
+i2c3_ick: i2c3_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <17>;
+};
+
+i2c2_ick: i2c2_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <16>;
+};
+
+i2c1_ick: i2c1_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <15>;
+};
+
+uart2_ick: uart2_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <14>;
+};
+
+uart1_ick: uart1_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <13>;
+};
+
+gpt11_ick: gpt11_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <12>;
+};
+
+gpt10_ick: gpt10_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <11>;
+};
+
+mcbsp5_ick: mcbsp5_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <10>;
+};
+
+mcbsp1_ick: mcbsp1_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <9>;
+};
+
+omapctrl_ick: omapctrl_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <6>;
+};
+
+dss_tv_fck: dss_tv_fck@48004e00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&omap_54m_fck>;
+	reg = <0x48004e00 0x4>;
+	bit-shift = <2>;
+};
+
+dss_96m_fck: dss_96m_fck@48004e00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&omap_96m_fck>;
+	reg = <0x48004e00 0x4>;
+	bit-shift = <2>;
+};
+
+dss2_alwon_fck: dss2_alwon_fck@48004e00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x48004e00 0x4>;
+	bit-shift = <1>;
+};
+
+gpt1_mux_fck: gpt1_mux_fck@48004c40 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	reg = <0x48004c40 0x4>;
+	bit-mask = <0x1>;
+};
+
+gpt1_fck: gpt1_fck@48004c00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&gpt1_mux_fck>;
+	bit-shift = <0>;
+	reg = <0x48004c00 0x4>;
+};
+
+aes2_ick: aes2_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <28>;
+};
+
+wkup_32k_fck: wkup_32k_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&omap_32k_fck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+gpio1_dbck: gpio1_dbck@48004c00 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&wkup_32k_fck>;
+	reg = <0x48004c00 0x4>;
+	bit-shift = <3>;
+};
+
+sha12_ick: sha12_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <27>;
+};
+
+wdt2_fck: wdt2_fck@48004c00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&wkup_32k_fck>;
+	reg = <0x48004c00 0x4>;
+	ti,clkdm-name = "wkup_clkdm";
+	ti,enable-bit = <5>;
+};
+
+wkup_l4_ick: wkup_l4_ick {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&sys_ck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+wdt2_ick: wdt2_ick@48004c10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&wkup_l4_ick>;
+	reg = <0x48004c10 0x4>;
+	ti,clkdm-name = "wkup_clkdm";
+	ti,enable-bit = <5>;
+};
+
+wdt1_ick: wdt1_ick@48004c10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&wkup_l4_ick>;
+	reg = <0x48004c10 0x4>;
+	ti,clkdm-name = "wkup_clkdm";
+	ti,enable-bit = <4>;
+};
+
+gpio1_ick: gpio1_ick@48004c10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&wkup_l4_ick>;
+	reg = <0x48004c10 0x4>;
+	ti,clkdm-name = "wkup_clkdm";
+	ti,enable-bit = <3>;
+};
+
+omap_32ksync_ick: omap_32ksync_ick@48004c10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&wkup_l4_ick>;
+	reg = <0x48004c10 0x4>;
+	ti,clkdm-name = "wkup_clkdm";
+	ti,enable-bit = <2>;
+};
+
+gpt12_ick: gpt12_ick@48004c10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&wkup_l4_ick>;
+	reg = <0x48004c10 0x4>;
+	ti,clkdm-name = "wkup_clkdm";
+	ti,enable-bit = <1>;
+};
+
+gpt1_ick: gpt1_ick@48004c10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&wkup_l4_ick>;
+	reg = <0x48004c10 0x4>;
+	ti,clkdm-name = "wkup_clkdm";
+	ti,enable-bit = <0>;
+};
+
+per_96m_fck: per_96m_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&omap_96m_alwon_fck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+per_48m_fck: per_48m_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&omap_48m_fck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+uart3_fck: uart3_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&per_48m_fck>;
+	reg = <0x48005000 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <11>;
+};
+
+gpt2_mux_fck: gpt2_mux_fck@48005040 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	reg = <0x48005040 0x4>;
+	bit-mask = <0x1>;
+};
+
+gpt2_fck: gpt2_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&gpt2_mux_fck>;
+	bit-shift = <3>;
+	reg = <0x48005000 0x4>;
+};
+
+gpt3_mux_fck: gpt3_mux_fck@48005040 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	bit-shift = <1>;
+	reg = <0x48005040 0x4>;
+	bit-mask = <0x1>;
+};
+
+gpt3_fck: gpt3_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&gpt3_mux_fck>;
+	bit-shift = <4>;
+	reg = <0x48005000 0x4>;
+};
+
+gpt4_mux_fck: gpt4_mux_fck@48005040 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	bit-shift = <2>;
+	reg = <0x48005040 0x4>;
+	bit-mask = <0x1>;
+};
+
+gpt4_fck: gpt4_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&gpt4_mux_fck>;
+	bit-shift = <5>;
+	reg = <0x48005000 0x4>;
+};
+
+gpt5_mux_fck: gpt5_mux_fck@48005040 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	bit-shift = <3>;
+	reg = <0x48005040 0x4>;
+	bit-mask = <0x1>;
+};
+
+gpt5_fck: gpt5_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&gpt5_mux_fck>;
+	bit-shift = <6>;
+	reg = <0x48005000 0x4>;
+};
+
+gpt6_mux_fck: gpt6_mux_fck@48005040 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	bit-shift = <4>;
+	reg = <0x48005040 0x4>;
+	bit-mask = <0x1>;
+};
+
+gpt6_fck: gpt6_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&gpt6_mux_fck>;
+	bit-shift = <7>;
+	reg = <0x48005000 0x4>;
+};
+
+gpt7_mux_fck: gpt7_mux_fck@48005040 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	bit-shift = <5>;
+	reg = <0x48005040 0x4>;
+	bit-mask = <0x1>;
+};
+
+gpt7_fck: gpt7_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&gpt7_mux_fck>;
+	bit-shift = <8>;
+	reg = <0x48005000 0x4>;
+};
+
+gpt8_mux_fck: gpt8_mux_fck@48005040 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	bit-shift = <6>;
+	reg = <0x48005040 0x4>;
+	bit-mask = <0x1>;
+};
+
+gpt8_fck: gpt8_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&gpt8_mux_fck>;
+	bit-shift = <9>;
+	reg = <0x48005000 0x4>;
+};
+
+gpt9_mux_fck: gpt9_mux_fck@48005040 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	bit-shift = <7>;
+	reg = <0x48005040 0x4>;
+	bit-mask = <0x1>;
+};
+
+gpt9_fck: gpt9_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&gpt9_mux_fck>;
+	bit-shift = <10>;
+	reg = <0x48005000 0x4>;
+};
+
+per_32k_alwon_fck: per_32k_alwon_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&omap_32k_fck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+gpio6_dbck: gpio6_dbck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&per_32k_alwon_fck>;
+	reg = <0x48005000 0x4>;
+	bit-shift = <17>;
+};
+
+gpio5_dbck: gpio5_dbck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&per_32k_alwon_fck>;
+	reg = <0x48005000 0x4>;
+	bit-shift = <16>;
+};
+
+gpio4_dbck: gpio4_dbck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&per_32k_alwon_fck>;
+	reg = <0x48005000 0x4>;
+	bit-shift = <15>;
+};
+
+gpio3_dbck: gpio3_dbck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&per_32k_alwon_fck>;
+	reg = <0x48005000 0x4>;
+	bit-shift = <14>;
+};
+
+gpio2_dbck: gpio2_dbck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&per_32k_alwon_fck>;
+	reg = <0x48005000 0x4>;
+	bit-shift = <13>;
+};
+
+wdt3_fck: wdt3_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&per_32k_alwon_fck>;
+	reg = <0x48005000 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <12>;
+};
+
+per_l4_ick: per_l4_ick {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&l4_ick>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+gpio6_ick: gpio6_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <17>;
+};
+
+gpio5_ick: gpio5_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <16>;
+};
+
+gpio4_ick: gpio4_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <15>;
+};
+
+gpio3_ick: gpio3_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <14>;
+};
+
+gpio2_ick: gpio2_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <13>;
+};
+
+wdt3_ick: wdt3_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <12>;
+};
+
+uart3_ick: uart3_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <11>;
+};
+
+uart4_ick: uart4_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <18>;
+};
+
+gpt9_ick: gpt9_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <10>;
+};
+
+gpt8_ick: gpt8_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <9>;
+};
+
+gpt7_ick: gpt7_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <8>;
+};
+
+gpt6_ick: gpt6_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <7>;
+};
+
+gpt5_ick: gpt5_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <6>;
+};
+
+gpt4_ick: gpt4_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <5>;
+};
+
+gpt3_ick: gpt3_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <4>;
+};
+
+gpt2_ick: gpt2_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <3>;
+};
+
+mcbsp2_ick: mcbsp2_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <0>;
+};
+
+mcbsp3_ick: mcbsp3_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <1>;
+};
+
+mcbsp4_ick: mcbsp4_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,clkdm-name = "per_clkdm";
+	ti,enable-bit = <2>;
+};
+
+mcbsp2_mux_fck: mcbsp2_mux_fck@48002274 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&per_96m_fck>, <&mcbsp_clks>;
+	bit-shift = <6>;
+	reg = <0x48002274 0x4>;
+	bit-mask = <0x1>;
+};
+
+mcbsp2_fck: mcbsp2_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&mcbsp2_mux_fck>;
+	bit-shift = <0>;
+	reg = <0x48005000 0x4>;
+};
+
+mcbsp3_mux_fck: mcbsp3_mux_fck@480022d8 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&per_96m_fck>, <&mcbsp_clks>;
+	reg = <0x480022d8 0x4>;
+	bit-mask = <0x1>;
+};
+
+mcbsp3_fck: mcbsp3_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&mcbsp3_mux_fck>;
+	bit-shift = <1>;
+	reg = <0x48005000 0x4>;
+};
+
+mcbsp4_mux_fck: mcbsp4_mux_fck@480022d8 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&per_96m_fck>, <&mcbsp_clks>;
+	bit-shift = <2>;
+	reg = <0x480022d8 0x4>;
+	bit-mask = <0x1>;
+};
+
+mcbsp4_fck: mcbsp4_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&mcbsp4_mux_fck>;
+	bit-shift = <2>;
+	reg = <0x48005000 0x4>;
+};
+
+emu_src_mux_ck: emu_src_mux_ck@48005140 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&sys_ck>, <&emu_core_alwon_ck>, <&emu_per_alwon_ck>, <&emu_mpu_alwon_ck>;
+	reg = <0x48005140 0x4>;
+	bit-mask = <0x3>;
+};
+
+emu_src_ck: emu_src_ck {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&emu_src_mux_ck>;
+	ti,clkdm-name = "emu_clkdm";
+};
+
+pclk_fck: pclk_fck@48005140 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&emu_src_ck>;
+	bit-shift = <8>;
+	reg = <0x48005140 0x4>;
+	bit-mask = <0x7>;
+	index-starts-at-one;
+};
+
+pclkx2_fck: pclkx2_fck@48005140 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&emu_src_ck>;
+	bit-shift = <6>;
+	reg = <0x48005140 0x4>;
+	bit-mask = <0x3>;
+	index-starts-at-one;
+};
+
+atclk_fck: atclk_fck@48005140 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&emu_src_ck>;
+	bit-shift = <4>;
+	reg = <0x48005140 0x4>;
+	bit-mask = <0x3>;
+	index-starts-at-one;
+};
+
+traceclk_src_fck: traceclk_src_fck@48005140 {
+	#clock-cells = <0>;
+	compatible = "mux-clock";
+	clocks = <&sys_ck>, <&emu_core_alwon_ck>, <&emu_per_alwon_ck>, <&emu_mpu_alwon_ck>;
+	bit-shift = <2>;
+	reg = <0x48005140 0x4>;
+	bit-mask = <0x3>;
+};
+
+traceclk_fck: traceclk_fck@48005140 {
+	#clock-cells = <0>;
+	compatible = "divider-clock";
+	clocks = <&traceclk_src_fck>;
+	bit-shift = <11>;
+	reg = <0x48005140 0x4>;
+	bit-mask = <0x7>;
+	index-starts-at-one;
+};
+
+secure_32k_fck: secure_32k_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <32768>;
+};
+
+gpt12_fck: gpt12_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&secure_32k_fck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
+
+wdt1_fck: wdt1_fck {
+	#clock-cells = <0>;
+	compatible = "fixed-factor-clock";
+	clocks = <&secure_32k_fck>;
+	clock-mult = <1>;
+	clock-div = <1>;
+};
-- 
1.7.9.5

