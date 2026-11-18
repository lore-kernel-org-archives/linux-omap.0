Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024355;
	b=DjzJ1H89zf+DB12dqWHlDLeuXYcPdyGbs4I+gYQdbylJ6SbCOkj9hAJ/evJjYsz0YZoj
	 ey2KaPnBPN2Pu88Yi9EpkSr72mNgKbd2KuyIDFHwDfwzynrHPiPUMfJF7NkZV43LaXDg2
	 ZUOa61Y395Fe9dcCZQbPP8xLlh7bDvNwBkuWF+nQCHfnyeOvcC1m6tfATtOttj6I7KP8E
	 INDhiOOqX3w4inApQfqsI+kCrEr/ICGIlh/A15G51DYTm/lfhRqIsi2HphjWt5Tl3Tn7v
	 1IKPZ8Yk04ZNlJomOMQ2pdGfP2oa98ZvSo90lAOaq5Y1cjHyheX22JapGaUzNsIBO7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fk+qHAtrZ/DuPJQrbCUqHs8XRpVqhWvW4Myt9AdL6M4=;
	b=0c85x3DvVWoIf291a2L/X8me8XCjO81lZwDBlRjog6oIV+nmwMd+p9mek+JOkrP49gPT
	 sGelXCmpYqvTsp6xUZqo7XvfDt2gRbNnhLbWMargGveow0oZ9rjG+eFc08hQ12cWa2po4
	 o9B8lVP0Wg2B1TBm8HHI/UB3YLgRcKwid/prsAo47rjpZFg044y0ejIWFKs8FKyNBkerv
	 IpT/wTJ4hntuRPzGxZcfl4aDDjWthRKxaLdqVpvnsTrrTddfseaZTc8qs+yH2R3hSxAjq
	 BLVL/5nIviLKgVsyBbx7YJqiKHCwL7R2MyWozrL0TRp2kuauQMb8z1cAc0znddkwxNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fl2pYFX7;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8382960A2609
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 17:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8382960A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fl2pYFX7
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b8977f2785so1440199a12.3
        for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2026 09:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795024353; x=1795629153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fk+qHAtrZ/DuPJQrbCUqHs8XRpVqhWvW4Myt9AdL6M4=;
        b=Fl2pYFX7rqLTeW3ggEiDu81vcYN2zUFrCHtRl8PnhK0LM8mrLTYN4laUgird667h2b
         BicAr19uFg7Ni2xdYou1btXl6KZTMKrmy0roimJhxMgGO5az8M8w0icm6ewseVQEN55H
         C+HdwFQ3pRb10dDWOn+Tsl3ovv54/TY62MFWEnAMJQWVG7q35LzRnMpj5r2g84xCC8M5
         4aozzGt6YIUNHAjaQymZiHt8n/mzE7qQIxfgP2H5YynZrJAoj3Pb4bMbtp2w82xbtNyU
         pxGwy9E2it0LCFzokn48T3l5ICIGV3gTfto3mQodFO2IJcmWgvzBLzkhGADXFjQnOBs1
         vXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795024353; x=1795629153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fk+qHAtrZ/DuPJQrbCUqHs8XRpVqhWvW4Myt9AdL6M4=;
        b=hF2oDzy3xc7dbhRLEh4FuIaKW+dtq7RrgNvXFwWAtUVomfv9sS/nYz46H1C/i2m0Fu
         cI7itKy+NXk7lwy05OLucGdmjspIuAFvcaUq0e+7G9wLFJ82ffe/9H8KApCqKyhWlK9l
         d6yQMIhv+PdQnNsncRVWAstDP1fyFfXEEhCKhWQOCrtvAotJI+J+ZuyfMVmeep0Fm+Vf
         gnYB7hxK+r8ZK2VuaqT8sFlEDX0JnZSvGPgXjxGA5xcQP3w3bgUVklhhvAtGihLX9j8/
         dTQHSLQEEEYFNIZFyLM38P3D/1Pl+EAIhaooBPyeWjFA9PDv0fwiPZe/hC5RN02QFdoT
         vaxA==
