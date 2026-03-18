Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EED393DFB
	for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2026 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824095; cv=none; b=NNRuhEc4O1oEexZeeqc/r/00hCqpVLfy3K/3Lm4P0W0hY6ia3y58fZ24Y58ZMJVohaWi9mPW46LJAvrzuLBpU7TuuE5HTla4jbzYgCs3PWD43IXcV0oMZTpBDdnRDWpyjpebS3lG73VfwvS8ua6zuoNv6xMRM3/SaX8DfAd08Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824095; c=relaxed/simple;
	bh=F1c8h7XQUYOJeOTIMckWeltHUyGqxXPnl+9HpmkhJHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lTXUKrFyTrLjxTCaWpQ3vos56Gloyu+gX//Z41QGxcTsyUIFKAcMEzSLfIm84Z0vy0Z3j+E1+bC9kAjMsoDsFdp2Hl2zWNBb4hvDEffSpZ8TkH/R9q8vSKJXl/stH/PhHT15rFtv1z9SErsyRZ61jkdtZcygoD0I6NDi0/XltlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2Hxsybt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2Hxsybt"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b97a0f18a3aso508759766b.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2026 01:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773824088; x=1774428888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMHDH7wleoQWnYp+U62Lq9iWZRrogiMrLKeiIrWugFQ=;
        b=Q2HxsybtseDaOoYTgoW1kTPrEOGwFuEQ0IaQ6rBTzYuOyAnxMyZzaKT3rsmLr6hDOo
         ztWCe20IlhnrPvYDbDNKldEgOC2FTmr0GMLxd4WC9Izml41B2DUnKP529i5LkFqSvyO3
         2wyqwxJVS4jM7ET5uP8dtMIkkzGGvNlLtl8hqmxcqcX8yC8k7bOeId3NTv26dpUGTTqU
         oTx/XsecV1Z136MrgLC/tJBawMf/Y18gEpbEm/CiYpwRMfC/j85ZsqSY77lsNZ/H4uls
         9RwtgdUkRDECyFPEpnigxXSshmer9bDMQTwb8NsT/9FGvHEW2+8pjhIQfx/EYqBfyw8o
         nulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773824088; x=1774428888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMHDH7wleoQWnYp+U62Lq9iWZRrogiMrLKeiIrWugFQ=;
        b=bhfL7gKJ7byrAXHIzBkfepu9Prnp519ppUaR3Z6nEekrE49tRbyALaxFOa9rIFDzJS
         7rSpg+8wmZ0K/nPgpKPWwdjhE/5lJblpT55mafLidD44JtrN0JOWm+g3otnBs5O59ZJk
         JzQZAe6a6XUgvUNutZ/MFyaAo4rzN18xKIdieW6D2Hul3udJjbiBIuyxly5HFDBdR0yT
         9oIsWzEh7Y5aeS8YhMiefrRMxzqAZTqVyw7e0+8FOZJg0SG9QmaqYVcz6rZTOcwYzPwz
         9dz3HnmHA6zTWyTHqyDsMyVsZuucRyQA0jEsZ76juXB02DhjbK5VtQutoGF330RJrC/+
         Q+4w==
X-Forwarded-Encrypted: i=1; AJvYcCUn31UhHiDiXegrmbcSL2/KFmj+8uBV6l8mUL3PUfDSFDIoHKfR9CWRtKzeMVbRvI37Cht9pehIDL96@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6a8x+Mg8vxyw8FbYH5D8GRkK9tKKOdhHGI+gKmXPwhqCbJYJe
	i8e/g2jIA0vnlgFzCxZIMHYbjFgtygSLel/FPVW48XVeKR47uoPamvq+
