Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5CC46EF64
	for <linux-omap@vger.kernel.org>; Tue,  1 Sep 2026 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298960; cv=none; b=ELxdRTkEsDWfbJkvdwXkz46rihYMVKy+svPqRoFZImeY8d2JrwrVc/cXCCxltKizWeGAUWAoF9evciR5JlQLItEr89o5v/CVWN2P9BW9Com/MU40pH7wNyhLByidN2gnhA2jwo9E27IGBcErqw1ZtKd16Oe02tqMzc31q9CnCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298960; c=relaxed/simple;
	bh=2MQajOnTHQy9cxT4/OCsw/3Iyn4dIFt4qbmTlxBoqlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NaTXBCBSr/o3LWDd8o7DSv6/7/Ax3MYSm0TaFqL4arIiypEHacivej4Eoe53dOfoM/sZpogCo1LnI3HN3MZPXY0Qw2ylrrXe+hfdtD2EaKmN5v5vt2UOtQ9AsBo1+ELpuvfOP+VYxqVKNNAKQyLzmzPMrTv52rEB8O1C/+viEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nzsuqkj4; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nzsuqkj4"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6b1b233ca8dso176057eaf.2
        for <linux-omap@vger.kernel.org>; Tue, 01 Sep 2026 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788298958; x=1788903758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eDNui4atyj0kDkC+/FQwy6wqM5dKgLTfE/zfJmh8ukw=;
        b=Nzsuqkj4S/xTLqjOKEAa4k23CfO9GGUrKMYureafEZM/wZYBHL+WVqlrVm+eaeOcMA
         gfcARoXs6VoY4bKjbQfBdmusHoxY138RgOcL/8JJmyOlWeHEX/sqMWEIMAWCAoTpEP2o
         bkrTCro9cSSDOoXCTnk5oQy+tjVfpGOIdemlgB9AfpheY+LPoE36WSj1wf1D+HQO+05v
         G9QTdPtKLlBzieO6/o6JZi60TxFVdkHSLL9tzK9Zw/04L1Fgesy1CB8F/ThDs5aHrGtm
         yeCcZJnccHJYB+cTbwbBXP0rQmH98Y9dZhDo5WKkr8xfd97oB4PHjyEze1HkPM/B3CtT
         ifNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298958; x=1788903758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eDNui4atyj0kDkC+/FQwy6wqM5dKgLTfE/zfJmh8ukw=;
        b=cm9dGv65wVytGHL11fkMLblxf09yglIouk6MJvLOwvRXm3f5pnNwafjmHlGu6Mo1SL
         OKzpvA3/yCpoKbaoGYCItNcswvN7F9KHXMZMSHGcS8YMhV+llTxfIHC7iNEpFvebl9wP
         UGmnxFhf7YCGo88O4YoDkUeYMCh81uWzV8sPzyPTk75SkIkulVB/mVOFGQljI+siEAHJ
         ivGWoPYCvhmRNr0cqqXN764qmlHyF8DczTwxqdIh8QkFy/eaVQ52JNaskEOxeRIyNpdF
         pbVgQVOXnfdnBuzLRaGFXyguljAHhHDM6CUubx366WD5/EBYvcx0ZoP6wxvDcf5fvcqz
         W3Qg==
X-Gm-Message-State: AFuF++lfONnO9auwaSmVPqV8J2TkV5D2mJ7cKb6nAAsnQ68bleGIzdCs
	5dOwmv8d0wnZezuDFG+1Pp+gjxNaI45kz5u2LYyF4uLq/nU3IXvSjyou
