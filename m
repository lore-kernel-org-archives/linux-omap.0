Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DC83074AE
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665683; cv=none; b=fVLr/O/X+cVM3ieEwtmVIs6jwa/x8lRTtAKwmEePht1H69QoTISSjHhC7u0zzWX3pknCJH8FA3Z6zjZ9Td/htqDDaOtfCuQHeojnkLxXoLA8KlKV59gsNP28jEExrnir41mfX/zUZUwBSPniVu25Zr/CmiPBepXc66nRL3vPBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665683; c=relaxed/simple;
	bh=AUhhKwGaM9grtdftiWmb9K3MniiTndfrY7S51xLJzEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+dpqEuUNRHoSebFft3tUVN7aK+QJna7zkRvp4S7HNPQVmA3JQ7CJUqzdsN8JTBPLOwcO0+LtA0DhZ9V35eKhJkNm9zZQjCasku5pxifptfwYFIbSUa6SpPXsGahYKS2sMuPnlyT3SuziXfM3vLfncp+dfu36MPKCsTW4jPVkRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnsErbun; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnsErbun"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88a2fe9e200so6288066d6.0
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 21:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769665680; x=1770270480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meO53koivOwOs9Bd8q7AbA+V+PS952tTGxoKR0dH/Dg=;
        b=YnsErbunQkmvR9HqirsfDQr1TKpzlo0NAJSbDLJbuIhA0BiyWas3t78+lMJ3hEoirp
         CZFwtO+BLmgFNJ1XrNZBTeUlDK2F/xcA2qrH8wPkguxiPN3nubDrTbD/zF/lWDuYCzjL
         gWbHUJVi8H+aLfYh1YYRNF1knPJtVO/QmN8fdzYuTuUU9WfMkg0VIAcqfGbEQgjkfJ88
         wYvYAR3dVeNPhDqBmLoyDmM5YrR+VpTYXEQvlOIuoR1fU1OS1oLizNqr1w6L6seoyyzr
         JMyl7uUX28WtS+niHtjRtLu1wpVCQKATo+9pGB/z0/UWUR86FBXI7ebgjjwukyLPSHrQ
         /pqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769665680; x=1770270480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=meO53koivOwOs9Bd8q7AbA+V+PS952tTGxoKR0dH/Dg=;
        b=dn5TWY/57Iy08KkOf7ZqiFVrDJ4KhGjDFgzPOdEEd7CuglyYD9XFDnJl+sY4an1uqx
         OHsyzAacOUjpgQpQkIP8HNJtVkYFRQdfiOVitNHVKHVneZdHbusHC+qvzflrYSihDrIT
         Z45rJhiBr2dmCqrY4TE0mKrP5qwmAbG8orsNT7W5kkIgKBbbJveOE2QNWo3VbQme/zsI
         39OP5/ou0O54SGmoNF6kxUo3MyswkWIlXtN8KC+NucxbeO+y8ayFchyp1vus99NYvU7d
         nJ+Y+YL3WOB2BF22HJWhTqIK/J8A6owFyIw9M4BgTla3PD2nhk1C2O58e4OoessQ1zRb
         TJQw==
X-Forwarded-Encrypted: i=1; AJvYcCWep0acKgr4Uh1fserudcL/Tssq5ib6UZblS/9eyzi12JPwAc3gtrUR1ynZb0GlInpQFh57Scx+vEqt@vger.kernel.org
X-Gm-Message-State: AOJu0YxEVzxH67+wC3gU/5sAJBTENzsSD30b/HUCWF790dayTdxX7l9u
	votkTwjeiodm32l+L03GaBhxG7h/OZd+DW7UjbqydT+NdezMimUTLpYU
X-Gm-Gg: AZuq6aLhfmSsC/7sSk7x+Kqa/aqw6Gh64Pe/Jz6aSZOawm2kcMWouhbD1BPkUCuvnPe
	0xWMlCGA16qX1mIRG+7oNMy5sKcJ/OeHaPES3fwr36R+pocyjmZOOFInOfLBm1Cr4SobYW1ccN5
	8uF/AGyyX3pGJNdF+10kCyAxyR+gJ8Mt7KN6jPHomqS6SWT19BsklpLdlNhmbg4qYoHYIoefU97
	WKvZrRbwovhv8V16anqoKZkamk6sdNOC8XeImSsmyoC7ADi0UwmMJwSvGoUSJbqFO7NoRbdeABl
	2aCjGQX9ts6547BgQUZMNMtnphorf06d9+o4cCN1snU+zoixm0J8JzRyPvWWeaPFlp5w01J6+mG
	5xHU2/HVsjZ02PZHSrA1USnQvswOYAmOFM9/95ruXEQcULiwPAzZclYjXZ7K/nuSwYjN+ym03Pe
	31UDK2L0T/Z9bfuxLKh/76Eh1NBCX2rbqkCNKUQeNmPGMozI0P2z+Kb2Uel1ay/y5R2xdTTtU=
