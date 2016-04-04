From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/8] ARM: dts: omap3: fix clock node definitions to avoid build warnings
Date: Mon, 4 Apr 2016 18:16:06 +0300
Message-ID: <1459782973-21201-2-git-send-email-t-kristo@ti.com>
References: <1459782973-21201-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459782973-21201-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Upcoming change to DT compiler is going to complain about nodes
which have a reg property, but have not defined the address in their
name. This patch fixes following type of warnings for OMAP3 clock nodes:

Warning (unit_address_vs_reg): Node /ocp/cm@48004000/clocks/dpll3_m2_ck
has a reg or ranges property, but no unit name

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am35xx-clocks.dtsi               |   20 +-
 arch/arm/boot/dts/omap3430es1-clocks.dtsi          |   30 +--
 arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi    |   44 ++--
 .../omap36xx-am35xx-omap3430es2plus-clocks.dtsi    |   32 +--
 arch/arm/boot/dts/omap36xx-clocks.dtsi             |   14 +-
 .../boot/dts/omap36xx-omap3430es2plus-clocks.dtsi  |   14 +-
 arch/arm/boot/dts/omap3xxx-clocks.dtsi             |  276 ++++++++++----------
 7 files changed, 215 insertions(+), 215 deletions(-)

diff --git a/arch/arm/boot/dts/am35xx-clocks.dtsi b/arch/arm/boot/dts/am35xx-clocks.dtsi
index 18cc826..00dd1f0 100644
--- a/arch/arm/boot/dts/am35xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am35xx-clocks.dtsi
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  */
 &scm_clocks {
-	emac_ick: emac_ick {
+	emac_ick: emac_ick@32c {
 		#clock-cells = <0>;
 		compatible = "ti,am35xx-gate-clock";
 		clocks = <&ipss_ick>;
@@ -16,7 +16,7 @@
 		ti,bit-shift = <1>;
 	};
 
-	emac_fck: emac_fck {
+	emac_fck: emac_fck@32c {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&rmii_ck>;
@@ -24,7 +24,7 @@
 		ti,bit-shift = <9>;
 	};
 
-	vpfe_ick: vpfe_ick {
+	vpfe_ick: vpfe_ick@32c {
 		#clock-cells = <0>;
 		compatible = "ti,am35xx-gate-clock";
 		clocks = <&ipss_ick>;
@@ -32,7 +32,7 @@
 		ti,bit-shift = <2>;
 	};
 
-	vpfe_fck: vpfe_fck {
+	vpfe_fck: vpfe_fck@32c {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&pclk_ck>;
@@ -40,7 +40,7 @@
 		ti,bit-shift = <10>;
 	};
 
-	hsotgusb_ick_am35xx: hsotgusb_ick_am35xx {
+	hsotgusb_ick_am35xx: hsotgusb_ick_am35xx@32c {
 		#clock-cells = <0>;
 		compatible = "ti,am35xx-gate-clock";
 		clocks = <&ipss_ick>;
@@ -48,7 +48,7 @@
 		ti,bit-shift = <0>;
 	};
 
-	hsotgusb_fck_am35xx: hsotgusb_fck_am35xx {
+	hsotgusb_fck_am35xx: hsotgusb_fck_am35xx@32c {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_ck>;
@@ -56,7 +56,7 @@
 		ti,bit-shift = <8>;
 	};
 
-	hecc_ck: hecc_ck {
+	hecc_ck: hecc_ck@32c {
 		#clock-cells = <0>;
 		compatible = "ti,am35xx-gate-clock";
 		clocks = <&sys_ck>;
@@ -65,7 +65,7 @@
 	};
 };
 &cm_clocks {
-	ipss_ick: ipss_ick {
+	ipss_ick: ipss_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,am35xx-interface-clock";
 		clocks = <&core_l3_ick>;
@@ -85,7 +85,7 @@
 		clock-frequency = <27000000>;
 	};
 
-	uart4_ick_am35xx: uart4_ick_am35xx {
+	uart4_ick_am35xx: uart4_ick_am35xx@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -93,7 +93,7 @@
 		ti,bit-shift = <23>;
 	};
 
-	uart4_fck_am35xx: uart4_fck_am35xx {
+	uart4_fck_am35xx: uart4_fck_am35xx@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_48m_fck>;
diff --git a/arch/arm/boot/dts/omap3430es1-clocks.dtsi b/arch/arm/boot/dts/omap3430es1-clocks.dtsi
index 4c22f3a..86de819 100644
--- a/arch/arm/boot/dts/omap3430es1-clocks.dtsi
+++ b/arch/arm/boot/dts/omap3430es1-clocks.dtsi
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  */
 &cm_clocks {
-	gfx_l3_ck: gfx_l3_ck {
+	gfx_l3_ck: gfx_l3_ck@b10 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&l3_ick>;
@@ -16,7 +16,7 @@
 		ti,bit-shift = <0>;
 	};
 
-	gfx_l3_fck: gfx_l3_fck {
+	gfx_l3_fck: gfx_l3_fck@b40 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&l3_ick>;
@@ -33,7 +33,7 @@
 		clock-div = <1>;
 	};
 
-	gfx_cg1_ck: gfx_cg1_ck {
+	gfx_cg1_ck: gfx_cg1_ck@b00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&gfx_l3_fck>;
@@ -41,7 +41,7 @@
 		ti,bit-shift = <1>;
 	};
 
-	gfx_cg2_ck: gfx_cg2_ck {
+	gfx_cg2_ck: gfx_cg2_ck@b00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&gfx_l3_fck>;
@@ -49,7 +49,7 @@
 		ti,bit-shift = <2>;
 	};
 
-	d2d_26m_fck: d2d_26m_fck {
+	d2d_26m_fck: d2d_26m_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&sys_ck>;
@@ -57,7 +57,7 @@
 		ti,bit-shift = <3>;
 	};
 
-	fshostusb_fck: fshostusb_fck {
+	fshostusb_fck: fshostusb_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_48m_fck>;
@@ -65,7 +65,7 @@
 		ti,bit-shift = <5>;
 	};
 
-	ssi_ssr_gate_fck_3430es1: ssi_ssr_gate_fck_3430es1 {
+	ssi_ssr_gate_fck_3430es1: ssi_ssr_gate_fck_3430es1@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&corex2_fck>;
@@ -73,7 +73,7 @@
 		reg = <0x0a00>;
 	};
 
-	ssi_ssr_div_fck_3430es1: ssi_ssr_div_fck_3430es1 {
+	ssi_ssr_div_fck_3430es1: ssi_ssr_div_fck_3430es1@a40 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-divider-clock";
 		clocks = <&corex2_fck>;
@@ -96,7 +96,7 @@
 		clock-div = <2>;
 	};
 
-	hsotgusb_ick_3430es1: hsotgusb_ick_3430es1 {
+	hsotgusb_ick_3430es1: hsotgusb_ick_3430es1@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-no-wait-interface-clock";
 		clocks = <&core_l3_ick>;
@@ -104,7 +104,7 @@
 		ti,bit-shift = <4>;
 	};
 
-	fac_ick: fac_ick {
+	fac_ick: fac_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -120,7 +120,7 @@
 		clock-div = <1>;
 	};
 
-	ssi_ick: ssi_ick_3430es1 {
+	ssi_ick: ssi_ick_3430es1@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-no-wait-interface-clock";
 		clocks = <&ssi_l4_ick>;
@@ -128,7 +128,7 @@
 		ti,bit-shift = <0>;
 	};
 
-	usb_l4_gate_ick: usb_l4_gate_ick {
+	usb_l4_gate_ick: usb_l4_gate_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-interface-clock";
 		clocks = <&l4_ick>;
@@ -136,7 +136,7 @@
 		reg = <0x0a10>;
 	};
 
-	usb_l4_div_ick: usb_l4_div_ick {
+	usb_l4_div_ick: usb_l4_div_ick@a40 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-divider-clock";
 		clocks = <&l4_ick>;
@@ -152,7 +152,7 @@
 		clocks = <&usb_l4_gate_ick>, <&usb_l4_div_ick>;
 	};
 
-	dss1_alwon_fck: dss1_alwon_fck_3430es1 {
+	dss1_alwon_fck: dss1_alwon_fck_3430es1@e00 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll4_m4x2_ck>;
@@ -161,7 +161,7 @@
 		ti,set-rate-parent;
 	};
 
-	dss_ick: dss_ick_3430es1 {
+	dss_ick: dss_ick_3430es1@e10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-no-wait-interface-clock";
 		clocks = <&l4_ick>;
diff --git a/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi b/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi
index b02017b..858aa07 100644
--- a/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap34xx-omap36xx-clocks.dtsi
@@ -16,7 +16,7 @@
 		clock-div = <1>;
 	};
 
-	aes1_ick: aes1_ick {
+	aes1_ick: aes1_ick@a14 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&security_l4_ick2>;
@@ -24,7 +24,7 @@
 		reg = <0x0a14>;
 	};
 
-	rng_ick: rng_ick {
+	rng_ick: rng_ick@a14 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&security_l4_ick2>;
@@ -32,7 +32,7 @@
 		ti,bit-shift = <2>;
 	};
 
-	sha11_ick: sha11_ick {
+	sha11_ick: sha11_ick@a14 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&security_l4_ick2>;
@@ -40,7 +40,7 @@
 		ti,bit-shift = <1>;
 	};
 
-	des1_ick: des1_ick {
+	des1_ick: des1_ick@a14 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&security_l4_ick2>;
@@ -48,7 +48,7 @@
 		ti,bit-shift = <0>;
 	};
 
-	cam_mclk: cam_mclk {
+	cam_mclk: cam_mclk@f00 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll4_m5x2_ck>;
@@ -57,7 +57,7 @@
 		ti,set-rate-parent;
 	};
 
-	cam_ick: cam_ick {
+	cam_ick: cam_ick@f10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-no-wait-interface-clock";
 		clocks = <&l4_ick>;
@@ -65,7 +65,7 @@
 		ti,bit-shift = <0>;
 	};
 
-	csi2_96m_fck: csi2_96m_fck {
+	csi2_96m_fck: csi2_96m_fck@f00 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&core_96m_fck>;
@@ -81,7 +81,7 @@
 		clock-div = <1>;
 	};
 
-	pka_ick: pka_ick {
+	pka_ick: pka_ick@a14 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&security_l3_ick>;
@@ -89,7 +89,7 @@
 		ti,bit-shift = <4>;
 	};
 
-	icr_ick: icr_ick {
+	icr_ick: icr_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -97,7 +97,7 @@
 		ti,bit-shift = <29>;
 	};
 
-	des2_ick: des2_ick {
+	des2_ick: des2_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -105,7 +105,7 @@
 		ti,bit-shift = <26>;
 	};
 
-	mspro_ick: mspro_ick {
+	mspro_ick: mspro_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -113,7 +113,7 @@
 		ti,bit-shift = <23>;
 	};
 
-	mailboxes_ick: mailboxes_ick {
+	mailboxes_ick: mailboxes_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -129,7 +129,7 @@
 		clock-div = <1>;
 	};
 
-	sr1_fck: sr1_fck {
+	sr1_fck: sr1_fck@c00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&sys_ck>;
@@ -137,7 +137,7 @@
 		ti,bit-shift = <6>;
 	};
 
-	sr2_fck: sr2_fck {
+	sr2_fck: sr2_fck@c00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&sys_ck>;
@@ -153,7 +153,7 @@
 		clock-div = <1>;
 	};
 
-	dpll2_fck: dpll2_fck {
+	dpll2_fck: dpll2_fck@40 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&core_ck>;
@@ -163,7 +163,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll2_ck: dpll2_ck {
+	dpll2_ck: dpll2_ck@4 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-dpll-clock";
 		clocks = <&sys_ck>, <&dpll2_fck>;
@@ -173,7 +173,7 @@
 		ti,low-power-bypass;
 	};
 
-	dpll2_m2_ck: dpll2_m2_ck {
+	dpll2_m2_ck: dpll2_m2_ck@44 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll2_ck>;
@@ -182,7 +182,7 @@
 		ti,index-starts-at-one;
 	};
 
-	iva2_ck: iva2_ck {
+	iva2_ck: iva2_ck@0 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&dpll2_m2_ck>;
@@ -190,7 +190,7 @@
 		ti,bit-shift = <0>;
 	};
 
-	modem_fck: modem_fck {
+	modem_fck: modem_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&sys_ck>;
@@ -198,7 +198,7 @@
 		ti,bit-shift = <31>;
 	};
 
-	sad2d_ick: sad2d_ick {
+	sad2d_ick: sad2d_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l3_ick>;
@@ -206,7 +206,7 @@
 		ti,bit-shift = <3>;
 	};
 
-	mad2d_ick: mad2d_ick {
+	mad2d_ick: mad2d_ick@a18 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&l3_ick>;
@@ -214,7 +214,7 @@
 		ti,bit-shift = <3>;
 	};
 
-	mspro_fck: mspro_fck {
+	mspro_fck: mspro_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_96m_fck>;
diff --git a/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi b/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
index 080fb3f..15d1866 100644
--- a/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
+++ b/arch/arm/boot/dts/omap36xx-am35xx-omap3430es2plus-clocks.dtsi
@@ -25,7 +25,7 @@
 	};
 };
 &cm_clocks {
-	dpll5_ck: dpll5_ck {
+	dpll5_ck: dpll5_ck@d04 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-dpll-clock";
 		clocks = <&sys_ck>, <&sys_ck>;
@@ -34,7 +34,7 @@
 		ti,lock;
 	};
 
-	dpll5_m2_ck: dpll5_m2_ck {
+	dpll5_m2_ck: dpll5_m2_ck@d50 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll5_ck>;
@@ -43,7 +43,7 @@
 		ti,index-starts-at-one;
 	};
 
-	sgx_gate_fck: sgx_gate_fck {
+	sgx_gate_fck: sgx_gate_fck@b00 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&core_ck>;
@@ -91,7 +91,7 @@
 		clock-div = <2>;
 	};
 
-	sgx_mux_fck: sgx_mux_fck {
+	sgx_mux_fck: sgx_mux_fck@b40 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&core_d3_ck>, <&core_d4_ck>, <&core_d6_ck>, <&cm_96m_fck>, <&omap_192m_alwon_fck>, <&core_d2_ck>, <&corex2_d3_fck>, <&corex2_d5_fck>;
@@ -104,7 +104,7 @@
 		clocks = <&sgx_gate_fck>, <&sgx_mux_fck>;
 	};
 
-	sgx_ick: sgx_ick {
+	sgx_ick: sgx_ick@b10 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&l3_ick>;
@@ -112,7 +112,7 @@
 		ti,bit-shift = <0>;
 	};
 
-	cpefuse_fck: cpefuse_fck {
+	cpefuse_fck: cpefuse_fck@a08 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_ck>;
@@ -120,7 +120,7 @@
 		ti,bit-shift = <0>;
 	};
 
-	ts_fck: ts_fck {
+	ts_fck: ts_fck@a08 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&omap_32k_fck>;
@@ -128,7 +128,7 @@
 		ti,bit-shift = <1>;
 	};
 
-	usbtll_fck: usbtll_fck {
+	usbtll_fck: usbtll_fck@a08 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&dpll5_m2_ck>;
@@ -136,7 +136,7 @@
 		ti,bit-shift = <2>;
 	};
 
-	usbtll_ick: usbtll_ick {
+	usbtll_ick: usbtll_ick@a18 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -144,7 +144,7 @@
 		ti,bit-shift = <2>;
 	};
 
-	mmchs3_ick: mmchs3_ick {
+	mmchs3_ick: mmchs3_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -152,7 +152,7 @@
 		ti,bit-shift = <30>;
 	};
 
-	mmchs3_fck: mmchs3_fck {
+	mmchs3_fck: mmchs3_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_96m_fck>;
@@ -160,7 +160,7 @@
 		ti,bit-shift = <30>;
 	};
 
-	dss1_alwon_fck: dss1_alwon_fck_3430es2 {
+	dss1_alwon_fck: dss1_alwon_fck_3430es2@e00 {
 		#clock-cells = <0>;
 		compatible = "ti,dss-gate-clock";
 		clocks = <&dpll4_m4x2_ck>;
@@ -169,7 +169,7 @@
 		ti,set-rate-parent;
 	};
 
-	dss_ick: dss_ick_3430es2 {
+	dss_ick: dss_ick_3430es2@e10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-dss-interface-clock";
 		clocks = <&l4_ick>;
@@ -177,7 +177,7 @@
 		ti,bit-shift = <0>;
 	};
 
-	usbhost_120m_fck: usbhost_120m_fck {
+	usbhost_120m_fck: usbhost_120m_fck@1400 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll5_m2_ck>;
@@ -185,7 +185,7 @@
 		ti,bit-shift = <1>;
 	};
 
-	usbhost_48m_fck: usbhost_48m_fck {
+	usbhost_48m_fck: usbhost_48m_fck@1400 {
 		#clock-cells = <0>;
 		compatible = "ti,dss-gate-clock";
 		clocks = <&omap_48m_fck>;
@@ -193,7 +193,7 @@
 		ti,bit-shift = <0>;
 	};
 
-	usbhost_ick: usbhost_ick {
+	usbhost_ick: usbhost_ick@1410 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-dss-interface-clock";
 		clocks = <&l4_ick>;
diff --git a/arch/arm/boot/dts/omap36xx-clocks.dtsi b/arch/arm/boot/dts/omap36xx-clocks.dtsi
index 200ae3a..a21d1f0 100644
--- a/arch/arm/boot/dts/omap36xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap36xx-clocks.dtsi
@@ -8,14 +8,14 @@
  * published by the Free Software Foundation.
  */
 &cm_clocks {
-	dpll4_ck: dpll4_ck {
+	dpll4_ck: dpll4_ck@d00 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-dpll-per-j-type-clock";
 		clocks = <&sys_ck>, <&sys_ck>;
 		reg = <0x0d00>, <0x0d20>, <0x0d44>, <0x0d30>;
 	};
 
-	dpll4_m5x2_ck: dpll4_m5x2_ck {
+	dpll4_m5x2_ck: dpll4_m5x2_ck@d00 {
 		#clock-cells = <0>;
 		compatible = "ti,hsdiv-gate-clock";
 		clocks = <&dpll4_m5x2_mul_ck>;
@@ -25,7 +25,7 @@
 		ti,set-bit-to-disable;
 	};
 
-	dpll4_m2x2_ck: dpll4_m2x2_ck {
+	dpll4_m2x2_ck: dpll4_m2x2_ck@d00 {
 		#clock-cells = <0>;
 		compatible = "ti,hsdiv-gate-clock";
 		clocks = <&dpll4_m2x2_mul_ck>;
@@ -34,7 +34,7 @@
 		ti,set-bit-to-disable;
 	};
 
-	dpll3_m3x2_ck: dpll3_m3x2_ck {
+	dpll3_m3x2_ck: dpll3_m3x2_ck@d00 {
 		#clock-cells = <0>;
 		compatible = "ti,hsdiv-gate-clock";
 		clocks = <&dpll3_m3x2_mul_ck>;
@@ -43,7 +43,7 @@
 		ti,set-bit-to-disable;
 	};
 
-	dpll4_m3x2_ck: dpll4_m3x2_ck {
+	dpll4_m3x2_ck: dpll4_m3x2_ck@d00 {
 		#clock-cells = <0>;
 		compatible = "ti,hsdiv-gate-clock";
 		clocks = <&dpll4_m3x2_mul_ck>;
@@ -52,7 +52,7 @@
 		ti,set-bit-to-disable;
 	};
 
-	dpll4_m6x2_ck: dpll4_m6x2_ck {
+	dpll4_m6x2_ck: dpll4_m6x2_ck@d00 {
 		#clock-cells = <0>;
 		compatible = "ti,hsdiv-gate-clock";
 		clocks = <&dpll4_m6x2_mul_ck>;
@@ -61,7 +61,7 @@
 		ti,set-bit-to-disable;
 	};
 
-	uart4_fck: uart4_fck {
+	uart4_fck: uart4_fck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&per_48m_fck>;
diff --git a/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi b/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
index 877318c..1a4fbdf 100644
--- a/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
+++ b/arch/arm/boot/dts/omap36xx-omap3430es2plus-clocks.dtsi
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  */
 &cm_clocks {
-	ssi_ssr_gate_fck_3430es2: ssi_ssr_gate_fck_3430es2 {
+	ssi_ssr_gate_fck_3430es2: ssi_ssr_gate_fck_3430es2@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&corex2_fck>;
@@ -16,7 +16,7 @@
 		reg = <0x0a00>;
 	};
 
-	ssi_ssr_div_fck_3430es2: ssi_ssr_div_fck_3430es2 {
+	ssi_ssr_div_fck_3430es2: ssi_ssr_div_fck_3430es2@a40 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-divider-clock";
 		clocks = <&corex2_fck>;
@@ -39,7 +39,7 @@
 		clock-div = <2>;
 	};
 
-	hsotgusb_ick_3430es2: hsotgusb_ick_3430es2 {
+	hsotgusb_ick_3430es2: hsotgusb_ick_3430es2@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-hsotgusb-interface-clock";
 		clocks = <&core_l3_ick>;
@@ -55,7 +55,7 @@
 		clock-div = <1>;
 	};
 
-	ssi_ick: ssi_ick_3430es2 {
+	ssi_ick: ssi_ick_3430es2@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-ssi-interface-clock";
 		clocks = <&ssi_l4_ick>;
@@ -63,7 +63,7 @@
 		ti,bit-shift = <0>;
 	};
 
-	usim_gate_fck: usim_gate_fck {
+	usim_gate_fck: usim_gate_fck@c00 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&omap_96m_fck>;
@@ -143,7 +143,7 @@
 		clock-div = <20>;
 	};
 
-	usim_mux_fck: usim_mux_fck {
+	usim_mux_fck: usim_mux_fck@c40 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&sys_ck>, <&sys_d2_ck>, <&omap_96m_d2_fck>, <&omap_96m_d4_fck>, <&omap_96m_d8_fck>, <&omap_96m_d10_fck>, <&dpll5_m2_d4_ck>, <&dpll5_m2_d8_ck>, <&dpll5_m2_d16_ck>, <&dpll5_m2_d20_ck>;
@@ -158,7 +158,7 @@
 		clocks = <&usim_gate_fck>, <&usim_mux_fck>;
 	};
 
-	usim_ick: usim_ick {
+	usim_ick: usim_ick@c10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&wkup_l4_ick>;
diff --git a/arch/arm/boot/dts/omap3xxx-clocks.dtsi b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
index bbba5bd..9bd9164 100644
--- a/arch/arm/boot/dts/omap3xxx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
@@ -14,14 +14,14 @@
 		clock-frequency = <16800000>;
 	};
 
-	osc_sys_ck: osc_sys_ck {
+	osc_sys_ck: osc_sys_ck@d40 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&virt_12m_ck>, <&virt_13m_ck>, <&virt_19200000_ck>, <&virt_26000000_ck>, <&virt_38_4m_ck>, <&virt_16_8m_ck>;
 		reg = <0x0d40>;
 	};
 
-	sys_ck: sys_ck {
+	sys_ck: sys_ck@1270 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&osc_sys_ck>;
@@ -31,7 +31,7 @@
 		ti,index-starts-at-one;
 	};
 
-	sys_clkout1: sys_clkout1 {
+	sys_clkout1: sys_clkout1@d70 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&osc_sys_ck>;
@@ -81,7 +81,7 @@
 };
 
 &scm_clocks {
-	mcbsp5_mux_fck: mcbsp5_mux_fck {
+	mcbsp5_mux_fck: mcbsp5_mux_fck@68 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&core_96m_fck>, <&mcbsp_clks>;
@@ -95,7 +95,7 @@
 		clocks = <&mcbsp5_gate_fck>, <&mcbsp5_mux_fck>;
 	};
 
-	mcbsp1_mux_fck: mcbsp1_mux_fck {
+	mcbsp1_mux_fck: mcbsp1_mux_fck@4 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&core_96m_fck>, <&mcbsp_clks>;
@@ -109,7 +109,7 @@
 		clocks = <&mcbsp1_gate_fck>, <&mcbsp1_mux_fck>;
 	};
 
-	mcbsp2_mux_fck: mcbsp2_mux_fck {
+	mcbsp2_mux_fck: mcbsp2_mux_fck@4 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&per_96m_fck>, <&mcbsp_clks>;
@@ -123,7 +123,7 @@
 		clocks = <&mcbsp2_gate_fck>, <&mcbsp2_mux_fck>;
 	};
 
-	mcbsp3_mux_fck: mcbsp3_mux_fck {
+	mcbsp3_mux_fck: mcbsp3_mux_fck@68 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&per_96m_fck>, <&mcbsp_clks>;
@@ -136,7 +136,7 @@
 		clocks = <&mcbsp3_gate_fck>, <&mcbsp3_mux_fck>;
 	};
 
-	mcbsp4_mux_fck: mcbsp4_mux_fck {
+	mcbsp4_mux_fck: mcbsp4_mux_fck@68 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&per_96m_fck>, <&mcbsp_clks>;
@@ -193,14 +193,14 @@
 		clock-frequency = <38400000>;
 	};
 
-	dpll4_ck: dpll4_ck {
+	dpll4_ck: dpll4_ck@d00 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-dpll-per-clock";
 		clocks = <&sys_ck>, <&sys_ck>;
 		reg = <0x0d00>, <0x0d20>, <0x0d44>, <0x0d30>;
 	};
 
-	dpll4_m2_ck: dpll4_m2_ck {
+	dpll4_m2_ck: dpll4_m2_ck@d48 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll4_ck>;
@@ -217,7 +217,7 @@
 		clock-div = <1>;
 	};
 
-	dpll4_m2x2_ck: dpll4_m2x2_ck {
+	dpll4_m2x2_ck: dpll4_m2x2_ck@d00 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll4_m2x2_mul_ck>;
@@ -234,14 +234,14 @@
 		clock-div = <1>;
 	};
 
-	dpll3_ck: dpll3_ck {
+	dpll3_ck: dpll3_ck@d00 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-dpll-core-clock";
 		clocks = <&sys_ck>, <&sys_ck>;
 		reg = <0x0d00>, <0x0d20>, <0x0d40>, <0x0d30>;
 	};
 
-	dpll3_m3_ck: dpll3_m3_ck {
+	dpll3_m3_ck: dpll3_m3_ck@1140 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll3_ck>;
@@ -259,7 +259,7 @@
 		clock-div = <1>;
 	};
 
-	dpll3_m3x2_ck: dpll3_m3x2_ck {
+	dpll3_m3x2_ck: dpll3_m3x2_ck@d00 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll3_m3x2_mul_ck>;
@@ -288,7 +288,7 @@
 		clock-frequency = <0x0>;
 	};
 
-	dpll3_m2_ck: dpll3_m2_ck {
+	dpll3_m2_ck: dpll3_m2_ck@d40 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll3_ck>;
@@ -306,7 +306,7 @@
 		clock-div = <1>;
 	};
 
-	dpll1_fck: dpll1_fck {
+	dpll1_fck: dpll1_fck@940 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&core_ck>;
@@ -316,7 +316,7 @@
 		ti,index-starts-at-one;
 	};
 
-	dpll1_ck: dpll1_ck {
+	dpll1_ck: dpll1_ck@904 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-dpll-clock";
 		clocks = <&sys_ck>, <&dpll1_fck>;
@@ -331,7 +331,7 @@
 		clock-div = <1>;
 	};
 
-	dpll1_x2m2_ck: dpll1_x2m2_ck {
+	dpll1_x2m2_ck: dpll1_x2m2_ck@944 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll1_x2_ck>;
@@ -348,7 +348,7 @@
 		clock-div = <1>;
 	};
 
-	omap_96m_fck: omap_96m_fck {
+	omap_96m_fck: omap_96m_fck@d40 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&cm_96m_fck>, <&sys_ck>;
@@ -356,7 +356,7 @@
 		reg = <0x0d40>;
 	};
 
-	dpll4_m3_ck: dpll4_m3_ck {
+	dpll4_m3_ck: dpll4_m3_ck@e40 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll4_ck>;
@@ -374,7 +374,7 @@
 		clock-div = <1>;
 	};
 
-	dpll4_m3x2_ck: dpll4_m3x2_ck {
+	dpll4_m3x2_ck: dpll4_m3x2_ck@d00 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll4_m3x2_mul_ck>;
@@ -383,7 +383,7 @@
 		ti,set-bit-to-disable;
 	};
 
-	omap_54m_fck: omap_54m_fck {
+	omap_54m_fck: omap_54m_fck@d40 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&dpll4_m3x2_ck>, <&sys_altclk>;
@@ -399,7 +399,7 @@
 		clock-div = <2>;
 	};
 
-	omap_48m_fck: omap_48m_fck {
+	omap_48m_fck: omap_48m_fck@d40 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&cm_96m_d2_fck>, <&sys_altclk>;
@@ -415,7 +415,7 @@
 		clock-div = <4>;
 	};
 
-	dpll4_m4_ck: dpll4_m4_ck {
+	dpll4_m4_ck: dpll4_m4_ck@e40 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll4_ck>;
@@ -433,7 +433,7 @@
 		ti,set-rate-parent;
 	};
 
-	dpll4_m4x2_ck: dpll4_m4x2_ck {
+	dpll4_m4x2_ck: dpll4_m4x2_ck@d00 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll4_m4x2_mul_ck>;
@@ -443,7 +443,7 @@
 		ti,set-rate-parent;
 	};
 
-	dpll4_m5_ck: dpll4_m5_ck {
+	dpll4_m5_ck: dpll4_m5_ck@f40 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll4_ck>;
@@ -461,7 +461,7 @@
 		ti,set-rate-parent;
 	};
 
-	dpll4_m5x2_ck: dpll4_m5x2_ck {
+	dpll4_m5x2_ck: dpll4_m5x2_ck@d00 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll4_m5x2_mul_ck>;
@@ -471,7 +471,7 @@
 		ti,set-rate-parent;
 	};
 
-	dpll4_m6_ck: dpll4_m6_ck {
+	dpll4_m6_ck: dpll4_m6_ck@1140 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&dpll4_ck>;
@@ -489,7 +489,7 @@
 		clock-div = <1>;
 	};
 
-	dpll4_m6x2_ck: dpll4_m6x2_ck {
+	dpll4_m6x2_ck: dpll4_m6x2_ck@d00 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&dpll4_m6x2_mul_ck>;
@@ -506,7 +506,7 @@
 		clock-div = <1>;
 	};
 
-	clkout2_src_gate_ck: clkout2_src_gate_ck {
+	clkout2_src_gate_ck: clkout2_src_gate_ck@d70 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-no-wait-gate-clock";
 		clocks = <&core_ck>;
@@ -514,7 +514,7 @@
 		reg = <0x0d70>;
 	};
 
-	clkout2_src_mux_ck: clkout2_src_mux_ck {
+	clkout2_src_mux_ck: clkout2_src_mux_ck@d70 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&core_ck>, <&sys_ck>, <&cm_96m_fck>, <&omap_54m_fck>;
@@ -527,7 +527,7 @@
 		clocks = <&clkout2_src_gate_ck>, <&clkout2_src_mux_ck>;
 	};
 
-	sys_clkout2: sys_clkout2 {
+	sys_clkout2: sys_clkout2@d70 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&clkout2_src_ck>;
@@ -545,7 +545,7 @@
 		clock-div = <1>;
 	};
 
-	arm_fck: arm_fck {
+	arm_fck: arm_fck@924 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&mpu_ck>;
@@ -561,7 +561,7 @@
 		clock-div = <1>;
 	};
 
-	l3_ick: l3_ick {
+	l3_ick: l3_ick@a40 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&core_ck>;
@@ -570,7 +570,7 @@
 		ti,index-starts-at-one;
 	};
 
-	l4_ick: l4_ick {
+	l4_ick: l4_ick@a40 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&l3_ick>;
@@ -580,7 +580,7 @@
 		ti,index-starts-at-one;
 	};
 
-	rm_ick: rm_ick {
+	rm_ick: rm_ick@c40 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&l4_ick>;
@@ -590,7 +590,7 @@
 		ti,index-starts-at-one;
 	};
 
-	gpt10_gate_fck: gpt10_gate_fck {
+	gpt10_gate_fck: gpt10_gate_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&sys_ck>;
@@ -598,7 +598,7 @@
 		reg = <0x0a00>;
 	};
 
-	gpt10_mux_fck: gpt10_mux_fck {
+	gpt10_mux_fck: gpt10_mux_fck@a40 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&omap_32k_fck>, <&sys_ck>;
@@ -612,7 +612,7 @@
 		clocks = <&gpt10_gate_fck>, <&gpt10_mux_fck>;
 	};
 
-	gpt11_gate_fck: gpt11_gate_fck {
+	gpt11_gate_fck: gpt11_gate_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&sys_ck>;
@@ -620,7 +620,7 @@
 		reg = <0x0a00>;
 	};
 
-	gpt11_mux_fck: gpt11_mux_fck {
+	gpt11_mux_fck: gpt11_mux_fck@a40 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&omap_32k_fck>, <&sys_ck>;
@@ -642,7 +642,7 @@
 		clock-div = <1>;
 	};
 
-	mmchs2_fck: mmchs2_fck {
+	mmchs2_fck: mmchs2_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_96m_fck>;
@@ -650,7 +650,7 @@
 		ti,bit-shift = <25>;
 	};
 
-	mmchs1_fck: mmchs1_fck {
+	mmchs1_fck: mmchs1_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_96m_fck>;
@@ -658,7 +658,7 @@
 		ti,bit-shift = <24>;
 	};
 
-	i2c3_fck: i2c3_fck {
+	i2c3_fck: i2c3_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_96m_fck>;
@@ -666,7 +666,7 @@
 		ti,bit-shift = <17>;
 	};
 
-	i2c2_fck: i2c2_fck {
+	i2c2_fck: i2c2_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_96m_fck>;
@@ -674,7 +674,7 @@
 		ti,bit-shift = <16>;
 	};
 
-	i2c1_fck: i2c1_fck {
+	i2c1_fck: i2c1_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_96m_fck>;
@@ -682,7 +682,7 @@
 		ti,bit-shift = <15>;
 	};
 
-	mcbsp5_gate_fck: mcbsp5_gate_fck {
+	mcbsp5_gate_fck: mcbsp5_gate_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&mcbsp_clks>;
@@ -690,7 +690,7 @@
 		reg = <0x0a00>;
 	};
 
-	mcbsp1_gate_fck: mcbsp1_gate_fck {
+	mcbsp1_gate_fck: mcbsp1_gate_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&mcbsp_clks>;
@@ -706,7 +706,7 @@
 		clock-div = <1>;
 	};
 
-	mcspi4_fck: mcspi4_fck {
+	mcspi4_fck: mcspi4_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_48m_fck>;
@@ -714,7 +714,7 @@
 		ti,bit-shift = <21>;
 	};
 
-	mcspi3_fck: mcspi3_fck {
+	mcspi3_fck: mcspi3_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_48m_fck>;
@@ -722,7 +722,7 @@
 		ti,bit-shift = <20>;
 	};
 
-	mcspi2_fck: mcspi2_fck {
+	mcspi2_fck: mcspi2_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_48m_fck>;
@@ -730,7 +730,7 @@
 		ti,bit-shift = <19>;
 	};
 
-	mcspi1_fck: mcspi1_fck {
+	mcspi1_fck: mcspi1_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_48m_fck>;
@@ -738,7 +738,7 @@
 		ti,bit-shift = <18>;
 	};
 
-	uart2_fck: uart2_fck {
+	uart2_fck: uart2_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_48m_fck>;
@@ -746,7 +746,7 @@
 		ti,bit-shift = <14>;
 	};
 
-	uart1_fck: uart1_fck {
+	uart1_fck: uart1_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_48m_fck>;
@@ -762,7 +762,7 @@
 		clock-div = <1>;
 	};
 
-	hdq_fck: hdq_fck {
+	hdq_fck: hdq_fck@a00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_12m_fck>;
@@ -778,7 +778,7 @@
 		clock-div = <1>;
 	};
 
-	sdrc_ick: sdrc_ick {
+	sdrc_ick: sdrc_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&core_l3_ick>;
@@ -802,7 +802,7 @@
 		clock-div = <1>;
 	};
 
-	mmchs2_ick: mmchs2_ick {
+	mmchs2_ick: mmchs2_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -810,7 +810,7 @@
 		ti,bit-shift = <25>;
 	};
 
-	mmchs1_ick: mmchs1_ick {
+	mmchs1_ick: mmchs1_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -818,7 +818,7 @@
 		ti,bit-shift = <24>;
 	};
 
-	hdq_ick: hdq_ick {
+	hdq_ick: hdq_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -826,7 +826,7 @@
 		ti,bit-shift = <22>;
 	};
 
-	mcspi4_ick: mcspi4_ick {
+	mcspi4_ick: mcspi4_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -834,7 +834,7 @@
 		ti,bit-shift = <21>;
 	};
 
-	mcspi3_ick: mcspi3_ick {
+	mcspi3_ick: mcspi3_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -842,7 +842,7 @@
 		ti,bit-shift = <20>;
 	};
 
-	mcspi2_ick: mcspi2_ick {
+	mcspi2_ick: mcspi2_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -850,7 +850,7 @@
 		ti,bit-shift = <19>;
 	};
 
-	mcspi1_ick: mcspi1_ick {
+	mcspi1_ick: mcspi1_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -858,7 +858,7 @@
 		ti,bit-shift = <18>;
 	};
 
-	i2c3_ick: i2c3_ick {
+	i2c3_ick: i2c3_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -866,7 +866,7 @@
 		ti,bit-shift = <17>;
 	};
 
-	i2c2_ick: i2c2_ick {
+	i2c2_ick: i2c2_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -874,7 +874,7 @@
 		ti,bit-shift = <16>;
 	};
 
-	i2c1_ick: i2c1_ick {
+	i2c1_ick: i2c1_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -882,7 +882,7 @@
 		ti,bit-shift = <15>;
 	};
 
-	uart2_ick: uart2_ick {
+	uart2_ick: uart2_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -890,7 +890,7 @@
 		ti,bit-shift = <14>;
 	};
 
-	uart1_ick: uart1_ick {
+	uart1_ick: uart1_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -898,7 +898,7 @@
 		ti,bit-shift = <13>;
 	};
 
-	gpt11_ick: gpt11_ick {
+	gpt11_ick: gpt11_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -906,7 +906,7 @@
 		ti,bit-shift = <12>;
 	};
 
-	gpt10_ick: gpt10_ick {
+	gpt10_ick: gpt10_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -914,7 +914,7 @@
 		ti,bit-shift = <11>;
 	};
 
-	mcbsp5_ick: mcbsp5_ick {
+	mcbsp5_ick: mcbsp5_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -922,7 +922,7 @@
 		ti,bit-shift = <10>;
 	};
 
-	mcbsp1_ick: mcbsp1_ick {
+	mcbsp1_ick: mcbsp1_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -930,7 +930,7 @@
 		ti,bit-shift = <9>;
 	};
 
-	omapctrl_ick: omapctrl_ick {
+	omapctrl_ick: omapctrl_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -938,7 +938,7 @@
 		ti,bit-shift = <6>;
 	};
 
-	dss_tv_fck: dss_tv_fck {
+	dss_tv_fck: dss_tv_fck@e00 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&omap_54m_fck>;
@@ -946,7 +946,7 @@
 		ti,bit-shift = <2>;
 	};
 
-	dss_96m_fck: dss_96m_fck {
+	dss_96m_fck: dss_96m_fck@e00 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&omap_96m_fck>;
@@ -954,7 +954,7 @@
 		ti,bit-shift = <2>;
 	};
 
-	dss2_alwon_fck: dss2_alwon_fck {
+	dss2_alwon_fck: dss2_alwon_fck@e00 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&sys_ck>;
@@ -968,7 +968,7 @@
 		clock-frequency = <0>;
 	};
 
-	gpt1_gate_fck: gpt1_gate_fck {
+	gpt1_gate_fck: gpt1_gate_fck@c00 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&sys_ck>;
@@ -976,7 +976,7 @@
 		reg = <0x0c00>;
 	};
 
-	gpt1_mux_fck: gpt1_mux_fck {
+	gpt1_mux_fck: gpt1_mux_fck@c40 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&omap_32k_fck>, <&sys_ck>;
@@ -989,7 +989,7 @@
 		clocks = <&gpt1_gate_fck>, <&gpt1_mux_fck>;
 	};
 
-	aes2_ick: aes2_ick {
+	aes2_ick: aes2_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -1005,7 +1005,7 @@
 		clock-div = <1>;
 	};
 
-	gpio1_dbck: gpio1_dbck {
+	gpio1_dbck: gpio1_dbck@c00 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&wkup_32k_fck>;
@@ -1013,7 +1013,7 @@
 		ti,bit-shift = <3>;
 	};
 
-	sha12_ick: sha12_ick {
+	sha12_ick: sha12_ick@a10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&core_l4_ick>;
@@ -1021,7 +1021,7 @@
 		ti,bit-shift = <27>;
 	};
 
-	wdt2_fck: wdt2_fck {
+	wdt2_fck: wdt2_fck@c00 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&wkup_32k_fck>;
@@ -1029,7 +1029,7 @@
 		ti,bit-shift = <5>;
 	};
 
-	wdt2_ick: wdt2_ick {
+	wdt2_ick: wdt2_ick@c10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&wkup_l4_ick>;
@@ -1037,7 +1037,7 @@
 		ti,bit-shift = <5>;
 	};
 
-	wdt1_ick: wdt1_ick {
+	wdt1_ick: wdt1_ick@c10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&wkup_l4_ick>;
@@ -1045,7 +1045,7 @@
 		ti,bit-shift = <4>;
 	};
 
-	gpio1_ick: gpio1_ick {
+	gpio1_ick: gpio1_ick@c10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&wkup_l4_ick>;
@@ -1053,7 +1053,7 @@
 		ti,bit-shift = <3>;
 	};
 
-	omap_32ksync_ick: omap_32ksync_ick {
+	omap_32ksync_ick: omap_32ksync_ick@c10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&wkup_l4_ick>;
@@ -1061,7 +1061,7 @@
 		ti,bit-shift = <2>;
 	};
 
-	gpt12_ick: gpt12_ick {
+	gpt12_ick: gpt12_ick@c10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&wkup_l4_ick>;
@@ -1069,7 +1069,7 @@
 		ti,bit-shift = <1>;
 	};
 
-	gpt1_ick: gpt1_ick {
+	gpt1_ick: gpt1_ick@c10 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&wkup_l4_ick>;
@@ -1093,7 +1093,7 @@
 		clock-div = <1>;
 	};
 
-	uart3_fck: uart3_fck {
+	uart3_fck: uart3_fck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&per_48m_fck>;
@@ -1101,7 +1101,7 @@
 		ti,bit-shift = <11>;
 	};
 
-	gpt2_gate_fck: gpt2_gate_fck {
+	gpt2_gate_fck: gpt2_gate_fck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&sys_ck>;
@@ -1109,7 +1109,7 @@
 		reg = <0x1000>;
 	};
 
-	gpt2_mux_fck: gpt2_mux_fck {
+	gpt2_mux_fck: gpt2_mux_fck@1040 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&omap_32k_fck>, <&sys_ck>;
@@ -1122,7 +1122,7 @@
 		clocks = <&gpt2_gate_fck>, <&gpt2_mux_fck>;
 	};
 
-	gpt3_gate_fck: gpt3_gate_fck {
+	gpt3_gate_fck: gpt3_gate_fck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&sys_ck>;
@@ -1130,7 +1130,7 @@
 		reg = <0x1000>;
 	};
 
-	gpt3_mux_fck: gpt3_mux_fck {
+	gpt3_mux_fck: gpt3_mux_fck@1040 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&omap_32k_fck>, <&sys_ck>;
@@ -1144,7 +1144,7 @@
 		clocks = <&gpt3_gate_fck>, <&gpt3_mux_fck>;
 	};
 
-	gpt4_gate_fck: gpt4_gate_fck {
+	gpt4_gate_fck: gpt4_gate_fck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&sys_ck>;
@@ -1152,7 +1152,7 @@
 		reg = <0x1000>;
 	};
 
-	gpt4_mux_fck: gpt4_mux_fck {
+	gpt4_mux_fck: gpt4_mux_fck@1040 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&omap_32k_fck>, <&sys_ck>;
@@ -1166,7 +1166,7 @@
 		clocks = <&gpt4_gate_fck>, <&gpt4_mux_fck>;
 	};
 
-	gpt5_gate_fck: gpt5_gate_fck {
+	gpt5_gate_fck: gpt5_gate_fck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&sys_ck>;
@@ -1174,7 +1174,7 @@
 		reg = <0x1000>;
 	};
 
-	gpt5_mux_fck: gpt5_mux_fck {
+	gpt5_mux_fck: gpt5_mux_fck@1040 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&omap_32k_fck>, <&sys_ck>;
@@ -1188,7 +1188,7 @@
 		clocks = <&gpt5_gate_fck>, <&gpt5_mux_fck>;
 	};
 
-	gpt6_gate_fck: gpt6_gate_fck {
+	gpt6_gate_fck: gpt6_gate_fck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&sys_ck>;
@@ -1196,7 +1196,7 @@
 		reg = <0x1000>;
 	};
 
-	gpt6_mux_fck: gpt6_mux_fck {
+	gpt6_mux_fck: gpt6_mux_fck@1040 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&omap_32k_fck>, <&sys_ck>;
@@ -1210,7 +1210,7 @@
 		clocks = <&gpt6_gate_fck>, <&gpt6_mux_fck>;
 	};
 
-	gpt7_gate_fck: gpt7_gate_fck {
+	gpt7_gate_fck: gpt7_gate_fck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&sys_ck>;
@@ -1218,7 +1218,7 @@
 		reg = <0x1000>;
 	};
 
-	gpt7_mux_fck: gpt7_mux_fck {
+	gpt7_mux_fck: gpt7_mux_fck@1040 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&omap_32k_fck>, <&sys_ck>;
@@ -1232,7 +1232,7 @@
 		clocks = <&gpt7_gate_fck>, <&gpt7_mux_fck>;
 	};
 
-	gpt8_gate_fck: gpt8_gate_fck {
+	gpt8_gate_fck: gpt8_gate_fck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&sys_ck>;
@@ -1240,7 +1240,7 @@
 		reg = <0x1000>;
 	};
 
-	gpt8_mux_fck: gpt8_mux_fck {
+	gpt8_mux_fck: gpt8_mux_fck@1040 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&omap_32k_fck>, <&sys_ck>;
@@ -1254,7 +1254,7 @@
 		clocks = <&gpt8_gate_fck>, <&gpt8_mux_fck>;
 	};
 
-	gpt9_gate_fck: gpt9_gate_fck {
+	gpt9_gate_fck: gpt9_gate_fck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&sys_ck>;
@@ -1262,7 +1262,7 @@
 		reg = <0x1000>;
 	};
 
-	gpt9_mux_fck: gpt9_mux_fck {
+	gpt9_mux_fck: gpt9_mux_fck@1040 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&omap_32k_fck>, <&sys_ck>;
@@ -1284,7 +1284,7 @@
 		clock-div = <1>;
 	};
 
-	gpio6_dbck: gpio6_dbck {
+	gpio6_dbck: gpio6_dbck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&per_32k_alwon_fck>;
@@ -1292,7 +1292,7 @@
 		ti,bit-shift = <17>;
 	};
 
-	gpio5_dbck: gpio5_dbck {
+	gpio5_dbck: gpio5_dbck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&per_32k_alwon_fck>;
@@ -1300,7 +1300,7 @@
 		ti,bit-shift = <16>;
 	};
 
-	gpio4_dbck: gpio4_dbck {
+	gpio4_dbck: gpio4_dbck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&per_32k_alwon_fck>;
@@ -1308,7 +1308,7 @@
 		ti,bit-shift = <15>;
 	};
 
-	gpio3_dbck: gpio3_dbck {
+	gpio3_dbck: gpio3_dbck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&per_32k_alwon_fck>;
@@ -1316,7 +1316,7 @@
 		ti,bit-shift = <14>;
 	};
 
-	gpio2_dbck: gpio2_dbck {
+	gpio2_dbck: gpio2_dbck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,gate-clock";
 		clocks = <&per_32k_alwon_fck>;
@@ -1324,7 +1324,7 @@
 		ti,bit-shift = <13>;
 	};
 
-	wdt3_fck: wdt3_fck {
+	wdt3_fck: wdt3_fck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,wait-gate-clock";
 		clocks = <&per_32k_alwon_fck>;
@@ -1340,7 +1340,7 @@
 		clock-div = <1>;
 	};
 
-	gpio6_ick: gpio6_ick {
+	gpio6_ick: gpio6_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1348,7 +1348,7 @@
 		ti,bit-shift = <17>;
 	};
 
-	gpio5_ick: gpio5_ick {
+	gpio5_ick: gpio5_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1356,7 +1356,7 @@
 		ti,bit-shift = <16>;
 	};
 
-	gpio4_ick: gpio4_ick {
+	gpio4_ick: gpio4_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1364,7 +1364,7 @@
 		ti,bit-shift = <15>;
 	};
 
-	gpio3_ick: gpio3_ick {
+	gpio3_ick: gpio3_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1372,7 +1372,7 @@
 		ti,bit-shift = <14>;
 	};
 
-	gpio2_ick: gpio2_ick {
+	gpio2_ick: gpio2_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1380,7 +1380,7 @@
 		ti,bit-shift = <13>;
 	};
 
-	wdt3_ick: wdt3_ick {
+	wdt3_ick: wdt3_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1388,7 +1388,7 @@
 		ti,bit-shift = <12>;
 	};
 
-	uart3_ick: uart3_ick {
+	uart3_ick: uart3_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1396,7 +1396,7 @@
 		ti,bit-shift = <11>;
 	};
 
-	uart4_ick: uart4_ick {
+	uart4_ick: uart4_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1404,7 +1404,7 @@
 		ti,bit-shift = <18>;
 	};
 
-	gpt9_ick: gpt9_ick {
+	gpt9_ick: gpt9_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1412,7 +1412,7 @@
 		ti,bit-shift = <10>;
 	};
 
-	gpt8_ick: gpt8_ick {
+	gpt8_ick: gpt8_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1420,7 +1420,7 @@
 		ti,bit-shift = <9>;
 	};
 
-	gpt7_ick: gpt7_ick {
+	gpt7_ick: gpt7_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1428,7 +1428,7 @@
 		ti,bit-shift = <8>;
 	};
 
-	gpt6_ick: gpt6_ick {
+	gpt6_ick: gpt6_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1436,7 +1436,7 @@
 		ti,bit-shift = <7>;
 	};
 
-	gpt5_ick: gpt5_ick {
+	gpt5_ick: gpt5_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1444,7 +1444,7 @@
 		ti,bit-shift = <6>;
 	};
 
-	gpt4_ick: gpt4_ick {
+	gpt4_ick: gpt4_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1452,7 +1452,7 @@
 		ti,bit-shift = <5>;
 	};
 
-	gpt3_ick: gpt3_ick {
+	gpt3_ick: gpt3_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1460,7 +1460,7 @@
 		ti,bit-shift = <4>;
 	};
 
-	gpt2_ick: gpt2_ick {
+	gpt2_ick: gpt2_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1468,7 +1468,7 @@
 		ti,bit-shift = <3>;
 	};
 
-	mcbsp2_ick: mcbsp2_ick {
+	mcbsp2_ick: mcbsp2_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1476,7 +1476,7 @@
 		ti,bit-shift = <0>;
 	};
 
-	mcbsp3_ick: mcbsp3_ick {
+	mcbsp3_ick: mcbsp3_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1484,7 +1484,7 @@
 		ti,bit-shift = <1>;
 	};
 
-	mcbsp4_ick: mcbsp4_ick {
+	mcbsp4_ick: mcbsp4_ick@1010 {
 		#clock-cells = <0>;
 		compatible = "ti,omap3-interface-clock";
 		clocks = <&per_l4_ick>;
@@ -1492,7 +1492,7 @@
 		ti,bit-shift = <2>;
 	};
 
-	mcbsp2_gate_fck: mcbsp2_gate_fck {
+	mcbsp2_gate_fck: mcbsp2_gate_fck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&mcbsp_clks>;
@@ -1500,7 +1500,7 @@
 		reg = <0x1000>;
 	};
 
-	mcbsp3_gate_fck: mcbsp3_gate_fck {
+	mcbsp3_gate_fck: mcbsp3_gate_fck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&mcbsp_clks>;
@@ -1508,7 +1508,7 @@
 		reg = <0x1000>;
 	};
 
-	mcbsp4_gate_fck: mcbsp4_gate_fck {
+	mcbsp4_gate_fck: mcbsp4_gate_fck@1000 {
 		#clock-cells = <0>;
 		compatible = "ti,composite-gate-clock";
 		clocks = <&mcbsp_clks>;
@@ -1516,7 +1516,7 @@
 		reg = <0x1000>;
 	};
 
-	emu_src_mux_ck: emu_src_mux_ck {
+	emu_src_mux_ck: emu_src_mux_ck@1140 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_ck>, <&emu_core_alwon_ck>, <&emu_per_alwon_ck>, <&emu_mpu_alwon_ck>;
@@ -1529,7 +1529,7 @@
 		clocks = <&emu_src_mux_ck>;
 	};
 
-	pclk_fck: pclk_fck {
+	pclk_fck: pclk_fck@1140 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&emu_src_ck>;
@@ -1539,7 +1539,7 @@
 		ti,index-starts-at-one;
 	};
 
-	pclkx2_fck: pclkx2_fck {
+	pclkx2_fck: pclkx2_fck@1140 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&emu_src_ck>;
@@ -1549,7 +1549,7 @@
 		ti,index-starts-at-one;
 	};
 
-	atclk_fck: atclk_fck {
+	atclk_fck: atclk_fck@1140 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&emu_src_ck>;
@@ -1559,7 +1559,7 @@
 		ti,index-starts-at-one;
 	};
 
-	traceclk_src_fck: traceclk_src_fck {
+	traceclk_src_fck: traceclk_src_fck@1140 {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
 		clocks = <&sys_ck>, <&emu_core_alwon_ck>, <&emu_per_alwon_ck>, <&emu_mpu_alwon_ck>;
@@ -1567,7 +1567,7 @@
 		reg = <0x1140>;
 	};
 
-	traceclk_fck: traceclk_fck {
+	traceclk_fck: traceclk_fck@1140 {
 		#clock-cells = <0>;
 		compatible = "ti,divider-clock";
 		clocks = <&traceclk_src_fck>;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