X-Gm-Gg: AR+sD11wv2Qg+S2zINhwJmqiPI6vgorDVhJmobRvyqJWkYxYPhDZFmPYgjOmQ59OpE5
	B2cEPlzfHDCz4nc6NQoVMNtr9QSh2Q11DZGdp5pjJrxFHut5uXxYvJjcikyQSg4ChQ/Lmo9s7yP
	6r4BwqTBZn68MAXV9rJ08yVyW8ef+gd3CbNaFu/gjTbm64b7ZolicbpnZYDdgV6JGmJ+Nt31bZO
	Tl1nK2QT202ECIFMU8hTjI99Zn/g6ih9X/7cQ1HtJbvdJvAAkXxxDiGZ32vexmLrtuer1JQyfpo
	BzfPzBSLO2nbIxpziI4JK5r6dTP7pmFi9oLdMbDAStCmQLshlf7ioduyL2+i+ybk0WLJ35rAN0b
	qtLvp5D9t4Lr0dfCsAdaich9IR2z88VuPiM6oYJHCtyrIBwmikVGzQGG26QAJBHYXqtxR4EhZ83
	dT9WupRrnBwEuw9Zo6t1GHpQAWBbR1o+3P224spIxCzg3itQaRjqqNdglxmMgxlvLYb9cFHcmCS
	qd3t5HGa3CLdAkwtCOWtjU/HRx8nzS+gh9JAT1G5wLVANuM6JTsIjzGpoaOeuxLuxLxgdiHjNfe
	fKAJZpJZZfw81Gb8kIegznV22blvWbum8t28AXct++ca4w==
X-Received: by 2002:a05:6820:4b83:b0:6b4:96b:3e12 with SMTP id 006d021491bc7-6b4386c3971mr1447356eaf.23.1788298955076;
        Tue, 01 Sep 2026 14:42:35 -0700 (PDT)
