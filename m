From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 30/36] ARM: dts: omap3 clock data
Date: Wed, 9 Oct 2013 18:31:01 +0300
Message-ID: <1381332668-962-31-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52587 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755642Ab3JIPfY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 11:35:24 -0400
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch creates a unique node for each clock in the OMAP3 power,
reset and clock manager (PRCM).

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am35xx-clocks.dtsi               |  101 ++
 arch/arm/boot/dts/omap3.dtsi                       |    7 +
 arch/arm/boot/dts/omap3430es1-clocks.dtsi          |  145 ++
 arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi    |  223 ++++
 arch/arm/boot/dts/omap34xx.dtsi                    |  121 +-
 .../omap36xx-am35xx-omap3430es2plus-clocks.dtsi    |  186 +++
 arch/arm/boot/dts/omap36xx-clocks.dtsi             |   78 ++
 .../boot/dts/omap36xx-omap3430es2plus-clocks.dtsi  |  158 +++
 arch/arm/boot/dts/omap36xx.dtsi                    |  122 +-
 arch/arm/boot/dts/omap3xxx-clocks.dtsi             | 1392 ++++++++++++++++++++
 10 files changed, 2531 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/am35xx-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/omap3430es1-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/omap36xx-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/omap3xxx-clocks.dtsi

diff --git a/arch/arm/boot/dts/am35xx-clocks.dtsi b/arch/arm/boot/dts/am35xx-clocks.dtsi
new file mode 100644
index 0000000..7f3af1a
--- /dev/null
+++ b/arch/arm/boot/dts/am35xx-clocks.dtsi
@@ -0,0 +1,101 @@
+/*
+ * Device Tree Source for AM35xx clock data
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+ipss_ick: ipss_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,am35xx-interface-clock";
+	clocks = <&core_l3_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <4>;
+};
+
+rmii_ck: rmii_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <50000000>;
+};
+
+pclk_ck: pclk_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <27000000>;
+};
+
+emac_ick: emac_ick@4800259c {
+	#clock-cells = <0>;
+	compatible = "ti,am35xx-gate-clock";
+	clocks = <&ipss_ick>;
+	reg = <0x4800259c 0x4>;
+	ti,bit-shift = <1>;
+};
+
+emac_fck: emac_fck@4800259c {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&rmii_ck>;
+	reg = <0x4800259c 0x4>;
+	ti,bit-shift = <9>;
+};
+
+vpfe_ick: vpfe_ick@4800259c {
+	#clock-cells = <0>;
+	compatible = "ti,am35xx-gate-clock";
+	clocks = <&ipss_ick>;
+	reg = <0x4800259c 0x4>;
+	ti,bit-shift = <2>;
+};
+
+vpfe_fck: vpfe_fck@4800259c {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&pclk_ck>;
+	reg = <0x4800259c 0x4>;
+	ti,bit-shift = <10>;
+};
+
+hsotgusb_ick_am35xx: hsotgusb_ick_am35xx@4800259c {
+	#clock-cells = <0>;
+	compatible = "ti,am35xx-gate-clock";
+	clocks = <&ipss_ick>;
+	reg = <0x4800259c 0x4>;
+	ti,bit-shift = <0>;
+};
+
+hsotgusb_fck_am35xx: hsotgusb_fck_am35xx@4800259c {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x4800259c 0x4>;
+	ti,bit-shift = <8>;
+};
+
+hecc_ck: hecc_ck@4800259c {
+	#clock-cells = <0>;
+	compatible = "ti,am35xx-gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x4800259c 0x4>;
+	ti,bit-shift = <3>;
+};
+
+uart4_ick_am35xx: uart4_ick_am35xx@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <23>;
+};
+
+uart4_fck_am35xx: uart4_fck_am35xx@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <23>;
+};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 16420ae..bc11b83 100644
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
index 0000000..2a7a137
--- /dev/null
+++ b/arch/arm/boot/dts/omap3430es1-clocks.dtsi
@@ -0,0 +1,145 @@
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
+gfx_l3_ck: gfx_l3_ck@48004b10 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&l3_ick>;
+	reg = <0x48004b10 0x4>;
+	ti,bit-shift = <0>;
+};
+
+gfx_l3_fck: gfx_l3_fck@48004b40 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&l3_ick>;
+	reg = <0x48004b40 0x4>;
+	ti,max-div = <7>;
+	ti,index-starts-at-one;
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
+	compatible = "ti,wait-gate-clock";
+	clocks = <&gfx_l3_fck>;
+	reg = <0x48004b00 0x4>;
+	ti,bit-shift = <1>;
+};
+
+gfx_cg2_ck: gfx_cg2_ck@48004b00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&gfx_l3_fck>;
+	reg = <0x48004b00 0x4>;
+	ti,bit-shift = <2>;
+};
+
+d2d_26m_fck: d2d_26m_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <3>;
+};
+
+fshostusb_fck: fshostusb_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <5>;
+};
+
+ssi_ssr_fck_3430es1: ssi_ssr_fck_3430es1@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,no-wait-mux-gate-clock";
+	clocks = <&corex2_fck>;
+	ti,div-bit-shift = <8>;
+	ti,dividers = <0>, <1>, <2>, <3>, <4>, <0>, <6>, <0>, <8>;
+	reg-names = "gate-reg", "div-reg";
+	reg = <0x48004a00 0x4>, <0x48004a40 0x4>;
+	ti,gate-bit-shift = <0>;
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
+	compatible = "ti,omap3-no-wait-interface-clock";
+	clocks = <&core_l3_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <4>;
+};
+
+fac_ick: fac_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <8>;
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
+	compatible = "ti,omap3-no-wait-interface-clock";
+	clocks = <&ssi_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <0>;
+};
+
+usb_l4_ick: usb_l4_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-mux-gate-clock";
+	clocks = <&l4_ick>;
+	ti,div-bit-shift = <4>;
+	ti,max-div = <1>;
+	reg-names = "gate-reg", "div-reg";
+	reg = <0x48004a10 0x4>, <0x48004a40 0x4>;
+	ti,gate-bit-shift = <5>;
+	ti,div-index-starts-at-one;
+};
+
+dss1_alwon_fck_3430es1: dss1_alwon_fck_3430es1@48004e00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&dpll4_m4x2_ck>;
+	reg = <0x48004e00 0x4>;
+	ti,bit-shift = <0>;
+};
+
+dss_ick_3430es1: dss_ick_3430es1@48004e10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-no-wait-interface-clock";
+	clocks = <&l4_ick>;
+	reg = <0x48004e10 0x4>;
+	ti,bit-shift = <0>;
+};
diff --git a/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi b/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi
new file mode 100644
index 0000000..48b6a5c
--- /dev/null
+++ b/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi
@@ -0,0 +1,223 @@
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
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&security_l4_ick2>;
+	ti,bit-shift = <3>;
+	reg = <0x48004a14 0x4>;
+};
+
+rng_ick: rng_ick@48004a14 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&security_l4_ick2>;
+	reg = <0x48004a14 0x4>;
+	ti,bit-shift = <2>;
+};
+
+sha11_ick: sha11_ick@48004a14 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&security_l4_ick2>;
+	reg = <0x48004a14 0x4>;
+	ti,bit-shift = <1>;
+};
+
+des1_ick: des1_ick@48004a14 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&security_l4_ick2>;
+	reg = <0x48004a14 0x4>;
+	ti,bit-shift = <0>;
+};
+
+cam_mclk: cam_mclk@48004f00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&dpll4_m5x2_ck>;
+	ti,bit-shift = <0>;
+	reg = <0x48004f00 0x4>;
+	ti,set-rate-parent;
+};
+
+cam_ick: cam_ick@48004f10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-no-wait-interface-clock";
+	clocks = <&l4_ick>;
+	reg = <0x48004f10 0x4>;
+	ti,bit-shift = <0>;
+};
+
+csi2_96m_fck: csi2_96m_fck@48004f00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004f00 0x4>;
+	ti,bit-shift = <1>;
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
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&security_l3_ick>;
+	reg = <0x48004a14 0x4>;
+	ti,bit-shift = <4>;
+};
+
+icr_ick: icr_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <29>;
+};
+
+des2_ick: des2_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <26>;
+};
+
+mspro_ick: mspro_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <23>;
+};
+
+mailboxes_ick: mailboxes_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <7>;
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
+	compatible = "ti,wait-gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x48004c00 0x4>;
+	ti,bit-shift = <6>;
+};
+
+sr2_fck: sr2_fck@48004c00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x48004c00 0x4>;
+	ti,bit-shift = <7>;
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
+	compatible = "ti,divider-clock";
+	clocks = <&core_ck>;
+	ti,bit-shift = <19>;
+	ti,max-div = <7>;
+	reg = <0x48004040 0x4>;
+	ti,index-starts-at-one;
+};
+
+dpll2_ck: dpll2_ck@48004004 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-dpll-clock";
+	clocks = <&sys_ck>, <&dpll2_fck>;
+	reg = <0x48004004 0x4>, <0x48004024 0x4>, <0x48004034 0x4>, <0x48004040 0x4>;
+	ti,low-power-stop;
+	ti,lock;
+	ti,low-power-bypass;
+};
+
+dpll2_m2_ck: dpll2_m2_ck@48004044 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&dpll2_ck>;
+	reg = <0x48004044 0x4>;
+	ti,max-div = <31>;
+	ti,index-starts-at-one;
+};
+
+iva2_ck: iva2_ck@48004000 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&dpll2_m2_ck>;
+	reg = <0x48004000 0x4>;
+	ti,bit-shift = <0>;
+};
+
+modem_fck: modem_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&sys_ck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <31>;
+};
+
+sad2d_ick: sad2d_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&l3_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <3>;
+};
+
+mad2d_ick: mad2d_ick@48004a18 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&l3_ick>;
+	reg = <0x48004a18 0x4>;
+	ti,bit-shift = <3>;
+};
+
+mspro_fck: mspro_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <23>;
+};
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 5355d61..2ed7c69 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -25,4 +25,123 @@
 			clock-latency = <300000>; /* From legacy driver */
 		};
 	};
