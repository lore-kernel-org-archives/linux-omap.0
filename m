From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 6/7] arm: boot: dts: am4372: add sysconfig data to all HWMODs
Date: Tue, 9 Dec 2014 16:27:51 -0600
Message-ID: <1418164072-19087-7-git-send-email-balbi@ti.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47206 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753568AbaLIW2g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Dec 2014 17:28:36 -0500
In-Reply-To: <1418164072-19087-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>

This patch adds all new sysconfig DT properties
so they can later be removed from hwmod*data.c files

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Note here, there's still an idea of converting the flags to use
macros which would get preprocessed away, I'm yet to do that.

 arch/arm/boot/dts/am4372.dtsi | 251 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index b62a1cd..5a14405 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -126,6 +126,11 @@
 			reg = <0x44e09000 0x2000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart1";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x27>;
+			ti,syss_offs = <0x58>;
+			ti,sysc_offs = <0x54>;
+			ti,rev_offs = <0x50>;
 		};
 
 		uart1: serial@48022000 {
@@ -133,6 +138,11 @@
 			reg = <0x48022000 0x2000>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart2";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x27>;
+			ti,syss_offs = <0x58>;
+			ti,sysc_offs = <0x54>;
+			ti,rev_offs = <0x50>;
 			status = "disabled";
 		};
 
@@ -141,6 +151,11 @@
 			reg = <0x48024000 0x2000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart3";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x27>;
+			ti,syss_offs = <0x58>;
+			ti,sysc_offs = <0x54>;
+			ti,rev_offs = <0x50>;
 			status = "disabled";
 		};
 
@@ -149,6 +164,11 @@
 			reg = <0x481a6000 0x2000>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart4";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x27>;
+			ti,syss_offs = <0x58>;
+			ti,sysc_offs = <0x54>;
+			ti,rev_offs = <0x50>;
 			status = "disabled";
 		};
 
@@ -157,6 +177,11 @@
 			reg = <0x481a8000 0x2000>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart5";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x27>;
+			ti,syss_offs = <0x58>;
+			ti,sysc_offs = <0x54>;
+			ti,rev_offs = <0x50>;
 			status = "disabled";
 		};
 
@@ -165,6 +190,11 @@
 			reg = <0x481aa000 0x2000>;
 			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart6";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x27>;
+			ti,syss_offs = <0x58>;
+			ti,sysc_offs = <0x54>;
+			ti,rev_offs = <0x50>;
 			status = "disabled";
 		};
 
@@ -173,6 +203,10 @@
 			reg = <0x480C8000 0x200>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0x222>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <8>;
@@ -188,6 +222,11 @@
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-alwon;
 			ti,hwmods = "timer1";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0xb3>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 		};
 
 		timer2: timer@48040000  {
@@ -195,6 +234,11 @@
 			reg = <0x48040000  0x400>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer2";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x22>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 		};
 
 		timer3: timer@48042000 {
@@ -202,7 +246,12 @@
 			reg = <0x48042000 0x400>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer3";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x22>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
 			status = "disabled";
+			ti,sysc_type = <2>;
 		};
 
 		timer4: timer@48044000 {
@@ -211,6 +260,11 @@
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-pwm;
 			ti,hwmods = "timer4";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x22>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 			status = "disabled";
 		};
 
@@ -220,6 +274,11 @@
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-pwm;
 			ti,hwmods = "timer5";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x22>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 			status = "disabled";
 		};
 
@@ -229,6 +288,11 @@
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-pwm;
 			ti,hwmods = "timer6";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x22>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 			status = "disabled";
 		};
 
@@ -238,6 +302,11 @@
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			ti,timer-pwm;
 			ti,hwmods = "timer7";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x22>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 			status = "disabled";
 		};
 
@@ -246,6 +315,11 @@
 			reg = <0x481c1000 0x400>;
 			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer8";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x22>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 			status = "disabled";
 		};
 
@@ -254,6 +328,11 @@
 			reg = <0x4833d000 0x400>;
 			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer9";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x22>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 			status = "disabled";
 		};
 
@@ -262,6 +341,11 @@
 			reg = <0x4833f000 0x400>;
 			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer10";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x22>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 			status = "disabled";
 		};
 