X-Gm-Gg: ATEYQzyNEIN2/bgezYrc+IKCsAJJSeyBHnleEJfFdvUbQ+Bb4WQcSHuof01HLtsmUif
	F0PUlBkPE1AUktKiqLST1G4Aq58TvX0dcjgiVMRJJcSyeEwFd3nZTF0bXs/ZBrkWvPoQUMliIgR
	RVc5rHZDhMFOBOPY0X4Jt+KbxAgNzL588pcApKw9Xfsgq/hhwgElcgX7Lp6jiqC0CWtXSqfYwtR
	R/kALqKCzxGIU4ME6I75mzFtphLD1V5/RU5sQgon6qolMxkM1kbRhpCQjAqph/MTLWkTGqTMYTN
	6XC9IJ4UDbXJKBdtiIrK1sisqVUAGkJoB+RIGjxc7l2lJpoZPbvtx35v+OT6VIsJaS8v02vB3tM
	rnudBAmE4wRV2CQo7eOn1bSyjJzOUJuyCegWmVuRnzrFinuLsaqzQz3XLbHSiFhY+h97A0tV7Sh
	cWNYTj1vztbkoP0pITMEn2xsFu3fqrzUuPyJoXJxEbMlyJ4jzsXPHfFss3SSSREg30MOSuFYAJA
	Zl4n/uI
X-Received: by 2002:a17:906:fd8e:b0:b96:e593:fd32 with SMTP id a640c23a62f3a-b97f488554amr137876166b.12.1773824087475;
        Wed, 18 Mar 2026 01:54:47 -0700 (PDT)
