Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F743271F2
	for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535073; cv=none; b=p0peOlyAM8iP+SV0fDUVdlb9QyGtUqmAsdjen9k1SOiqldSi09eqRWKckVrCuK3iH6DD1u6PeBt7rm3BgZpZCq3hBeOerA4D28BRSkynZ7Ikrm19rcl8YUyHnLiSGKzyFZkSUV5F6TC+zclmsem+s+AiEo4MilRuiZQfSJ6aUMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535073; c=relaxed/simple;
	bh=RX33GA5zOgpeoSMg8VreXReEf3kxele1e/vLT+8mqtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2WDepdbOObke09wnI6SspwQE2l4c9pa85WV1TWR+DuKdg/g6oSgebQJIX5cO6drHaPDhhc7IS0PRmacvlCVdLQz/h+GjNM4b7Ews46ZLXMMKM8N0P7wsQHLsvRdITcA/4YAkXl5ba0keRzClOV1B4Yp176X4wuA5aEw6E4T1pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQteUeal; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQteUeal"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50698970941so14187141cf.0
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 13:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771535069; x=1772139869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpRjzfXUeBLBrKzvrYORnAxZvwxzGUFHWoRvOxRUYhc=;
        b=PQteUealhPDLFKuEMsIJOzyioFVqHV1nkHFntDCwHfdhlLroAM/nuYK3/E+yYdhnmV
         RTV55ZF7kFdHNE4QppUBAKQNiCkNcOAOdK/ZlzrMlLGHYIbDGt0FZMEa0WDg8HCG1K/9
         UzFCvL6H4NGzUkyWUNLTLGfW2MNy0PmdLMlQON3LxWKEahSuL0HpqUkcpRHUYd5jot5y
         WUEenR8VrTgNnDp/Uif7fn5dhY+4d5dGtxHtrAitetGQQdA5CwfTMhRbGOMFC4eBR684
         wOdjhtI1ssYkdrGY+jBojYMPhKati8qJ1jJG0+cLjEXX/IYTYi+V7eFjNDm8DEl8vlUE
         Db/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771535069; x=1772139869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SpRjzfXUeBLBrKzvrYORnAxZvwxzGUFHWoRvOxRUYhc=;
        b=r2wFhjgvKJ6k5TpJyunthWjCS6qzW6vd6K+X8kCK9QPTmwmX+9JjGCy6H0uselfDo2
         0ohNN2yRL0XOoA4BrIvU7hto+oKwemcr6iN+jJzuZwj68eYoxJvr3x58hM+W1Ruibhlv
         HVOX7WK8Wmie7uVP/JApNxlmnsHzboEPe+Fh7Q2TrLxd/SoqYOQXV46ttXmz5IySAHYk
         etB1Qgnd2mEgyBrccLZ+KHWeL9kZeORnlCthbfJY+bD0386AuTUnPmXpfhlpEYCQnjU0
         /eJQZdr3GL92nmr7xoazKBtDD5ir3DwTiOY/8YXXE2GxyijNSqQljXS/4bF3yUCK5dZQ
         I2bg==
X-Forwarded-Encrypted: i=1; AJvYcCURmlSQ+tATMy/UNo27GgGyWHVZgWlVC1T1D9MFjV5hOAPW6GHhLnHiDbrYNL+i4z5bQu7IR0PkDvK7@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAq+3kpEohryd6hTwezD4I/u7TcL+fIBY/P+2n0BWq/q1BTNV
	SPnxvRKgzdFyj+gjq8fWUO++/boznlJmqFfh6ahnwNhmDtd8kWfmDvj1
X-Gm-Gg: AZuq6aL4/Fyyb6yupvEUO4tMkWXhTRQFpULstIlvUh+HFI+47AD2npqxX3HkaUkx/hp
	knQo484sStrp5u06uiTE4P4oi80QwINpgqAfUI7hnALWjQwSd/Ed+XHb0MTzTZ4Aqq2MDvh9xuB
	l3mqQ+6WxcNewFmQeWmXhpGI7/K0I8+smf4L97QUVQlwna1p6/m2hwU3jnkn5rqoa2D9zbZu27I
	w3UFxsOhJ4aZsjoiZfz/12uAd4AKlwpYz1owq6MhbnAR+A6qnQCSpOpWapyiCfjQs3QORENePoa
	pHFDVzAhFWkGjpubUuDIxrfDTXN0R4/1VmBCchHF23j7sEyBkJI2KDctAPAgx4hyG+uv/1Ojl/k
	ekTz97AMaU68mVd84LqqTq8nrvOsziBxw3Zou4RebGaBU8yG3Nv7Yc8pr9WPlWYED0Fbbb1MjjO
	+EzLpRIbpeqT8ctHnw2HwrCNJUsvquVoXuPVwGlu16Y7tJtNPHo/kUC64lzRqSPdFiGb7WKGBfw
	ZiYZdfU8R8=