@@ -270,6 +354,11 @@
 			reg = <0x48341000 0x400>;
 			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer11";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x22>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 			status = "disabled";
 		};
 
@@ -277,6 +366,9 @@
 			compatible = "ti,am4372-counter32k","ti,omap-counter32k";
 			reg = <0x44e86000 0x40>;
 			ti,hwmods = "counter_32k";
+			ti,idlemodes = <0x3>;
+			ti,sysc_flags = <0x20>;
+			ti,sysc_offs = <0x4>;
 		};
 
 		rtc: rtc@44e3e000 {
@@ -285,6 +377,11 @@
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
 				      GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "rtc";
+			ti,rev_offs = <0x74>;
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x20>;
+			ti,sysc_offs = <0x78>;
+			ti,sysc_type = <3>;
 			status = "disabled";
 		};
 
@@ -293,6 +390,10 @@
 			reg = <0x44e35000 0x1000>;
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "wd_timer2";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0xaa>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
 		};
 
 		gpio0: gpio@44e07000 {
@@ -304,6 +405,10 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			ti,hwmods = "gpio1";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0xa7>;
+			ti,syss_offs = <0x114>;
+			ti,sysc_offs = <0x10>;
 			status = "disabled";
 		};
 
@@ -316,6 +421,10 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			ti,hwmods = "gpio2";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0xa7>;
+			ti,syss_offs = <0x114>;
+			ti,sysc_offs = <0x10>;
 			status = "disabled";
 		};
 
@@ -328,6 +437,10 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			ti,hwmods = "gpio3";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0xa7>;
+			ti,syss_offs = <0x114>;
+			ti,sysc_offs = <0x10>;
 			status = "disabled";
 		};
 
@@ -340,6 +453,10 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			ti,hwmods = "gpio4";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0xa7>;
+			ti,syss_offs = <0x114>;
+			ti,sysc_offs = <0x10>;
 			status = "disabled";
 		};
 
@@ -352,6 +469,10 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			ti,hwmods = "gpio5";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0xa7>;
+			ti,syss_offs = <0x114>;
+			ti,sysc_offs = <0x10>;
 			status = "disabled";
 		};
 
@@ -364,6 +485,10 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			ti,hwmods = "gpio6";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0xa7>;
+			ti,syss_offs = <0x114>;
+			ti,sysc_offs = <0x10>;
 			status = "disabled";
 		};
 
@@ -371,6 +496,10 @@
 			compatible = "ti,omap4-hwspinlock";
 			reg = <0x480ca000 0x1000>;
 			ti,hwmods = "spinlock";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0xb7>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
 			#hwlock-cells = <1>;
 		};
 
@@ -379,6 +508,10 @@
 			reg = <0x44e0b000 0x1000>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "i2c1";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0xb7>;
+			ti,syss_offs = <0x90>;
+			ti,sysc_offs = <0x10>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -389,6 +522,10 @@
 			reg = <0x4802a000 0x1000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "i2c2";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0xb7>;
+			ti,syss_offs = <0x90>;
+			ti,sysc_offs = <0x10>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -399,6 +536,10 @@
 			reg = <0x4819c000 0x1000>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "i2c3";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0xb7>;
+			ti,syss_offs = <0x90>;
+			ti,sysc_offs = <0x10>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -409,6 +550,10 @@
 			reg = <0x48030000 0x400>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "spi0";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0xb3>;
+			ti,syss_offs = <0x114>;
+			ti,sysc_offs = <0x110>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -418,6 +563,11 @@
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x48060000 0x1000>;
 			ti,hwmods = "mmc1";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0xb7>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
+			ti,rev_offs = <0x1fc>;
 			ti,dual-volt;
 			ti,needs-special-reset;
 			dmas = <&edma 24
@@ -431,6 +581,11 @@
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x481d8000 0x1000>;
 			ti,hwmods = "mmc2";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0xb7>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
+			ti,rev_offs = <0x1fc>;
 			ti,needs-special-reset;
 			dmas = <&edma 2
 				&edma 3>;
@@ -443,6 +598,11 @@
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x47810000 0x1000>;
 			ti,hwmods = "mmc3";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0xb7>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
