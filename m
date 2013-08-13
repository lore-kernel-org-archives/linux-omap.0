From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 8/8] ARM: DRA7: dts: Add the dts files for dra7 SoC
 and dra7-evm board
Date: Tue, 13 Aug 2013 12:54:31 +0530
Message-ID: <5209DF2F.5040409@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com> <1375183546-12758-9-git-send-email-rnayak@ti.com> <20130812114402.GB6616@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45484 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754752Ab3HMHZO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Aug 2013 03:25:14 -0400
In-Reply-To: <20130812114402.GB6616@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@linaro.org" <khilman@linaro.org>, "tony@atomide.com" <tony@atomide.com>, "benoit.cousson@gmail.com" <benoit.cousson@gmail.com>, "r.sricharan@ti.com" <r.sricharan@ti.com>, "ambresh@ti.com" <ambresh@ti.com>, "sourav.poddar@ti.com" <sourav.poddar@ti.com>

[]..

>> +
>> +       cpus {
>> +               cpu@0 {
>> +                       compatible = "arm,cortex-a15";
>> +                       timer {
>> +                               compatible = "arm,armv7-timer";
>> +                               /*
>> +                                * PPI secure/nonsecure IRQ,
>> +                                * active low level-sensitive
>> +                                */
>> +                               interrupts = <1 13 0x308>,
>> +                                            <1 14 0x308>;
>> +                               clock-frequency = <6144000>;
>> +                       };
>> +               };
> 
> The cpu nodes should have a reg matching their unit-address, and a
> device_type = "cpu".
> 
> The timer nodes should *not* be under the CPU nodes. They should be
> under under the root node. I realise that it makes intuitive sense to
> describe per-cpu resources this way, but that's not the way the bindings
> are intended to be used (does thei DT even work?).
> 
> No virtual/hypervisor interrupts?

Mark, all valid points. I just updated the patch to include all the missing
interrupts and registers for timer and gic and moved the timer node out as
its supposed to be.

> 
> Do you really need the clock-frequency property? It's far preferrable to
> have your bootloader do the right thing and program CNTFRQ with the
> correct value.

I kept the clock-frequency property since our bootloader does not handle this
and I am not sure if its a good idea to have the dependency on bootloader
to do this.

Updated patch:
----
>From 4d2e7cfe8a44448a37686a4af26f320ab0d66acb Mon Sep 17 00:00:00 2001
From: R Sricharan <r.sricharan@ti.com>
Date: Thu, 7 Feb 2013 16:14:00 +0530
Subject: [PATCH] ARM: DRA7: dts: Add the dts files for dra7 SoC and dra7-evm
 board

Add minimal device tree source needed for DRA7 based SoCs.
Also add a board dts file for the dra7-evm (based on dra752)
which contains 1.5G of memory with 1G interleaved and 512MB
non-interleaved. Also added in the board file are pin configuration
details for i2c, mcspi and uart devices on board.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/Makefile     |    3 +-
 arch/arm/boot/dts/dra7-evm.dts |  140 ++++++++++
 arch/arm/boot/dts/dra7.dtsi    |  568 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 710 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/dra7-evm.dts
 create mode 100644 arch/arm/boot/dts/dra7.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 641b3c9..e2f8566 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -173,7 +173,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	am335x-bone.dtb \
 	am3517-evm.dtb \
 	am3517_mt_ventoux.dtb \
-	am43x-epos-evm.dtb
+	am43x-epos-evm.dtb \
+	dra7-evm.dtb
 dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
new file mode 100644
index 0000000..21fe16b
--- /dev/null
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -0,0 +1,140 @@
+/*
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "dra7.dtsi"
+
+/ {
+	model = "TI DRA7";
+	compatible = "ti,dra7-evm", "ti,dra752", "ti,dra7";
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x60000000>; /* 1536 MB */
+	};
+};
+
+&dra7_pmx_core {
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			0x400 0x60000	/* i2c1_sda */
+			0x404 0x60000	/* i2c1_scl */
+		>;
+	};
+
+	i2c2_pins: pinmux_i2c2_pins {
+		pinctrl-single,pins = <
+			0x408 0x60000	/* i2c2_sda */
+			0x40c 0x60000	/* i2c2_scl */
+		>;
+	};
+
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			0x410 0x60000	/* i2c3_sda */
+			0x414 0x60000	/* i2c3_scl */
+		>;
+	};
+
+	mcspi1_pins: pinmux_mcspi1_pins {
+		pinctrl-single,pins = <
+			0x3a4 0x40000	/* spi2_clk */
+			0x3a8 0x40000	/* spi2_d1 */
+			0x3ac 0x40000	/* spi2_d0 */
+			0x3b0 0xc0000	/* spi2_cs0 */
+			0x3b4 0xc0000	/* spi2_cs1 */
+			0x3b8 0xe0006	/* spi2_cs2 */
+			0x3bc 0xe0006	/* spi2_cs3 */
+		>;
+	};
+
+	mcspi2_pins: pinmux_mcspi2_pins {
+		pinctrl-single,pins = <
+			0x3c0 0x40000	/* spi2_sclk */
+			0x3c4 0xc0000	/* spi2_d1 */
+			0x3c8 0xc0000	/* spi2_d1 */
+			0x3cc 0xe0000	/* spi2_cs0 */
+		>;
+	};
+
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			0x3e0 0xe0000	/* uart1_rxd */
+			0x3e4 0xe0000	/* uart1_txd */
+			0x3e8 0x60003	/* uart1_ctsn */
+			0x3ec 0x60003	/* uart1_rtsn */
+		>;
+	};
+
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			0x3f0 0x60000 /* uart2_rxd */
+			0x3f4 0x60000 /* uart2_txd */
+			0x3f8 0x60000 /* uart2_ctsn */
+			0x3fc 0x60000 /* uart2_rtsn */
+		>;
+	};
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			0x248 0xc0000 /* uart3_rxd */
+			0x24c 0xc0000 /* uart3_txd */
+		>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	clock-frequency = <400000>;
+};
+
+&i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	clock-frequency = <400000>;
+};
+
+&i2c3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	clock-frequency = <3400000>;
+};
+
+&mcspi1 {
+        status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi1_pins>;
+};
+
+&mcspi2 {
+        status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcspi2_pins>;
+};
+
+&uart1 {
+	status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&uart1_pins>;
+};
+
+&uart2 {
+        status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&uart2_pins>;
+};
+
+&uart3 {
+        status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&uart3_pins>;
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
new file mode 100644
index 0000000..3b154a0
--- /dev/null
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -0,0 +1,568 @@
+/*
+ * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ * Based on "omap4.dtsi"
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#include "skeleton.dtsi"
+
+/ {
+	compatible = "ti,dra7xx";
+	interrupt-parent = <&gic>;
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		serial5 = &uart6;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0>;
+		};
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		/* PPI secure/nonsecure IRQ */
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(3) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <6144000>;
+	};
+
+	gic: interrupt-controller@48211000 {
+		compatible = "arm,cortex-a15-gic";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		reg = <0x48211000 0x1000>,
+		      <0x48212000 0x1000>,
+		      <0x48214000 0x2000>,
+		      <0x48216000 0x2000>;
+	};
+
+	/*
+	 * The soc node represents the soc top level view. It is uses for IPs
+	 * that are not memory mapped in the MPU view or for the MPU itself.
+	 */
+	soc {
+		compatible = "ti,omap-infra";
+		mpu {
+			compatible = "ti,omap5-mpu";
+			ti,hwmods = "mpu";
+		};
+	};
+
+	/*
+	 * XXX: Use a flat representation of the SOC interconnect.
+	 * The real OMAP interconnect network is quite complex.
+	 * Since that will not bring real advantage to represent that in DT for
+	 * the moment, just use a fake OCP bus entry to represent the whole bus
+	 * hierarchy.
+	 */
+	ocp {
+		compatible = "ti,omap4-l3-noc", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		ti,hwmods = "l3_main_1", "l3_main_2";
+
+		counter32k: counter@4ae04000 {
+			compatible = "ti,omap-counter32k";
+			reg = <0x4ae04000 0x40>;
+			ti,hwmods = "counter_32k";
+		};
+
+		dra7_pmx_core: pinmux@4a003400 {
+			compatible = "pinctrl-single";
+			reg = <0x4a003400 0x0464>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-single,register-width = <32>;
+			pinctrl-single,function-mask = <0x3fffffff>;
+		};
+
+		sdma: dma-controller@4a056000 {
+			compatible = "ti,omap4430-sdma";
+			reg = <0x4a056000 0x1000>;
+			interrupts = <0 12 0x4>,
+				     <0 13 0x4>,
+				     <0 14 0x4>,
+				     <0 15 0x4>;
+			#dma-cells = <1>;
+			#dma-channels = <32>;
+			#dma-requests = <127>;
+		};
+
+		gpio1: gpio@4ae10000 {
+			compatible = "ti,omap4-gpio";
+			reg = <0x4ae10000 0x200>;
+			interrupts = <0 29 0x4>;
+			ti,hwmods = "gpio1";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio2: gpio@48055000 {
+			compatible = "ti,omap4-gpio";
+			reg = <0x48055000 0x200>;
+			interrupts = <0 30 0x4>;
+			ti,hwmods = "gpio2";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio3: gpio@48057000 {
+			compatible = "ti,omap4-gpio";
+			reg = <0x48057000 0x200>;
+			interrupts = <0 31 0x4>;
+			ti,hwmods = "gpio3";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio4: gpio@48059000 {
+			compatible = "ti,omap4-gpio";
+			reg = <0x48059000 0x200>;
+			interrupts = <0 32 0x4>;
+			ti,hwmods = "gpio4";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio5: gpio@4805b000 {
+			compatible = "ti,omap4-gpio";
+			reg = <0x4805b000 0x200>;
+			interrupts = <0 33 0x4>;
+			ti,hwmods = "gpio5";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio6: gpio@4805d000 {
+			compatible = "ti,omap4-gpio";
+			reg = <0x4805d000 0x200>;
+			interrupts = <0 34 0x4>;
+			ti,hwmods = "gpio6";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio7: gpio@48051000 {
+			compatible = "ti,omap4-gpio";
+			reg = <0x48051000 0x200>;
+			interrupts = <0 35 0x4>;
+			ti,hwmods = "gpio7";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio8: gpio@48053000 {
+			compatible = "ti,omap4-gpio";
+			reg = <0x48053000 0x200>;
+			interrupts = <0 121 0x4>;
+			ti,hwmods = "gpio8";
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		uart1: serial@4806a000 {
+			compatible = "ti,omap4-uart";
+			reg = <0x4806a000 0x100>;
+			interrupts = <0 72 0x4>;
+			ti,hwmods = "uart1";
+			clock-frequency = <48000000>;
+			status = "disabled";
+		};
+
+		uart2: serial@4806c000 {
+			compatible = "ti,omap4-uart";
+			reg = <0x4806c000 0x100>;
+			interrupts = <0 73 0x4>;
+			ti,hwmods = "uart2";
+			clock-frequency = <48000000>;
+			status = "disabled";
+		};
+
+		uart3: serial@48020000 {
+			compatible = "ti,omap4-uart";
+			reg = <0x48020000 0x100>;
+			interrupts = <0 74 0x4>;
+			ti,hwmods = "uart3";
+			clock-frequency = <48000000>;
+			status = "disabled";
+		};
+
+		uart4: serial@4806e000 {
+			compatible = "ti,omap4-uart";
+			reg = <0x4806e000 0x100>;
+			interrupts = <0 70 0x4>;
+			ti,hwmods = "uart4";
+			clock-frequency = <48000000>;
+                        status = "disabled";
+		};
+
+		uart5: serial@48066000 {
+			compatible = "ti,omap4-uart";
+			reg = <0x48066000 0x100>;
+			interrupts = <0 105 0x4>;
+			ti,hwmods = "uart5";
+			clock-frequency = <48000000>;
+			status = "disabled";
+		};
+
+		uart6: serial@48068000 {
+			compatible = "ti,omap4-uart";
+			reg = <0x48068000 0x100>;
+			interrupts = <0 106 0x4>;
+			ti,hwmods = "uart6";
+			clock-frequency = <48000000>;
+			status = "disabled";
+		};
+
+		uart7: serial@48420000 {
+			compatible = "ti,omap4-uart";
+			reg = <0x48420000 0x100>;
+			ti,hwmods = "uart7";
+			clock-frequency = <48000000>;
+			status = "disabled";
+		};
+
+		uart8: serial@48422000 {
+			compatible = "ti,omap4-uart";
+			reg = <0x48422000 0x100>;
+			ti,hwmods = "uart8";
+			clock-frequency = <48000000>;
+			status = "disabled";
+		};
+
+		uart9: serial@48424000 {
+			compatible = "ti,omap4-uart";
+			reg = <0x48424000 0x100>;
+			ti,hwmods = "uart9";
+			clock-frequency = <48000000>;
+			status = "disabled";
+		};
+
+		uart10: serial@4ae2b000 {
+			compatible = "ti,omap4-uart";
+			reg = <0x4ae2b000 0x100>;
+			ti,hwmods = "uart10";
+			clock-frequency = <48000000>;
+			status = "disabled";
+		};
+
+		timer1: timer@4ae18000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x4ae18000 0x80>;
+			interrupts = <0 37 0x4>;
+			ti,hwmods = "timer1";
+			ti,timer-alwon;
+		};
+
+		timer2: timer@48032000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x48032000 0x80>;
+			interrupts = <0 38 0x4>;
+			ti,hwmods = "timer2";
+		};
+
+		timer3: timer@48034000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x48034000 0x80>;
+			interrupts = <0 39 0x4>;
+			ti,hwmods = "timer3";
+		};
+
+		timer4: timer@48036000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x48036000 0x80>;
+			interrupts = <0 40 0x4>;
+			ti,hwmods = "timer4";
+		};
+
+		timer5: timer@48820000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x48820000 0x80>;
+			interrupts = <0 41 0x4>;
+			ti,hwmods = "timer5";
+			ti,timer-dsp;
+		};
+
+		timer6: timer@48822000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x48822000 0x80>;
+			interrupts = <0 42 0x4>;
+			ti,hwmods = "timer6";
+			ti,timer-dsp;
+			ti,timer-pwm;
+		};
+
+		timer7: timer@48824000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x48824000 0x80>;
+			interrupts = <0 43 0x4>;
+			ti,hwmods = "timer7";
+			ti,timer-dsp;
+		};
+
+		timer8: timer@48826000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x48826000 0x80>;
+			interrupts = <0 44 0x4>;
+			ti,hwmods = "timer8";
+			ti,timer-dsp;
+			ti,timer-pwm;
+		};
+
+		timer9: timer@4803e000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x4803e000 0x80>;
+			interrupts = <0 45 0x4>;
+			ti,hwmods = "timer9";
+		};
+
+		timer10: timer@48086000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x48086000 0x80>;
+			interrupts = <0 46 0x4>;
+			ti,hwmods = "timer10";
+		};
+
+		timer11: timer@48088000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x48088000 0x80>;
+			interrupts = <0 47 0x4>;
+			ti,hwmods = "timer11";
+			ti,timer-pwm;
+		};
+
+		timer13: timer@48828000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x48828000 0x80>;
+			ti,hwmods = "timer13";
+			status = "disabled";
+		};
+
+		timer14: timer@4882a000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x4882a000 0x80>;
+			ti,hwmods = "timer14";
+			status = "disabled";
+		};
+
+		timer15: timer@4882c000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x4882c000 0x80>;
+			ti,hwmods = "timer15";
+			status = "disabled";
+		};
+
+		timer16: timer@4882e000 {
+			compatible = "ti,omap5430-timer";
+			reg = <0x4882e000 0x80>;
+			ti,hwmods = "timer16";
+			status = "disabled";
+		};
+
+		wdt2: wdt@4ae14000 {
+			compatible = "ti,omap4-wdt";
+			reg = <0x4ae14000 0x80>;
+			interrupts = <0 80 0x4>;
+			ti,hwmods = "wd_timer2";
+		};
+
+		i2c1: i2c@48070000 {
+			compatible = "ti,omap4-i2c";
+			reg = <0x48070000 0x100>;
+			interrupts = <0 56 0x4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c1";
+			status = "disabled";
+		};
+
+		i2c2: i2c@48072000 {
+			compatible = "ti,omap4-i2c";
+			reg = <0x48072000 0x100>;
+			interrupts = <0 57 0x4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c2";
+			status = "disabled";
+		};
+
+		i2c3: i2c@48060000 {
+			compatible = "ti,omap4-i2c";
+			reg = <0x48060000 0x100>;
+			interrupts = <0 61 0x4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c3";
+			status = "disabled";
+		};
+
+		i2c4: i2c@4807a000 {
+			compatible = "ti,omap4-i2c";
+			reg = <0x4807a000 0x100>;
+			interrupts = <0 62 0x4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c4";
+			status = "disabled";
+		};
+
+		i2c5: i2c@4807c000 {
+			compatible = "ti,omap4-i2c";
+			reg = <0x4807c000 0x100>;
+			interrupts = <0 60 0x4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "i2c5";
+			status = "disabled";
+		};
+
+		mmc1: mmc@4809c000 {
+			compatible = "ti,omap4-hsmmc";
+			reg = <0x4809c000 0x400>;
+			interrupts = <0 83 0x4>;
+			ti,hwmods = "mmc1";
+			ti,dual-volt;
+			ti,needs-special-reset;
+			dmas = <&sdma 61>, <&sdma 62>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		mmc2: mmc@480b4000 {
+			compatible = "ti,omap4-hsmmc";
+			reg = <0x480b4000 0x400>;
+			interrupts = <0 86 0x4>;
+			ti,hwmods = "mmc2";
+			ti,needs-special-reset;
+			dmas = <&sdma 47>, <&sdma 48>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		mmc3: mmc@480ad000 {
+			compatible = "ti,omap4-hsmmc";
+			reg = <0x480ad000 0x400>;
+			interrupts = <0 94 0x4>;
+			ti,hwmods = "mmc3";
+			ti,needs-special-reset;
+			dmas = <&sdma 77>, <&sdma 78>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		mmc4: mmc@480d1000 {
+			compatible = "ti,omap4-hsmmc";
+			reg = <0x480d1000 0x400>;
+			interrupts = <0 96 0x4>;
+			ti,hwmods = "mmc4";
+			ti,needs-special-reset;
+			dmas = <&sdma 57>, <&sdma 58>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		mcspi1: spi@48098000 {
+			compatible = "ti,omap4-mcspi";
+			reg = <0x48098000 0x200>;
+			interrupts = <0 65 0x4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi1";
+			ti,spi-num-cs = <4>;
+			dmas = <&sdma 35>,
+			       <&sdma 36>,
+			       <&sdma 37>,
+			       <&sdma 38>,
+			       <&sdma 39>,
+			       <&sdma 40>,
+			       <&sdma 41>,
+			       <&sdma 42>;
+			dma-names = "tx0", "rx0", "tx1", "rx1",
+				    "tx2", "rx2", "tx3", "rx3";
+			status = "disabled";
+		};
+
+		mcspi2: spi@4809a000 {
+			compatible = "ti,omap4-mcspi";
+			reg = <0x4809a000 0x200>;
+			interrupts = <0 66 0x4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi2";
+			ti,spi-num-cs = <2>;
+			dmas = <&sdma 43>,
+			       <&sdma 44>,
+			       <&sdma 45>,
+			       <&sdma 46>;
+			dma-names = "tx0", "rx0", "tx1", "rx1";
+			status = "disabled";
+		};
+
+		mcspi3: spi@480b8000 {
+			compatible = "ti,omap4-mcspi";
+			reg = <0x480b8000 0x200>;
+			interrupts = <0 91 0x4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi3";
+			ti,spi-num-cs = <2>;
+			dmas = <&sdma 15>, <&sdma 16>;
+			dma-names = "tx0", "rx0";
+			status = "disabled";
+		};
+
+		mcspi4: spi@480ba000 {
+			compatible = "ti,omap4-mcspi";
+			reg = <0x480ba000 0x200>;
+			interrupts = <0 48 0x4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcspi4";
+			ti,spi-num-cs = <1>;
+			dmas = <&sdma 70>, <&sdma 71>;
+			dma-names = "tx0", "rx0";
+			status = "disabled";
+		};
+	};
+};
-- 
1.7.9.5


