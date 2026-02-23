Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8776025C818
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854610; cv=none; b=FnuPKKFA/N93Ud7vRyFn8KlTmC2TH05ImPkSWFYsEE81TMYZ2ln+1aYmFbTvq+f87gsHM9Rua+OtcS8D81zWdR/PRmPv+757/yEkfCepNgdgFr0qKICKvl/42Ad1gQf4Fe/vbpay9BY95rBuuyPMAgXg/9Y6ObuYM5TA4e0rso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854610; c=relaxed/simple;
	bh=AUhhKwGaM9grtdftiWmb9K3MniiTndfrY7S51xLJzEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbCO5GOvFYwl2w1qq/UHezpUAAg8dhJvuMBFZIR6j1bvZHxceruxeb8XLSLG91eWub7GGG5KaOdA4c9thW/09/DI5A4mktexhbdzCUvcRagt5+r2xb0YEKald5IionPGTXpG4V8RcH891kFc83ceMFPFT0zouSv0FbTYdZhS5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlnyAXTd; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlnyAXTd"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8947e17968eso48411466d6.0
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 05:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771854598; x=1772459398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meO53koivOwOs9Bd8q7AbA+V+PS952tTGxoKR0dH/Dg=;
        b=VlnyAXTdmgc6Cvw7p8ppNaeebRPezTDUbWPp9+cyGLRGJOrPHvb8P8heBx72JKP8/w
         qXw0Ulgbg2hynT81iLEmPnOCXJTDvxqLomTHng2OM1DZijrVxHZHcNFFpSDX4L1N1rIF
         9D2rcoE1UW1Mj1E5fxw6GZSs52ezDIfiFoC7JhG/JkmnEF+LSzWGCq0YleCBMijXzgHZ
         eutD2xFLAKZ/iHsNvq+XxLI1Ac+qIH2QarwogJ8DQ9IMsiSvkw2b8uZMMjekh/9L7Hag
         zpuUQ+MUSlOOEkcTu14XmsakBNZt0/MBtiVKvpBEurEvhZengTUB5M9KnV9p7RX+HzIg
         0JSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854598; x=1772459398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=meO53koivOwOs9Bd8q7AbA+V+PS952tTGxoKR0dH/Dg=;
        b=rphq5TYrUCC5PcYnVw5bCvM/EyTel/n6mkEYTPeqHVTwcBXpT02r8GVlihxbUHEwm6
         nlnPBd9klwIZS5jqUV/ZQu3MkOA7l5wUMWG0yaJiZm4FICk29A7osENg5Zplovghf1dn
         R/UQrF1hvoVMzj9weoXSQsRxmLdZ3HTddh5L/fXjLTDonITsA/1SowgwyRfCmyM0pZ8K
         gu8KAf89RN/GVH3hY2T1uFO1lAfqe9aPgjiNXyy4kk/2ndLoLVHk5W/XPuMUBo6XKRi3
         12OtmNmAq3m0jVBv5PP3cjzOi0efZ1KkQ6Jyatl93ywiQ1aq0sk+06SxzWwVXHIG/2oQ
         INfw==
X-Forwarded-Encrypted: i=1; AJvYcCUfr6xb/pjJ/C/JVi5g4fR8lgZm2UowisT5hXYRh0nABm0rJU+jVUlDj/gUh82vIiqXk4N+8AEeEzx2@vger.kernel.org
X-Gm-Message-State: AOJu0YxVIKdIogKaBGQStUbbdCX8/2YZ7i2IE08FOALl2xON0LNgQDG4
	R4THGgu9hGVIuXqCc8feMHTJeksiY9wV2NXigsBOK8cohS1VUFdFhHkz
X-Gm-Gg: ATEYQzyh91lPhRtyrBcQsm3EhTeR0Dh93GNe3KAg7t1AwpTAgpDaa3wydkj8qPbwPJg
	d6aZnzWvqU4sem08PUWVDJWoAmk/uyrJj0uLsRv2Lhmjs3uWJsns1sAUoe8o4WLcH+g5ndW/FfS
	/2SW/qjUjYCycpTL7K0xR6VP/d/MtwEazqz90BbCg8BhKBNzm3zwXZU9VITtBymdTWG2eJgP6PN
	gHFQEH89ziqjbntLRxu9pbDUFI0scuw8e+YW2+hxTwMQ9msGwWxL/zjU7mbVtAJnt3cHhMWkPBB
	ylCGEHKGBtL2L9+M8fev5eUEylV7S1p5pCx/Uhd9H9VTlv/BVlNK1aMswweUQoBB1mPBDiNIqM2
	OTfEzuIH9qwlH1wl9qJxRjx/vi6UrneaOXQilbwGqUjDTm8etwNrcaHKWBRYD54XXMEYzKDMW05
	Bbx3LH5N4ECziR1WO4MG/wqgV70//Sg025ghDC0v0pvey1LSZW1wA8Im3gSelvoaGxpoAPx9m35
	yLViPCg6ds=
X-Received: by 2002:a05:6214:301b:b0:7e9:2697:dc63 with SMTP id 6a1803df08f44-89979f31ce8mr109290576d6.48.1771854598356;
        Mon, 23 Feb 2026 05:49:58 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm67954716d6.36.2026.02.23.05.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:49:58 -0800 (PST)
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
Subject: [PATCH v8 8/8] ARM: dts: ti: omap: samsung-espresso10: Add initial support for Galaxy Tab 2 10.1
Date: Mon, 23 Feb 2026 08:49:40 -0500
Message-ID: <20260223134941.427-9-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223134941.427-1-bavishimithil@gmail.com>
References: <20260223134941.427-1-bavishimithil@gmail.com>
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