Received: from fedora.tux.internal (85.191.71.118.dynamic.dhcp.aura-net.dk. [85.191.71.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9801c11fa0sm72259866b.28.2026.03.18.01.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 01:54:46 -0700 (PDT)
From: Bruno Thomsen <bruno.thomsen@gmail.com>
To: devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: Lars Alex Pedersen <lapeddk@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Roger Quadros <rogerq@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Bruno Thomsen <bruno.thomsen@gmail.com>
Subject: [PATCH 1/2] ARM: dts: ti/omap: am335x: add kamstrup emperor platform
Date: Wed, 18 Mar 2026 09:54:19 +0100
Message-ID: <20260318085420.7680-1-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device tree can be used on the following 3 products:
- Kamstrup READy Concentrator 1M (RC1M)
- Kamstrup READy Concentrator 2M (RC2M)
- Kamstrup READy Concentrator 2C (RC2C)

Concentrators are used as 868MHz gateway for heat, cooling and water
meters using wM-Bus, Kamstrup LinkIQ or OMS LPWAN communication protocols.

RC1M only support one way communication (Rx only) where RC2M and RC2C
support full two way communication (Rx/Tx) with meters.

Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
Co-developed-by: Lars Alex Pedersen <lapeddk@gmail.com>
Signed-off-by: Lars Alex Pedersen <lapeddk@gmail.com>
---
Note: AM33XX_PADCONF lines are longer then 100 columns but it's a common
warning in am335x DTS.

 arch/arm/boot/dts/ti/omap/am335x-emperor.dts | 690 +++++++++++++++++++
 1 file changed, 690 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/am335x-emperor.dts

diff --git a/arch/arm/boot/dts/ti/omap/am335x-emperor.dts b/arch/arm/boot/dts/ti/omap/am335x-emperor.dts
new file mode 100644
index 000000000000..b135708e73fb
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/am335x-emperor.dts
@@ -0,0 +1,690 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Device Tree Source for Kamstrup READy Concentrator 1M/2M/2C.
+ *
+ * Copyright (C) 2025 Kamstrup A/S
+ * Author: Bruno Thomsen <bruno.thomsen@gmail.com>
+ *         Lars Alex Pedersen <lapeddk@gmail.com>
+ */
+/dts-v1/;
+
+#include "am33xx.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Kamstrup READy Concentrator 1M/2M/2C";
+	compatible = "kam,am335x-emperor", "ti,am33xx";
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_pins_default>;
+
+		led0 {
+			label = "led0";
+			gpios = <&gpio2 24 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led1 {
+			label = "led1";
+			gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led2 {
+			label = "led2";
+			gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led3 {
+			label = "led3";
+			gpios = <&gpio2 25 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	sdr-radio-control {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdr_radio_control_pins_default>;
+
+		led_radio_power {
+			label = "RADIO_POWER";
+			gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		led_radio_flash_mux {
+			label = "RADIO_FLASH_MUX";
+			gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+
+		led_radio_reset {
+			label = "RADIO_RESET";
+			gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led_radio_flash_reset {
+			label = "RADIO_FLASH_RESET";
+			gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		vcc_fixed: vcc_fixed {
+			compatible = "regulator-fixed";
+			regulator-name = "vcc_fixed";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+		};
+
+		vmmcsd_fixed: fixedregulator0 {
+			compatible = "regulator-fixed";
+			regulator-name = "vmmcsd_fixed";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
+};
+
+/*
+ * Restrict 1.1 V operating point to increase SoC life-time
+ * by removing the follow opp's:
+ * - OPP120-1
+ * - OPP120-2
+ * - OPP120-2
+ * - OPP Turbo-2
+ * - OPP Nitro
+ *
+ * Note: This limit SoC operating point to maximum 600 MHz.
+ */
+&cpu0_opp_table {
+	/delete-node/ opp-120-600000000;
+	/delete-node/ opp-120-720000000;
+	/delete-node/ opp-720000000;
+	/delete-node/ opp-800000000;
+	/delete-node/ opp-1000000000;
+};
+
+&gpio0 {
+	gpio-line-names =
+		"MDIO_DATA",
+		"MDIO_CLK",
+		"SPI0_CLK",
+		"SPI0_MOSI",
+		"SPI0_MISO",
+		"SPI0_CS0",
+		"POWER_FAILURE",
+		"SPI1_CLK",
+		"SYS_BOOT12",
+		"SYS_BOOT13",
+		"SYS_BOOT14",
+		"SYS_BOOT15",
+		"RADIO_TEMP_CRIT",
+		"RADIO_TEMP_ALERT",
+		"I2C1_SDA",
+		"I2C1_SCL",
+		"MII1_TXD3",
+		"MII1_TXD2",
+		"USB0_DRVVBUS",
+		"RADIO_GPIO4",
+		"RADIO_IRQ",
+		"MII1_TXD1",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"MII1_TXD0",
+		"PHY_IRQ",
+		"NC",
+		"NC";
+};
+
+&gpio1 {
+	gpio-line-names =
+		"MMC1_DAT0",
+		"MMC1_DAT1",
+		"MMC1_DAT2",
+		"MMC1_DAT3",
+		"MMC1_DAT4",
+		"MMC1_DAT5",
+		"MMC1_DAT6",
+		"MMC1_DAT7",
+		"UART4_RX",
+		"UART4_TX",
+		"UART0_RX",
+		"UART0_TX",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"TEST_MODE",
+		"NC",
+		"RADIO_GPIO5",
+		"MMC1_CMD";
+};
+
+&gpio2 {
+	gpio-line-names =
+		"NC",
+		"NC",
+		"RADIO_GPIO0",
+		"RADIO_GPIO1",
+		"RADIO_GPIO2",
+		"RADIO_GPIO3",
+		"SYS_BOOT0",
+		"SYS_BOOT1",
+		"SYS_BOOT2",
+		"SYS_BOOT3",
+		"SYS_BOOT4",
+		"SYS_BOOT5",
+		"SYS_BOOT6",
+		"SYS_BOOT7",
+		"SYS_BOOT8",
+		"SYS_BOOT9",
+		"SYS_BOOT10",
+		"SYS_BOOT11",
+		"MII1_RXD3",
+		"MII1_RXD2",
+		"MII1_RXD1",
+		"MII1_RXD0",
+		"LED2",
+		"LED3",
+		"LED1",
+		"LED4",
+		"MMC0_DAT3",
+		"MMC0_DAT2",
+		"MMC0_DAT1",
+		"MMC0_DAT0",
+		"MMC0_CLK0",
+		"MMC0_CMD";
+};
+
+&gpio3 {
+	gpio-line-names =
+		"MII1_COL",
+		"MII1_CRS_DV",
+		"MII1_RXERR",
+		"MII1_TXEN",
+		"MII1_RXDV",
+		"I2C0_SDA",
+		"I2C0_SCL",
+		"NC",
+		"NC",
+		"MII1_TXCLK",
+		"MII1_RXCLK",
+		"NC",
+		"NC",
+		"NC",
+		"RTC_IRQ",
+		"RTC_TAMPER",
+		"RADIO_INIT_B",
+		"RADIO_PRG_DONE",
+		"RADIO_POWER",
+		"RADIO_FLASH_MUX",
+		"RADIO_RESET",
+		"RADIO_FLASH_RESET",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC";
+
+	eeprom-wp-hog {
+		gpio-hog;
+		gpios = <13 GPIO_ACTIVE_HIGH>;
+		output-low;
+	};
+};
+
+&am33xx_pinmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&pinctrl_board_pins_default
+		&sdr_radio_pins_default>;
+
+	temperature_pins: temperature-pins {
+		pinctrl-single,pins = <
+			// Critical radio temperature
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE7) /* (D18) uart1_ctsn.gpio0[12] */
+		>;
+	};
+
+	rtc_pins_default: rtc-pins {
+		pinctrl-single,pins = <
+			// RTC Interrupt
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKX, PIN_INPUT, MUX_MODE7) /* (A13) mcasp0_aclkx.gpio3[14] */
+			// Tamper state
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSX, PIN_INPUT, MUX_MODE7) /* (B13) mcasp0_fsx.gpio3[15] */
+			// Power failure
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE7) /* (C15) spi0_cs1.gpio0[6] */
+		>;
+	};
+
+	mii1_pins_default: mii1-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_MII1_COL, PIN_INPUT, MUX_MODE0) /* (H16) gmii1_col.gmii1_col */
+			AM33XX_PADCONF(AM335X_PIN_MII1_CRS, PIN_INPUT, MUX_MODE0) /* (H17) gmii1_crs.gmii1_crs */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_ER, PIN_INPUT, MUX_MODE0) /* (J15) gmii1_rxer.gmii1_rxer */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT, MUX_MODE0) /* (J16) gmii1_txen.gmii1_txen */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_DV, PIN_INPUT, MUX_MODE0) /* (J17) gmii1_rxdv.gmii1_rxdv */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_CLK, PIN_INPUT, MUX_MODE0) /* (K18) gmii1_txclk.gmii1_txclk */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_CLK, PIN_INPUT, MUX_MODE0) /* (L18) gmii1_rxclk.gmii1_rxclk */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_OUTPUT, MUX_MODE0) /* (K17) gmii1_txd0.gmii1_txd0 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD1, PIN_OUTPUT, MUX_MODE0) /* (K16) gmii1_txd1.gmii1_txd1 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD2, PIN_OUTPUT, MUX_MODE0) /* (K15) gmii1_txd2.gmii1_txd2 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD3, PIN_OUTPUT, MUX_MODE0) /* (J18) gmii1_txd3.gmii1_txd3 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_INPUT, MUX_MODE0) /* (M16) gmii1_rxd0.gmii1_rxd0 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT, MUX_MODE0) /* (L15) gmii1_rxd1.gmii1_rxd1 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD2, PIN_INPUT, MUX_MODE0) /* (L16) gmii1_rxd2.gmii1_rxd2 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD3, PIN_INPUT, MUX_MODE0) /* (L17) gmii1_rxd3.gmii1_rxd3 */
+		>;
+	};
+
+	mdio_pins_default: mdio-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0) /* (M18) mdio_clk.mdio_clk */
+			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLUP, MUX_MODE0) /* (M17) mdio_data.mdio_data */
+		>;
+	};
+
+	i2c0_pins_default: i2c0-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_INPUT, MUX_MODE0) /* (C16) I2C0_SCL.I2C0_SCL */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT, MUX_MODE0) /* (C17) I2C0_SDA.I2C0_SDA */
+		>;
+	};
+
+	i2c1_pins_default: i2c1-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_INPUT, MUX_MODE3) /* (D15) uart1_txd.I2C1_SCL */
+			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT, MUX_MODE3) /* (D16) uart1_rxd.I2C1_SDA */
+		>;
+	};
+
+	spi0_pins_default: spi0-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_INPUT, MUX_MODE0) /* (A17) spi0_sclk.spi0_sclk */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_INPUT_PULLUP, MUX_MODE0) /* (B17) spi0_d0.spi0_d0 */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D1, PIN_INPUT, MUX_MODE0) /* (B16) spi0_d1.spi0_d1 */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS0, PIN_INPUT_PULLUP, MUX_MODE0) /* (A16) spi0_cs0.spi0_cs0 */
+		>;
+	};
+
+	uart0_pins_default: uart0-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0) /* (E15) uart0_rxd.uart0_rxd */
+			AM33XX_PADCONF(AM335X_PIN_UART0_TXD, PIN_OUTPUT, MUX_MODE0) /* (E16) uart0_txd.uart0_txd */
+		>;
+	};
+
+	uart4_pins_default: uart4-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_INPUT_PULLUP, MUX_MODE1) /* (E18) uart0_ctsn.uart4_rxd */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_OUTPUT, MUX_MODE1) /* (E17) uart0_rtsn.uart4_txd */
+		>;
+	};
+
+	sdcard_pins_default: sdcard-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CLK, PIN_INPUT, MUX_MODE0) /* (G17) mmc0_clk.mmc0_clk */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CMD, PIN_INPUT, MUX_MODE0) /* (G18) mmc0_cmd.mmc0_cmd */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT0, PIN_INPUT, MUX_MODE0) /* (G16) mmc0_dat0.mmc0_dat0 */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT1, PIN_INPUT, MUX_MODE0) /* (G15) mmc0_dat1.mmc0_dat1 */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT2, PIN_INPUT, MUX_MODE0) /* (F18) mmc0_dat2.mmc0_dat2 */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT3, PIN_INPUT, MUX_MODE0) /* (F17) mmc0_dat3.mmc0_dat3 */
+		>;
+	};
+
+	emmc_pins_default: emmc-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN1, PIN_INPUT, MUX_MODE2) /* (U9) gpmc_csn1.mmc1_clk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN2, PIN_INPUT, MUX_MODE2) /* (V9) gpmc_csn2.mmc1_cmd */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD0, PIN_INPUT, MUX_MODE1) /* (U7) gpmc_ad0.mmc1_dat0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD1, PIN_INPUT, MUX_MODE1) /* (V7) gpmc_ad1.mmc1_dat1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD2, PIN_INPUT, MUX_MODE1) /* (R8) gpmc_ad2.mmc1_dat2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD3, PIN_INPUT, MUX_MODE1) /* (T8) gpmc_ad3.mmc1_dat3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD4, PIN_INPUT, MUX_MODE1) /* (U8) gpmc_ad4.mmc1_dat4 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD5, PIN_INPUT, MUX_MODE1) /* (V8) gpmc_ad5.mmc1_dat5 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD6, PIN_INPUT, MUX_MODE1) /* (R9) gpmc_ad6.mmc1_dat6 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD7, PIN_INPUT, MUX_MODE1) /* (T9) gpmc_ad7.mmc1_dat7 */
+		>;
+	};
+
+	leds_pins_default: leds-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT, MUX_MODE7) /* (U5) lcd_vsync.gpio2[22] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT, MUX_MODE7) /* (R5) lcd_hsync.gpio2[23] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_PCLK, PIN_OUTPUT, MUX_MODE7) /* (V5) lcd_pclk.gpio2[24] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT, MUX_MODE7) /* (R6) lcd_ac_bias_en.gpio2[25] */
+		>;
+	};
+
+	sdr_radio_control_pins_default: sdr-radio-control-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKR, PIN_OUTPUT, MUX_MODE7) /* (B12) mcasp0_aclkr.gpio3[18] */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSR, PIN_OUTPUT, MUX_MODE7) /* (C13) mcasp0_fsr.gpio3[19] */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR1, PIN_OUTPUT, MUX_MODE7) /* (D13) mcasp0_axr1.gpio3[20] */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKX, PIN_OUTPUT, MUX_MODE7) /* (A14) mcasp0_ahclkx.gpio3[21] */
+		>;
+	};
+
+	sdr_radio_pins_default: sdr-radio-pins {
+		pinctrl-single,pins = <
+			// Radio irq
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR1, PIN_INPUT_PULLUP, MUX_MODE7) /* (D14) xdma_event_intr1.gpio0[20] */
+			// Radio init_b
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR0, PIN_INPUT_PULLUP, MUX_MODE7) /* (D12) mcasp0_axr0.gpio3[16] */
+			// Radio prog_done
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKR, PIN_INPUT_PULLUP, MUX_MODE7) /* (C12) mcasp0_ahclkr.gpio3[17] */
+			// Radio gpio0 to gpio5
+			AM33XX_PADCONF(AM335X_PIN_GPMC_ADVN_ALE, PIN_INPUT_PULLUP, MUX_MODE7) /* (R7) gpmc_advn_ale.gpio2[2] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_OEN_REN, PIN_INPUT_PULLUP, MUX_MODE7) /* (T7) gpmc_oen_ren.gpio2[3] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WEN, PIN_INPUT_PULLUP, MUX_MODE7) /* (U6) gpmc_wen.gpio2[4] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN0_CLE, PIN_INPUT_PULLUP, MUX_MODE7) /* (T6) gpmc_be0n_cle.gpio2[5] */
+			AM33XX_PADCONF(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_INPUT_PULLUP, MUX_MODE7) /* (C18) eCAP0_in_PWM0_out.gpio0[7] */
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR0, PIN_INPUT_PULLUP, MUX_MODE7) /* (A15) xdma_event_intr0.gpio0[19] */
+		>;
+	};
+
+	pinctrl_board_pins_default: board-default-pins {
+		pinctrl-single,pins = <
+			// PHY irq
+			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLUP, MUX_MODE7) /* (H18) rmii1_refclk.gpio0[29] */
+			// Production test
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN1, PIN_INPUT_PULLUP, MUX_MODE7) /* (U18) gpmc_be1n.gpio1[28] */
+			// SYS_BOOT0 to SYS_BOOT15
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA0, PIN_INPUT, MUX_MODE7) /* (R1) lcd_data0.gpio2[6] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA1, PIN_INPUT, MUX_MODE7) /* (R2) lcd_data1.gpio2[7] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA2, PIN_INPUT, MUX_MODE7) /* (R3) lcd_data2.gpio2[8] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA3, PIN_INPUT, MUX_MODE7) /* (R4) lcd_data3.gpio2[9] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA4, PIN_INPUT, MUX_MODE7) /* (T1) lcd_data4.gpio2[10] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA5, PIN_INPUT, MUX_MODE7) /* (T2) lcd_data5.gpio2[11] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA6, PIN_INPUT, MUX_MODE7) /* (T3) lcd_data6.gpio2[12] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA7, PIN_INPUT, MUX_MODE7) /* (T4) lcd_data7.gpio2[13] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA8, PIN_INPUT, MUX_MODE7) /* (U1) lcd_data8.gpio2[14] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA9, PIN_INPUT, MUX_MODE7) /* (U2) lcd_data9.gpio2[15] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA10, PIN_INPUT, MUX_MODE7) /* (U3) lcd_data10.gpio2[16] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA11, PIN_INPUT, MUX_MODE7) /* (U4) lcd_data11.gpio2[17] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA12, PIN_INPUT, MUX_MODE7) /* (V2) lcd_data12.gpio0[8] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA13, PIN_INPUT, MUX_MODE7) /* (V3) lcd_data13.gpio0[9] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA14, PIN_INPUT, MUX_MODE7) /* (V4) lcd_data14.gpio0[10] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA15, PIN_INPUT, MUX_MODE7) /* (T5) lcd_data15.gpio0[11] */
+			// Unused gpio pins
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD8, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U10) gpmc_ad8.gpio0[22] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD9, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T10) gpmc_ad9.gpio0[23] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T11) gpmc_ad10.gpio0[26] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U12) gpmc_ad11.gpio0[27] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T17) gpmc_wait0.gpio0[30] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U17) gpmc_wpn.gpio0[31] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T12) gpmc_ad12.gpio1[12] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (R12) gpmc_ad13.gpio1[13] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (V13) gpmc_ad14.gpio1[14] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U13) gpmc_ad15.gpio1[15] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A0, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (R13) gpmc_a0.gpio1[16] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (V14) gpmc_a1.gpio1[17] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A2, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U14) gpmc_a2.gpio1[18] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A3, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T14) gpmc_a3.gpio1[19] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A4, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (R14) gpmc_a4.gpio1[20] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A5, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (V15) gpmc_a5.gpio1[21] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A6, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U15) gpmc_a6.gpio1[22] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A6, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T15) gpmc_a7.gpio1[23] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A8, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (V16) gpmc_a8.gpio1[24] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U16) gpmc_a9.gpio1[25] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T16) gpmc_a10.gpio1[26] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (V17) gpmc_a11.gpio1[27] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN0, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (V6) gpmc_csn0.gpio1[29] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN3, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T13) gpmc_csn3.gpio2[0] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (V12) gpmc_clk.gpio2[1] */
+			AM33XX_PADCONF(AM335X_PIN_USB1_DRVVBUS, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (F15) USB1_DRVVBUS.gpio3[13] */
+		>;
+	};
+};
+
+/*
+ * I2C bus on baseband board (55501738)
+ */
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_default>;
+	status = "okay";
+	clock-frequency = <400000>;
+
+	/*
+	 * SDR radio temperature sensor
+	 *
+	 * Unused hardware connected pins:
+	 * gpio0 pin 13: /ALERT INTERRUPT
+	 * gpio0 pin 12: /T_CRIT INTERRUPT
+	 */
+	sa56004: temperature-sensor@4c {
+		compatible = "nxp,sa56004";
+		reg = <0x4c>;
+		vcc-supply = <&vcc_fixed>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@0 {
+			reg = <0x0>;
+			label = "baseboard-temperature";
+		};
+
+		channel@1 {
+			reg = <0x1>;
+			label = "fpga-temperature";
+		};
+	};
+
+	pcf2127: rtc@51 {
+		compatible = "nxp,pcf2127";
+		reg = <0x51>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtc_pins_default>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		reset-source;
+	};
+
+	eeprom@54 {
+		compatible = "atmel,24c512";
+		reg = <0x54>;
+		pagesize = <128>;
+	};
+};
+
+/*
+ * I2C bus on radio board (55501946)
+ */
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_default>;
+	status = "okay";
+	clock-frequency = <400000>;
+
+	eeprom@50 {
+		reg = <0x50>;
+		compatible = "atmel,24c512";
+		pagesize = <128>;
+	};
+};
+
+/*
+ * SPI bus on radio board (55501946)
+ */
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins_default>;
+	ti,spi-num-cs = <1>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+		spi-max-frequency = <10000000>;
+
+		/* Radio flash is 32 MBytes in size.
+		 * 64 KB blocks of configurations are located in the
+		 * last part of the storage.
+		 */
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				reg = <0x0 0xfe0000>;
+				label = "radio-program";
+			};
+			partition@fe0000 {
+				reg = <0xfe0000 0x10000>;
+				label = "radio-config";
+			};
+			partition@ff0000 {
+				reg = <0xff0000 0x10000>;
+				label = "baseband-config";
+			};
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_default>;
+	status = "okay";
+};
+
+/*
+ * SDR radio low-level error logging.
+ * Works even if primary USB communcation has issues.
+ */
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins_default>;
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb_ctrl_mod {
+	status = "okay";
+};
+
+/*
+ * Host USB port 0 is used for SDR radio communication.
+ */
+&usb0_phy {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&cppi41dma	{
+	status = "okay";
+};
+
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <7>;
+	phy-mode = "mii";
+	phy-handle = <&ethernetphy7>;
+};
+
+&mac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mii1_pins_default>;
+	status = "okay";
+	slaves = <1>;
+};
+
+&davinci_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins_default>;
+	status = "okay";
+
+	ethernetphy7: ethernet-phy@7 {
+		reg = <7>;
+		smsc,disable-energy-detect;
+	};
+};
+
+/* eMMC */
+&mmc1 {
+	status = "okay";
+	bus-width = <8>;
+	vmmc-supply = <&vmmcsd_fixed>;
+	vmmc_aux-supply = <&vmmcsd_fixed>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_pins_default>;
+
+	/*
+	 * am335x doesn't support DDR, so make sure the data signal is set
+	 * early in the clock cycle
+	 */
+	/delete-property/ ti,needs-special-hs-handling;
+};
+
+/* microSD card, used during manufacturing */
+&mmc2 {
+	status = "okay";
+	bus-width = <4>;
+	vmmc-supply = <&vmmcsd_fixed>;
+	vmmc_aux-supply = <&vmmcsd_fixed>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdcard_pins_default>;
+};
+
+&rtc {
+	ti,no-init;
+	status = "disabled";
+};
+
+&aes {
+	status = "okay";
+};
+
+&sham {
+	status = "okay";
+};

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.53.0

