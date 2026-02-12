Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73970224B05;
	Thu, 12 Feb 2026 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770910102; cv=none; b=fMx5jSeLlVcR8CQU7FIzAX6EtDUYNyHa+tqBJyntIJZA/+i+wOZg8o1hI++a/BuSZ5evJM0JE8Zke+UxY8eowuhDdouqo23zTic26Scu7Kbd84XP5xO0AoYNF2aaSMqn1rJ85/oZKVlRXDeYNRnK54e4DpVNRQy087hPjZEHHhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770910102; c=relaxed/simple;
	bh=G2vQYlLsdINyji1KLabxtiRtHzx45nyqyhItWUnpKao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrckRNF/3JRWQSyCIinnqKR9QELOXCCbnf13Xhj+Gdrp4fkCTek/UDg9Fy0Q22s9iqhZEU4YZz0Ikqeox5Cti4t3jDXtVRR+WSSNfn5HFStZi6x9ZkhW6SFmWidQDuJujDSjARxqEFAqnlEcKS6mFLIHgKP5W+qZ9SbAg5GcmMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e+0pBbPU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e+0pBbPU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3D9644E40CE3;
	Thu, 12 Feb 2026 15:28:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 13C85606CF;
	Thu, 12 Feb 2026 15:28:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6C23511971B2A;
	Thu, 12 Feb 2026 16:28:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770910093; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2Zij+Z4h6O2o9kCfnyrg98WGWWEKH3SEASfeD3RXqf8=;
	b=e+0pBbPU4ompRUN3bLPhtcg/rjp4Y8GEfyOeO3pe7QFkeMNwuxCfMnl5V64usoHBXITa2L
	j9uiGBkz9WpckNwRRDiI98izN0wWZzDgY7+YjqiT7Vtv1CXYRhOHbHUJPT8qk4AOyw2XTa
	mWSJH3DpZFduqi9XA4ADDKQcIQEfRo2GRsXSlf+P738gllBZCS4Co1tWVNxRkNkevX4680
	zTrOpEeBI/Sf/IOx5Uoedkc2T5L/JRlIxxMOkeYj0bYqdmWNMs4IX2iKW1ZUQIcqinuwLb
	JUh/wuX6hTkazcPKkG8svPAAdojzRu5Hh2p2R+2o+cu8dVBLoLbAjqFB479Cww==
From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
Date: Thu, 12 Feb 2026 16:26:19 +0100
Subject: [PATCH 5/5] ARM: dts: am335x: Add Seeed Studio BeagleBone HDMI
 cape overlay
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-feature_bbge-v1-5-29014a212f35@bootlin.com>
References: <20260212-feature_bbge-v1-0-29014a212f35@bootlin.com>
In-Reply-To: <20260212-feature_bbge-v1-0-29014a212f35@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Bajjuri Praneeth <praneeth@ti.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 "Kory Maincent (TI)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev-d4707
X-Last-TLS-Session-Version: TLSv1.3

Add devicetree overlay for the Seeed Studio BeagleBone HDMI cape, which
provides HDMI output via an ITE IT66121 HDMI bridge and audio support
through McASP.

The cape is designed for BeagleBone Green but is also compatible with
BeagleBone and BeagleBone Black due to pin compatibility.

Link: https://www.seeedstudio.com/Seeed-Studio-BeagleBoner-Green-HDMI-Cape.html
Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
---
 arch/arm/boot/dts/ti/omap/Makefile                 |   5 +
 .../boot/dts/ti/omap/am335x-bone-hdmi-00a0.dtso    | 157 +++++++++++++++++++++
 2 files changed, 162 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index 52df04328aff2..23ae6df682206 100644
--- a/arch/arm/boot/dts/ti/omap/Makefile
+++ b/arch/arm/boot/dts/ti/omap/Makefile
@@ -82,6 +82,10 @@ dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-var-stk-om44.dtb \
 	omap4-xyboard-mz609.dtb \
 	omap4-xyboard-mz617.dtb
+
+am335x-bonegreen-hdmi-00a0-dtbs := am335x-bonegreen-eco.dtb \
+	am335x-bone-hdmi-00a0.dtbo
+
 dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-baltos-ir2110.dtb \
 	am335x-baltos-ir3220.dtb \
@@ -94,6 +98,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-bonegreen.dtb \
 	am335x-bonegreen-wireless.dtb \
 	am335x-bonegreen-eco.dtb \
+	am335x-bonegreen-hdmi-00a0.dtb \
 	am335x-chiliboard.dtb \
 	am335x-cm-t335.dtb \
 	am335x-evm.dtb \
diff --git a/arch/arm/boot/dts/ti/omap/am335x-bone-hdmi-00a0.dtso b/arch/arm/boot/dts/ti/omap/am335x-bone-hdmi-00a0.dtso
new file mode 100644
index 0000000000000..f43f44c79c96d
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/am335x-bone-hdmi-00a0.dtso
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * 2017 Copyright (c) Seeed Technology Inc.  All right reserved.
+ * Author: Baozhu Zuo <zuobaozhu@gmail.com>
+ * Copyright (c) Bootlin 2026
+ *
+ * This device tree overlay is compatible with the BeagleBone Black, Green
+ * and their subversions.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/pinctrl/am33xx.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+&{/} {
+	hdmi0: connector-hdmi {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&it66121_out>;
+			};
+		};
+	};
+
+	clk_mcasp0_fixed: clk-mcasp0-fixed {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24576000>;
+	};
+
+	clk_mcasp0: clk-mcasp0 {
+		#clock-cells = <0>;
+		compatible = "gpio-gate-clock";
+		clocks = <&clk_mcasp0_fixed>;
+		enable-gpios = <&gpio1 27 0>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "TI BeagleBone Green HDMI cape";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+
+		sound_master: simple-audio-card,cpu {
+			sound-dai = <&mcasp0>;
+			clocks = <&clk_mcasp0>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&it66121>;
+		};
+	};
+};
+
+&am33xx_pinmux {
+	bb_lcd_pins: pinmux-bb-lcd-pins {
+		pinctrl-single,pins = <
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
+			AM33XX_PADCONF(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_PCLK, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WEN, PIN_INPUT, MUX_MODE7)
+		>;
+	};
+	mcasp0_pins: mcasp0-pins {
+		pinctrl-single,pins = <
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKX, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKR, PIN_OUTPUT_PULLDOWN, MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSX, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKX, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+		>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	it66121: it66121 {
+		compatible = "ite,it66121";
+		reg = <0x4d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bb_lcd_pins>;
+
+		#sound-dai-cells = <0>;
+
+		interrupt-parent = <&gpio2>;
+		interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				it66121_in: endpoint {
+					bus-width = <24>;
+					remote-endpoint = <&lcdc_0>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				it66121_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
+
+&lcdc {
+	status = "okay";
+	blue-and-red-wiring = "straight";
+	port {
+		lcdc_0: endpoint@0 {
+			remote-endpoint = <&it66121_in>;
+		};
+	};
+};
+
+
+&mcasp0 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcasp0_pins>;
+	op-mode = <0>;
+	tdm-slots = <2>;
+	serial-dir = < 0 0 1 0 >;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};
+

-- 
2.43.0