-};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		/include/ "omap34xx-omap36xx-clocks.dtsi"
+		/include/ "omap36xx-omap3430es2plus-clocks.dtsi"
+		/include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
+	};
+
+	clockdomains {
+		usbhost_clkdm: usbhost_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&usbhost_48m_fck>, <&usbhost_ick>,
+				 <&usbhost_120m_fck>;
+		};
+
+		wkup_clkdm: wkup_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&wdt1_ick>, <&sr2_fck>, <&omap_32ksync_ick>,
+				 <&wdt2_fck>, <&gpt12_ick>, <&sr1_fck>,
+				 <&gpio1_ick>, <&gpt1_ick>, <&wdt2_ick>,
+				 <&usim_ick>, <&gpio1_dbck>;
+		};
+
+		cam_clkdm: cam_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&csi2_96m_fck>, <&cam_ick>;
+		};
+
+		dpll4_clkdm: dpll4_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll4_ck>;
+		};
+
+		sgx_clkdm: sgx_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&sgx_ick>;
+		};
+
+		dpll3_clkdm: dpll3_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll3_ck>;
+		};
+
+		iva2_clkdm: iva2_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&iva2_ck>;
+		};
+
+		dpll1_clkdm: dpll1_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll1_ck>;
+		};
+
+		dpll2_clkdm: dpll2_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll2_ck>;
+		};
+
+		dpll5_clkdm: dpll5_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll5_ck>;
+		};
+
+		dss_clkdm: dss_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dss_tv_fck>, <&dss1_alwon_fck_3430es2>,
+				 <&dss_96m_fck>, <&dss2_alwon_fck>,
+				 <&dss_ick_3430es2>;
+		};
+
+		core_l4_clkdm: core_l4_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&mmchs1_ick>, <&mspro_ick>, <&mmchs2_ick>,
+				 <&mcspi4_fck>, <&i2c3_fck>, <&mcspi2_ick>,
+				 <&uart2_ick>, <&mcspi3_ick>, <&i2c1_fck>,
+				 <&sha12_ick>, <&mcspi3_fck>, <&mailboxes_ick>,
+				 <&uart2_fck>, <&mmchs2_fck>, <&usbtll_fck>,
+				 <&mmchs3_ick>, <&des2_ick>, <&i2c2_ick>,
+				 <&i2c1_ick>, <&icr_ick>, <&hdq_fck>,
+				 <&uart1_ick>, <&ts_fck>, <&usbtll_ick>,
+				 <&hdq_ick>, <&mcbsp5_ick>, <&aes2_ick>,
+				 <&mcspi1_ick>, <&mmchs1_fck>, <&i2c3_ick>,
+				 <&mcspi1_fck>, <&mmchs3_fck>, <&mcspi4_ick>,
+				 <&omapctrl_ick>, <&mspro_fck>, <&mcbsp1_ick>,
+				 <&mcspi2_fck>, <&ssi_ick_3430es2>,
+				 <&gpt10_ick>, <&cpefuse_fck>, <&i2c2_fck>,
+				 <&gpt11_ick>, <&uart1_fck>;
+		};
+
+		core_l3_clkdm: core_l3_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&sdrc_ick>, <&hsotgusb_ick_3430es2>;
+		};
+
+		per_clkdm: per_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&gpt2_ick>, <&uart3_fck>, <&gpio3_ick>,
+				 <&mcbsp2_ick>, <&gpt6_ick>, <&gpio2_dbck>,
+				 <&mcbsp4_ick>, <&gpio4_dbck>, <&gpt4_ick>,
+				 <&gpio5_dbck>, <&mcbsp3_ick>, <&gpio3_dbck>,
+				 <&gpt8_ick>, <&gpt5_ick>, <&gpio6_dbck>,
+				 <&uart3_ick>, <&gpt7_ick>, <&gpio2_ick>,
+				 <&gpio6_ick>, <&gpt9_ick>, <&gpt3_ick>,
+				 <&gpio5_ick>, <&wdt3_fck>, <&gpio4_ick>,
+				 <&wdt3_ick>, <&uart4_ick>;
+		};
+
+		emu_clkdm: emu_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&emu_src_ck>;
+		};
+
+		d2d_clkdm: d2d_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&mad2d_ick>, <&sad2d_ick>, <&modem_fck>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi b/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
new file mode 100644
index 0000000..a31bc85
--- /dev/null
+++ b/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
@@ -0,0 +1,186 @@
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
+	clocks = <&sys_ck>, <&sys_ck>;
+	reg = <0x48004d04 0x4>, <0x48004d24 0x4>, <0x48004d34 0x4>, <0x48004d4c 0x4>;
+};
+
+dpll5_m2_ck: dpll5_m2_ck@48004d50 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&dpll5_ck>;
+	reg = <0x48004d50 0x4>;
+	ti,max-div = <31>;
+	ti,index-starts-at-one;
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
+sgx_fck: sgx_fck@48004b00 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&core_d3_ck>, <&core_d4_ck>, <&core_d6_ck>, <&cm_96m_fck>, <&omap_192m_alwon_fck>, <&core_d2_ck>, <&corex2_d3_fck>, <&corex2_d5_fck>;
+	ti,gate-bit-shift = <1>;
+	reg = <0x48004b00 0x4>, <0x48004b40 0x4>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+sgx_ick: sgx_ick@48004b10 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&l3_ick>;
+	reg = <0x48004b10 0x4>;
+	ti,bit-shift = <0>;
+};
+
+cpefuse_fck: cpefuse_fck@48004a08 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x48004a08 0x4>;
+	ti,bit-shift = <0>;
+};
+
+ts_fck: ts_fck@48004a08 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&omap_32k_fck>;
+	reg = <0x48004a08 0x4>;
+	ti,bit-shift = <1>;
+};
+
+usbtll_fck: usbtll_fck@48004a08 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&dpll5_m2_ck>;
+	reg = <0x48004a08 0x4>;
+	ti,bit-shift = <2>;
+};
+
+usbtll_ick: usbtll_ick@48004a18 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a18 0x4>;
+	ti,bit-shift = <2>;
+};
+
+mmchs3_ick: mmchs3_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <30>;
+};
+
+mmchs3_fck: mmchs3_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <30>;
+};
+
+dss1_alwon_fck_3430es2: dss1_alwon_fck_3430es2@48004e00 {
+	#clock-cells = <0>;
+	compatible = "ti,dss-gate-clock";
+	clocks = <&dpll4_m4x2_ck>;
+	reg = <0x48004e00 0x4>;
+	ti,bit-shift = <0>;
+};
+
+dss_ick_3430es2: dss_ick_3430es2@48004e10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-dss-interface-clock";
+	clocks = <&l4_ick>;
+	reg = <0x48004e10 0x4>;
+	ti,bit-shift = <0>;
+};
+
+usbhost_120m_fck: usbhost_120m_fck@48005400 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&dpll5_m2_ck>;
+	reg = <0x48005400 0x4>;
+	ti,bit-shift = <1>;
+};
+
+usbhost_48m_fck: usbhost_48m_fck@48005400 {
+	#clock-cells = <0>;
+	compatible = "ti,dss-gate-clock";
+	clocks = <&omap_48m_fck>;
+	reg = <0x48005400 0x4>;
+	ti,bit-shift = <0>;
+};
+
+usbhost_ick: usbhost_ick@48005410 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-dss-interface-clock";
+	clocks = <&l4_ick>;
+	reg = <0x48005410 0x4>;
+	ti,bit-shift = <0>;
+};
diff --git a/arch/arm/boot/dts/omap36xx-clocks.dtsi b/arch/arm/boot/dts/omap36xx-clocks.dtsi
new file mode 100644
index 0000000..0a3a697
--- /dev/null
+++ b/arch/arm/boot/dts/omap36xx-clocks.dtsi
@@ -0,0 +1,78 @@
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
+	compatible = "ti,omap3-dpll-per-j-type-clock";
+	clocks = <&sys_ck>, <&sys_ck>;
+	reg = <0x48004d00 0x4>, <0x48004d20 0x4>, <0x48004d30 0x4>, <0x48004d44 0x4>;
+};
+
+dpll4_m2x2_ck: dpll4_m2x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "ti,hsdiv-gate-clock";
+	clocks = <&dpll4_m2x2_mul_ck>;
+	ti,bit-shift = <0x1b>;
+	reg = <0x48004d00 0x4>;
+	ti,set-bit-to-disable;
+};
+
+dpll3_m3x2_ck: dpll3_m3x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "ti,hsdiv-gate-clock";
+	clocks = <&dpll3_m3x2_mul_ck>;
+	ti,bit-shift = <0xc>;
+	reg = <0x48004d00 0x4>;
+	ti,set-bit-to-disable;
+};
+
+dpll4_m3x2_ck: dpll4_m3x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "ti,hsdiv-gate-clock";
+	clocks = <&dpll4_m3x2_mul_ck>;
+	ti,bit-shift = <0x1c>;
+	reg = <0x48004d00 0x4>;
+	ti,set-bit-to-disable;
+};
+
+dpll4_m5x2_ck: dpll4_m5x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "ti,hsdiv-gate-clock";
+	clocks = <&dpll4_m5x2_mul_ck>;
+	ti,bit-shift = <0x1e>;
+	reg = <0x48004d00 0x4>;
+	ti,set-bit-to-disable;
+	ti,set-rate-parent;
+};
+
+dpll4_m6x2_ck: dpll4_m6x2_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "ti,hsdiv-gate-clock";
+	clocks = <&dpll4_m6x2_mul_ck>;
+	ti,bit-shift = <0x1f>;
+	reg = <0x48004d00 0x4>;
+	ti,set-bit-to-disable;
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
+	compatible = "ti,wait-gate-clock";
+	clocks = <&per_48m_fck>;
+	reg = <0x48005000 0x4>;
+	ti,bit-shift = <18>;
+};
diff --git a/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi b/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
new file mode 100644
index 0000000..a89206c
--- /dev/null
+++ b/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
@@ -0,0 +1,158 @@
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
+ssi_ssr_fck_3430es2: ssi_ssr_fck_3430es2@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,no-wait-mux-gate-clock";
+	clocks = <&corex2_fck>;
+	ti,div-bit-shift = <8>;
+	ti,dividers = <0>, <1>, <2>, <3>, <4>, <0>, <6>, <0>, <8>;
+	reg-names = "gate-reg", "div-reg";
+	reg = <0x48004a00 0x4>, <0x48004a40 0x4>;
+	ti,gate-bit-shift = <0>;
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
+	compatible = "ti,omap3-hsotgusb-interface-clock";
+	clocks = <&core_l3_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <4>;
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
+	compatible = "ti,omap3-ssi-interface-clock";
+	clocks = <&ssi_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <0>;
+};
+
+dpll5_ck: dpll5_ck@48004d04 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-dpll-clock";
+	clocks = <&sys_ck>, <&sys_ck>;
+	reg = <0x48004d04 0x4>, <0x48004d24 0x4>, <0x48004d34 0x4>, <0x48004d4c 0x4>;
+};
+
+dpll5_m2_ck: dpll5_m2_ck@48004d50 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&dpll5_ck>;
+	reg = <0x48004d50 0x4>;
+	ti,max-div = <31>;
+	ti,index-starts-at-one;
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
+usim_fck: usim_fck@48004c00 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&sys_ck>, <&dpll5_m2_d20_ck>, <&sys_d2_ck>, <&omap_96m_d2_fck>, <&omap_96m_d4_fck>, <&omap_96m_d8_fck>, <&omap_96m_d10_fck>, <&dpll5_m2_d4_ck>, <&dpll5_m2_d8_ck>, <&dpll5_m2_d16_ck>;
+	ti,gate-bit-shift = <9>;
+	reg = <0x48004c00 0x4>, <0x48004c40 0x4>;
+	ti,mux-bit-shift = <3>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+usim_ick: usim_ick@48004c10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&wkup_l4_ick>;
+	reg = <0x48004c10 0x4>;
+	ti,bit-shift = <9>;
+};
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index f8b3765..71fb6fb 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -35,4 +35,124 @@
 			clock-frequency = <48000000>;
 		};
 	};