+			ti,rev_offs = <0x1fc>;
 			ti,needs-special-reset;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -453,6 +613,10 @@
 			reg = <0x481a0000 0x400>;
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "spi1";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0xb3>;
+			ti,syss_offs = <0x114>;
+			ti,sysc_offs = <0x110>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -463,6 +627,10 @@
 			reg = <0x481a2000 0x400>;
 			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "spi2";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0xb3>;
+			ti,syss_offs = <0x114>;
+			ti,sysc_offs = <0x110>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -473,6 +641,10 @@
 			reg = <0x481a4000 0x400>;
 			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "spi3";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0xb3>;
+			ti,syss_offs = <0x114>;
+			ti,sysc_offs = <0x110>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -483,6 +655,10 @@
 			reg = <0x48345000 0x400>;
 			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "spi4";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0xb3>;
+			ti,syss_offs = <0x114>;
+			ti,sysc_offs = <0x110>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -499,6 +675,11 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ti,hwmods = "cpgmac0";
+			ti,idlemodes = <0x33>;
+			ti,sysc_flags = <0xe0>;
+			ti,syss_offs = <0x4>;
+			ti,sysc_offs = <0x8>;
+			ti,sysc_type = <3>;
 			clocks = <&cpsw_125mhz_gclk>, <&cpsw_cpts_rft_clk>;
 			clock-names = "fck", "cpts";
 			status = "disabled";
@@ -548,6 +729,10 @@
 			#size-cells = <1>;
 			ranges;
 			ti,hwmods = "epwmss0";
