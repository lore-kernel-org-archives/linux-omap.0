From: =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?=
        <sz.lin@moxa.com>
Subject: [PATCH 2/3] ARM: dts: am335x: add support for Moxa UC-2101 open platform
Date: Thu, 30 Aug 2018 12:09:28 +0800
Message-ID: <20180830040929.23357-3-sz.lin@moxa.com>
References: <20180830040929.23357-1-sz.lin@moxa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830040929.23357-1-sz.lin@moxa.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= <sz.lin@moxa.com>, Wes Huang <wes.huang@moxa.com>, Fero JD Zhou <FeroJD.Zhou@moxa.com>
List-Id: linux-omap@vger.kernel.org

Add support for Moxa UC-2101 open platform

The UC-2101 computing platform is designed for industrial embedded
data acquisition and processing applications.

The features of UC-2101 are:
* eMMC
* SPI flash
* 1x LAN
* 1x RS-232/422/485 ports, software-selectable
* EEPROM
* TPM 2.0
* Watchdog
* RTC
* User gpio-keys
* User LEDs
* User button

Signed-off-by: Wes Huang (黃淵河) <wes.huang@moxa.com>
Signed-off-by: Fero JD Zhou (周俊達) <FeroJD.Zhou@moxa.com>
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
---
 .../devicetree/bindings/arm/omap/omap.txt     |  3 +
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts     | 63 +++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2101.dts

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 2ecc712bf707..c5ca3d6a8099 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -157,6 +157,9 @@ Boards:
 - AM335X phyCORE-AM335x: Development kit
   compatible = "phytec,am335x-pcm-953", "phytec,am335x-phycore-som", "ti,am33xx"
 
+- AM335X UC-2100: Wireless-enabled palm-sized industrial computing platform
+  compatible = "moxa,uc-2101", "ti,am33xx"
+
 - AM335X UC-8100-ME-T: Communication-centric industrial computing platform
   compatible = "moxa,uc-8100-me-t", "ti,am33xx";
 
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b5bd3de87c33..6167c068601c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -706,6 +706,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-evmsk.dtb \
 	am335x-icev2.dtb \
 	am335x-lxm.dtb \
+	am335x-moxa-uc-2101.dtb \
 	am335x-moxa-uc-8100-me-t.dtb \
 	am335x-nano.dtb \
 	am335x-pdu001.dtb \
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2101.dts b/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
new file mode 100644
index 000000000000..d0c1eea4a6c9
--- /dev/null
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 MOXA Inc. - https://www.moxa.com/
+ *
+ * Authors: SZ Lin (林上智) <sz.lin@moxa.com>
+ *          Wes Huang (黃淵河) <wes.huang@moxa.com>
+ *          Fero JD Zhou (周俊達) <FeroJD.Zhou@moxa.com>
+ */
+
+/dts-v1/;
+
+#include "am335x-moxa-uc-2100-common.dtsi"
+
+/ {
+	model = "Moxa UC-2101";
+	compatible = "moxa,uc-2101", "ti,am33xx";
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			label = "UC2100:GREEN:USER";
+			gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+};
+
+&am33xx_pinmux {
+	pinctrl-names = "default";
+
+	cpsw_default: cpsw_default {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
+			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txen.rmii1_txen */
+			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
+			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mii1_refclk.rmii1_refclk */
+		>;
+	};
+
+	spi1_pins: pinmux_spi1 {
+		pinctrl-single,pins = <
+			AM33XX_IOPAD(0x964, PIN_INPUT_PULLUP | MUX_MODE4)	 /* ecap0_in_pwm0_out.spi1_sclk */
+			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE4)	 /* uart1_ctsn.spi1_cs0 */
+			AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE4)	 /* uart0_ctsn.spi1_d0 */
+			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE4)	 /* uart0_rtsn.spi1_d1 */
+		>;
+	};
+};
+
+&cpsw_emac0 {
+	status = "okay";
+	phy_id = <&davinci_mdio>, <0x4>;
+	phy-mode = "rmii";
+};
+
+&cpsw_emac1 {
+	status = "disable";
+};
-- 
2.19.0.rc1