X-Received: by 2002:ac8:7e8b:0:b0:4ee:1727:10bb with SMTP id d75a77b69052e-506b403773bmr261797501cf.73.1771535069261;
        Thu, 19 Feb 2026 13:04:29 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506b275d59fsm153971511cf.32.2026.02.19.13.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:04:28 -0800 (PST)
From: Mithil Bavishi <bavishimithil@gmail.com>
To: aaro.koskinen@iki.fi,
	airlied@gmail.com,
	andreas@kemnade.info,
	conor+dt@kernel.org,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	khilman@baylibre.com,
	krzk+dt@kernel.org,
	laurent.pinchart@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	jesszhan0024@gmail.com,
	rfoss@kernel.org,
	robh@kernel.org,
	rogerq@kernel.org,
	simona@ffwll.ch,
	thierry.reding@gmail.com,
	tony@atomide.com,
	tzimmermann@suse.de,
	andrzej.hajda@intel.com,
	bavishimithil@gmail.com
Cc: devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [PATCH v6 5/8] ARM: dts: ti: omap: espresso-common: Add common device tree for Samsung Galaxy Tab 2 series
Date: Thu, 19 Feb 2026 16:04:04 -0500
Message-ID: <20260219210408.5451-6-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219210408.5451-1-bavishimithil@gmail.com>
References: <20260219210408.5451-1-bavishimithil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create common device tree for Samsung Espresso series devices

Let's create a common tree for all the variants first, later we can
device specific trees based on their screen sizes

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 .../omap/omap4-samsung-espresso-common.dtsi   | 753 ++++++++++++++++++
 1 file changed, 753 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi

diff --git a/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
new file mode 100644
index 000000000..ab8e5f39d
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
@@ -0,0 +1,753 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/dts-v1/;
+#include "dt-bindings/gpio/gpio.h"
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/input/input.h>
+#include "omap443x.dtsi"
+
+/ {
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>; /* 1 GB */
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		continuous_splash: framebuffer@bef00000{
+			reg = <0xbef00000 (1024 * 600 * 4)>;
+			no-map;
+		};
+	};
+
+	chosen {
+		stdout-path = &uart3;
+		#address-cells = <1>;
+	};
+
+	i2c-gpio5 {
+		compatible = "i2c-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c5_pins>;
+		sda-gpios = <&gpio4 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpio4 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* TODO: SMB136 Charger for 7" variant at 0x4d */
+	};
+
+	i2c-gpio6 {
+		compatible = "i2c-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c6_pins>;
+		sda-gpios = <&gpio3 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpio3 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* TODO: STMPE811 ADC at 0x41 */
+	};
+
+	i2c-gpio7 {
+		compatible = "i2c-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c7_pins>;
+		sda-gpios = <&gpio2 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpio2 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		i2c-gpio,delay-us = <3>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		fuel-gauge@36 {
+			compatible = "maxim,max17042";
+			reg = <0x36>;
+			pinctrl-0 = <&fuel_alert_irq>;
+			pinctrl-names = "default";
+			interrupt-parent = <&gpio2>;
+			interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+			maxim,rsns-microohm = <10000>;
+			maxim,over-heat-temp = <500>;
+			maxim,dead-volt = <2500>;
+			maxim,over-volt = <4300>;
+		};
+	};
+
+	reg_espresso_wlan: regulator-espresso-wlan {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlanen_gpio>;
+		compatible = "regulator-fixed";
+		regulator-name = "espresso_wlan";
+		regulator-max-microvolt = <2000000>;
+		regulator-min-microvolt = <2000000>;
+		gpio = <&gpio4 8 GPIO_ACTIVE_HIGH>; /* GPIO_104 */
+		startup-delay-us = <70000>;
+		regulator-always-on;
+		enable-active-high;
+	};
+
+	wlan_pwrseq: wlan-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&twl 0>;
+		clock-names = "ext_clock";
+	};
+
+	reg_espresso_internal: regulator-espresso-internal {
+		compatible = "regulator-fixed";
+		regulator-name = "eMMC_LDO";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>; /* GPIO_63 */
+		startup-delay-us = <100000>;
+		regulator-boot-on;
+		regulator-always-on;
+		enable-active-high;
+	};
+
+	reg_espresso_external: regulator-espresso-external {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc1";
+		regulator-max-microvolt = <2800000>;
+		regulator-min-microvolt = <2800000>;
+		gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>; /* GPIO_34 */
+		enable-active-high;
+	};
+
+	reg_touch_ldo_en: regulator-touch-ldo-en  {
+		compatible = "regulator-fixed";
+		regulator-name = "touch_ldo_en";
+		regulator-max-microvolt = <2800000>;
+		regulator-min-microvolt = <2800000>;
+		gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>; /* GPIO_54 */
+		regulator-always-on;
+		enable-active-high;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys>;
+
+		key-power {
+			label = "power";
+
+			gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>; /* GPIO_wk3 */
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+
+		button-volup {
+			linux,code = <KEY_VOLUMEUP>;
+			label = "volume_up"; /* GPIO_wk30 */
+			gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
+		};
+
+		button-voldown {
+			linux,code = <KEY_VOLUMEDOWN>;
+			label = "volume_down"; /* GPIO_wk8 */
+			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	reg_lcd: regulator-lcd	{
+		compatible = "regulator-fixed";
+		regulator-name = "lcd_en";
+		gpios = <&gpio5 7 GPIO_ACTIVE_HIGH>; /* GPIO_135 */
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+
+	pwm10: pwm-10 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm10_default>;
+		compatible = "ti,omap-dmtimer-pwm";
+		#pwm-cells = <3>;
+		ti,timers = <&timer10>;
+		ti,clock-source = <0x00>;
+	};
+
+	lvds-encoder {
+		compatible = "doestek,dtc34lm85am", "lvds-encoder";
+		powerdown-gpios = <&gpio5 8 GPIO_ACTIVE_LOW>; /* GPIO_136 */
+		power-supply = <&reg_lcd>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				bridge_in: endpoint {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				bridge_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+		};
+	};
+
+	vibrator {
+		compatible = "gpio-vibrator";
+		enable-gpios = <&gpio2 6 GPIO_ACTIVE_HIGH>; /* GPIO_38 */
+		pinctrl-names = "default";
+		pinctrl-0 = <&vibrator_default>;
+	};
+
+	gp2a_shunt: current-sense-shunt {
+		compatible = "current-sense-shunt";
+		io-channels = <&gpadc 4>;
+		shunt-resistor-micro-ohms = <24000000>; /* 24 ohms */
+		#io-channel-cells = <0>;
+	};
+
+	led-ir {
+		compatible = "gpio-ir-tx";
+		gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>; /* GPIO_59 */
+		pinctrl-names = "default";
+		pinctrl-0 = <&ledir_pins>;
+	};
+};
+
+&omap4_pmx_wkup {
+	gpio_keys: gpio-keys-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x046, WAKEUP_EN | PIN_INPUT | MUX_MODE3)
+			/* sim_cd.gpio_wk3 - EXT_WAKEUP */
+			OMAP4_IOPAD(0x056, WAKEUP_EN | PIN_INPUT | MUX_MODE3)
+			/* fref_clk3_req.gpio_wk30 - VOL_UP */
+			OMAP4_IOPAD(0x05C, WAKEUP_EN | PIN_INPUT | MUX_MODE3)
+			/* fref_clk4_out.gpio_wk8 - VOL_DN */
+		>;
+	};
+
+	prox_irq: prox-irq-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x042, WAKEUP_EN | PIN_INPUT_PULLUP | MUX_MODE3)
+			/* sim_clk.gpio_wk1 - PS_VOUT */
+		>;
+	};
+};
+
+&omap4_pmx_core {
+	backlight_pins: pinmux-backlight-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0X0D8, PIN_OUTPUT | PIN_OFF_OUTPUT_LOW | MUX_MODE3)
+			/* usbb1_ulpitll_dat7.gpio_95 - LED_BACKLIGHT_RESET */
+		>;
+	};
+
+	bluetooth_pins: pinmux-bluetooth-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x094, PIN_OUTPUT | MUX_MODE3)
+			/* gpmc_ncs6.gpio_103 - BT_EN */
+			OMAP4_IOPAD(0x0be, PIN_OUTPUT | MUX_MODE3)
+			/* cam_strobe.gpio_82 - BT_nRST */
+			OMAP4_IOPAD(0x0c0, PIN_INPUT | MUX_MODE3)
+			/* cam_globalreset.gpio_83 - BT_HOST_WAKE */
+			OMAP4_IOPAD(0x0d4, PIN_OUTPUT | MUX_MODE3)
+			/* usbb1_ulpitll_dat5.gpio_93 - BT_WAKE */
+		>;
+	};
+
+	dss_dpi_pins: pinmux-dss-dpi-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x162, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data23 */
+			OMAP4_IOPAD(0x164, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data22 */
+			OMAP4_IOPAD(0x166, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data21 */
+			OMAP4_IOPAD(0x168, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data20 */
+			OMAP4_IOPAD(0x16a, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data19 */
+			OMAP4_IOPAD(0x16c, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data18 */
+			OMAP4_IOPAD(0x16e, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data15 */
+			OMAP4_IOPAD(0x170, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data14 */
+			OMAP4_IOPAD(0x172, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data13 */
+			OMAP4_IOPAD(0x174, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data12 */
+			OMAP4_IOPAD(0x176, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data11 */
+			OMAP4_IOPAD(0x1b4, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data10 */
+			OMAP4_IOPAD(0x1b6, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data9 */
+			OMAP4_IOPAD(0x1b8, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data16 */
+			OMAP4_IOPAD(0x1ba, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data17 */
+			OMAP4_IOPAD(0x1bc, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_hsync */
+			OMAP4_IOPAD(0x1be, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_pclk */
+			OMAP4_IOPAD(0x1c0, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_vsync */
+			OMAP4_IOPAD(0x1c2, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_de */
+			OMAP4_IOPAD(0x1c4, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data8 */
+			OMAP4_IOPAD(0x1c6, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data7 */
+			OMAP4_IOPAD(0x1c8, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data6 */
+			OMAP4_IOPAD(0x1ca, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data5 */
+			OMAP4_IOPAD(0x1cc, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data4 */
+			OMAP4_IOPAD(0x1ce, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data3 */
+
+			OMAP4_IOPAD(0x1d0, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data2 */
+			OMAP4_IOPAD(0x1d2, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data1 */
+			OMAP4_IOPAD(0x1d4, PIN_OFF_OUTPUT_LOW | MUX_MODE5)
+			/* dispc2_data0 */
+		>;
+	};
+
+	fuel_alert_irq: pinmux-fuel-alert-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x068, PIN_INPUT_PULLUP | MUX_MODE3)
+			/* gpmc_a20.gpio_44 */
+		>;
+	};
+
+	i2c1_pins: pinmux-i2c1-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x122, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* i2c1_scl */
+			OMAP4_IOPAD(0x124, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* i2c1_sda */
+		>;
+	};
+
+	i2c2_pins: pinmux-i2c2-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x126, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* i2c2_scl */
+			OMAP4_IOPAD(0x128, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* i2c2_sda */
+		>;
+	};
+
+	i2c3_pins: pinmux-i2c3-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x12a, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* i2c3_scl */
+			OMAP4_IOPAD(0x12c, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* i2c3_sda */
+		>;
+	};
+
+	i2c4_pins: pinmux-i2c4-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x12e, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* i2c4_scl */
+			OMAP4_IOPAD(0x130, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* i2c4_sda */
+		>;
+	};
+
+	i2c5_pins: pinmux-i2c5-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x0de, PIN_INPUT_PULLUP | MUX_MODE3)
+			/* usbc1_icusb_dp.gpio_98 */
+			OMAP4_IOPAD(0x0e0, PIN_INPUT_PULLUP | MUX_MODE3)
+			/* usbc1_icusb_dm.gpio_99 */
+		>;
+	};
+
+	i2c6_pins: pinmux-i2c6-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x09c, PIN_INPUT_PULLUP | MUX_MODE3)
+			/* hdmi_ddc_scl.gpio_65 */
+			OMAP4_IOPAD(0x09e, PIN_INPUT_PULLUP | MUX_MODE3)
+			/* hdmi_ddc_sda.gpio_66 */
+		>;
+	};
+
+	i2c7_pins: pinmux-i2c7-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x08a, PIN_INPUT_PULLUP | MUX_MODE3)
+			/* gpmc_wait0.gpio_61 */
+			OMAP4_IOPAD(0x08c, PIN_INPUT_PULLUP | MUX_MODE3)
+			/* gpmc_wait1.gpio_62 */
+		>;
+	};
+
+	ledir_pins: pimux-ledir-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x086, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			/* gpmc_nbe0_cle.gpio_59 */
+			OMAP4_IOPAD(0x156, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			/* mcspi4_simo.gpio_152 */
+		>;
+	};
+
+	lvds_pins: pinmux-lvds-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0X136, PIN_OUTPUT | MUX_MODE3)
+			/* mcspi1_simo.gpio_136 - LVDS_nSHDN */
+		>;
+	};
+
+	mmc1_pins: pinmux-mmc1-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x0e2, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			/* sdmmc1_clk */
+			OMAP4_IOPAD(0x0e4, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* sdmcc1_cmd */
+			OMAP4_IOPAD(0x0e6, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* sdmcc1_dat0 */
+			OMAP4_IOPAD(0x0e8, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* sdmmc1_dat1 */
+			OMAP4_IOPAD(0x0ea, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* sdmmc1_dat2 */
+			OMAP4_IOPAD(0x0ec, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* sdmmc1_dat3 */
+		>;
+	};
+
+	mmc2_pins: pinmux-mmc2-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x040, PIN_INPUT_PULLUP | MUX_MODE1)
+			/* sdmmc2_dat0 */
+			OMAP4_IOPAD(0x042, PIN_INPUT_PULLUP | MUX_MODE1)
+			/* sdmmc2_dat1 */
+			OMAP4_IOPAD(0x044, PIN_INPUT_PULLUP | MUX_MODE1)
+			/* sdmmc2_dat2 */
+			OMAP4_IOPAD(0x046, PIN_INPUT_PULLUP | MUX_MODE1)
+			/* sdmmc2_dat3 */
+			OMAP4_IOPAD(0x048, PIN_INPUT_PULLUP | MUX_MODE1)
+			/* sdmmc2_dat4 */
+			OMAP4_IOPAD(0x04a, PIN_INPUT_PULLUP | MUX_MODE1)
+			/* sdmmc2_dat5 */
+			OMAP4_IOPAD(0x04c, PIN_INPUT_PULLUP | MUX_MODE1)
+			/* sdmmc2_dat6 */
+			OMAP4_IOPAD(0x04e, PIN_INPUT_PULLUP | MUX_MODE1)
+			/* sdmmc2_dat7 */
+			OMAP4_IOPAD(0x082, PIN_INPUT_PULLUP | MUX_MODE1)
+			/* sdmmc2_clk */
+			OMAP4_IOPAD(0x084, PIN_INPUT_PULLUP | MUX_MODE1)
+			/* sdmmc2_cmd */
+		>;
+	};
+
+	mmc5_pins: pinmux-mmc5-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x148, PIN_INPUT_PULLDOWN | MUX_MODE0)
+			/* sdmmc5_clk.sdmmc5_clk */
+			OMAP4_IOPAD(0x14a, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* sdmmc5_cmd.sdmmc5_cmd */
+			OMAP4_IOPAD(0x14c, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* sdmmc5_dat0.sdmmc5_dat0 */
+			OMAP4_IOPAD(0x14e, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* sdmmc5_dat1.sdmmc5_dat1 */
+			OMAP4_IOPAD(0x150, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* sdmmc5_dat2.sdmmc5_dat2 */
+			OMAP4_IOPAD(0x152, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* sdmmc5_dat3.sdmmc5_dat3 */
+		>;
+	};
+
+	pwm10_default: pinmux-pwm10-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0X0D6, PIN_OUTPUT | PIN_OFF_OUTPUT_LOW | MUX_MODE1)
+			/* usbb1_ulpitll_dat6.dmtimer10_pwm_evt - LED_BACKLIGHT_PWM */
+		>;
+	};
+
+	touch_pins: pinmux-touch-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x06c, PIN_INPUT | MUX_MODE3)
+			/* gpmc_a22.gpio_46 - TSP_INT */
+		>;
+	};
+
+	uart2_pins: pinmux-uart2-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x118, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* uart2_cts.uart2_cts */
+			OMAP4_IOPAD(0x11a, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* uart2_rts.uart2_rts */
+			OMAP4_IOPAD(0x11c, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* uart2_rx.uart2_rx */
+			OMAP4_IOPAD(0x11e, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* uart2_tx.uart2_tx */
+		>;
+	};
+
+	uart3_pins: pinmux-uart3-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x144, PIN_INPUT | MUX_MODE0)
+			/* uart3_rx_irrx */
+			OMAP4_IOPAD(0x146, PIN_OUTPUT | MUX_MODE0)
+			/* uart3_tx_irtx */
+		>;
+	};
+
+	vibrator_default: pinmux-vibrator-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x05c, PIN_INPUT_PULLDOWN | MUX_MODE3)
+			/* gpmc_ad14.gpio_38 - MOTOR_EN */
+		>;
+	};
+
+	wlanen_gpio: pinmux-wlanen-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x096, PIN_OUTPUT | MUX_MODE3)
+			/* gpmc_ncs7.gpio_104 */
+		>;
+	};
+
+	wlan_host_wake: pinmux-wlan-host-wake-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x0bc, PIN_INPUT | MUX_MODE3)
+			/* cam_shutter.gpio_81 - WLAN_HOST_WAKE */
+		>;
+	};
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+
+	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
+				   &omap4_pmx_core OMAP4_UART3_RX>;
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	clock-frequency = <400000>;
+
+	twl: pmic@48 {
+		reg = <0x48>;
+		#clock-cells = <1>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <
+			&twl6030_pins
+			&twl6030_wkup_pins
+		>;
+
+		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
+		interrupt-parent = <&gic>;
+		system-power-controller;
+	};
+};
+
+#include "twl6032.dtsi"
+#include "twl6030_omap4.dtsi"
+
+&ldo1 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-always-on;
+	regulator-state-mem {
+		regulator-off-in-suspend;
+	};
+};
+
+&ldo3 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-always-on;
+	regulator-state-mem {
+		regulator-off-in-suspend;
+	};
+};
+
+&ldo4 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-always-on;
+};
+
+&ldo5 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-always-on;
+};
+
+&ldo6 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-always-on;
+	regulator-state-mem {
+		regulator-off-in-suspend;
+	};
+};
+
+&smps4 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-always-on;
+};
+
+&ldousb {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-always-on;
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+
+	accelerometer@18 {
+		compatible = "bosch,bma254";
+		reg = <0x18>;
+		vdd-supply = <&ldo4>;
+		vddio-supply = <&ldo5>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <25 (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_EDGE_RISING)>,
+			<26 (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_EDGE_RISING)>;
+	};
+
+	magnetometer@2e {
+		compatible = "yamaha,yas530";
+		reg = <0x2e>;
+		vdd-supply = <&ldo4>;
+		iovdd-supply = <&ldo5>;
+		reset-gpios = <&gpio5 29 GPIO_ACTIVE_LOW>;
+		interrupts = <&gpio6 10 IRQ_TYPE_EDGE_RISING>;
+	};
+
+	light-sensor@44 {
+		compatible = "sharp,gp2ap002a00f";
+		reg = <0x44>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&ldo4>;
+		vio-supply = <&ldo4>;
+		io-channels = <&gp2a_shunt>;
+		io-channel-names = "alsout";
+		sharp,proximity-far-hysteresis = /bits/ 8 <0x40>;
+		sharp,proximity-close-hysteresis = /bits/ 8 <0x20>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&prox_irq>;
+	};
+};
+
+&dss {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss_dpi_pins>;
+
+	port {
+		dpi_out: endpoint {
+			remote-endpoint = <&bridge_in>;
+			data-lines = <24>;
+		};
+	};
+};
+
+&twl_usb_comparator {
+	usb-supply = <&ldousb>;
+};
+
+&usb_otg_hs {
+	interface-type = <1>;
+	mode = <3>;
+	power = <50>;
+};
+
+&mmc1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+
+	vmmc-supply = <&reg_espresso_external>;
+	bus-width = <4>;
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+
+	vmmc-supply = <&reg_espresso_internal>;
+	ti,non-removable;
+	bus-width = <8>;
+};
+
+&mmc3 {
+	status = "disabled";
+};
+
+&mmc4 {
+	status = "disabled";
+};
+
+&mmc5 {
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	non-removable;
+	bus-width = <4>;
+	vmmc-supply = <&reg_espresso_wlan>;
+	mmc-pwrseq = <&wlan_pwrseq>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc5_pins>;
+
+	brcmf: wifi@1 {
+		compatible = "brcm,bcm4330-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+
+		interrupt-parent = <&gpio3>;
+		interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_host_wake>;
+	};
+};
+
+&uart2 {
+	interrupts-extended = <&wakeupgen GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
+				&omap4_pmx_core OMAP4_UART2_RX>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	bluetooth {
+		compatible = "brcm,bcm4330-bt";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bluetooth_pins>;
+		shutdown-gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio3 18 GPIO_ACTIVE_LOW>;
+		device-wakeup-gpios = <&gpio3 29 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "host-wakeup";
+	};
+};
-- 
2.43.0