X-Forwarded-Encrypted: i=1; AL+hErFsiXE7/uasuwIvRN9EmL51rZMWKWJ0yFxqc8FXKUSXA3or0g57twIESZGONgyQQ/355MEK1L+kezNP@vger.kernel.org
X-Gm-Message-State: APuU4Z8B7Mno5XwD+OPZ/CXSk6XiBlhllectCPUN3GyeeowYvboUfz3R
	ytqZtlUPvj14zpvytK1VCh5t6uw9XZNI3LJM1s2dGpFOw1ZX/Jg4afIwwRryzkqk
X-Gm-Gg: AYBFou2hycu1q/Gep55AB6DLo8iF1ojb0IffBxghdGPNQIRy5F9bytq2/wh4QWuscZf
	da7+bRCpDpUTy6kD3BVKZ07NcM44sqkHxmkingUJrfaqS5xvfQnR3LIjBw43YgOUkXCB1xHSQXl
	P3i9tANhhSo8m/9aQ6eJGQGtX1NdppXg9aY2NkfStho4hvJE6e9sIyaB/sIqfQhEnHfMzns9CAt
	UKsgMZndyMifMIXwMTjwcuu4yPa+GWJtQQ+a4y7Q5Z8NCPV7oXXAwA09+z9H/wbj/F6lsqcQKIm
	t4sm0UTY0dE7YaUY1/5jX2MlXTDl3hTqJ3tbouALNHsI27RZKoRoyNVWP6/95wAMIeCgracP1gi
	HlzwB/YUhfSg3tKmTeLvYx02yZd0q1WMQvtcjA5pfaEIeezBAyCLiwEv7XwnbrVu7D7dqPTVLeH
	Z0ASJ/JOMe3zVxFn3kv4hy3Hd0qq0CUUpy/kxBWsUodsTSJthtZyM2REVDacKaRMQm/vMqmcei1
	657F0A4Sbp/MyfeGmAqkWA4KxNntsZ+YBbbgZqRXvBMKKyMJG6yto9Eq0C8jcbQc0mvlrSBxetD
	S8k3Ncs9HKoo5qxW+O6Zwn3806qm6CAtfq8V1KFx8uZcLwFHolM/6VQc6G8m15MvCKeUgK2Utwm
	6xU8n5T39Kdw=
X-Received: by 2002:aa7:d0d2:0:b0:6b8:6d59:5f2d with SMTP id 4fb4d7f45d1cf-6b887ebb2femr2187055a12.31.1795024352662;
        Wed, 18 Nov 2026 09:52:32 -0800 (PST)