X-Received: by 2002:a05:6214:485:b0:892:6ec3:41d2 with SMTP id 6a1803df08f44-894cc93d523mr120506026d6.54.1769665679737;
        Wed, 28 Jan 2026 21:47:59 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36dd1cfsm30903216d6.25.2026.01.28.21.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 21:47:59 -0800 (PST)
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
Subject: [PATCH v5 8/8] ARM: dts: ti: omap: samsung-espresso10: Add initial support for Galaxy Tab 2 10.1
Date: Thu, 29 Jan 2026 00:47:09 -0500
Message-ID: <20260129054709.3878-9-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129054709.3878-1-bavishimithil@gmail.com>
References: <20260129054709.3878-1-bavishimithil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a device tree for the 10 inch variants (P5100, P5110, P5113)

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 arch/arm/boot/dts/ti/omap/Makefile            |   1 +
 .../dts/ti/omap/omap4-samsung-espresso10.dts  | 104 ++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index d24f13efd..140ac39b3 100644
--- a/arch/arm/boot/dts/ti/omap/Makefile
+++ b/arch/arm/boot/dts/ti/omap/Makefile
@@ -81,6 +81,7 @@ dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-var-dvk-om44.dtb \
 	omap4-var-stk-om44.dtb \
 	omap4-samsung-espresso7.dtb \
+	omap4-samsung-espresso10.dtb \
 	omap4-xyboard-mz609.dtb \
 	omap4-xyboard-mz617.dtb
 dtb-$(CONFIG_SOC_AM33XX) += \
diff --git a/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
new file mode 100644
index 000000000..5c00d67ac
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/dts-v1/;
+
+#include "omap4-samsung-espresso-common.dtsi"
+#include <dt-bindings/power/summit,smb347-charger.h>
+/ {
+	model = "Samsung Galaxy Tab 2 (10 inch)";
+	compatible = "samsung,espresso10", "ti,omap4430", "ti,omap4";
+
+	i2c-gpio5 {
+		smb347: charger@6 {
+			compatible = "summit,smb347";
+			reg = <0x6>; // 0x0C >> 1
+			interrupt-parent = <&gpio2>;
+			interrupts = <0 IRQ_TYPE_EDGE_BOTH>;
+
+			summit,enable-usb-charging;
+			summit,enable-charge-control = <SMB3XX_CHG_ENABLE_SW>;
+			summit,chip-temperature-threshold-celsius = <120>;
+			summit,usb-current-limit-microamp = <1800000>;
+		};
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_pins>;
+		pwms = <&pwm10 0 1600 0>;
+		power-supply = <&reg_lcd>;
+		enable-gpios = <&gpio3 31 GPIO_ACTIVE_HIGH>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+	};
+
+	panel {
+		compatible = "samsung,ltn101al03", "panel-lvds";
+		power-supply = <&reg_lcd>;
+		width-mm = <223>;
+		height-mm = <125>;
+		data-mapping = "vesa-24";
+		backlight = <&backlight>;
+
+		panel-timing {
+			clock-frequency = <69818000>;
+
+			hback-porch = <64>;
+			hactive = <1280>;
+			hfront-porch = <16>;
+			hsync-len = <48>;
+
+			vback-porch = <11>;
+			vactive = <800>;
+			vfront-porch = <16>;
+			vsync-len = <3>;
+
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&bridge_out>;
+			};
+		};
+	};
+};
+
+&i2c3 {
+	touchscreen@20 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		interrupt-parent = <&gpio2>;
+		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_pins>;
+
+		//avdd-supply = <&reg_touch_ldo_en>;
+		vdd-supply = <&ldo6>;
+
+		syna,reset-delay-ms = <200>;
+		syna,startup-delay-ms = <200>;
+
+		touchscreen-size-x = <1280>;
+		touchscreen-size-y = <800>;
+
+		rmi4-f01@1 {
+			reg = <0x01>;
+			syna,nosleep-mode = <1>;
+		};
+
+		rmi4-f11@11 {
+			reg = <0x11>;
+			touchscreen-size-x = <1280>;
+			touchscreen-size-y = <800>;
+			syna,sensor-type = <1>;
+		};
+	};
+};
-- 
2.43.0