Received: from [127.0.1.1] (140-186-136-19-dynamic.midco.net. [140.186.136.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b40ba648f6sm1094703eaf.2.2026.09.01.14.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:42:34 -0700 (PDT)
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 01 Sep 2026 16:42:22 -0500
Subject: [PATCH 2/3] arm: dts: omap: Add support for BeagleBone Black RevD
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-v7-3-rc1-beaglebone-black-revd-v1-2-f521950b777a@gmail.com>
References: <20260901-v7-3-rc1-beaglebone-black-revd-v1-0-f521950b777a@gmail.com>
In-Reply-To: <20260901-v7-3-rc1-beaglebone-black-revd-v1-0-f521950b777a@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jason Kridner <jkridner@beagleboard.org>, 
 Deepak Khatri <lorforlinux@beagleboard.org>, 
 Ayush Singh <ayush@beagleboard.org>, 
 Robert Nelson <robertcnelson@gmail.com>
X-Mailer: b4 0.15.2

The BeagleBoard.org BeagleBone Black RevD and Industrial (00D0/EID0) are
redesigns of the BeagleBone Black Rev C3. They feature an IT66122 HDMI PHY to
replace the EOL NXP TDA19988. Additionally, these models include a larger eMMC
capacity to address the limited availability of 4GB modules.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 arch/arm/boot/dts/ti/omap/Makefile                 |   1 +
 .../dts/ti/omap/am335x-boneblack-ite-hdmi.dtsi     | 184 +++++++++++++++++++++
 .../arm/boot/dts/ti/omap/am335x-boneblack-revd.dts | 166 +++++++++++++++++++
 3 files changed, 351 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index 498c36ccb5ea..55cab3e8a05c 100644
--- a/arch/arm/boot/dts/ti/omap/Makefile
+++ b/arch/arm/boot/dts/ti/omap/Makefile
@@ -97,6 +97,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-baltos-ir5221.dtb \
 	am335x-bone.dtb \
 	am335x-boneblack.dtb \
+	am335x-boneblack-revd.dtb \
 	am335x-boneblack-wireless.dtb \
 	am335x-boneblue.dtb \
 	am335x-bonegreen.dtb \
diff --git a/arch/arm/boot/dts/ti/omap/am335x-boneblack-ite-hdmi.dtsi b/arch/arm/boot/dts/ti/omap/am335x-boneblack-ite-hdmi.dtsi
new file mode 100644
index 000000000000..77dd7d9aa57d
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/am335x-boneblack-ite-hdmi.dtsi
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * https://github.com/beagleboard/beaglebone-black
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2026 Robert Nelson, BeagleBoard.org Foundation
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	connector-hdmi {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&it66122_out>;
+			};
+		};
+	};
+
+	it66122_vcn18_fixed: fixedregulator1 {
+		compatible = "regulator-fixed";
+		regulator-name = "it66122_vcn18_fixed";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	it66122_vcn12_fixed: fixedregulator2 {
+		compatible = "regulator-fixed";
+		regulator-name = "it66122_vcn12_fixed";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+	};
+};
+
+&am33xx_pinmux {
+	nxp_hdmi_bonelt_pins: nxp-hdmi-bonelt-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT_PULLDOWN, MUX_MODE3)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA0, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA10, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA12, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA14, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_PCLK, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+		>;
+	};
+
+	hdmi_gpio_pins_default: hdmi-gpio-default-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLUP, MUX_MODE7)	/* HDMI_INT gpmc_a9.GPIO1_25 */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_OUTPUT_PULLUP, MUX_MODE7) /* HDMI_RESET uart0_rtsn.GPIO1_9 */
+		>;
+	};
+
+	mcasp0_pins: mcasp0-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKX, PIN_INPUT_PULLUP, MUX_MODE0) /* mcasp0_ahcklx.mcasp0_ahclkx */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKR, PIN_OUTPUT_PULLDOWN, MUX_MODE2) /* mcasp0_ahclkr.mcasp0_axr2*/
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSX, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKX, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A11, PIN_OUTPUT_PULLDOWN, MUX_MODE7) /* gpmc_a11.GPIO1_27 */
+		>;
+	};
+};
+
+&lcdc {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&nxp_hdmi_bonelt_pins>;
+
+	/* If you want to get 24 bit RGB and 16 BGR mode instead of
+	 * current 16 bit RGB and 24 BGR modes, set the propety
+	 * below to "crossed" and uncomment the video-ports -property
+	 * in tda19988 node.
+	 */
+	blue-and-red-wiring = "straight";
+
+	port {
+		lcdc_0: endpoint@0 {
+			remote-endpoint = <&it66122_in>;
+		};
+	};
+};
+
+&i2c0 {
+	it66122: bridge-hdmi@4c {
+		compatible = "ite,it66122";
+		reg = <0x4c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_gpio_pins_default>;
+		vcn33-supply = <&vmmcsd_fixed>;
+		vcn18-supply = <&it66122_vcn18_fixed>;
+		vrf12-supply = <&it66122_vcn12_fixed>;
+		reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+		#sound-dai-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				it66122_in: endpoint {
+					bus-width = <24>;
+					remote-endpoint = <&lcdc_0>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				it66122_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
+
+&mcasp0 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcasp0_pins>;
+	status = "okay";
+	op-mode = <0>;	/* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	serial-dir = <	/* 0: INACTIVE, 1: TX, 2: RX */
+			0 0 1 0
+		>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};
+
+/ {
+	clk_mcasp0_fixed: clk_mcasp0_fixed {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24576000>;
+	};
+
+	clk_mcasp0: clk_mcasp0 {
+		#clock-cells = <0>;
+		compatible = "gpio-gate-clock";
+		clocks = <&clk_mcasp0_fixed>;
+		enable-gpios = <&gpio1 27 0>; /* BeagleBone Black Clk enable on GPIO1_27 */
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "TI BeagleBone Black";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink0_master>;
+		simple-audio-card,frame-master = <&dailink0_master>;
+
+		dailink0_master: simple-audio-card,cpu {
+			sound-dai = <&mcasp0>;
+			clocks = <&clk_mcasp0>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&it66122>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/ti/omap/am335x-boneblack-revd.dts b/arch/arm/boot/dts/ti/omap/am335x-boneblack-revd.dts
new file mode 100644
index 000000000000..fe9536d5f55e
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/am335x-boneblack-revd.dts
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * https://github.com/beagleboard/beaglebone-black
+ *
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2026 Robert Nelson, BeagleBoard.org Foundation
+ */
+/dts-v1/;
+
+#include "am33xx.dtsi"
+#include "am335x-bone-common.dtsi"
+#include "am335x-boneblack-common.dtsi"
+#include "am335x-boneblack-ite-hdmi.dtsi"
+
+/ {
+	model = "TI AM335x BeagleBone Black Rev D";
+	compatible = "beagle,am335x-bone-black-revd", "ti,am33xx";
+};
+
+&gpio0 {
+	gpio-line-names =
+		"[mdio_data]",
+		"[mdio_clk]",
+		"P9_22 [spi0_sclk]",
+		"P9_21 [spi0_d0]",
+		"P9_18 [spi0_d1]",
+		"P9_17 [spi0_cs0]",
+		"[mmc0_cd]",
+		"P9_42A [ecappwm0]",
+		"P8_35 [lcd d12]",
+		"P8_33 [lcd d13]",
+		"P8_31 [lcd d14]",
+		"P8_32 [lcd d15]",
+		"P9_20 [i2c2_sda]",
+		"P9_19 [i2c2_scl]",
+		"P9_26 [uart1_rxd]",
+		"P9_24 [uart1_txd]",
+		"[rmii1_txd3]",
+		"[rmii1_txd2]",
+		"[usb0_drvvbus]",
+		"[hdmi cec]",
+		"P9_41B",
+		"[rmii1_txd1]",
+		"P8_19 [ehrpwm2a]",
+		"P8_13 [ehrpwm2b]",
+		"NC",
+		"NC",
+		"P8_14",
+		"P8_17",
+		"[rmii1_txd0]",
+		"[rmii1_refclk]",
+		"P9_11 [uart4_rxd]",
+		"P9_13 [uart4_txd]";
+};
+
+&gpio1 {
+	gpio-line-names =
+		"P8_25 [mmc1_dat0]",
+		"[mmc1_dat1]",
+		"P8_5 [mmc1_dat2]",
+		"P8_6 [mmc1_dat3]",
+		"P8_23 [mmc1_dat4]",
+		"P8_22 [mmc1_dat5]",
+		"P8_3 [mmc1_dat6]",
+		"P8_4 [mmc1_dat7]",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"P8_12",
+		"P8_11",
+		"P8_16",
+		"P8_15",
+		"P9_15A",
+		"P9_23",
+		"P9_14 [ehrpwm1a]",
+		"P9_16 [ehrpwm1b]",
+		"[emmc rst]",
+		"[usr0 led]",
+		"[usr1 led]",
+		"[usr2 led]",
+		"[usr3 led]",
+		"[hdmi irq]",
+		"[usb vbus oc]",
+		"[hdmi audio]",
+		"P9_12",
+		"P8_26",
+		"P8_21 [emmc]",
+		"P8_20 [emmc]";
+};
+
+&gpio2 {
+	gpio-line-names =
+		"P9_15B",
+		"P8_18",
+		"P8_7",
+		"P8_8",
+		"P8_10",
+		"P8_9",
+		"P8_45 [hdmi]",
+		"P8_46 [hdmi]",
+		"P8_43 [hdmi]",
+		"P8_44 [hdmi]",
+		"P8_41 [hdmi]",
+		"P8_42 [hdmi]",
+		"P8_39 [hdmi]",
+		"P8_40 [hdmi]",
+		"P8_37 [hdmi]",
+		"P8_38 [hdmi]",
+		"P8_36 [hdmi]",
+		"P8_34 [hdmi]",
+		"[rmii1_rxd3]",
+		"[rmii1_rxd2]",
+		"[rmii1_rxd1]",
+		"[rmii1_rxd0]",
+		"P8_27 [hdmi]",
+		"P8_29 [hdmi]",
+		"P8_28 [hdmi]",
+		"P8_30 [hdmi]",
+		"[mmc0_dat3]",
+		"[mmc0_dat2]",
+		"[mmc0_dat1]",
+		"[mmc0_dat0]",
+		"[mmc0_clk]",
+		"[mmc0_cmd]";
+};
+
+&gpio3 {
+	gpio-line-names =
+		"[mii col]",
+		"[mii crs]",
+		"[mii rx err]",
+		"[mii tx en]",
+		"[mii rx dv]",
+		"[i2c0 sda]",
+		"[i2c0 scl]",
+		"[jtag emu0]",
+		"[jtag emu1]",
+		"[mii tx clk]",
+		"[mii rx clk]",
+		"NC",
+		"NC",
+		"[usb vbus en]",
+		"P9_31 [spi1_sclk]",
+		"P9_29 [spi1_d0]",
+		"P9_30 [spi1_d1]",
+		"P9_28 [spi1_cs0]",
+		"P9_42B [ecappwm0]",
+		"P9_27",
+		"P9_41A",
+		"P9_25",
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
+&baseboard_eeprom {
+	vcc-supply = <&ldo4_reg>;
+};

-- 
2.55.0