Received: from fedora.tux.internal (85.191.71.118.dynamic.dhcp.aura-net.dk. [85.191.71.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b889c22d85sm1379135a12.15.2026.11.18.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 09:52:32 -0800 (PST)
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
Subject: [PATCH v2 2/3] ARM: dts: ti/omap: am335x: add kamstrup emperor platforms
Date: Wed, 18 Nov 2026 18:52:08 +0100
Message-ID: <20261118175209.20829-2-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118175209.20829-1-bruno.thomsen@gmail.com>
References: <20261118175209.20829-1-bruno.thomsen@gmail.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device trees can be used on the following 4 products:
- Kamstrup READy Concentrator 1M (RC1M)
- Kamstrup READy Concentrator 2M (RC2M)
- Kamstrup READy Concentrator 2C (RC2C)
- Kamstrup connectIQ IoT Gateway 500 (CIG500)

Concentrators are used as 868MHz gateway for heat, cooling and water
meters using wM-Bus, Kamstrup LinkIQ or OMS LPWAN communication protocols.

RC1M only support one way communication (Rx only) where RC2M, RC2C
and CIG500 support full two way communication (Rx/Tx) with meters.

Product pages:
https://www.kamstrup.com/en-en/product-centre/ready-concentrator-2m
https://www.kamstrup.com/en-en/product-centre/ready-concentrator-2c
https://www.kamstrup.com/en-en/product-centre/connectiq-iot-gateway-500

Co-developed-by: Lars Alex Pedersen <lapeddk@gmail.com>
Signed-off-by: Lars Alex Pedersen <lapeddk@gmail.com>
Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
---
Changes in v2:
- Add Kamstrup connectIQ IoT Gateway 500 (CIG500) in am335x-emperor-mini
- Move common platform configuration into am335x-emperor-common.dtsi.
- Fix pinmux typo: AM335X_PIN_GPMC_A6 was listed twice, so gpmc_a7 (T15) was
  never muxed. The second entry is now AM335X_PIN_GPMC_A7.
- Drop phy_id from &cpsw_emac0. phy-handle is parsed first, so it was
  never used, and it triggers a dtc property_name_chars_strict warning.
- Merge the temperature-pins group into pinctrl_board_pins_default. It was
  never referenced by any pinctrl-0, so the /T_CRIT pin was not muxed.
- Mux the sensor /ALERT pin (uart1_rtsn, gpio0[13]) alongside /T_CRIT.
- Drop the sdr-radio-control node. It used gpio-leds to expose four radio
  control lines (power, reset, flash mux, flash reset) that are not LEDs;
  they are reached from user space by GPIO line name instead. Their pad
  configuration moves into sdr_radio_pins_default.
- LEDs: replace the deprecated label property with color and function
  (plus function-enumerator where they would otherwise collide) on the
  gpio-leds nodes, and rename them led0..led3 to led-1..led-4. The
  lp5812 multi-led nodes keep label, as the driver derives the LED name
  from it and ignores function.
- Move the fixed regulators out of the simple-bus "regulators" container
  to the root node, and give them generic node names.
- Drop vmmc_aux-supply from mmc1 and mmc2.
- Remove device tree labels that were never referenced.
- Use /* */ comments instead of //, except for the SPDX identifier.
- Reorder the sign-off trailers so the author's Signed-off-by comes last.

Note 1: AM33XX_PADCONF lines are longer then 100 columns but it's a common
warning for in-tree am335x DTS.

Note 2: am335x-emperor-mini names its temperature channels with channel
nodes, which the ti,tmp401 binding does not yet describe. Until that
lands dtbs_check reports:

  am335x-emperor-mini.dtb: temperature-sensor@4c (ti,tmp431):
  '#address-cells', '#size-cells', 'channel@0', 'channel@1' do not
  match any of the regexes: '^pinctrl-[0-9]+$'

The binding and driver change is added by a separate patch series (v2):
https://lore.kernel.org/linux-hwmon/20261118174334.18759-1-bruno.thomsen@gmail.com/
---
 arch/arm/boot/dts/ti/omap/Makefile            |   2 +
 .../dts/ti/omap/am335x-emperor-common.dtsi    | 414 ++++++++++++++++++
 .../boot/dts/ti/omap/am335x-emperor-mini.dts  | 408 +++++++++++++++++
 arch/arm/boot/dts/ti/omap/am335x-emperor.dts  | 262 +++++++++++
 4 files changed, 1086 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/am335x-emperor-common.dtsi
 create mode 100644 arch/arm/boot/dts/ti/omap/am335x-emperor-mini.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/am335x-emperor.dts

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index 498c36ccb5ea..6764ffa88f07 100644
--- a/arch/arm/boot/dts/ti/omap/Makefile
+++ b/arch/arm/boot/dts/ti/omap/Makefile
@@ -105,6 +105,8 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-bonegreen-hdmi-00a0.dtb \
 	am335x-chiliboard.dtb \
 	am335x-cm-t335.dtb \
+	am335x-emperor.dtb \
+	am335x-emperor-mini.dtb \
 	am335x-evm.dtb \
 	am335x-evmsk.dtb \
 	am335x-guardian.dtb \
diff --git a/arch/arm/boot/dts/ti/omap/am335x-emperor-common.dtsi b/arch/arm/boot/dts/ti/omap/am335x-emperor-common.dtsi
new file mode 100644
index 000000000000..2e4c1e3728c1
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/am335x-emperor-common.dtsi
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Device Tree Include file for Kamstrup emperor platforms.
+ *
+ * Copyright (C) 2025 Kamstrup A/S
+ * Author: Bruno Thomsen <bruno.thomsen@gmail.com>
+ *         Lars Alex Pedersen <lapeddk@gmail.com>
+ */
+
+#include "am33xx.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>; /* 256 MB */
+	};
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	/*
+	 * Internal LEDs on baseband board (emperor 55501738, mini 55502242),
+	 * not part of the HMI.
+	 * emperor-mini extends this node with led-5 for HMI power control.
+	 */
+	leds: leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_pins_default>;
+
+		led-1 {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&gpio2 24 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-2 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			function-enumerator = <1>;
+			gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-3 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+			function-enumerator = <2>;
+			gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led-4 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&gpio2 25 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	vcc_fixed: regulator-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+
+	vmmcsd_fixed: regulator-vmmcsd {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcsd_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+/*
+ * Restrict 1.1 V operating point to increase SoC life-time
+ * by removing the following opp's:
+ * - OPP120-1
+ * - OPP120-2
+ * - OPP Turbo-1
+ * - OPP Turbo-2
+ * - OPP Nitro
+ *
+ * Note: This limits SoC operating point to maximum 600 MHz.
+ */
+&cpu0_opp_table {
+	/delete-node/ opp-120-600000000;
+	/delete-node/ opp-120-720000000;
+	/delete-node/ opp-720000000;
+	/delete-node/ opp-800000000;
+	/delete-node/ opp-1000000000;
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
+&am33xx_pinmux {
+	rtc_pins_default: rtc-pins {
+		pinctrl-single,pins = <
+			/* RTC Interrupt */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKX, PIN_INPUT, MUX_MODE7) /* (A13) mcasp0_aclkx.gpio3[14] */
+			/* Tamper state */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSX, PIN_INPUT, MUX_MODE7) /* (B13) mcasp0_fsx.gpio3[15] */
+			/* Power failure */
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
+			/* led-5 on emperor-mini, NC on emperor */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T12) gpmc_ad12.gpio1[12] */
+		>;
+	};
+
+	sdr_radio_pins_default: sdr-radio-pins {
+		pinctrl-single,pins = <
+			/* Radio irq */
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR1, PIN_INPUT_PULLUP, MUX_MODE7) /* (D14) xdma_event_intr1.gpio0[20] */
+			/* Radio init_b */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR0, PIN_INPUT_PULLUP, MUX_MODE7) /* (D12) mcasp0_axr0.gpio3[16] */
+			/* Radio prog_done */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKR, PIN_INPUT_PULLUP, MUX_MODE7) /* (C12) mcasp0_ahclkr.gpio3[17] */
+			/* Radio gpio0 to gpio5 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_ADVN_ALE, PIN_INPUT_PULLUP, MUX_MODE7) /* (R7) gpmc_advn_ale.gpio2[2] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_OEN_REN, PIN_INPUT_PULLUP, MUX_MODE7) /* (T7) gpmc_oen_ren.gpio2[3] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WEN, PIN_INPUT_PULLUP, MUX_MODE7) /* (U6) gpmc_wen.gpio2[4] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN0_CLE, PIN_INPUT_PULLUP, MUX_MODE7) /* (T6) gpmc_be0n_cle.gpio2[5] */
+			AM33XX_PADCONF(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_INPUT_PULLUP, MUX_MODE7) /* (C18) eCAP0_in_PWM0_out.gpio0[7] */
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR0, PIN_INPUT_PULLUP, MUX_MODE7) /* (A15) xdma_event_intr0.gpio0[19] */
+			/* Radio power */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKR, PIN_OUTPUT, MUX_MODE7) /* (B12) mcasp0_aclkr.gpio3[18] */
+			/* Radio flash mux */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSR, PIN_OUTPUT, MUX_MODE7) /* (C13) mcasp0_fsr.gpio3[19] */
+			/* Radio reset */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR1, PIN_OUTPUT, MUX_MODE7) /* (D13) mcasp0_axr1.gpio3[20] */
+			/* Radio flash reset */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKX, PIN_OUTPUT, MUX_MODE7) /* (A14) mcasp0_ahclkx.gpio3[21] */
+		>;
+	};
+};
+
+/*
+ * SPI bus on radio frontend board.
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
+ * Works even if primary USB communication has issues.
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
+ * Host USB port 0 is used for SDR FPGA communication.
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
+&cppi41dma {
+	status = "okay";
+};
+
+&cpsw_emac0 {
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
+/* eMMC disk */
+&mmc1 {
+	status = "okay";
+	bus-width = <8>;
+	vmmc-supply = <&vmmcsd_fixed>;
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
diff --git a/arch/arm/boot/dts/ti/omap/am335x-emperor-mini.dts b/arch/arm/boot/dts/ti/omap/am335x-emperor-mini.dts
new file mode 100644
index 000000000000..797b52f32a7a
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/am335x-emperor-mini.dts
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Device Tree Source for Kamstrup connectIQ IoT Gateway 500.
+ *
+ * Copyright (C) 2025 Kamstrup A/S
+ * Author: Bruno Thomsen <bruno.thomsen@gmail.com>
+ *         Lars Alex Pedersen <lapeddk@gmail.com>
+ */
+/dts-v1/;
+
+#include "am335x-emperor-common.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Kamstrup connectIQ IoT Gateway 500";
+	compatible = "kam,am335x-emperor-mini", "ti,am33xx";
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
+		"PCI_PWR_ENA",
+		"NC",
+		"NC",
+		"PCI_RST_N",
+		"PCI_CARD_DET_N",
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
+		"HMI_POWERCTRL",
+		"PCI_W_DIS_N",
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
+		"POE_DETECT_N",
+		"RADIO_GPIO5",
+		"MMC1_CMD";
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
+};
+
+&am33xx_pinmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&pinctrl_board_pins_default
+		&pcie_module_pins_default
+		&sdr_radio_pins_default>;
+
+	pcie_module_pins_default: pcie-module-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD9, PIN_OUTPUT, MUX_MODE7) /* (T10) gpmc_ad9.gpio0[23] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_OUTPUT, MUX_MODE7) /* (R12) gpmc_ad13.gpio1[13] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_OUTPUT, MUX_MODE7) /* (T11) gpmc_ad10.gpio0[26] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLUP, MUX_MODE7) /* (U12) gpmc_ad11.gpio0[27] */
+		>;
+	};
+
+	pinctrl_board_pins_default: board-default-pins {
+		pinctrl-single,pins = <
+			/* PoE detect (POE_DETECT_N) */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN0, PIN_INPUT_PULLUP, MUX_MODE7) /* (V6) gpmc_csn0.gpio1[29] */
+			/* PHY irq */
+			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLUP, MUX_MODE7) /* (H18) rmii1_refclk.gpio0[29] */
+			/* Production test */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN1, PIN_INPUT_PULLUP, MUX_MODE7) /* (U18) gpmc_be1n.gpio1[28] */
+			/* Temperature sensor: critical (T_CRIT) */
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE7) /* (D18) uart1_ctsn.gpio0[12] */
+			/* Temperature sensor: alert (ALERT) */
+			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_INPUT_PULLUP, MUX_MODE7) /* (D17) uart1_rtsn.gpio0[13] */
+			/* SYS_BOOT0 to SYS_BOOT15 */
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
+			/* Unused GPIO pins */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD8, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U10) gpmc_ad8.gpio0[22] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T17) gpmc_wait0.gpio0[30] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U17) gpmc_wpn.gpio0[31] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (V13) gpmc_ad14.gpio1[14] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U13) gpmc_ad15.gpio1[15] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A0, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (R13) gpmc_a0.gpio1[16] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (V14) gpmc_a1.gpio1[17] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A2, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U14) gpmc_a2.gpio1[18] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A3, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T14) gpmc_a3.gpio1[19] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A4, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (R14) gpmc_a4.gpio1[20] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A5, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (V15) gpmc_a5.gpio1[21] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A6, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U15) gpmc_a6.gpio1[22] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A7, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T15) gpmc_a7.gpio1[23] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A8, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (V16) gpmc_a8.gpio1[24] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U16) gpmc_a9.gpio1[25] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T16) gpmc_a10.gpio1[26] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (V17) gpmc_a11.gpio1[27] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN3, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T13) gpmc_csn3.gpio2[0] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (V12) gpmc_clk.gpio2[1] */
+			AM33XX_PADCONF(AM335X_PIN_USB1_DRVVBUS, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (F15) USB1_DRVVBUS.gpio3[13] */
+		>;
+	};
+};
+
+/*
+ * I2C bus on baseband board (55502242)
+ */
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_default>;
+	status = "okay";
+	clock-frequency = <400000>;
+
+	/*
+	 * Baseband board temperature sensor.
+	 * Local channel measures the board, remote channel the FPGA die.
+	 *
+	 * Alert pins are muxed as GPIO inputs but have no kernel consumer:
+	 * gpio0 pin 12: /T_CRIT
+	 * gpio0 pin 13: /ALERT
+	 */
+	temperature-sensor@4c {
+		compatible = "ti,tmp431";
+		reg = <0x4c>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@0 {
+			reg = <0x0>;
+			label = "baseboard";
+		};
+
+		channel@1 {
+			reg = <0x1>;
+			label = "fpga";
+		};
+	};
+
+	rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
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
+ * I2C bus on radio frontend board (55502246)
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
+
+	led-controller@15 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "ti,lp5812";
+		reg = <0x15>;
+		ti,scan-mode = "tcm:4:0:1:2:3";
+		vcc-supply = <&vcc_fixed>;
+
+		multi-led@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x4>;
+			color = <LED_COLOR_ID_RGB>;
+			label = "hmi-system";
+
+			led@4 {
+				reg = <0x4>;
+				color = <LED_COLOR_ID_GREEN>;
+				led-max-microamp = <10000>;
+			};
+
+			led@5 {
+				reg = <0x5>;
+				color = <LED_COLOR_ID_RED>;
+				led-max-microamp = <10000>;
+			};
+
+			led@6 {
+				reg = <0x6>;
+				color = <LED_COLOR_ID_BLUE>;
+				led-max-microamp = <5000>;
+			};
+		};
+
+		multi-led@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x5>;
+			color = <LED_COLOR_ID_RGB>;
+			label = "hmi-ethernet";
+
+			led@7 {
+				reg = <0x7>;
+				color = <LED_COLOR_ID_GREEN>;
+				led-max-microamp = <10000>;
+			};
+
+			led@8 {
+				reg = <0x8>;
+				color = <LED_COLOR_ID_RED>;
+				led-max-microamp = <10000>;
+			};
+
+			led@9 {
+				reg = <0x9>;
+				color = <LED_COLOR_ID_BLUE>;
+				led-max-microamp = <5000>;
+			};
+		};
+
+		multi-led@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x6>;
+			color = <LED_COLOR_ID_RGB>;
+			label = "hmi-lpwan";
+
+			led@a {
+				reg = <0xa>;
+				color = <LED_COLOR_ID_GREEN>;
+				led-max-microamp = <10000>;
+			};
+
+			led@b {
+				reg = <0xb>;
+				color = <LED_COLOR_ID_RED>;
+				led-max-microamp = <10000>;
+			};
+
+			led@c {
+				reg = <0xc>;
+				color = <LED_COLOR_ID_BLUE>;
+				led-max-microamp = <5000>;
+			};
+		};
+
+		multi-led@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x7>;
+			color = <LED_COLOR_ID_RGB>;
+			label = "hmi-cellular";
+
+			led@d {
+				reg = <0xd>;
+				color = <LED_COLOR_ID_GREEN>;
+				led-max-microamp = <10000>;
+			};
+
+			led@e {
+				reg = <0xe>;
+				color = <LED_COLOR_ID_RED>;
+				led-max-microamp = <10000>;
+			};
+
+			led@f {
+				reg = <0xf>;
+				color = <LED_COLOR_ID_BLUE>;
+				led-max-microamp = <5000>;
+			};
+		};
+	};
+
+	adc@2f {
+		/* Using internal 2.5V Vref */
+		compatible = "adi,ad7291";
+		reg = <0x2f>;
+	};
+};
+
+/*
+ * Part of the HMI, mounted on the radio frontend board (55502246).
+ * The power indicator is an RGB LED lit green by default. Asserting
+ * this line turns on its red channel, so the indicator shows orange.
+ */
+&leds {
+	led-5 {
+		color = <LED_COLOR_ID_RED>;
+		function = LED_FUNCTION_POWER;
+		gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
+		default-state = "off";
+	};
+};
+
+/*
+ * Host USB port 1 is used for mini PCIe slot with cellular module.
+ */
+&usb1_phy {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+	dr_mode = "host";
+};
diff --git a/arch/arm/boot/dts/ti/omap/am335x-emperor.dts b/arch/arm/boot/dts/ti/omap/am335x-emperor.dts
new file mode 100644
index 000000000000..bb5cc7dc347c
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/am335x-emperor.dts
@@ -0,0 +1,262 @@
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
+#include "am335x-emperor-common.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "Kamstrup READy Concentrator 1M/2M/2C";
+	compatible = "kam,am335x-emperor", "ti,am33xx";
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
+	pinctrl_board_pins_default: board-default-pins {
+		pinctrl-single,pins = <
+			/* PHY irq */
+			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLUP, MUX_MODE7) /* (H18) rmii1_refclk.gpio0[29] */
+			/* Production test */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN1, PIN_INPUT_PULLUP, MUX_MODE7) /* (U18) gpmc_be1n.gpio1[28] */
+			/* Temperature sensor: critical (T_CRIT) */
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE7) /* (D18) uart1_ctsn.gpio0[12] */
+			/* Temperature sensor: alert (ALERT) */
+			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_INPUT_PULLUP, MUX_MODE7) /* (D17) uart1_rtsn.gpio0[13] */
+			/* SYS_BOOT0 to SYS_BOOT15 */
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
+			/* Unused GPIO pins */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD8, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U10) gpmc_ad8.gpio0[22] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD9, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T10) gpmc_ad9.gpio0[23] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T11) gpmc_ad10.gpio0[26] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U12) gpmc_ad11.gpio0[27] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T17) gpmc_wait0.gpio0[30] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (U17) gpmc_wpn.gpio0[31] */
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
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A7, PIN_INPUT_PULLDOWN, MUX_MODE7) /* (T15) gpmc_a7.gpio1[23] */
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
+	 * Baseband board temperature sensor.
+	 * Local channel measures the board, remote channel the FPGA die.
+	 *
+	 * Alert pins are muxed as GPIO inputs but have no kernel consumer:
+	 * gpio0 pin 12: /T_CRIT
+	 * gpio0 pin 13: /ALERT
+	 */
+	temperature-sensor@4c {
+		compatible = "nxp,sa56004";
+		reg = <0x4c>;
+		vcc-supply = <&vcc_fixed>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@0 {
+			reg = <0x0>;
+			label = "baseboard";
+		};
+
+		channel@1 {
+			reg = <0x1>;
+			label = "fpga";
+		};
+	};
+
+	rtc@51 {
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
+ * I2C bus on radio frontend board (55501946)
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
-- 
2.53.0

