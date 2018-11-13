From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-am654-base-board: Add I2C nodes
Date: Tue, 13 Nov 2018 11:31:11 +0530
Message-ID: <20181113060111.16374-5-vigneshr@ti.com>
References: <20181113060111.16374-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181113060111.16374-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Vignesh R <vigneshr@ti.com>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Add DT entries for I2C instances present in AM654 SoC.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 44 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       | 11 +++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    | 11 +++
 arch/arm64/boot/dts/ti/k3-am65.dtsi           |  6 ++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 70 +++++++++++++++++++
 5 files changed, 142 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index f7c2a60d5c80..916434839603 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -85,4 +85,48 @@
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
+
+	main_i2c0: i2c@2000000 {
+		compatible = "ti,am654-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x2000000 0x0 0x100>;
+		interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 110 1>;
+		power-domains = <&k3_pds 110>;
+	};
+
+	main_i2c1: i2c@2010000 {
+		compatible = "ti,am654-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x2010000 0x0 0x100>;
+		interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 111 1>;
+		power-domains = <&k3_pds 111>;
+	};
+
+	main_i2c2: i2c@2020000 {
+		compatible = "ti,am654-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x2020000 0x0 0x100>;
+		interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 112 1>;
+		power-domains = <&k3_pds 112>;
+	};
+
+	main_i2c3: i2c@2030000 {
+		compatible = "ti,am654-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x2030000 0x0 0x100>;
+		interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 113 1>;
+		power-domains = <&k3_pds 113>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 8c611d16df44..1fd027748e1f 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -15,4 +15,15 @@
 			clock-frequency = <96000000>;
 			current-speed = <115200>;
 	};
+
+	mcu_i2c0: i2c@40b00000 {
+		compatible = "ti,am654-i2c", "ti,omap4-i2c";
+		reg = <0x0 0x40b00000 0x0 0x100>;
+		interrupts = <GIC_SPI 564 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 114 1>;
+		power-domains = <&k3_pds 114>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index 19b46f40789b..9e8467ce7ad8 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -51,4 +51,15 @@
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
 	};
+
+	wkup_i2c0: i2c@42120000 {
+		compatible = "ti,am654-i2c", "ti,omap4-i2c";
+		reg = <0x42120000 0x100>;
+		interrupts = <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-names = "fck";
+		clocks = <&k3_clks 115 1>;
+		power-domains = <&k3_pds 115>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index 6fdfc7815811..50f4be2047a9 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -23,6 +23,12 @@
 		serial2 = &main_uart0;
 		serial3 = &main_uart1;
 		serial4 = &main_uart2;
+		i2c0 = &wkup_i2c0;
+		i2c1 = &mcu_i2c0;
+		i2c2 = &main_i2c0;
+		i2c3 = &main_i2c1;
+		i2c4 = &main_i2c2;
+		i2c5 = &main_i2c3;
 	};
 
 	chosen { };
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index cbf9d3dfeaa3..bd5a0069191d 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -35,6 +35,15 @@
 	};
 };
 
+&wkup_pmx0 {
+	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
+		pinctrl-single,pins = <
+			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT, 0) /* (AC7) WKUP_I2C0_SCL */
+			AM65X_WKUP_IOPAD(0x00e4, PIN_INPUT, 0) /* (AD6) WKUP_I2C0_SDA */
+		>;
+	};
+};
+
 &main_pmx0 {
 	main_uart0_pins_default: main-uart0-pins-default {
 		pinctrl-single,pins = <
@@ -44,6 +53,29 @@
 			AM65X_IOPAD(0x01f0, PIN_OUTPUT, 0)	/* (AD11) UART0_RTSn */
 		>;
 	};
+
+	main_i2c2_pins_default: main-i2c2-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x0074, PIN_INPUT, 5) /* (T27) GPMC0_CSn3.I2C2_SCL */
+			AM65X_IOPAD(0x0070, PIN_INPUT, 5) /* (R25) GPMC0_CSn2.I2C2_SDA */
+		>;
+	};
+};
+
+&main_pmx1 {
+	main_i2c0_pins_default: main-i2c0-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x0000, PIN_INPUT, 0) /* (D20) I2C0_SCL */
+			AM65X_IOPAD(0x0004, PIN_INPUT, 0) /* (C21) I2C0_SDA */
+		>;
+	};
+
+	main_i2c1_pins_default: main-i2c1-pins-default {
+		pinctrl-single,pins = <
+			AM65X_IOPAD(0x0008, PIN_INPUT, 0) /* (B21) I2C1_SCL */
+			AM65X_IOPAD(0x000c, PIN_INPUT, 0) /* (E21) I2C1_SDA */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -55,3 +87,41 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
 };
+
+&wkup_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	pca9554: gpio@39 {
+		compatible = "nxp,pca9554";
+		reg = <0x39>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	pca9555: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&main_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <400000>;
+};
+
+&main_i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c2_pins_default>;
+	clock-frequency = <400000>;
+};
-- 
2.19.1
