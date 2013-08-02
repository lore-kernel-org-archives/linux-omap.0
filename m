From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 28/31] ARM: dts: AM35xx clock data
Date: Fri, 2 Aug 2013 19:25:47 +0300
Message-ID: <1375460751-23676-29-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50399 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924Ab3HBQ1k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 12:27:40 -0400
In-Reply-To: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch creates a unique node for each AM35xx specific clock in the
AM35xx power, reset and clock manager (PRCM). Most of the AM35xx clock
data is shared with OMAP3xxx, this patch only creates the delta.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am35xx-clocks.dtsi |  113 ++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 arch/arm/boot/dts/am35xx-clocks.dtsi

diff --git a/arch/arm/boot/dts/am35xx-clocks.dtsi b/arch/arm/boot/dts/am35xx-clocks.dtsi
new file mode 100644
index 0000000..d28aa5c
--- /dev/null
+++ b/arch/arm/boot/dts/am35xx-clocks.dtsi
@@ -0,0 +1,113 @@
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
+	compatible = "ti,interface-clock";
+	clocks = <&core_l3_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l3_clkdm";
+	ti,enable-bit = <4>;
+	ti,am35xx-clk;
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
+	compatible = "ti,gate-clock";
+	clocks = <&ipss_ick>;
+	reg = <0x4800259c 0x4>;
+	ti,clkdm-name = "core_l3_clkdm";
+	ti,enable-bit = <1>;
+	ti,am35xx-clk;
+};
+
+emac_fck: emac_fck@4800259c {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&rmii_ck>;
+	reg = <0x4800259c 0x4>;
+	bit-shift = <9>;
+};
+
+vpfe_ick: vpfe_ick@4800259c {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&ipss_ick>;
+	reg = <0x4800259c 0x4>;
+	ti,clkdm-name = "core_l3_clkdm";
+	ti,enable-bit = <2>;
+	ti,am35xx-clk;
+};
+
+vpfe_fck: vpfe_fck@4800259c {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&pclk_ck>;
+	reg = <0x4800259c 0x4>;
+	bit-shift = <10>;
+};
+
+hsotgusb_ick_am35xx: hsotgusb_ick_am35xx@4800259c {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&ipss_ick>;
+	reg = <0x4800259c 0x4>;
+	ti,clkdm-name = "core_l3_clkdm";
+	ti,enable-bit = <0>;
+	ti,am35xx-clk;
+};
+
+hsotgusb_fck_am35xx: hsotgusb_fck_am35xx@4800259c {
+	#clock-cells = <0>;
+	compatible = "gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x4800259c 0x4>;
+	bit-shift = <8>;
+};
+
+hecc_ck: hecc_ck@4800259c {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&sys_ck>;
+	reg = <0x4800259c 0x4>;
+	ti,clkdm-name = "core_l3_clkdm";
+	ti,enable-bit = <3>;
+	ti,am35xx-clk;
+};
+
+uart4_ick_am35xx: uart4_ick_am35xx@48004a10 {
+	#clock-cells = <0>;
+	compatible = "ti,interface-clock";
+	clocks = <&core_l4_ick>;
+	reg = <0x48004a10 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <23>;
+};
+
+uart4_fck_am35xx: uart4_fck_am35xx@48004a00 {
+	#clock-cells = <0>;
+	compatible = "ti,gate-clock";
+	clocks = <&core_48m_fck>;
+	reg = <0x48004a00 0x4>;
+	ti,clkdm-name = "core_l4_clkdm";
+	ti,enable-bit = <23>;
+};
-- 
1.7.9.5