-};
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
+
+	clockdomains {
+		usbhost_clkdm: usbhost_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&usbhost_48m_fck>, <&usbhost_ick>,
+				 <&usbhost_120m_fck>;
+		};
+
+		wkup_clkdm: wkup_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&wdt1_ick>, <&sr2_fck>, <&omap_32ksync_ick>,
+				 <&wdt2_fck>, <&gpt12_ick>, <&sr1_fck>,
+				 <&gpio1_ick>, <&gpt1_ick>, <&wdt2_ick>,
+				 <&usim_ick>, <&gpio1_dbck>;
+		};
+
+		cam_clkdm: cam_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&csi2_96m_fck>, <&cam_ick>;
+		};
+
+		dpll4_clkdm: dpll4_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll4_ck>;
+		};
+
+		sgx_clkdm: sgx_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&sgx_ick>;
+		};
+
+		dpll3_clkdm: dpll3_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll3_ck>;
+		};
+
+		iva2_clkdm: iva2_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&iva2_ck>;
+		};
+
+		dpll1_clkdm: dpll1_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll1_ck>;
+		};
+
+		dpll5_clkdm: dpll5_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll5_ck>;
+		};
+
+		dpll2_clkdm: dpll2_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll2_ck>;
+		};
+
+		dss_clkdm: dss_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dss_tv_fck>, <&dss1_alwon_fck_3430es2>,
+				 <&dss_96m_fck>, <&dss2_alwon_fck>,
+				 <&dss_ick_3430es2>;
+		};
+
+		core_l4_clkdm: core_l4_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&mmchs1_ick>, <&mspro_ick>, <&mmchs2_ick>,
+				 <&mcspi4_fck>, <&i2c3_fck>, <&mcspi2_ick>,
+				 <&uart2_ick>, <&mcspi3_ick>, <&i2c1_fck>,
+				 <&sha12_ick>, <&mcspi3_fck>, <&mailboxes_ick>,
+				 <&uart2_fck>, <&mmchs2_fck>, <&usbtll_fck>,
+				 <&mmchs3_ick>, <&des2_ick>, <&i2c2_ick>,
+				 <&i2c1_ick>, <&icr_ick>, <&hdq_fck>,
+				 <&uart1_ick>, <&ts_fck>, <&usbtll_ick>,
+				 <&hdq_ick>, <&mcbsp5_ick>, <&aes2_ick>,
+				 <&mcspi1_ick>, <&mmchs1_fck>, <&i2c3_ick>,
+				 <&mcspi1_fck>, <&mmchs3_fck>, <&mcspi4_ick>,
+				 <&omapctrl_ick>, <&mspro_fck>, <&mcbsp1_ick>,
+				 <&mcspi2_fck>, <&ssi_ick_3430es2>,
+				 <&gpt10_ick>, <&cpefuse_fck>, <&i2c2_fck>,
+				 <&gpt11_ick>, <&uart1_fck>;
+		};
+
+		core_l3_clkdm: core_l3_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&sdrc_ick>, <&hsotgusb_ick_3430es2>;
+		};
+
+		per_clkdm: per_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&gpt2_ick>, <&uart3_fck>, <&gpio3_ick>,
+				 <&mcbsp2_ick>, <&gpt6_ick>, <&gpio2_dbck>,
+				 <&mcbsp4_ick>, <&gpio4_dbck>, <&gpt4_ick>,
+				 <&gpio5_dbck>, <&mcbsp3_ick>, <&gpio3_dbck>,
+				 <&gpt8_ick>, <&gpt5_ick>, <&uart4_fck>,
+				 <&gpio6_dbck>, <&uart3_ick>, <&gpt7_ick>,
+				 <&gpio2_ick>, <&gpt9_ick>, <&gpio6_ick>,
+				 <&gpt3_ick>, <&gpio5_ick>, <&wdt3_fck>,
+				 <&gpio4_ick>, <&wdt3_ick>, <&uart4_ick>;
+		};
+
+		emu_clkdm: emu_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&emu_src_ck>;
+		};
+
+		d2d_clkdm: d2d_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&mad2d_ick>, <&sad2d_ick>, <&modem_fck>;
+		};
+	};
+};
\ No newline at end of file
diff --git a/arch/arm/boot/dts/omap3xxx-clocks.dtsi b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
new file mode 100644
index 0000000..f9ccaf1
--- /dev/null
+++ b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
@@ -0,0 +1,1392 @@
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
+	compatible = "ti,mux-clock";
+	clocks = <&virt_12m_ck>, <&virt_13m_ck>, <&virt_19200000_ck>, <&virt_26000000_ck>, <&virt_38_4m_ck>, <&virt_16_8m_ck>;
+	reg = <0x48306d40 0x4>;
+};
+
+sys_ck: sys_ck@48307270 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&osc_sys_ck>;
+	ti,bit-shift = <6>;
+	ti,max-div = <3>;
+	reg = <0x48307270 0x4>;
+	ti,index-starts-at-one;
+};
+
+dpll4_ck: dpll4_ck@48004d00 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-dpll-per-clock";
+	clocks = <&sys_ck>, <&sys_ck>;
+	reg = <0x48004d00 0x4>, <0x48004d20 0x4>, <0x48004d30 0x4>, <0x48004d44 0x4>;
+};
+
+dpll4_m2_ck: dpll4_m2_ck@48004d48 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&dpll4_ck>;
+	reg = <0x48004d48 0x4>;
+	ti,max-div = <63>;
+	ti,index-starts-at-one;
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
+	compatible = "ti,gate-clock";
+	clocks = <&dpll4_m2x2_mul_ck>;
+	ti,bit-shift = <0x1b>;
+	reg = <0x48004d00 0x4>;
+	ti,set-bit-to-disable;
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
+	compatible = "ti,omap3-dpll-core-clock";
+	clocks = <&sys_ck>, <&sys_ck>;
+	reg = <0x48004d00 0x4>, <0x48004d20 0x4>, <0x48004d30 0x4>, <0x48004d40 0x4>;
+};
+
+dpll3_m3_ck: dpll3_m3_ck@48005140 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&dpll3_ck>;
+	ti,bit-shift = <16>;
+	ti,max-div = <31>;
+	reg = <0x48005140 0x4>;
+	ti,index-starts-at-one;
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
+	compatible = "ti,gate-clock";
+	clocks = <&dpll3_m3x2_mul_ck>;
+	ti,bit-shift = <0xc>;
+	reg = <0x48004d00 0x4>;
+	ti,set-bit-to-disable;
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
+	compatible = "ti,gate-clock";
+	clocks = <&osc_sys_ck>;
+	reg = <0x48306d70 0x4>;
+	ti,bit-shift = <7>;
+};
+
+dpll3_m2_ck: dpll3_m2_ck@48004d40 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&dpll3_ck>;
+	ti,bit-shift = <27>;
+	ti,max-div = <31>;
+	reg = <0x48004d40 0x4>;
+	ti,index-starts-at-one;
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
+dpll1_fck: dpll1_fck@48004940 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&core_ck>;
+	ti,bit-shift = <19>;
+	ti,max-div = <7>;
+	reg = <0x48004940 0x4>;
+	ti,index-starts-at-one;
+};
+
+dpll1_ck: dpll1_ck@48004904 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-dpll-clock";
+	clocks = <&sys_ck>, <&dpll1_fck>;
+	reg = <0x48004904 0x4>, <0x48004924 0x4>, <0x48004934 0x4>, <0x48004940 0x4>;
+	ti,low-power-bypass;
+	ti,lock;
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
+	compatible = "ti,divider-clock";
+	clocks = <&dpll1_x2_ck>;
+	reg = <0x48004944 0x4>;
+	ti,max-div = <31>;
+	ti,index-starts-at-one;
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
+	compatible = "ti,mux-clock";
+	clocks = <&cm_96m_fck>, <&sys_ck>;
+	ti,bit-shift = <6>;
+	reg = <0x48004d40 0x4>;
+};
+
+dpll4_m3_ck: dpll4_m3_ck@48004e40 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&dpll4_ck>;
+	ti,bit-shift = <8>;
+	ti,max-div = <63>;
+	reg = <0x48004e40 0x4>;
+	ti,index-starts-at-one;
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
+	compatible = "ti,gate-clock";
+	clocks = <&dpll4_m3x2_mul_ck>;
+	ti,bit-shift = <0x1c>;
+	reg = <0x48004d00 0x4>;
+	ti,set-bit-to-disable;
+};
+
+omap_54m_fck: omap_54m_fck@48004d40 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-clock";
+	clocks = <&dpll4_m3x2_ck>, <&sys_altclk>;
+	ti,bit-shift = <5>;
+	reg = <0x48004d40 0x4>;
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
+	compatible = "ti,mux-clock";
+	clocks = <&cm_96m_d2_fck>, <&sys_altclk>;
+	ti,bit-shift = <3>;
+	reg = <0x48004d40 0x4>;
+	ti,table = <&cm_96m_d2_fck 0>, <&sys_altclk 1>;
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
+	compatible = "ti,divider-clock";
+	clocks = <&dpll4_ck>;
+	reg = <0x48004e40 0x4>;
+	ti,max-div = <63>;
+	ti,index-starts-at-one;
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
+	compatible = "ti,gate-clock";
+	clocks = <&dpll4_m4x2_mul_ck>;
+	ti,bit-shift = <0x1d>;
+	reg = <0x48004d00 0x4>;
+	ti,set-bit-to-disable;
+};
+
+dpll4_m5_ck: dpll4_m5_ck@48004f40 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&dpll4_ck>;
+	reg = <0x48004f40 0x4>;
+	ti,max-div = <63>;
+	ti,index-starts-at-one;
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
+	compatible = "ti,gate-clock";
+	clocks = <&dpll4_m5x2_mul_ck>;
+	ti,bit-shift = <0x1e>;
+	reg = <0x48004d00 0x4>;
+	ti,set-bit-to-disable;
+};
+
+dpll4_m6_ck: dpll4_m6_ck@48005140 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&dpll4_ck>;
+	ti,bit-shift = <24>;
+	ti,max-div = <63>;
+	reg = <0x48005140 0x4>;
+	ti,index-starts-at-one;
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
+	compatible = "ti,gate-clock";
+	clocks = <&dpll4_m6x2_mul_ck>;
+	ti,bit-shift = <0x1f>;
+	reg = <0x48004d00 0x4>;
+	ti,set-bit-to-disable;
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
+clkout2_src_ck: clkout2_src_ck@48004d70 {
+	#clock-cells = <0>;
+	compatible = "ti,no-wait-mux-gate-clock";
+	clocks = <&core_ck>, <&sys_ck>, <&cm_96m_fck>, <&omap_54m_fck>;
+	ti,gate-bit-shift = <7>;
+	reg = <0x48004d70 0x4>, <0x48004d70 0x4>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+sys_clkout2: sys_clkout2@48004d70 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&clkout2_src_ck>;
+	ti,bit-shift = <3>;
+	ti,max-div = <64>;
+	reg = <0x48004d70 0x4>;
+	ti,index-power-of-two;
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
+	compatible = "ti,divider-clock";
+	clocks = <&mpu_ck>;
+	reg = <0x48004924 0x4>;
+	ti,max-div = <2>;
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
+	compatible = "ti,divider-clock";
+	clocks = <&core_ck>;
+	reg = <0x48004a40 0x4>;
+	ti,max-div = <3>;
+	ti,index-starts-at-one;
+};
+
+l4_ick: l4_ick@48004a40 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&l3_ick>;
+	ti,bit-shift = <2>;
+	ti,max-div = <3>;
+	reg = <0x48004a40 0x4>;
+	ti,index-starts-at-one;
+};
+
+rm_ick: rm_ick@48004c40 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&l4_ick>;
+	ti,bit-shift = <1>;
+	ti,max-div = <3>;
+	reg = <0x48004c40 0x4>;
+	ti,index-starts-at-one;
+};
+
+gpt10_fck: gpt10_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	ti,gate-bit-shift = <11>;
+	reg = <0x48004a00 0x4>, <0x48004a40 0x4>;
+	ti,mux-bit-shift = <6>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+gpt11_fck: gpt11_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	ti,gate-bit-shift = <12>;
+	reg = <0x48004a00 0x4>, <0x48004a40 0x4>;
+	ti,mux-bit-shift = <7>;
+	reg-names = "gate-reg", "mux-reg";
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
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <25>;
+};
+
+mmchs1_fck: mmchs1_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <24>;
+};
+
+i2c3_fck: i2c3_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <17>;
+};
+
+i2c2_fck: i2c2_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <16>;
+};
+
+i2c1_fck: i2c1_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_96m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <15>;
+};
+
+mcbsp5_fck: mcbsp5_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&core_96m_fck>, <&mcbsp_clks>;
+	ti,gate-bit-shift = <10>;
+	reg = <0x48004a00 0x4>, <0x480022d8 0x4>;
+	ti,mux-bit-shift = <4>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+mcbsp1_fck: mcbsp1_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&core_96m_fck>, <&mcbsp_clks>;
+	ti,gate-bit-shift = <9>;
+	reg = <0x48004a00 0x4>, <0x48002274 0x4>;
+	ti,mux-bit-shift = <2>;
+	reg-names = "gate-reg", "mux-reg";
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
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <21>;
+};
+
+mcspi3_fck: mcspi3_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <20>;
+};
+
+mcspi2_fck: mcspi2_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <19>;
+};
+
+mcspi1_fck: mcspi1_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <18>;
+};
+
+uart2_fck: uart2_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <14>;
+};
+
+uart1_fck: uart1_fck@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <13>;
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
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_12m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,bit-shift = <22>;
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
+	compatible = "ti,wait-gate-clock";
+	clocks = <&core_l3_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <1>;
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
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <25>;
+};
+
+mmchs1_ick: mmchs1_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <24>;
+};
+
+hdq_ick: hdq_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <22>;
+};
+
+mcspi4_ick: mcspi4_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <21>;
+};
+
+mcspi3_ick: mcspi3_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <20>;
+};
+
+mcspi2_ick: mcspi2_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <19>;
+};
+
+mcspi1_ick: mcspi1_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <18>;
+};
+
+i2c3_ick: i2c3_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <17>;
+};
+
+i2c2_ick: i2c2_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <16>;
+};
+
+i2c1_ick: i2c1_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <15>;
+};
+
+uart2_ick: uart2_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <14>;
+};
+
+uart1_ick: uart1_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <13>;
+};
+
+gpt11_ick: gpt11_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <12>;
+};
+
+gpt10_ick: gpt10_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <11>;
+};
+
+mcbsp5_ick: mcbsp5_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <10>;
+};
+
+mcbsp1_ick: mcbsp1_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <9>;
+};
+
+omapctrl_ick: omapctrl_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <6>;
+};
+
+dss_tv_fck: dss_tv_fck@48004e00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&omap_54m_fck>;
+	reg = <0x48004e00 0x4>;
+	ti,bit-shift = <2>;
+};
+
+dss_96m_fck: dss_96m_fck@48004e00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&omap_96m_fck>;
+	reg = <0x48004e00 0x4>;
+	ti,bit-shift = <2>;
+};
+
+dss2_alwon_fck: dss2_alwon_fck@48004e00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x48004e00 0x4>;
+	ti,bit-shift = <1>;
+};
+
+dummy_ck: dummy_ck {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <0>;
+};
+
+gpt1_fck: gpt1_fck@48004c00 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	ti,gate-bit-shift = <0>;
+	reg = <0x48004c00 0x4>, <0x48004c40 0x4>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+aes2_ick: aes2_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	ti,bit-shift = <28>;
+	reg = <0x48004a10 0x4>;
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
+	compatible = "ti,gate-clock";
+	clocks = <&wkup_32k_fck>;
+	reg = <0x48004c00 0x4>;
+	ti,bit-shift = <3>;
+};
+
+sha12_ick: sha12_ick@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,bit-shift = <27>;
+};
+
+wdt2_fck: wdt2_fck@48004c00 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&wkup_32k_fck>;
+	reg = <0x48004c00 0x4>;
+	ti,bit-shift = <5>;
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
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&wkup_l4_ick>;
+	reg = <0x48004c10 0x4>;
+	ti,bit-shift = <5>;
+};
+
+wdt1_ick: wdt1_ick@48004c10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&wkup_l4_ick>;
+	reg = <0x48004c10 0x4>;
+	ti,bit-shift = <4>;
+};
+
+gpio1_ick: gpio1_ick@48004c10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&wkup_l4_ick>;
+	reg = <0x48004c10 0x4>;
+	ti,bit-shift = <3>;
+};
+
+omap_32ksync_ick: omap_32ksync_ick@48004c10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&wkup_l4_ick>;
+	reg = <0x48004c10 0x4>;
+	ti,bit-shift = <2>;
+};
+
+gpt12_ick: gpt12_ick@48004c10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&wkup_l4_ick>;
+	reg = <0x48004c10 0x4>;
+	ti,bit-shift = <1>;
+};
+
+gpt1_ick: gpt1_ick@48004c10 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&wkup_l4_ick>;
+	reg = <0x48004c10 0x4>;
+	ti,bit-shift = <0>;
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
+	compatible = "ti,wait-gate-clock";
+	clocks = <&per_48m_fck>;
+	reg = <0x48005000 0x4>;
+	ti,bit-shift = <11>;
+};
+
+gpt2_fck: gpt2_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	ti,gate-bit-shift = <3>;
+	reg = <0x48005000 0x4>, <0x48005040 0x4>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+gpt3_fck: gpt3_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	ti,gate-bit-shift = <4>;
+	reg = <0x48005000 0x4>, <0x48005040 0x4>;
+	ti,mux-bit-shift = <1>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+gpt4_fck: gpt4_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	ti,gate-bit-shift = <5>;
+	reg = <0x48005000 0x4>, <0x48005040 0x4>;
+	ti,mux-bit-shift = <2>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+gpt5_fck: gpt5_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	ti,gate-bit-shift = <6>;
+	reg = <0x48005000 0x4>, <0x48005040 0x4>;
+	ti,mux-bit-shift = <3>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+gpt6_fck: gpt6_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	ti,gate-bit-shift = <7>;
+	reg = <0x48005000 0x4>, <0x48005040 0x4>;
+	ti,mux-bit-shift = <4>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+gpt7_fck: gpt7_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	ti,gate-bit-shift = <8>;
+	reg = <0x48005000 0x4>, <0x48005040 0x4>;
+	ti,mux-bit-shift = <5>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+gpt8_fck: gpt8_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	ti,gate-bit-shift = <9>;
+	reg = <0x48005000 0x4>, <0x48005040 0x4>;
+	ti,mux-bit-shift = <6>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+gpt9_fck: gpt9_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&omap_32k_fck>, <&sys_ck>;
+	ti,gate-bit-shift = <10>;
+	reg = <0x48005000 0x4>, <0x48005040 0x4>;
+	ti,mux-bit-shift = <7>;
+	reg-names = "gate-reg", "mux-reg";
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
+	compatible = "ti,gate-clock";
+	clocks = <&per_32k_alwon_fck>;
+	reg = <0x48005000 0x4>;
+	ti,bit-shift = <17>;
+};
+
+gpio5_dbck: gpio5_dbck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&per_32k_alwon_fck>;
+	reg = <0x48005000 0x4>;
+	ti,bit-shift = <16>;
+};
+
+gpio4_dbck: gpio4_dbck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&per_32k_alwon_fck>;
+	reg = <0x48005000 0x4>;
+	ti,bit-shift = <15>;
+};
+
+gpio3_dbck: gpio3_dbck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&per_32k_alwon_fck>;
+	reg = <0x48005000 0x4>;
+	ti,bit-shift = <14>;
+};
+
+gpio2_dbck: gpio2_dbck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&per_32k_alwon_fck>;
+	reg = <0x48005000 0x4>;
+	ti,bit-shift = <13>;
+};
+
+wdt3_fck: wdt3_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,wait-gate-clock";
+	clocks = <&per_32k_alwon_fck>;
+	reg = <0x48005000 0x4>;
+	ti,bit-shift = <12>;
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
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <17>;
+};
+
+gpio5_ick: gpio5_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <16>;
+};
+
+gpio4_ick: gpio4_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <15>;
+};
+
+gpio3_ick: gpio3_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <14>;
+};
+
+gpio2_ick: gpio2_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <13>;
+};
+
+wdt3_ick: wdt3_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <12>;
+};
+
+uart3_ick: uart3_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <11>;
+};
+
+uart4_ick: uart4_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <18>;
+};
+
+gpt9_ick: gpt9_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <10>;
+};
+
+gpt8_ick: gpt8_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <9>;
+};
+
+gpt7_ick: gpt7_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <8>;
+};
+
+gpt6_ick: gpt6_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <7>;
+};
+
+gpt5_ick: gpt5_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <6>;
+};
+
+gpt4_ick: gpt4_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <5>;
+};
+
+gpt3_ick: gpt3_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <4>;
+};
+
+gpt2_ick: gpt2_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <3>;
+};
+
+mcbsp2_ick: mcbsp2_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <0>;
+};
+
+mcbsp3_ick: mcbsp3_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <1>;
+};
+
+mcbsp4_ick: mcbsp4_ick@48005010 {
+	#clock-cells = <0>;
+	compatible = "ti,omap3-interface-clock";
+	clocks = <&per_l4_ick>;
+	reg = <0x48005010 0x4>;
+	ti,bit-shift = <2>;
+};
+
+mcbsp2_fck: mcbsp2_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&per_96m_fck>, <&mcbsp_clks>;
+	ti,gate-bit-shift = <0>;
+	reg = <0x48005000 0x4>, <0x48002274 0x4>;
+	ti,mux-bit-shift = <6>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+mcbsp3_fck: mcbsp3_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&per_96m_fck>, <&mcbsp_clks>;
+	ti,gate-bit-shift = <1>;
+	reg = <0x48005000 0x4>, <0x480022d8 0x4>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+mcbsp4_fck: mcbsp4_fck@48005000 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-gate-clock";
+	clocks = <&per_96m_fck>, <&mcbsp_clks>;
+	ti,gate-bit-shift = <2>;
+	reg = <0x48005000 0x4>, <0x480022d8 0x4>;
+	ti,mux-bit-shift = <2>;
+	reg-names = "gate-reg", "mux-reg";
+};
+
+emu_src_mux_ck: emu_src_mux_ck@48005140 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-clock";
+	clocks = <&sys_ck>, <&emu_core_alwon_ck>, <&emu_per_alwon_ck>, <&emu_mpu_alwon_ck>;
+	reg = <0x48005140 0x4>;
+};
+
+emu_src_ck: emu_src_ck {
+	#clock-cells = <0>;
+	compatible = "ti,clkdm-gate-clock";
+	clocks = <&emu_src_mux_ck>;
+};
+
+pclk_fck: pclk_fck@48005140 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&emu_src_ck>;
+	ti,bit-shift = <8>;
+	ti,max-div = <7>;
+	reg = <0x48005140 0x4>;
+	ti,index-starts-at-one;
+};
+
+pclkx2_fck: pclkx2_fck@48005140 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&emu_src_ck>;
+	ti,bit-shift = <6>;
+	ti,max-div = <3>;
+	reg = <0x48005140 0x4>;
+	ti,index-starts-at-one;
+};
+
+atclk_fck: atclk_fck@48005140 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&emu_src_ck>;
+	ti,bit-shift = <4>;
+	ti,max-div = <3>;
+	reg = <0x48005140 0x4>;
+	ti,index-starts-at-one;
+};
+
+traceclk_src_fck: traceclk_src_fck@48005140 {
+	#clock-cells = <0>;
+	compatible = "ti,mux-clock";
+	clocks = <&sys_ck>, <&emu_core_alwon_ck>, <&emu_per_alwon_ck>, <&emu_mpu_alwon_ck>;
+	ti,bit-shift = <2>;
+	reg = <0x48005140 0x4>;
+};
+
+traceclk_fck: traceclk_fck@48005140 {
+	#clock-cells = <0>;
+	compatible = "ti,divider-clock";
+	clocks = <&traceclk_src_fck>;
+	ti,bit-shift = <11>;
+	ti,max-div = <7>;
+	reg = <0x48005140 0x4>;
+	ti,index-starts-at-one;
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