+			ti,idlemodes = <0xff>;
+			ti,sysc_flags = <0x60>;
+			ti,sysc_offs = <0x4>;
+			ti,sysc_type = <2>;
 			status = "disabled";
 
 			ecap0: ecap@48300100 {
@@ -574,6 +759,9 @@
 			#size-cells = <1>;
 			ranges;
 			ti,hwmods = "epwmss1";
+			ti,idlemodes = <0xff>;
+			ti,sysc_flags = <0x60>;
+			ti,sysc_offs = <0x4>;
 			status = "disabled";
 
 			ecap1: ecap@48302100 {
@@ -600,6 +788,9 @@
 			#size-cells = <1>;
 			ranges;
 			ti,hwmods = "epwmss2";
+			ti,idlemodes = <0xff>;
+			ti,sysc_flags = <0x60>;
+			ti,sysc_offs = <0x4>;
 			status = "disabled";
 
 			ecap2: ecap@48304100 {
@@ -626,6 +817,9 @@
 			#size-cells = <1>;
 			ranges;
 			ti,hwmods = "epwmss3";
+			ti,idlemodes = <0xff>;
+			ti,sysc_flags = <0x60>;
+			ti,sysc_offs = <0x4>;
 			status = "disabled";
 
 			ehrpwm3: ehrpwm@48306200 {
@@ -644,6 +838,9 @@
 			#size-cells = <1>;
 			ranges;
 			ti,hwmods = "epwmss4";
+			ti,idlemodes = <0xff>;
+			ti,sysc_flags = <0x60>;
+			ti,sysc_offs = <0x4>;
 			status = "disabled";
 
 			ehrpwm4: ehrpwm@48308200 {
@@ -662,6 +859,9 @@
 			#size-cells = <1>;
 			ranges;
 			ti,hwmods = "epwmss5";
+			ti,idlemodes = <0xff>;
+			ti,sysc_flags = <0x60>;
+			ti,sysc_offs = <0x4>;
 			status = "disabled";
 
 			ehrpwm5: ehrpwm@4830a200 {
@@ -677,6 +877,10 @@
 			compatible = "ti,am3359-tscadc";
 			reg = <0x44e0d000 0x1000>;
 			ti,hwmods = "adc_tsc";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x20>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&adc_tsc_fck>;
 			clock-names = "fck";
@@ -696,6 +900,10 @@
 		sham: sham@53100000 {
 			compatible = "ti,omap5-sham";
 			ti,hwmods = "sham";
+			ti,sysc_flags = <0x80>;
+			ti,syss_offs = <0x114>;
+			ti,sysc_offs = <0x110>;
+			ti,rev_offs = <0x100>;
 			reg = <0x53100000 0x300>;
 			dmas = <&edma 36>;
 			dma-names = "rx";
@@ -705,6 +913,10 @@
 		aes: aes@53501000 {
 			compatible = "ti,omap4-aes";
 			ti,hwmods = "aes";
+			ti,sysc_flags = <0x80>;
+			ti,syss_offs = <0x88>;
+			ti,sysc_offs = <0x84>;
+			ti,rev_offs = <0x80>;
 			reg = <0x53501000 0xa0>;
 			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&edma 6
@@ -725,6 +937,10 @@
 		mcasp0: mcasp@48038000 {
 			compatible = "ti,am33xx-mcasp-audio";
 			ti,hwmods = "mcasp0";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0x20>;
+			ti,sysc_offs = <0x4>;
+			ti,sysc_type = <3>;
 			reg = <0x48038000 0x2000>,
 			      <0x46000000 0x400000>;
 			reg-names = "mpu", "dat";
@@ -739,6 +955,10 @@
 		mcasp1: mcasp@4803C000 {
 			compatible = "ti,am33xx-mcasp-audio";
 			ti,hwmods = "mcasp1";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0x20>;
+			ti,sysc_offs = <0x4>;
+			ti,sysc_type = <3>;
 			reg = <0x4803C000 0x2000>,
 			      <0x46400000 0x400000>;
 			reg-names = "mpu", "dat";
@@ -755,6 +975,10 @@
 			reg = <0x48080000 0x2000>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "elm";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0xb3>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
 			clocks = <&l4ls_gclk>;
 			clock-names = "fck";
 			status = "disabled";
@@ -763,6 +987,10 @@
 		gpmc: gpmc@50000000 {
 			compatible = "ti,am3352-gpmc";
 			ti,hwmods = "gpmc";
+			ti,idlemodes = <0x7>;
+			ti,sysc_flags = <0xa3>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
 			clocks = <&l3s_gclk>;
 			clock-names = "fck";
 			reg = <0x50000000 0x2000>;
@@ -827,6 +1055,10 @@
 		dwc3_1: omap_dwc3@48380000 {
 			compatible = "ti,am437x-dwc3";
 			ti,hwmods = "usb_otg_ss0";
+			ti,idlemodes = <0xff>;
+			ti,sysc_flags = <0x460>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 			reg = <0x48380000 0x10000>;
 			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
@@ -851,6 +1083,10 @@
 		dwc3_2: omap_dwc3@483c0000 {
 			compatible = "ti,am437x-dwc3";
 			ti,hwmods = "usb_otg_ss1";
+			ti,idlemodes = <0xff>;
+			ti,sysc_flags = <0x460>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 			reg = <0x483c0000 0x10000>;
 			interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
@@ -878,6 +1114,10 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "qspi";
+			ti,idlemodes = <0xf>;
+			ti,sysc_flags = <0x20>;
+			ti,sysc_offs = <0x10>;
+			ti,sysc_type = <2>;
 			interrupts = <0 138 0x4>;
 			num-cs = <4>;
 			status = "disabled";
@@ -898,6 +1138,9 @@
 			reg = <0x4832a000 0x200>;
 			status = "disabled";
 			ti,hwmods = "dss_core";
+			ti,sysc_flags = <0x83>;
+			ti,syss_offs = <0x14>;
+			ti,sysc_offs = <0x10>;
 			clocks = <&disp_clk>;
 			clock-names = "fck";
 			#address-cells = <1>;
@@ -909,6 +1152,10 @@
 				reg = <0x4832a400 0x400>;
 				interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 				ti,hwmods = "dss_dispc";
+				ti,idlemodes = <0x77>;
+				ti,sysc_flags = <0x77>;
+				ti,syss_offs = <0x14>;
+				ti,sysc_offs = <0x10>;
 				clocks = <&disp_clk>;
 				clock-names = "fck";
 			};
@@ -917,6 +1164,10 @@
 				compatible = "ti,omap3-rfbi";
 				reg = <0x4832a800 0x100>;
 				ti,hwmods = "dss_rfbi";
+				ti,idlemodes = <0x7>;
+				ti,sysc_flags = <0x23>;
+				ti,syss_offs = <0x14>;
+				ti,sysc_offs = <0x10>;
 				clocks = <&disp_clk>;
 				clock-names = "fck";
 			};
-- 
2.2.0

